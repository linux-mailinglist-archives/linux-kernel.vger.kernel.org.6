Return-Path: <linux-kernel+bounces-275942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F716948C43
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C798D1F21AC9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48771BDA9E;
	Tue,  6 Aug 2024 09:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXVzTkNX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF9A5464E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722937262; cv=none; b=b6HhdaNn8Yf6kKpm4En3yaq23KstGQMh8J+Xp5AXVUFrMzaRdLNqZjxYvfzviiRWzS2vc10/aCbSRSXv30eaYQDFW/67kz8NhjBNsDq26QSv8W7YQx2/Tczg2/KugbGwjoNdvIUex3Uv6TJD54HSnWsm8ZdQaIbBDzWLOCllwfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722937262; c=relaxed/simple;
	bh=aYqDvoRDf3JMHhB71lW27cCe/hn8Rs9fJHHNmSZv8NA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=McrfaUHSmInLf/drq+H52015wYZr6VNOjwz2Fr6g7QPLTPzuqAm9wL/WU4X/k/rG3xdiUmrUiaKeiFLT+REc46aDJiZjV+zz5F5b3xaqtbmTOv55yjF0GTYGpCjyXMVb9zsQKmBPDflKi2vMmNIp3F1Q0A5uQG0oFg0ecPPnofQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AXVzTkNX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722937258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4sH0fBYcEAsNCLPYwHilfAXVbxQ9T0LtTAmwUlVDpSk=;
	b=AXVzTkNXuP69qjvxMdXEfJOi96CiZLHuu9gm8J1S9pieLccvk+m1XSyDK25niv408971Pg
	R7jou7Zd09Qz2T/JMXsThMoQCa/FB8VU2Lj/VvSbOGdtatWXEa12MELJuR0gxrfaiVmdew
	7eTp/Fpj+bxIohPKOS5r6B7MCuoub0s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-Wmaicg5tMwW0_LYc97lrIA-1; Tue, 06 Aug 2024 05:40:56 -0400
X-MC-Unique: Wmaicg5tMwW0_LYc97lrIA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a77f0eca75bso49342766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 02:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722937255; x=1723542055;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4sH0fBYcEAsNCLPYwHilfAXVbxQ9T0LtTAmwUlVDpSk=;
        b=s6hbgvJ/NpT3V3R/eyps8bhO84BbHSdNlpwXcew021XrMoSApp8tD2BWSHKV7IRWdw
         Dzevl2xieXA8x6T0hRT9sFYxNlV45hMGDn59jjHImGBywN4wzkod6yeE27RrG16xy6Ue
         awpoBttEuPTH0LIfIfOdsKbqrQb2G0PmJDGjRE/XlMySSqE47UDjrP2UwWetJF0eNZQF
         HwU/s8cZ/iT0UzvkmAd1cRa3bqt+dtZ+wwEYMcb5NJ5MaIxblG0E6cJbTXaOTzUh+ybe
         PiENKYqFy9Zwbz656gTK1yIn6yhTvnK/eEAKgE7gKTruaqsfcvbv3Yg4/9+ZahylBMqX
         62MA==
X-Gm-Message-State: AOJu0Yw0sgzB45AcxtFC6v6xz4y/ydc3EDE4qUC7JNvFb3Ppr7hpW+oQ
	XIxrc9VKvFKdWhLblPUKQ++6WsKm+WVmNEACIpH2M/u7LjbKTNgGfdZ8Yv2ZM6YuQAqRd9u50a1
	g5i1KfH6NxvvozBuBPKSz1ig0drl8tCtMWKHQtp0DODuKdSYWkJ8XGqov52lWgA==
X-Received: by 2002:a17:906:7956:b0:a7d:48e3:4117 with SMTP id a640c23a62f3a-a7dc518febbmr1078836466b.68.1722937255608;
        Tue, 06 Aug 2024 02:40:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ4vqsfgihejS6Eyz1CA5H5YmIQyoyLuL/W83qs6hOkpfbll5bE6UOZ182BaMjIPOSgaczJw==
X-Received: by 2002:a17:906:7956:b0:a7d:48e3:4117 with SMTP id a640c23a62f3a-a7dc518febbmr1078834766b.68.1722937255187;
        Tue, 06 Aug 2024 02:40:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e83e93sm525913066b.166.2024.08.06.02.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 02:40:54 -0700 (PDT)
Message-ID: <53e1e46c-b75e-4f64-bd7d-c56cad1981e8@redhat.com>
Date: Tue, 6 Aug 2024 11:40:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86: asus-wmi: don't fail if platform_profile
 already registered
To: "Luke D. Jones" <luke@ljones.dev>, platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
 corentin.chary@gmail.com
References: <20240805235808.40944-1-luke@ljones.dev>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240805235808.40944-1-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Luke,

On 8/6/24 1:58 AM, Luke D. Jones wrote:
> On some newer laptops it appears that an AMD driver can register a
> platform_profile handler. If this happens then the asus_wmi driver would
> error with -EEXIST when trying to register its own handler leaving the
> user with a possibly unusable system - this is especially true for
> laptops with an MCU that emit a stream of HID packets, some of which can
> be misinterpreted as shutdown signals.
> 
> We can safely continue loading the driver instead of bombing out.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index cc5dc296fb2d..2fdfa84f7efb 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -3897,8 +3897,13 @@ static int platform_profile_setup(struct asus_wmi *asus)
>  		asus->platform_profile_handler.choices);
>  
>  	err = platform_profile_register(&asus->platform_profile_handler);
> -	if (err)
> +	if (err == -EEXIST) {
> +		pr_warn("A platform_profile handler is already registered, this may be a driver conflict.\n");
> +		return 0;
> +	} else if (err) {
> +		pr_err("Failed to register platform_profile: %d\n", err);
>  		return err;
> +	}
>  
>  	asus->platform_profile_support = true;
>  	return 0;
> @@ -4773,7 +4778,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>  		goto fail_fan_boost_mode;
>  
>  	err = platform_profile_setup(asus);
> -	if (err)
> +	if (err && err != -EEXIST)
>  		goto fail_platform_profile_setup;

Since you already do "return 0" on EEXIST in platform_profile_setup() there
is no need for this part of the patch.

Regards,

Hans



>  
>  	err = asus_wmi_sysfs_init(asus->platform_device);


