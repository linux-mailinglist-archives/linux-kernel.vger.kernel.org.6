Return-Path: <linux-kernel+bounces-352912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D44992609
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D536282171
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5911741C6;
	Mon,  7 Oct 2024 07:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ShifBP9s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F471BC5C
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 07:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728286057; cv=none; b=Cjoc0IHTUaHbNlNYg31eCQ66r7dX+Z0DXVyb79qg3269lXpwFJXvY1LW4ATHZHn944yVs8x9VS9jdXLDzAvN9MZGqDTx+F1DOAkUfWBUL28ScfAboVj7CsDV1S0TqPOvbpdtle1X82o4XFlb+7BjCJAyGoPzfBI9JO+a1NFCzfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728286057; c=relaxed/simple;
	bh=3ZVQ/du5fp/D7M+/DZSrAUjCM0yTqZIr5MrY8DlPGkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=deWPc4Jpi9hyDKeIRQ0JXZoigQ2I4bgNsHlIoBOzQv+9s7IMapLX0YXkAOMfhk7jd+W7Q0LJxbdiRyqJ32dK9Cgd/KN8gispCrsfSFa9dkHkjCjoESI8ReIQnYAJzcg8TXnUZf1yTLiMRKyz5ZOHUDIafammE5BtBHsqe3Gfz2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ShifBP9s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728286054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cw2WEIesKZP7kRBN9ihX4z0j8EU2ju/lqZ4x9HFRnko=;
	b=ShifBP9sP/0cJqS7bQEJxEQx9kbZ0Gw74pOFrghWWNUgVkrdkgjuQEb/FqNOAjpr5NHmBp
	cKbbc+V/PJKF5GwH9WIfszjt0+5IYyFaOcwSK8+smtljET1j+o+ftuKdQiLP9vR530Gbb3
	0i/ch02jrksLJlZgohboM1/NrvyXpeQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-h8zz4DIXOquLL54w2NZJfA-1; Mon, 07 Oct 2024 03:27:33 -0400
X-MC-Unique: h8zz4DIXOquLL54w2NZJfA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37ccd39115bso2797982f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 00:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728286052; x=1728890852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cw2WEIesKZP7kRBN9ihX4z0j8EU2ju/lqZ4x9HFRnko=;
        b=brw2GFnIMqKsu7ddRVx7CJEzvVLBk7WHaF/lCl36CZA3tUzkHuf81eVLUk5iIczc7R
         udvkoGhY457PLtZO0/8wg2bn+KrYbndwGO3Rb0WahRBz7nndBmNTKS5Ob33s5B9oDHdT
         DsUDs+lX3a3NuQjiXy8M3/uB5CIVIgNR422LWu535VoXtmQm+I1q7HdIDL8q9nUz757O
         NHvVR33ie6zhjjs9nWGKD8nv+Sq+u0eH82eA0VOSIO8ud4O8IS4IX/tcBAG+KoJkaMxT
         vrDIf0oXr/kOo1AMJb8WkuqNHKgmJCHk6dVqQCzVGIvzLE7TgaBpUiH0fjMkl8cEKSX4
         XO0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSqXO9ztKYZy/lUL8nivC4VsDX4hynSVqhjNZxxEiGZH6OpLzG2GQf6BmfefO8VgNV2bVQfD2Wh1wIKY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn4cMTiIg0XJ8fLF5wm3ce6hF9NlrOJ6w8fzw4V3mdXyZwRxDL
	KXTtsdh1yugcC9bgUn9Nm0AM9jQ6VBvy0H+tY/4iO3qxL+PYByLu06r5nCH0D/T6qLJ9FSsLhUk
	rVbYBChTJkMSPkk7bvn//iOMn8KPgZED3Z+Z5KUMcnFWD4+B1JlCKFe3b8rIRkw==
X-Received: by 2002:adf:fb4f:0:b0:37c:d261:3c6e with SMTP id ffacd0b85a97d-37d0e6bb9ebmr6279616f8f.10.1728286051794;
        Mon, 07 Oct 2024 00:27:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtq8JWHTMkBnHAxco/hSRyF3Kw8hFWJ++hg1DsVE0Of3iNQ06+04BW/YAH9dSwMbiGx1lSvg==
X-Received: by 2002:adf:fb4f:0:b0:37c:d261:3c6e with SMTP id ffacd0b85a97d-37d0e6bb9ebmr6279601f8f.10.1728286051342;
        Mon, 07 Oct 2024 00:27:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1690f0b2sm5064405f8f.9.2024.10.07.00.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 00:27:30 -0700 (PDT)
Message-ID: <d328299b-40c2-4e63-a3b9-c83feb1ca168@redhat.com>
Date: Mon, 7 Oct 2024 09:27:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] drm/log: Introduce a new boot logger to draw the
 kmsg on the screen
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 John Ogness <john.ogness@linutronix.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 bluescreen_avenger@verizon.net, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240910070733.156127-1-jfalempe@redhat.com>
 <782f6c32-73ed-4e58-ae10-ff2d486b499c@linaro.org>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <782f6c32-73ed-4e58-ae10-ff2d486b499c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/10/2024 00:40, Caleb Connolly wrote:
> Hi Jocelyn,
> 
> On 10/09/2024 08:56, Jocelyn Falempe wrote:
>> drm_log is a simple logger that uses the drm_client API to print the 
>> kmsg boot log on the screen.
>> This is not a full replacement to fbcon, as it will only print the kmsg.
>> It will never handle user input, or a terminal because this is better 
>> done in userspace.
> 
> 
> I tried this out on the OnePlus 6 (Qualcomm SDM845/freedreno) and it 
> looks great :D
> 
> Here's a demo for kicks:
> 
> https://people.linaro.org/~caleb.connolly/drm_log_oneplus6.mp4

Thanks, it's a really nice demo!
For high-resolution screen, I will add integer scaling soon, so that 
should be a bit easier to read, without requiring huge fonts.

-- 

Jocelyn


> 
> Tested-by: Caleb Connolly <caleb.connolly@linaro.org> # freedreno/dsi
> 
> Kind regards,
>>
>> If you're curious on how it looks like, I've put a small demo here:
>> https://people.redhat.com/jfalempe/drm_log/drm_log_draft_boot_v2.mp4
>>
>> Design decisions:
>>    * It uses the drm_client API, so it should work on all drm drivers 
>> from the start.
>>    * It doesn't scroll the message, that way it doesn't need to redraw 
>> the whole screen for each new message.
>>      It also means it doesn't have to keep drawn messages in memory, 
>> to redraw them when scrolling.
>>    * drm_log can only be built-in (and drm must be built-in too).
>>      The reason is that, if you build it as a module, then a userspace 
>> application will be more appropriate than this module.
>>    * It uses the new non-blocking console API, so it should work well 
>> with PREEMPT_RT
>> v2:
>>   * Use vmap_local() api, with that change, I've tested it 
>> successfully on simpledrm, virtio-gpu, amdgpu, and nouveau.
>>   * Stop drawing when the drm_master is taken. This avoid wasting CPU 
>> cycle if the buffer is not visible.
>>   * Use deferred probe. Only do the probe the first time there is a 
>> log to draw. With this, if you boot with quiet, drm_log won't do any 
>> modeset.
>>   * Add color support for the timestamp prefix, like what dmesg does.
>>   * Add build dependency on  disabling the fbdev emulation, as they 
>> are both drm_client, and there is no way to choose which one gets the 
>> focus.
>>
>> v3:
>>   * Remove the work thread and circular buffer, and use the new 
>> write_thread() console API.
>>   * Register a console for each drm driver.
>>
>> Thanks and best regards,
>>
>> Jocelyn Falempe (4):
>>    drm/panic: Move drawing functions to drm_draw
>>    drm/log: Introduce a new boot logger to draw the kmsg on the screen
>>    drm/log: Do not draw if drm_master is taken
>>    drm/log: Color the timestamp, to improve readability
>>
>>   drivers/gpu/drm/Kconfig     |  19 ++
>>   drivers/gpu/drm/Makefile    |   3 +
>>   drivers/gpu/drm/drm_draw.c  | 216 ++++++++++++++++++++
>>   drivers/gpu/drm/drm_draw.h  |  56 ++++++
>>   drivers/gpu/drm/drm_drv.c   |   2 +
>>   drivers/gpu/drm/drm_log.c   | 391 ++++++++++++++++++++++++++++++++++++
>>   drivers/gpu/drm/drm_log.h   |  11 +
>>   drivers/gpu/drm/drm_panic.c | 247 +++--------------------
>>   8 files changed, 721 insertions(+), 224 deletions(-)
>>   create mode 100644 drivers/gpu/drm/drm_draw.c
>>   create mode 100644 drivers/gpu/drm/drm_draw.h
>>   create mode 100644 drivers/gpu/drm/drm_log.c
>>   create mode 100644 drivers/gpu/drm/drm_log.h
>>
>>
>> base-commit: 9aaeb87ce1e966169a57f53a02ba05b30880ffb8
> 


