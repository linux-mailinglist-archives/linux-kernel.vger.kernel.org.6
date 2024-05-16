Return-Path: <linux-kernel+bounces-181197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D15BE8C78E3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72B241F21EBC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D53514B97A;
	Thu, 16 May 2024 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PruRqEPA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECD214B952
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715871814; cv=none; b=gJEYcb4rRDIyHO3j1+kWhstsJT38dGjQxjRfVFrV2U+hWgltxJz3beDQpnXIx7OrXaxgyVpKGI2xJXEF3IN3WzECsGsodBE/mmtPh3M/Lmiocq1K+2Y1aHMXK8uIsZJv0pp1vDUVsCIwldchx+HIUWL6Bd9Vy0utlrsf2grrQbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715871814; c=relaxed/simple;
	bh=Barrt/8/lO9wErCh7pOsz/xbkBpqA22b9Ik53PIZbjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rCG+0aaVSpjJJhgYhosiYoDGQJZG8+dN7NS5YgKHs+JojxwXKxyX67x6WpG3rf9cZ0wl80ThYZb1uw8cT7dIHLCGe8ZWm4faGpgluOe0AJ0f6BF8pEnOghAf6Y2TyuPCxxO3VwqA9TAg42FgPXaIvgf5jQQvVPunzv6cNYW18oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PruRqEPA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715871811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nKBUSAzkxF9Zs4eRSjZEOq3e8C2Kq3MU7w45eIpOnW4=;
	b=PruRqEPA2Rrte/ywuqyD/wuVDEQzyCAJ9M/9tBVTwfbpHYHYwaEyRp9U/sGiPTBdmyXYEG
	oqCnzhE6AwdmvR2n9LmrKvtsbv6OAlwYkqHKxS8ET9cmGM5ozLiaDwrezDSEtZjpKKokkj
	Oh7L2rG6OtHB9Szq1gqC16+sIQpuxsQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-BvGdyph_PJO0-lazurSuZw-1; Thu, 16 May 2024 11:03:28 -0400
X-MC-Unique: BvGdyph_PJO0-lazurSuZw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-572afd6e96fso2463354a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715871807; x=1716476607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nKBUSAzkxF9Zs4eRSjZEOq3e8C2Kq3MU7w45eIpOnW4=;
        b=XEjmguE4UOAyaqnwZinFUtEbp4FXgogZeFqwR2rsB099DXuKcEcZn7qOff3wZYxueO
         UzecbBW7SbnBQAVR4f3k+wn7IIMHzehRU8IGGu1ogQ+wSVPEl0P2ptVUvdHcpwsTirNU
         H2Vk8GHatOC8fDHdlY9MVZjJkHKwLghmYhMPu0oGjCRMRxI4DbXtloRummjwBths1ZIC
         PDI0dsLKPDYxTOySWSWVkeFj3DSaonuUEOa3mKsnwYPv0Go3TcFyKXM9ki9tejffcKAB
         /zCLsPBO/eO3hURYbitryvjhNlGdu3ADKScQP/isGa6YYNIzzHXlFYweLWve+YMrb1zg
         5IsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNp9wQlUTwHxvKFLWk9mscc1+YoZAkl2MQcT76YAagDb51HiTIvGFRRxZ96brCklnhGwBO75LV2tEDCpdDc8cVb7lKApT1HnQrl3oM
X-Gm-Message-State: AOJu0Yz95i02ea0d0MN71NbfzxCnb8wVlj9THiem6mQwuYv6xTFPXJfd
	JGQ/FleHSGeTQoL7lFMrheDYsU3+wT+65R/3K6RCtK3Bhf3kDLISpGXj9/TIVPqNpZxVOuvwYZu
	HIAO4BzGRcwddnTr6WY2tGUoYeQwFv9QOal+ezG5iQQkvCeMU2DEg2YgG1bo9BA==
X-Received: by 2002:a50:d583:0:b0:572:637b:c7e1 with SMTP id 4fb4d7f45d1cf-5734d5f48b1mr19637045a12.21.1715871807566;
        Thu, 16 May 2024 08:03:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgvrzhNOwipq4x4p3Hw4REcPng/U01BJKv87Sp+Z20QuaHZ/2tw+/vdsLUK4lIsDrkAAHqdA==
X-Received: by 2002:a50:d583:0:b0:572:637b:c7e1 with SMTP id 4fb4d7f45d1cf-5734d5f48b1mr19637027a12.21.1715871807208;
        Thu, 16 May 2024 08:03:27 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574f6b8b9d7sm2749663a12.82.2024.05.16.08.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 08:03:26 -0700 (PDT)
Message-ID: <1850b44d-e468-44db-82b7-f57e77fe49ba@redhat.com>
Date: Thu, 16 May 2024 17:03:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: video: Fix name collision with architecture's
 video.o
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: lenb@kernel.org, arnd@arndb.de, chaitanya.kumar.borah@intel.com,
 suresh.kumar.kurmi@intel.com, jani.saarinen@intel.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-arch@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20240516124317.710-1-tzimmermann@suse.de>
 <CAJZ5v0gw620SLfxM66FfVeWMTN=dSZZtpH-=mFT_0HsumT3SsA@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0gw620SLfxM66FfVeWMTN=dSZZtpH-=mFT_0HsumT3SsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 5/16/24 3:04 PM, Rafael J. Wysocki wrote:
> CC Hans who has been doing the majority of the ACPI video work.
> 
> On Thu, May 16, 2024 at 2:43 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>
>> Commit 2fd001cd3600 ("arch: Rename fbdev header and source files")
>> renames the video source files under arch/ such that they does not
>> refer to fbdev any longer. The new files named video.o conflict with
>> ACPI's video.ko module.
> 
> And surely nobody knew or was unable to check upfront that there was a
> video.ko already in the kernel.

Sorry, but nack for this change. I very deliberately kept the module-name
as video when renaming the actual .c file from video.c to acpi_video.c
because many people pass drivers/video/acpi_video.c module arguments
on the kernel commandline using video.param=val .

Try e.g. doing a duckduckgo search for 1 off:

"video.only_lcd"
"video.allow_duplicates"
"video.brightness_switch_enabled"

And you will find a lot of hits. The last one is even documented as
being "video.brightness_switch_enabled" in the main kernel-parameters.txt
as well as separately:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/kernel-parameters.txt#n39
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/kernel-parameters.txt#n7152
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/firmware-guide/acpi/video_extension.rst#n118

https://wiki.archlinux.org/title/Lenovo_ThinkPad_X1_Carbon#Brightness_control

If you rename this module then peoples config will break for
a whole lot of users.

So lets not do that and lets rename the new module which is causing
the conflict in the first place instead.

Regards,

Hans


