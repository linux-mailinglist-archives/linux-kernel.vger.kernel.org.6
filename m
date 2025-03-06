Return-Path: <linux-kernel+bounces-549718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95212A55663
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD6551750BC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6C526D5B8;
	Thu,  6 Mar 2025 19:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gomA5s6L"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EE019E99E;
	Thu,  6 Mar 2025 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288578; cv=none; b=mjqsx4h5ssk9tm6/uNn2f8ffNyIBZtujowU2/dAGISxB0MR72Km/v9bbAgob2pW1ff++q05zy75HZU+AcKshsbrAL3jktZVn3IiXM+fdkdWv20MtXaOpxRZXwW3A2VdaGAdrc+xkmJuFxiEvTquK66sjDrITiIRGT9xLcaemRTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288578; c=relaxed/simple;
	bh=q2hPBFkNdaK4S3iQuw7LOrhtKH0/q3Oertms5sis28U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b95H2r/T0qetuNDzgb3Q4syEbR8/UE9HVz8fM3Q8bSO94J9nyrEG2GputKw7k3Dr18PkfC/41Tu31o28HoIcokiqYz3wpwtMu/ouC4+N6qzkvIJNOiVvYwtGBef8G0FgoHD1z4hC1/yua/eHol3kwU/QVst41TV8T+qSIgurGHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gomA5s6L; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30bd473770bso10262051fa.3;
        Thu, 06 Mar 2025 11:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741288574; x=1741893374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zWv5vfgOjb/x6VCa5m+Ij1S1ZZkHOGvhDIcER6Dvj4=;
        b=gomA5s6Lrb1MJF8B2Wf5d97pHJJgFfipQmMiJTi8JsDo4lTBW0BwvHp7mJQoYA/PXO
         kKenyo6OPIywp3g1/5cu5HC/SQprfM+BxTuKhExbd3U4l5FxWPtQoVTgIm9Hd1R6l9HY
         cFzPkOptEUcG/mYigi5hOddvYD7Sd1H/GN6pKw3Z+qLZM20Zqq6vXZDGS32xKYPshFSQ
         C8OqszrCCgZ6sbwMamKih/LGYlxuswg2a0CX42NLbvQCgs7w/sZxzk3VKbmOWJfCk0dd
         i71p9KvAUX0QJkP5LDpF/owdEt5HF6OZBVGr7hodNNRMFk7fd49MRB14E62+RrkY1YSc
         0r6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741288574; x=1741893374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3zWv5vfgOjb/x6VCa5m+Ij1S1ZZkHOGvhDIcER6Dvj4=;
        b=m8TL3rnrQJW1vd6oGk+J0zEILnEUFQBMBz0SU1WAaaLnTOrb3CzNbSTeTBTbSvOlRA
         wPiWoQ7b+Af14fqtxe19GaLl68w3dRPq9GMJQASPkvSlidEhMuL4BkXJMf6fxYgFE4S5
         2pWgBWAZuEFxIN05rLtNO1hqAxPWUXfs/A6HXO1t3X55asv9U0YlhFN/E789gvf1sfET
         ix23HcXX/YWZ7uO5VrVSWR0mnqyLj9+4A+0228tS0lt90FPzp/h75HL5En59Pkl+lfxZ
         +EAVgLnfGudFKoJ3JnQEI2CGw887F3HfziTjVgzhyNfTquEIbmjmn/E91Zf5sOzjS1q8
         fDgw==
X-Forwarded-Encrypted: i=1; AJvYcCV+IhBVDupLu/Cr4tb/rupsOm4FLjSWrPX2zBg8e9d7oh61jHDapSnCZFPC2D9coerwUOwBpdRBwDHrb0QjQmA=@vger.kernel.org, AJvYcCVndWQoTpdAIG/YQH4uJEZ/lnil22sF3VGFzadhtDly+WUZpSZjHywTSr/MvkCT5vOdmQHbW2r3mIw8cTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwQOkDw2YD/xo8beKTW5NVvSHj4uzQS8GVWvbNbwutyNCA2sS5
	vNTtYD9by3Zz84Sz1GLozezpH0IqQiPUY8tjbKh9bP9Cn1dg7iBugy+lYspWErvTvXx/QB3OL1Q
	e/fiLZWXT8V0qAtIuz+Ysgznwv8/yDs9d
X-Gm-Gg: ASbGnctXeGgRf035V4bzYkTHmR8aJas7CsPjVP/ZT87KvNbHBdVtHd+YUl8vaLmf8qh
	irngJ1CtfVvKzirIBsVwRmzafyr5WsYKuaBfLBBfeBYKPgMtQxuTRJa655+2PPS4SmIyBrfJwUA
	YGqYoXoziFzojM+VaOprCSC0tqSg==
X-Google-Smtp-Source: AGHT+IH0/6rfvsSTjj6Oho1kqCGlqCatvY17T4k/5nKHZE91YXjib3mpD3ttoqN2cRr2pmaWptEyM20iYuRcS8FKznI=
X-Received: by 2002:a05:6512:1245:b0:545:5d:a5cd with SMTP id
 2adb3069b0e04-54990e2c073mr127331e87.6.1741288573786; Thu, 06 Mar 2025
 11:16:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
 <5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de> <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
 <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
 <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
 <m4cbniqfsr5xpb2m7k53e7plc6he5ioyl2efiiftdmzod56usd@htwdppje6re5> <CAHk-=whEkEsGHWBMZ17v5=sq1uRe6g-BRHy5xNZK-2JBKRs=_A@mail.gmail.com>
In-Reply-To: <CAHk-=whEkEsGHWBMZ17v5=sq1uRe6g-BRHy5xNZK-2JBKRs=_A@mail.gmail.com>
From: Ventura Jack <venturajack85@gmail.com>
Date: Thu, 6 Mar 2025 12:16:00 -0700
X-Gm-Features: AQ5f1JottkKmRWm9d9-3BOGDaY6aX18jU7z4bz0wmQr9-3z_OciBPEKZEX-A_TU
Message-ID: <CAFJgqgRxvUqvgC30Y_n2jOppUH47r=heSYpJb7FiMyw4miW4=w@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Martin Uecker <uecker@tugraz.at>, 
	Ralf Jung <post@ralfj.de>, "Paul E. McKenney" <paulmck@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Gary Guo <gary@garyguo.net>, airlied@gmail.com, boqun.feng@gmail.com, 
	david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, 
	hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 4:17=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 26 Feb 2025 at 14:27, Kent Overstreet <kent.overstreet@linux.dev>=
 wrote:
> >
> > This is another one that's entirely eliminated due to W^X references.
>
> Are you saying rust cannot have global flags?
>
> That seems unlikely. And broken if so.
>
> > IOW: if you're writing code where rematerializing reads is even a
> > _concern_ in Rust, then you had to drop to unsafe {} to do it - and you=
r
> > code is broken, and yes it will have UB.
>
> If you need to drop to unsafe mode just to read a global flag that may
> be set concurrently, you're doing something wrong as a language
> designer.
>
> And if your language then rematerializes reads, the language is shit.
>
> Really.
>
>              Linus

Rust does allow global mutable flags, but some kinds of
them are very heavily discouraged, even in unsafe Rust.

    https://doc.rust-lang.org/edition-guide/rust-2024/static-mut-references=
.html

Best, VJ.

