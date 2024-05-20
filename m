Return-Path: <linux-kernel+bounces-184263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7348CA4B4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17461281B53
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE47F13D26B;
	Mon, 20 May 2024 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LO0QhOfY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD3D13B792
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245215; cv=none; b=Li0k6KdxZhpvYN7aMYTO2V9AqgY/gqfFUh3xdZKJixtSM3/Qt6iZ5l6ndlEKYX1gx1Ju0GjrI42Yn4zeNNDqmw3wPpGiJyh909RoF/hcCSfHt4d/KPUeY/afaU33PFYtQ1xckkXAzhPz5FXaoW5x1onoNfO+yb1TjXaYojBBtXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245215; c=relaxed/simple;
	bh=ifunLBjjEJ27+/uU6cajdNrtE7FxVrkvN9E3z6UIJT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZARKiRTC24MdytBLTW/D0Hq5pTuHj37xPyZ9d4XhHABi6GHEodgGzC5GUBEUSmixJFWc5IwQXDSsW5PQVJzkaloG3dLtEGJfigdT4SSjdve+usuQFYOrT/hpUOCoBC2/jdpuRDSXka/BHfesbjHnsWKINIhTgpWbPlRqbSW9ssY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LO0QhOfY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716245213; x=1747781213;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ifunLBjjEJ27+/uU6cajdNrtE7FxVrkvN9E3z6UIJT8=;
  b=LO0QhOfYpq9AO2b9WDJegU3NZL8rjFHztdD/9hCmiMXROLOgdYpmmWWF
   yX8xnQ3WswJLc08SQBTwat+JQBIBtlbikr+omu8bhfUSDL917GrtytJ0l
   K7a0pp7ra/Qrx//blh+KM4nxml+LLmgWN9XRINxsMp9aSVeqpyuJCk/Jt
   vhpHpdgWq0cFaLZY9nK8PbLqwPsR00cCwIXvrasU/Rd74QYwaXGhA5ezQ
   tqeYtsQrbbJzMiShsD/2TfA+i6YQI4cEQz2bHLRn4oxQZUTwQ4pm8cvn9
   MW2JhdXRxn9V17yFyBdh+LVMHGzFHACI8gSpXyV3frY7TWuYQScPv8gH6
   A==;
X-CSE-ConnectionGUID: dcPDBJXwTwGHJXz3ubxyyg==
X-CSE-MsgGUID: rZetZfOVQ9+vvY+hw967Ig==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12199900"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12199900"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:39 -0700
X-CSE-ConnectionGUID: GVU20H2TQqCBG6tz0xcbZg==
X-CSE-MsgGUID: 9fqPi9D2Qt+5UqCp/uLm3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32593492"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:39 -0700
From: Tony Luck <tony.luck@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Tony Luck <tony.luck@intel.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Thomas Renninger <trenn@suse.de>,
	Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v6 36/49] EDAC, pnd2: Switch to new Intel CPU model defines
Date: Mon, 20 May 2024 15:46:07 -0700
Message-ID: <20240520224620.9480-37-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240520224620.9480-1-tony.luck@intel.com>
References: <20240520224620.9480-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/pnd2_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index 2afcd148fcf8..f93f2f2b1cf2 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1511,8 +1511,8 @@ static struct dunit_ops dnv_ops = {
 };
 
 static const struct x86_cpu_id pnd2_cpuids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&apl_ops),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,	&dnv_ops),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,	&apl_ops),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_D,	&dnv_ops),
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, pnd2_cpuids);
-- 
2.45.0


