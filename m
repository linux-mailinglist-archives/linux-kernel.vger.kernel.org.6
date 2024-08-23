Return-Path: <linux-kernel+bounces-299407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 650B495D431
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D245284AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1F218E346;
	Fri, 23 Aug 2024 17:20:44 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55AA18E03F
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724433643; cv=none; b=s56QhnXxxT5vvCdZGD9W6dcfyYYAJj5K/eSR4Jx/Vg993kosjBmYygf0bZyzQE6Ci/xGpv1gh1vZygtDJhoHbojst18peDBIGaqd/BwflJfl79KTMP6V+b9nz4YjLdaswGczXBKCBi6JuasHGO6+6KStYckx0MqcA+eQHWTkKJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724433643; c=relaxed/simple;
	bh=2s0HmHC5BxdKSohQRReHQscLN8+om9ADhIV836AtpsY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EU/zzfZIbD/vlOKZawdNCQByan2QWF5jAZjLwkIdWP6dJrLxU4Dq9IDDS9yeDf7swOhTZZwsz6EOMe6hKZVfIMqeK8oaaT1SuMiozXG7D/VGoBFzBFP4RJqxcfRZxgFLLfXyKqly6+YjLhbYa44/xXC21ImSC8AbvQ0cf92eUb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2ECC32786;
	Fri, 23 Aug 2024 17:20:42 +0000 (UTC)
Date: Fri, 23 Aug 2024 18:20:40 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64/KVM fixes for 6.11-rc5
Message-ID: <ZsjE6BXzDznbg6R-@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

As Paolo is away, I'm taking the arm64/KVM fixes through the arm64 tree.
Apart from KVM, there are no other fixes. Thanks.

The following changes since commit f75c235565f90c4a17b125e47f1c68ef6b8c2bce:

  arm64: Fix KASAN random tag seed initialization (2024-08-15 11:04:56 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 75c8f387dd16066a90c0928d00851edad0c8c519:

  Merge tag 'kvmarm-fixes-6.11-2' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into for-next/fixes (2024-08-23 09:47:39 +0100)

----------------------------------------------------------------
arm64/KVM fixes:

- Don't drop references on LPIs that weren't visited by the vgic-debug
  iterator

- Cure lock ordering issue when unregistering vgic redistributors

- Fix for misaligned stage-2 mappings when VMs are backed by hugetlb
  pages

- Treat SGI registers as UNDEFINED if a VM hasn't been configured for
  GICv3

----------------------------------------------------------------
Catalin Marinas (1):
      Merge tag 'kvmarm-fixes-6.11-2' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into for-next/fixes

Marc Zyngier (2):
      KVM: arm64: vgic: Don't hold config_lock while unregistering redistributors
      KVM: arm64: Make ICC_*SGI*_EL1 undef in the absence of a vGICv3

Oliver Upton (1):
      KVM: arm64: Ensure canonical IPA is hugepage-aligned when handling fault

Zenghui Yu (1):
      KVM: arm64: vgic-debug: Don't put unmarked LPIs

 Documentation/virt/kvm/api.rst                     |  2 +-
 arch/arm64/include/asm/kvm_ptrauth.h               |  2 +-
 arch/arm64/kvm/Kconfig                             |  1 +
 arch/arm64/kvm/Makefile                            |  3 +++
 arch/arm64/kvm/arm.c                               | 15 +++++----------
 arch/arm64/kvm/hyp/include/hyp/switch.h            |  1 -
 arch/arm64/kvm/hyp/nvhe/Makefile                   |  2 ++
 arch/arm64/kvm/hyp/nvhe/switch.c                   |  5 ++---
 arch/arm64/kvm/hyp/vhe/Makefile                    |  2 ++
 arch/arm64/kvm/mmu.c                               |  9 ++++++++-
 arch/arm64/kvm/nested.c                            |  2 +-
 arch/arm64/kvm/sys_regs.c                          |  6 ++++++
 arch/arm64/kvm/vgic/vgic-debug.c                   |  7 ++++---
 arch/arm64/kvm/vgic/vgic-init.c                    | 12 +++++++-----
 arch/arm64/kvm/vgic/vgic-irqfd.c                   |  7 ++++---
 arch/arm64/kvm/vgic/vgic-its.c                     | 18 +++++++++++-------
 arch/arm64/kvm/vgic/vgic-v3.c                      |  2 +-
 arch/arm64/kvm/vgic/vgic.c                         |  7 ++++++-
 arch/arm64/kvm/vgic/vgic.h                         |  9 ++++++++-
 tools/testing/selftests/kvm/aarch64/get-reg-list.c |  4 ++--
 20 files changed, 75 insertions(+), 41 deletions(-)

-- 
Catalin

