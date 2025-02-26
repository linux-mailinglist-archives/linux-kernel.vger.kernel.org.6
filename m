Return-Path: <linux-kernel+bounces-534233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E20A46477
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0EC23A430A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43215224891;
	Wed, 26 Feb 2025 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llvSPuGJ"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D518F2236FC;
	Wed, 26 Feb 2025 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583322; cv=none; b=isoNed9oNzeJX+pwm3k6hPy7znIIDeop72mIOpYJYHIZKhjPH3+dCRhjykHkARXJp2ZLjyQb+C3J+WOOveOTmxJUcWPLaNJCzMZ1t+beoUdQNGo7o7VbIpY+xFr9VAOSqMoLiDX6MxTuE3wFc5aZZWH37+P0bIiuYAXch3zEup0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583322; c=relaxed/simple;
	bh=yU8gNYOdF+KZIK43kgv3VmI3q8AVM3zFnCh57wmb8KY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lEiKFCt0SRaHJARfLEh5e1ROs95myX3WO9x0Tju3ug/jmxsufnx8WZTPWjLVra4tgnjcIna7EJLK+EX0+7k/Ct/dtEyxaC+ED2L7XHMIx6o7w8RPYz2LW4zQe41oNvWURsdABcnnRMt3pCG0ftRUZiY2fYsoKwzcK1JyZHkGqvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llvSPuGJ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-307325f2436so69631421fa.0;
        Wed, 26 Feb 2025 07:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740583319; x=1741188119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0hFN/Q5bioCyAT9aA3v+FnRq1GwqeK2EWDX0R9FPAE=;
        b=llvSPuGJkjn/55LU/xl80ez/vKWtscEIDVss8ebf5v8IoyycXJCcY4D04+1dzrN/pn
         Xccp7D5Kwy38Gocdcy4U3dmt9wJquT+3IH7gCq7a05daDctEM2HKQTlhyIvx5WzAyEXn
         MZ84ebYAFS5wH2woYIomueR66c+BIU3G4W7x3/9NxF9+zE43AMf4o4eElUtLATQ6Kzf5
         ybwejX4fhb0daCs329ytNJZJ8uSyEh3VxoRjpy0RUC4FKd8usP3PBlb9w4CgiqPZrd3U
         kW8M2GtOHwQjO/IwNUxrLYHs8LfUPL8UXm88PZhpomlw+S6HgJbfUoHrFyqBoUxA/dGJ
         sFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740583319; x=1741188119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0hFN/Q5bioCyAT9aA3v+FnRq1GwqeK2EWDX0R9FPAE=;
        b=EPj/oBwsOjf1vqDVLQspjdyKjG5ILOWSt8jadicn/7I3BZGMke0Vis1O2K1If1rbao
         QNtCnCbcKQO2H+yY+Q9fC9JiqulydQ65x8TT/hoSYqGVC952Fmm7TmNINDCkBjUW6soe
         CkzZCp92MVQ6hurrSDP/vKu4Dv/gZ5GJlNklDnjLvOXSZqatCixs7TYUd8IzV/K3xNqy
         uDWtEM+XE6dd6NWRwmPcgNJnD+y9W2FTXxZ2/2CE1R8aaBBlDal00cGOqs8QMTftgey9
         0BLpN1+Yj7ctKUKXYInt1TbP7t2kRbLqXc1KZKXRxPTA2vOuvplSgxcaW5Gkq2pc+e7K
         ldFA==
X-Forwarded-Encrypted: i=1; AJvYcCViCg5uZP12DEdU2e4y0bvifKn2k7/kPiH1O3SpRaOhHFDqsPuOFWLN7DaDK9AqmRcZkIQ303cSxEgySpTOnWE=@vger.kernel.org, AJvYcCX6xAgCmwPoZ43yM5M8J+AQ0CODXJjFBODOWPf59VPE9SobuwnI1GSvey0PikdW2TheAlHQXpm82DShxqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YznzDFTX+pBYgUPaHT3tMgGFekQpCt8wu8nRbtci3EFy1mmp+D0
	6NK3aR82YMc41AkL+G4sjgx2VCdbh3GK1S0/oR7TQrSaHC9un9kcZlJPuLK+XZxTer5ZZsqQrCV
	OSoZUBHvx8iZK5eW8TDPA1AisO8s=
X-Gm-Gg: ASbGncsKuEkXbBdKwO9vC5QIjSIETpN3FkIgZW5pIzwlocZrwdLCiYxfqm8MDR1rxGR
	y0FQm6O/XbqAejCvbuQN9zJKseQBYtuk+/fLWS2NyiSp13dPbcQ94umEEQoXUoONO/A/nFTWzIr
	6JVGWd7JQ/
X-Google-Smtp-Source: AGHT+IHyRHWjbncLImDyeksSRZpjsqLCk2gH0nyAOGo3WeXuQNL4gvXvxUYeo01VFKJKwqmTifGfFsF2qzF1qZIU/hE=
X-Received: by 2002:a05:6512:2314:b0:545:ab8:2be4 with SMTP id
 2adb3069b0e04-5493c57a2demr2783344e87.27.1740583318703; Wed, 26 Feb 2025
 07:21:58 -0800 (PST)
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
 <CAFJgqgREAj-eP-d244WpqO-9H48ajZh83AxE31GqoONZ=DJe-g@mail.gmail.com>
 <CAH5fLghEMtT663SNogAGad-qk7umefGeBKbm+QjKKzoskjOubw@mail.gmail.com>
 <CAFJgqgRxfTVxrWja=ZW=mTj1ShPE5s-atAqxzMOq5poajMh=4A@mail.gmail.com> <CANiq72mA4Pbx1BeCZdg7Os3FtGkrwx6T8_+=+-=-o9+TOMv+EA@mail.gmail.com>
In-Reply-To: <CANiq72mA4Pbx1BeCZdg7Os3FtGkrwx6T8_+=+-=-o9+TOMv+EA@mail.gmail.com>
From: Ventura Jack <venturajack85@gmail.com>
Date: Wed, 26 Feb 2025 08:21:45 -0700
X-Gm-Features: AQ5f1JqXNq_djDucaFz0JfQlyejxMXbHKVh9InZ_hpbly_lGP7oSWSDqQNXn0as
Message-ID: <CAFJgqgSzqGKdeT88fJzrFOex7i-yvVte3NiQDdgXeWEFtnq=9A@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Ralf Jung <post@ralfj.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 6:52=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, Feb 26, 2025 at 1:36=E2=80=AFPM Ventura Jack <venturajack85@gmail=
.com> wrote:
> >
> > In a preprint paper, both stacked borrows and tree burrows are as
> > far as I can tell described as having false positives.
> >
> > Are you sure that both stacked borrows and tree borrows are
> > meant to be full models with no false positives and false negatives,
> > and no uncertainty, if I understand you correctly? It should be
> > noted that they are both works in progress.
>
> I think you are mixing up two things: "a new model does not allow
> every single unsafe code pattern out there" with "a new model, if
> adopted, would still not be able to tell if something is UB or not".

I am not certain that I understand either you or Alice correctly.
But Ralf Jung or others will probably help clarify matters.

> > The aliasing rules being tied to a specific compiler backend,
> > instead of a specification, might make it harder for other
> > Rust compilers, like gccrs, to implement the same behavior for
> > compiled programs, as what the sole major Rust compiler,
> > rustc, has of behavior for compiled programs.
>
> It is not "tied to a specific compiler backend". The reference (or
> e.g. the standard library implementation, which you mentioned) may
> mention LLVM, as well as other backends, but that does not imply the
> final rules will (or need to) refer to the LLVM reference. And even if
> a spec refers to a given revision of another spec (it is not
> uncommon), that is different from being "tied to a specific compiler
> backend".
>
> Moreover, if it makes it easier, another compiler could always assume les=
s.

You are right that I should have written "currently tied", not "tied", and
I do hope and assume that the work with aliasing will result
in some sorts of specifications.

The language reference directly referring to LLVM's aliasing rules,
and that the preprint paper also refers to LLVM, does indicate a tie-in,
even if that tie-in is incidental and not desired. With more than one
major compiler, such tie-ins are easier to avoid.

    https://doc.rust-lang.org/stable/reference/behavior-considered-undefine=
d.html
        "Breaking the pointer aliasing rules
        http://llvm.org/docs/LangRef.html#pointer-aliasing-rules
        . Box<T>, &mut T and &T follow LLVM=E2=80=99s scoped noalias
        http://llvm.org/docs/LangRef.html#noalias
        model, except if the &T contains an UnsafeCell<U>.
        References and boxes must not be dangling while they are
        live. The exact liveness duration is not specified, but some
        bounds exist:"

Best, VJ.

