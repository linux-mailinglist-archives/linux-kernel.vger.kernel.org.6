Return-Path: <linux-kernel+bounces-364725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 244A099D86F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A753C1F24F1B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC301D14E4;
	Mon, 14 Oct 2024 20:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ze9hKPHx"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE271CF7D0;
	Mon, 14 Oct 2024 20:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728938340; cv=none; b=Jqn5FTB9A9yKpic9p3ZhStwAwa3nNcKisFWa7nQiMZqOc0CEjs3fHLhxu6B9pQJJt4eISkGHip0LgBWL90K4fX3+bdI+fiwD3nppYQfHSHNvzZw09Pw9bGXj4cAAa/YCLpli1q9UT3pM9q1wRwiUirwVTsDfJLgfsqjrtwxOJBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728938340; c=relaxed/simple;
	bh=LSwM4cSgwFd92iqw6QrKYcSWXzlyP/n+CPEjhVFGzyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msUVxBRbPiT9VrgrAZScAs5/+cNTFyjhb+kWAKcla4a6aqe5wmUvtI3ZJHRqDiGFI+SSkQIu4SSXOnYhdBDzyeZWgOW67WP+qMOe284OU6lp8BfBjyFhNrktoBDMcPqOP/MRqhD3LsN+2UEmIkMEJvsR+7zW15jvkonlk+p6LWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ze9hKPHx; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7c3d415f85eso513080a12.0;
        Mon, 14 Oct 2024 13:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728938339; x=1729543139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSwM4cSgwFd92iqw6QrKYcSWXzlyP/n+CPEjhVFGzyc=;
        b=Ze9hKPHxMYNd3YtoBbnzfh2M1/m64c/QSEDW4vG9fBhAQtpY+RhbKzubmGpkwRDRul
         /v+JTMITIQigp4PjwkwHOCZ1Q63VF4VH8i7XL18NOdIorj2FzKv6JBXtq4R95Yxwagnn
         NvwIfcGfPCaALZ06cPbXqYDA8ABCbr1go/ZSnEI8LOz/3pMLHdU1cz3l+MJ7nlYjDR9T
         nibfSQyd8BiYtgVrSHfPgdkIUQAVLW87+n3HKYxiQg9zXn6OUiDMFlvHORFBbURZ7hp4
         mtZ79Eg/gzlSmuee45Vz3aNRgEihPUT+E9BdW3oW1vgjbogOWFjevd4FXDib51asg1+J
         V+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728938339; x=1729543139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LSwM4cSgwFd92iqw6QrKYcSWXzlyP/n+CPEjhVFGzyc=;
        b=MQ0lJzcTt8/NkOzZ7BDdl6alGmgzIx83T1JsDPzfRnlvHhPFBn+QhfT6i1lmjWNdBG
         smAkHKl9fo5DX49pzyIVZpDhFEH4qI6DBBxOOyaAAMCwVVyArVbKKEtiwqnX4dP5s+xR
         DgW0a2uORVauCRjS4iHIncbhn976dOeGbncMXeymdzbpxRP6W2viSC25QgqPVSFHXNm9
         240Rnhon2/kjyJ8MyX7Drud1TS4/Pibjim2FkBZTsr5vHmHxuuuDyJ31g32FJjSKMzMZ
         08MRPFZh+pF6GwYNNnPFBxuNykdT7vCMrgHH4vLRkQTFjRUWWDSqK5ozOhXpkJH+ghhm
         yzBw==
X-Forwarded-Encrypted: i=1; AJvYcCUvWWFPkQgmLpuvg9qYJU1T0sSLFRuDBkWveq62228GheRd33uXRJDrvFHljsXfMj1dQroIikM+ZJQk2B4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn95b7Y7HHWqOn0CnOzqLs4Vtz33dIROYkQp31Ighxdd6W4l5q
	L2zb3saM6tuYBo5GrAMCReYfjsL4A0pShdVuFutPhZiSAubfv3LxTFkpyVain0CVD83rm6+xM92
	hIvvjNd9hXXixoIb0VW+G9LIdIgdSJLjiXQ8=
X-Google-Smtp-Source: AGHT+IH5v+EGJJYSy6AxI+TX8o2gV8lIGqTtRyt1pD2iF+3zRq0nrJ0M9Z/DtDebFPgIcBxVKl+8ABYrjwrHBXXrqwg=
X-Received: by 2002:a17:90b:318:b0:2e2:a70a:f107 with SMTP id
 98e67ed59e1d1-2e2f0a11479mr6947844a91.1.1728938338628; Mon, 14 Oct 2024
 13:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014195253.1704625-1-ezulian@redhat.com>
In-Reply-To: <20241014195253.1704625-1-ezulian@redhat.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 14 Oct 2024 22:38:45 +0200
Message-ID: <CANiq72n5cPxDORQad2_fJPHXaE2YDHW3enavjWyz1MZBU3oasQ@mail.gmail.com>
Subject: Re: [PATCH] rust: Fix build error
To: Eder Zulian <ezulian@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	williams@redhat.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 9:54=E2=80=AFPM Eder Zulian <ezulian@redhat.com> wr=
ote:
>
> Error observed while building a rt-debug kernel for aarch64.

Thanks for testing with Rust enabled!

> Suggested-by: Clark Williams <williams@redhat.com>

Do you mean `Reported-by`?

Also, I am not sure which `Fixes:` tag would fit best here, since
`PREEMPT_RT` has been around for quite a while, but only enabled very
recently. Thomas: do you have a preference?

In addition (sorry, it was in my backlog):

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409251238.vetlgXE9-lkp@int=
el.com/

Finally, I think we should perhaps put a helper in `spinlock{_,rt}.h`
that takes the `key` (instead of having this `#ifdef` here) and then
just use that from the Rust helpers, because we don't want to
duplicate such logic (conditionals) in helpers. And with the RT init
open coding that Boqun mentioned, even more. After all, helpers are
meant to be as straightforward as possible, and if we have this sort
of thing in helpers, it is harder for everyone to keep them in sync.

In other words, I see helpers as following the same "avoid `#ifdef`s"
rule that we prefer in C source files vs. headers.

What do you think, Thomas?

>

Spurious newline.

Cheers,
Miguel

