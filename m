Return-Path: <linux-kernel+bounces-184265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7138CA4B6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8722A28110E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C6913D2B6;
	Mon, 20 May 2024 22:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rndo5BOs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334FE13CA92
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245216; cv=none; b=sYJgDWOY7+ZTGMCCExLqb3s1BY2LglGzlpffV/TUfDEm6h0VT2cdKlZAU52NvGstosUwJ+BXO7WNgvnHNH2azeIW7A9GgO2m+yBAzAYXTTHTGG2dH5xa+qeJ5ZnKItFoRRbplA20UL0aq4d+3heHY+IondscYHueu6Mu3tgFF7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245216; c=relaxed/simple;
	bh=yvG8vVOFiUlIL/SKzVALgFIjKhQFvNcZtyEQuh9ZrVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V59ePT6AgAlKLhu1gHX51bjV8zsOXvIGUAtie82lHq9lJDCbteoeVo1mo+MSUb0zHp9P4CDZKKtjYqZvqgBhqqtRH8IkVvWbmbYrYPLnE001GVIgp0ZaiN8RjGe9USLKZ25AYOppo+UtuWNgMFfvu7lcnwEOT9JSE2esJs7sO0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rndo5BOs; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716245214; x=1747781214;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yvG8vVOFiUlIL/SKzVALgFIjKhQFvNcZtyEQuh9ZrVQ=;
  b=Rndo5BOsDr2GgTxSzzn+QjoJp8P9kDrIpyrazRV/cqoboT09ciHcyjmd
   gfEOwW2K+BKxJ1KNaJDqAs9EX4dE9QI2TqXwvx5zFN2SDwb85XAhpGi82
   nbPXikTRJZAaRqZg6NCtVQATZanQpiVcXT9etxKBnduCkZ45eQxHycDHs
   CeG7uLXVQ/SjQ0v68QP/nfMly6zT819NvIwt3KuHdO9F/qLtw7Gb70/hR
   DcHQAZ+Z01TEZLhWwP4jXiixftDzkxsR79tB2bt7Eh7myQyB3ClhlAnM3
   ijNVGoGuz/TMZ/zORfxJ2Ka52n3cws9mVPBm7d9mzFdKMJ0P7o1VXT1Lm
   Q==;
X-CSE-ConnectionGUID: QukVl16FSuGoY9H8iJucAw==
X-CSE-MsgGUID: 98ao9+lVQhKd6+ISRFGGJg==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12199913"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12199913"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:39 -0700
X-CSE-ConnectionGUID: yStxYKhOQCKRJBCtnmc/fw==
X-CSE-MsgGUID: BT5RpVzmSqifu12udtCIkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32593495"
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
Subject: [PATCH v6 37/49] EDAC/sb_edac: Switch to new Intel CPU model defines
Date: Mon, 20 May 2024 15:46:08 -0700
Message-ID: <20240520224620.9480-38-tony.luck@intel.com>
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
 drivers/edac/sb_edac.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 26cca5a9322d..cbc92d3683e6 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -3546,13 +3546,13 @@ static int sbridge_register_mci(struct sbridge_dev *sbridge_dev, enum type type)
 }
 
 static const struct x86_cpu_id sbridge_cpuids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X, &pci_dev_descr_sbridge_table),
-	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE_X,	  &pci_dev_descr_ibridge_table),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X,	  &pci_dev_descr_haswell_table),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,	  &pci_dev_descr_broadwell_table),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,	  &pci_dev_descr_broadwell_table),
-	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,  &pci_dev_descr_knl_table),
-	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,  &pci_dev_descr_knl_table),
+	X86_MATCH_VFM(INTEL_SANDYBRIDGE_X,	&pci_dev_descr_sbridge_table),
+	X86_MATCH_VFM(INTEL_IVYBRIDGE_X,	&pci_dev_descr_ibridge_table),
+	X86_MATCH_VFM(INTEL_HASWELL_X,		&pci_dev_descr_haswell_table),
+	X86_MATCH_VFM(INTEL_BROADWELL_X,	&pci_dev_descr_broadwell_table),
+	X86_MATCH_VFM(INTEL_BROADWELL_D,	&pci_dev_descr_broadwell_table),
+	X86_MATCH_VFM(INTEL_XEON_PHI_KNL,	&pci_dev_descr_knl_table),
+	X86_MATCH_VFM(INTEL_XEON_PHI_KNM,	&pci_dev_descr_knl_table),
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, sbridge_cpuids);
-- 
2.45.0


