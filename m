Return-Path: <linux-kernel+bounces-184246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BE58CA4A3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B852811D7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7859A13BAE3;
	Mon, 20 May 2024 22:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iOHZxqna"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BDD13AA5D
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245207; cv=none; b=tQMIhnRJ4BBifwTm67kWINHV94B0UyoBuykmZJit9r0R3z8/6lpUoZoCgHbFWJvCwxApxK/Zvf9Fa2rTs8s0kBFlInNVv+LA22WlaqKyAdsoA26QgVt4GWKIgN61UZU4Kiei21kki7VKr+exy7V/wLUsRGzNH9TUbYQUnswg6NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245207; c=relaxed/simple;
	bh=hG3FP4AcNKVMSK2tzoC+JG6H48CVh98nrbPvxUI40RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ID6b+QWiqsxHAwsImMxLgBCRZejVKIgcre1Hhd4CdUuEGTUn642u3I6c69gRij5bqG+v3iiYMQqJpQroRNw0+tmAKaYy1Cqv4Pf0aE5gzGXYvmbkbwPxb/hjTtDpZOmCEGPRaXT/mYsyg4v8POOEVmX27cTLrqtoQ1Xpcu6DDBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iOHZxqna; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716245205; x=1747781205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hG3FP4AcNKVMSK2tzoC+JG6H48CVh98nrbPvxUI40RA=;
  b=iOHZxqnaFhW+Q24FeTYxM4YUg0kZLoXr0CEF5ZH7bKeUhCXYlXNCCSnG
   ZojM7b9swk4Jmr0fNMd+Kf/yNZVhKS3r0H3p2Bxan5x4TW8GQBO6fV7DK
   sQ7153NxgQvGI8RSiJCVBPnw18vIHUns6ml1m9dF3g3YFlA8Hn2ctGK++
   ApOBzvDfxCbltK4dJ7+JgY+Vcq9T6xmBOr48+0qgeziFrmWzAjanjogQw
   UMGjH7kyTNzKKmognNIVEd6vFyT83c1IvSjN5DrDfqMBQjNK3wwUcfwCN
   PPeEsnO7o+urXGLgb1W1VZtkHZu/OpOBTUOusSiBMlgU1xORD8PbWYSgK
   g==;
X-CSE-ConnectionGUID: 8Ohxs9gXTM+qGSohWSMvog==
X-CSE-MsgGUID: R5SN4+gSQ42rVQVN1DxB6w==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12199690"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12199690"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:37 -0700
X-CSE-ConnectionGUID: jTD+lewsQrm7iSCS0pL6WQ==
X-CSE-MsgGUID: V6PIu/WDRNSu54Do8AB0ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32593433"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:37 -0700
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
Subject: [PATCH v6 17/49] platform/x86: intel_speed_select_if: Switch to new Intel CPU model defines
Date: Mon, 20 May 2024 15:45:48 -0700
Message-ID: <20240520224620.9480-18-tony.luck@intel.com>
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
 drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c b/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
index 1b6eab071068..6c36f7704fe7 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
@@ -161,7 +161,7 @@ static struct notifier_block isst_pm_nb = {
 };
 
 static const struct x86_cpu_id isst_if_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X, NULL),
+	X86_MATCH_VFM(INTEL_SKYLAKE_X, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, isst_if_cpu_ids);
-- 
2.45.0


