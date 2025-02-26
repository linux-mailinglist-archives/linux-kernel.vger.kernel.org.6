Return-Path: <linux-kernel+bounces-534909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29165A46C85
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A7116EDF3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDC8238142;
	Wed, 26 Feb 2025 20:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="x0KqG4eu"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3F84438B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740602099; cv=none; b=UyQAOB2KdFNjcFnWv0HfveZEtogrRz2dg9azSSPcr0uujFB4X/Q8dTk0VPyo7HleqfugKoeawPw3cdIWy0BltVsvf9+MVMqNjhYC6qhD1zE54pIgGLht/cF4KMPqOWXQ1/i3EB+sSBp3QVkkjNB5vmaErJ0WUOAqE/tKOQBQlyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740602099; c=relaxed/simple;
	bh=BsjkObCZOGJxyJ1E4M58vXDesam1iaUd49yxo0CQgKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mEmm0eipwWMXFmQwLpFVgUqa+1BznmQvar8z6S/Aq7G3QI93xz7CgSng6tJwtK0N/zafgxlKVGYZdzkLCNTE6U65h1GOkpk7Ex7Eah1q+JwCtuKvXje2F9wbL8JAxLhG3SlF/U/o4fSjl6E16wfSpRxVXG/0dL6f//bvN6K8Xmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=x0KqG4eu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abb79af88afso35125566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1740602096; x=1741206896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNNBNCG63y+hw99CeSG36gYBSbxZTQ5PMbvNbhu7Ucs=;
        b=x0KqG4euj69rKfVyohShdWWAch0lIlaBrDc83Vo7l6xTzathxENPWZpxN6MDpKyb1R
         4DexNKwQ3uD64I76OqqgihtVlI4xBB5T0Rv4qzjsGu6tjwL1a6vjWWoghB6uBPd3mRsf
         W+gpiZvvIZrMOpmSH5S+Ia8jds+hMGf2NXTK/GjKd5u51h+mXRtKiP4YHOAoRh2HcKe+
         A3X/vIx0mTpqEwDAlkRD0fsAl5/+R5fjJmwbhTL+MM9ImTDzNODkmeZBvKmZxneTXha2
         1JIqIczsdBMAz8jLfbem+B7U/Hdw5k4eTc1UoUlQslyABfCuuhIHRjIOkl5/LjqhoWbG
         OX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740602096; x=1741206896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNNBNCG63y+hw99CeSG36gYBSbxZTQ5PMbvNbhu7Ucs=;
        b=O6DOx/pZFC/7imgvwbJEvDhiCxtKbwVQWikQkmpjFsCjC7PNukGgCRxYFiGvqEnphI
         oZjoECb9gmk79ujsTQOdkD+eUWtindZRTKdys7cSE9mCutEvsV1AEXHPz0RpPaUyBgU1
         BEbqGDCd7nXqlMicEaObOI4wXeOje2dbPU6RLSfuAEb4+v9y7kfdWzAySL9zTIR/fBb2
         6DIaHylrvlwL6n4vrP0YUxR1DCa+RtQQDAsXgcB46eicocd2u+684rMcMUXmlB7JtgaT
         b1HAvs36f84M5ucdMMT/k5OrTxIWdNSl87URVCMF1SPY2uTApriuvmCIKWfJ3wMBCqSV
         7otQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtxC3pW17zcw7ZABFqN30avfHIEmGmMSOGMvG6nLS+b5KT2ymxHRAHqrwFst9IXOYzfs2IWutt6RugwZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY0Xu8KsndW+Qb5+jmKMPocu0EQQf93fw2bu5MCxbuwOlm0a0P
	OTQdGU72Jk6GJEF7AWCXAuqCcBdPBIudB20tPVfuz7KZ6T+9ROSrVPIy12Nu96QH98FWHszsGdh
	SEzYv6W1C/51VSW/StzsoZXsqsQ8tHPvNJmZP
X-Gm-Gg: ASbGncvnscIk9TfYvaMd33fwNmw9ntsuXg9DsBcX7ldEnf+DoTNprC4l0qpQiiyyrn5
	CaOpJygs5Zqxh8gP2oGL/HOarWdfFtbqgcoJ4LKxtCL4WcgNULSqmdKvRSCyxiKlHJZllqTvGtL
	E9D0e4kQ==
X-Google-Smtp-Source: AGHT+IEpD0bL4v9cVqbM+mXKhEESXlvA+VH0GzcrSUQIWZvKuDazTin9u4dr6k0WDBAgoL9Etj8BS5SONGwDZcdL8eM=
X-Received: by 2002:a17:907:c29:b0:ab7:86ae:4bb8 with SMTP id
 a640c23a62f3a-abc09a0bc37mr2387353166b.23.1740602096179; Wed, 26 Feb 2025
 12:34:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
 <5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de> <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
 <amebiomyty3gw7gwgpz3sbztzdac6ce2pslq3jjfe3no4w72dn@sskvzdp6l67w>
In-Reply-To: <amebiomyty3gw7gwgpz3sbztzdac6ce2pslq3jjfe3no4w72dn@sskvzdp6l67w>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 26 Feb 2025 12:34:44 -0800
X-Gm-Features: AQ5f1Jq-YVyDssbhA7TUSjB18AyuOEnmF5EUBN1uZ8DJs3k5rbz-GioqT3VdMt4
Message-ID: <CALCETrVc_eBjBSPy=nLHP7fh5h52u_wdT2YRnUZJDWmr-C2q_Q@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ralf Jung <post@ralfj.de>, 
	Alice Ryhl <aliceryhl@google.com>, Ventura Jack <venturajack85@gmail.com>, 
	Gary Guo <gary@garyguo.net>, airlied@gmail.com, boqun.feng@gmail.com, 
	david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, 
	hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 12:27=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:

> E.g. if you're doing a ringbuffer with head and tail pointers shared
> between multiple threads, you no longer do that with bare integers, you
> use atomics (even if you're not actually using any atomic operations on
> them).
>

FWIW, as far as I'm concerned, this isn't Rust-specific at all.  In my
(non-Linux-kernel) C++ code, if I type "int", I mean an int that
follows normal C++ rules and I promise that I won't introduce a data
race.  (And yes, I dislike the normal C++ rules and the complete lack
of language-enforced safety here as much as the next person.)  If I
actually mean "a location in memory that contains int and that I
intend to manage on my own", like what "volatile int" sort of used to
mean, I type "atomic<int>".  And I like this a *lot* more than I ever
liked volatile.  With volatile int, it's very very easy to forget that
using it as an rvalue is a read (to the extent this is true under
various compilers).  With atomic<int>, the language forces [0] me to
type what I actually mean, and I type foo->load().

I consider this to be such an improvement that I actually went through
and converted a bunch of code that predated C++ atomics and used
volatile over to std::atomic.  Good riddance.

(For code that doesn't want to modify the data structures in question,
C++ has atomic_ref, which I think would make for a nicer
READ_ONCE-like operation without the keyword volatile appearing
anywhere including the macro expansion.)

[0] Okay, C++ actually gets this wrong IMO, because atomic::operator
T() exists.  But that doesn't mean I'm obligated to use it.

