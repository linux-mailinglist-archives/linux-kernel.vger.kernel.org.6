Return-Path: <linux-kernel+bounces-170465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A59198BD785
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 00:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C19F0B23D82
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 22:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1AF15CD53;
	Mon,  6 May 2024 22:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NYqHkCYG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7485413D2BC
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 22:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715033064; cv=none; b=LqTnWrLmyBYQeLCd0OYzRa/gHXuJuezqFK8eT9M75HbnjVyv5MKMzw4dyxNe71YVTJxIohwnmvqgLyvBjkUEDbDnG9OrcfVVkAboADa6SKDvdjdET91+bXTyv4sj5twxuRAR47F3rPaobQ6IM0aKRnTNxS0p2t+/Gm6x67mHqls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715033064; c=relaxed/simple;
	bh=y1pKmLNjD6ly2wG24fibSNsxSB5FXW6x1wqjHI9K6i0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b69m8eJw+va6LcftUTjNuIAKrR2Br61Rs/ZVqfA/207Ye8mEGGKtOhC8UB2ULbbkWpw64dTHfFJsEcy+d8plQeoQ/4kHnprrd3FVt4kc2W5NHpyt+8Tk69+93y8zwIgGtcbzmThH6v4OJevi5bpiosJkIdsbFGj//aCP4gsCd/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NYqHkCYG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715033061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dX6hpaztuk6FCu0Ua3+psQvfei3hBYYAmMBnV3oJJsA=;
	b=NYqHkCYGqWfvLGvTgXnvTKDDaKXxdN39Z9ZbYizALV/JRpjX2h3DXXgAYjRwMtbHazI/X8
	yOTUigkpwTa4kCt001FCJMJy10aY+BqKE83d3eSOXUvzecBKXTrNtLkcJM6qqiUZdvSY8r
	JGfnv2krtAy2EKCqrgd4n8ep0DpHmf0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-1jbfBUfMM3ub7kA8mdiynQ-1; Mon, 06 May 2024 18:04:20 -0400
X-MC-Unique: 1jbfBUfMM3ub7kA8mdiynQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2b432dfdcf6so2079513a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 15:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715033059; x=1715637859;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dX6hpaztuk6FCu0Ua3+psQvfei3hBYYAmMBnV3oJJsA=;
        b=J38FBDq4ETGTI3NOJRUtVLrbkidAdDf8zM5M9dgSuqF5PjSACNQyFJB3bJoGIf5qvl
         yLOuT4Gjh7tvSqQyFZdtFVtLOg3Zemg8e5TV5vvG9H/f9MHXvFH2B7ehVS1IDaVgJK2N
         xPLuYHmergOSaKkWrNbp1uBri/L7p1Gwh8MSGCQFG2+PCHQhqBFXOsex6+sWDVLIOI9L
         SOgvdKC1STa5dur+T241HI7eumSmOWpiOwDr+TDepoUySoGwHYleYOuuXtHgUm8EOk06
         fok+vfSNHSB6ykpWToMquzh5U6/ghQPORCq6RKgwlqjXFHAgDG0cImgOKyD85e0t9ABd
         t9oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgD+bSGSkqkuX37htexE0DTO3mXx6qwvQbm/UXzszAObjy4nq39em7wQLRjGc5seBkKDerNe9QWwFFMjRbQNN0qv9sgS1KKrdnpNDP
X-Gm-Message-State: AOJu0YwpGpnW15NdWKz0AU90/wD89AqcnjZmqHIP0zVyCP57eX2LsAdT
	6za7+q3cfDBohW3Bq7Egc9/BQhbkozLk5Pemrj7cUsR60QLHrWfK805IiGL1sqQkQq6jas1iUOm
	yzqq9iOJGCAa428lOqLaoewSlsPm4Kz6NKDAcrU/KVcULKwVilFXSnEURIx+YFQvKAnl1p0ej8i
	80Io3zKKMPyqEFyRgi3KwtFFdSu/5Bn1ofJTuG
X-Received: by 2002:a17:90a:17c1:b0:2af:d8cd:6709 with SMTP id q59-20020a17090a17c100b002afd8cd6709mr7924698pja.41.1715033059044;
        Mon, 06 May 2024 15:04:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2zU/nYRm+0zhqAwwuyjIQBHzQkepOENzhlqsbSf2KYyGDy8GlywXTpBfU5xJ6zk+uhTq28MzQM9byjYNIoJ4=
X-Received: by 2002:a17:90a:17c1:b0:2af:d8cd:6709 with SMTP id
 q59-20020a17090a17c100b002afd8cd6709mr7924653pja.41.1715033058339; Mon, 06
 May 2024 15:04:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 May 2024 15:04:17 -0700
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <86y18mq5q2.wl-maz@kernel.org>
References: <20240411-tso-v1-0-754f11abfbff@marcan.st> <20240411132853.GA26481@willie-the-truck>
 <28ab55b3-e699-4487-b332-f1f20a6b22a1@marcan.st> <20240419165809.GA4020@willie-the-truck>
 <CAOgh=Fykg3Xb8Y59R_tJ7_jXe-ozXRMQjU+qVy5DdmFn3pkcPw@mail.gmail.com>
 <CAAiTLFW8DWH-ejNgcXgr2tQxxF4pp7BNUFGyUq99BfrYx1kScQ@mail.gmail.com> <86y18mq5q2.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 6 May 2024 15:04:17 -0700
Message-ID: <CAAiTLFXOX1sgAYM26NBVG9ROpNAD9Ns9X+JZBig+sqeWnacWmg@mail.gmail.com>
Subject: Re: [PATCH 0/4] arm64: Support the TSO memory model
To: Marc Zyngier <maz@kernel.org>
Cc: Eric Curtin <ecurtin@redhat.com>, Will Deacon <will@kernel.org>, 
	Hector Martin <marcan@marcan.st>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Zayd Qumsieh <zayd_qumsieh@apple.com>, 
	Justin Lu <ih_justin@apple.com>, Ryan Houdek <Houdek.Ryan@fex-emu.org>, 
	Mark Brown <broonie@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
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

Marc Zyngier <maz@kernel.org> writes:

> On Mon, 06 May 2024 12:21:40 +0100,
> Sergio Lopez Pascual <slp@redhat.com> wrote:
>>
>> Eric Curtin <ecurtin@redhat.com> writes:
>>
>> > On Fri, 19 Apr 2024 at 18:08, Will Deacon <will@kernel.org> wrote:
>> >>
>> >> On Thu, Apr 11, 2024 at 11:19:13PM +0900, Hector Martin wrote:
>> >> > On 2024/04/11 22:28, Will Deacon wrote:
>> >> > >   * Some binaries in a distribution exhibit instability which goes away
>> >> > >     in TSO mode, so a taskset-like program is used to run them with TSO
>> >> > >     enabled.
>> >> >
>> >> > Since the flag is cleared on execve, this third one isn't generally
>> >> > possible as far as I know.
>> >>
>> >> Ah ok, I'd missed that. Thanks.
>> >>
>> >> > > In all these cases, we end up with native arm64 applications that will
>> >> > > either fail to load or will crash in subtle ways on CPUs without the TSO
>> >> > > feature. Assuming that the application cannot be fixed, a better
>> >> > > approach would be to recompile using stronger instructions (e.g.
>> >> > > LDAR/STLR) so that at least the resulting binary is portable. Now, it's
>> >> > > true that some existing CPUs are TSO by design (this is a perfectly
>> >> > > valid implementation of the arm64 memory model), but I think there's a
>> >> > > big difference between quietly providing more ordering guarantees than
>> >> > > software may be relying on and providing a mechanism to discover,
>> >> > > request and ultimately rely upon the stronger behaviour.
>> >> >
>> >> > The problem is "just" using stronger instructions is much more
>> >> > expensive, as emulators have demonstrated. If TSO didn't serve a
>> >> > practical purpose I wouldn't be submitting this, but it does. This is
>> >> > basically non-negotiable for x86 emulation; if this is rejected
>> >> > upstream, it will forever live as a downstream patch used by the entire
>> >> > gaming-on-Mac-Linux ecosystem (and this is an ecosystem we are very
>> >> > explicitly targeting, given our efforts with microVMs for 4K page size
>> >> > support and the upcoming Vulkan drivers).
>>
>> In addition to the use case Hector exposed here, there's another,
>> potentially larger one, which is running x86_64 containers on aarch64
>> systems, using a combination of both Virtualization and emulation.
>>
>> In this scenario, both not being able to use TSO for emulation
>> and having to enable it all the time for the whole VM have a very large
>> impact on performance (~25% on some workloads).
>
> Well, there is always a price to pay somewhere, and this is the usual
> trade-off between performance and maintainability.

Yes, and given that the impact on performance is so big, I honestly
think it's worth exploring a bit if there's an option that could keep
the maintenance cost at an acceptable level.

>> I understand the concern about the risk of userspace fragmentation, but
>> I was wondering if we could minimize it to an acceptable level by
>> narrowing down the context. For instance, since both use cases we're
>> bringing to the table imply the use of Virtualization, we should be able
>> to restrict PR_SET_MEM_MODEL to only be accepted when running on EL1
>> (and not in nVHE nor pKVM), returning EINVAL otherwise. This would
>> heavily discourage users from relying on this feature for native
>> applications that can run on arbitrary contexts, hence drastically
>> reducing the fragmentation risk.
>
> As I explained in another sub-thread[1], I am not prepared to allow
> non architectural state to be exposed to a guest.  I'm also not
> prepared to make significant ABI differences between VHE, nVHE, hVHE,
> with or without pKVM, because the job of the kernel is to abstract
> those differences.

I understand, makes sense.

>> We would still need a way to ensure the trap gets to the VMM and for
>> the VMM to operate on the impdef ACTLR_EL12, but that should be dealt on
>> a different series.
>
> The VMM can't use ACTLR_EL12, by the very definition of this register
> (the clue is in the name).  You'd have to proxy the write in the
> kernel and context-switch it, which means adding non-architectural
> state to KVM, breaking VM migration and adding more kludges to the
> existing Apple-specific host crap.

I know, I just didn't want to go into details here, because this series
is not touching any of that. But since we're already there, I'd like to
ask you, do you think it'd be possible and reasonable dealing with
IMPDEF registers outside of KVM, from a platform-specific module,
treating it like a paravirt feature?

In fact, if that would be acceptable, what if we treated this whole
feature as a platform-specific knob leaving both the ARM64 ABI and KVM
(mostly) aside?

I'm thinking of something in the lines of this:

- Host side:

  * Having vcpu load/put calling into some platform-specific module that
    would be in charge of keeping track of the desired state for a
    particular context and adjusting ACTLR_EL12 as needed, relieving KVM
    from this task and avoiding polluting its structs with
    non-architectural state.

  * Either having a kernel handler for the TACR trap that would call to
    the platform-specific module, or allowing the VMM to request the
    kernel to exit to it when that trap is triggered. The latter would
    also require the module to expose a device node with an ioctl
    interface (independent from KVM's) for the VMM to request the
    desired TSO stategy for a particular thread.

  * An alternative to the previous point could be enabling the VMM to be
    able to request KVM to start a VM with HCR_EL2.TACR = 0. This one
    would be way cheaper in CPU time, and would simplify the
    platform-specific module job to just save/restore ACTLR_EL12 for
    that context, but I guess it could potentially introduce some
    undesired variance between VM configurations. I'm honestly open to
    both options, please let me know if you find one to be better for
    KVM.

- Guest side:

  * Wiring __switch_to() to also call the platform-specific module. Akin
    to what happens with KVM, this one would be in charge of keeping
    track of the threads that want TSO enabled, adjusting ACTLR_EL1
    accordingly.

  * Having the platform-specific module expose a device node with an
    ioctl interface for userspace applications to request TSO to be
    enabled for the current thread.

I think an approach like this would address the ARM64 userspace
fragmentation concerns, relieve KVM from carrying a platform-specific
burden and reduce the maintenance costs to a reasonable level. WDYT?

> Also, let's realise that we are talking about making significant
> changes to the arm64 ABI for a platform that is still not fully
> supported in the upstream kernel. I have the feeling that changing the
> memory model dynamically may not be of the utmost priority until then.

Please note this feature will also be used by Linux running in a VM on
macOS under Hypervisor.framework, so Asahi isn't the only platform. This
raises significantly the number of users potentially benefited by
emulators being able to operate the TSO knob.

Thanks,
Sergio.


