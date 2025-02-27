Return-Path: <linux-kernel+bounces-537022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CBBA48723
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 822817A62CD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995291EFF82;
	Thu, 27 Feb 2025 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQ95vmda"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6521E51EC;
	Thu, 27 Feb 2025 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740679148; cv=none; b=JvZxtvO/D/ihRtHDrqh1nAOcmdn3XTB0JRB5C+3x+7pMv3JWSGTORcvGatKHkqkJ9Fo7nzaNRVygeNHHLs10cTRnthptS6DwXAtgMEwmwen3yg6tkKiinyVXpftkueHzsTfAy3KHVsFnbAys6KafTTrKk6rLLIqdJ3OD4STJ3qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740679148; c=relaxed/simple;
	bh=wFHypZ9aXeGy2H0u0DN/smAKx66S6IqcKlu7mbarYQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mClvXefnfvdAZrcQBOqyis3HF8X0zI+g0Y87sw6RtYWrV0ZtLVyG0Z3Os8EQIQx0M7KJ/X2TNC4bxQPIt9OmD4B2ihTyD729+i9+bqiCBh9PlNMTPn0B0uD+0tbZBlHPmqWrFiaEyfAbv5mQko1tdjJRY1BOxMKPz4W3cCUanrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQ95vmda; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fe99d5f1e8so320836a91.1;
        Thu, 27 Feb 2025 09:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740679145; x=1741283945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFHypZ9aXeGy2H0u0DN/smAKx66S6IqcKlu7mbarYQM=;
        b=DQ95vmdaG5DrBp3zDX/xi8OOp6S9pRMsie1UNkRnBUkh8Mv5Jyl7fiypLTrqFB9Yt8
         Zc8my95YNakq852MShj+3OPofVzP1a3YwosFKwXHIDEZfdPg8uRluZQHtIXOcaJ0qlKq
         ygHi9EYkmoFyUiQkcdJvDdcwlcXJkYHuXrRosoNOBcbLtzTV/5Xtwnnvk2C61eXFxBRF
         ME6f9z1QK6cE4+ywrNpjLfKl1ATk4XEsPFvYc5K3FZWJ6jrFwxi0Akwq61BDGSY7BWnx
         SKGNxBD4VbP0HEXPWBRF2BkcSN423df4HHgvsKaNC0D8zrLgLyNVasNwXqyXqdVHH0sl
         mt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740679145; x=1741283945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFHypZ9aXeGy2H0u0DN/smAKx66S6IqcKlu7mbarYQM=;
        b=IQjLo+JBboVwABWueX7OSYUdjSE8ThOfssKsdXa4YNln6yqEKAo3DZehKgEBjm4NOb
         ocYl0Q+xRGNwEUknNcX44JVkhWPaiPuVdlSGY/wSmIZfZsy3NENZDKrqMtHpBA4aD8if
         T0NkX4RqfqBpII+Bb+blqNDRhy7I75SaoP2tov0oTqfi1yauIuT9KwDZTHEVy8vSN67S
         pLSa0AjH+7sQ/Uqytdk8LRWh9vzf4azufuv50D4l2PLkmOCBXcqoau3UQA83RSa77dVa
         MduCdVgxJzABbJ5ljqJ3p6JJuuIP907EYVLDACKp6EENfLqUlPaVQHiouWdS6iXl1Nsc
         j9eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgGlifFePpCvDxPHD/xsdNsYN3isykuTDaFAyUoR6j8ehC1jYjj9m/tVExnT6lL7tnLYaKS3iQ/XqWonI=@vger.kernel.org, AJvYcCWV/tMewvisCFUzunvkXf5lOmgZBq5APRXrUGAVQt/BLH8QnbFmrsukdG6Ca2Fim0IBaecdEOGX+m25a6LiL2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu7Sb5P4wHdqIk0G2RCAMJn/E6zNoyw9RDdt50HmF1H7u8R+kN
	ucGsZugRr96GciPi8pRTCU59a4pMJb7Tg2I2Q6wpQLPzvp6HuoEz6LknwPNW5B/AUuH9SXwJbaZ
	6B8bFz3zlN4uqjEX7bQGOw/1g180=
X-Gm-Gg: ASbGncs/ZHNRDIa/BbIKQrWl2yJ78pt7owoFXTOLC3D0nEHQbH0dDZeKn9h1SrJ9Gfe
	3TeCk0P4oH5f7QsaCUy2dU9VNCthAseZCOWJLgyrBppU0C/RwJL3HXF++BwxBfqh/+R0bV+UC7B
	wiYk8i5oA=
X-Google-Smtp-Source: AGHT+IEKP0WngFhSFv5HXyTS5ELtJf8myg8BbfACuEnuDF4I0HhFrREvIFttA3H3voCU/rGm7SEmt3dcOQN+bg43agM=
X-Received: by 2002:a17:90b:4a48:b0:2ee:cbc9:d50b with SMTP id
 98e67ed59e1d1-2febabedde2mr129657a91.4.1740679144947; Thu, 27 Feb 2025
 09:59:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CANiq72mdzUJocjXhPRQEEdgRXsr+TEMt99V5-9R7TjKB7Dtfaw@mail.gmail.com>
 <lz7hsnvexoywjgdor33mcjrcztxpf7lzvw3khwzd5rifetwrcf@g527ypfkbhp2>
 <780ff858-4f8e-424f-b40c-b9634407dce3@ralfj.de> <CAFJgqgRN0zwwaNttS_9qnncTDnSA-HU5EgAXFrNHoPQ7U8fUxw@mail.gmail.com>
 <f3a83d60-3506-4e20-b202-ef2ea99ef4dc@ralfj.de> <CAFJgqgR4Q=uDKNnU=2yo5zoyFOLERG+48bFuk4Dd-c+S6x+N5w@mail.gmail.com>
 <7edf8624-c9a0-4d8d-a09e-2eac55dc6fc5@ralfj.de> <CAFJgqgS-S3ZbPfYsA-eJmCXHhMrzwaKW1-G+LegKJNqqGm31UQ@mail.gmail.com>
In-Reply-To: <CAFJgqgS-S3ZbPfYsA-eJmCXHhMrzwaKW1-G+LegKJNqqGm31UQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 27 Feb 2025 18:58:51 +0100
X-Gm-Features: AQ5f1Jr5x77fYUaMBG1Lz2wlsPD0ugqjQLLdlTB5193Be51NeSn-MP9LKAUdkwI
Message-ID: <CANiq72mw_zo4ai7QWD5eLN_oFXE1RVkotFsGS+f=6LRmJoHM7Q@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Ventura Jack <venturajack85@gmail.com>
Cc: Ralf Jung <post@ralfj.de>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Gary Guo <gary@garyguo.net>, torvalds@linux-foundation.org, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 6:34=E2=80=AFPM Ventura Jack <venturajack85@gmail.c=
om> wrote:
>
> I have seen some Rust proponents literally say that there is
> a specification for Rust, and that it is called rustc/LLVM.
> Though those specific individuals may not have been the
> most credible individuals.

These "Some say..." arguments are not really useful, to be honest.

> A fear I have is that there may be hidden reliance in
> multiple different ways on LLVM, as well as on rustc.
> Maybe even very deeply so. The complexity of Rust's
> type system and rustc's type system checking makes
> me more worried about this point. If there are hidden
> elements, they may turn out to be very difficult to fix,
> especially if they are discovered to be fundamental.

If you have concrete concerns (apart from the ones you already raised
so far which are not really applicable), please explain them.

Otherwise, this sounds a bit like an appeal to fear, sorry.

> You mention ossifying, but the more popular Rust becomes,
> the more painful breakage will be, and the less suited
> Rust will be as a research language.

Rust is not a research language -- I guess you may be including
features that are not promised to be stable, but that means even C
would a research language... :)

> Using Crater to test existing Rust projects with, as you
> mention later in your email, is an interesting and
> possibly very valuable approach, but I do not know
> its limitations and disadvantages. Some projects
> will be closed source, and thus will presumably
> not be checked, as I understand it.

Well, one advantage for open source ;)

> Does Crater run Rust for Linux and relevant Rust
> kernel code?

We do something better: every PR is required to build part of the Rust
kernel code in one config.

That does not even happen with either Clang or GCC (though the Clang
maintainer was open to a proposal when I talked to him about it).

Cheers,
Miguel

