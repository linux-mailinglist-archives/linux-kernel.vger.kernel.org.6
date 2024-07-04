Return-Path: <linux-kernel+bounces-241636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02588927D61
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A5A1F247E9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5753473452;
	Thu,  4 Jul 2024 18:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ebXuo1pL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCC640BF5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 18:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720119458; cv=none; b=tMQyxc20jL2TkQCM7YxJHMTHu2RzuabfL49jRcAC8n2I7wM3jixpbE5GurDn1eyZN9AnZ6U3xAEOYyxWzy5HHGNaaTcqb2IYRtzlge5aQb5tqakUKECJf+obWGV3ksjWzTEsOnRPorYePSFGwHwL/6RQ8HA+tPst+dEBZXyORMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720119458; c=relaxed/simple;
	bh=dvYXstgzeNn2Ivh10EbsLujK6bZSFQ1w4btYRjSPxVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5ux0D4cL9kt4ZswqmMsISLThd/zXoOHMZWzryC+TWdc4ZTdDnEy5jyD96bea1sjvY2DforC7yiHpvZK3INH0sWzOsG4AfxvI2XRxXoFqZXFDW7EbnhmwJ5py2I5xeDTaJ+4xSOnnBzy3zsP73qEZ9TkkFv8YM9K5m1QUHOVBz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=ebXuo1pL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483F3C32786
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 18:57:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ebXuo1pL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720119455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dvYXstgzeNn2Ivh10EbsLujK6bZSFQ1w4btYRjSPxVA=;
	b=ebXuo1pLTluGg2WNFG9YggMH5UN5wh+r0Gc2kQ/PObrLNtMCzbpWbSRwbW0T3/Zpy5CBEC
	OTjKyKkyoK/KnXZodJViOhXoeiuShbkMEvY5YXcNAmKjJxf3rMGTKuIWGHZrtf04Yo/g8m
	4PQMogXAe2hnZjDl+fYHd0vm/A9ei5I=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 470bec47 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-kernel@vger.kernel.org>;
	Thu, 4 Jul 2024 18:57:35 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d846f43632so482936b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 11:57:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXB8wXP2XK8Ayk6YZWW0+8sL0YHutNir6ch50maieVn5FCDrlwbbf1nxTo6YsM1/WaHRYdueTG/G1JdOC5jfShBYLdistoX4IHHkhSF
X-Gm-Message-State: AOJu0YznpNxynjnTf3g7dPO/fGgTlMWPAuyNIVdPMDfEALQ+qEEpuGhP
	aouhppfL13r4tFGaJ0CiKHLjvRGGYI+QcJGE9FlTx4aQ+5czL0fCSXmoQKBCJz5pIhnkaI0yxgg
	lbmhQoannckFkK8loUT09V+mCc28=
X-Google-Smtp-Source: AGHT+IHWhdZFD7WHsM8niOtNNoDGNuAUCKrnom34fCn8fn3DaGfURj5EVvwpoEudWkzw8LBLHM7XZYcXogMX1J2i4sc=
X-Received: by 2002:a05:6871:5825:b0:25d:6ec2:b16a with SMTP id
 586e51a60fabf-25e2bd8b3c0mr1939963fac.29.1720119454672; Thu, 04 Jul 2024
 11:57:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZobXdDCYBi8OM-Fo@zx2c4.com> <CAHk-=wiGk+1eNy4Vk6QsEgM=Ru3jE40qrDwgq_CSKgqwLgMdRg@mail.gmail.com>
 <Zobf3fZOuvOJOGPN@zx2c4.com> <CAHk-=whf2Pb8fSmUsLRSn6CnYvQoyUkLikKpFDWN_xnTJqix=A@mail.gmail.com>
 <CAHmME9pm+ZE2_qf1DNxukB6ufPrjTAsnwin05-VX_gS03Yq-ag@mail.gmail.com>
 <CAHk-=whTjdO6szgRKp51ZeDLDmA1+YYSbg+vEUt9OsxTMDUtjQ@mail.gmail.com>
 <CAHk-=wgqD9h0Eb-n94ZEuK9SugnkczXvX497X=OdACVEhsw5xQ@mail.gmail.com>
 <Zobt_M91PEnVobML@zx2c4.com> <CAHk-=wh47WSNQYuSWqdu_8XeRzfpWbozzTDL6KtkGbSmLrWU4g@mail.gmail.com>
In-Reply-To: <CAHk-=wh47WSNQYuSWqdu_8XeRzfpWbozzTDL6KtkGbSmLrWU4g@mail.gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 4 Jul 2024 20:57:23 +0200
X-Gmail-Original-Message-ID: <CAHmME9pgFXhSdWpTwt_x51pFu2Qm878dhcQjG9WhPXV_XFXm9w@mail.gmail.com>
Message-ID: <CAHmME9pgFXhSdWpTwt_x51pFu2Qm878dhcQjG9WhPXV_XFXm9w@mail.gmail.com>
Subject: Re: deconflicting new syscall numbers for 6.11
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: jolsa@kernel.org, mhiramat@kernel.org, cgzones@googlemail.com, 
	brauner@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Thu, Jul 4, 2024 at 8:52=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 4 Jul 2024 at 11:46, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> >
> > I addressed this in the cover letter:
> >
> > | How do we rectify this? By putting a safe implementation of getrandom=
()
> > | in the vDSO, which has access to whatever information a
> > | particular iteration of random.c is using to make its decisions. I us=
e
> > | that careful language of "particular iteration of random.c", because =
the
> > | set of things that a vDSO getrandom() implementation might need for m=
aking
> > | decisions as good as the kernel's will likely change over time.
>
> Jason. This smells. It's BS.

It's not BS. And that's not a real argument from you, but rather is
something else.

> Christ, let's make a deal: do a five-liner patch that adds the
> generation number to the vdso data, and basically document it as a
> "the kernel thinks you need to reseed your buffers using getrandom"
> flag.

I really do not want to expose random.c internals, and then deal with
the consequences of breaking user code that relied on that. The fake
entropy count API was already a nightmare to move away from. And I
think there's tremendous value in letting users use the kernel's
*exact algorithm*, whatever it happens to be, without syscall
overhead. Plus, this means further proliferation of bad userspace
RNGs. So I think the deal is a bad one.

> reason why that doesn't work, I'll take the 1000+ line thing

(I would like to point out that a good deal of that series is test
code and documentation and such.)

Jason

