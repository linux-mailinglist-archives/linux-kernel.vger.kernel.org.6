Return-Path: <linux-kernel+bounces-236437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C2991E24B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F5D42877F9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2E216133C;
	Mon,  1 Jul 2024 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G1HkP1xX"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF62B161314
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843768; cv=none; b=OKAG0dwL8WzaQAj4jrGPXD3xB1+fqSOvLlqAE2QK54Z1UsoZWo1R6ZCzTGGgPfggv/ibCXbVB0kCUA9wM21g2AebFo+zHe1nSCfznTjubCS+2FYwA3Oe4kZISqWvE4TXgUNkSvqWXkbk3lAYLxPF9CqAWK9VU6SfyYx/DccpOlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843768; c=relaxed/simple;
	bh=CL0VQcOdLknkqaZQnfKJaWCOUQd0LT7HUMHcF5iatnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USzReOpX2ijplx+AOR/hJL8my8VNJjOOSi20de9B1TcwLqPhVlOVRW696/4spE4HvrrpPwk+uN5F7kZJouGeglbxQsC7whbQcXSPXP5bgLINKnxdNNXi8+9RVbKaythrpyj5++xdiOD+OXWHTOwhWMB2gyRFEm3uWF9t74l/QYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G1HkP1xX; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4255f915611so89825e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 07:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719843765; x=1720448565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=of8h/yHjfyVd8gobR+fvjPEOrNpXyMTMcmCaItkRWUw=;
        b=G1HkP1xXpyzAFewdG9GHWP798Hf6svqkuEroSw4teqVxgqZY4GamtJ1UE4HIUX4+O/
         RR7092+e3rrNGuJ44XzImQc2XtIdkZBV+upkBApKTQrweMYId010JbS323LTzd0rajr+
         lXGtaYnFaG+/ZHMAmbNJbVGZi/uD3ggJ120Upo6RH2e2Jrw+CmxEWvV1VV/igteGjZgE
         MV6khpA88j1vfdjJm9FmvBjxQyxHda0Yj8IsEd9xiZF9KP5aBTk4m3bzYXWQyMZrHIJM
         r2r5rEes92FZzcFOihzMHlvkuYZKnvlhSLIZls8I5vJyXv9wlz8nOMoin22w+RcTJtdg
         SYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719843765; x=1720448565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=of8h/yHjfyVd8gobR+fvjPEOrNpXyMTMcmCaItkRWUw=;
        b=Uv7eIdHddJfeeLrMu0VPkfbHQP0Q/IYjwmZZ4RAhKX5m3goqptRYJbqGUc/vsoX+Ca
         bOOkxvV6hJV1bkP5Nq7rfNaUz1j1FdG4qziplXnuq1P+jx+xok0p85i33VlAQTLTpNyu
         DgTX+NxWiAoonB/Il88jwrBRzZPLDe7vYRqD3stmypn9rY1xrnmbyBZrnLZMMPRbNJV0
         laLiA5dnnfdq6Q3j3jKY6U1oGd6BlmqcPfdZ22BHdvydCegZY/PJnhaJvOWAtt3ZpjDF
         FRUoLbryHnuLJ19Nuoo10T/VC1cfiSYCXmOQBh3xrRujvBY6mYxFYBoabzM2QrBEOrPc
         nExw==
X-Forwarded-Encrypted: i=1; AJvYcCUz84q1pjapDqK3pxKc3SJkP340B3mArrWfjGheflaQztSTiTHTUduzkEg/mw56di2kErmpZhK1m2vJvYiM4JjXTkb/RCBgGkbBtbwA
X-Gm-Message-State: AOJu0YyEpb8qmj9G5t29UkoLxak6Qf1V54su4syLPY3pQg7z+VmRyt/X
	Yy8abtr0Ombp7NM0wbo/ZOtmLNL4ug5ibSRQd7rJNTugc4YUZ+lB4jSXuLnKzw==
X-Google-Smtp-Source: AGHT+IFAq/GFiNJ0adtx2OIotan4cZfIRVizFxAq75sexqi9Few6MhuACXgBYA4CjeCEBo5vIrjeuQ==
X-Received: by 2002:a05:600c:3550:b0:41a:444b:e1d9 with SMTP id 5b1f17b1804b1-425777f8671mr3614145e9.4.1719843765016;
        Mon, 01 Jul 2024 07:22:45 -0700 (PDT)
Received: from google.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4257fc934b2sm59543115e9.44.2024.07.01.07.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 07:22:44 -0700 (PDT)
Date: Mon, 1 Jul 2024 14:22:43 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: akpm@linux-foundation.org, alexghiti@rivosinc.com, ankita@nvidia.com,
	ardb@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, james.morse@arm.com,
	vdonnefort@google.com, mark.rutland@arm.com, maz@kernel.org,
	rananta@google.com, ryan.roberts@arm.com, shahuang@redhat.com,
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v7 0/6] arm64: ptdump: View the second stage page-tables
Message-ID: <ZoK7sw73g94iP050@google.com>
References: <20240621123230.1085265-1-sebastianene@google.com>
 <Zn8qRqf8VZCk0KmP@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn8qRqf8VZCk0KmP@linux.dev>

On Fri, Jun 28, 2024 at 09:25:26PM +0000, Oliver Upton wrote:

Hello Oliver,

> Hi Seb,
> 
> I think we're getting closer on this series, thanks for reposting it. In
> addition to polishing up the KVM side of things, I'd like to have acks
> on the ptdump changes (patches 2-3).
>
> Will + Catalin, any concerns?
> 
> -- 
> Thanks,
> Oliver


Thanks for the feedback, I will spin a v8 later this week if there are
no more findings on the remaining patches.

Thanks,
Sebastian

> 
> On Fri, Jun 21, 2024 at 12:32:24PM +0000, Sebastian Ene wrote:
> > Hi,
> > 
> > 
> > This series extends the ptdump support to allow dumping the guest
> > stage-2 pagetables. When CONFIG_PTDUMP_STAGE2_DEBUGFS is enabled, ptdump
> > registers '/sys/debug/kvm/<guest_id>/stage2_page_tables' entry with debugfs
> > upon guest creation. This allows userspace tools (eg. cat) to dump the
> > stage-2 pagetables by reading the registered file.
> > 
> > Reading the debugfs file shows stage-2 memory ranges in following format:
> > <IPA range> <size> <descriptor type> <access permissions> <mem_attributes>
> > 
> > Below is the output of a guest stage-2 pagetable dump running under Qemu:
> > 
> > ---[ IPA bits 33 start lvl 2 ]---
> > 0x0000000000000000-0x0000000080000000           2G PGD
> > 0x0000000080000000-0x0000000080c00000          12M PGD      R W AF        BLK
> > 0x0000000080c00000-0x0000000080e00000           2M PGD   XN R W AF        BLK
> > 0x0000000080e00000-0x0000000081000000           2M PGD      R W AF        BLK
> > 0x0000000081000000-0x0000000081400000           4M PGD   XN R W AF        BLK
> > 0x0000000081400000-0x000000008fe00000         234M PGD
> > 0x000000008fe00000-0x0000000090000000           2M PGD   XN R W AF        BLK
> > 0x0000000090000000-0x00000000fa000000        1696M PGD
> > 0x00000000fa000000-0x00000000fe000000          64M PGD   XN R W AF        BLK
> > 0x00000000fe000000-0x0000000100000000          32M PGD
> > 0x0000000100000000-0x0000000101c00000          28M PGD   XN R W AF        BLK
> > 0x0000000101c00000-0x0000000102000000           4M PGD
> > 0x0000000102000000-0x0000000102200000           2M PGD   XN R W AF        BLK
> > 0x0000000102200000-0x000000017b000000        1934M PGD
> > 0x000000017b000000-0x0000000180000000          80M PGD   XN R W AF        BLK
> > 
> > Link to v6:
> > https://lore.kernel.org/all/20240220151035.327199-1-sebastianene@google.com/
> > 
> > Link to v5:
> > https://lore.kernel.org/all/20240207144832.1017815-2-sebastianene@google.com/
> > 
> > Link to v4:
> > https://lore.kernel.org/all/20231218135859.2513568-2-sebastianene@google.com/
> > 
> > Link to v3:
> > https://lore.kernel.org/all/20231115171639.2852644-2-sebastianene@google.com/
> > 
> > Changelog:
> >  v6 -> v7:
> >  * Reworded commit for this patch : [PATCH v6 2/6] arm64: ptdump: Expose
> >    the attribute parsing functionality
> >  * fixed minor conflicts in the struct pg_state definition
> >  * moved the kvm_ptdump_guest_registration in the
> >  * kvm_arch_create_vm_debugfs
> >  * reset the parse state before walking the pagetables
> >  * copy the level name to the pg_level buffer
> > 
> > 
> >  v5 -> v6:
> >  * don't return an error if the kvm_arch_create_vm_debugfs fails to
> >    initialize (ref.
> > https://lore.kernel.org/all/20240216155941.2029458-1-oliver.upton@linux.dev/)  
> >  * fix use-after-free suggested by getting a reference to the
> >    KVM struct while manipulating the debugfs files
> >    and put the reference on the file close.
> >  * do all the allocations at once for the ptdump parser state tracking
> >    and simplify the initialization.
> >  * move the ptdump parser state initialization as part of the file_open
> >  * create separate files for printing the guest stage-2 pagetable
> >    configuration such as: the start level of the pagetable walk and the
> >    number of bits used for the IPA space representation.
> >  * fixed the wrong header format for the newly added file
> >  * include missing patch which hasn't been posted on the v5:
> >    "KVM-arm64-Move-pagetable-definitions-to-common-heade.patch" 
> > 
> > 
> >  v4 -> v5:
> >  * refactorization: split the series into two parts as per the feedback
> >    received from Oliver. Introduce the base support which allows dumping
> >    of the guest stage-2 pagetables.
> >  * removed the *ops* struct wrapper built on top of the file_ops and
> >    simplify the ptdump interface access.
> >  * keep the page table walker away from the ptdump specific code
> > 
> >   v3 -> current_version:
> >   * refactorization: moved all the **KVM** specific components under
> >     kvm/ as suggested by Oliver. Introduced a new file
> >     arm64/kvm/ptdump.c which handled the second stage translation.
> >     re-used only the display portion from mm/ptdump.c
> >   * pagetable snapshot creation now uses memory donated from the host.
> >     The memory is no longer shared with the host as this can pose a security
> >     risk if the host has access to manipulate the pagetable copy while
> >     the hypervisor iterates it.
> >   * fixed a memory leak: while memory was used from the memcache for
> >     building the snapshot pagetable, it was no longer giving back the
> >     pages to the host for freeing. A separate array was introduced to
> >     keep track of the pages allocated from the memcache.
> > 
> > 
> >   v2 -> v3:
> >   * register the stage-2 debugfs entry for the host under
> >     /sys/debug/kvm/host_stage2_page_tables and in
> >     /sys/debug/kvm/<guest_id>/stage2_page_tables for guests.
> >   * don't use a static array for parsing the attributes description,
> >     generate it dynamically based on the number of pagetable levels
> >   * remove the lock that was guarding the seq_file private inode data,
> >     and keep the data private to the open file session.
> >   * minor fixes & renaming of CONFIG_NVHE_EL2_PTDUMP_DEBUGFS to
> >     CONFIG_PTDUMP_STAGE2_DEBUGFS
> > 
> > 
> >   v1 -> v2:
> >   * use the stage-2 pagetable walker for dumping descriptors instead of
> >     the one provided by ptdump.
> >   * support for guests pagetables dumping under VHE/nVHE non-protected
> > 
> > Thanks,
> > 
> > Sebastian Ene (6):
> >   KVM: arm64: Move pagetable definitions to common header
> >   arm64: ptdump: Expose the attribute parsing functionality
> >   arm64: ptdump: Use the mask from the state structure
> >   KVM: arm64: Register ptdump with debugfs on guest creation
> >   KVM: arm64: Initialize the ptdump parser with stage-2 attributes
> >   KVM: arm64: Expose guest stage-2 pagetable config to debugfs
> > 
> >  arch/arm64/include/asm/kvm_pgtable.h |  42 +++++
> >  arch/arm64/include/asm/ptdump.h      |  42 ++++-
> >  arch/arm64/kvm/Kconfig               |  14 ++
> >  arch/arm64/kvm/Makefile              |   1 +
> >  arch/arm64/kvm/arm.c                 |   2 +
> >  arch/arm64/kvm/hyp/pgtable.c         |  42 -----
> >  arch/arm64/kvm/kvm_ptdump.h          |  20 ++
> >  arch/arm64/kvm/ptdump.c              | 272 +++++++++++++++++++++++++++
> >  arch/arm64/mm/ptdump.c               |  50 +----
> >  9 files changed, 402 insertions(+), 83 deletions(-)
> >  create mode 100644 arch/arm64/kvm/kvm_ptdump.h
> >  create mode 100644 arch/arm64/kvm/ptdump.c
> > 
> > -- 
> > 2.45.2.741.gdbec12cfda-goog
> > 
> 
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> 

