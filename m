Return-Path: <linux-kernel+bounces-184270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6238CA4BA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402BB1C211CD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDCD13D88F;
	Mon, 20 May 2024 22:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CrMmLYsH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B48613D289
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245219; cv=none; b=P19Nc8N5O5lkrSQEpzrIYThhmaQoaeylRjAtFcg7hxzUBsz41qni/Kt5g7wKTFZ70AC/GeoxM1F9ltB/q3TrrDpddHbRSSaHYmsXLX6vTNy25VUGKEetz1V6Br4qYCbo1nAXsIYbMFT0eCq1mtcOYnL6FpJMfY6M1u0RbROfFL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245219; c=relaxed/simple;
	bh=PBr5qbc4Ss4oqMBYAxjj4UdSDANT6hrIS0/VoPySkL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q11SGMVIVs5Hq0+CDwh94SGLta7yPX8nb/YXgg1zWwOv4jXz0ZDe70N8dx0TxAoI6XQzDrZLJXa7Ve15mnyWlF0Q2GTw3b6rfxaJJiiBdjZM3Upc1xeJpHieH1IFj2aRw4AOKZDOyGpkX417paprkrCom75JOd9NAvnbmMbmxB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CrMmLYsH; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716245217; x=1747781217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PBr5qbc4Ss4oqMBYAxjj4UdSDANT6hrIS0/VoPySkL0=;
  b=CrMmLYsHlpy8xuPFQ0nuf15zNWgZCCNjCgJheb2bwKVo4NesY5okFBm8
   os1GVuSaDfJZna6pGmmhJVpOozZOsk6VAcSoEM4O9pBzKGt256+gybX6l
   2fvy5cLePJzDKPBV1s7ECjXjiFXgXBSlNfB+ZKLEf4hJz1J5gmsIwl7D+
   9BicFUOwz5KXXFEChlR08tg7GCmEbHSCUZesizs9NteLg/J0cQnN2HMwM
   558shNbxazJu6FghrykTJUBCvagzbWiDtwQZ5pvVFUvLQL6faSDf7BCyo
   HPT9o1S0+qOpxYwbKTqn5x99RAKJcuQeb3dUfzi3WeLP14qyfIhXFdn5k
   g==;
X-CSE-ConnectionGUID: tEpKD8IaQXG1vd4eoMYzOw==
X-CSE-MsgGUID: lksSWXa4RT+BI1rXjIyJRQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12199990"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12199990"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:40 -0700
X-CSE-ConnectionGUID: nptkOWmKSM6BWb7h4XSrXg==
X-CSE-MsgGUID: 7g7XCoOAQa+0UHw/cvqnhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32593519"
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
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v6 44/49] platform/x86: ISST: Switch to new Intel CPU model defines
Date: Mon, 20 May 2024 15:46:15 -0700
Message-ID: <20240520224620.9480-45-tony.luck@intel.com>
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
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
---
 .../platform/x86/intel/speed_select_if/isst_if_common.c   | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 713c0d1fa85f..21e15e679fc3 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -719,10 +719,10 @@ static struct miscdevice isst_if_char_driver = {
 };
 
 static const struct x86_cpu_id hpm_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_D,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT_X,	NULL),
+	X86_MATCH_VFM(INTEL_GRANITERAPIDS_D,	NULL),
+	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,	NULL),
+	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,	NULL),
+	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X,	NULL),
 	{}
 };
 
-- 
2.45.0


