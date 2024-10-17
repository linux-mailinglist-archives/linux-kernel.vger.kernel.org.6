Return-Path: <linux-kernel+bounces-369862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2D79A23BE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB763282D4B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746281DDC24;
	Thu, 17 Oct 2024 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YK9wy9xt"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9711DD54E;
	Thu, 17 Oct 2024 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171462; cv=none; b=UvCLs/aBqqnY12JBpUfoCkQLMA0SeLL19YGfLsCX1+IXasVqkPPkTPjdlfb6535Hub7+6l7s9VLUEnsWos10gLTHw/pNsO2UUqKFuuER/Agi/A4CbrJlZ9HFd4ZUEJEePjpGY3xsm1FOmUHO/AEH7tfDFBiFmLNOg+F7Z5kQ4oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171462; c=relaxed/simple;
	bh=AwfeuT+5+2+w/3J2up9DJz2hLy/0MT2GzA1McZFVhGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLRGqYyUgAhqZa8NPqLK9EU/mJXBGRcBby+fytxQ/rxEavzXVQsq3bmlX56+G2rfYch7j99xeaqfdwCEQhrkXvfrOau9O+Wa8Ou5d2NWfYyFivzflyroxrymzzhI3bkBTnMNdCfcAw/bK2byq37xTxmJ/z1evZ+229Gw5jSwcU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YK9wy9xt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cf3f68ff2so881705ad.2;
        Thu, 17 Oct 2024 06:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729171461; x=1729776261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwfeuT+5+2+w/3J2up9DJz2hLy/0MT2GzA1McZFVhGg=;
        b=YK9wy9xtGqtX8XVER17yscKj1aN4yRqXse0+xUlUsxKQedg+gDOqSNxsKvknVZoeQE
         Y0u/yjPbXnou6d5zjncEDdYZo819F1B+LU+Ktbrpk0mBnV9gonkSQjNzkZ3YWZ1Vq/Co
         5wce7FmtA2y5WCl6Y5ym12eZb79Fh43lgwomkGFI4ulq2HLefXBxpa3/R5UKGnu0WSeJ
         5jIG+uFcbcyAcXV5e2/fB4K/dZAnJ0jnvfomxr1UL+CzUb/RZ3E/6qBUEOoxNfk/KtHj
         DOY8bIF4CKP4kQ5tq74+qk0eNzZ3H2FJa/iNRv17gOQFNtvk0bJouX90Ncnf1Wfm49ld
         Htqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729171461; x=1729776261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwfeuT+5+2+w/3J2up9DJz2hLy/0MT2GzA1McZFVhGg=;
        b=U0PtGyiv/ZTvvp11ZVLwoKJTO30OJvcsdXqTOAhpZ9/KZcTwwQrM0NP+Y/tv1j/rFw
         msYNNXIiZCXTbgH/a7umEBxu30Kvqnya+UnosN4QrnpLMtc/xomsfhjFrJLBZ0T82h2J
         XvAJJ4EOWCteg+FDzslYlaN2e9iUiksQbe9ifqaxoWsGYSLtjoiX2lFcjuliisph53dQ
         Lw51wDnuJdO7XvZF71NHyVt32idqL2NvVvXsqU1rGHwcomet/wD+HKUsmZF8Px4SFJPB
         4lkx976Mm3l8E+Z3yYLQsv4B8b1BJNTcLKfkKvxfd/fEX+FaZIqNfhIaL4BC43AKJrrj
         aWOA==
X-Forwarded-Encrypted: i=1; AJvYcCVx8F43UJaCTfB+ayhYvFypXZrdZWvJwLoGN+tWZyQtI01fV7qPqRKJCTEESDJ7f6yXbr0M3gB8sbBFY7MY7GM=@vger.kernel.org, AJvYcCWnu/dwEDpJeY6+46+fZ2sQAA1WNBXXUQJRP6wWBlKxucVLy4JRsmMGCzqWmEfBG1Tsfw/7w0Mx79FxGBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRsXr4/abjpNKVi7X3vuYOzVQH5dkPUfWnnfo18RT/MPnX/R3P
	7PkE7Ml9QG2s/QZlIMuQ02nQq/nUPd4koRPIAfvSG6UOVYqyoYAy1aAOoHIrjR4gGRlwfn0aq5I
	zzZzNNXHNdt6cyW42I1T6Z/Lllds=
X-Google-Smtp-Source: AGHT+IFz4NYl53lMRUd7X+IJa75+Rd9AY70/7Q6RUZweh0EkKg+FuS9yQF0yU7jF/tMo5iOcZjfVjqY1T2wgPBu4FHU=
X-Received: by 2002:a17:90b:110c:b0:2e2:cd6b:c6b8 with SMTP id
 98e67ed59e1d1-2e3dc2a4054mr1725298a91.8.1729171460727; Thu, 17 Oct 2024
 06:24:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014195253.1704625-1-ezulian@redhat.com> <CANiq72n5cPxDORQad2_fJPHXaE2YDHW3enavjWyz1MZBU3oasQ@mail.gmail.com>
 <ZxBXDhZXNgCwAHzN@f39>
In-Reply-To: <ZxBXDhZXNgCwAHzN@f39>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 17 Oct 2024 15:24:06 +0200
Message-ID: <CANiq72nqPN64KQat2VhC5EcVBxvNF18Hi19FPz24fqjpaj2LJA@mail.gmail.com>
Subject: Re: [PATCH] rust: Fix build error
To: Eder Zulian <ezulian@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, williams@redhat.com, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 2:15=E2=80=AFAM Eder Zulian <ezulian@redhat.com> wr=
ote:
>
> I can fix it and send a v2 if that's ok. Is it valid to add two 'Reported=
-by'
> tags (Clark and kernel test robot)?

Yeah, I think so, at least if they were independently reported. Please
add a `Closes` if you have it for Clark's report.

> Agreed. We don't want code replicated. In my reply to Boqun I added some
> notes. If that makes sense, we could avoid even the helper in
> 'spinlock{_,rt}.h'?

Hmm... I am not sure I follow your reply to Boqun. In your version,
under `DEBUG_SPINLOCK && PREEMPT_RT`, you call `spin_lock_init`, but
that means we are not passing the given key but creating a new
static/single one, no? That is why Boqun mentioned that.

> Please correct me if I misunderstood. It seems that Rust doesn't have a
> pre-processor step to replace macros in the code and the Rust compiler wo=
rks
> with 'objects/entities' created for functions and variables, but macros w=
ould
> be ignored (since they are string substitution.) Do you have pointers for=
 good
> docs on this?

I am not sure what exactly you are referring to, so perhaps this quick
summary helps (apologies if you already know all this!).

Rust does not understand C, at all. So we use `bindgen`, which is a
tool that internally uses `libclang` to parse C headers and emit Rust
code to use them from Rust. Clang (of course) knows about macros and
can parse them and expand them etc., but those macros (typically)
expand into C code, not Rust code. So (typically) we can't simply use
the macro because it does not generate valid Rust code. Thus we use a
C source file to declare helpers that call the C macros (which is fine
because it is a C file compiled by a C compiler), and then we can call
the C helper function from Rust.

The problem Boqun pointed out is that, now, since you introduced an
extra condition in the same `#ifdef`, then `spin_lock_init` is also
called in a case when `DEBUG_SPINLOCK=3Dy`, which means the key that was
passed as a parameter is not used but the macro will provide a new
one.

Does that help?

As for docs, I am happy to point to some -- do you mean on the Rust
side of things?

Thanks for the patch!

Cheers,
Miguel

