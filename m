Return-Path: <linux-kernel+bounces-199756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E388FA565
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 00:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963891F263A1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 22:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC83813C918;
	Mon,  3 Jun 2024 22:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="srpa8opl"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3F684FB7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 22:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717452606; cv=none; b=aDSij1OZVqbWNi0Z91i/qocG4YLdWwfxjR+3NM7NK39D8e8t5TFMoHifXaRus4Wkk+uweMbI6EotTZhtAtOwY62CIbJms/xRtOjLOXAcIy5UcpgLPev6bDiMUYNDm2eaMGcmLo/wY4Pam2K2wwFzdvG3fC9gbRFwmiGPo3rInZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717452606; c=relaxed/simple;
	bh=6JYUK/JYFtBaQXk5Wd3j593s8c/SjwpSDffu/EOZPtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvSFJ4UKe3Sb+WRgJUEN8mRgcoiKzmmUAuwSPCSk0IK0PsKT7jGMJ9okxqtEZXU34WUnw7O9Uiqi6saz5oLhFmDRYHV0OOkTKaNlplz9cFT04RxCTaRb0pcUme9vll+0nKtJDXhAXPFIUe1B6bJOVbgp8FJciZCbvSf+m6UDP3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=srpa8opl; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f62217f806so41706995ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 15:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1717452604; x=1718057404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t7GKUQMjJhl3ipM3zR31k8Ko1N1r8B30w07RRIKYgq4=;
        b=srpa8oplsXgiu6bczYQgBXvvkq2slK5PLSHEUghf2Z0cxTAoh/H0N+KJlNXHtZbZUk
         kEbeozoxv23bFPpB78LRQ3oxmyEOPhJ+NatqfqU7jfNnYYBAaf4a5IFydee8+ryiAKyV
         am1LYBVdNA581qbXRV4dhO2afYDFjd/AsysudYi0LJv9tnOmd7wM+R0AQmiFi3qOvCUR
         iLaQ/TAQhBkgohImwFzzwoIJdwoDvwhDV84k3gRYc1pH/RUhVuSnkKsx4xW9qeS04SSm
         twK2WnavdmM85UWYRij7V+I3IAMjwbIvInm+no9giNZ2TRrRB/3v5oz/aSL7zDxOj/7P
         0NaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717452604; x=1718057404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7GKUQMjJhl3ipM3zR31k8Ko1N1r8B30w07RRIKYgq4=;
        b=K1TKebmkFXTQ2n9bB1Uu8p6RTz3wp+kUHB5FeM4NiJJwkATU57GyoelY5Lk8KVWZVV
         5yHDrlocZuTQBXuIxHLfmbqCtElueFhm3mkGOFO5Y0nrO1oiJvKrDAlRsTyTAaooeDvS
         XyUNFoZSImBvIiZZjUsry2LEXOBt01TkYyt1LEeMOwD5tOP7P/6+dpJj3RoJxCvZC41i
         yHhVrcbLqSVX4RYYNajNU2yE2zXGElM8oiUNjHTcire58U/LISetTjMxTC93hn5ELrDi
         /gIElzC353iY9lVuwycmXT6x2k0xDdKIm2N4BshCyLWTh850dKFkngZhrDcBIGDUELHk
         eEOg==
X-Forwarded-Encrypted: i=1; AJvYcCXQqNIYdIalZTAty5j7GvSZLQh9jVCiYOEURAUqzlkGWHeehttVjxt/cPO5HRkcwlPR/8j8tfg1IDOv0mQOiXiOrTyUaVmvU+uqZ60A
X-Gm-Message-State: AOJu0YyaXhPb0yQ2VH7sdO/CDmXl2OjEWkakCqT8YalnFXDmra9Yqr89
	LxDSTOfNaJAANlEEFlanta7eUvsRxCyzkfAtJMkPsQQCRKLOVOyrGPH0nsH0ShI=
X-Google-Smtp-Source: AGHT+IH5yMClkcY+6/WbP2qYz4dW8LFjoQ+vX8JMxAX2MslIbXm1VlEjEbivmMhYyH34HOly6saJ6A==
X-Received: by 2002:a17:902:eccc:b0:1f6:65b1:1208 with SMTP id d9443c01a7336-1f665b1145amr85868595ad.47.1717452603776;
        Mon, 03 Jun 2024 15:10:03 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f691cdd674sm5019255ad.80.2024.06.03.15.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 15:10:03 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sEFsO-003KJd-0g;
	Tue, 04 Jun 2024 08:10:00 +1000
Date: Tue, 4 Jun 2024 08:10:00 +1000
From: Dave Chinner <david@fromorbit.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	lege.wang@jaguarmicro.com
Subject: Re: [HELP] FUSE writeback performance bottleneck
Message-ID: <Zl4/OAsMiqB4LO0e@dread.disaster.area>
References: <495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com>
 <67771830-977f-4fca-9d0b-0126abf120a5@fastmail.fm>
 <CAJfpeguts=V9KkBsMJN_WfdkLHPzB6RswGvumVHUMJ87zOAbDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguts=V9KkBsMJN_WfdkLHPzB6RswGvumVHUMJ87zOAbDQ@mail.gmail.com>

On Mon, Jun 03, 2024 at 05:19:44PM +0200, Miklos Szeredi wrote:
> On Mon, 3 Jun 2024 at 16:43, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
> >
> >
> >
> > On 6/3/24 08:17, Jingbo Xu wrote:
> > > Hi, Miklos,
> > >
> > > We spotted a performance bottleneck for FUSE writeback in which the
> > > writeback kworker has consumed nearly 100% CPU, among which 40% CPU is
> > > used for copy_page().
> > >
> > > fuse_writepages_fill
> > >   alloc tmp_page
> > >   copy_highpage
> > >
> > > This is because of FUSE writeback design (see commit 3be5a52b30aa
> > > ("fuse: support writable mmap")), which newly allocates a temp page for
> > > each dirty page to be written back, copy content of dirty page to temp
> > > page, and then write back the temp page instead.  This special design is
> > > intentional to avoid potential deadlocked due to buggy or even malicious
> > > fuse user daemon.
> >
> > I also noticed that and I admin that I don't understand it yet. The commit says
> >
> > <quote>
> >     The basic problem is that there can be no guarantee about the time in which
> >     the userspace filesystem will complete a write.  It may be buggy or even
> >     malicious, and fail to complete WRITE requests.  We don't want unrelated parts
> >     of the system to grind to a halt in such cases.
> > </quote>
> >
> >
> > Timing - NFS/cifs/etc have the same issue? Even a local file system has no guarantees
> > how fast storage is?
> 
> I don't have the details but it boils down to the fact that the
> allocation context provided by GFP_NOFS (PF_MEMALLOC_NOFS) cannot be
> used by the unprivileged userspace server (and even if it could,
> there's no guarantee, that it would).

I thought we had PR_SET_IO_FLUSHER for that. Requires
CAP_SYS_RESOURCES but no other privileges, then the userspace
server will then always operate in PF_MEMALLOC_NOIO |
PF_LOCAL_THROTTLE memory allocation context.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

