Return-Path: <linux-kernel+bounces-324913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80488975286
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4721C26602
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B08186614;
	Wed, 11 Sep 2024 12:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVN54qWU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FB4187543
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057964; cv=none; b=pfKa7o5NJeibmHibGKHzOgk1JuLAuvLthdKlRt/ZKMxCfdZGagOIxJCMS3oJkh0fAJDobG5W7EhOequbLV2qjGtwI6gS9FQbkVB9sWlOCWo39FE4G8rCNQH7gPk9joT9Ykl5r7B/cDbOvQlHLAuHmw/SDm6rM+pyMVMkYJ0yr1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057964; c=relaxed/simple;
	bh=3E8UknEqSHZAcXniAwjf+6pj1naW+gTUBVB98txU7LQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SysHWZvRjpkoqxar1mbYA2ab4twUj8IuWyi21MA/ELFBKZQ9PSIsgSZtSOf9pu+4X+/PENE2VutllUsFBB/4Qno8tVV19xaUtZ4t37gv9ZHbbDoGKXvfdVbPjFBWcYFfYW+4pgh6UZIcPbTBgR1/WairggLopbcn13jN8N1LCZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BVN54qWU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726057961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OiQW+zBQm6vtaHF0u01yFenxpXbBAA2X9t1zS8CTGXU=;
	b=BVN54qWUoUyGAN5m/HOSzIC5H3q0g6lT3ss0adRvhMb4f1WSO/F5wIv8HRxirQzsJHeqkw
	oSh+WddrET0QEw0mJVq2cquHgmAEMfeI3Zeo/HPwKtsr7wr4Q/D4llS0LARzWqCJinMJGs
	TQL2uvA8inIBEAcHdmyHNIC4sL6xW3g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-VC6YTC1OMk6skY8Lrh2JoA-1; Wed, 11 Sep 2024 08:32:40 -0400
X-MC-Unique: VC6YTC1OMk6skY8Lrh2JoA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-374beb23f35so3171774f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 05:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726057958; x=1726662758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OiQW+zBQm6vtaHF0u01yFenxpXbBAA2X9t1zS8CTGXU=;
        b=chOJoJThwqF2b2DQLmiOaGtqWRhbojgEDZGkVmkV50hU1zWmOUl4VmrqX5LQbSlMzO
         lOxQniyQOxevfgbgm6NIz08RgQJhRKzO1A7sAKmg6yelMhRXS3WwdlTtOE3ByQ4wm2HY
         mDSZkSbS/31rDLEHG7280u5FnijTnQNx6GCxSyiWfGufFI7MkOtxJyRXJOFK+2PkhS/U
         pAraWQaWRB2aAGFsSXyM2AD7zTzn//as3NqaApMvPP1Mgv9ZoKmqgB1VT+JzWc2rcT8h
         3E3VtpFci6gj6kixXjPTJuHV/fPnUwqMvklT3qILVzq5H6iMnaBa07rQlGSlIGVnYYxi
         /K5w==
X-Gm-Message-State: AOJu0Yzc9wS/Qd9alI5bovUBqc7Xa5YUAv2PSTpWEmWyWkKoz8QUDp1k
	B3wPLv7P1bWBtxWV9Mg9t93CDBxUPkwDXyx8T94dvxm8pqiZvi4LQ8F65BPwGsygvZBxqdhLcD3
	lQ+AwPwL2UsaHelkaFCmjRKy7dT2Te0Z84T4Dl6+HxVoCXJRQP6sJmNs5hZ4dChMy6S3ErA==
X-Received: by 2002:a5d:6988:0:b0:374:bde7:d148 with SMTP id ffacd0b85a97d-37892685e63mr8999943f8f.1.1726057957840;
        Wed, 11 Sep 2024 05:32:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa5s1+ujpu4nHfNJIdFLp8Ue9eAk17qJD5Dkov2EW/zPFQXxOodKFyYZX8UF4a9t6DBStfjA==
X-Received: by 2002:a5d:6988:0:b0:374:bde7:d148 with SMTP id ffacd0b85a97d-37892685e63mr8999929f8f.1.1726057957308;
        Wed, 11 Sep 2024 05:32:37 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd5201dsm5419613a12.46.2024.09.11.05.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 05:32:36 -0700 (PDT)
Message-ID: <6ad5b0ee-d05f-4e8e-8946-cbeb350add8a@redhat.com>
Date: Wed, 11 Sep 2024 14:32:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: asus-wmi: don't fail if platform_profile
 already registered
To: "Luke D. Jones" <luke@ljones.dev>, platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
 corentin.chary@gmail.com
References: <20240910045443.678145-1-luke@ljones.dev>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240910045443.678145-1-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/10/24 6:54 AM, Luke D. Jones wrote:
> On some newer laptops ASUS laptops SPS support is advertised but not
> actually used, causing the AMD driver to register as a platform_profile
> handler.
> 
> If this happens then the asus_wmi driver would error with -EEXIST when
> trying to register its own handler leaving the user with a possibly
> unusable system. This is especially true for laptops with an MCU that emit
> a stream of HID packets, some of which can be misinterpreted as shutdown
> signals.
> 
> We can safely continue loading the driver instead of bombing out.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Thank you for your patch. I've applied this now, dropping the second
unnecessary chunk manually so there is no need to send out a new version.

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
>  drivers/platform/x86/asus-wmi.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index fbb3345cc65a..d53c4aff519f 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -3876,8 +3876,13 @@ static int platform_profile_setup(struct asus_wmi *asus)
>  		asus->platform_profile_handler.choices);
>  
>  	err = platform_profile_register(&asus->platform_profile_handler);
> -	if (err)
> +	if (err == -EEXIST) {
> +		pr_warn("%s, a platform_profile handler is already registered\n", __func__);
> +		return 0;
> +	} else if (err) {
> +		pr_err("%s, failed at platform_profile_register: %d\n", __func__, err);
>  		return err;
> +	}
>  
>  	asus->platform_profile_support = true;
>  	return 0;
> @@ -4752,7 +4757,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>  		goto fail_fan_boost_mode;
>  
>  	err = platform_profile_setup(asus);
> -	if (err)
> +	if (err && err != -EEXIST)
>  		goto fail_platform_profile_setup;
>  
>  	err = asus_wmi_sysfs_init(asus->platform_device);


