Return-Path: <linux-kernel+bounces-430405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA69D9E307D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 01:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70FA9283316
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3804A33;
	Wed,  4 Dec 2024 00:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sYH8k3bt"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3382500C0
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 00:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733273590; cv=none; b=ByePOmB4xSytnpI/Sxl8feZRqbF/WySQwJaOZ61GmGFdQHNJaXwkCP1e6WLdcU6Y3IHVkZ2i8hM3FXyPmssfSAQeRw3NDmtw3LKpToKIVBmwDwUHEs3kNFyLK+HTthDlHXkxDjgUXQ3wozDRVnD9YU0XZzF0gU5dMZMtyaeSfBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733273590; c=relaxed/simple;
	bh=Rw9eSKUinUHHh79ce0ClcEVu8ofwzOvsndWqXNDOZUc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oHpyv/Dg16qZ42lMzfCf2JF7Z0+hQ1nBcyztsO9U0lSSJqOVQu4TZ9NUm/PprF46+VivDCgIix9PAGNqJgH3nuBH4jXyury/YuobyjXWsTGqNJG3TA+1BiQlINUPlyuGff6aOQfMNDPA7TllmdeIegJ529xy48VEAB7o4ThOjTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sYH8k3bt; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 3 Dec 2024 16:52:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733273584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=WPSnJJ3xcAhgShdI5TZXtrd+D3WR/pvi0oW1mVgxgPY=;
	b=sYH8k3bt45IhiO+HdqQhPMpe9vSHqD883VjennUKwErPEdme55YJYp/hQ3gwCM8EByJPxu
	/JoNP3qhNdrs1+ZQHMzBpnG+EB8ouJawVEASP1mS5PXnG6vFEWGuixdLB2ofr3d8tHGq+w
	BqfxepXlBNNjUxjpaUM0Zbav6t47NSM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Keisuke Nishimura <keisuke.nishimura@inria.fr>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, Marc Zyngier <maz@kernel.org>,
	James Clark <james.clark@linaro.org>
Subject: [GIT PULL] KVM/arm64 fixes for 6.13, part #2
Message-ID: <Z0-n5WnAg8tBjLhG@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Paolo,

Another week, another batch of fixes. The most notable here is the MDCR_EL2
change from James, which addresses a rather stupid regression I introduced
in 6.13.

Please pull.

-- 
Thanks,
Oliver

The following changes since commit 13905f4547b050316262d54a5391d50e83ce613a:

  KVM: arm64: Use MDCR_EL2.HPME to evaluate overflow of hyp counters (2024-11-20 17:23:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git/ tags/kvmarm-fixes-6.13-2

for you to fetch changes up to be7e611274224b23776469d7f7ce50e25ac53142:

  KVM: arm64: vgic-its: Add error handling in vgic_its_cache_translation (2024-12-03 16:22:10 -0800)

----------------------------------------------------------------
KVM/arm64 fixes for 6.13, part #2

 - Fix confusion with implicitly-shifted MDCR_EL2 masks breaking
   SPE/TRBE initialization

 - Align nested page table walker with the intended memory attribute
   combining rules of the architecture

 - Prevent userspace from constraining the advertised ASID width,
   avoiding horrors of guest TLBIs not matching the intended context in
   hardware

 - Don't leak references on LPIs when insertion into the translation
   cache fails

----------------------------------------------------------------
James Clark (1):
      arm64: Fix usage of new shifted MDCR_EL2 values

Keisuke Nishimura (1):
      KVM: arm64: vgic-its: Add error handling in vgic_its_cache_translation

Marc Zyngier (2):
      KVM: arm64: Fix S1/S2 combination when FWB==1 and S2 has Device memory type
      KVM: arm64: Do not allow ID_AA64MMFR0_EL1.ASIDbits to be overridden

 arch/arm64/include/asm/el2_setup.h |  4 ++--
 arch/arm64/kernel/hyp-stub.S       |  4 ++--
 arch/arm64/kvm/at.c                | 11 +++++++++--
 arch/arm64/kvm/hyp/nvhe/pkvm.c     |  4 ++--
 arch/arm64/kvm/sys_regs.c          |  3 ++-
 arch/arm64/kvm/vgic/vgic-its.c     | 12 +++++++++++-
 6 files changed, 28 insertions(+), 10 deletions(-)

