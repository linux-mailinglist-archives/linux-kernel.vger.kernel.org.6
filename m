Return-Path: <linux-kernel+bounces-341383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AA1987F4D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F4E1C22BF7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122B317D373;
	Fri, 27 Sep 2024 07:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXzY+jXb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7105814A0A9
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727421724; cv=none; b=OeIcUJ/mgS9ijiHv8zF0+vooqd//mDi7shyEmY5R7WS4ZrQtXLipd3s0i+/nKx7kZ5n6tlP7T+zV3FxBUk01Vm2CPQ7sLNNdMNKBdUo9HbbLG/92ygQlJ3e60on6+ab+00T5rWbC4sXCqLR9QmF4vnIxq81xRDglI1QgM+68Cl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727421724; c=relaxed/simple;
	bh=XXyorE3NYuaIDyKhE8tOm3HgUiabzoTflJQVXTwEZ5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=re/yN2YYQqgdIGE+vIfbPYOUysSMNWA5JC5SBDY3EWMoN3mTkWq9JuVSmeQ7c3cNShhM96j6fDzuXzC5ClVnyr/gKwNzma++tpypFcs7xp+yMP42vA4BGbmWE0D+JMAVta2hGnM9SebBLVptSrgKUrdbNH+9XG9JzrogI+/rxV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXzY+jXb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A18C4CECF
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727421724;
	bh=XXyorE3NYuaIDyKhE8tOm3HgUiabzoTflJQVXTwEZ5I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jXzY+jXb8Dv8w6jzWwjSyIsOThAJIUQrgM3HbBpuauw9kIRF6mQc3AoQonlaGfFTu
	 6EYEFlnXbMEaj7BGEkzKnpAulGc46TCpO+/81JXHY6Rrwhk2uPJ9L7rO3zv7U0cMvH
	 smgsOKwJvCkG6KwN3xO+kvplq13fhPraadiAGXQd8+roeB6AX1qAGCJ6294Ax4neb9
	 LL5VP5G0Ximam4INJiXJ0AiLn9YhojrfnGTj5Ue7XVTgCfaAdhNulZ36tEUSo3qyKs
	 qUadbCC0CxTE2h4SRRj42tVzfwAcwMIluHzDJ0vci7/2VWpT33sNemUIlB6obhhPNx
	 E028f5lW4Fopw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f75aa08a96so19582381fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 00:22:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXdp83Wgys2vHzKau3/B6qQ/qnkMdEEMgJXiqQTykWi2QLocKbSadiTZ1RbCeu51DquGGqS//MNXQ5Xxdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzx5MRx4QPa2fe4+i/ETYahHsi8rKyS+kEWmG6R1DjdpfPYXAv
	P2e9Ic2/bie/iOok2MBgsFI8wJYz2zSJtSjucFQoJ20QPC89le65QITx7BOt3CZm8MagGqRDH0Q
	wj63/AQGKPEejSS12Idc1t9eGScw=
X-Google-Smtp-Source: AGHT+IHge0Y7vPBswWpBlfdMpGay8Cj7KoMmh1SqNdtIRPMbR5P+1BFic2AQtpeOfD0rJjofWLR8ftJJRjSH+e4kQmY=
X-Received: by 2002:a2e:9401:0:b0:2f6:5f0a:9cfe with SMTP id
 38308e7fff4ca-2f9d417b457mr10213891fa.30.1727421722306; Fri, 27 Sep 2024
 00:22:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926104113.80146-7-ardb+git@google.com> <20240926104113.80146-11-ardb+git@google.com>
 <572b339b-7dab-4db0-8ee8-d805f8211aa3@amd.com> <CAMj1kXGt76Z0VsWog5Y2srBp8MiYXqkkhOQvFiZ7ULhNB3p6KA@mail.gmail.com>
In-Reply-To: <CAMj1kXGt76Z0VsWog5Y2srBp8MiYXqkkhOQvFiZ7ULhNB3p6KA@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 27 Sep 2024 09:21:50 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFL_a1DTzzXBaNZyU=4ho_NPYG7tceo-wNu9ehQ-72+gA@mail.gmail.com>
Message-ID: <CAMj1kXFL_a1DTzzXBaNZyU=4ho_NPYG7tceo-wNu9ehQ-72+gA@mail.gmail.com>
Subject: Re: [PATCH 4/5] x86/xen: Avoid relocatable quantities in Xen ELF notes
To: Jason Andryuk <jason.andryuk@amd.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Sept 2024 at 07:49, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 27 Sept 2024 at 03:47, Jason Andryuk <jason.andryuk@amd.com> wrote:
> >
> > On 2024-09-26 06:41, Ard Biesheuvel wrote:
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > Xen puts virtual and physical addresses into ELF notes that are treated
> > > by the linker as relocatable by default. Doing so is not only pointless,
> > > given that the ELF notes are only intended for consumption by Xen before
> > > the kernel boots. It is also a KASLR leak, given that the kernel's ELF
> > > notes are exposed via the world readable /sys/kernel/notes.
> > >
> > > So emit these constants in a way that prevents the linker from marking
> > > them as relocatable. This involves place-relative relocations (which
> > > subtract their own virtual address from the symbol value) and linker
> > > provided absolute symbols that add the address of the place to the
> > > desired value.
> > >
> > > While at it, switch to a 32-bit field for XEN_ELFNOTE_PHYS32_ENTRY,
> > > which better matches the intent as well as the Xen documentation and
> > > source code.
> >
> > QEMU parses this according to the ELF bitness.  It looks like this reads
> > 8 bytes on 64bit, and 4 on 32.  So I think this change would break its
> > parsing.
> >
>
> Indeed, well spotted.
>
> > (I don't use QEMU PVH and I'm not that familiar with its implementation.)
> >
>
> This is what I used for testing, and it worked fine.
>
> But looking at the code, it does dereference a size_t*, which seems
> bizarre but will clearly produce garbage in the upper bits if the note
> is 32-bits only and followed by unrelated non-zero data.
>
> I'll just back out this part of the change - it isn't really necessary anyway.

... and fix QEMU as well:

https://lore.kernel.org/qemu-devel/20240927071950.1458596-1-ardb+git@google.com/T/#u

