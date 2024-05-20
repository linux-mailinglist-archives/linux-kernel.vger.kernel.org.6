Return-Path: <linux-kernel+bounces-184272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68C98CA4BD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61ABD281CF3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AF7139563;
	Mon, 20 May 2024 22:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z9WYDV9L"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8410B13CFBA
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245220; cv=none; b=D/dGNyrD7IDdr/tXi0iU1RAt9B+B/h2KNiQEwawt+15oiHAnSaUoxutHFaxdURvgFWF++Nmy/tG8sXTatkOUysCyRVDGccyPNWdzgNFSXJ8bzLQ1pdM/ICUbrFxSLXePd4YBGrqWPf9X/Z3+VJXFfeO4DhdyB5syU4iiCJVWvcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245220; c=relaxed/simple;
	bh=mv/DdbZyo6eomJ/rc6S48OLZws5x/hvaTKemElND+wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1b8w1CXVjz4jw9gMkSUUx4ptKQTgTjZyvE2IpkuBKEUZmqT2w58xgKlmGj2ZSJHdPwSZHnbHGjOi5QSXHtN2ZUtlgMsMLRHjcJYLPQNiZtKlEPYWHLpQzwEkUQN9j8B4frma1Il05jxuSyPstLe6LcEEhziHNuR3QQgo8v+/6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z9WYDV9L; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716245216; x=1747781216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mv/DdbZyo6eomJ/rc6S48OLZws5x/hvaTKemElND+wk=;
  b=Z9WYDV9LFkxFaNVelu/uBUrpyRzgC5dYspkpRBYP3Yd2CHTOutQY2x/K
   PWIAwGoyGry/Xtn/QTfRfK+tSR9a7ey1bh7O5QvxFF7lCGHyuevBItsOt
   U8cL2G9/5liRQDKyV1vNPvyeti9oY/SfmLb0ydRKmggNdjPM7I07NbQhT
   jLqMp/OAZvy8IrVEXRQdGcAzI286GwLn56fjaLzlmMTtmQeBuLLQf/8oa
   YxhcvwA57EAqE/kdiAQSQU84omGNGC0aqFZgeXTXR4/CltbqzRkV86HYa
   HfxdddIk6DFFFcdhQGd6PEHLRGFCjkrT/Utp+C6bTBsbrvTRM7erAQjtG
   g==;
X-CSE-ConnectionGUID: Msm4DpycQY69wIA0g9Hjug==
X-CSE-MsgGUID: YU3zzfCkSI+hjXLiqGxqOA==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12199949"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12199949"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:40 -0700
X-CSE-ConnectionGUID: N6iJoTr9Rs6llL8HsCEguQ==
X-CSE-MsgGUID: gq4jayzTTueHQeNli00jwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32593505"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:40 -0700
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
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v6 40/49] ACPI: LPSS: Switch to new Intel CPU model defines
Date: Mon, 20 May 2024 15:46:11 -0700
Message-ID: <20240520224620.9480-41-tony.luck@intel.com>
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
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/x86/lpss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/x86/lpss.c b/drivers/acpi/x86/lpss.c
index 148e29c2c526..258440b899a9 100644
--- a/drivers/acpi/x86/lpss.c
+++ b/drivers/acpi/x86/lpss.c
@@ -338,8 +338,8 @@ static const struct lpss_device_desc bsw_spi_dev_desc = {
 };
 
 static const struct x86_cpu_id lpss_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,	NULL),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT,	NULL),
+	X86_MATCH_VFM(INTEL_ATOM_AIRMONT,	NULL),
 	{}
 };
 
-- 
2.45.0


