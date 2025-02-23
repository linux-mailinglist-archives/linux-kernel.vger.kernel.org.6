Return-Path: <linux-kernel+bounces-527846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6ECA41070
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 18:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD61172897
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 17:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D204C13F434;
	Sun, 23 Feb 2025 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPkGyD6b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E84D78F3B
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740331827; cv=none; b=Glh3T1PjWP4fIPtFFO6x0JhPECbeCp3/mN1QYDo1BUbIFjXyWv9UlwksTf/z9S/OhE83seTn9cHadruwOOvRQ33WIS53wJNl4hPHMd0w+2rCwWdCchVUIdkKeR3L1LOiMih3DRCQWcsWGHNMxZ7n24a/G9UC5AAUW/oY3Hr5zAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740331827; c=relaxed/simple;
	bh=TGFFOYxjKUrF3bfDOR+Uvj+CkPssQarIDqNrdXi+08g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bNHYDZOwTM4cpzWjP1uzRovsGUsSIEtjEy4d2weMRy8zg1fjNXz+ArzUEFacNGetkV+53jMU5zwr0l1QLoCEoZwZ0zCAZBG34+jVOXQc1uV+yFagF9KZr7+irpevXsQHMrQYKKAtgpOUcshVxXd7ToOvt11dXO6EVrJlVRgiVZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPkGyD6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D077C4CEEC
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 17:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740331827;
	bh=TGFFOYxjKUrF3bfDOR+Uvj+CkPssQarIDqNrdXi+08g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jPkGyD6b9qk+z9lV4zz346iystVlMCHkb8LKQpe5OjP52O8krLhGak5FaiJwIT0mx
	 PCsG6Nfz7lsm/LqzEDAqYwW6idmspFcl2vd04W5kUIvtbZmoRK+mbjUVt0EcO+t3x9
	 Km5G5374zzwswx51q7m9ZehXlfqHSVHdSBt6kyuQmksU59DdBskwCeuqDpupauu8Hf
	 rflHBD1n9uf6EDuz6U4FMPpL+o0FpO3ryGSUc115Rvi5oEcllneWNAz7DdH6Rs85Us
	 7I01Pe9Oyoz2UoHXtjvKuLAQdjHsjkkL4dTidVPMf6poKUmKxi2/nzA+FzuARiJR2C
	 yhwupJcQvKngg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30737db1aa9so35076711fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 09:30:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVe1GL783BCKV8oYDRdGqvBZwy2zeSLavWEP+pEsjOwP8yhiZGcUw+PuJq7xLJxXwXWHRQrRezPs06SlII=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWgveveGGhHbJfg81fSAPoOaPUNP5UVxmrMGLMKaelyml8GR7v
	SD7dKnKV991a8r7GmEKMKziqVXJMJefvt9uXah6vL6a+3tnDvsZC4vB89bBHb0kB+EYW+O03fv9
	xollv2MMlCcgg+hV1kjcG2B9BR3k=
X-Google-Smtp-Source: AGHT+IF0D9Du/RqVs2ixIckZ39RhvabP4gu0eSkxGrMjGUFWTZDpRkqjN8NNWA/0SnCKnMCKni8qU7DChgKeOtZxhbw=
X-Received: by 2002:a05:6512:68e:b0:545:f1d:6f2c with SMTP id
 2adb3069b0e04-54838ee8fa6mr3623883e87.18.1740331825279; Sun, 23 Feb 2025
 09:30:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222190623.262689-1-brgerst@gmail.com> <Z7rsOVaxhfCJdn2P@gmail.com>
 <CAMj1kXE51FSYQ6prL7M5vfy1KjJGiBAre3CH3G-L3CQj9YSq9A@mail.gmail.com>
 <CAFULd4YHj_Y7B4B8Mz5rwm3uB5GS=BhQny_eFhSSkdi=qg+qcA@mail.gmail.com> <CAMzpN2hYex-uuAZPZfA_8wz5t0Vn5hPcvi+2=aNbfc1POKyq=A@mail.gmail.com>
In-Reply-To: <CAMzpN2hYex-uuAZPZfA_8wz5t0Vn5hPcvi+2=aNbfc1POKyq=A@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 23 Feb 2025 18:30:13 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE0N=yw9tmrHwiDGwmEk+8J6_5YHYsy-eWvyAUeK+rjxA@mail.gmail.com>
X-Gm-Features: AWEUYZkNee6wEQk3gEmpPWGnEHp09Hyt_gG_qblKUNF9_CeF_Exg1-Qriq1lMIo
Message-ID: <CAMj1kXE0N=yw9tmrHwiDGwmEk+8J6_5YHYsy-eWvyAUeK+rjxA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] Add a percpu subsection for hot data
To: Brian Gerst <brgerst@gmail.com>
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 23 Feb 2025 at 18:25, Brian Gerst <brgerst@gmail.com> wrote:
>
> On Sun, Feb 23, 2025 at 5:30=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> w=
rote:
> >
> > On Sun, Feb 23, 2025 at 11:20=E2=80=AFAM Ard Biesheuvel <ardb@kernel.or=
g> wrote:
> > >
> > > On Sun, 23 Feb 2025 at 10:37, Ingo Molnar <mingo@kernel.org> wrote:
> > > >
> > > >
> > > > * Brian Gerst <brgerst@gmail.com> wrote:
> > > >
> > > > > Add a new percpu subsection for data that is frequently accessed =
and
> > > > > exclusive to each processor.  This is intended to replace the pcp=
u_hot
> > > > > struct on X86, and is available to all architectures.
> > > > >
> > > > > The one caveat with this approach is that it depends on the linke=
r to
> > > > > effeciently pack data that is smaller than machine word size.  Th=
e
> > > > > binutils linker does this properly:
> > > > >
> > > > > ffffffff842f6000 D __per_cpu_hot_start
> > > > > ffffffff842f6000 D softirq_pending
> > > > > ffffffff842f6002 D hardirq_stack_inuse
> > > > > ffffffff842f6008 D hardirq_stack_ptr
> > > > > ffffffff842f6010 D __ref_stack_chk_guard
> > > > > ffffffff842f6010 D __stack_chk_guard
> > > > > ffffffff842f6018 D const_cpu_current_top_of_stack
> > > > > ffffffff842f6018 D cpu_current_top_of_stack
> > > > > ffffffff842f6020 D const_current_task
> > > > > ffffffff842f6020 D current_task
> > > > > ffffffff842f6028 D __preempt_count
> > > > > ffffffff842f602c D cpu_number
> > > > > ffffffff842f6030 D this_cpu_off
> > > > > ffffffff842f6038 D __x86_call_depth
> > > > > ffffffff842f6040 D __per_cpu_hot_end
> > > > >
> > > > > The LLVM linker doesn't do as well with packing smaller data obje=
cts,
> > > > > causing it to spill over into a second cacheline.
> > > >
> > > > ... now it's linker-ordered. But on the other hand that can be an
> > > > advantage too: the linker will try to (or at least has a chance to)
> > > > order the fields optimally for cache density, while the hand-packin=
g
> > > > always has the potential to bitrot without much of an outside,
> > > > actionable indicator for the bitrot.
> > > >
> > >
> > > The linker will need some help here - by default, it just emits these
> > > variables in the order they appear in the input.
> > >
> > > If we emit each such variable 'foo' into .data..hot.foo, and define
> > > the contents of the section as
> > >
> > > *(SORT_BY_ALIGNMENT(.data..hot.*))
> > >
> > > we should get optimal packing as long as the alignment of these
> > > variables does not exceed their size.
> >
> > Is it possible to warn/error when data is spilled over the cache line?
> > Previously, there was:
> >
> > -static_assert(sizeof(struct pcpu_hot) =3D=3D 64);
> >
> > that failed the build in this case.
>
> I think it should be a warning and not an error.  If it does spill
> into a second cacheline the kernel will still boot and function
> properly so it's not a fatal error, it just could hit performance a
> bit.  By decentralizing this it does make it harder to account for
> size, especially with conditional builds.  Unfortunately, the linker
> script language does not have a WARNING() counterpart to ASSERT().
>

Why should it even be a warning? What is the problem if the build in
question has two cachelines worth of hot per-CPU data?

