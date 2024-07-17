Return-Path: <linux-kernel+bounces-255042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD98933AF0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF791282C6C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B573917E901;
	Wed, 17 Jul 2024 10:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPFBRtuT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668CE3D3BF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721210916; cv=none; b=bVozlOAmzkoX/r8Vekf4ttAV7jHYdpJ/bUAI9axH3WlaDfjz0VB3kXv/VoloJj8A++ERh3Jbjq4RuY/2U3t70PRNpGtAAV/JeLjMQWbpfD+4fTyIJKJj1x364gCz9mODkCZ/FvJkO7ZW60AcrrshAp6QDtbOOgKxrNo/XZoD0Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721210916; c=relaxed/simple;
	bh=VJzbhh46j8FTftQKVsWxLRGfCdvkS4wlIGN2br8arew=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aY/62MPZXHjsMpq1vpCmr6spo1h8Wjv4RfYn8R98mDwVsiL9A1Tr+wNDX19si0ySTKTQGzz7kYLSqb1Un9OYV0Y6XRXLRg9GquyOrLvYJUOt+60I5TdAK//eTodSft1G/+ByWWZEo/vlvjV7E03KcAriD1hOhjFl9HU9Eub0E1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GPFBRtuT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721210913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xjkUyUot20NGrY9ZFrQg4iD0i6JztFTd/ok1J4HNwDY=;
	b=GPFBRtuTpOSrbMeooo40gYn8ZOc9XmwEUthWNQcqR3HYzs4xHY0LRrfOUmkJgGbxY8jbji
	dUVo+LN42DAMOg/9aCqZ//E6Lb+vJjyaQgR3Lc/DYnsKqemJrlArhYFkFow8y7WdY9jxOF
	Z3i3FrpqZlT8brfd0n+uybW1e5YUDEQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-GsbtTOQSOGizWdk9BbjeNw-1; Wed, 17 Jul 2024 06:08:32 -0400
X-MC-Unique: GsbtTOQSOGizWdk9BbjeNw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4279b07cd45so47475635e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 03:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721210911; x=1721815711;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjkUyUot20NGrY9ZFrQg4iD0i6JztFTd/ok1J4HNwDY=;
        b=lOdoWPrTmZ72AeWxBmUvACsRL0XrYA9BqtWXMXPrb9BkoBPPOKiKPNzxH6j41w2ry5
         Ux28hGoRg0jw3tWgVGTJb5hsWuw9FqvHSq61Qsad+XEzKIkVT8GmZiJC9mL8JxMCydah
         nqdgY/+6hbVmvqwXYYlteOIyRgQUEyPiRHYg1SwXu4hbi4D5yI4Xzw3RmZncVqmx2SYS
         MudTtxFl42MMsLH5rrnIV9WeXCsRsU4E2+WvTD/OAAbxYKDO62IU0XPz6QLjBKC9je0R
         48+sCH8ZyMM+BBpOtAsI9UabSch7713s99aC/W952pPsbKiUgR5NBR5fWUeWj603gIY3
         DPMw==
X-Forwarded-Encrypted: i=1; AJvYcCXy2XCnX0LWh4xzvby9Zi99d5DBjf617244BVXISCzDB4KuEZutcLNBYhNzNvWlas/GIls20UPoFhPua39yGtSscMDte1Ge2HxgqmwC
X-Gm-Message-State: AOJu0YwSZIYvhXxwNXx/lxP7YdGJoUFgFTWd0cZEuB0YbqyAlEag5sTu
	rfQTonWQfmja2m94+RTZfupeyZFGog+XKR6Rnau3WENGXWKokwNsvRyMufNmJcEpCgylD2fvPIi
	kz7UfVhkGEtvVV97ZJY4UzOQCktNmflyQviXoMJv43CvG7x8nggk6L3y7ca5ivA==
X-Received: by 2002:a05:600c:1c21:b0:426:4f47:6037 with SMTP id 5b1f17b1804b1-427c2cc2f5bmr8604555e9.19.1721210910941;
        Wed, 17 Jul 2024 03:08:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkUSxu2VeixFnYHEIPInPCJHTDc3WCGL4pCgRh1eLivnZ8ZCPxQEJHjlvcn3WW+HuqhF4hlA==
X-Received: by 2002:a05:600c:1c21:b0:426:4f47:6037 with SMTP id 5b1f17b1804b1-427c2cc2f5bmr8604225e9.19.1721210910486;
        Wed, 17 Jul 2024 03:08:30 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db038dbsm11135956f8f.95.2024.07.17.03.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 03:08:30 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>, "Jiri Slaby
 (SUSE)" <jirislaby@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Jocelyn Falempe <jfalempe@redhat.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 2/3] fbcon: Add an option to disable fbcon in panic.
In-Reply-To: <20240717090102.968152-3-jfalempe@redhat.com>
References: <20240717090102.968152-1-jfalempe@redhat.com>
 <20240717090102.968152-3-jfalempe@redhat.com>
Date: Wed, 17 Jul 2024 12:08:28 +0200
Message-ID: <87zfqg49gj.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jocelyn Falempe <jfalempe@redhat.com> writes:

> This is required to avoid conflict between DRM_PANIC, and fbcon. If
> a drm device already handle panic with drm_panic, it should set
> the skip_panic field in fb_info, so that fbcon will stay quiet, and
> not overwrite the panic_screen.
>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---

This makes sense to me as well.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


