Return-Path: <linux-kernel+bounces-224653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C6A912565
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A6332836B4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6CC152E04;
	Fri, 21 Jun 2024 12:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TLA/uDPe"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ACD152161
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718973160; cv=none; b=VpWl7k8lNGXjO00gRTMStnD8qxdReUT65iVoCwoJ1Xk/mRWOX6Lj6ITQLu9JRAHZ1cucnHkinzY4qGbH/FvNL+nPsLGSqUWAAouc5moK7tc4Gw+ZeIezquvGKlPhnGUoRDHShwiU8aeu5kJHKftKFB+eNSCytB3XC26Atn0RqN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718973160; c=relaxed/simple;
	bh=r9Qp+3t57LKbLCQehAaphI5epSAhBl7IBxONt6On+2k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Dzgtd8VVyuGZXYfcWDkk+R6/t0ADi6LbR1qrmURAw/INE5fsobcgjzCuNEmr0jIfuozpBV2TYZFgqau4wYt/FgsW0zOon23NBPHH9OhwuzZdPewto3WZIYbbiOGAW4D779HG6RqGKVU911yVRUie0ic4ElwdoB2jOnokHm0O4go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TLA/uDPe; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4218447b900so11063465e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718973157; x=1719577957; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PMXX+jk8CoyrGDajp1NmkklStgSxsIyqK7BV0cb2dR4=;
        b=TLA/uDPeJ8jW0MMot3IY8VN7c1Ov7+M5rmQSbB869RQ0p6p3UKXpJSaQuVl2NNp7F9
         35HlYiZ3TEALX5MHGtlUN0PfqC+rp/ob8wbBG4+HMujIoulS5VBwfFSBDflCgpqwuAUR
         UhTaAbr+8YOgT85dxqDN7G2PMYKOBcKwBcKsyUIwIxPA/JOLnERmen235SbJ+NjMoIyW
         bgpxZ2os3YF5uASaq+liDi4HE6zudVHgp87l27nfuySGaEvaHdqCzaUHjLsHyZ4DRo++
         cgVVr44Ok7ainrXjaLuW3kagB4lgZN3xsJpzByxWI7FNw1+VjpYbuRD1TCJvNsnxpbaN
         eo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718973157; x=1719577957;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PMXX+jk8CoyrGDajp1NmkklStgSxsIyqK7BV0cb2dR4=;
        b=i2lAJ5roqHgQtzFKZAPFF33tPPz/alKt2pNluIqwN5eeCfBAvJ03snhiZ/pNwezJ0/
         0AbQEwICX/kbCJU0xPCAmo2g0aeAqpWMKsqFF4y0N8CONEV9aTNF8iVV11U2McStP0lH
         8IL/4yKuJRUT8Y5FwOP/eAvAwsJFAE/BKj5C0eLHTxTF+9Bn7USdEWxuR+cVTjYFJ8hN
         qJQVY9YKcJPHIsJP81+7/oi1VKzakP1b1AxkAybgLMQryRTZwh3aIUEUxVGILmBFDJRz
         bmbCplc7vykDGdwYS3ItN4pELxomqu7aRfu3WlKZApHfYHU2GEJhKLi7sQGBbSDqD1Je
         GQZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKTX6uj6w+twxzu4jw6WCD1Xx2vIzFtZA8ltLRQiTBkv0oICvQHjXF7ctJtQDz71KjBmGz/0qz18YnzEr2xp9cNqYF8deC93Ps1dGb
X-Gm-Message-State: AOJu0Yx8ddughDCAY+Q7xruEAKhnEF1YdcwcWleZG39ZL2HKUn7WIzPl
	a756Rfd0nqUfrdE+Exz5qD3v0ChaZNVAKZgLW0vEORlS1qW6zhn0aN9TlKPCUJGFd7aqOXElr5I
	mR+0E9K4LdJAYGgj6IIOwJfJDJw==
X-Google-Smtp-Source: AGHT+IEF1VDRkJcqgGZr7F6pw8YsXYfWulpGqWDu9ViK9xi/OKgbp+BBhdGW5TbYitbNz0PnBDObFBUGJcfUzlV7l5c=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:511d:b0:421:de31:7b with
 SMTP id 5b1f17b1804b1-42474ca44c6mr1852195e9.0.1718973157245; Fri, 21 Jun
 2024 05:32:37 -0700 (PDT)
Date: Fri, 21 Jun 2024 12:32:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240621123230.1085265-1-sebastianene@google.com>
Subject: [PATCH v7 0/6] arm64: ptdump: View the second stage page-tables
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

Link to v6:
https://lore.kernel.org/all/20240220151035.327199-1-sebastianene@google.com/

Link to v5:
https://lore.kernel.org/all/20240207144832.1017815-2-sebastianene@google.com/

Link to v4:
https://lore.kernel.org/all/20231218135859.2513568-2-sebastianene@google.com/

Link to v3:
https://lore.kernel.org/all/20231115171639.2852644-2-sebastianene@google.com/

Changelog:
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
 arch/arm64/kvm/ptdump.c              | 272 +++++++++++++++++++++++++++
 arch/arm64/mm/ptdump.c               |  50 +----
 9 files changed, 402 insertions(+), 83 deletions(-)
 create mode 100644 arch/arm64/kvm/kvm_ptdump.h
 create mode 100644 arch/arm64/kvm/ptdump.c

-- 
2.45.2.741.gdbec12cfda-goog


