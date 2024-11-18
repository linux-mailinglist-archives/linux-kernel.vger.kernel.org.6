Return-Path: <linux-kernel+bounces-413510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 879A79D1A14
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 22:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A732B22B17
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 21:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BABC1E882A;
	Mon, 18 Nov 2024 21:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FYyM8k8S"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD12B1E631D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 21:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731963933; cv=none; b=hoODBzzABd5jzsc7Cz9D9Aa0ApcHhojRQKE7ISi49rTHqPueo83wLdDcQMvSzEtdQjiONQJsiO9EXqDEdpjVMSzXHYGIKtoravXFSURCK2rSUqXUhyI5d1YwPuULmjWLzSSImhLg4u3hhq74Bf0ltCbJF8/9HTzNj6bmGwwZXQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731963933; c=relaxed/simple;
	bh=blGWhtR6NF+x/0PawezFXFF9gzLHyA0/qJ5zJXb9UnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sKsp+LSagati+IpMFts2+6maCDlckUrZQ3Hhld+eTMX8rKUwVbyiigS9+looKj9156ktVtK9YEfC5MgMLjFkfeN1rs4rFgLPyhwHDPeynbsrfu2OJivmAeJ9geCS8SdcCVdRR2CXsD0TodKYXNCtVbEWtMXuDqMT2On0Shk+FhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FYyM8k8S; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4D58440E0261;
	Mon, 18 Nov 2024 21:05:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NhHVV1MGu5is; Mon, 18 Nov 2024 21:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731963918; bh=FEUECKS5LfLmJmfLtdQqFhCDBN/wXLX44MGyApGQMO8=;
	h=Date:From:To:Cc:Subject:From;
	b=FYyM8k8SEKd2SyF9/dTC2EQn2Llvg1eJgQABaqsyxOmZNJf6Ims0McmWUQwX50+7K
	 vHZJEEGgFiEGHNrx8xGyK3OQYn2o3dS30iRYBttHokImBPgoSDsM2BAt+pNxua8/zg
	 02HbcrpjmLRGi0MGop63PnYy7Xzq6dnstNxpzwmq4hORGlpqe9IlDDXpy6BWybMQLu
	 uXk8g0F024zjM5tACl1MeL0mWrg46ATQ4MEVL/zFgAU5iOWmQVuc6ukxKnHRLoMtCM
	 N8qDMXfUc4QTe2+Bl2nFFJdZKV3qYofEvmdKc+SSsvSV5fT+KEZRvMoWXG5MO8XtGB
	 LGwapT2kGF2ivf+SM9L414vlDVAPMJDoGSjri/aKq3HQ7rmWROtn2JxGF6+bKMVbkL
	 R4hU0dDwaPHk0GDV7Z2qbfN9P0xVL3Xt/8IOnd4gBc8Nbn6NVIt0QT0w9wJqse9CHZ
	 VArHyLZl4luSzgh5ya02i+yCD58+pZ8ErmUsZM+mMwOgRvLUnTABdkSyUTi3LC7F2n
	 Gzd8wHC007+Unwo8LSAEtklAlkVnkrJOfi7SQbwZCoQWgzpWP4P4qnY0kW/odcL1gR
	 DkZvK1hUbB67YMvQKhOJZaU1gNt/EZ57RuUsEvS+WOAjUa0SDvywFSZUItbnhPYJJV
	 QP2qlBx2PZzrnadlolBoDEwc=
Received: from zn.tnic (pd9530b86.dip0.t-ipconnect.de [217.83.11.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D978140E019C;
	Mon, 18 Nov 2024 21:05:14 +0000 (UTC)
Date: Mon, 18 Nov 2024 22:05:08 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cpu for v6.13
Message-ID: <20241118210508.GAZzusBLFPq3Rqt50z@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/cpu lineup for v6.13.

Thx.

---

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_cpu_for_v6.13

for you to fetch changes up to f74642d81c24d9e69745cd0b75e1bddc81827606:

  x86/cpu: Remove redundant CONFIG_NUMA guard around numa_add_cpu() (2024-11-12 11:00:50 +0100)

----------------------------------------------------------------
- Add a feature flag which denotes AMD CPUs supporting workload classification
  with the purpose of using such hints when making scheduling decisions

- Determine the boost enumerator for each AMD core based on its type: efficiency
  or performance, in the cppc driver

- Add the type of a CPU to the topology CPU descriptor with the goal of
  supporting and making decisions based on the type of the respective core

- Add a feature flag to denote AMD cores which have heterogeneous topology and
  enable SD_ASYM_PACKING for those

- Check microcode revisions before disabling PCID on Intel

- Cleanups and fixlets

----------------------------------------------------------------
Borislav Petkov (AMD) (1):
      x86/cpu: Fix formatting of cpuid_bits[] in scattered.c

Mario Limonciello (2):
      x86/cpufeatures: Rename X86_FEATURE_FAST_CPPC to have AMD prefix
      x86/amd: Use heterogeneous core topology for identifying boost numerator

Pawan Gupta (1):
      x86/cpu: Add CPU type to struct cpuinfo_topology

Perry Yuan (3):
      x86/cpufeatures: Add X86_FEATURE_AMD_HETEROGENEOUS_CORES
      x86/cpu: Enable SD_ASYM_PACKING for PKG domain on AMD
      x86/cpufeatures: Add X86_FEATURE_AMD_WORKLOAD_CLASS feature bit

Shivank Garg (1):
      x86/cpu: Remove redundant CONFIG_NUMA guard around numa_add_cpu()

Tony Luck (1):
      x86/cpu: Fix FAM5_QUARK_X1000 to use X86_MATCH_VFM()

Xi Ruoyao (1):
      x86/mm: Don't disable PCID when INVLPG has been fixed by microcode

 arch/x86/include/asm/cpufeatures.h              |  4 +-
 arch/x86/include/asm/intel-family.h             |  7 +++-
 arch/x86/include/asm/processor.h                | 18 ++++++++
 arch/x86/include/asm/topology.h                 |  9 ++++
 arch/x86/kernel/acpi/cppc.c                     | 23 ++++++++++
 arch/x86/kernel/cpu/common.c                    |  2 -
 arch/x86/kernel/cpu/debugfs.c                   |  1 +
 arch/x86/kernel/cpu/scattered.c                 | 56 +++++++++++++------------
 arch/x86/kernel/cpu/topology_amd.c              |  3 ++
 arch/x86/kernel/cpu/topology_common.c           | 34 +++++++++++++++
 arch/x86/kernel/smpboot.c                       |  5 ++-
 arch/x86/mm/init.c                              | 23 ++++++----
 arch/x86/platform/efi/quirks.c                  |  3 +-
 arch/x86/platform/intel-quark/imr.c             |  2 +-
 arch/x86/platform/intel-quark/imr_selftest.c    |  2 +-
 drivers/cpufreq/amd-pstate.c                    |  2 +-
 drivers/thermal/intel/intel_quark_dts_thermal.c |  2 +-
 tools/arch/x86/include/asm/cpufeatures.h        |  2 +-
 18 files changed, 149 insertions(+), 49 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

