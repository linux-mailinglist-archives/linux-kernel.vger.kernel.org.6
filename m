Return-Path: <linux-kernel+bounces-290406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6E9955367
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63253B22735
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D09145FED;
	Fri, 16 Aug 2024 22:37:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A18145B01
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 22:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723847873; cv=none; b=lG+C5m5+MqSMqzpqRhq8ajInfYtxSZyHPBv9f9ODL0l41ijKsFYzWZMDU9GdsdoU9OgKug9u5XKsVQv6WOuWQx4uVEI/WfWeWJxif0XtEEu4aSKf+8bfjua1nxgR5ckKcNvtRau5hL02QS6lQ77O2PobCCOfYg5zZFjIwJnHVp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723847873; c=relaxed/simple;
	bh=a8uRkXoPCKqQCnzEKy2RGDO5/6Qq2oGKcd4u8xEjhkc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N+DqRNl5iH+d0ia99zotaagN6wS30793tkbnkMkzSRWdtlx2yutPquz2UD+J4OYKLkaLG7/HpRnyUYBk7vh4MV1kaCKUIBZKxd7Vo6FJQHAMHX2IxgVHt9ef1nuLxZvOjq5EmzXC+DGaIixZrpW9JHwiyDqRbiRq5Mdcmm0utyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41791C32782;
	Fri, 16 Aug 2024 22:37:52 +0000 (UTC)
Date: Fri, 16 Aug 2024 23:37:49 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 6.11-rc4
Message-ID: <Zr_Uvf970W3ceqgU@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit cfb00a35786414e7c0e6226b277d9f09657eae74:

  arm64: jump_label: Ensure patched jump_labels are visible to all CPUs (2024-08-02 15:07:01 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to f75c235565f90c4a17b125e47f1c68ef6b8c2bce:

  arm64: Fix KASAN random tag seed initialization (2024-08-15 11:04:56 +0100)

----------------------------------------------------------------
arm64 fixes:

- Fix the arm64 __get_mem_asm() to use the _ASM_EXTABLE_##type##ACCESS()
  macro instead of the *_ERR() one in order to avoid writing -EFAULT to
  the value register in case of a fault

- Initialise all elements of the acpi_early_node_map[] to NUMA_NO_NODE.
  Prior to this fix, only the first element was initialised

- Move the KASAN random tag seed initialisation after the per-CPU areas
  have been initialised (prng_state is __percpu)

----------------------------------------------------------------
Haibo Xu (1):
      arm64: ACPI: NUMA: initialize all values of acpi_early_node_map to NUMA_NO_NODE

Mark Rutland (1):
      arm64: uaccess: correct thinko in __get_mem_asm()

Samuel Holland (1):
      arm64: Fix KASAN random tag seed initialization

 arch/arm64/include/asm/uaccess.h | 2 +-
 arch/arm64/kernel/acpi_numa.c    | 2 +-
 arch/arm64/kernel/setup.c        | 3 ---
 arch/arm64/kernel/smp.c          | 2 ++
 4 files changed, 4 insertions(+), 5 deletions(-)

-- 
Catalin

