Return-Path: <linux-kernel+bounces-411478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E70D9CFA76
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 23:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABCCE1F22604
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 22:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536E014F9D9;
	Fri, 15 Nov 2024 22:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZMbAD6b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B509016F0FE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 22:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731711336; cv=none; b=oSgDxo0ifJatnlo4wKwi5LjGG8S6Zz03M6ZQiXgSkqadMJYwVXbliP+rIhNwKGQB+xhEP3pU52/oywpqf6o8O4YQd6SmWzVSnMT3RtZrfKAuyJxyxK8FeacQP+DV8Na6nt9uFr56nENkOMIEM9xBetlZ65jJFhmJYxiw2csXJ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731711336; c=relaxed/simple;
	bh=zMB/Lu8tWduDzFZNtWpfx6xDX6n8UlW9nfqOIsyqsx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lPId/+oNsh99W74v1wjPqPMW++kD5SWcyptqTZUV8S/aN2Ass+tnlh/PGminOJhfU4HfUEkRiX3QGLTE2tTFW81Kx2KfN5tbxvwPwnc/o8nu/EEb4TwQ28g2LnVpX2grcfrFLlYC3n5rWbSpEbwZ+dESJDvNytoWm2Zfh17PmEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZMbAD6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A87C4CED7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 22:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731711336;
	bh=zMB/Lu8tWduDzFZNtWpfx6xDX6n8UlW9nfqOIsyqsx0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BZMbAD6bUJeHbjNmpm4vlpuN8nmk/NJZsBU6MGZxnIO/HWRlZtPBh4svzJupk4HmD
	 aFktaoktSaBSeLmTFD6WR+N1sNOEXFtQXV+7T3GnqyJ7gQ4aArQw0yZ/vm4CWq9ppH
	 g0YwwxTcA5PibynfCYcJ+kCMDW+QIY63Wd0H0o4YuU4lzZ8QuxPYjUGXRJ6CiRMX0X
	 cgeMWi56/X8xyI9XN3Ptqy10raFj3Z8IU2IBmWWj+eBrLgWdljxCuaVZj4WmXHpXB1
	 /mvUQpCoqmETN1crK8fubz5df54RNwINzDX9KuuusE+NWesTd67N7HJzbgQ/GKSr1d
	 wYm6kh+syyuNQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb57f97d75so24126981fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:55:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV9AFN0wnsSXjnsBF9+rfw5x8QhFyJtCz9VBnEl0ifbsIIbAL5ZNJTZOI1iLQaClw4DM9P1qdKuP665fg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiWVutK4Gp0/9szYxGBxWrDuBCKz7D9Wi/XBPJ4h6YRVC74o+g
	g4ZK/ZR9bAYBPqO7ya7F9LI9NymL6JrAnliMa+h/JQ5M0gyHr4ACsG+qjY7AEncwSRlS3QdBWj/
	KIKqXLF75HSbC1TiQAP6a4ECOW+g=
X-Google-Smtp-Source: AGHT+IHRixSdaQmxSYNDR+PKQG4qn4jjmg3kia6WAF6J3iXju8tl9PxUMaggNO+tnBdbppJZEg+9P2Y8yUZ3+aUtX1A=
X-Received: by 2002:a2e:b88a:0:b0:2fa:c8d1:224 with SMTP id
 38308e7fff4ca-2ff608f110cmr25855131fa.2.1731711334537; Fri, 15 Nov 2024
 14:55:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115003505.9492-2-ragavendra.bn@gmail.com>
 <Zzcp75p3KTFRfW5O@gmail.com> <CAMj1kXHK4NxgWCieaQY7tT6BquSBv6Db10K8-V_8qFeZKv=BZA@mail.gmail.com>
 <ZzemwFBfEIgFhrD-@desktop>
In-Reply-To: <ZzemwFBfEIgFhrD-@desktop>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 15 Nov 2024 23:55:22 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHPut9qv7dT9Xv=xhbS6AP3HRP0dikk-G690AKfLuNLGA@mail.gmail.com>
Message-ID: <CAMj1kXHPut9qv7dT9Xv=xhbS6AP3HRP0dikk-G690AKfLuNLGA@mail.gmail.com>
Subject: Re: [PATCH] arch:x86:coco:sev: Initialize ctxt variable
To: "Ragavendra B.N." <ragavendra.bn@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, thomas.lendacky@amd.com, 
	ashish.kalra@amd.com, tzimmermann@suse.de, bhelgaas@google.com, 
	x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Nov 2024 at 20:53, Ragavendra B.N. <ragavendra.bn@gmail.com> wrote:
>
> On Fri, Nov 15, 2024 at 12:02:27PM +0100, Ard Biesheuvel wrote:
> > On Fri, 15 Nov 2024 at 12:01, Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > >
> > > * Ragavendra <ragavendra.bn@gmail.com> wrote:
> > >
> > > > Updating the ctxt value to NULL in the svsm_perform_ghcb_protocol as
> > > > it was not initialized.
> > > >
> > > > Fixes: 2e1b3cc9d7f7 (grafted) Merge tag 'arm-fixes-6.12-2' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> > >
> > > This 'Fixes' tag looks bogus.
> > >
> >
> > So does the patch itself - 'struct es_em_ctxt ctxt' is not a pointer.
> Thank you very much for your response. I am relatively new to kernel development.
>
> I know we can use kmalloc for memory allocation. Please advice.
>
> struct es_em_ctxt ctxt = kmalloc(sizeof(struct es_em_ctxt), GFP_KERNEL);
>
> I am thinking to update like above, but like you mentioned, ctxt is not a pointer. I can update this to be a pointer if needed.
>

The code is fine as is. Let's end this thread here, shall we?

