Return-Path: <linux-kernel+bounces-527669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BC1A40E09
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 11:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA8D618982A4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 10:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10ECD20469F;
	Sun, 23 Feb 2025 10:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcKZ/7hI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70617335BA
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 10:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740306043; cv=none; b=aWc3hH5oSaisiMbyroRMSUpV9H8WzroXv2uHd/Qjou2D7YEOGNxG4K30ABdO4HL0z+XfvdKavPmSmfvp1OJzL637x+Low51n8wqScKoxizoRd0j7zZ/nCFm/tjNymYnl3AyFtUqT4NJFeFjmoUcdw1VkclytPweJt3XsHU9hEXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740306043; c=relaxed/simple;
	bh=nLLJx7rSg68EODwVW4lh0RL2AzUdrK09e4ssTKWUxbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kMDqnC1u1F9rNsdgRFdfjU66z6RY2I8FGbIQuoHeSdex1yDh4SHYAogXGiCaFmcpUo8MXb+5HYu6crw6XSKCHWbpT2bEhUHe6ddW2L0tht24PVjlWIPEQdm0vB23DbMN+KmC+VOdP7cWkTZ96wn/C2bXeQs72BQPmp5crUPhDos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcKZ/7hI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EEEEC4CEE8
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 10:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740306043;
	bh=nLLJx7rSg68EODwVW4lh0RL2AzUdrK09e4ssTKWUxbA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CcKZ/7hIXpOVYF+dbnCRCIRiLjqq98x+jSv9yQrjAVAstssNGoku4auCjLatqsqRH
	 7NziLVfIDbQfmtLebtX5/FlPBZIeox+gQ/jYrSWYU49yXNdWCCOs+v+Lorc/j2hAHB
	 ukkmZG1sR1QQU4GP4wYSyrUrl++l95anwYFgjHwe0XCIWTgxwbQ8Rf7MXDWXDsMArj
	 Jttmc3YKAz9YnfXlDlkTR5E7xe4iNazGMahDY2S9cfnJD4svfFIPbgZAxtpR5g+c0a
	 odYlLLdTw/t6MtCNxPduh1d4ysYH+YdEcYKhPN0onewogBht6CRCIY9E6ruuultqdT
	 u7SNGDZOihEpQ==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-307c13298eeso40475521fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 02:20:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX6t2iuHsVxwWItVTgVIW7PPQvHnEWfwV8UajAmv57l01QY5ckK10eIOFxiO/5HHicNA56H6/F39YktGsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeKWlyH5VKpsrw8MhE/6kYPvXHYQocoGb8S3zowE2c6NiyoIFb
	HvW81juRSR+bMz6ttXV/NEzeFx6iO5m0EdYco9DCkyAHHWwchnv/mO2mY6I1c5UhFnJ+AKK+Vin
	qnuOenuFK366rM8BNcFokhAOojM4=
X-Google-Smtp-Source: AGHT+IEB5i7vIIWPdah9QWq3KdhRrFOD5dgLb+/0b2dyklVF7bNGLe0kvDY7vEBE2C4+UT78BPWB2DnqmjERA+9ddaQ=
X-Received: by 2002:a2e:2a04:0:b0:309:31bf:ec17 with SMTP id
 38308e7fff4ca-30a506516aemr41167441fa.15.1740306041641; Sun, 23 Feb 2025
 02:20:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222190623.262689-1-brgerst@gmail.com> <Z7rsOVaxhfCJdn2P@gmail.com>
In-Reply-To: <Z7rsOVaxhfCJdn2P@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 23 Feb 2025 11:20:26 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE51FSYQ6prL7M5vfy1KjJGiBAre3CH3G-L3CQj9YSq9A@mail.gmail.com>
X-Gm-Features: AWEUYZmdQ7MIAodLtKvnrou8VMQUf3rbpi9wNNdxbsF2xvF811l70q-_6Dh_WuA
Message-ID: <CAMj1kXE51FSYQ6prL7M5vfy1KjJGiBAre3CH3G-L3CQj9YSq9A@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] Add a percpu subsection for hot data
To: Ingo Molnar <mingo@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Uros Bizjak <ubizjak@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 23 Feb 2025 at 10:37, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Brian Gerst <brgerst@gmail.com> wrote:
>
> > Add a new percpu subsection for data that is frequently accessed and
> > exclusive to each processor.  This is intended to replace the pcpu_hot
> > struct on X86, and is available to all architectures.
> >
> > The one caveat with this approach is that it depends on the linker to
> > effeciently pack data that is smaller than machine word size.  The
> > binutils linker does this properly:
> >
> > ffffffff842f6000 D __per_cpu_hot_start
> > ffffffff842f6000 D softirq_pending
> > ffffffff842f6002 D hardirq_stack_inuse
> > ffffffff842f6008 D hardirq_stack_ptr
> > ffffffff842f6010 D __ref_stack_chk_guard
> > ffffffff842f6010 D __stack_chk_guard
> > ffffffff842f6018 D const_cpu_current_top_of_stack
> > ffffffff842f6018 D cpu_current_top_of_stack
> > ffffffff842f6020 D const_current_task
> > ffffffff842f6020 D current_task
> > ffffffff842f6028 D __preempt_count
> > ffffffff842f602c D cpu_number
> > ffffffff842f6030 D this_cpu_off
> > ffffffff842f6038 D __x86_call_depth
> > ffffffff842f6040 D __per_cpu_hot_end
> >
> > The LLVM linker doesn't do as well with packing smaller data objects,
> > causing it to spill over into a second cacheline.
>
> ... now it's linker-ordered. But on the other hand that can be an
> advantage too: the linker will try to (or at least has a chance to)
> order the fields optimally for cache density, while the hand-packing
> always has the potential to bitrot without much of an outside,
> actionable indicator for the bitrot.
>

The linker will need some help here - by default, it just emits these
variables in the order they appear in the input.

If we emit each such variable 'foo' into .data..hot.foo, and define
the contents of the section as

*(SORT_BY_ALIGNMENT(.data..hot.*))

we should get optimal packing as long as the alignment of these
variables does not exceed their size.

