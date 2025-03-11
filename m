Return-Path: <linux-kernel+bounces-555831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4A1A5BD45
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B534162DD9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D69225A32;
	Tue, 11 Mar 2025 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdXl6sEr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDEC224AE3
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687796; cv=none; b=gNZBjqYZ6pNvW99BmtY6S4+Lfx31Al0Qa5Aq1uIR+j++8Z6ssSN+Q8MQTaMYGNNbqJH2HVQhgXfJvjlzxKSVKTvGt35YWyl+TNwuJX1ffB9Y/mPr8vjQfyKVfYRI+T0YtvlW//95C7ijflAWtbuSJbAKANfdJumw6i+RK+5thao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687796; c=relaxed/simple;
	bh=ZR+XCIBQs9+80ifRtPgR+U/OFpGq/zuM7lgT746lhxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/amDoKbfdLxJCAdhUNGAJWaTSa5sL/tNMhGgSMVe03oh3L7rYj4mrHmlbH7Qb93G21RCNgrlc92MBvjj8Wy7uU4dbqQksNHvR2asA+rFAHMZa6C7Qo3muV3FFd+sPNA+X8P6kRLrNZkG3ct96+BIoUqLXSWBqj6min8IZP89mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YdXl6sEr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741687793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IYjkd0g01QmPqFmmHmr74WTt10z1qqPixGBi+49Tezc=;
	b=YdXl6sErIZTVIsODFOvVsIDFfkCZqnc/69m6ymELiv8uO8mqy9Z5tqa35eRoKtUgrr7HfF
	KkiW/KWLN9DkKVggmQ8a31jFwuufLhmnR7Tv8Ry5zOEZz8yl1oQ8gBL+OSo/BvAWZ0CCht
	m8Fvv0CAO2oXn99W30N03ojWjnviUmE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-z7u6RcgwPBWdA5ALKZ1lQA-1; Tue, 11 Mar 2025 06:09:52 -0400
X-MC-Unique: z7u6RcgwPBWdA5ALKZ1lQA-1
X-Mimecast-MFC-AGG-ID: z7u6RcgwPBWdA5ALKZ1lQA_1741687791
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac28a2c7c48so273490966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 03:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741687791; x=1742292591;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IYjkd0g01QmPqFmmHmr74WTt10z1qqPixGBi+49Tezc=;
        b=A1um+Cr74KKIMUBhUSbX9z9ImVpeH2fyKDJm6hX7C7TTUU1QkvMBrbeBVzipwXHrw8
         5xgFqckgGLGp7ESC9TPq5QXlOpwIJ09wOUOJ5eBmnw9nDgx3TZOMW4RNEOyXDMfzVlf0
         BNBxWdNsCOqjBH5U48LUewaaF9BQsTmXNw29LakG7NZ7dmPiczNcLEHHh2esg9IrVNWH
         yG+0XNLebl5Q0+p9squTERhrUiTBhzVhAPYbYoQlW889E0RjiCvoFrgX98vZYuW6Bxnp
         Uw85do3E27EQdGOGLWJkiuN2vFjadR+z++/BY7eFj0G1BEtD8LUEhLQ3C2DAv6CxYjh5
         f3yA==
X-Forwarded-Encrypted: i=1; AJvYcCUPH5+QHD6Y+1thWbeqTr5zfm5OsqjLTwuoeHktG9SF6dzI5YA0I3jTU3yx5OO1A5pUSyCJRT1hBLne/os=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYKAuN/3lpQXbT3kyrQz+eS7Wu+ucX456ZrOVyStTiRTgxhLzP
	Bp0ZLdsuwkDxWv+DL9kAbmw8WL82Nv9/Yai1A4Ji1n4icTxnSGKIBaUizMXpqaxbwZAp0TW9XVP
	/B518pMFepSuw99aIgraQgcdQFD2POAmhhB4T4p7ZnWkss0xPoq2N4Vv7QwZOag==
X-Gm-Gg: ASbGnctDOGRcZgsoWjEpfoflve+ht6VaRDmMYbqDOg9Uh3DG2K79a+g9ikQ1MxAKisT
	CK9oM6wSvikaIxukq5AoPhxIaz6A+vocAww3A1lakkE9DKZQXDwxLQT/FMY7zo5CUcb36hGTs7x
	gZoPxJtA4doGbt8nw7V1yEDoBcIfEfwOTMPnHTSDeANRRIW9oneGJIKNWMhvv0eYpYiUIE64rbC
	xPOzAlo9YB2licoIymihtVQbxKy4yist1TCWBpIyFNvJSXfe9RR+OxhaenqXKK+MAHJ1wcLipik
	+U+Tm1AP5Z18mZFsykh3JG9ru23CWjkg93804zZxrgPAWvPoUXwrGjgmLBo4gcx5zryNnT34zlM
	V0D5lW7KcgnMidfSlOMoLz+F4hi+/EMe8nBWRlNgGPUAtRmTSDeeKvpzPqfUcSWZLsA==
X-Received: by 2002:a17:907:720a:b0:ac1:e881:89aa with SMTP id a640c23a62f3a-ac2525b9c95mr2043899766b.5.1741687791355;
        Tue, 11 Mar 2025 03:09:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOtp2eumlycwdsPaAxaDUlofVKvmeDoy+4Ahh4afVHjwmszC51GixSB4O24V97bjopnGYZwg==
X-Received: by 2002:a17:907:720a:b0:ac1:e881:89aa with SMTP id a640c23a62f3a-ac2525b9c95mr2043896666b.5.1741687790943;
        Tue, 11 Mar 2025 03:09:50 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac288ffe157sm449727566b.132.2025.03.11.03.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 03:09:50 -0700 (PDT)
Message-ID: <7ceea724-4e9e-409e-88fa-0d186096744f@redhat.com>
Date: Tue, 11 Mar 2025 11:09:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vboxsf: Add __nonstring annotations for unterminated
 strings
To: Kees Cook <kees@kernel.org>
Cc: Brahmajit Das <brahmajit.xyz@gmail.com>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250310222530.work.374-kees@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250310222530.work.374-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10-Mar-25 11:25 PM, Kees Cook wrote:
> When a character array without a terminating NUL character has a static
> initializer, GCC 15's -Wunterminated-string-initialization will only
> warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
> with __nonstring to and correctly identify the char array as "not a C
> string" and thereby eliminate the warning.
> 
> This effectively reverts the change in 4e7487245abc ("vboxsf: fix building
> with GCC 15"), to add the annotation that has other uses (i.e. warning
> if the string is ever used with C string APIs).
> 
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Brahmajit Das <brahmajit.xyz@gmail.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Kees Cook <kees@kernel.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  fs/vboxsf/super.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
> index 1d94bb784108..0bc96ab6580b 100644
> --- a/fs/vboxsf/super.c
> +++ b/fs/vboxsf/super.c
> @@ -21,8 +21,7 @@
>  
>  #define VBOXSF_SUPER_MAGIC 0x786f4256 /* 'VBox' little endian */
>  
> -static const unsigned char VBSF_MOUNT_SIGNATURE[4] = { '\000', '\377', '\376',
> -						       '\375' };
> +static const unsigned char VBSF_MOUNT_SIGNATURE[4] __nonstring = "\000\377\376\375";
>  
>  static int follow_symlinks;
>  module_param(follow_symlinks, int, 0444);


