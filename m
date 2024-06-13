Return-Path: <linux-kernel+bounces-213021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 971019069F0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25744285183
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC271142629;
	Thu, 13 Jun 2024 10:27:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14011422D1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718274443; cv=none; b=KEsXuW63v7hC+NMaI6A7orAd/6/0idJyXNuzRFkbBGDogK3difxFljf7ktZC6RXKF1l0QfXziPRFERydx6VY4It8tbX2w6xrvZhW1BELoYpP7ptt+OYPlZkoOF3IidCm+fmeYoxO2aKqr8CM29oHQWo20JbC3A85Tg0bhzs8Ycc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718274443; c=relaxed/simple;
	bh=nbuOukV7CZ02btKXgW0+RmyN5gVD4F0yYWswrEiINzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YPg29+VUXtH+sLie+xltnd/mij99nn/FtkdjcgJ7MPbKAKJDCAkkBw8ohAVKs024yJGuBHBE3vrCRFBM6ZqF9fMY/uPx3MVO6+K8BWhuqA9/w1lC8d0lIgAAIQA5rsDzdr0EpvNlUj9MD2ROoCmYAbz8Qaj0j7Za4vQljSchFU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC2071063;
	Thu, 13 Jun 2024 03:27:44 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.44.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A08723F5A1;
	Thu, 13 Jun 2024 03:27:16 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com,
	ryan.roberts@arm.com,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/2] arm64: Drop ID_AA64PFR0_EL1_ELx_[64BIT_ONLY|32BIT_64BIT]
Date: Thu, 13 Jun 2024 15:57:08 +0530
Message-Id: <20240613102710.3295108-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series replaces custom macros usage for ID_AA64PFR0_EL1_ELx_64BIT_ONLY
and ID_AA64PFR0_EL1_ELx_32BIT_64BIT fields, thus finally just dropping them
off completely. This series applies on v6.10-rc3

Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.linux.dev
Cc: linux-kernel@vger.kernel.org

Changes in V2:

- Replaced FIELD_PREP() with SYS_FIELD_PREP_ENUM() as per Marc

Changes in V1:

https://lore.kernel.org/all/20240418053804.2573071-1-anshuman.khandual@arm.com/

Anshuman Khandual (2):
  KVM: arm64: Replace custom macros with fields from ID_AA64PFR0_EL1
  arm64/cpufeature: Replace custom macros with fields from ID_AA64PFR0_EL1

 arch/arm64/include/asm/cpufeature.h            |  4 ++--
 arch/arm64/include/asm/sysreg.h                |  4 ----
 arch/arm64/kernel/cpufeature.c                 |  4 ++--
 arch/arm64/kvm/hyp/include/nvhe/fixed_config.h | 10 +++++-----
 arch/arm64/kvm/hyp/nvhe/pkvm.c                 |  4 ++--
 arch/arm64/kvm/hyp/nvhe/sys_regs.c             |  2 +-
 6 files changed, 12 insertions(+), 16 deletions(-)

-- 
2.30.2


