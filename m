Return-Path: <linux-kernel+bounces-383061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1789B16E7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 12:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D200E1C20CC7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 10:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F82A1D2B0D;
	Sat, 26 Oct 2024 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Grn5zq3T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8315B1D043A
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729937262; cv=none; b=tIQdeuLPjwhP479MIa+vKukBPPxO3ixU4e4M49sr3L0ZoNY+JBJS+1LOUFGoYmyrqmSBuwZBdxk/DG0r+q3a6mpxTY8q+OTe45pl+syR4EzQf3FMMxTMHswZBVQYAuzSFvBl+sJ2JAbh+Z/40uKD2Rv/N95haOi2V7jgm29Hq+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729937262; c=relaxed/simple;
	bh=KBmP0nO8LLhW1rNmvh8diNerp2LuvfZNzwxEdjqWeho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9J1DxekfzVfeETr46Mt2zv3wV1AeOsyqFs3O2EmFT7bVOHmM06yAHTkUFHVObVG2rrnrITdIZh/BwP12RhjK2b9IEDqHWrINdVIkxQEoWtXHIffj4Hmwmn+yRQRMYQauzS0zFJKQ6/0ujDCVD2Vd37Tu1SicGXvmlGxQxlxiYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Grn5zq3T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729937258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=86pihVpFCTMFYss1/Iltby9/esixmfhGJjvS5+uk3X8=;
	b=Grn5zq3TPRQzst72tWSuS9rUuthMZF7xgF6BeE/ZeSew+pv3YWDoZX5JV7ay2tAwisEE48
	K4CR4Ofwxn5yYYkqhqmhzfIw7pXPEkrKDFTshn+E2aoh1hjUhGZ6sZrLQOF98S8x/bdd0h
	nE3Qjes4YwxzSRYiu0fCmLk3AUcYC/U=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-BHpGj0QPOjCN_MXTmc8Ycg-1; Sat, 26 Oct 2024 06:07:37 -0400
X-MC-Unique: BHpGj0QPOjCN_MXTmc8Ycg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a9a157d028aso187128466b.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 03:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729937256; x=1730542056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=86pihVpFCTMFYss1/Iltby9/esixmfhGJjvS5+uk3X8=;
        b=ge2dGZY1/d/Om7VwaqOuwozXX3SHX9ve+7B89bCX3xfan49RQonXSJ1GR4JYh8ahxX
         yAMWBNAwxmvgOaXglfyFeCYhHHpeoVHG6T4XcDuugrUK7w00x2anlz/25nOE8jmHgttj
         9oyIk3B6xM5p4sEfFLN+g3IkpfsvF31iRM7IVJ9MvIs23LOHFrfASXncvYEYexz/HjKC
         iHFVoluHBbrKF+Dv6RC5FvNF2uIlp/RjiXUZWIYr7TZXdK8OzZXD8Y8atQ0+CGzo5m/g
         4XNytHLaN77/XRhZHgmXLpXnm9ZzTtAl9N1sBpby8CEuPAadZfSZYL5xp23C8e/4NAz6
         hkSA==
X-Forwarded-Encrypted: i=1; AJvYcCXmQZwNnGvxPlgXWUhcdgBDVABqf0z0KdJcPviVyCDyLj17fRduWj8+jv+fJRMXsarX4tPHdH2zoGQHcNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YysPo705oCQyJOsha9ckwebUWUqCilP0ENP2gQHk2QrpI3l6xiz
	JQgN+aW+hUg+UOdKUqAbJG7oWdjvng9LfOu4x+RiY0MvHDDm54WirzH3A5QRaGnDvZOZ1I6cKHA
	pq0CJElgxX7Af0FmlfnOYnJJ1crbilcjtt+DRihqKZMBM9bNQTkSit7ORSijV1g==
X-Received: by 2002:a17:907:9727:b0:a9a:230b:ff2c with SMTP id a640c23a62f3a-a9de5f2226dmr168737566b.30.1729937256108;
        Sat, 26 Oct 2024 03:07:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGugRUzTiO3bQ3RT5C4neQOCWw/sRdC3diGmPwKsQoYtVGLDDEjNj2gnVCayaCXt7maanra6g==
X-Received: by 2002:a17:907:9727:b0:a9a:230b:ff2c with SMTP id a640c23a62f3a-a9de5f2226dmr168735166b.30.1729937255762;
        Sat, 26 Oct 2024 03:07:35 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f0298cfsm159302066b.74.2024.10.26.03.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 03:07:35 -0700 (PDT)
Message-ID: <e302a05d-cea1-4004-8727-8beee52dc112@redhat.com>
Date: Sat, 26 Oct 2024 12:07:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] ACPI: platform_profile: Use guard(mutex) for
 register/unregister
To: Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER"
 <ibm-acpi-devel@lists.sourceforge.net>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20241025193055.2235-1-mario.limonciello@amd.com>
 <20241025193055.2235-6-mario.limonciello@amd.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241025193055.2235-6-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 25-Oct-24 9:30 PM, Mario Limonciello wrote:
> guard(mutex) can be used to automatically release mutexes when going
> out of scope.
> 
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/acpi/platform_profile.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 0c60fc970b6e8..81928adccfade 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -180,41 +180,34 @@ int platform_profile_register(struct platform_profile_handler *pprof)
>  {
>  	int err;
>  
> -	mutex_lock(&profile_lock);
> +	guard(mutex)(&profile_lock);
>  	/* We can only have one active profile */
> -	if (cur_profile) {
> -		mutex_unlock(&profile_lock);
> +	if (cur_profile)
>  		return -EEXIST;
> -	}
>  
>  	/* Sanity check the profile handler field are set */
>  	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
> -		!pprof->profile_set || !pprof->profile_get) {
> -		mutex_unlock(&profile_lock);
> +		!pprof->profile_set || !pprof->profile_get)
>  		return -EINVAL;
> -	}
>  
>  	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
> -	if (err) {
> -		mutex_unlock(&profile_lock);
> +	if (err)
>  		return err;
> -	}
>  	list_add_tail(&pprof->list, &platform_profile_handler_list);
>  
>  	cur_profile = pprof;
> -	mutex_unlock(&profile_lock);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_register);
>  
>  int platform_profile_remove(struct platform_profile_handler *pprof)
>  {
> +	guard(mutex)(&profile_lock);
> +
>  	list_del(&pprof->list);
>  
>  	sysfs_remove_group(acpi_kobj, &platform_profile_group);
> -	mutex_lock(&profile_lock);
>  	cur_profile = NULL;
> -	mutex_unlock(&profile_lock);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_remove);


