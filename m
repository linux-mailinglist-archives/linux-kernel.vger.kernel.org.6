Return-Path: <linux-kernel+bounces-516892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C245FA37962
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 02:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 777313A9643
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 01:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF505DDC5;
	Mon, 17 Feb 2025 01:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="AAyijUfh"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541988C1F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 01:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739754433; cv=none; b=oT/xw6ny3q9KqP7YTeQOyhKsmjVQxbwJLN/1RcNxOYmsJd+YrBD4EdrxnJmBMPLs2UXiTO7S47P70bQBPmdIkIZZxn+v54qbelNRkpkWKZpiYNoYkmkruK/Y8Kf9hgHAe1shU9O0dPNobq+CudY8X05XpCLh3P+3Z40d7BVpxKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739754433; c=relaxed/simple;
	bh=r0i6heuaVPSa7p0zoaWhFw3re3YRJH3Qsth80J4/D7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEuWX+R/BNejfHeXBY6QX6WXLtPOAdqehH2t7pVE7SF23wZR3MuRRjKSu39lYdZKyG8ZstOGJ/wUw6uB1+F/0ejI3Szmc/f9SPIlB55vSPF5QN4I1mNl7I7WaDjp1CFQa282sNt5DQ4xgdHgtzV74JcdTCgz9R76o0A21WumSVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=AAyijUfh; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 62A3F3F2F0
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 01:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739754428;
	bh=nr0Qsc/Vfc147F5wq/TRUqaKRNYr5hm2ZvifJ1Iio1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=AAyijUfhNmN5pw+GGwfWPExPe4wAHmb6hntrQLdeqQ6Yrk2A0PZ2hzwFeA/LsHc/Y
	 9hWkt2bURyOv9PLW2idgDxTYdl462cmMsRP9Ds7CVtdMGohCZ3aXvEFez2owt6irPB
	 KiSYk2amSvZMmXXc4dtKyFXMspWoakJiIZr72roOIWpcEyicE8ADSrKTB3Jley5UKt
	 2LQmdz1avrALf2tgJGo4hkwY5gDfywKx5Em8+ztEBiAa8R8kQtJyczO9lB6uxXXdZo
	 4yAsPQn9xj2pEkFaWetQHqxF3OYCUJQ7jByTRYl3RwG/pmF5xmLFTKTxjxfW+EdBHf
	 NCV90d8zx+UUw==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22107b29ac3so20831985ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 17:07:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739754427; x=1740359227;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nr0Qsc/Vfc147F5wq/TRUqaKRNYr5hm2ZvifJ1Iio1k=;
        b=ZLvPDv7weRWy9pvVq3Vqi66DUGGPLy4LiW+fw4kZRvhJ/d3mYZLXjKDR/dWNVFD7tv
         GkKbJGgjBYVrcFOrFgqzUn9iFc74uEYcpvSLVdgMs8dvcccUG5FwwNDB6rR8lLYxZ8N1
         ZzhjFxBnu6P8qPV2kG5pP8svpGkUatwV+dGgkWn0he6Qpr9KfcMNuo+/4gMEfXFNuYVl
         VxdE5wPc423EFG7yKeln/beQRQAMMOLgIMcfDIultcuKbeR1K8iJbdeNsMXiK3G/FOD1
         7XQV2GGEyngDHPj9aiAsf/yktyNL5hWyq5lCODmEh+ESrwTYxdVB84QEVQTrtfxxzzPo
         454g==
X-Forwarded-Encrypted: i=1; AJvYcCW7nVXan68v0NWqIj3PqgGS0PK3nXKUSoHWML0RaY5mK8guT+9k8iYMf0eUiOKE2DFHJDDQ4zYUaNpPkuA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxh3nelGnginpStOGxIlRSC9Kqgi6Dqs2jV2gVzCm/zVdSZSTt
	s+oen9Xm5gd5GqNSn26C4OD20cP8Yauw379P7rHWWDX99bqLSCnQCbe8b+T48mgYVjtdKTGi1l2
	4x9q3fR4WLLJzsvFUUXY1BId7sUJbg5SXjO0OSXqSuwKuxbMeIpesRQZoRyg/KPDU83piZVahFr
	zaCQ==
X-Gm-Gg: ASbGncswMn2vf/QOdfPNfQwqyOI/ASUOZF5UEn4hidqJHrQE2v8ktHQN563Ar4zUIwh
	ESeXqQhyJZQj37Un3Qd5vCjLVlSdFsUiZHzMblVBDX7BX7IWtaayLBUO2ZJ5D5m+837lLN13fdn
	2zE3Jw1K4ox8S2YZdCG+UJtRJKoD/FBLKrErrJ3c5p3/Eo6bEREFRkPT7+06Le6y9+rbCXopfwh
	yMGVr03kJLsszQLfyFMHhbw6eRFHWuYqUShyN2D6cI3Ww4Wig11yIMlnIw9NqajZzQ1NAO1aWZW
	0lDaEg8=
X-Received: by 2002:a17:902:e54e:b0:215:58be:3349 with SMTP id d9443c01a7336-221045be927mr119384405ad.14.1739754426981;
        Sun, 16 Feb 2025 17:07:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGINbnORJERYLV1toDiLsb3YR+F8zpJcdAW1YK15qVKFjxFXMXNTZB3GLtcH9d3rtJlkyPk+Q==
X-Received: by 2002:a17:902:e54e:b0:215:58be:3349 with SMTP id d9443c01a7336-221045be927mr119384185ad.14.1739754426668;
        Sun, 16 Feb 2025 17:07:06 -0800 (PST)
Received: from localhost ([240f:74:7be:1:a6da:1fd8:6ba3:4cf3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d53fsm60989245ad.110.2025.02.16.17.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 17:07:06 -0800 (PST)
Date: Mon, 17 Feb 2025 10:07:03 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, geert+renesas@glider.be, 
	linus.walleij@linaro.org, maciej.borzecki@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/13] Introduce configfs-based interface for
 gpio-aggregator
Message-ID: <qw5epzoexlteotpuulafg4fyjatlsjjko3ldnzjezoumhodgko@a72wjsaw6fgz>
References: <20250216125816.14430-1-koichiro.den@canonical.com>
 <CAMRc=Mef-cg_xt_+mEAyxY_9RfK4=qWEbt_GebeT2mu_8GWVxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mef-cg_xt_+mEAyxY_9RfK4=qWEbt_GebeT2mu_8GWVxw@mail.gmail.com>

On Sun, Feb 16, 2025 at 04:56:59PM GMT, Bartosz Golaszewski wrote:
> On Sun, Feb 16, 2025 at 1:58 PM Koichiro Den <koichiro.den@canonical.com> wrote:
> >
> > This patch series introduces a configfs-based interface to gpio-aggregator
> > to address limitations in the existing 'new_device' interface.
> >
> > The existing 'new_device' interface has several limitations:
> >
> >   Issue#1. No way to determine when GPIO aggregator creation is complete.
> >   Issue#2. No way to retrieve errors when creating a GPIO aggregator.
> >   Issue#3. No way to trace a GPIO line of an aggregator back to its
> >            corresponding physical device.
> >   Issue#4. The 'new_device' echo does not indicate which virtual
> >            gpiochip<N> was created.
> >   Issue#5. No way to assign names to GPIO lines exported through an
> >            aggregator.
> >
> > Although Issue#1 to #3 could technically be resolved easily without
> > configfs, using configfs offers a streamlined, modern, and extensible
> > approach, especially since gpio-sim and gpio-virtuser already utilize
> > configfs.
> >
> > This v3 patch series includes 13 patches:
> >
> >   Patch#1-7: Prepare for Patch#8
> >              * #1: Prepare for the following patches.
> >              * #2: Fix an issue that was spotted during v3 preparation.
> >              * #3: Add gpio-pseudo.[ch] to reduce code duplications.
> >              * #4: Update gpio-sim to use gpio-pseudo.[ch].
> >              * #5: Update gpio-virtuser to use gpio-pseudo.[ch].
> >              * #6: Update gpio-aggregator to use gpio-pseudo.[ch].
> >              * #7: Add aggr_alloc() to reduce code duplication.
> 
> Please don't ram this new functionality into an unrelated series.
> Split it into the gpio-pseudo code, factoring out common parts and
> converting existing drivers, then send the aggregator series saying it
> depends on the former. Otherwise it gets way too complex to review.

Ok, I'll do so.
Thanks,

Koichiro

> 
> Bartosz

