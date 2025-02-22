Return-Path: <linux-kernel+bounces-527447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B3BA40B5D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D19B189FD77
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7272F211A37;
	Sat, 22 Feb 2025 19:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BW2tEED0"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9854520AF7B
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 19:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740251936; cv=none; b=LxwjLNdLypN+B8+vWRs83/Y8WdNz+GsheJG0cYUb5C1wnK52CKUh5hau2VYIVRJTI3rf0POcJq1sgG25kDdJRCA0zmKgp8bzGzhL8X7Ew2CapA6aBBGhuH2B3t4yhiV+R5E2pjQfxMIU2UF5rKrXjGmBkvFGzAe7PzJHKMym2+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740251936; c=relaxed/simple;
	bh=EzT1g5FwFw69UDBYQDzjBiLobs2dYIYvZzFfhBYPdIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLOVTnbmknUDIv/hPxSknBBD4juAD4IHJa5mrlC7xT79PPtUH2eaE1Lme9OA9syC8vS//04VVB2VPs4DD/Wm2I0oVc3j8qaBMKA+PQLmPjRKknZWy1dNjpcR2xBEkSLbr+lhGQtjE50tU2HtMhPityaGwAFhy5kpScdWT48vPjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BW2tEED0; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abbdc4a0b5aso595292166b.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740251932; x=1740856732; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0Xzl2/w9nsMmIh5i8j2sKE6LkAdctHwz3MFgW7DcHyk=;
        b=BW2tEED0mTrUEiv0aL1fv0c3YLvKQUPVNpbRTurp1VlN7VkuifEAnneZj2E1Kc2UKe
         ECgoMTqe62cVnhXbrwdutYmNBt9He/k4V7QZrosfuSjbvyietcOx0pqM69lSF2M9+HbM
         rdq4vbpNU55rTPCu3P0cg4gJbVOvYD/mv2Xcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740251932; x=1740856732;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Xzl2/w9nsMmIh5i8j2sKE6LkAdctHwz3MFgW7DcHyk=;
        b=DJvECizNLyts6T3YEBuwkmZ3g7uxI8LeDQ9F01L/lkdC1zRz+EFE6rAhbNXPSe9Brb
         Qnu7gAxkNC7/rLg7WI8vJxpgp1nPSC1iUssuLIG+GETcg4JCRXbnFh/UeFioG9zLnPl/
         qnhDRkwzluvfmp55JXk48ZKTDzgNpe5WTssZuwcdT8l5Iw3sfV/MUDzvVgHUrMea+pY7
         +NXqzi0ryLszwUX3eMDGBb2PjbFg3J9zZbQrAu1sLUF7uYzaKU7EOPoO1/jwSYZxSyHM
         IG7a6P0n/x7t/cURKQ9/2UvDQVlDIOFfvNZuG5iasWNqQPFYih38IL58Hgjrl0fNBWc8
         GX7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdrDtVlqLgjZI9pCx3L4U7o4RbKStdotwDTGHRLE+HDQhACGkgKVsatwjqaAlhnAAJx+vJolvhIthb+f8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZmUFnFEsiXXFgdG8hFbT92B/6Dpvjhku4PO+oGu6PNRTTRnpU
	86bnMmsTSnUw5daAYQrgbxvFhmVGNp3AoDdO0fHOa1JbQB4f0FUrej0xxVS7HywubqCfeQhbcqv
	Sj44=
X-Gm-Gg: ASbGncv+gnoC3GbK4w9N7d0fL/TNmUscoF/THqGJmIwWTzGFoxS0G2i+Z3zxzFpGAMF
	6DcpY/2QgS+bIZ/58zJNHU1W4M5AYqUeslD4tFqY95IY9auvgxh0whM/QZK9I9TGiYMODIMm7x0
	5io2hPAHHvgnkSgEpdgBkaJ9w1AqzmnKPaMuR/UhIOd0ZRCaQdWx7KNX+zVAiddvgcBtWqL26/v
	pY3dEzgaNunDb9i5rjxI4cwEMrH13l+t8HNKD7GmvjzTLeXH1R52HWPsxdjiIidlpyO4Dv75G8t
	Af+XXFy7cEC7sYElPMtmRKm4gtf12s7DYBNAQ3Hcegb8LlXphsoVZgQtdx5s7w/HKrNu6A2BRFR
	P
X-Google-Smtp-Source: AGHT+IF1vvRb0/tmWH9I3xp2qIXfL4g8qUJLvJRN38RCqmMKoFu9V0eF8GwuGrbsMYUH5Fc6Kl2fmQ==
X-Received: by 2002:a17:907:cf91:b0:abb:bb82:385b with SMTP id a640c23a62f3a-abbeddc5eb9mr1082875966b.13.1740251931656;
        Sat, 22 Feb 2025 11:18:51 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abba8b1df9bsm1102880666b.114.2025.02.22.11.18.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2025 11:18:50 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab744d5e567so549344566b.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:18:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqJcPrFLX7MmDNmEHI/LZcoE8MjDmTJ9UntpMV1uK6uVjXN6C7QjWZTOtQkCe1IVIeaSNuAKl88adXy5E=@vger.kernel.org
X-Received: by 2002:a17:907:7744:b0:ab7:d34a:8f83 with SMTP id
 a640c23a62f3a-abc0ae94ed6mr697861966b.17.1740251930006; Sat, 22 Feb 2025
 11:18:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
In-Reply-To: <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 22 Feb 2025 11:18:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
X-Gm-Features: AWEUYZnYn9FC1D3iPga4e5fosxwJzgzYfFpxBBvQVXYxwhFF0dkV8v7eiQuqia8
Message-ID: <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Ventura Jack <venturajack85@gmail.com>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 22 Feb 2025 at 10:54, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> If that work is successful it could lead to significant improvements in
> code generation, since aliasing causes a lot of unnecessary spills and
> reloads - VLIW could finally become practical.

No.

Compiler people think aliasing matters. It very seldom does. And VLIW
will never become practical for entirely unrelated reasons (read: OoO
is fundamentally superior to VLIW in general purpose computing).

Aliasing is one of those bug-bears where compiler people can make
trivial code optimizations that look really impressive. So compiler
people *love* having simplistic aliasing rules that don't require real
analysis, because the real analysis is hard (not just expensive, but
basically unsolvable).

And they matter mainly on bad CPUs and HPC-style loads, or on trivial
example code. And for vectorization.

And the sane model for those was to just have the HPC people say what
the aliasing rules were (ie the C "restrict" keyword), but because it
turns out that nobody wants to use that, and because one of the main
targets was HPC where there was a very clear type distinction between
integer indexes and floating point arrays, some "clever" person
thought "why don't we use that obvious distinction to say that things
don't alias". Because then you didn't have to add "restrict" modifiers
to your compiler benchmarks, you could just use the existing syntax
("double *").

And so they made everything worse for everybody else, because it made
C HPC code run as fast as the old Fortran code, and the people who
cared about DGEMM and BLAS were happy. And since that was how you
defined supercomputer speeds (before AI), that largely pointless
benchmark was a BigDeal(tm).

End result: if you actually care about HPC and vectorization, just use
'restrict'. If you want to make it better (because 'restrict'
certainly isn't perfect either), extend on the concept. Don't make
things worse for everybody else by introducing stupid language rules
that are fundamentally based on "the compiler can generate code better
by relying on undefined behavior".

The C standards body has been much too eager to embrace "undefined behavior".

In original C, it was almost entirely about either hardware
implementation issues or about "you got your pointer arithetic wrong,
and the source code is undefined, so the result is undefined".
Together with some (very unfortunate) order of operations and sequence
point issues.

But instead of trying to tighten that up (which *has* happened: the
sequence point rules _have_ actually become better!) and turning the
language into a more reliable one by making for _fewer_ undefined or
platform-defined things, many C language features have been about
extending on the list of undefined behaviors.

The kernel basically turns all that off, as much as possible. Overflow
isn't undefined in the kernel. Aliasing isn't undefined in the kernel.
Things like that.

And making the rules stricter makes almost no difference for code
generation in practice. Really. The arguments for the garbage that is
integer overflow or 'strict aliasing' in C were always just wrong.

When 'integer overflow' means that you can _sometimes_ remove one
single ALU operation in *some* loops, but the cost of it is that you
potentially introduced some seriously subtle security bugs, I think we
know it was the wrong thing to do.

             Linus

