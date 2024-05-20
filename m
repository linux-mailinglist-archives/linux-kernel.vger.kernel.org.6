Return-Path: <linux-kernel+bounces-184267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711138CA4B8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8543B1C20933
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD5913D2BA;
	Mon, 20 May 2024 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j245rpoV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4745113CFAB
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245217; cv=none; b=PmnUT1vN4W5vVdDgX1yjY034ie7UKTKDqGoYOAZ2MAXCU6MY66QS2BJcWwDTstlFj9/QugcvnY0rUr0xYQ+CJbwq8+YXMFpu0BpmjfP04rNU5V/uzxLr4TEnGk3gs0JS2HrSt1NUp00sPWMOoFNRzgSAm63x4I7yDrsg6FIGXgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245217; c=relaxed/simple;
	bh=0BIu25xiRc9EWcC4UBkBOf5JXNRhy4328JnDHuEYwgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pf6V2I8kXEy4UM2dgyAElWnnyNFW92lWGDq2P+wPE60A4W/uwMuD5PHnUV3rJy+ciyt2XVZjvWbv4ko5fZdjdwaiSDLvGhfpJSk+dKQTJQ3KqAl0qjYFhg2jL8ziCVjKlPxpVa6CV4t8tbQ1Oqa1ERlasxPsJBLYmKa3hsD7ikw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j245rpoV; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716245215; x=1747781215;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0BIu25xiRc9EWcC4UBkBOf5JXNRhy4328JnDHuEYwgY=;
  b=j245rpoVQ/oI+kYhjDXQRu851wI1A2V2ThGmI+OgPnsH9//s6PxMctoj
   3Yoc3hL2G+73L+6URxj6qAWznviAqMDVouFIaaUMf+XtUgvx23MAepn4V
   6kSIF2uRZtI0P7jDlr4vtmB+NeIuwPCa7SqTsPXodHZF3c6k/fio2Dz2l
   3sHfS8gbLb6T2FdawptvDCDIWmv+UbZ+4GiNN7PF8MXxuUl71WO1rCvhv
   8LMLQGerKG2in0ijhgFzgQwxCUcB/lkehSEMpJWS+P8j7XInuAuncMRjO
   FTTUxRqhR23jWtVvN6dhKUBQwEmaPgBoGlqEnUD+jurXrhKXOpCfb9Zvk
   Q==;
X-CSE-ConnectionGUID: Ha+XOuuGQ4iOzZyD+cmFvA==
X-CSE-MsgGUID: yYJaIg5iTOSR4n6C/GYfOA==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12199928"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12199928"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:40 -0700
X-CSE-ConnectionGUID: WNuY+Ue2QteY1j6M/VwZmA==
X-CSE-MsgGUID: qITB6he/Te+4xpMHQ3uyJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32593499"
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
Subject: [PATCH v6 38/49] EDAC/skx: Switch to new Intel CPU model defines
Date: Mon, 20 May 2024 15:46:09 -0700
Message-ID: <20240520224620.9480-39-tony.luck@intel.com>
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
 drivers/edac/skx_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index 0a862336a7ce..af3fa807acdb 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -164,7 +164,7 @@ static struct res_config skx_cfg = {
 };
 
 static const struct x86_cpu_id skx_cpuids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(SKYLAKE_X, X86_STEPPINGS(0x0, 0xf), &skx_cfg),
+	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X, X86_STEPPINGS(0x0, 0xf), &skx_cfg),
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, skx_cpuids);
-- 
2.45.0


