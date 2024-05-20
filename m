Return-Path: <linux-kernel+bounces-184256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9FD8CA4AD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B1B6B212C6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9408F13C9C8;
	Mon, 20 May 2024 22:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nKqUfhqW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667FF13C660
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245212; cv=none; b=FPeWv5OLXbq2m1WUSAF0VcZA/xi9Fh78x8oEWaqi4Jk9ggrHYtDsmEo5M7G6lHaZ60kRriKaskqltkup+9I1qHSGQ+oUQYQY9mLh+8kawlDT0mMbp3o19guLhia3KE9DaR7bWOAxmNIP1ED4zdWkL3/Ad5xXR4NE+gsEtepkT8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245212; c=relaxed/simple;
	bh=lbpkB4zBQpI4GcfCpRLlxtqxYH5hSB0ZDHxIhsLKKBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCg4QDwA6NUUBK/hm2x8z1RY4Mj00NCwtDWAJcDoo0MuNea+yCVQqfTH0/g+6xD9F6DtCfjxwbG2FR9MmBK5e/3eheMFIjSnA0rHaVmLTPUD072NXRQoguC8zMivl4hG45Dq6XcpEFxyYeXaSAu8LTtD5lciyZVFlKiFbMRuOS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nKqUfhqW; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716245210; x=1747781210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lbpkB4zBQpI4GcfCpRLlxtqxYH5hSB0ZDHxIhsLKKBA=;
  b=nKqUfhqW1T+TdSkjZMwh8GWyqLHknWk/mrofBfuev1X3zFOfqirDeuOZ
   f/XSB1eDNxgE/KHULbZUq+atYOdwC4qUa2zBlYsQpBvOw8yp0b2C51XBs
   e0Q5ONAlYCuj9VFQQSM2ofi80k0zwlzkbMzbSK6jb1AQtzXUE2MYtDMuq
   j/cVYvtu7lrdk42O3N3PXoweodi6mreh5RMSbW7dq+h4hPtQXaUlLSz36
   aGvsVlR3udO84IzLa+n7xJ30fmB9fKMvGQzswpT1X0t5UKvAG5AXBgHGZ
   vax0Kok0L8gYxHaHz/Bg74eyMBAXigfzOVyasKSX5rclUBQyIIwl8xZgv
   g==;
X-CSE-ConnectionGUID: Q9qS81HvRMOB25C3AKhxBQ==
X-CSE-MsgGUID: gTqtKHzUTtaiy9+7ymKjbQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12199829"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12199829"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:38 -0700
X-CSE-ConnectionGUID: O4y47AxMTaynDCoGD+QjFA==
X-CSE-MsgGUID: DK/YWFaeRTu19v5t14xv2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32593470"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:38 -0700
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
Subject: [PATCH v6 29/49] x86/PCI: Switch to new Intel CPU model defines
Date: Mon, 20 May 2024 15:46:00 -0700
Message-ID: <20240520224620.9480-30-tony.luck@intel.com>
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
 arch/x86/pci/intel_mid_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index 8edd62206604..933ff795e53e 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -216,7 +216,7 @@ static int pci_write(struct pci_bus *bus, unsigned int devfn, int where,
 }
 
 static const struct x86_cpu_id intel_mid_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID, NULL),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID, NULL),
 	{}
 };
 
@@ -243,7 +243,7 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 		model = id->model;
 
 	switch (model) {
-	case INTEL_FAM6_ATOM_SILVERMONT_MID:
+	case VFM_MODEL(INTEL_ATOM_SILVERMONT_MID):
 		polarity_low = false;
 
 		/* Special treatment for IRQ0 */
-- 
2.45.0


