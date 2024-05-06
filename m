Return-Path: <linux-kernel+bounces-170154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 300A48BD287
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC1E2870E9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9ED315688E;
	Mon,  6 May 2024 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BFNYFuhd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE8C156657
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715012485; cv=none; b=H1ph35s8/4lErEUEXAQjCKbcXGg+tueYRLBDIHfRUMIAXgQvu4Wkn6MA2lvfmgMS48wtUzJaeoPTz+mEI8C/L5dijUpz7sOyRRHzhd9mx9iqwjtXI8i4mSmvjTuWOhsWbMHeAwif+SbaqUV1GaxBdYrrDQ7XCqle6UJMPyn2Cs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715012485; c=relaxed/simple;
	bh=FNqnC2c9zmHzy0ilZkz1ephneYy3eKn4srXeUWAvuPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T1tbzZ+WCKvQc7cgPoP8NhJrV42Hlw8NUsnJRbybnqhFdmSuUWqvAwdU1HWHHLB787CZTzOhAy0lN98KCI+jvHJY5ZDZogdZRjxmQpS+hVbyUKf++mz43j2w3nrB90SrzRbrPjCAuobKlOFbY6pwlsBCt3p5kYlhw0M5VA4WIN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BFNYFuhd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715012483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4NFLhoz3on1oTZbaory8Am+rpsu/luJeNYW9SKD/foM=;
	b=BFNYFuhdstljJYpZquRAEMqHQNuhB/jRg7ml8pVxFgzWcFr8dkurW7aMpVbwhrA6lyqQcS
	d3HszrWMYOBZs2eRs/FofuuBW0c1bSSxyNaNLr4CkzRTZeWJ/g9J4sbmjGQLTAphP5ypuZ
	mMzcPg3s611K4Otzpui5MstU06TRntM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-0sJtQgKyMqSUEghDjRObLA-1; Mon, 06 May 2024 12:21:21 -0400
X-MC-Unique: 0sJtQgKyMqSUEghDjRObLA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2b337e189ecso1755529a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 09:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715012481; x=1715617281;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4NFLhoz3on1oTZbaory8Am+rpsu/luJeNYW9SKD/foM=;
        b=w852o91hIThELVYCYbwSs0aarGvytoPYqTwhwsw1raRP7Q4EbEtzqHcOIncNsPC0Di
         STyUOWY+j1w1xxAUlZpg2jQbkTkDcxdr0xfly701O76AMl8Oj4WXLsos/ub5qWwzROs/
         gkhK1OqH2u2K/hNmURzkScyFLHk8PqH3cxhye594kS06Pj4CtC6JD7VQRPRqWTiWdD0i
         e2BIBb+VZ87MaCZIFh7spDN9Jpjz+sxuYOs0K7Eig+soXTHkCldwV48vt+bSghqYzXXZ
         vrE2d/5RRwtrxeY6HfOyw/PnMBB6qfvLfavE+oT3qaiTrGO+y68TScgmduOwFiyNudeC
         YupQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTgXNK22njHno8XkUdtJUAVBifv+thiNlyZXVwT59K1LLh7OD42VT+z5Q7jN86/JLherT4+dzXqNP600TNPNL/d45z/5ewcnV+OGrV
X-Gm-Message-State: AOJu0Ywn+PDKviZr4akvVfpJF/D8ZAHM4cC6U/3q8OTkXw1JCUt2o225
	ntCR1XjiXnoq1DMQPPzeJUk8NaqwdOTbGvoZGmUEZ+Nq9uhEj64XViSeZkwJYFEWk/BpZwNPXkv
	YQ/Da9khzppb5NTRK2W/R8MD1/xl88lgaZCcZ2Qv+RHsh7em679rOrR2XF/Yx0m9rZSpueHULk7
	2kZG3DlyQCZeYScDh6qKThv0B+YQVQZRtAUQ+B
X-Received: by 2002:a17:90b:1295:b0:2b2:b1c7:5fd7 with SMTP id fw21-20020a17090b129500b002b2b1c75fd7mr8924069pjb.30.1715012480639;
        Mon, 06 May 2024 09:21:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdF9xGjbBlWkHmhqmilAg9LqASzYwWuG5m6xpJmC2hsZJZNNDuBHVwYYGR7aafGK9BlTi9YmmdRxWnT37Embg=
X-Received: by 2002:a17:90b:1295:b0:2b2:b1c7:5fd7 with SMTP id
 fw21-20020a17090b129500b002b2b1c75fd7mr8924016pjb.30.1715012480042; Mon, 06
 May 2024 09:21:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411-tso-v1-0-754f11abfbff@marcan.st> <20240411132853.GA26481@willie-the-truck>
 <28ab55b3-e699-4487-b332-f1f20a6b22a1@marcan.st> <20240419165809.GA4020@willie-the-truck>
 <CAOgh=Fykg3Xb8Y59R_tJ7_jXe-ozXRMQjU+qVy5DdmFn3pkcPw@mail.gmail.com>
 <CAAiTLFW8DWH-ejNgcXgr2tQxxF4pp7BNUFGyUq99BfrYx1kScQ@mail.gmail.com> <86y18mq5q2.wl-maz@kernel.org>
In-Reply-To: <86y18mq5q2.wl-maz@kernel.org>
From: Eric Curtin <ecurtin@redhat.com>
Date: Mon, 6 May 2024 17:20:43 +0100
Message-ID: <CAOgh=FwcLpmqCmKyZNh1CGiGYyHS8u29+v2SmyNfnz6YnS6LZQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] arm64: Support the TSO memory model
To: Marc Zyngier <maz@kernel.org>
Cc: Sergio Lopez Pascual <slp@redhat.com>, Will Deacon <will@kernel.org>, Hector Martin <marcan@marcan.st>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Zayd Qumsieh <zayd_qumsieh@apple.com>, Justin Lu <ih_justin@apple.com>, 
	Ryan Houdek <Houdek.Ryan@fex-emu.org>, Mark Brown <broonie@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Miguel Luis <miguel.luis@oracle.com>, Joey Gouly <joey.gouly@arm.com>, 
	Christoph Paasch <cpaasch@apple.com>, Kees Cook <keescook@chromium.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Baoquan He <bhe@redhat.com>, 
	Joel Granados <j.granados@samsung.com>, Dawei Li <dawei.li@shingroup.cn>, 
	Andrew Morton <akpm@linux-foundation.org>, Florent Revest <revest@chromium.org>, 
	David Hildenbrand <david@redhat.com>, Stefan Roesch <shr@devkernel.io>, Andy Chiu <andy.chiu@sifive.com>, 
	Josh Triplett <josh@joshtriplett.org>, Oleg Nesterov <oleg@redhat.com>, Helge Deller <deller@gmx.de>, 
	Zev Weiss <zev@bewilderbeest.net>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Miguel Ojeda <ojeda@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Asahi Linux <asahi@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 May 2024 at 17:13, Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 06 May 2024 12:21:40 +0100,
> Sergio Lopez Pascual <slp@redhat.com> wrote:
> >
> > Eric Curtin <ecurtin@redhat.com> writes:
> >
> > > On Fri, 19 Apr 2024 at 18:08, Will Deacon <will@kernel.org> wrote:
> > >>
> > >> On Thu, Apr 11, 2024 at 11:19:13PM +0900, Hector Martin wrote:
> > >> > On 2024/04/11 22:28, Will Deacon wrote:
> > >> > >   * Some binaries in a distribution exhibit instability which goes away
> > >> > >     in TSO mode, so a taskset-like program is used to run them with TSO
> > >> > >     enabled.
> > >> >
> > >> > Since the flag is cleared on execve, this third one isn't generally
> > >> > possible as far as I know.
> > >>
> > >> Ah ok, I'd missed that. Thanks.
> > >>
> > >> > > In all these cases, we end up with native arm64 applications that will
> > >> > > either fail to load or will crash in subtle ways on CPUs without the TSO
> > >> > > feature. Assuming that the application cannot be fixed, a better
> > >> > > approach would be to recompile using stronger instructions (e.g.
> > >> > > LDAR/STLR) so that at least the resulting binary is portable. Now, it's
> > >> > > true that some existing CPUs are TSO by design (this is a perfectly
> > >> > > valid implementation of the arm64 memory model), but I think there's a
> > >> > > big difference between quietly providing more ordering guarantees than
> > >> > > software may be relying on and providing a mechanism to discover,
> > >> > > request and ultimately rely upon the stronger behaviour.
> > >> >
> > >> > The problem is "just" using stronger instructions is much more
> > >> > expensive, as emulators have demonstrated. If TSO didn't serve a
> > >> > practical purpose I wouldn't be submitting this, but it does. This is
> > >> > basically non-negotiable for x86 emulation; if this is rejected
> > >> > upstream, it will forever live as a downstream patch used by the entire
> > >> > gaming-on-Mac-Linux ecosystem (and this is an ecosystem we are very
> > >> > explicitly targeting, given our efforts with microVMs for 4K page size
> > >> > support and the upcoming Vulkan drivers).
> >
> > In addition to the use case Hector exposed here, there's another,
> > potentially larger one, which is running x86_64 containers on aarch64
> > systems, using a combination of both Virtualization and emulation.
> >
> > In this scenario, both not being able to use TSO for emulation
> > and having to enable it all the time for the whole VM have a very large
> > impact on performance (~25% on some workloads).
>
> Well, there is always a price to pay somewhere, and this is the usual
> trade-off between performance and maintainability.
>
> > I understand the concern about the risk of userspace fragmentation, but
> > I was wondering if we could minimize it to an acceptable level by
> > narrowing down the context. For instance, since both use cases we're
> > bringing to the table imply the use of Virtualization, we should be able
> > to restrict PR_SET_MEM_MODEL to only be accepted when running on EL1
> > (and not in nVHE nor pKVM), returning EINVAL otherwise. This would
> > heavily discourage users from relying on this feature for native
> > applications that can run on arbitrary contexts, hence drastically
> > reducing the fragmentation risk.
>
> As I explained in another sub-thread[1], I am not prepared to allow
> non architectural state to be exposed to a guest.  I'm also not
> prepared to make significant ABI differences between VHE, nVHE, hVHE,
> with or without pKVM, because the job of the kernel is to abstract
> those differences.
>
> > We would still need a way to ensure the trap gets to the VMM and for
> > the VMM to operate on the impdef ACTLR_EL12, but that should be dealt on
> > a different series.
>
> The VMM can't use ACTLR_EL12, by the very definition of this register
> (the clue is in the name).  You'd have to proxy the write in the
> kernel and context-switch it, which means adding non-architectural
> state to KVM, breaking VM migration and adding more kludges to the
> existing Apple-specific host crap.
>
> Also, let's realise that we are talking about making significant
> changes to the arm64 ABI for a platform that is still not fully
> supported in the upstream kernel. I have the feeling that changing the

Note there's two use-cases for this today, bare-metal Linux on Apple
Silicon devices and Linux VMs on macOS. The latter is fully supported
in the upstream kernel.

Apple Silicon devices have a significantly sized Linux userbase as
there is a shortage of decent local ARM development machines for Linux
as well as just being decent local laptop/desktop SoC's in general for
AI. The general performance of the SoC makes it very useful.

Is mise le meas/Regards,

Eric Curtin

> memory model dynamically may not be of the utmost priority until then.
>
> Thanks,
>
>         M.
>
> [1] https://lore.kernel.org/all/867cgcqrb9.wl-maz@kernel.org
>
> --
> Without deviation from the norm, progress is not possible.
>


