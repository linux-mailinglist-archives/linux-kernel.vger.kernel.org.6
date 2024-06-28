Return-Path: <linux-kernel+bounces-234565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FA891C814
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1661F22FBE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ADD7E576;
	Fri, 28 Jun 2024 21:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LH7nadvX"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4507D3E4
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719609936; cv=none; b=StWrfMZrqiHhNJXu/fu+MMiJZ78lLfoahT/vsLaFLffAymHl1BMCi4bofkpQIuqXmAOjbJO32klPrXXGY0G73+HNS+1iQkqws6wEtjo1kdbITGBu0T2KSxkmMZddCnL1na1u2EniANAjptN8DgFd/rFNCx1LfQqgPnK+QiwQUqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719609936; c=relaxed/simple;
	bh=N59WPI9EfXkR5vuxEptNjnh5hJvs9LbGDPVgOAO2bAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=resuT7mTE/SH5pwZw7rA7i1VNyUoQ1dtoJDDqHl2M0q5IelwuF85Al+/wEDDp89CfJyiG0sMCJWUyRtuTI2lvrg7cJU8wBVlKpR0wwrDkiSeQYP9Zq3kFyvjx0gbL3vO2SqDuM+TIV84aHKlEmC91cgwNWCj+iJe5GoulLsrXHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LH7nadvX; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: sebastianene@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719609932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+SRbUosfVTkOw3kLArjDnU2h9hEgZUxBiqMVhNqRDys=;
	b=LH7nadvXqIuuqk0lM4p4sxQ/AmvOKkgPEw4U1fe4zocK/uC2bah9H33DSR4ImZO9NmDCOu
	xWo0aOtzi4TeDg6zlw35ODVqUjNrGH5s7XrP5e9p3NCCAwIVtyUCpHR1Hldw6PWIDcEQ1J
	o+nJQG/89u5U+fl6hgZNLNUp/9MKff8=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: alexghiti@rivosinc.com
X-Envelope-To: ankita@nvidia.com
X-Envelope-To: ardb@kernel.org
X-Envelope-To: catalin.marinas@arm.com
X-Envelope-To: christophe.leroy@csgroup.eu
X-Envelope-To: james.morse@arm.com
X-Envelope-To: vdonnefort@google.com
X-Envelope-To: mark.rutland@arm.com
X-Envelope-To: maz@kernel.org
X-Envelope-To: rananta@google.com
X-Envelope-To: ryan.roberts@arm.com
X-Envelope-To: shahuang@redhat.com
X-Envelope-To: suzuki.poulose@arm.com
X-Envelope-To: will@kernel.org
X-Envelope-To: yuzenghui@huawei.com
X-Envelope-To: kvmarm@lists.linux.dev
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: kernel-team@android.com
Date: Fri, 28 Jun 2024 21:25:26 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sebastian Ene <sebastianene@google.com>
Cc: akpm@linux-foundation.org, alexghiti@rivosinc.com, ankita@nvidia.com,
	ardb@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, james.morse@arm.com,
	vdonnefort@google.com, mark.rutland@arm.com, maz@kernel.org,
	rananta@google.com, ryan.roberts@arm.com, shahuang@redhat.com,
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v7 0/6] arm64: ptdump: View the second stage page-tables
Message-ID: <Zn8qRqf8VZCk0KmP@linux.dev>
References: <20240621123230.1085265-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621123230.1085265-1-sebastianene@google.com>
X-Migadu-Flow: FLOW_OUT

Hi Seb,

I think we're getting closer on this series, thanks for reposting it. In
addition to polishing up the KVM side of things, I'd like to have acks
on the ptdump changes (patches 2-3).

Will + Catalin, any concerns?

-- 
Thanks,
Oliver

On Fri, Jun 21, 2024 at 12:32:24PM +0000, Sebastian Ene wrote:
> Hi,
> 
> 
> This series extends the ptdump support to allow dumping the guest
> stage-2 pagetables. When CONFIG_PTDUMP_STAGE2_DEBUGFS is enabled, ptdump
> registers '/sys/debug/kvm/<guest_id>/stage2_page_tables' entry with debugfs
> upon guest creation. This allows userspace tools (eg. cat) to dump the
> stage-2 pagetables by reading the registered file.
> 
> Reading the debugfs file shows stage-2 memory ranges in following format:
> <IPA range> <size> <descriptor type> <access permissions> <mem_attributes>
> 
> Below is the output of a guest stage-2 pagetable dump running under Qemu:
> 
> ---[ IPA bits 33 start lvl 2 ]---
> 0x0000000000000000-0x0000000080000000           2G PGD
> 0x0000000080000000-0x0000000080c00000          12M PGD      R W AF        BLK
> 0x0000000080c00000-0x0000000080e00000           2M PGD   XN R W AF        BLK
> 0x0000000080e00000-0x0000000081000000           2M PGD      R W AF        BLK
> 0x0000000081000000-0x0000000081400000           4M PGD   XN R W AF        BLK
> 0x0000000081400000-0x000000008fe00000         234M PGD
> 0x000000008fe00000-0x0000000090000000           2M PGD   XN R W AF        BLK
> 0x0000000090000000-0x00000000fa000000        1696M PGD
> 0x00000000fa000000-0x00000000fe000000          64M PGD   XN R W AF        BLK
> 0x00000000fe000000-0x0000000100000000          32M PGD
> 0x0000000100000000-0x0000000101c00000          28M PGD   XN R W AF        BLK
> 0x0000000101c00000-0x0000000102000000           4M PGD
> 0x0000000102000000-0x0000000102200000           2M PGD   XN R W AF        BLK
> 0x0000000102200000-0x000000017b000000        1934M PGD
> 0x000000017b000000-0x0000000180000000          80M PGD   XN R W AF        BLK
> 
> Link to v6:
> https://lore.kernel.org/all/20240220151035.327199-1-sebastianene@google.com/
> 
> Link to v5:
> https://lore.kernel.org/all/20240207144832.1017815-2-sebastianene@google.com/
> 
> Link to v4:
> https://lore.kernel.org/all/20231218135859.2513568-2-sebastianene@google.com/
> 
> Link to v3:
> https://lore.kernel.org/all/20231115171639.2852644-2-sebastianene@google.com/
> 
> Changelog:
>  v6 -> v7:
>  * Reworded commit for this patch : [PATCH v6 2/6] arm64: ptdump: Expose
>    the attribute parsing functionality
>  * fixed minor conflicts in the struct pg_state definition
>  * moved the kvm_ptdump_guest_registration in the
>  * kvm_arch_create_vm_debugfs
>  * reset the parse state before walking the pagetables
>  * copy the level name to the pg_level buffer
> 
> 
>  v5 -> v6:
>  * don't return an error if the kvm_arch_create_vm_debugfs fails to
>    initialize (ref.
> https://lore.kernel.org/all/20240216155941.2029458-1-oliver.upton@linux.dev/)  
>  * fix use-after-free suggested by getting a reference to the
>    KVM struct while manipulating the debugfs files
>    and put the reference on the file close.
>  * do all the allocations at once for the ptdump parser state tracking
>    and simplify the initialization.
>  * move the ptdump parser state initialization as part of the file_open
>  * create separate files for printing the guest stage-2 pagetable
>    configuration such as: the start level of the pagetable walk and the
>    number of bits used for the IPA space representation.
>  * fixed the wrong header format for the newly added file
>  * include missing patch which hasn't been posted on the v5:
>    "KVM-arm64-Move-pagetable-definitions-to-common-heade.patch" 
> 
> 
>  v4 -> v5:
>  * refactorization: split the series into two parts as per the feedback
>    received from Oliver. Introduce the base support which allows dumping
>    of the guest stage-2 pagetables.
>  * removed the *ops* struct wrapper built on top of the file_ops and
>    simplify the ptdump interface access.
>  * keep the page table walker away from the ptdump specific code
> 
>   v3 -> current_version:
>   * refactorization: moved all the **KVM** specific components under
>     kvm/ as suggested by Oliver. Introduced a new file
>     arm64/kvm/ptdump.c which handled the second stage translation.
>     re-used only the display portion from mm/ptdump.c
>   * pagetable snapshot creation now uses memory donated from the host.
>     The memory is no longer shared with the host as this can pose a security
>     risk if the host has access to manipulate the pagetable copy while
>     the hypervisor iterates it.
>   * fixed a memory leak: while memory was used from the memcache for
>     building the snapshot pagetable, it was no longer giving back the
>     pages to the host for freeing. A separate array was introduced to
>     keep track of the pages allocated from the memcache.
> 
> 
>   v2 -> v3:
>   * register the stage-2 debugfs entry for the host under
>     /sys/debug/kvm/host_stage2_page_tables and in
>     /sys/debug/kvm/<guest_id>/stage2_page_tables for guests.
>   * don't use a static array for parsing the attributes description,
>     generate it dynamically based on the number of pagetable levels
>   * remove the lock that was guarding the seq_file private inode data,
>     and keep the data private to the open file session.
>   * minor fixes & renaming of CONFIG_NVHE_EL2_PTDUMP_DEBUGFS to
>     CONFIG_PTDUMP_STAGE2_DEBUGFS
> 
> 
>   v1 -> v2:
>   * use the stage-2 pagetable walker for dumping descriptors instead of
>     the one provided by ptdump.
>   * support for guests pagetables dumping under VHE/nVHE non-protected
> 
> Thanks,
> 
> Sebastian Ene (6):
>   KVM: arm64: Move pagetable definitions to common header
>   arm64: ptdump: Expose the attribute parsing functionality
>   arm64: ptdump: Use the mask from the state structure
>   KVM: arm64: Register ptdump with debugfs on guest creation
>   KVM: arm64: Initialize the ptdump parser with stage-2 attributes
>   KVM: arm64: Expose guest stage-2 pagetable config to debugfs
> 
>  arch/arm64/include/asm/kvm_pgtable.h |  42 +++++
>  arch/arm64/include/asm/ptdump.h      |  42 ++++-
>  arch/arm64/kvm/Kconfig               |  14 ++
>  arch/arm64/kvm/Makefile              |   1 +
>  arch/arm64/kvm/arm.c                 |   2 +
>  arch/arm64/kvm/hyp/pgtable.c         |  42 -----
>  arch/arm64/kvm/kvm_ptdump.h          |  20 ++
>  arch/arm64/kvm/ptdump.c              | 272 +++++++++++++++++++++++++++
>  arch/arm64/mm/ptdump.c               |  50 +----
>  9 files changed, 402 insertions(+), 83 deletions(-)
>  create mode 100644 arch/arm64/kvm/kvm_ptdump.h
>  create mode 100644 arch/arm64/kvm/ptdump.c
> 
> -- 
> 2.45.2.741.gdbec12cfda-goog
> 

