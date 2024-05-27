Return-Path: <linux-kernel+bounces-190511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 343248CFF59
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC2F6285249
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFED015DBB7;
	Mon, 27 May 2024 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fk2ev0Zi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A24815DBB5
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 11:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810564; cv=none; b=kr9ZPZ87fD2ics4Ccxo0eIM5k39rW1OcAhvIMzxtcljfG1sYCnR3MpfQGp2BgtfF6hUhJjW4XR5azEeRdn8tpkgAvyV5dOso5HzEqZxZa/RWPsxKB6Bx+tEqHr25tercSrqTtYw6iMCBclgTr0LHWKfYtrW2oX5xt7fVMUaJErM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810564; c=relaxed/simple;
	bh=shk951gmo+1ms+DYYiAUmzVJFmHGWUHqdaCj4KTjfOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F0+AvpGDON/IDnrolshkBPWNkZpgJF8opciTyWQgHMYfAndefYm+m8+PD85o1bsgeQBzndXL/fv5uk/wNusLUIjdzCNTahCQJb9Nm/nmi70aTo0v5fb109QzKEjPeJn1LCq9PJAojTbum0D8gyx7l4Of6dhk4EGz17viiPSL48k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fk2ev0Zi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716810561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rGCsIcJ2HG9F3cNxibyATF7iD4Qq4gsNs6+gmI03mi0=;
	b=fk2ev0ZiQaETjRDS9E1+vZvbxjNGWj97k9ejV/s6C19zy1pLojcB9EJjtB0TWBisIQaCOj
	se6YNQ/F1TwKVW6QFxWrmLVwbqHUOaZ+XzRrHGKfSlaySpR1Af2UkuWctnnXcYN9CbnFGS
	jYP6BztzuRs6zefh+itd2qm3l5oFtLU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-N3vcT01FNCK_lmlJnCD-lg-1; Mon, 27 May 2024 07:49:19 -0400
X-MC-Unique: N3vcT01FNCK_lmlJnCD-lg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a62684ef298so157064866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 04:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716810558; x=1717415358;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rGCsIcJ2HG9F3cNxibyATF7iD4Qq4gsNs6+gmI03mi0=;
        b=c03pUyPqwhy9XBoTpZOCKyV+hgfIfc7l+2NEXMW8rsuX0XEH1MIqLgNXotfvEcw0BK
         HmM5SFv7UMEkf9VKIb/ID7TwTYQQq5WhEz+FSOtkHLh/rHwbrvjb182R9m8yZXcBvF82
         ayt2Uv9mBkGGRFSyPvm8SCFQWTHdRyiO8dICKNTM4b2pl8psSaenx16xxgK6s39Qmba+
         gVzo6Xwl5IVBI8VNJSu9nJGWY+DcpuQB1dFELNxGQ/7vNYMZ5xfgL9b0ByyjzN89avyj
         wtS68GLHukCFE58XcAVCysrGPO8EuHo/U8y4sDCVIb16uubTyGTif6qoefqs/Xlzs1nq
         emag==
X-Forwarded-Encrypted: i=1; AJvYcCXBOigGPv3Z6z8rr+5qnjiNOgFbZlDxjruZtTS7Ay9hpPYVKHCt3sgSYhWwVnQMj6lUqHvS7BSVrzlp1o+fsoEwU2QFvI7inFLrf7yW
X-Gm-Message-State: AOJu0YxFYov7yCpuCSBoFgTbstl4/RpZiydRD4w5z/cYfy3ptTWONWZk
	/R5b35PhuUFsukOKVglKwExCo+cfJEapAERBykZmHPRIVqYX/kARE/E88V3C23WJdYaqtKA0s1l
	7bkOf7P69Tv7uYwBClsgGGo2j1CR71U2Xyxa1nMlTWb5wqRWuCB2lxNF/8tBCstZTEYnEFdoT
X-Received: by 2002:a17:907:7212:b0:a62:fc9d:6fec with SMTP id a640c23a62f3a-a62fc9d8765mr150222066b.34.1716810558266;
        Mon, 27 May 2024 04:49:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5yX7OFlzdqsfP0BWU+yULSArzx/o5mWjMhXD/cpaJ4F+sdO0r+SwZXlVPjuKHYi+4qDCqjg==
X-Received: by 2002:a17:907:7212:b0:a62:fc9d:6fec with SMTP id a640c23a62f3a-a62fc9d8765mr150220866b.34.1716810557912;
        Mon, 27 May 2024 04:49:17 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc4ff07sm483604966b.135.2024.05.27.04.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 04:49:17 -0700 (PDT)
Message-ID: <368d0206-9436-4467-b57f-6ed5159e96c9@redhat.com>
Date: Mon, 27 May 2024 13:49:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mfd: intel_soc_pmic_crc: Use PWM_LOOKUP_WITH_MODULE()
 for the PWM lookup
To: Andy Shevchenko <andy@kernel.org>
Cc: Jani Nikula <jani.nikula@intel.com>, linux-kernel@vger.kernel.org
References: <20240527114743.326482-1-hdegoede@redhat.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240527114743.326482-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Ugh I send this to the wrong email address for Lee, so I'm going to resend it
with the right address, sorry about the spam.

Regards,

Hans


On 5/27/24 1:47 PM, Hans de Goede wrote:
> The primary use of the CRC PMIC's PWM is for LCD panel backlight
> control by the i915 driver.
> 
> Due to its complexity the probe() function of the i915 driver does not
> support -EPROBE_DEFER handling. So far the pwm-crc driver must be built
> into the kernel to ensure that the pwm_get() done by the i915 driver
> succeeds at once (rather then returning -EPROBE_DEFER).
> 
> But the PWM core can load the module from pwm_get() if a module-name is
> provided in the pwm_lookup associated with the consumer device.
> 
> Switch to using PWM_LOOKUP_WITH_MODULE() for the lookup added for
> the Intel integrated GPU, so that the PWM core can load the module from
> pwm_get() as needed allowing the pwm-crc driver to be safely built as
> module.
> 
> This has been successfully tested on an Asus T100TAM with pwm-crc
> build as a module.
> 
> Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/11081
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - Some small commit message tweaks
> - Add Andy's Reviewed-by
> ---
>  drivers/mfd/intel_soc_pmic_crc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
> index 581f81cbaa24..876d017f74fe 100644
> --- a/drivers/mfd/intel_soc_pmic_crc.c
> +++ b/drivers/mfd/intel_soc_pmic_crc.c
> @@ -137,7 +137,9 @@ static const struct regmap_irq_chip crystal_cove_irq_chip = {
>  
>  /* PWM consumed by the Intel GFX */
>  static struct pwm_lookup crc_pwm_lookup[] = {
> -	PWM_LOOKUP("crystal_cove_pwm", 0, "0000:00:02.0", "pwm_pmic_backlight", 0, PWM_POLARITY_NORMAL),
> +	PWM_LOOKUP_WITH_MODULE("crystal_cove_pwm", 0, "0000:00:02.0",
> +			       "pwm_pmic_backlight", 0, PWM_POLARITY_NORMAL,
> +			       "pwm-crc"),
>  };
>  
>  struct crystal_cove_config {


