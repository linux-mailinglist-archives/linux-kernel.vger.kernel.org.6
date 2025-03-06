Return-Path: <linux-kernel+bounces-549059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F9FA54CB3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176F6174C69
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58D613C80C;
	Thu,  6 Mar 2025 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8letVuq"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C5513957E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741269402; cv=none; b=RXWC8cPKel8TnR30R4gRd0IMqsWTOgEKy9sAaS+SLCgzJ6pYYSlmh+kwSSKSXnzfhdFyxVe9VGICvj7k+9nTOV8V2huhj8CdsSFK01NaqdbI+X4yX3YvexjW/4dYOPvW81NLYXor2IY1v8ofF2jVwbxxoNuJ32I4s4deSAHE+XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741269402; c=relaxed/simple;
	bh=Ak4jPNS2H5zDaC93QvcNheTKkzUBzednJJVpi8m397w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kM0nLgW3PcRz9nkWoZygXC9/WQgXPK6sPyyNaA5FP2aXGGiMYynlEbgc0vCwUSzRJPtFrslHKsHM76/3k7+4LvsjY7HdWmhoU8kefWz50Y2O3ZDUvkX0hEdVbIOjcc70G71LmJ8MlMbjC9VbtL3xmLGNv3172CGWAGoj7J9d974=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8letVuq; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30bb2fdbb09so6612231fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 05:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741269398; x=1741874198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qw/mZJ3F1G3n89iZgBPP7rYy/9o9JwgTq33glnQrqFE=;
        b=V8letVuqFBa3yl1LlyE0KEwjHxMjMvZnAUCNXRYbUcvELMOYfY+98IPoCmRKiTdEde
         b5TsB8UZTVWLLyscuru1WNbPI8yANG3Zj3dejGxZZZxUXSmjgki1TkfXQ2ThOSBPXRMU
         M7L0ZhtZy8KXD/K/7yVer/RUSscaENJROH8Y+KDWyRPrv9sotW8vkKAwOBgYzU3dJVRB
         fGIVj9JDEMxLIulAFLl1qZ6OI0EfefnnKTuNhborFB55TUPv04pPdaxea8//XXn/YKH+
         +NrZbL0HUgj7N+6AllTr/JfvSv/oWn45GaelxJSUIGvgqFDJYKyIR/vH95g5xw+zNv+x
         zcmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741269398; x=1741874198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qw/mZJ3F1G3n89iZgBPP7rYy/9o9JwgTq33glnQrqFE=;
        b=u6HeXc7Bd3hHXl1rebxYNJ/k0xkwBSMQLKGe3iTx9AYuZKvyMNlQVXaLv1HgLi3X+n
         mC5neT8MQmV+bWuS/67nMef+u1tdWiPC+ARSWfve6DMtSTZKu64fY4sCbM8bT78yUEcn
         ZafwJ31UoPJznjRREL/potPN2vJmBE6RM5Be5vUh5R1Ju3t+bjyOdSAFZeCQnfxnMUz5
         UNdAGuiO0xViXA0osHTuU3NB4Kv5hHg9nMETUcsdPornbcuV85uhpWLCT1jvQkiiowcQ
         FrSLGBJzUilWKetuH0ixUdwoArCrcBLEoMkdnjVo3+U/W8CZ04CWKv7mdeVI21xo3E2Q
         uWdQ==
X-Forwarded-Encrypted: i=1; AJvYcCULzYuJgMz6WWHYP7EZ54iqHQuB6D+2ZJxfjcbcTW+B/EX0D6KEWbX5mVJRyuTyaK7yDk8m4OTsfbJpsxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhZ4ioqKy4OjAZA61Os75+vBAm3gpyY+yZ6EpmLPkbK/wCFGwE
	Ueq65bNn1XC9HJh/iXJsqRxO5+jonu636T+ys8B04r+/0rokYRaE5F+a91YFTXEvyCZ4EiE1h6U
	/+HG4SNW623LddaFCm77/pFwGdcfeYKl4FD0=
X-Gm-Gg: ASbGncswIZ++RNC0eOCYlOP6HGR6ohtp0Ik7gaRzO/mYXnZcIyfrVhB2+xPD0e/p8iH
	1prAUkY9XjFoKRSW1Vur7RdHABL708a6+UnI1mFXMV1VRyAVU6YELQmK2ywnQk83iJaken7NPiB
	G9rpUZ6SPmMIGqH5fOqjU5Pgqn7w==
X-Google-Smtp-Source: AGHT+IG3DQkcHiaFi2rFPWS7ff35/Uqx4ZLwiQtUwV9Zn19JbqWqJcH8NcQXcuXMik2Tf40dgxj/DlfcHSrz3vuXxPE=
X-Received: by 2002:a2e:be28:0:b0:30b:963e:9b1a with SMTP id
 38308e7fff4ca-30bd7b11c0cmr29194141fa.23.1741269398222; Thu, 06 Mar 2025
 05:56:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228123825.2729925-1-ubizjak@gmail.com> <Z8lxmPmnJhBmPRvl@gmail.com>
In-Reply-To: <Z8lxmPmnJhBmPRvl@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 6 Mar 2025 14:56:35 +0100
X-Gm-Features: AQ5f1JrmwxMl7SeTCZmrmdvqkLUhSfb_P2EoWHVOqTWShygNYpWcbMYk4qFB3ug
Message-ID: <CAFULd4b-YJnC1LFrvqLXTTsZQqchGQar=q3vUmeN-c8Kcrd51A@mail.gmail.com>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
To: Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 10:57=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > According to:
> >
> >   https://gcc.gnu.org/onlinedocs/gcc/Size-of-an-asm.html
> >
> > the usage of asm pseudo directives in the asm template can confuse
> > the compiler to wrongly estimate the size of the generated
> > code.
> >
> > The LOCK_PREFIX macro expands to several asm pseudo directives, so
> > its usage in atomic locking insns causes instruction length estimate
> > to fail significantly (the specially instrumented compiler reports
> > the estimated length of these asm templates to be 6 instructions long).
> >
> > This incorrect estimate further causes unoptimal inlining decisions,
> > unoptimal instruction scheduling and unoptimal code block alignments
> > for functions that use these locking primitives.
> >
> > Use asm_inline instead:
> >
> >   https://gcc.gnu.org/pipermail/gcc-patches/2018-December/512349.html
> >
> > which is a feature that makes GCC pretend some inline assembler code
> > is tiny (while it would think it is huge), instead of just asm.
> >
> > For code size estimation, the size of the asm is then taken as
> > the minimum size of one instruction, ignoring how many instructions
> > compiler thinks it is.
> >
> > The code size of the resulting x86_64 defconfig object file increases
> > for 33.264 kbytes, representing 1.2% code size increase:
> >
> >    text    data     bss     dec     hex filename
> > 27450107        4633332  814148 32897587        1f5fa33 vmlinux-old.o
> > 27483371        4633784  814148 32931303        1f67de7 vmlinux-new.o
> >
> > mainly due to different inlining decisions of -O2 build.
>
> So my request here would be not more benchmark figures (I don't think
> it's a realistic expectation for contributors to be able to measure
> much of an effect with such a type of change, let alone be certain
> what a macro or micro-benchmark measures is causally connected with
> the patch), but I'd like to ask for some qualitative analysis on the
> code generation side:
>
>  - +1.2% code size increase is a lot, especially if it's under the
>    default build flags of the kernel. Where does the extra code come
>    from?
>
>  - Is there any effect on Clang? Are its inlining decisions around
>    these asm() statements comparable, worse/better?

FTR, clang recognizes "asm inline", but there was no difference in code siz=
es:

  text    data     bss     dec     hex filename
27577163        4503078  807732 32887973        1f5d4a5 vmlinux-clang-patch=
ed.o
27577181        4503078  807732 32887991        1f5d4b7
vmlinux-clang-unpatched.o

Uros.

