Return-Path: <linux-kernel+bounces-289661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F64D9548E3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442461C23C91
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6555B1B3F08;
	Fri, 16 Aug 2024 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="om+95dNA"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC49B12D1EA
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 12:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723811957; cv=none; b=gYz4Pm83yXRl5gSR5+Cg/xQHHgVEYmmHwZzPic9uNSNxx/a+KyHAC2M3R5qZpSrvSQ3xkF3ToP85kTYvUachmUJ3TRVieBAF8+dDef61Jpv8O5FULadof69U9g8ZNk9sgJqRqfIIHSe6vUi+PJOnqa0XDX9pXXyMJXN3FsEhRRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723811957; c=relaxed/simple;
	bh=XlTQsOUXB9raZB8rGaK0daP0rTZKs1RamzUCLFc8lag=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NviFEmAXYWZiYcXjCY5z1L/e8ACQhNfSjFF1/FZB3z5p4NayEvPsapJfLCicgPTTrI/q7CD2gKyj8rjI1YvgSBwpavcC+x82oiy9BM/0gPoIAcUcAXWa7PjWowoqFXtUD0DNOVDKmwxcmUB7AX6SZTYqS0OSGqJoATrkqnGTWpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=om+95dNA; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5bebd3e0eb9so1011625a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723811954; x=1724416754; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F15OS9DmHfOIzgTYHZN2li4ydR2TifG9W0hcWGNXF70=;
        b=om+95dNAIPlDjoijOPOeMy6SBBKvuTBcgLLEXjx2ueioqGU6O1jlRG79v8KVhAUyhh
         z7LeJKp/MwnIwEsnh5pYke64uuZe15PDBFj55vbVA2d2VkcQqAo5GMvIsqi17lF0giAS
         36B40HrCAxhH10vORUkVSG9fjdx4c2D0jtS+xHgvUyc48yXORVpy6rftrf3FNisSkDTo
         GnVGXMQ0bmboTNsVihF0pbDUZjFLHb5oSOOw+DEC+qMe8aHd8gzsPnxu2vn4QGRpQGrA
         51T/pwXtzeHrjHFbiblUKvfxA6sDjocuJvd8g4uvXI39fblVPGkCuMoS8LPcJZnSmC44
         vjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723811954; x=1724416754;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F15OS9DmHfOIzgTYHZN2li4ydR2TifG9W0hcWGNXF70=;
        b=rgjtPm9KWDjwM9IkS6Vrk6bemcTDKhQgRmx7Dafn+j+W8NCKpNqxk5LTpGW61YTcg9
         Lxej1A1AY8O1zmU+5/jwsIhkTuAuwWB3OM4CUrJINTjEWmSNomqO/5hVq+pdsOdgwj/G
         +AE+J8mj6sfWZRfLPhSddeNVBZAKIrZp36ELzThQUxZ196fsVU8TyiDYj156iL0/uYNS
         pRHvAUPv/25Asr0ZJnS61piI+bFGVihpBOvDW2vwBPwA3sYavIE9u1r4w6gI+LIKXYl2
         /WF5YDMDvjaEzR1sITu1rIcIprOw6zFLWkvJQBvT4G1OLsMjIAWKKnJfMGF0xAftty/4
         sF0w==
X-Forwarded-Encrypted: i=1; AJvYcCXPckrY3oZWNZihHHycQxSrvih28O4PyV/u0GyB7mH8FSj+BSYvCY0xZOhi7Y9ynwtzAXGQi0laZD1WICj0TCnDCcdiXuX45iEQCYUR
X-Gm-Message-State: AOJu0YxzODPDY3G69dDBvvNLHR0dZxpu9X+evlBGX6pTDGE74LiLOY8S
	RNZFT45mTtYUgKF18+UfuMrpIkYEuaSnmm7sKfHkxgfv9bWjxQ6Qjdr5itnxoaN4+tBs7bLXw1J
	SFNnNinG0P/MaARDXDJ/7eQxqbQ==
X-Google-Smtp-Source: AGHT+IGB0VFbMJX9PjdgC8p1ueT+M9NCul0doNH3FtI58DbCoos4szbVwer8lzRUhSiaxjA5OYmf50ifvUmcB9uy4qA=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a17:906:d7d6:b0:a83:9526:b28c with
 SMTP id a640c23a62f3a-a839526b3e8mr185866b.1.1723811953902; Fri, 16 Aug 2024
 05:39:13 -0700 (PDT)
Date: Fri, 16 Aug 2024 12:39:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240816123906.3683425-1-sebastianene@google.com>
Subject: [PATCH v8 0/6] arm64: ptdump: View the second stage page-tables
From: Sebastian Ene <sebastianene@google.com>
To: akpm@linux-foundation.org, alexghiti@rivosinc.com, ankita@nvidia.com, 
	ardb@kernel.org, catalin.marinas@arm.com, christophe.leroy@csgroup.eu, 
	james.morse@arm.com, vdonnefort@google.com, mark.rutland@arm.com, 
	maz@kernel.org, oliver.upton@linux.dev, rananta@google.com, 
	ryan.roberts@arm.com, sebastianene@google.com, shahuang@redhat.com, 
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Hi,


This series extends the ptdump support to allow dumping the guest
stage-2 pagetables. When CONFIG_PTDUMP_STAGE2_DEBUGFS is enabled, ptdump
registers '/sys/debug/kvm/<guest_id>/stage2_page_tables' entry with debugfs
upon guest creation. This allows userspace tools (eg. cat) to dump the
stage-2 pagetables by reading the registered file.

Reading the debugfs file shows stage-2 memory ranges in following format:
<IPA range> <size> <descriptor type> <access permissions> <mem_attributes>

Below is the output of a guest stage-2 pagetable dump running under Qemu:

---[ IPA bits 33 start lvl 2 ]---
0x0000000000000000-0x0000000080000000           2G PGD
0x0000000080000000-0x0000000080c00000          12M PGD      R W AF        BLK
0x0000000080c00000-0x0000000080e00000           2M PGD   XN R W AF        BLK
0x0000000080e00000-0x0000000081000000           2M PGD      R W AF        BLK
0x0000000081000000-0x0000000081400000           4M PGD   XN R W AF        BLK
0x0000000081400000-0x000000008fe00000         234M PGD
0x000000008fe00000-0x0000000090000000           2M PGD   XN R W AF        BLK
0x0000000090000000-0x00000000fa000000        1696M PGD
0x00000000fa000000-0x00000000fe000000          64M PGD   XN R W AF        BLK
0x00000000fe000000-0x0000000100000000          32M PGD
0x0000000100000000-0x0000000101c00000          28M PGD   XN R W AF        BLK
0x0000000101c00000-0x0000000102000000           4M PGD
0x0000000102000000-0x0000000102200000           2M PGD   XN R W AF        BLK
0x0000000102200000-0x000000017b000000        1934M PGD
0x000000017b000000-0x0000000180000000          80M PGD   XN R W AF        BLK

Link to v7:
https://lore.kernel.org/all/20240621123230.1085265-1-sebastianene@google.com/

Link to v6:
https://lore.kernel.org/all/20240220151035.327199-1-sebastianene@google.com/

Link to v5:
https://lore.kernel.org/all/20240207144832.1017815-2-sebastianene@google.com/

Link to v4:
https://lore.kernel.org/all/20231218135859.2513568-2-sebastianene@google.com/

Link to v3:
https://lore.kernel.org/all/20231115171639.2852644-2-sebastianene@google.com/

Changelog:
 v7 -> v8:
 * applied Will's feedback and prefixed the exported structure names
   with ptdump_
 * dropped PTE_CONT and PTE_NG attribute parsing from Oliver's
   suggestion
 * fixed spurious BLK annotation reported by Vincent
 * repurposed `stage2_levels` debugfs file to show the number of the
   levels
 * tried changing the order of the patches:
   "5/6 Initialize the ptdump parser with stage-2 attributes" before
   exposing the debugfs file but ended up keeping the same order
   as this depends on the later one.

 v6 -> v7:
 * Reworded commit for this patch : [PATCH v6 2/6] arm64: ptdump: Expose
   the attribute parsing functionality
 * fixed minor conflicts in the struct pg_state definition
 * moved the kvm_ptdump_guest_registration in the
 * kvm_arch_create_vm_debugfs
 * reset the parse state before walking the pagetables
 * copy the level name to the pg_level buffer


 v5 -> v6:
 * don't return an error if the kvm_arch_create_vm_debugfs fails to
   initialize (ref.
https://lore.kernel.org/all/20240216155941.2029458-1-oliver.upton@linux.dev/)  
 * fix use-after-free suggested by getting a reference to the
   KVM struct while manipulating the debugfs files
   and put the reference on the file close.
 * do all the allocations at once for the ptdump parser state tracking
   and simplify the initialization.
 * move the ptdump parser state initialization as part of the file_open
 * create separate files for printing the guest stage-2 pagetable
   configuration such as: the start level of the pagetable walk and the
   number of bits used for the IPA space representation.
 * fixed the wrong header format for the newly added file
 * include missing patch which hasn't been posted on the v5:
   "KVM-arm64-Move-pagetable-definitions-to-common-heade.patch" 


 v4 -> v5:
 * refactorization: split the series into two parts as per the feedback
   received from Oliver. Introduce the base support which allows dumping
   of the guest stage-2 pagetables.
 * removed the *ops* struct wrapper built on top of the file_ops and
   simplify the ptdump interface access.
 * keep the page table walker away from the ptdump specific code

  v3 -> current_version:
  * refactorization: moved all the **KVM** specific components under
    kvm/ as suggested by Oliver. Introduced a new file
    arm64/kvm/ptdump.c which handled the second stage translation.
    re-used only the display portion from mm/ptdump.c
  * pagetable snapshot creation now uses memory donated from the host.
    The memory is no longer shared with the host as this can pose a security
    risk if the host has access to manipulate the pagetable copy while
    the hypervisor iterates it.
  * fixed a memory leak: while memory was used from the memcache for
    building the snapshot pagetable, it was no longer giving back the
    pages to the host for freeing. A separate array was introduced to
    keep track of the pages allocated from the memcache.


  v2 -> v3:
  * register the stage-2 debugfs entry for the host under
    /sys/debug/kvm/host_stage2_page_tables and in
    /sys/debug/kvm/<guest_id>/stage2_page_tables for guests.
  * don't use a static array for parsing the attributes description,
    generate it dynamically based on the number of pagetable levels
  * remove the lock that was guarding the seq_file private inode data,
    and keep the data private to the open file session.
  * minor fixes & renaming of CONFIG_NVHE_EL2_PTDUMP_DEBUGFS to
    CONFIG_PTDUMP_STAGE2_DEBUGFS


  v1 -> v2:
  * use the stage-2 pagetable walker for dumping descriptors instead of
    the one provided by ptdump.
  * support for guests pagetables dumping under VHE/nVHE non-protected

Thanks,

Sebastian Ene (6):
  KVM: arm64: Move pagetable definitions to common header
  arm64: ptdump: Expose the attribute parsing functionality
  arm64: ptdump: Use the mask from the state structure
  KVM: arm64: Register ptdump with debugfs on guest creation
  KVM: arm64: Initialize the ptdump parser with stage-2 attributes
  KVM: arm64: Expose guest stage-2 pagetable config to debugfs

 arch/arm64/include/asm/kvm_pgtable.h |  42 +++++
 arch/arm64/include/asm/ptdump.h      |  42 ++++-
 arch/arm64/kvm/Kconfig               |  14 ++
 arch/arm64/kvm/Makefile              |   1 +
 arch/arm64/kvm/arm.c                 |   2 +
 arch/arm64/kvm/hyp/pgtable.c         |  42 -----
 arch/arm64/kvm/kvm_ptdump.h          |  20 ++
 arch/arm64/kvm/ptdump.c              | 262 +++++++++++++++++++++++++++
 arch/arm64/mm/ptdump.c               |  66 ++-----
 9 files changed, 400 insertions(+), 91 deletions(-)
 create mode 100644 arch/arm64/kvm/kvm_ptdump.h
 create mode 100644 arch/arm64/kvm/ptdump.c

-- 
2.46.0.184.g6999bdac58-goog


