Return-Path: <linux-kernel+bounces-237057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F342591EA6A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0C81F21807
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836A3171650;
	Mon,  1 Jul 2024 21:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l6Fws19+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F50D84A5B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 21:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719869827; cv=none; b=kbNvvuMA9u9V9+YyH8sGuWmDDV28Xl06hOA1vXjbczGDeG6HO/W2ygKNpuNgPnuI+7LEOgzI3YbYXMEhADS+6Q9ZNaxhaW5JLYsyARHtCcaXmdS41L7N+FVtpSoFcGErb3z17crJUT7ZVd323PoGYnL/A6g6a2mzLbFZfYjqi78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719869827; c=relaxed/simple;
	bh=RJr1cRKNNn8xxj7jXfqYNQYRN2Qj0u9+INtfv+Jz9fs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NHqooZsulIhQDNFzDAeuSSxu5eG2yB5M5HZ2DIxgoR0rX/BpgK1kiLre23upESvwYqThJHh3gP6RU4h1CjI9AYiFpvMCj1JNucXOYg6Qh0zK/gB5guyDrNCHy2CgsmLkonUt9NbHBVMVkrk5361FSoQY0fzfOyMh1zC1I9rtTvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l6Fws19+; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719869826; x=1751405826;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RJr1cRKNNn8xxj7jXfqYNQYRN2Qj0u9+INtfv+Jz9fs=;
  b=l6Fws19+LsAAP+Syv+OBQNJ/fHBFUjuMKXb9ESU6xsQLmRYhJnsn5vmQ
   E32QznR3eDi+q7uRBchqYBcaarDyxaRggX72WBgs2Nk5EpCnUvRM+taQS
   s1JWUEWyHLXhuFoZBvdQpJz0ucPd3Ogvz4A1dwuV3Ch5NDiVwJG0tx4I+
   DhZ1PuhC+9F80NMZ1L8wgnYgw3lue0yzHQbE5ywenR17UtkxxZxYa/Pew
   D+CrzGv0Xc4pefQD0KJovOGE25P/5LL3ndwYk8/FEH2Apv1+0brrfF+Ga
   uezn/wNac/wbpug6gk+xUvNHvSKPhyy9oowvQvp812vnqFZKyjqAj1xZr
   w==;
X-CSE-ConnectionGUID: Es4ijX7HR+6o/T3nEcC8NA==
X-CSE-MsgGUID: qAKZ8NAGRNeHqxps9XjfZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="16685002"
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="16685002"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 14:37:05 -0700
X-CSE-ConnectionGUID: 8gbmYNngRlykNQcJ0znXgA==
X-CSE-MsgGUID: rAFlOhRSRlqKcjFbJRIGDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="46093045"
Received: from chang-linux-3.sc.intel.com ([172.25.66.177])
  by orviesa006.jf.intel.com with ESMTP; 01 Jul 2024 14:37:05 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	tony.luck@intel.com,
	ashok.raj@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH 0/1] x86/microcode: Revert cache flush on Intel microcode loading
Date: Mon,  1 Jul 2024 14:20:11 -0700
Message-Id: <20240701212012.21499-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi All,

During the process of aligning our internal code with the upstream code,
Yan reported significantly increased late loading times. William
identified the cause as the cache writeback and invalidation in the
microcode update path. This patch [1] appears to have been around our
platform-specific branches before.

The changelog [2] explains that the flush can guarantee a successful
microcode update and mentions Broadwell parts as an example, without
specifying any erratum. After discussing with some related folks, the
erratum [3] was clarified as the reason for the flush.

However, the affected revisions on the relevant Broadwell models have
already been blacklisted, making this flush obsolete. Initially, I was
quite confused that the two approaches ([4,5,6] and [7]) were dealing
with the same issue. Unfortunately, that is the case, as I double-checked
with the author.

This cache flush does not come without a cost. In older parts like
Broadwell and Skylake systems, for example, it takes about 3.5x more time
than WRMSR for the microcode update.

I’d like to ensure the patch description is clear enough to describe the
whole story for the record, as I am posting this revert.

Thanks,
Chang

[1] “Drop wbinvd() from microcode loading”:
    https://lore.kernel.org/lkml/20230130213955.6046-9-ashok.raj@intel.com/
[2] Commit 91df9fdf5149 (“x86/microcode/intel: Writeback and invalidate
    caches before updating microcode”)
[3] BDX90 - Loading Microcode Updates or Executing an Authenticated Code
    Module May Result in a System Hang. Details can be found in Intel
    Xeon E7-8800/4800 v4 Processor Product Family, Specification Update,
    August 2020:
    https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/xeon-e7-v4-spec-update.pdf
[4] Commit 723f2828a98c (“x86/microcode/intel: Disable late loading on
    model 79”)
[5] Commit b94b73733171 (“x86/microcode/intel: Extend BDW late-loading
    with a revision check”)
[6] Commit 7e702d17ed13 (“x86/microcode/intel: Extend BDW late-loading
    further with LLC size check”)
[7] Commit 91df9fdf5149 (“x86/microcode/intel: Writeback and invalidate
    caches before updating microcode”)

Chang S. Bae (1):
  arch/x86/microcode/intel: Remove unnecessary cache writeback and
    invalidation

 arch/x86/kernel/cpu/microcode/intel.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

-- 
2.34.1


