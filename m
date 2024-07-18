Return-Path: <linux-kernel+bounces-256068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655D2934894
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D551C21A84
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1D375808;
	Thu, 18 Jul 2024 07:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JW9XMahH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279D374429
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 07:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721286369; cv=none; b=ebu5rMmYv1dfTc1MC0XM5+un0MhNlc2lSr3kbaXQriaTQM0Pw6v2OW1W4DqHxl/mIzDPcnmT/I/N1AAzTq2hGQCGkbPd/7groaU0/aKc/WIc9l0JD2hF/cwFJrjC7ebjavpUEIqmzqCV3fg5TqYSA/skXj+WZ0WSuP5KN2dbLZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721286369; c=relaxed/simple;
	bh=uA0JGGjakiMbR9WsA7dhks+DdnDu6St2X1YRdoaTlws=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YJc9SSDex5FqPmAID3aqHEv0y1Cw52nvKjHkipJ+K/5LAj7s5qWVAa9C+EBMXjF9h8SKFK/UCiqTd2EdF5DR3LERmC/HiWRQyzYRP4z6vo8RtPy34VEF9KoaGCx4iv+YDz1YPGl99aXBZs8pHdMzCPJ0xSXnkhtHBE/qSCqBbZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JW9XMahH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721286366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LZ1lU4s3MEl0eqBrDrKpVc0POkcvbrGUvI/MYSaxt9I=;
	b=JW9XMahHpN9JlXItgjKirIQ2J7fVIUqpwRNQJqJ33LLNJo1XiyAYv4U+PB76JJrMFG4ZlI
	cIW3tBTFdsdN7pf4I9ovUcSWoDwtiwkrH5/asx0b7ooH3hDMlBD9NkS6uEl8HuOG4qis2M
	9fVbe3VNeTgIznaRJURJMyfuWPR28RQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-7NhJeS4cMv-GjG_WjDODaw-1; Thu, 18 Jul 2024 03:06:04 -0400
X-MC-Unique: 7NhJeS4cMv-GjG_WjDODaw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-426724679f0so7450965e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 00:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721286363; x=1721891163;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LZ1lU4s3MEl0eqBrDrKpVc0POkcvbrGUvI/MYSaxt9I=;
        b=j3F3Y2rrovfDWVDSrfyiAu0YWuKgyLsm/XxaQFRuDgtimjZFaOzW4sADtF00jFkUvh
         qonEqHl3LQ+QHhRPjsa0/bn3CCQ5m8fQqqs+qAF02XNANSVpH0Q+/RvkcWaOLt3o3R0w
         itERBcNfRw94ifF/4h4fEUjcNwC7W1uHRz+7xvnvh2oDcIFOIcv/riSD/JYCkSXbECi8
         BCbZWuaVkoU5QkH6sKE5VeEiZZRT/FU4JAVNMYaM6uTJRxrhM72z/q1KnPq0tUuHAgRE
         yaluiAlOUmjvPFdf30MHNJZkcmQWPDud1Anq2UYu27qXJCigdii55a/yrnsl6IOi8B4D
         ZLgw==
X-Forwarded-Encrypted: i=1; AJvYcCXOm8kjV26IKCp6xoUHhNxPnYT44wrP00G74WR5Yx36NtE9xYp0Nr6hTGDKzV/bE6WKIzEv4fB2ze8kDOK64WDeN2CQqJ0vYbysl4Yp
X-Gm-Message-State: AOJu0Yzg40Ah1tu1Um8yM2I9LTsoHKA2dbcBs3etorxBw7snGjdXvlt8
	Fiyr/c7Gm8ckoe3aSBOWEM9wPTma7AlV8J2uF5CjN8uiDeq18XGIIzbzrTSOWRb88GEnj6+GZUP
	dZ8LuI6yJ6GlhYWM5q6gY7LZDGEt2lUkImdvFDfT3CYM6RismbnbLqU6fpKZSUA==
X-Received: by 2002:a05:600c:a41:b0:424:a7f1:ba2 with SMTP id 5b1f17b1804b1-427c83abaacmr11056425e9.17.1721286363350;
        Thu, 18 Jul 2024 00:06:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa7qUlOIVPtRLS94vJ5+kzoefqLguJcUGf7zXA8087LONGESX8WhOSNJuoCKzvG05hbn781w==
X-Received: by 2002:a05:600c:a41:b0:424:a7f1:ba2 with SMTP id 5b1f17b1804b1-427c83abaacmr11056155e9.17.1721286362999;
        Thu, 18 Jul 2024 00:06:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c77f21bdsm23840755e9.29.2024.07.18.00.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 00:06:02 -0700 (PDT)
Message-ID: <93589af2-dcfc-437b-85ca-b0029f4d6401@redhat.com>
Date: Thu, 18 Jul 2024 09:06:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] fbcon: Add an option to disable fbcon in panic.
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Helge Deller <deller@gmx.de>,
 "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org
References: <20240717090102.968152-1-jfalempe@redhat.com>
 <20240717090102.968152-3-jfalempe@redhat.com>
 <ZpfdcC2Es9rweHW_@phenom.ffwll.local>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <ZpfdcC2Es9rweHW_@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/07/2024 17:04, Daniel Vetter wrote:
> On Wed, Jul 17, 2024 at 10:48:40AM +0200, Jocelyn Falempe wrote:
>> This is required to avoid conflict between DRM_PANIC, and fbcon. If
>> a drm device already handle panic with drm_panic, it should set
>> the skip_panic field in fb_info, so that fbcon will stay quiet, and
>> not overwrite the panic_screen.
>>
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>> ---
>>   drivers/gpu/drm/drm_fb_helper.c  | 2 ++
>>   drivers/video/fbdev/core/fbcon.c | 7 ++++++-
>>   include/linux/fb.h               | 1 +
>>   3 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
>> index e2e19f49342e..3662d664d8f9 100644
>> --- a/drivers/gpu/drm/drm_fb_helper.c
>> +++ b/drivers/gpu/drm/drm_fb_helper.c
>> @@ -40,6 +40,7 @@
>>   #include <drm/drm_fourcc.h>
>>   #include <drm/drm_framebuffer.h>
>>   #include <drm/drm_modeset_helper_vtables.h>
>> +#include <drm/drm_panic.h>
>>   #include <drm/drm_print.h>
>>   #include <drm/drm_vblank.h>
>>   
>> @@ -524,6 +525,7 @@ struct fb_info *drm_fb_helper_alloc_info(struct drm_fb_helper *fb_helper)
>>   	fb_helper->info = info;
>>   	info->skip_vt_switch = true;
>>   
>> +	info->skip_panic = drm_panic_is_enabled(fb_helper->dev);
>>   	return info;
>>   
>>   err_release:
> 
> Bit a bikeshed, but I'd split this patch out since it's for drm's fbdev
> emulation, not the fbcon core code. With that:
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Agreed, I considered doing that when writing the patch, but as it was 1 
line, I kept it with the fbcon change.

Thanks,

-- 

Jocelyn

> 


