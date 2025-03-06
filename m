Return-Path: <linux-kernel+bounces-548503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0621A545BC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C11C53A4094
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87F6207DF4;
	Thu,  6 Mar 2025 09:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEPYBiBY"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6C619D880
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251699; cv=none; b=B1odTdleDbk76QB0Dd6a4LGarEC9wr1OC2T71rbEuB0bo8duynM3f0cxBWf5N+O/Zu4r5Y5ZjKmAiNFyY7SDPMpyvYJVkfwQ7EshC11l5PXP82kAXbxt49b1/ozx2lS7cs3gGTJoyC22gdSPvmzm/TuQUsxgLGd1zyDxX4vTngU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251699; c=relaxed/simple;
	bh=4JZq/mGfFlnxPW9pNixuWia30OIERIh5Dpt80vZaWd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4Y5/72VpCI0fRO33wqZsePMIhy+8DnNO1h0bsCVMsTTVr+mXClVJ13asay2AIHS8cAcBAvlsV0ztLCgC7KVOmOJ7LozSNhBP+OgS2tdNmloDuX+vFxOqX/LKR9sRBSO6U99oamdpTQYyUFhvR0eWZAT1XOgg5J+Widi+pbVBFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEPYBiBY; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30bef9b04adso606211fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 01:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741251695; x=1741856495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGDL4TEb6k2+qfa9R2TSSmcOiUuibbQbJSU/WRBG5z0=;
        b=MEPYBiBYNZg/7B66IXX/TIH6QWm54IuLXfRWi5t0HvnW7sC0Ql4wqY0lYSrxE4dBjk
         64woXQZQ82BBLjiZInU8GePt/nMqJdNFzWYP03+KSegAzg0SXGw4H40VPu52MmJpoDYb
         TtYVn5jL8KVt+7IXwhtP5gthxxIaXx4smG7BZzz5bMF6+oG4+VMfRG8MzE9K4sAIaeMF
         Sn5V51sJW8nwBXGHXXUXH0BVej4JZpBlWXZYNC5SN3u0fAOY7iTchyZUvQQMeMqQrNMu
         tzeE6912QcIEe4tR1e41SFwMbCG5zmKAJgV7R7gXpRTStZQMqfdGpylNFb7Ku11IGF31
         8zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741251695; x=1741856495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGDL4TEb6k2+qfa9R2TSSmcOiUuibbQbJSU/WRBG5z0=;
        b=SUKAbFiOQm77iQiGPDmksmac3+ZGXHFD9/sj1cGid5ZVP3orIciKd77y5bZd1cjIJE
         FMvHcJf41uFrjDZOG1hjFRzaQtQ0BTBze9vpfxNGTZq/rS4ZCwT5xXniltu8IQG6wRAT
         k7FWok2F9v4oyP2B3RO7oWCFeWRglJbhDrPl12UVVyiVT5ueBP6Qct5UB+ghWNJXnanC
         YULR7WF3bHOn+Xm5ZIfKbD9UTAB/NH7GmgTNnCMiJGo+eVquaTOPZdO5mG41fvHxYXat
         Wfw5vzWhEAcwGViwR10rQumsMmOjNGH2qw+vcvI9+jevb3kEcO9rv8KPiOthC8VSywEF
         EfeA==
X-Forwarded-Encrypted: i=1; AJvYcCXgFdbtW2mELQqU2pnKl6HfGv/Dr8crXVOG0AA4gbTrwLithnJA4I3Wpah0972CxCngxA8RZ7HoebRTeRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzyeRep8U1uleny0gaJ0g7Qtqj1dQXmTFnP1hF4xihq5W1hVrW
	XOqOUo4APiFzzZAaf9pNo33zMmhY1hG+4CpPQ1mEAnr4mUbmo9//2TfebFgg0rRUVToOTp+97du
	m/gXTT7vGW8lNbf0ZXnLSNrvZTqQ=
X-Gm-Gg: ASbGncuCfP3u6//sCfiWx9WqHqyu3dJolhjBe7bTz/lurI/glnv962sEmekpStqHgpA
	ru1NulJyBv6tUH6LeszgR4LAMpje6QXsUSZJfi4sciE4z3vVZ1T214LMRKLJwDbgi8DsEvcQSFN
	eWGogcpzSaxaEmZpizY9Nv3beiag==
X-Google-Smtp-Source: AGHT+IHXbMHW4YyShS1AIona/bs0M+r8jlEJ2xiWHRMpOX0N5js+AHUqQ2QNK9oCKsBGzam+l2IFP/7etWxsjce82Gc=
X-Received: by 2002:a2e:9645:0:b0:30a:448a:467 with SMTP id
 38308e7fff4ca-30bd7a6fdadmr19351551fa.21.1741251695146; Thu, 06 Mar 2025
 01:01:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228123825.2729925-1-ubizjak@gmail.com> <20f1af22-71dc-4d62-9615-03030012222e@intel.com>
 <CAFULd4bpHGE83qc37sbh=rpGj+SFqQrsNDLzL_-NQpo6pQH3jw@mail.gmail.com>
 <c4aca08a-95c1-48ee-b4da-55a69b74101c@intel.com> <CAFULd4YVOEtT+bsp9H7ijaoJn2e2108tWhiFarRv=QxoUMZaiw@mail.gmail.com>
 <20250301123802.GCZ8L_qsv7-WwUwqt5@fat_crate.local> <CAFULd4b=4rHcVAVSg_3yMb8=3ReiSriw_rM4vJL9_HvheXE92w@mail.gmail.com>
 <20250305203633.GNZ8i10cVCCnhhULis@fat_crate.local> <20250305212638.GC35526@noisy.programming.kicks-ass.net>
In-Reply-To: <20250305212638.GC35526@noisy.programming.kicks-ass.net>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 6 Mar 2025 10:01:31 +0100
X-Gm-Features: AQ5f1JrRoa_h3AnkQYSTAY5Il94GcvsYSiPDByfBE6bFOLjB-n8gdCfuAyUMEeE
Message-ID: <CAFULd4ZsHKA4Yh9CsxPjdoW-fa7yD1-Ov7xDN4E3J3c8O8yQ7g@mail.gmail.com>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
To: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 10:26=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Mar 05, 2025 at 09:36:33PM +0100, Borislav Petkov wrote:
> > On Wed, Mar 05, 2025 at 09:54:11AM +0100, Uros Bizjak wrote:
> > > The -Os argument was to show the effect of the patch when the compile=
r
> > > is instructed to take care of the overall size. Giving the compiler
> > > -O2 and then looking at the overall size of the produced binary is
> > > just wrong.
> >
> > No one cares about -Os AFAICT. It might as well be non-existent. So the=
 effect
> > doesn't matter.
>
> Well, more people would care if it didn't stand for -Ostupid I suppose.
> That is, traditionally GCC made some very questionable choices with -Os,
> quite horrendous code-gen.

Size optimizations result in 15% code size reduction (x86_64
defconfig, gcc-14.2), so they reflect what user wanted:

  text    data     bss     dec     hex filename
27478996        4635807  814660 32929463        1f676b7 vmlinux-O2.o
23859143        4617419  814724 29291286        1bef316 vmlinux-Os.o

The compiler heuristics depend on tradeoffs, and -Os uses different
tradeoffs than -O2. Unfortunately, there is no
-Os-but-I-really-want-performace switch, but OTOH, tradeoffs can be
adjusted. The compiler is open-source, and these adjustments can be
discussed in public spaces (mailing lists and bugzilla) and eventually
re-tuned. We are aware that the world around us changes, so tunings
are not set in stone, but we also depend on user feedback.

Thanks,
Uros.

