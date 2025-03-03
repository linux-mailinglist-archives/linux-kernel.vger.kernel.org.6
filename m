Return-Path: <linux-kernel+bounces-542702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98631A4CCA4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CBA33A5278
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A5822FDF3;
	Mon,  3 Mar 2025 20:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IzVqXes/"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC6822FAC3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 20:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741033661; cv=none; b=AnfYrQXjC4wcAKhpfbGCOKGf92X2ZiB9uDEG8rZgbQw3VfAKp3wr/sFdTau9VSId5MBFXSLomkctKdmtQfbcHcob+5rO8rYB6tQwh4IDC8kJXROilEblbfkRviFUu0M8kXp46wGNIptE1k1Uyczr3dpLIiH5c5KcOexl7+Ywqsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741033661; c=relaxed/simple;
	bh=tyjhOZCLXblk/lWGiyqb0yg43eEGfRrZFxaVqWUtMx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXTvirim2OunWf4r9g2IYmrR7Gw2uPIxgdpkyMsJvIe7mqakAWgp8Ymj/oNBopNexff349oI2odRBQdIRLFAz3KUkzgdeMn4PiSbkg6GllCKgkiw6ajZev62xF/My6iuBx1yEl8VWtjSmtEmYFHuHk6n05opuUZdNVYil5KpPyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IzVqXes/; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab7430e27b2so813319466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 12:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741033657; x=1741638457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yp6ZHHcUlv3BN2Sxx60Ds1olIBUSnA0r2BR96nqq1mo=;
        b=IzVqXes/CxzmJ/O1KsWUxNFrZTkFuDyQq+1vs2SLy5lmZEBdDt7Of1KlGgGG1zxWCY
         jUSqfgzLACmHCavTseP5iFWpJRJaNIx7JstIIRtYUejCjqstp4UC63BfTc1tOFJD1wsj
         TqABQhGRoZiQ5+ek3yoSBdMiqHGOrh/1OZubxGG/U8m7S/HJgCmP1+cTw01kJ9UK0Mik
         qP5KJjOcmM6HcEw2336vK1cdhA4woGL/lVwJyIOILf6+Aw+72KBlXY/Ph73AMMdy5vP7
         nxuTbaY4HBI+fq5uJEl2lERSqNtxG4J+CRGVkc6uZVU57t+0rP6yuKHwjEoBZanVv/YF
         Xotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741033657; x=1741638457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yp6ZHHcUlv3BN2Sxx60Ds1olIBUSnA0r2BR96nqq1mo=;
        b=J4eK2YWdyXzebR4cTdSrgn0v0d7FXyxXIC+dScVPCPa65OUZ2yTtHNKOfIoqgeNvUP
         gvpGL84Sm3LsxV6mEBr4HT3AlunT1y6gYRVPCREjr2U34p9WrOk4wfUy0JdfUbHyyTYm
         /K8Tj9hNiXOTnKJKIz0PrOyvKOcqJIEFMfbHH60kpfTbJX51gqAKlundjpIJnhQd4vh3
         MM7BRdC2r7Z3t/mU5yUwQAJv0gV2Ptc3dXhXzwC1V6IR7Y0RQDnqo2Kv3i3wyGJDRrkn
         EOtDba1MPtL0c4mm5jVzP0tstRtTFo9q2psS+LFLjhj9nzq5gmU1GbgC33ZgTvke0HbR
         P0eg==
X-Forwarded-Encrypted: i=1; AJvYcCUGQ4Tlhu91hPLaFLssoIbgVDBAicbAzLjWOtzCNuUQ5jBVcunoaptlUOcsfZ6xbLBdPnNQgzTswWBOTKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7GFoye1G5y4AAuzg6RMYAby+yjYRLOG6R0xSUFQRzY+Cqy70a
	ELWxzBD2XKPBvSGucNZ5EhBZmi9BBVXMd76le4hmV88Si1SD0srkGFAgHLbJEYqH0NX5WlOPTTQ
	nynHoEXvtwN9djJcvw8hg2tr5d2u8qIc2PQM=
X-Gm-Gg: ASbGncvGqTEHhpRHPWsHcrkkdbhC0hflXMXICXL4XImKmQM8NE7KM24U8j7p2LIzjmM
	w2xqIcfA195qZI8jD09KWuAbTAQ8hjfCArk5atSwFS7MK50jttR2Cikwom7nlytXEPk3VV/Wkwr
	po0YHjcZG1aKmt3Nn6v3/7Pak=
X-Google-Smtp-Source: AGHT+IHI0fHcpRxOMEO7nP/Kg/pdqqFRVzlmne6oJqNMvLeXcAHaJcnaYg8dJwxhgGdthWyXCwkDPcWhYDYce4Gahp0=
X-Received: by 2002:a17:906:c10a:b0:abf:5d4a:56e5 with SMTP id
 a640c23a62f3a-abf5d4a6eb4mr974355566b.26.1741033657432; Mon, 03 Mar 2025
 12:27:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGG=3QVi27WRYVxmsk9+HLpJw9ZJrpfLjU8G4exuXm-vUA-KqQ@mail.gmail.com>
 <CAGG=3QVkd9Vb9a=pQ=KwhKzGJXaS+6Mk5K+JtBqamj15MzT9mQ@mail.gmail.com> <20250303201509.32f6f062@pumpkin>
In-Reply-To: <20250303201509.32f6f062@pumpkin>
From: Bill Wendling <morbo@google.com>
Date: Mon, 3 Mar 2025 12:27:21 -0800
X-Gm-Features: AQ5f1JrEzddvs-Wv-Crhgn4hy8yEJ4TPM_rlAZtbpq3z6xnwhM66zprDjy3Rcmo
Message-ID: <CAGG=3QV1iDn2r39v5eroO+kCvpbmJNtSeqJS+fpwb4vBG67z=w@mail.gmail.com>
Subject: Re: [PATCH v2] x86/crc32: use builtins to improve code generation
To: David Laight <david.laight.linux@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Eric Biggers <ebiggers@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Justin Stitt <justinstitt@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-crypto@vger.kernel.org, 
	clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 12:15=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
> On Thu, 27 Feb 2025 15:47:03 -0800
> Bill Wendling <morbo@google.com> wrote:
>
> > For both gcc and clang, crc32 builtins generate better code than the
> > inline asm. GCC improves, removing unneeded "mov" instructions. Clang
> > does the same and unrolls the loops. GCC has no changes on i386, but
> > Clang's code generation is vastly improved, due to Clang's "rm"
> > constraint issue.
> >
> > The number of cycles improved by ~0.1% for GCC and ~1% for Clang, which
> > is expected because of the "rm" issue. However, Clang's performance is
> > better than GCC's by ~1.5%, most likely due to loop unrolling.
>
> How much does it unroll?
> How much you need depends on the latency of the crc32 instruction.
> The copy of Agner's tables I have gives it a latency of 3 on
> pretty much everything.
> If you can only do one chained crc instruction every three clocks
> it is hard to see how unrolling the loop will help.
> Intel cpu (since sandy bridge) will run a two clock loop.
> With three clocks to play with it should be easy (even for a compiler)
> to generate a loop with no extra clock stalls.
>
> Clearly if Clang decides to copy arguments to the stack an extra time
> that will kill things. But in this case you want the "m" constraint
> to directly read from the buffer (with a (reg,reg,8) addressing mode).
>
Below is what Clang generates with the builtins. From what Eric said,
this code is only run for sizes <=3D 512 bytes? So maybe it's not super
important to micro-optimize this. I apologize, but my ability to
measure clock loops for x86 code isn't great. (I'm sure I lack the
requisite benchmarks, etc.)

-bw

.LBB1_9:                                # =3D>This Inner Loop Header: Depth=
=3D1
        movl    %ebx, %ebx
        crc32q  (%rcx), %rbx
        addq    $8, %rcx
        incq    %rdi
        cmpq    %rdi, %rsi
        jne     .LBB1_9
# %bb.10:
        subq    %rdi, %rax
        jmp     .LBB1_11
.LBB1_7:
        movq    %r14, %rcx
.LBB1_11:
        movq    %r15, %rsi
        andq    $-8, %rsi
        cmpq    $7, %rdx
        jb      .LBB1_14
# %bb.12:
        xorl    %edx, %edx
.LBB1_13:                               # =3D>This Inner Loop Header: Depth=
=3D1
        movl    %ebx, %ebx
        crc32q  (%rcx,%rdx,8), %rbx
        crc32q  8(%rcx,%rdx,8), %rbx
        crc32q  16(%rcx,%rdx,8), %rbx
        crc32q  24(%rcx,%rdx,8), %rbx
        crc32q  32(%rcx,%rdx,8), %rbx
        crc32q  40(%rcx,%rdx,8), %rbx
        crc32q  48(%rcx,%rdx,8), %rbx
        crc32q  56(%rcx,%rdx,8), %rbx
        addq    $8, %rdx
        cmpq    %rdx, %rax
        jne     .LBB1_13
.LBB1_14:
        addq    %rsi, %r14
.LBB1_15:
        andq    $7, %r15
        je      .LBB1_23
# %bb.16:
        crc32b  (%r14), %ebx
        cmpl    $1, %r15d
        je      .LBB1_23
# %bb.17:
        crc32b  1(%r14), %ebx
        cmpl    $2, %r15d
        je      .LBB1_23
# %bb.18:
        crc32b  2(%r14), %ebx
        cmpl    $3, %r15d
        je      .LBB1_23
# %bb.19:
        crc32b  3(%r14), %ebx
        cmpl    $4, %r15d
        je      .LBB1_23
# %bb.20:
        crc32b  4(%r14), %ebx
        cmpl    $5, %r15d
        je      .LBB1_23
# %bb.21:
        crc32b  5(%r14), %ebx
        cmpl    $6, %r15d
        je      .LBB1_23
# %bb.22:
        crc32b  6(%r14), %ebx
.LBB1_23:
        movl    %ebx, %eax
.LBB1_24:

