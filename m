Return-Path: <linux-kernel+bounces-249405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C59992EB49
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37B49B20D74
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9556B154BE8;
	Thu, 11 Jul 2024 15:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkprqM1u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282CC1E531
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720710386; cv=none; b=CKFHYPySPV1RYqZPXqYjwSyqinJbUXW7j5Mg9m1yoAIC80I5Dxzclhz6xL2YV+nbALs/5haRBszKgonJafyVLBLD3oxR8dPGVGDH02cl/9EkB+8bny/ngaCxt4BXsSzitSHiVLRvVBISeQ+WWViDo7I8qOAEB8gsuV9IjKDqbJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720710386; c=relaxed/simple;
	bh=+x1nbIbYsKxoL7/AoMYpgLIqjRukRey4qXiFTtWPe/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m90t4IHj6z53JuizALV/x/SDitLaRUnAXylBMzOYJas9jJU1uqSjfIhvyYvSUoC/BfNholJHdNbnQ29b0qOcFqOku0EzMERIUQ8/D7BZ/a0Py7SREI9iOTSoPYIyrY17II2mdMb/4E5YFomfCiDZ3t8ffGvvwf20wUX5r5I1ULQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TkprqM1u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720710384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8qX2wb+XVC+iw2iukk9txuf8i+mfSqaQlhye0IZiLVg=;
	b=TkprqM1uTBPTsLKWAv2P87A5anw0s8rQGb/wGsGX3J/Qqo7dH/oVUzn9bJSJ7vH13SyrMS
	WnY4GAG/zY/hOWN6mI0Wd2j7wUbDat8MlCE67/RMz6kQEfpFbe3bNdkppApCKuMW/3AlaC
	sAqFlAbScFY97Q76g344WYomQBUrMoc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-YgVxmJfrPOC71b6XQD8LfQ-1; Thu, 11 Jul 2024 11:06:22 -0400
X-MC-Unique: YgVxmJfrPOC71b6XQD8LfQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-57d5467c427so996940a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720710382; x=1721315182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8qX2wb+XVC+iw2iukk9txuf8i+mfSqaQlhye0IZiLVg=;
        b=NrsllPdR4L7ooDilbVW2P1tX8To/umt0PlLXSNUGwCXDw+G/3lOfp19FJGBdAGduhy
         MVPx8AtNHql6bZ6HkNbpPFQybci2KTYrGECWmEZl5AKDESU5cgUVyHScj1fHj7q/yuHd
         hD+8LkogejmZ2LU2JldN8+XjTUaTcdjYrPwGGU2waK9RqLVHu5UIAVXwRTPGYtrt2bUT
         n66gmv4888eYrAKJry6mThQPc5p1Y0/627jAhgbHfK1eTqBAyK507Rl6C2cqd+Bif10U
         DL1jA1Yb6q2rvjdAonS9c6x0sUH1m8NU8yWdVe5oksQE+8jq1gKhmOAHddKPsHDsiWtt
         QaDw==
X-Forwarded-Encrypted: i=1; AJvYcCXeVNblHyubu5vrjDB7p4n6EN5XAw8plCcBRIRj3UVz1Cg/+yA/76p/AsbzyHhaxFIod3CXMMRZUSb7v9cFc5vml68dM70vv0zi2zOM
X-Gm-Message-State: AOJu0YzCkbfTIbLep03ggmTex2hwZPjDlpHcqklUmffHDytjAL/bwCO3
	t0eYUdPZm+VferN5ene1806BP0ya+nSnhrAMOLkxXfjurdUUPMDbKtywR+6UmdAqvOXKfCH6oy9
	fI+9uYE9LGRLHdFajuMvTA/kGiS1nvJ+jqnkKFS1cA4E36qY4Wve+5qySCume+g==
X-Received: by 2002:a05:6402:1ecf:b0:586:12f6:c0fe with SMTP id 4fb4d7f45d1cf-594ba99755cmr6845259a12.5.1720710381779;
        Thu, 11 Jul 2024 08:06:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGjnmXjuKQh6NXSz/UGqhyY5531yE5F20gmjMjAM/PVO2+s0DMhSK40OmAIO8Dp0lQASZVZQ==
X-Received: by 2002:a05:6402:1ecf:b0:586:12f6:c0fe with SMTP id 4fb4d7f45d1cf-594ba99755cmr6845228a12.5.1720710381332;
        Thu, 11 Jul 2024 08:06:21 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bd459af1sm3561120a12.59.2024.07.11.08.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 08:06:20 -0700 (PDT)
Message-ID: <4ba78f41-e8b8-46cd-8bc5-d089971156c7@redhat.com>
Date: Thu, 11 Jul 2024 17:06:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform: arm64: EC_LENOVO_YOGA_C630 should depend on
 ARCH_QCOM
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <80e17dffa8f4c1d3fdedd4d82df3a722aa4044ff.1720707932.git.geert+renesas@glider.be>
 <0e4c9ffdc8a5caffcda2afb8d5480900f7adebf6.1720707932.git.geert+renesas@glider.be>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <0e4c9ffdc8a5caffcda2afb8d5480900f7adebf6.1720707932.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geert,

On 7/11/24 4:32 PM, Geert Uytterhoeven wrote:
> The Lenovo Yoga C630 Embedded Controller is only present on the Qualcomm
> Snapdragon-based Lenovo Yoga C630 laptop.  Hence add a dependency on
> ARCH_QCOM, to prevent asking the user about this driver when configuring
> a kernel without Qualcomm SoC support.
> 
> Fixes: 5e5f2f92cccc29f3 ("platform: arm64: add Lenovo Yoga C630 WOS EC driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Not sure if this warrants a fixes tag though, anyways I'll leave that up
to Ilpo when he applies this.

Regards,

Hans





> ---
>  drivers/platform/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/arm64/Kconfig b/drivers/platform/arm64/Kconfig
> index 058a4baa216a83b8..f7539e5419cf1616 100644
> --- a/drivers/platform/arm64/Kconfig
> +++ b/drivers/platform/arm64/Kconfig
> @@ -35,6 +35,7 @@ config EC_ACER_ASPIRE1
>  
>  config EC_LENOVO_YOGA_C630
>  	tristate "Lenovo Yoga C630 Embedded Controller driver"
> +	depends on ARCH_QCOM || COMPILE_TEST
>  	depends on I2C
>  	select AUXILIARY_BUS
>  	help


