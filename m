Return-Path: <linux-kernel+bounces-190652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6354C8D00EF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94FA91C23A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC5915E5DD;
	Mon, 27 May 2024 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K8hjuvfR"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612321E522
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814847; cv=none; b=fRhjdhm7qkf7ABFf+4inftn4nV1/n36YhdsLj3hdZxC5LltF4w2qBoJzOTG/G2gMM6/9aqBkzMg2g3i4/6HMdMmaSxLtZNVkpV5A0/Yr0+a+mdeHTEalOC5RcpLB7R8fNYNax+jsjsvaIzAsby12rvUPs6NKBAkkSL3ITG3E/q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814847; c=relaxed/simple;
	bh=EUyCbnhS3BlHRRSjjBnZZZsociF0Jq1G5n0SD0UfcYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YO6i002HSuWquCFhcfuFN12oXjMqStmdDKUTq9DtltPe+B0+9QzlJ57mkWiSwNsMjyCABeUl4PNgzcByRNFxhNZ9EuLIQFC3pV8MyH9meNeyYdjbOEKD3rXpxCVdDXhDobrMtsL3BYFe5thh5M1ASihvgGOYVbFqEw3+GeweiaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K8hjuvfR; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5295e488248so3517341e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716814843; x=1717419643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MpJ6vCZMz7EOGVjorfIQKnCKCEyg0Yd4/DGxKW7l3C4=;
        b=K8hjuvfR6H1aFQH5cvVPt2IO9VGMjy54hau72GqCWJmIFzBZtvug0B4xR8theIMtz1
         QQcvUbTCrb0KdRlIsUJRkDhWT8jMgQG84ADwpULn996fclSlqzz/vq7FayyhS328xyYQ
         ViRGkHQspcjFeQDXMUaHKv/eYMxYVLl/ah9wDqO7jZjOgIymKvGYPIf1WmBtPst+uTOy
         Xhu+uRvJo9EAB+1GGWnDZ8TbGzFLIuGE+PvBqZ42Ja3sg+T03xH5lJq/yj0vjyLos6rZ
         JoN449shwVcau6VJ+L2L2JPyXJrtnqrxbqoQa82ZLxs3fbtOZT6d+35zCiqM8rQUDxCF
         s58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716814843; x=1717419643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MpJ6vCZMz7EOGVjorfIQKnCKCEyg0Yd4/DGxKW7l3C4=;
        b=d9RneUb8+rJVQyQ5bpkTShLyTNlx8SobSpznosJLKD+j4aJGaNeyZW3htLc9KxmvSJ
         bEDPnab8X5z+7S0L0Sfi84YnC7augx70ZsRGoiXcDXr7XkkWqqvDp9nth2xeMWfgnrV6
         vxWPvnQ1BnjngHcgjJRSvANs/kEe2y0qU8djL29MwP9Mo3Gvn1Kc+6uNuC02omPoLvea
         B9c/WUfTsZ+wbKmSAAI8E/0OaZqJWthB8yg+ySNHi/42iKBOTHOvMlay2kwAA8beMrJh
         JKdDERF4/lyUwuIOWHMExSlZH6GSBBShT5Ul/1SgEJqWC4Ws1PtmeO1Udrcs//5dgp0S
         x6mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJdyH7wMYnDgit+VE0KiarxI4vOVAgUlAKDlvwwv/W5GZVHG73jAaBz0gLP+mpXd3u+8C+y/lT8QkTpguchM76LPEd12FNkMJLfCWt
X-Gm-Message-State: AOJu0Yy+Qc7GsJcQIIes4/JUMvbFYXXCv6kcXMh2EIjXpNW1S23GRPIq
	NCUjsBFM2A6s/ZFwBVmGytX6nXVoLXtLPhc5N7Ccw7OEkBkInCLrk8oXe2zQ8WA=
X-Google-Smtp-Source: AGHT+IEDtPIGNSFITefCjH6Zw9Wwfz0YD1Jqj60Q7SNk+Nsx4qFaryKs3KQrEdvR2BRRRnu+5T3UAw==
X-Received: by 2002:a05:6512:1388:b0:51a:c8bb:fcf7 with SMTP id 2adb3069b0e04-5296410a55dmr7155320e87.3.1716814843603;
        Mon, 27 May 2024 06:00:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9? ([2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579deb8f406sm615511a12.34.2024.05.27.06.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 06:00:43 -0700 (PDT)
Message-ID: <fc3bfebb-78b7-428e-8da5-5221f4921faa@linaro.org>
Date: Mon, 27 May 2024 15:00:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
To: Jens Wiklander <jens.wiklander@linaro.org>, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Sumit Garg
 <sumit.garg@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bart Van Assche <bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>,
 Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Manuel Traut <manut@mecka.net>, Mikko Rapeli <mikko.rapeli@linaro.org>
References: <20240527121340.3931987-1-jens.wiklander@linaro.org>
 <20240527121340.3931987-5-jens.wiklander@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240527121340.3931987-5-jens.wiklander@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/27/24 14:13, Jens Wiklander wrote:
> Adds support in the OP-TEE drivers (both SMC and FF-A ABIs) to probe and
> use an RPMB device via the RPMB subsystem instead of passing the RPMB
> frames via tee-supplicant in user space. A fallback mechanism is kept to
> route RPMB frames via tee-supplicant if the RPMB subsystem isn't
> available.
> 
> The OP-TEE RPC ABI is extended to support iterating over all RPMB
> devices until one is found with the expected RPMB key already
> programmed.
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Tested-by: Manuel Traut <manut@mecka.net>
> ---
>  Documentation/ABI/testing/sysfs-class-tee |  15 ++
>  MAINTAINERS                               |   1 +
>  drivers/tee/optee/core.c                  |  96 +++++++++++-
>  drivers/tee/optee/device.c                |   7 +
>  drivers/tee/optee/ffa_abi.c               |  14 ++
>  drivers/tee/optee/optee_ffa.h             |   2 +
>  drivers/tee/optee/optee_private.h         |  26 +++-
>  drivers/tee/optee/optee_rpc_cmd.h         |  35 +++++
>  drivers/tee/optee/optee_smc.h             |   2 +
>  drivers/tee/optee/rpc.c                   | 177 ++++++++++++++++++++++
>  drivers/tee/optee/smc_abi.c               |  14 ++
>  11 files changed, 387 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-tee
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-tee b/Documentation/ABI/testing/sysfs-class-tee
> new file mode 100644
> index 000000000000..c9144d16003e
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-tee
> @@ -0,0 +1,15 @@
> +What:		/sys/class/tee/tee{,priv}X/rpmb_routing_model

Wouldn't /sys/class/tee/teeX/rpmb_routing_model be good enough?

Thanks,
-- 
Jerome

