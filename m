Return-Path: <linux-kernel+bounces-527673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4932A40E0F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 11:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC1B5178D1A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 10:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1031FCFC6;
	Sun, 23 Feb 2025 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfiY1u4/"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07CD3BBC9
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740306633; cv=none; b=ZAjrq0qbCX61WtSnx1ZoTva7bW4ZiuDgMUNLQvER1PQJLvep+cjWMfV65aJ26NreLc0gdt5qp+npPyK/Esa2HJk07kJYZMsttOJauuojO7drUd7YjpEq5kZnjE1KP8rRXDlVJhpISLNgCKweYJP6Nn+KwBLtAKc/bhz1Kp1Hn0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740306633; c=relaxed/simple;
	bh=Dl3+yp1j0uUvvHMrDFjfGrvoQEGFpkBAjD03AHpfzR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTnl3c6prcJdBUZXlTHzHBcoVvjXHt+N0I5zPTnwh30LEr7p3GoxI7ImU74YTQfH3xuLekJ/42LSvaYLXMjhhMpzTmx/n58vH9q7Mcq0YFFQ9CEK862p27+ztzwe+opaAwgOLSRWNm3scbU7IQteDd0VN+qkxgRXIKZYPDkgFRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfiY1u4/; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30a2f240156so34709121fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 02:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740306630; x=1740911430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODMDkk1m488I/kgMYHn95DzHCtQtRSd4ouwlxgKanNI=;
        b=FfiY1u4/GwdZ06mEpMJcixmF50VidEBvTAdoG5kZAX4lfAlAntJ8SiytA3FsZAn0sP
         cWGMxcpWS+XdajVqfIXGiresz83dCwMauK/lIT68v6jQjJOkEPTBZTdTSepkhRXCDIMQ
         C/boxUQF4R0HZWnk4fIEo16pXhIW8G4QnBxBzGLcGX9kMYdC4fHZsAKwcOtjmyHtqR4a
         ASu+JN4agISrBUcQrJaPOO0AMywzXeZgmMWB02C6Qu7aRbrAv2btCEOyvExTuRoTmjNT
         VtHhLSBDakUq2Encnu/HzuuE0SVNKVah15YLJNDhs/wYA4lwdc14okYlvve4UwgwqNvK
         e8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740306630; x=1740911430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODMDkk1m488I/kgMYHn95DzHCtQtRSd4ouwlxgKanNI=;
        b=YBmcrWyNUyfkDBsBp58PIoftxxsvzL2dQUGah3aczjYbDrdl7fpafGQXZdM6oh7DM+
         AkBmWi7n6Fd+47Cip2VXHIEL7C8FlK9bbXZh44Og37hM4lbIdmjOhpO3mKS/CkatVJ4U
         +lbLfHR6XoWVjPZaFfjOE1rRM7OgTR4wTQxFDOnX/HHvYYsZgPVpgt63TLh9ERj4Mg7O
         F7EiN6S2rS8iZu4kwhdQ9mPf22sjKhbJDZDv10mCvyRv3EyzNZlftnkxb91L1+0rWTjn
         AVVkMaDKu7n9Fbts028zXOiP0L/Kb7vqmO2NMI2XHbgLzxi8zy/P9noMKKRsKoEm61pl
         fJzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtE/Csh+m9q0ttc5XLVOoELGnA6cR5KxQcmrEhxEsjJMju0RXmKktQbcTADrdwwr/UzpnnC3oa2x0Ns3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz77Lc/itg1nl5hWmAjccgsRkrTdJDX5nZdIbopEzbkOlStbxSA
	G/H4XcASlwu0wsC6th7QUVvq03isszfvrtEq7wz2uLb/rvHJCO2B34fULzmnAsESWxfzeRkcqXl
	lv3HL2T53mAEOGvUFz1dkDw3H9WQhv6QM
X-Gm-Gg: ASbGncvs+j9gMhJ9i/S01xoojaCnV5d9LWcFKCKCR1mqzLRRNzyndG1y3S/LZpnIQSS
	TZO+HlDclUuIMjY6Knd0RE3OMuJS+qK01wcczR4ePtmxuF1COzeTPeKsDGpE0CUme7v5qZKqjz8
	pbh7ZMjjE=
X-Google-Smtp-Source: AGHT+IEn3yXpJN3oWq6fjW/Z7CfWG/d7IDCNCinIwV0tQKFT0G7j8rAfBkFndEMu7Jy55BUncmFzYHPLP1jQt0gPQzE=
X-Received: by 2002:a2e:8649:0:b0:309:1c07:4a69 with SMTP id
 38308e7fff4ca-30a598ebd72mr29398591fa.22.1740306629392; Sun, 23 Feb 2025
 02:30:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222190623.262689-1-brgerst@gmail.com> <Z7rsOVaxhfCJdn2P@gmail.com>
 <CAMj1kXE51FSYQ6prL7M5vfy1KjJGiBAre3CH3G-L3CQj9YSq9A@mail.gmail.com>
In-Reply-To: <CAMj1kXE51FSYQ6prL7M5vfy1KjJGiBAre3CH3G-L3CQj9YSq9A@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sun, 23 Feb 2025 11:30:24 +0100
X-Gm-Features: AWEUYZnbvIXbr9WMQ5_iOuutv4mVYXIK-z-udLZmvYW3hGIfk9jasWTMXN-dREY
Message-ID: <CAFULd4YHj_Y7B4B8Mz5rwm3uB5GS=BhQny_eFhSSkdi=qg+qcA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] Add a percpu subsection for hot data
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 11:20=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> On Sun, 23 Feb 2025 at 10:37, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Brian Gerst <brgerst@gmail.com> wrote:
> >
> > > Add a new percpu subsection for data that is frequently accessed and
> > > exclusive to each processor.  This is intended to replace the pcpu_ho=
t
> > > struct on X86, and is available to all architectures.
> > >
> > > The one caveat with this approach is that it depends on the linker to
> > > effeciently pack data that is smaller than machine word size.  The
> > > binutils linker does this properly:
> > >
> > > ffffffff842f6000 D __per_cpu_hot_start
> > > ffffffff842f6000 D softirq_pending
> > > ffffffff842f6002 D hardirq_stack_inuse
> > > ffffffff842f6008 D hardirq_stack_ptr
> > > ffffffff842f6010 D __ref_stack_chk_guard
> > > ffffffff842f6010 D __stack_chk_guard
> > > ffffffff842f6018 D const_cpu_current_top_of_stack
> > > ffffffff842f6018 D cpu_current_top_of_stack
> > > ffffffff842f6020 D const_current_task
> > > ffffffff842f6020 D current_task
> > > ffffffff842f6028 D __preempt_count
> > > ffffffff842f602c D cpu_number
> > > ffffffff842f6030 D this_cpu_off
> > > ffffffff842f6038 D __x86_call_depth
> > > ffffffff842f6040 D __per_cpu_hot_end
> > >
> > > The LLVM linker doesn't do as well with packing smaller data objects,
> > > causing it to spill over into a second cacheline.
> >
> > ... now it's linker-ordered. But on the other hand that can be an
> > advantage too: the linker will try to (or at least has a chance to)
> > order the fields optimally for cache density, while the hand-packing
> > always has the potential to bitrot without much of an outside,
> > actionable indicator for the bitrot.
> >
>
> The linker will need some help here - by default, it just emits these
> variables in the order they appear in the input.
>
> If we emit each such variable 'foo' into .data..hot.foo, and define
> the contents of the section as
>
> *(SORT_BY_ALIGNMENT(.data..hot.*))
>
> we should get optimal packing as long as the alignment of these
> variables does not exceed their size.

Is it possible to warn/error when data is spilled over the cache line?
Previously, there was:

-static_assert(sizeof(struct pcpu_hot) =3D=3D 64);

that failed the build in this case.

Uros.

