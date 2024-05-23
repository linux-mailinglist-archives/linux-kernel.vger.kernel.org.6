Return-Path: <linux-kernel+bounces-186929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F26678CCAE2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 04:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5936282AB0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 02:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC4E13A41C;
	Thu, 23 May 2024 02:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNjISuj9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0781852
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 02:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716432858; cv=none; b=TEgyqNMo+X3bC5HTcOmB6NFhizAwcbHvgJP7x7CT+TcOXQyP8g3SVxWte0DA4XL99UhWfzgz9B0yS45mrY7VxCyIdowZy3FnubyK4d84f0WBNRe+0jKROFmPp0S5eGgfsAXLwNAH9VYH7TjOv0SIEnLtooY2WcqwbvUjMJETKX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716432858; c=relaxed/simple;
	bh=KIPFXtgeVsYCx+TPE+Omq9vOJHTDlUHEkkIB6RiQCJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T26a6QB+joZHeMiHqXOQOWcio6Z5dfuDW8Hs1IOdJJgrYbTg6pwliHQmmP+wyWU4WJr43vIYBg69ftrYxWqyvRUqB3Sl8h9aty+4cinB5DRjetFtrAr05WiisAJcSxb7UnLb9ZIe5WAb5tDiAiJOwzPthJ37ZOuSB8LbtSCX++E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eNjISuj9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716432855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u7PAynGSneULEGsZEeUTDx10vqiJthWdZNRrBnIUivM=;
	b=eNjISuj9FmFbmLR00qRgQ/RzEJgw4r2Qt7Tcw7goUgAK5Dno6Yekhi3YROn2zACpE5P8Z2
	x3Y1hyDv4PEMTmZ4vbQK712hCBqDNXP8okqLBKuWIyrxcU6x+khuEZKp9VK0cbG6zygk49
	LPwmyDQGFdkyqmE3qt4Yb5bgrEglQsM=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-sEbJAKIZOseagIPaK37I7Q-1; Wed, 22 May 2024 22:54:13 -0400
X-MC-Unique: sEbJAKIZOseagIPaK37I7Q-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36c854ced78so4011325ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 19:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716432853; x=1717037653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7PAynGSneULEGsZEeUTDx10vqiJthWdZNRrBnIUivM=;
        b=Nktsy5JGWSb4UgeqeoYg/5yvmKtwxG4R4r7w/zGnlHXbrqDJ+GcVAC76hMEzC7INXO
         ZgAc+dLACQFO89dbEpU3sD1injIH8/aOWG9ig1FgAWEF/sfHVIduxOyoMg9aYgIJaGuN
         X/GSvxZudNNHi97zlbmvVpisc8pcKWcvTK10akpG2c/rqG5eo7slofow3C//qaZDMbAg
         wQA99A1H203RtnbzepLbgAJdZF2IwSBiTkkr748qVOWauU4IAKVG/+4RSkL/yGBbOWLJ
         ujFz2t1yZNeC1u8RDIVpGt8iDDy67GAp+2I5dOO8ja/2WgTWqEWU7817OtWCGnHUjAvr
         kkwA==
X-Forwarded-Encrypted: i=1; AJvYcCWC2jOMMNJmjubDGJJJEwCZOIfoxKwrcnR+HBjJ5aLWnpcxd8VXYg/V79BSE9rM2rAOGeJ+/KTnh4HmMnuXGJjCyg0VhpRQUQWsb/IL
X-Gm-Message-State: AOJu0YyZ7DOE3HFz42/bcjo+M4qtlLoHTtSnwshgdRnSs2yRfMWdSBjo
	GT0tA3ynAoFrDgJs7ZHDQz9GaYJkVGWaiA+46NT5VuHW4LV0qdYmE/q4VIdVdqUaSPtsd19qeNj
	H01pccyjFccntsKkAzSRUh/cJFE2HmY2AWjmh9suuzEfUJUCqTSDdplvbFqHr6ZOnoi/aL0KUFA
	mJPIBrk9JWYCTamQ2EKX1E/AT1v2YFBtFJq0Yu
X-Received: by 2002:a05:6e02:1447:b0:36c:3856:4386 with SMTP id e9e14a558f8ab-371f92ff411mr48838645ab.3.1716432852967;
        Wed, 22 May 2024 19:54:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoUKoGiEr3/sh0h7NFbA0eRmtxogyNERfkCpDAdV/NZDOzIG/XLDnnztL7o7uIwbdWdpTl7hmrnVgYmwuDbbI=
X-Received: by 2002:a05:6e02:1447:b0:36c:3856:4386 with SMTP id
 e9e14a558f8ab-371f92ff411mr48838235ab.3.1716432852467; Wed, 22 May 2024
 19:54:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520183633.1457687-1-steve.wahl@hpe.com> <CALu+AoQGvHzkoRPvAwqaCCokOBsjQ7tDwMVwgyOMUqKm=tEkuQ@mail.gmail.com>
In-Reply-To: <CALu+AoQGvHzkoRPvAwqaCCokOBsjQ7tDwMVwgyOMUqKm=tEkuQ@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 23 May 2024 10:54:33 +0800
Message-ID: <CALu+AoR_OZbrrVWL_2EbDB-ctSR28+006q+nHhwgZ55QhK0qSw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Resolve problems with kexec identity mapping
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	Pavin Joseph <me@pavinjoseph.com>, Eric Hagberg <ehagberg@gmail.com>, 
	Simon Horman <horms@verge.net.au>, Eric Biederman <ebiederm@xmission.com>, Sarah Brofeldt <srhb@dbc.dk>, 
	Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Yuntao Wang <ytcoode@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Joerg Roedel <jroedel@suse.de>, Michael Roth <michael.roth@amd.com>, Tao Liu <ltao@redhat.com>, 
	kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Cc kexec list as well.

On Thu, 23 May 2024 at 10:52, Dave Young <dyoung@redhat.com> wrote:
>
> Add Tao in the cc list.
>
> On Tue, 21 May 2024 at 02:37, Steve Wahl <steve.wahl@hpe.com> wrote:
> >
> > Although there was a previous fix to avoid early kernel access to the
> > EFI config table on Intel systems, the problem can still exist on AMD
> > systems that support SEV (Secure Encrypted Virtualization).  The
> > command line option "nogbpages" brings this bug to the surface.  And
> > this is what caused the regression with my earlier patch that
> > attempted to reduce the use of gbpages.  This patch series fixes that
> > problem and restores my earlier patch.
> >
> > The following 2 commits caused the EFI config table, and the CC_BLOB
> > entry in that table, to be accessed when enabling SEV at kernel
> > startup.
> >
> >     commit ec1c66af3a30 ("x86/compressed/64: Detect/setup SEV/SME features
> >                           earlier during boot")
> >     commit c01fce9cef84 ("x86/compressed: Add SEV-SNP feature
> >                           detection/setup")
> >
> > These accesses happen before the new kernel establishes its own
> > identity map, and before establishing a routine to handle page faults.
> > But the areas referenced are not explicitly added to the kexec
> > identity map.
> >
> > This goes unnoticed when these areas happen to be placed close enough
> > to others areas that are explicitly added to the identity map, but
> > that is not always the case.
> >
> > Under certain conditions, for example Intel Atom processors that don't
> > support 1GB pages, it was found that these areas don't end up mapped,
> > and the SEV initialization code causes an unrecoverable page fault,
> > and the kexec fails.
> >
> > Tau Liu had offered a patch to put the config table into the kexec
> > identity map to avoid this problem:
> >
> > https://lore.kernel.org/all/20230601072043.24439-1-ltao@redhat.com/
> >
> > But the community chose instead to avoid referencing this memory on
> > non-AMD systems where the problem was reported.
> >
> >     commit bee6cf1a80b5 ("x86/sev: Do not try to parse for the CC blob
> >                           on non-AMD hardware")
> >
> > I later wanted to make a different change to kexec identity map
> > creation, and had this patch accepted:
> >
> >     commit d794734c9bbf ("x86/mm/ident_map: Use gbpages only where full GB page should be mapped.")
> >
> > but it quickly needed to be reverted because of problems on AMD systems.
> >
> > The reported regression problems on AMD systems were due to the above
> > mentioned references to the EFI config table.  In fact, on the same
> > systems, the "nogbpages" command line option breaks kexec as well.
> >
> > So I resubmit Tau Liu's original patch that maps the EFI config
> > table, add an additional patch by me that ensures that the CC blob is
> > also mapped (if present), and also resubmit my earlier patch to use
> > gpbages only when a full GB of space is requested to be mapped.
> >
> > I do not advocate for removing the earlier, non-AMD fix.  With kexec,
> > two different kernel versions can be in play, and the earlier fix
> > still covers non-AMD systems when the kexec'd-from kernel doesn't have
> > these patches applied.
> >
> > All three of the people who reported regression with my earlier patch
> > have retested with this patch series and found it to work where my
> > single patch previously did not.  With current kernels, all fail to
> > kexec when "nogbpages" is on the command line, but all succeed with
> > "nogbpages" after the series is applied.
> >
> > Tao Liu (1):
> >   x86/kexec: Add EFI config table identity mapping for kexec kernel
> >
> > Steve Wahl (2):
> >   x86/kexec: Add EFI Confidential Computing blob to kexec identity
> >     mapping.
> >   x86/mm/ident_map: Use gbpages only where full GB page should be
> >     mapped.
> >
> >  arch/x86/kernel/machine_kexec_64.c | 82 ++++++++++++++++++++++++++++--
> >  arch/x86/mm/ident_map.c            | 23 +++++++--
> >  2 files changed, 95 insertions(+), 10 deletions(-)
> >
> > --
> > 2.26.2
> >


