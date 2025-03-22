Return-Path: <linux-kernel+bounces-572403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E150A6CA03
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E0D883BB7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 12:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9AC1EF38A;
	Sat, 22 Mar 2025 12:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRmr/0z4"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA6D17E0
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 12:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742644942; cv=none; b=OmxXUVFMXmPg5kXrzF/TMW04VqQmohyzRw8HGOrgyZQhNN5e52A2WM8Dp9PFq9lB3SKzBoGYnaFw6F6dpebnA2NCAkuOuJOLo5sAGnVWFHyaO5AXerSWxQaIvBfv9M1HGd8uM9Qh/2T4nz1Kds22SeAZUNEReyud4Lr1TGOsCnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742644942; c=relaxed/simple;
	bh=dJbr/+xbd2tD9DFz+WgFGuMH+D5ajrVlrfrLESKBtaE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8i7yezQNHV5FzR2gfGzbWwTPnLcwRpbeQCWoApJpCqOF8X97ktEMz1CNneu/AybOJDcDlaGw3VkXdjLOk5dHTuxP5Tf2LcLwhw8IuxTFB57I5TRbZkq7qdJ2xTvtv1D+BHQMpyUt/x23ZrBAaceewqfnMas2j0LlVt11JdxdS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRmr/0z4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4394a823036so28258505e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 05:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742644939; x=1743249739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYbsuPyU4m6K394Fk+cbUBhjL1OliK8MPdiQnerVR+k=;
        b=LRmr/0z4aBHWprHAHRWXJUp/aIJLE9v0JivMA8UVJBYjP/e5pZs5Xi8odaX8Q8+JXA
         zFaUcRE9B8hEArpvK+kFRDjwSWMuto4bOuG/d+a7aOVMo38rNOuaxkaxlE3cbZftHdt0
         BA6yclLqrOo35foj+9Raj///kJ5kJiP+3rDS03LBtRSKw7Ah9i1g/StrYCSv+qvuispf
         2snFkBbGGfLoZ3ZOCpVilw+y00nMVpB6W5ZGtV5B6vESyRr5X9HrhBaf1JvD8yYR1jBq
         k3m7ZVYUSjPi22mg/j2Fuc+5/KVDbdnsXvfoVrg5arvZbMwI6Jczs9HaruGrwph+MP4X
         evjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742644939; x=1743249739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYbsuPyU4m6K394Fk+cbUBhjL1OliK8MPdiQnerVR+k=;
        b=k+2+ucvIjQblJsYKKXmqyEVnHk4TsfsSyw0wjlJXBrkJj0aoYdnIeX6IPybVw8aoH3
         glxDLCu4IYPBVwbbAQSYy2RrCXKDIEH//dRMVO1p4Li6Cy7k4b1Nfp+clDY2No3bguvS
         0zr7eLKMb40qjHy5GZ1o7j048GobG+iRntSk4dK+85ecwa0SXp8zc/eQ04PX71/PawFU
         OmGFKnELkltoKcACrktj9rD+wUrUYoASuyt+lS23xRpaL/gkUU29xAKEfps/ZBlv6Fm9
         w8vjCEnfkeyr4ebF/5tN2vrPACR/DlUu96FA/M169/VcqYzP4a7xDfsGawLTVGoR19KQ
         QpDg==
X-Forwarded-Encrypted: i=1; AJvYcCX48g+KyjRV/oRastRNy6tA3Qx0MuK209tZCo0Wn0aj5hyY2MTAnhJJBkqh3ypgsQ5DnXoFafsue7BcRzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBqqyGzwjlY1w6vo5l35esZt3x8PNK1efPoEC+/F1ZDwyzK7RX
	MiUa7/6CPeBVX+qDLpid4RT7lh8Xm9qLi0unU8f4CdZCDxhwgbze
X-Gm-Gg: ASbGncuhEqUit9rrmvZrPr3wZ0HM51u5UwtEfYMJ7MKkMDuZ+PmtZKoOkhu17BqRsEN
	gENIImHFltHQey/+pWRx2y3bMiYmkxrvFhEWdrCUQtfTUXj4LmMEquPyrvZle3e+N2dCr7okZuO
	Kaneh+dHrMXACBnmor8d33+Z1NdCkyVXrrvU/qSQkx/FHAHRXe9s5Zf/pnQpeS2el/YP3NBNRKQ
	aifhonif8l4EljCVTrT7/0lcaz7cIr6keTI7OfIJLXuUD1NKtLHboQfHoXVvNL0h4Pl58LvjTT9
	4W0rz2KokEyz9qYAmEENIRKJQGyOLD4zsJ1FsNxQOcJRrko4Hq7JFEBQpm+sGXpow+DlnNK2l4n
	QS5m7Mac=
X-Google-Smtp-Source: AGHT+IHawvyD/6qm9CmF5fyE4A/k5X8DwcgLZa0UiCzozXfHeWI1TD8+7xmEItYKcPg/g14Dna16mg==
X-Received: by 2002:a05:600c:4f55:b0:439:9b2a:1b2f with SMTP id 5b1f17b1804b1-43d568cdf1bmr43793395e9.3.1742644938659;
        Sat, 22 Mar 2025 05:02:18 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d440ed5e0sm104921415e9.37.2025.03.22.05.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 05:02:18 -0700 (PDT)
Date: Sat, 22 Mar 2025 12:02:13 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 hkrzesin@redhat.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, olichtne@redhat.com,
 atomasov@redhat.com, aokuliar@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: handle the tail in rep_movs_alternative() with an
 overlapping store
Message-ID: <20250322120213.1420450a@pumpkin>
In-Reply-To: <CAGudoHFqGfiGPf2ZkVeAqco+0BD2G72_TSGCz29dP_tvwQN0NQ@mail.gmail.com>
References: <20250320190514.1961144-1-mjguzik@gmail.com>
	<CAHk-=whd82fzhEbFRw9d_EMtR1SeefOJabjCHcm4-6jzeqqd3g@mail.gmail.com>
	<CAGudoHGNFT+LC24842ZKLWBxD3vvvddBqDKa6gkixN4Esor+RQ@mail.gmail.com>
	<CAGudoHFqGfiGPf2ZkVeAqco+0BD2G72_TSGCz29dP_tvwQN0NQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Mar 2025 21:24:38 +0100
Mateusz Guzik <mjguzik@gmail.com> wrote:

> On Thu, Mar 20, 2025 at 8:33=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com>=
 wrote:
> >
> > On Thu, Mar 20, 2025 at 8:23=E2=80=AFPM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote: =20
> > >
> > > On Thu, 20 Mar 2025 at 12:06, Mateusz Guzik <mjguzik@gmail.com> wrote=
: =20
> > > >
> > > > Sizes ranged <8,64> are copied 8 bytes at a time with a jump out to=
 a
> > > > 1 byte at a time loop to handle the tail. =20
> > >
> > > I definitely do not mind this patch, but I think it doesn't go far en=
ough.
> > >
> > > It gets rid of the byte-at-a-time loop at the end, but only for the
> > > short-copy case of 8-63 bytes.
> > > =20
> >
> > This bit I can vouch for.
> > =20
> > > The .Llarge_movsq ends up still doing
> > >
> > >         testl %ecx,%ecx
> > >         jne .Lcopy_user_tail
> > >         RET
> > >
> > > and while that is only triggered by the non-ERMS case, that's what
> > > most older AMD CPU's will trigger, afaik.
> > > =20
> >
> > This bit I can't.
> >
> > Per my other e-mail it has been several years since I was seriously
> > digging in the area (around 7 by now I think) and details are rather
> > fuzzy.
> >
> > I have a recollection that handling the tail after rep movsq with an
> > overlapping store was suffering a penalty big enough to warrant a
> > "normal" copy instead, avoiding the just written to area. I see my old
> > routine $elsewhere makes sure to do it. I don't have sensible hw to
> > bench this on either at the moment.
> > =20
>=20
> So I did some testing on Sapphire Rapids vs movsq (it is an
> FSRM-enabled sucker so I had to force it to use it) and the penalty I
> remembered is still there.
>=20
> I patched read1 from will-it-scale to do 128 and 129 byte reads.
>=20
> On the stock kernel I get about 5% throughput drop rate when adding
> just the one byte.
>=20
> On a kernel patched to overlap these with prior movsq stores I get a 10% =
drop.
>=20
> While a CPU without ERMS/FSRM could have a different penalty, this
> very much lines up with my prior experiments back in the day, so I'm
> gonna have to assume this still is still a problem for others.

A different penalty for ERMS/FSRM wouldn't surprise me.
If you tested on an Intel cpu it probably supported ERMS/FSRM
(you have to go back to 'core-2' to not have the support).

So I suspect you'd need to have tested an AMD cpu for it to matter.
And the report of slow misaligned writes was for a fairly recent
AMD cpu - I think one that didn't report ERMS/FSRM support.
I've only got a zen-5, although I might 'borrow' a piledriver from work.
Definitely no access to anything amd in between.

I do wonder if the 'medium length' copy loop is needed at all.
The non ERMS/FSRM case needs 'short copy' and aligned 'rep movsq'
copies, but is the setup cost for 'rep movsq' significant enough
for the 'copy loop' to be worth while?

I also suspect the copy loop is 'over unrolled'.
The max throughput is 8 bytes/clock and Intel cpu will execute
2 clock loops, so if you can reduce the loop control (etc) instructions
to ones that will run in two clocks you can do 16 bytes per iteration.
That should be achievable using negative offsets from the end of the
buffer - the loop control is 'add $16,%rcx; js 10b'.
(I've mentioned that before ...)

I've just done some more searching and found a comment that FRMS is
very slow on zen3 for misaligned destinations.
(Possibly to the level of dropping back to byte copies.)
That means that the 'rep movsq' also needs to be aligned.
Which is what started all this.

I'm going to have to see if my Sandy bridge system still works.

	David

>=20
> So I stand by only patching the short range for the time being.
>=20
> Note that should someone(tm) rework this to use overlapping stores
> with bigger ranges (like memcpy), this will become less of an issue as
> there will be no per-byte copying.


