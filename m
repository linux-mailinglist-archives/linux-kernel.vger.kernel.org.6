Return-Path: <linux-kernel+bounces-315747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE7096C67B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19D0A1F22214
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983251E2010;
	Wed,  4 Sep 2024 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+wB1e69"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FA21E200E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 18:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725474689; cv=none; b=H/HZvNMm6LC9pETfoQunR98mQXWkvLeTeNoaNaA9eegCyLZBSCh69oFGi1ldI5cczMTkh2vqrC7MBDceIUovmGu5b/ivdqBlvAn+mktFd5Eh3jyNbZ6vwx8epNCN5+uGGi3I5NlWdDoPp2qVILvE+a/cHgFSOddbcLm1xxZGRYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725474689; c=relaxed/simple;
	bh=dCFHjYy2rxPVoOVF6xozo8cBeg+hYhHg8U+lT0eESAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PdKr9CfJEzNWwc29oCOuyvaNGbmbLNXL/Y/fJ7yqkrFAkjgqQiLFlP9JUlWqF/9ggzNDAK9TVKQRcwufT040tuqSTaMPFFoZ1eBj+fimbtIcrR+/QQzuEzw0wSU2Xb8rVo0i2homemy8zKlYLZYVfo5UVeO7Lbzakavt6rTNa5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+wB1e69; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725474686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aRSp1v5PZIdxAQeHR9DcZAxUHCkfQs5kyuYnxD2c5HI=;
	b=A+wB1e69iJ2QnZW9YQoemqTV7BMvcROIS1zrTRSC6IJhVZ9SNm1Cj0a9uCB8TXLbvH+Yye
	IDEGlkCP1fY+VXCBn0whYoWZuJpiWDROM0H28mm8oO9wzWPEL7v+rwSY2hwerCg0oLJNr0
	i1d4ksV1vUh8aWAXCUOm3jTx4WmqHvk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-ZiLfV0YzPSWvRbx4RoRrTA-1; Wed, 04 Sep 2024 14:31:25 -0400
X-MC-Unique: ZiLfV0YzPSWvRbx4RoRrTA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a8a1b72ddfaso192253566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 11:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725474684; x=1726079484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aRSp1v5PZIdxAQeHR9DcZAxUHCkfQs5kyuYnxD2c5HI=;
        b=O1+QI3uIYVN4p2jJebtr16digWmh1ajsfnxIbfu8FZawL2Yqt7MLxKzlw7EoeHSZxF
         xF8uHwVG556O1w3PbHT1efJJDLPkoLMRM1lZZPtXhjfxrMMgy9co6iXBQDgpwk5kF6HO
         EctIjLKHOl8+W94jpVs4SeTX4EacEV+byXcHcIofsydCTOIogjMzh/GulBdRLtlRqJAk
         0TfrriPcpSHDv/UBwFPcmuOVpQrTJHuSuNLskI1gcSGx4Jrsaxox0cjCz+dEo/05s1iD
         nSUXFxxzrqpDRGH1UoFKLi3OuUQTmgqTS/aK2SkjzTs1yrEU9ipFTz758aW72LPMHXsX
         4gdg==
X-Forwarded-Encrypted: i=1; AJvYcCXmfnzbagjPgADs/to9UlyP4S7Zdy+MVY3q5Z2vB5jzD+XIsQlHOB8IsT+y5rqORmGqpFAYYIEQ7EIXKCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMxwFsD6aHFK+Mcz1eO3GUKZsbOOajwiz5Eyjoi2pUXhXG5+It
	FV/ROaCVhHWCNfDKy/ZyAeIQzNwQAq+aNN9E7v/UkSsiBjrVAdnWETqZ6sdNiY6U8ms7N4xfNCO
	V5b5IcFGggMuwPBvkUmFffVIq68lxmavcL2QliZYKuTt6HZinYH6SBpDGoHjkcg==
X-Received: by 2002:a17:907:7e84:b0:a86:8953:e1fe with SMTP id a640c23a62f3a-a89d8849241mr883947866b.47.1725474683910;
        Wed, 04 Sep 2024 11:31:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsikd3mhZk9gwltRUrA+sywi3kpqEM45M7eSD6hruJJ+6cnxhPclwmJluFYskGKkTOx/tLyQ==
X-Received: by 2002:a17:907:7e84:b0:a86:8953:e1fe with SMTP id a640c23a62f3a-a89d8849241mr883944966b.47.1725474683332;
        Wed, 04 Sep 2024 11:31:23 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a620455d1sm22325966b.67.2024.09.04.11.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 11:31:22 -0700 (PDT)
Message-ID: <05d4e489-c081-4edb-b203-88701b135b74@redhat.com>
Date: Wed, 4 Sep 2024 20:31:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Fix uninitialized symbol
To: Matthias Fetzer <kontakt@matthias-fetzer.de>, hmh@hmh.eng.br,
 ilpo.jarvinen@linux.intel.com, ibm-acpi-devel@lists.sourceforge.net,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20240903172756.19235-1-kontakt@matthias-fetzer.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240903172756.19235-1-kontakt@matthias-fetzer.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/3/24 7:27 PM, Matthias Fetzer wrote:
> When the TPACPI_FAN_WR_ACPI_FANW branch is taken s stays uninitialized
> and would be later used in a debug print.
> 
> Since the registers are always set to the same two static values inside the
> branch s is initialized to 0.
> 
> Signed-off-by: Matthias Fetzer <kontakt@matthias-fetzer.de>

Thank you.

I've applied this with the following tags added to the commit message:

Fixes: 57d0557dfa49 ("platform/x86: thinkpad_acpi: Add Thinkpad Edge E531 fan support")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/platform-driver-x86/f99e558d-c62a-41eb-93b3-cf00c016d907@stanley.mountain/

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
>  drivers/platform/x86/thinkpad_acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 8f7053920884..4c1b0553f872 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -8318,7 +8318,7 @@ static int fan_set_level_safe(int level)
>  
>  static int fan_set_enable(void)
>  {
> -	u8 s;
> +	u8 s = 0;
>  	int rc;
>  
>  	if (!fan_control_allowed)


