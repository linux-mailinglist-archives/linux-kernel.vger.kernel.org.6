Return-Path: <linux-kernel+bounces-296924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED12F95B0A7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C2C1B27897
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78D217085A;
	Thu, 22 Aug 2024 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TWfsGwGe"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD9615CD78
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 08:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315805; cv=none; b=uumKAnkBMCcHtBf66/CGp82S/g+RV5dng74q1FvKarp1jrhlYzhQK2fNVOzghuA1Us7aE6ft2VdnMmG3tQy8K/WzOs1X8Zj9L3+cGaIRQDTIa3LphjqdzIj+Im5xWsSlqRjTtB3TlyihFPGpm7X1A5WD//OG++NCkV262VwCFUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315805; c=relaxed/simple;
	bh=LSQVp0gOynObcNqwjGT2JXTi+qt6YE2Ny0x4vK2nF98=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ncF0ALFXCTusCxHRq54J00Lolsf9PyeJFg36iP06+uevC6TT68O5yUp95hV63R45S5mNrqvBQh5V5/46DfwlgUmHLWAdL6bgkEFPXxHAmzczXW269+tqy2L4rxfbAzzwDKVH//qj41xewE7dmyjTpSZ2STUDagYMpVEYhjR5PvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TWfsGwGe; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 22 Aug 2024 01:36:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724315800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=pcL3SznNZSWm9dN7/mUyjJcTwqEA+cVbdDDcB/ulbas=;
	b=TWfsGwGeAOaSdjAOZxRueTVOGqNEx7M91qD5MatowOG+uZnNhGn+rL/q2AUmZOBnh2S5wb
	l9a1fTHNpA3XmgBCjG8AuXf2MNSAyEq5F4mG2C9dn57PHYoAp/ukmXUIp+4UDHlY235NzI
	PhMH2hUcMhZ7Q6+kvHv4JIamVhl+wZ0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
	kvmarm@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] KVM/arm64 fixes for 6.11, round #2
Message-ID: <Zsb4kbq6FAfgg4WA@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Catalin,

Paolo is on holiday for a few weeks and has asked that KVM arch maintainers
send pulls through the architecture trees in his absence.

So lucky you, here's a pile of kvmarm crap from the past week.

Details can be found in the tag, but this is a set of small fixes
around the shop thanks to syzkaller bringup on KVM/arm64 and a few
recently introduced bugs.

Please pull.

-- 
Thanks,
Oliver

The following changes since commit 9eb18136af9fe4dd688724070f2bfba271bd1542:

  KVM: arm64: vgic: Hold config_lock while tearing down a CPU interface (2024-08-08 16:58:22 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvmarm-fixes-6.11-2

for you to fetch changes up to 3e6245ebe7ef341639e9a7e402b3ade8ad45a19f:

  KVM: arm64: Make ICC_*SGI*_EL1 undef in the absence of a vGICv3 (2024-08-22 08:08:37 +0000)

----------------------------------------------------------------
KVM/arm64 fixes for 6.11, round #2

 - Don't drop references on LPIs that weren't visited by the
   vgic-debug iterator

 - Cure lock ordering issue when unregistering vgic redistributors

 - Fix for misaligned stage-2 mappings when VMs are backed by hugetlb
   pages

 - Treat SGI registers as UNDEFINED if a VM hasn't been configured for
   GICv3

----------------------------------------------------------------
Marc Zyngier (2):
      KVM: arm64: vgic: Don't hold config_lock while unregistering redistributors
      KVM: arm64: Make ICC_*SGI*_EL1 undef in the absence of a vGICv3

Oliver Upton (1):
      KVM: arm64: Ensure canonical IPA is hugepage-aligned when handling fault

Zenghui Yu (1):
      KVM: arm64: vgic-debug: Don't put unmarked LPIs

 arch/arm64/kvm/mmu.c             | 9 ++++++++-
 arch/arm64/kvm/sys_regs.c        | 6 ++++++
 arch/arm64/kvm/vgic/vgic-debug.c | 2 +-
 arch/arm64/kvm/vgic/vgic-init.c  | 9 ++++++---
 arch/arm64/kvm/vgic/vgic.c       | 5 +++++
 arch/arm64/kvm/vgic/vgic.h       | 7 +++++++
 6 files changed, 33 insertions(+), 5 deletions(-)

