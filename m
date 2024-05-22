Return-Path: <linux-kernel+bounces-186600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 115868CC620
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 20:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EFD51C21692
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B20145B02;
	Wed, 22 May 2024 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CTTYHZwy"
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2352A929
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 18:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716401534; cv=none; b=WZWrxzKUBHt30ezLxF0aS2hstZG9ztrEYkCNMZP4d8qFMhrc/OCLQBPnozr9u03dTMuEbb6DJnUlPdrwLZYLm6SP492nBVVlgL3sduAYoUkx6uGYkdHwj86foGIN2TrzJZClK/zBW37m1UG0XLgk5EDBFo0jNr7KyYex2eWsQcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716401534; c=relaxed/simple;
	bh=ayimWCKkgfYo+0x6XeVSOVgCcBa5dhPMekRUmdgIThw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2ljRMwihS0GzwxI4lrZJsyEPmbRmbJIuFcvTxbfgXJRnvHPJwpwXfoXPDmQPGiE9Tf5XhzFlRhOkH/Z6F5e0R3PXVzktjdgOgQEZPzG8V7ISAQ1f5YgnZSDiVRaCB2PJdHQU69mwG6owglRWySAsu7RAYL4bQkxb5ygpA114XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CTTYHZwy; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-a5a4bc9578cso1002545466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 11:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716401531; x=1717006331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AugUKhaYwKDJ/9b03MK/LG9RwwxS/6pxd40CuSzPjmc=;
        b=CTTYHZwyB48HpHQbi2AkbOVs6ISj89wm8JzMriYZLeavnB+1W3aO+PF7vIiO9lbwNO
         GU2M6WKaC0wLBPyeX2vLVXjhcNsf1blRIaDbEkdR9t7MFy0ooq4CY22+5nGjQsyNFrXy
         S3eGdV5EyLkrlGZd76+y7irgNaq2jA+Bwl/eY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716401531; x=1717006331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AugUKhaYwKDJ/9b03MK/LG9RwwxS/6pxd40CuSzPjmc=;
        b=NwhrwCtxef5v+obt4mcXIZyDGAGM+B1mvucBReXlbbUmuZa6s4n+zUYlOgXfxy23xS
         FjxFl5pppzEtoZm9aYX9bWVF484Y9habxbzfDOyhknyKaRNpVVT7PdNxF04VZGi6aFpk
         v/zRiF6+MFOXkBHx6mTe1XNejvGv2kciO2ekDL54jKd/8p4doOeB2gYfbouCxdQyeCw6
         iA9roW3BKvljliMx/OFPwlHabk1Ni+rNjwHoHqm3Ufni+c1uVx2csiGvsMUBpXAz+v4K
         dosK9+APw1/vQFbaj/5poOqS0WuB+gUb3LMTEMqoqI9d/ewc2lOHDFHSuIwjXKFvyBWF
         H7tw==
X-Forwarded-Encrypted: i=1; AJvYcCULIei0n/uSkuJrCu6QeDljsrRNx/X19wBnKEoLRv1snebmNlaY7wezcfu150ta3IiaFSkblHD+/Wkp9nQlmq/a3EvVBTJ7VJst2htj
X-Gm-Message-State: AOJu0YwD+dwtsUJvnAiqF7JhN8l0NTzY87Yjb4YEWkL6Ogfmkoly7d0k
	W1WsgWF4T5fUiWyBC+6hZrPGuxtKTJ7N3CRP8INDiifadjjr73p4yCWvVUvbBvkqbembgy8r1OD
	Lv/DCALqd
X-Google-Smtp-Source: AGHT+IEmMZ4xud+XcC/bM4GnQ/gNDaT0Ez26ffalby5ZwQAi2eqMaIfl7FgX9IZApNI0DNKyltnkng==
X-Received: by 2002:a17:906:7ad2:b0:a5a:893a:a73a with SMTP id a640c23a62f3a-a62280b0165mr239268966b.10.1716401531193;
        Wed, 22 May 2024 11:12:11 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781cf70sm1806721166b.30.2024.05.22.11.12.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 11:12:10 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59ab4f60a6so914312566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 11:12:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW4oQuaDCfzVwxo3mzmgmEGjpOYE/HjYBt3icNWPhC+2osi5KWKq/X/iW66YfJv0lc9usEqZ2B6MHd3ydtv7U2VtUfZ+/6jHxnpDYt+
X-Received: by 2002:a17:906:488:b0:a59:b1cf:fea0 with SMTP id
 a640c23a62f3a-a62280d5059mr234104266b.19.1716401530325; Wed, 22 May 2024
 11:12:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515091727.22034-1-laoar.shao@gmail.com> <202405221518.ecea2810-oliver.sang@intel.com>
 <CAHk-=wg2jGRLWhT1-Od3A74Cr4cSM9H+UhOD46b3_-mAfyf1gw@mail.gmail.com> <Zk4n1eXLXkbKWFs2@casper.infradead.org>
In-Reply-To: <Zk4n1eXLXkbKWFs2@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 May 2024 11:11:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgdm4SN_ofM1gFuF7CTRgVcbAGuopgS3NWP04zRCn_SKw@mail.gmail.com>
Message-ID: <CAHk-=wgdm4SN_ofM1gFuF7CTRgVcbAGuopgS3NWP04zRCn_SKw@mail.gmail.com>
Subject: Re: [PATCH] vfs: Delete the associated dentry when deleting a file
To: Matthew Wilcox <willy@infradead.org>
Cc: kernel test robot <oliver.sang@intel.com>, Yafang Shao <laoar.shao@gmail.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Waiman Long <longman@redhat.com>, 
	Wangkai <wangkai86@huawei.com>, Colin Walters <walters@verbum.org>, linux-fsdevel@vger.kernel.org, 
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 22 May 2024 at 10:14, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, May 22, 2024 at 09:00:03AM -0700, Linus Torvalds wrote:
> > Of course, if you do billions of lookups of different files that do
> > not exist in the same directory, I suspect you just have yourself to
> > blame, so the "lots of negative lookups" load doesn't sound
> > particularly realistic.
>
> Oh no.  We have real customers that this hits and it's not even stupid.

Oh, negative dentries exist, and yes, they are a major feature on some
loads. Exactly because of the kinds of situations you describe.

In fact, that's the _point_. Things like PATH lookup require negative
dentries for good performance, because otherwise all the missed cases
would force a lookup all the way out to the filesystem.

So having thousands of negative dentries is normal and expected. And
it will grow for bigger machines and loads, of course.

That said, I don't think we've had people on real loads complain about
them being in the hundreds of millions like Yafang's case.

> plan9 handles this so much better because it has that union-mount stuff
> instead of search paths.  So it creates one dentry that tells it which of
> those directories it actually exists in.  But we're stuck with unix-style
> search paths, so life is pain.

I suspect you are just not as aware of the downsides of the plan9 models.

People tend to think plan9 was great. It had huge and fundamental
design mistakes.

Union mounts =C3=A0 la plan9 aren't hugely wonderful, and there's a reason
overlayfs does things differently (not that that is hugely wonderful
either).

             Linus

