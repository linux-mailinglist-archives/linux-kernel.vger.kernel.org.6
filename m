Return-Path: <linux-kernel+bounces-400720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E501C9C1164
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979EF1F26A7B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA0D218940;
	Thu,  7 Nov 2024 21:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIeEUDts"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B552170C2
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731016540; cv=none; b=G8U/i1J6npH97AcokDggNs86blTthgq/C3sfRx/XfWhUKxi1/BZRp9R+32CJs1kZKhJTqwKMMBCHGXsWrjMYfoxX51qTO+mjVNBRftYZwPU5ihEqdekJe6uPDahdv7qkr5ShYAjIEeqbxU6M7KNvT6Lvhlj6mZa5dm0SQPwmm9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731016540; c=relaxed/simple;
	bh=nc9ucCfhR2wIZEpLkpxJr1fEetHhto7BrMg2FeuxNeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VtvSxiouYG3hWWlMefgOLk9Tue+IxPwReqlsRdqKOapMu8tmmRBPiCgWc3OdzSh9NvaS6R7Z6DqYLpAuwdBCTHPgA490FwaZK30Uoge/LcKQVZTRx2Di3QR5LvZOG/o4bXEjfPE6f8kMnoAdbahoBVl8c8JEmwP+3tdrh7UQ68E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CIeEUDts; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731016536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qug7OvgZTlqxoJAL+oiITmZ07W0vBoe+U4mALXwX0Nw=;
	b=CIeEUDtsp3tG7i5WBewOtqXvwewQcq2Ijadt7t7nAmXI8PYMcQBYxRp3DnPh7ZFAryO55m
	6a/H6feDv7hbKhzOznfMI8dewKJai3vWm8g5ZPS1sfzIv40uD6zi4mFDqsUxboqRWV1Ntl
	UYHsel+SKwlFAkCpYu+RHO/axW7GcO0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-61e4UAcPOk-nZLthVlsBKg-1; Thu, 07 Nov 2024 16:55:35 -0500
X-MC-Unique: 61e4UAcPOk-nZLthVlsBKg-1
X-Mimecast-MFC-AGG-ID: 61e4UAcPOk-nZLthVlsBKg
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d5016d21eso721710f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 13:55:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731016534; x=1731621334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qug7OvgZTlqxoJAL+oiITmZ07W0vBoe+U4mALXwX0Nw=;
        b=aUkvW/vlCwkxyff9ZHDn8TX6SVDK+eB+hvSXHUjoUeiNYQA3JR4GIB9QburOSQH1W3
         FZ5T9KDzCJRfLKZMQF6tJeGEfw/4PX1T31A7QVcrFMcfUfQCEM0yEHu5Zmc3Xpi9Yz/9
         WMGSH4WLZhDPIK8nlObePigw8ggVro0oTGm4tDe0vNG7dNiXqOtMD/g4Fvb+hAQ3ZY5U
         QhgmiujSnZL20GdhkXq0n9Nz0Zp+kic9mGcdLsVRYja8NKu6L71snU1rzQMYtbziA7JK
         hzm5b+PlEW6OWtJW6UBjkDvlWN9v64ra0SNr5vGtUT8adU1Y2f+CsxcEKPRTFCTYZR2P
         2R0g==
X-Gm-Message-State: AOJu0YzJ6Lg55rBsIfqpARF/Q841W0E7EDjIOQgU/jE2/0NX6JMY2sw5
	5ev8PU1yKMCcx87tS41FSmu6XDlJfs7MF6rEArmH7X0ymKAmbkDKRfI6ts8Z49pt/zJujWIr2FZ
	Xputo/YGo0pNGnmjA8MOyxGH220vPhRFBBdeDLKUhNlxxUr6yKsC7s5Qe6y479A==
X-Received: by 2002:a5d:584f:0:b0:37d:5436:49b with SMTP id ffacd0b85a97d-381f186ad10mr446442f8f.13.1731016534124;
        Thu, 07 Nov 2024 13:55:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqA6+IjO1vc84OA9xDTf/zCcjLkow+qcTKg8MpI3DEHWK4CeLkm1oELLXCx5s9qeUCMcnY+g==
X-Received: by 2002:a5d:584f:0:b0:37d:5436:49b with SMTP id ffacd0b85a97d-381f186ad10mr446435f8f.13.1731016533732;
        Thu, 07 Nov 2024 13:55:33 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03bb6a2fsm1290987a12.40.2024.11.07.13.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 13:55:32 -0800 (PST)
Message-ID: <32b477e7-27b7-4468-b506-2c565b2010e1@redhat.com>
Date: Thu, 7 Nov 2024 22:55:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] intel-hid: fix volume buttons on Thinkpad X12 Detachable
 Tablet Gen 1
To: Cole Stowell <cole@stowell.pro>, platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
 alexhung@gmail.com, Mary Strodl <mstrodl@csh.rit.edu>
References: <20241107205908.69279-1-cole@stowell.pro>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241107205908.69279-1-cole@stowell.pro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Thank you for the patch.

On 7-Nov-24 9:59 PM, Cole Stowell wrote:
> Volume buttons on Lenovo Thinkpad X12 Detachable Tablet Gen 1 did not
> send any input events when pressed. When loading intel-hid with the 5
> Button Array explicitly enabled, the buttons functioned normally.
> 
> Adds the X12 Detachable Tablet Gen 1 to the `button_array_table`.
> 
> However, the driver is unable to call INTEL_HID_DSM_BTNE_FN and prints
> the warning "failed to set button capability" when attempting to enable
> or disable the 5 Button Array. I'm not sure if this is normal,
> but the warning seems harmless.

Yes the warning should be harmless and adding more special handling
is not worth it IMHO.

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> Co-developed-by: Mary Strodl <mstrodl@csh.rit.edu>
> Signed-off-by: Mary Strodl <mstrodl@csh.rit.edu>
> Signed-off-by: Cole Stowell <cole@stowell.pro>
> ---
>  drivers/platform/x86/intel/hid.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
> index 445e7a59beb4..48ad75a56199 100644
> --- a/drivers/platform/x86/intel/hid.c
> +++ b/drivers/platform/x86/intel/hid.c
> @@ -118,6 +118,13 @@ static const s
> truct dmi_system_id button_array_table[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "HP Spectre x2 Detachable"),
>  		},
>  	},
> +	{
> +		.ident = "Lenovo ThinkPad X1 Tablet Gen 1",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_FAMILY, "ThinkPad X12 Detachable Gen 1"),
> +		},
> +	},
>  	{
>  		.ident = "Lenovo ThinkPad X1 Tablet Gen 2",
>  		.matches = {


