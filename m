Return-Path: <linux-kernel+bounces-521564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD191A3BF5B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC73A189A798
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10081E1C1F;
	Wed, 19 Feb 2025 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PUcv/jhy"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4A2198E81
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969924; cv=none; b=FUsfA2Ag+taXH5fZuxtHyJsrD5uZnuE54DlcNtgnNDW5vv98RreSHn59lcvhZeEHKx5ULgmuXpJc1Cq/IoC/8NClq5ltdlTeJRe+MVCDKeDkYBPocg9ySc9F+C9QWRRmzfnvbGemND3fVZEh6z/djbHRBL+6xB4Irw+OT6VwCXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969924; c=relaxed/simple;
	bh=mFyDWsE7J9ZW8FmEHWh+K0Jf/vn8Ov7C5joVUJWT04s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUKAQinUMtuM9XGy6mFSL1aLBA1OwQQ5DusHaQ+PziTMoTwQ0nPyM/hc9GxBNo6arlLJhlDt65GRpI6awWSTD+ifb1dlLHxajrj4qrTEWuWogIqN4C4n7hgJnW0Jm4QRHiU26Y0aemf33NUat5y9amTEyjIYEyfty5D1BWeumpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=PUcv/jhy; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43996e95114so11919095e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 04:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1739969921; x=1740574721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=34sVOinnrdUpopDeZt0X3vBKN/d5vCnq4SYbVGcMLpU=;
        b=PUcv/jhyl3Oz6a/O1c1xGJ+/KgQnUmo4aS5WPqLdqL2WlkrIn/d+/EVQlccO5XTQob
         cHeZrc52ut8+SfxHGobx+afvEacmOi9L8BbMJ8Lldcco3Grs7QKdI45xyLC/G29NYckN
         lvbZ+nJ8J9VPLZZyXCqQfOk6S7fXWlQyUDtiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969921; x=1740574721;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=34sVOinnrdUpopDeZt0X3vBKN/d5vCnq4SYbVGcMLpU=;
        b=IYMTlrtDELG4udJ8RiEIQuzh1rqnCg9tWjy++s3LIoGXSua9dFvMs+WlUsGmepBGSJ
         xTA+5BbTHJAOOotdDOH4zwdwIrtALhBzRqCoZL6uzqUKYRITU4iUKgntasRNr4aH9pIf
         XbPkPfbrrThB6WLQMB0/PBQuTOI/cVmaq/ZOt3bULpOsTTjknjFM/K0XaERvurnB+Jr2
         20JRJ1WvxIHHW7p7iH7zbVI7S1/vMFO4LqepQgc4T6/pu8BMkZll7zrQrLVpqg2XCcZF
         ZvVqjqIJ/SCZdQbkchMZi2We3McWOXTDwA3pn+02hZnsAk6HcYpoL6Ojr7jXdMxUH3Pu
         zi0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVref51OuSx59brCNVpXDgh9d34raeCrB5mSTHkb56GK9Se4AnG0mZ3h3+8VRZcZMLmtSMFBVJAqEOYRxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnBXJtZernRUHGW0wa2wY+3oQqk9Aj9mc734jYrn+A9dUdne24
	DyNQ1Hdtb+QY2mWng6j+Lm/HOtSgrtD8YFcgijDs0Q58+WCdmM4VJOf8fJpqPLk=
X-Gm-Gg: ASbGncsvqDv3sqHP6pKFM3aTwxnL70w8XzIGOa0bt5b/S1EPKKKwHf+2oZMYBH356/N
	9/94XAvUgt8FQoshQ6RyAa/1+4llMcICrBxEyeowmdnle5ZZHdwwxHEMEPv1EcVTOlCTDCiuxht
	9YRrB8wKH0SHsOnGYqEIDhbCE7vkpGseUpIhr3Pf5NjNWG2QmsjhrSG0qKDwVpjcQXZFUJyyFb4
	feQTtlO5K5mKAJlngsz0nIzFDaZGqod4n7l2bLKb/Bfsb/ViVterPWS7yvLTWX0P8zfcQToDvWj
	rSSHMccoRH43/l86rNcZ8d4HT0M=
X-Google-Smtp-Source: AGHT+IGzbUBUg/56lBAekqPCOphT5RTECYUG5Q84fY/+IOL0ZwxmdTe8Ny3WUiTLHfIX8hhDw7t+4Q==
X-Received: by 2002:a05:600c:1c98:b0:439:88bb:d026 with SMTP id 5b1f17b1804b1-43988bbd48cmr104447115e9.5.1739969920700;
        Wed, 19 Feb 2025 04:58:40 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1aa7c7sm214383535e9.27.2025.02.19.04.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:58:40 -0800 (PST)
Date: Wed, 19 Feb 2025 13:58:38 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Dave Airlie <airlied@gmail.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Ben Skeggs <bskeggs@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH 0/3] gpu: nova-core: add basic timer subdevice
 implementation
Message-ID: <Z7XVfnnrRKrtQbB6@phenom.ffwll.local>
Mail-Followup-To: Danilo Krummrich <dakr@kernel.org>,
	Dave Airlie <airlied@gmail.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Ben Skeggs <bskeggs@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20250217-nova_timer-v1-0-78c5ace2d987@nvidia.com>
 <Z7OrKX3zzjrzZdyz@pollux>
 <CAPM=9tyu84z4Xk5X0fykO3Dazby2UqRgwtN4woNKe4Z2yMyDZg@mail.gmail.com>
 <Z7RgOd_57wcSUyB0@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7RgOd_57wcSUyB0@pollux>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Tue, Feb 18, 2025 at 11:26:01AM +0100, Danilo Krummrich wrote:
> On Tue, Feb 18, 2025 at 11:46:26AM +1000, Dave Airlie wrote:
> > > 1. How to avoid unnecessary calls to try_access().
> > >
> > > This is why I made Boot0.read() take a &RevocableGuard<'_, Bar0> as argument. I
> > > think we can just call try_access() once and then propage the guard through the
> > > callchain, where necessary.
> > 
> > Nope, you can't do that, RevocableGuard holds a lock and things
> > explode badly in lockdep if you do.
> 
> Yes, try_access() marks the begin of an RCU read side critical section. Hence,
> sections holding the guard should be kept as short as possible.
> 
> What I meant is that for a series of I/O operations we can still pass the guard
> to subsequent functions doing the actual I/O ops.
> 
> More generally, I also thought about whether we should also provide an SRCU
> variant of Revocable and hence Devres. Maybe we even want to replace it with
> SRCU entirely to ensure that drivers can't stall the RCU grace period for too
> long by accident.

The issue with srcu is that the revocation on driver unload or hotunplug
becomes unbound. Which is very, very uncool, and the fundamental issue
that also drm_dev_enter/exit() struggles with. So unless the kernel has a
concept of "bound-time mutex only, but not unbounded sleeps of any sort" I
think we should try really, really hard to introduce srcu revocables on
the rust side. And at least for mmio I don't think any driver needs more
than maybe some retry loops while holding a spinlock, which is fine under
standard rcu. It does mean that drivers need to have fairly fine-grained
fallible paths for dealing with revocable resources, but I think that's
also a good thing - mmio to an unplugged device times out and is really
slow, so doing too many of those isn't a great idea either.

Ofc on the C side of things the balance shits a lot, and we just want to
at least make "no uaf on driver hotunplug" something achievable and hence
are much more ok with the risk that it's just stuck forever or driver
calls take an undue amount of time until they've finished timing out
everything.

Cheers, Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

