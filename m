Return-Path: <linux-kernel+bounces-249404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7DA92EB44
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E129D1F2286C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C558916B732;
	Thu, 11 Jul 2024 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7Z73Af1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A070154BE8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720710373; cv=none; b=EH2BLoQqNal+SwjXL5XCCrca0aynNCzbdfarHppaNIRXrzbP+LHK+lrN6hIRXlt9wMarVz7HjkOzrmjhqzNAUT+Eujt0SpQ5QAmaQCveuAXHzSHBP6y/DwVqDmj+GKieZC7zutfAC58jlely1KL78Ppz6a+O36OzHzp+624RXBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720710373; c=relaxed/simple;
	bh=xuSHiaH4k17V7ocXClO5+/mDrYAkB9E1+5U7c7Vffrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PJEfg7QamUQYKhlNyX8vt2F7qfB1Pxm5F9JqAKSVtQGGq04bOCxw+U2l5KC8OHo2BP+M9nYpvl91qrP+7WZvH0zBJLFLrg3+rCfRL60+MaAyZLvVqpIZzQK4IZu27yHsgh1p/dbbl1RWpGbZBMe+IuKk90ARP12+3Aja/3Zzfcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y7Z73Af1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720710370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dMWX75v/Q0xYYwgu78z3z70LpPrh+hTEiyyb8o7LpEM=;
	b=Y7Z73Af1OT9PnCf8lvCkXNq7OPBnpUMPx42MBf25rxlNqPijWYsaWkwyGb45itfcw2jRgE
	xZIClEhHo1TCfnv+PvXU2AmWZ1u8fzYgKjT8hBquuSnsV3oisb1Aqya74cMA86MeVpwte5
	7qyQuvVyKmDz31LPXRwPH2pY8EL2DLw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-IufFyhjJP3iHaScG3ZZrmA-1; Thu, 11 Jul 2024 11:06:08 -0400
X-MC-Unique: IufFyhjJP3iHaScG3ZZrmA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a77c589d819so101550866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720710367; x=1721315167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMWX75v/Q0xYYwgu78z3z70LpPrh+hTEiyyb8o7LpEM=;
        b=VcXNQFaJujXHt9zxt2Ghs9PWU9EHsNTza5xP1gprGQcPc8F4PMeuqASCb1GsPLajhF
         lTahzGkfRhrbt0eMu1mSVrUNAZoz3mOdJEt9V0ZdZ0g+KHNnnSMa9yEl40BZ/O5zaV6Y
         B0yaYDzJWnfudQsS2LY61DMHw8LOgvMBLIbxgdiLdECmW5X9Lfh1/cgQJd+y+lZt0qJh
         VSXE0s5t5odiT6TIfXfQnJnPjojxMiddtfdX0jzGjGmStT8jicV4hrEgzLdRssYV4H6w
         8IQIyhsMggOjn6lZqXu5uIevnVfJiogbDNRIuEO1KKItFdnRExeCFmcMpCVOdXL0gqVt
         ZXgg==
X-Forwarded-Encrypted: i=1; AJvYcCXeU0sKanvZyaX+JCeI8xdYRpCuaJYPDL4R7cOGni8Bmj2xu3gWQ+n/fCSEb/mxZOW3AFedQbQWQcqvRTFgFMRk+jbrcxkQrMMVOxAD
X-Gm-Message-State: AOJu0YyF7a2ZxlCeGUUKiZuQU5tOuyZ4ojc+ZnClqTk+yyJ69LU+OYb/
	b+77lUtacbgJ3l0Konv7N8pw50Q8cQ8b8QA1aUwhtPR5vdCYa72w2rL45YgoVqga+S+EybPdPqT
	v7JNkfbpZgEUfkYABmTaTw4Q3EmzdFXlOHFWYQSenYR+Cf1afldh7y0aI2UyM2A==
X-Received: by 2002:a17:906:dfc3:b0:a75:360a:6cb0 with SMTP id a640c23a62f3a-a780b6b3644mr548407566b.29.1720710366945;
        Thu, 11 Jul 2024 08:06:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+K2BmfO1W0KIUpowuHPM/JP9GFkXo7DqGMyX4VEtKhWUnKogLVgLwi48nSPliOcnf8KOy1g==
X-Received: by 2002:a17:906:dfc3:b0:a75:360a:6cb0 with SMTP id a640c23a62f3a-a780b6b3644mr548406066b.29.1720710366527;
        Thu, 11 Jul 2024 08:06:06 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a72fce7sm262806266b.92.2024.07.11.08.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 08:06:05 -0700 (PDT)
Message-ID: <76655490-84c5-42df-b473-9a9a80054500@redhat.com>
Date: Thu, 11 Jul 2024 17:06:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform: arm64: EC_ACER_ASPIRE1 should depend on
 ARCH_QCOM
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Nikita Travkin <nikita@trvn.ru>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <80e17dffa8f4c1d3fdedd4d82df3a722aa4044ff.1720707932.git.geert+renesas@glider.be>
 <f5f38709c01d369ed9e375ceb2a9a12986457a1a.1720707932.git.geert+renesas@glider.be>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <f5f38709c01d369ed9e375ceb2a9a12986457a1a.1720707932.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geert,

On 7/11/24 4:30 PM, Geert Uytterhoeven wrote:
> The Acer Aspire 1 Embedded Controller is only present on the Qualcomm
> Snapdragon-based Acer Aspire 1 laptop.  Hence add a dependency on
> ARCH_QCOM, to prevent asking the user about this driver when configuring
> a kernel without Qualcomm SoC support.
> 
> Fixes: 2b3efb7c515111ea ("platform: arm64: Add Acer Aspire 1 embedded controller driver")

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Not sure if this warrants a fixes tag though, anyways I'll leave that up
to Ilpo when he applies this.

Regards,

Hans


> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/platform/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/arm64/Kconfig b/drivers/platform/arm64/Kconfig
> index 8c103b3150d1d0a6..058a4baa216a83b8 100644
> --- a/drivers/platform/arm64/Kconfig
> +++ b/drivers/platform/arm64/Kconfig
> @@ -18,6 +18,7 @@ if ARM64_PLATFORM_DEVICES
>  
>  config EC_ACER_ASPIRE1
>  	tristate "Acer Aspire 1 Embedded Controller driver"
> +	depends on ARCH_QCOM || COMPILE_TEST
>  	depends on I2C
>  	depends on DRM
>  	depends on POWER_SUPPLY


