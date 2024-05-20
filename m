Return-Path: <linux-kernel+bounces-184250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 875838CA4A7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B86581C2129B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947E413C66F;
	Mon, 20 May 2024 22:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e9HljlYP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8180413B5BE
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245209; cv=none; b=FIkPKHHZEm5sCddwKSQihFavSgxFclfGNtZWiO0qN+EasUvfN5Xbf9cH8Rk2wX3B1ZVNkds1DehHSZ7DM3vw/euMpQNg05JYrFbWVMiICUTMzE22S4aLCyYH13uKdkplPQ6AY9ivzGlA5+NftqJ1vx5goHADLibin51FkVFKUY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245209; c=relaxed/simple;
	bh=PQHhBRWTyJ7lXAnwUF6T1t71Eh1K9Um/FsP12CRYfhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rlxub/v8X59EI9kKiCYLBlkk9Pib0qje7yE+XfwCDqISfWlNErIkTU9ZevaOmOWxVq30784HKWhi8AEo0+YfMrtshZSAvhg89KOny/HLOt4636iLt54WtUaGvrfNOYU0yI8hgPRjkYVd2VGdQ+Ov3um1cDHvEuP86p+M4aX0wIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e9HljlYP; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716245208; x=1747781208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PQHhBRWTyJ7lXAnwUF6T1t71Eh1K9Um/FsP12CRYfhs=;
  b=e9HljlYPL40Eim/NR2njdP+k6nEh/uEop+6U/1fSI2A2OSkJA4W+rbRs
   RLPCLFP6AE23KwAdvDxyZsaOxwmuQqYgjVPVNFoJ/d9muqew3rX9POs2N
   Ma284qrI9WL+StPmoA7J7iYsalz88sV17RwKGys1f/k2ADBWdMWCocfux
   7BmyNBNt0C+X2hU1jJeJ1wBqw7W8cli6ztGU5a8LoSulzVd95CKaibgCZ
   FLKQ3zKlVADGYYIcEnkmtcrpH8XTI4e6wrUhHSsuNAhtCfhKP3zezW504
   B820Eso54jfsWdZdvCUhMm0tXdTqRkfLgnvo5/8HmaT2BqjodHe26LCHd
   g==;
X-CSE-ConnectionGUID: JhN6bM61Qpihq5C1glumTQ==
X-CSE-MsgGUID: NB0tLkvoREitYUFPamebpg==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12199756"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12199756"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:38 -0700
X-CSE-ConnectionGUID: hgJ5Tr7QR8W9CQr8QmhazQ==
X-CSE-MsgGUID: MUEH5rC1RmW5u4N+LO9a7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32593451"
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
	patches@lists.linux.dev,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v6 23/49] platform/x86: p2sb: Switch to new Intel CPU model defines
Date: Mon, 20 May 2024 15:45:54 -0700
Message-ID: <20240520224620.9480-24-tony.luck@intel.com>
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
Acked-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/p2sb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/p2sb.c b/drivers/platform/x86/p2sb.c
index 3bf5d2243491..31f38309b389 100644
--- a/drivers/platform/x86/p2sb.c
+++ b/drivers/platform/x86/p2sb.c
@@ -24,7 +24,7 @@
 #define SPI_DEVFN_GOLDMONT	PCI_DEVFN(13, 2)
 
 static const struct x86_cpu_id p2sb_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT, P2SB_DEVFN_GOLDMONT),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT, P2SB_DEVFN_GOLDMONT),
 	{}
 };
 
-- 
2.45.0


