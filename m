Return-Path: <linux-kernel+bounces-184240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A9E8CA49D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B671F21844
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659A013AD3A;
	Mon, 20 May 2024 22:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jUVog0QY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA2E13A417
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245204; cv=none; b=Vrru8VCLTQwMIsSNsI4ve8MvKixiZWo+BrMdaP+uIu1Pvm9C0HDI6Ip/OGkBT1j/91jysqyDXumXTqIWtv0zh+X7Y5ZxU9Rfmvcy0cAy9fAU8jrF0gzN2Iknpk0mCDzrtNyuJAsa/45leBnvEADDXpQMCTeXVvfn1VX6pnP5r7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245204; c=relaxed/simple;
	bh=UCxMtBp8JAc8kiqTmHIGiN2JeFnF21tMXCqSLt0G2gM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+pcnnb2FKqSXqeuQO4Sq9/Jxn1E8bJjb+OjMWnKKrWrKrcnKWuuncFa/iZnfpxD/NZYJzDnDVTXcgqPkom2gdLxry7mmsbrYrdNQAPvFrf9f0HR/mwb/6CsIHqUSWdCj/aEvV20DhWbCs1nMoSPDGsH2TO8R2fOUBkjRalOgRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jUVog0QY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716245203; x=1747781203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UCxMtBp8JAc8kiqTmHIGiN2JeFnF21tMXCqSLt0G2gM=;
  b=jUVog0QYo77UVUsvRW/YR4xQZLTyes47+JCP9rIy4kOHj/DdRYy/kJLs
   peUWv0O6ptVlySUSCp480JoAwMF3HLI901PKEzyIk7yxOzzO29CptZFdf
   habf3MqfJZ4iTXYEj5ZXWZ6ReCCvpbLPmkhQHb9BuQvdPhTOdG8UhzN+d
   4R7W4+qwyBbyj/g09SgKCqiR+DonlNFP+SdlKRwX+9cdfGg8Ky6U2OAkD
   VrvHZ7jP6gTFTXRROUuPZLtsa7J91ZDTOXR3u/Rx3BmtFDUztWNiHpUDN
   SvEv0Mjln49eZWIXAst357Xsy6xd0XEyduddqBDWqCmo1xKZ/deJbWe1M
   w==;
X-CSE-ConnectionGUID: Yk85uoaaTH2IUUjCI+KNTA==
X-CSE-MsgGUID: uYxZJoxFSRWqv/kZmhwAOA==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12199638"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12199638"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:36 -0700
X-CSE-ConnectionGUID: rlYlv6GQSsq8AeKfMtVR6Q==
X-CSE-MsgGUID: 8GvZ7HJCTVCdtTTPSvXKeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32593418"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:36 -0700
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
	patches@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v6 12/49] PCI: PM: Switch to new Intel CPU model defines
Date: Mon, 20 May 2024 15:45:43 -0700
Message-ID: <20240520224620.9480-13-tony.luck@intel.com>
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
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-mid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-mid.c b/drivers/pci/pci-mid.c
index fbfd78127123..bed9f0755271 100644
--- a/drivers/pci/pci-mid.c
+++ b/drivers/pci/pci-mid.c
@@ -38,8 +38,8 @@ pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
  * arch/x86/platform/intel-mid/pwr.c.
  */
 static const struct x86_cpu_id lpss_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SALTWELL_MID, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID, NULL),
+	X86_MATCH_VFM(INTEL_ATOM_SALTWELL_MID, NULL),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID, NULL),
 	{}
 };
 
-- 
2.45.0


