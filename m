Return-Path: <linux-kernel+bounces-287319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC16952657
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 01:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFFEC1F243D2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD7D14B97E;
	Wed, 14 Aug 2024 23:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U7qAc2E3"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C293914B963
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 23:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723679602; cv=none; b=Vfyrsu4pXNQz/KE8WxlnA1Luh5AIDPTKH3k/E2TjvSk2aloy87XOm848EFIwAe3NX8sFhY95146atPjQEoMksuFsjnykOzKKqJ2eCXF6dGQXCmvegWddn6tFfrvyc/JgMir8DhooEKIAU1CVGTZXBoEq2u5cyVt4lpOgC1hjfTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723679602; c=relaxed/simple;
	bh=oWcr9yvSj89hwLY1f4OI1N0YsmHkbUrc/8uMmyWpRAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YxunHPiNwFUX2+c5l0nha7oOikwykfq+h7sPeILGgfWe5c9lg2V6YucxfeisQHJNjn9X5tDHeliPjpyQ4JhCQdQrYG8dIV+Rxo9taRH28XW559+CGMAcPSnOcvBjVIx7hhYFzCb/PMGBJ3Ssy6QViQpH7qlunoFIBzKoe7xAzdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U7qAc2E3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42808071810so2083845e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723679599; x=1724284399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/EGN+b4/f+L1J4PwtsVMenONq33iywKxH0fU8rJy0js=;
        b=U7qAc2E3dcQ70B+h3jUnQhy+qHCqU2llTkXF2+Cg+HoiJgT30sc054eniEPWtMziqX
         8Sw6SIjj5bGVNlOB2lf2Cto67EUaJWF2/2xpx9C9loQ0WlUt8iuXJLoE9Qy3897Oe2pK
         gnA01EvT07PZqYWbnthAlgJ8zxmQ+r7FvfncUIbwFf9uPGLyh7E7KaWN4yRHfHMlP+m9
         yS6BqqhQ97MDupXals/rhRCHN/RQIshgfjerFwxiXtxVpqUsfbq0PaLdX2OUjhJI09dG
         GoC1sLTQTkOO/nJbQ8XhDdryqD+rcwySYdBuxbuEC046yHX1fy0FyPAY180dwRMupu9P
         p+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723679599; x=1724284399;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/EGN+b4/f+L1J4PwtsVMenONq33iywKxH0fU8rJy0js=;
        b=VyiPXWUQ0/IOrhvbdI4mkcA27XF708uxVOthfe2cgrwyY+2SBveJR5CQMfAUAr4xYf
         7E+NCqOI9pu6TLPTY4ix3rEQRvPYJXYI/8Ioo3rntqeKUH5FBIlkd5pBwZK12Du/U/S5
         VIrEne8Dem3to29SBTsawPsr7APXvLElNYwcvLvcSDvTkIIBDB5b+L5SgQ7UB1IVGk2Z
         WviwIprhf4CjZOCaWe3CowkDcziFYgPO34xNX88WqEea9Kj3SzL4UvF6yChJ/Yr2ARo+
         CVQNjZY0AJS2MioKTpKvC1FFmCxK12tgMr60EmvGiedYAMsR9jnGD0ZkIjmxepIvK3ib
         K6GQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFIrAQGRtryWrp3RBAeb8rhTADLTDc3KDKIZPniFGOqZk34K0Ox34BiLqjgM7RWVKxDYP1iUx2c9x4A6f/VX6vGz7r7UgRfeXr1GDo
X-Gm-Message-State: AOJu0YzbH4pg94bP2pPAPVLJzV1qwrkXGmr1wlh3PuNqalvFRQLahjI6
	QSAlmvXeQ/O5edtANf7Ao9af+GMyTedMaAlpjIH5/hMUHXVAoKOJj2jj3m+WZ/E=
X-Google-Smtp-Source: AGHT+IHnR9FXVZqaGbdhBGxRE1L18EtaOWa7lw8oftSVGi5gyStVTja4iv7pJGXAgPHIo7eMHDjlDQ==
X-Received: by 2002:a05:600c:138f:b0:426:6eac:8314 with SMTP id 5b1f17b1804b1-429dd22f4c1mr30463375e9.1.1723679598842;
        Wed, 14 Aug 2024 16:53:18 -0700 (PDT)
Received: from [192.168.0.25] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429e7e1c46fsm3963855e9.39.2024.08.14.16.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 16:53:18 -0700 (PDT)
Message-ID: <8c504081-b0e4-4a64-9e21-e7d040a0aa6c@linaro.org>
Date: Thu, 15 Aug 2024 00:53:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] media: qcom: camss: csid: Move common code into
 csid core
To: Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20240812144131.369378-1-quic_depengs@quicinc.com>
 <20240812144131.369378-9-quic_depengs@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240812144131.369378-9-quic_depengs@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/08/2024 15:41, Depeng Shao wrote:
> The get hw version and src pad code functions can be common code in csid
> core file, then the csid driver of different hw version can reuse them,
> rather than adding duplicate code in csid driver for each version.
> 
> Suggested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Depeng Shao <quic_depengs@quicinc.com>
> ---
>   .../platform/qcom/camss/camss-csid-4-1.c      | 19 -----
>   .../platform/qcom/camss/camss-csid-4-7.c      | 42 ----------
>   .../platform/qcom/camss/camss-csid-gen2.c     | 60 ---------------
>   .../media/platform/qcom/camss/camss-csid.c    | 77 +++++++++++++++++++
>   .../media/platform/qcom/camss/camss-csid.h    | 21 +++++
>   5 files changed, 98 insertions(+), 121 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csid-4-1.c b/drivers/media/platform/qcom/camss/camss-csid-4-1.c
> index c95861420502..6998e1c52895 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid-4-1.c
> +++ b/drivers/media/platform/qcom/camss/camss-csid-4-1.c
> @@ -17,7 +17,6 @@
>   #include "camss-csid-gen1.h"
>   #include "camss.h"
>   
> -#define CAMSS_CSID_HW_VERSION		0x0
>   #define CAMSS_CSID_CORE_CTRL_0		0x004
>   #define CAMSS_CSID_CORE_CTRL_1		0x008
>   #define CAMSS_CSID_RST_CMD		0x00c
> @@ -139,15 +138,6 @@ static int csid_configure_testgen_pattern(struct csid_device *csid, s32 val)
>   	return 0;
>   }
>   
> -static u32 csid_hw_version(struct csid_device *csid)
> -{
> -	u32 hw_version = readl_relaxed(csid->base + CAMSS_CSID_HW_VERSION);
> -
> -	dev_dbg(csid->camss->dev, "CSID HW Version = 0x%08x\n", hw_version);
> -
> -	return hw_version;
> -}
>   
> -static u32 csid_hw_version(struct csid_device *csid)
> -{
> -	u32 hw_version = readl_relaxed(csid->base + CAMSS_CSID_HW_VERSION);
> -
> -	dev_dbg(csid->camss->dev, "CSID HW Version = 0x%08x\n", hw_version);
> -
> -	return hw_version;
> -}

Is it also the case with csid-4-1 and csid-47 that the HW version is in 
the format x.x.x - because you're removing this printout which just 
prints the register in favour of a later function that decodes that 
register into three parts.

Suggest having a csid_hw_version_gen1() for these two and a 
csid_hw_version_gen2() which does the x.x.x print instead.

=> camss-csid-4-1.c and camss-csid-4-7.c will have hw_version = 
csid_hw_version_gen1()

=> camss-csid-gen2, camss-csid-790 will have hw_version = hw_version_gen2()

---
bod

