Return-Path: <linux-kernel+bounces-521798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3F0A3C26B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F7171732FB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BF485260;
	Wed, 19 Feb 2025 14:45:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3361E1C09
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976303; cv=none; b=FG+Sh0b6i6F+zyCV0nSMqIRWUYlqi56gaLLKl2IerOjEpVIuFntIfD6RjbPhbUcXARmOtx+b5p/THURdo1T6KQOcqmB0LJefdHjWElKJcmxRMv8xcbKt1orp7t80Ib3RZyYQIqBDGM96HUK0b7QuNRUgLMrzJul3X2DaWmcKyno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976303; c=relaxed/simple;
	bh=Lg1Iyu4pbxer1+btJAh4izacBOCnj/tM+fmLEh+c/rg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pEeXIo0KMdgpN48Jnv5iH/VxjvCRNybDvMlR3oozn5/nfjHM3mTuzvO4XqaA995OxkoNgm263tXequ3Y3tVG9xuoyja32LFHxUFd0XSiivrGc/4i8c/n/tLFNtz1BPHV0HBx8iayvYJ12J7zjOZFIijtpj+mk8POWAVONtyhTCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B28513D5;
	Wed, 19 Feb 2025 06:45:19 -0800 (PST)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.2.80.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15FE53F59E;
	Wed, 19 Feb 2025 06:44:57 -0800 (PST)
From: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
To: ryan.roberts@arm.com,
	yang@os.amperecomputing.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	joey.gouly@arm.com,
	broonie@kernel.org,
	mark.rutland@arm.com,
	james.morse@arm.com,
	yangyicong@hisilicon.com,
	robin.murphy@arm.com,
	anshuman.khandual@arm.com,
	maz@kernel.org,
	liaochang1@huawei.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	baohua@kernel.org,
	ioworker0@gmail.com,
	oliver.upton@linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
Subject: [PATCH v1 0/3] Initial BBML2 support for contpte_convert()
Date: Wed, 19 Feb 2025 14:38:36 +0000
Message-ID: <20250219143837.44277-3-miko.lenczewski@arm.com>
X-Mailer: git-send-email 2.45.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi All,

This patch series adds adding initial support for eliding
break-before-make requirements on systems that support BBML2 and
additionally guarantee to never raise a conflict abort.

This support reorders and optionally elides a TLB invalidation in
contpte_convert(). The elision of said invalidation leads to a 12%
improvement when executing a microbenchmark designed to force the
pathological path where contpte_convert() gets called. This
represents an 80% reduction in the cost of calling contpte_convert().

However, even without the elision, the reodering represents a
performance improvement due to reducing thread contention, as there is
a smaller time window for racing threads to see an invalid pagetable
entry (especially if they already have a cached entry in their TLB
that they are working off of).

This series is based on v6.14-rc3 (0ad2507d5d93).

Patch 1 implements an allow-list of cpus that support BBML2, but with
the additional constraint of never causing TLB conflict aborts. We
settled on this constraint because we will use the feature for kernel
mappings in the future, for which we cannot handle conflict aborts
safely.

Yang Shi has a series at [1] that aims to use BBML2 to enable splitting
the linear map at runtime. This series partially overlaps with it to add
the cpu feature. We beleive this series is fully compatible with Yang's
requirements and could go first, given there is still a lot of discussion
around the best way to manage the mechanics of splitting/collapsing the
linear map.

[1]:
  https://lore.kernel.org/linux-arm-kernel/20250103011822.1257189-1-yang@os.amperecomputing.com/

Mikołaj Lenczewski (3):
  arm64: Add BBM Level 2 cpu feature
  arm64/mm: Delay tlbi in contpte_convert() under BBML2
  arm64/mm: Elide tlbi in contpte_convert() under BBML2

 arch/arm64/Kconfig                  |  9 ++++++++
 arch/arm64/include/asm/cpufeature.h |  5 +++++
 arch/arm64/kernel/cpufeature.c      | 32 +++++++++++++++++++++++++++++
 arch/arm64/mm/contpte.c             |  3 ++-
 arch/arm64/tools/cpucaps            |  1 +
 5 files changed, 49 insertions(+), 1 deletion(-)

-- 
2.45.3


