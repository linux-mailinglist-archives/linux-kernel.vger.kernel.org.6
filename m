Return-Path: <linux-kernel+bounces-256614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2069C935116
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 19:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81FD8B21B1F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94662145359;
	Thu, 18 Jul 2024 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LmOsclIT"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753C8144D3E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721322552; cv=none; b=QzLpNvMlRNHtu8DkdWSoODaTNieB5GsJcNxfMNmUJwvXYbqXz+vuUPfFOXctH+lWuq6xIKJNsTHwVB9TU4d6Rs3+UC86pQ7nprivT7u5001yp8DcDQy+QIgBsNmvDt11+uClU5XpPCHDzMO0L6F1xXC8Q3XaKeGquFKj/Q8fo+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721322552; c=relaxed/simple;
	bh=hfptMg5b01LvLxc2SG4Uz4PY1885pejHBHnSI3jHNo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VlHx3yMtyyW0HnHud2DHTxrseBCheJQz1RYBxPXWlEKwLpADkm+UMe532ugTewTIrX5gQ+Ys3jNJCoVDpXBxVX4+YMAQddwETpcRjriTLY3fQDHoWyUaYSTE9ipHDJ0OkBvpTBAQA0ZbK9NMK5zoGrK/IKHIT4II1wmECUDwyXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LmOsclIT; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc312a36f9so9955ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721322551; x=1721927351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfptMg5b01LvLxc2SG4Uz4PY1885pejHBHnSI3jHNo4=;
        b=LmOsclITNClWJfccpQJt2d2iHpl/UCf69BGG/qXacLLcSjuk07wmb42ijg/DHol4Wu
         zzaRt3nYlqxI32p6P3fknA9c1Jnu/XObYxmdhrhY+cnHyFFJz8qWMKvrgTMYmwvSPLuE
         7MDiShHq/qqCzvOHCZY+Tb7HyCB0yk+1whAA60XKsDW47S0cCQ3Q3T/7DXV6FBI/DQRf
         +PF+YmJLrKj0iFvY6MQNv8MLcwJEViYdCZ4QPYVB9536ExbIn4vAiqZy4ntmZD6RFhfi
         DAWXSSyCB4AJwuH/TkY1UKengFCJrD3kW9BupQa17aMPlprq0yK/DC7p8FFd91bO3KPe
         yyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721322551; x=1721927351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfptMg5b01LvLxc2SG4Uz4PY1885pejHBHnSI3jHNo4=;
        b=tUV47hwdUfbIKHfuS0o6mdZxibbfugt3fQs7xrWLtDcBB7m52z10RhSB+s9PDHUjsN
         xLd+utb5ySwR0ZWYDzZV0NCvfPM4Pfva/SNKn3rtdllE1eVuCamBK+vVi07pH22JGvu1
         ozXMyAraimGbJbyHGLHih9/nJUCmAM4Ht4TTfs5I7YTQEZvBkqY3BrapZXKqebqbGPSE
         /kgv5SuyQE2lymhiV/VJ2tmsCEZjDNgSOIWOUhd/XDCgW/g4BoBhYwgqOVhCGzHM5XLp
         VSZ7IqzYLvVRDsIGzr3k3S1wlqTM7TaeXMnVE7edRj0Zeu2CsWFtPXD95WwuQSLE4Vp8
         IdWA==
X-Forwarded-Encrypted: i=1; AJvYcCVazqqHHsdKA1Owfrmy3+pre7nly2A0b2T954OjRhyuHJpdzQrD6ovghIhj4czeLoXumf3yZf+Dzgls77W+JvdGLcPlYaSfRn05v9D5
X-Gm-Message-State: AOJu0YyRUMQTuStmUdtUi8V1OnbYSIyq7TSJKCi+y+zU+vdu40RilXj0
	vJk4ZMoIOBZFNJAmGkJJjAFy0Njm2wdJ6SDxPMBDN94fiTGC0xboF0bCtMKRliJ9xM3WHEEJ20T
	TVWgM/YLx5wcLTBerPgYwrXCSUgAhbCcQ7D1/
X-Google-Smtp-Source: AGHT+IFyQOwgVWytrps02GnyGzCKWAzKQb9jdGG6O5HjYS2fonQnaQCgjBSaqq+ZRXTyamSyDlrVjFSIa0H9hip10Ho=
X-Received: by 2002:a17:903:183:b0:1f7:1c96:d2e8 with SMTP id
 d9443c01a7336-1fc5f58803emr2989145ad.10.1721322550399; Thu, 18 Jul 2024
 10:09:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710234222.2333120-1-jthoughton@google.com>
 <20240710234222.2333120-9-jthoughton@google.com> <DS0PR11MB6373C1BE8CF5E1BCC9F2365BDCA32@DS0PR11MB6373.namprd11.prod.outlook.com>
In-Reply-To: <DS0PR11MB6373C1BE8CF5E1BCC9F2365BDCA32@DS0PR11MB6373.namprd11.prod.outlook.com>
From: James Houghton <jthoughton@google.com>
Date: Thu, 18 Jul 2024 10:08:33 -0700
Message-ID: <CADrL8HVDUG7OSN2ERmmiXeg8eT8D6edoSiqYKsnjAnVbhGAX9Q@mail.gmail.com>
Subject: Re: [RFC PATCH 08/18] KVM: x86: Add KVM Userfault support
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, David Matlack <dmatlack@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 8:34=E2=80=AFAM Wang, Wei W <wei.w.wang@intel.com> =
wrote:
>
> On Thursday, July 11, 2024 7:42 AM, James Houghton wrote:
> > The first prong for enabling KVM Userfault support for x86 is to be abl=
e to
> > inform userspace of userfaults. We know when userfaults occurs when
> > fault->pfn comes back as KVM_PFN_ERR_FAULT, so in
> > kvm_mmu_prepare_memory_fault_exit(), simply check if fault->pfn is inde=
ed
> > KVM_PFN_ERR_FAULT. This means always setting fault->pfn to a known valu=
e (I
> > have chosen KVM_PFN_ERR_FAULT) before calling
> > kvm_mmu_prepare_memory_fault_exit().
> >
> > The next prong is to unmap pages that are newly userfault-enabled. Do t=
his in
> > kvm_arch_pre_set_memory_attributes().
>
> Why is there a need to unmap it?
> I think a userfault is triggered on a page during postcopy when its data =
has not yet
> been fetched from the source, that is, the page is never accessed by gues=
t on the
> destination and the page table leaf entry is empty.
>

You're right that it's not strictly necessary for implementing
post-copy. This just comes down to the UAPI we want: does
ATTRIBUTE_USERFAULT mean "KVM will be unable to access this memory;
any attempt to access it will generate a userfault" or does it mean
"accesses to never-accessed, non-prefaulted memory will generate a
userfault."

I think the former (i.e., the one implemented in this RFC) is slightly
clearer and slightly more useful.

Userfaultfd does the latter:
1. MAP_PRIVATE|MAP_ANONYMOUS + UFFDIO_REGISTER_MODE_MISSING: if
nothing is mapped (i.e., major page fault)
2. non-anonymous VMA + UFFDIO_REGISTER_MODE_MISSING: if the page cache
does not contain a page
3. MAP_SHARED + UFFDIO_REGISTER_MODE_MINOR: if the page cache
*contains* a page, but we got a fault anyway

But in all of these cases, we have a way to start getting userfaults
for already-accessed memory: for (1) and (3), MADV_DONTNEED, and for
(2), fallocate(FALLOC_FL_PUNCH_HOLE).

Even if we didn't have MADV_DONTNEED (as used to be the case with
HugeTLB), we can use PROT_NONE to prevent anyone from mapping anything
in between an mmap() and a UFFDIO_REGISTER. This has been useful for
me.

With KVM, we have neither of these tools (unless we include them here), AFA=
IA.

