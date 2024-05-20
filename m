Return-Path: <linux-kernel+bounces-184238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD838CA49B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD6A5B2194B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3002C13AA47;
	Mon, 20 May 2024 22:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iPcvydDh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F17F13A260
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245203; cv=none; b=TJS0CvgdFufiyW5LpBlmYT3kEf/WAPsJijA7i5SNUyjSWyis0kns6QlR2oDBkPK9n8Md/oEY8CQVjK7Sj8+wgT4m0PAoiFbBNB93vfUYRSNtquTRmASEjPWl9W9oNP5JrY1HVngCQcjx+rWUuCkqq5P2445UPodXNVB1vvyj4L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245203; c=relaxed/simple;
	bh=N7BO8ma+2BwG4UD9NIGMDLMhLyzkgYBOUd3reNFktso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svHwcpF9kt3KVSbpjt4Wqu27E8qbYgH4rD7ZYlwzPLuczF2qbFGJRmY3j/dyvBNncCw1ExVhJjFCctsK7watd9XvkhMz8Wbd4bDMq9tCueChR66D+44UZZf3lLPZlqHW6BnT7TyegI8geSjnXJioMPX1BoDr8b2InrkUoXOFtKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iPcvydDh; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716245201; x=1747781201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N7BO8ma+2BwG4UD9NIGMDLMhLyzkgYBOUd3reNFktso=;
  b=iPcvydDh1V9AACKSsjyq7jhYxz2K7cSeMWb+fw+8vO0CBq+Z3UftnR6v
   fhgW7jRRV1hY0aXK9TfnJc0ExAsoM8QyQLnV70MbRHo5X7GwUDOLQdmCv
   lfkEprY90QhTqXvUWtBNsfgsn7T6CVBrf+og51D3qCfb67JrrvWexZoxY
   Pt2lMzE3r8mv+WBM5hPWEbK+PfkCGmmJRaozOMbPxdypwn3Rr1K7jRWMN
   4zKGk7mBT3mZTju1tc5IvI4t8OZkk5gZjNkhSrWp0m6XPmaGQjeZU7Azo
   7baE/A4/en4VgkSV8wEvuEwonDypj5sAJVocmflpzU54smjH9maDcmzka
   g==;
X-CSE-ConnectionGUID: 18AAiIsNT6aBD9LMO7kopw==
X-CSE-MsgGUID: rUa0+RpDSEeP4CqXstYtsQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12199611"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12199611"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:36 -0700
X-CSE-ConnectionGUID: rzvZAkC1Q+iwxdWL6KBEZw==
X-CSE-MsgGUID: q8bHIfDuRHqtHwt74K1gEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32593412"
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
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v6 10/49] cpufreq: Switch to new Intel CPU model defines
Date: Mon, 20 May 2024 15:45:41 -0700
Message-ID: <20240520224620.9480-11-tony.luck@intel.com>
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
 drivers/cpufreq/speedstep-centrino.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/speedstep-centrino.c b/drivers/cpufreq/speedstep-centrino.c
index 75b10ecdb60f..ddd6f53bfd2a 100644
--- a/drivers/cpufreq/speedstep-centrino.c
+++ b/drivers/cpufreq/speedstep-centrino.c
@@ -520,10 +520,10 @@ static struct cpufreq_driver centrino_driver = {
  * or ASCII model IDs.
  */
 static const struct x86_cpu_id centrino_ids[] = {
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL,  6,  9, X86_FEATURE_EST, NULL),
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL,  6, 13, X86_FEATURE_EST, NULL),
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 15,  3, X86_FEATURE_EST, NULL),
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 15,  4, X86_FEATURE_EST, NULL),
+	X86_MATCH_VFM_FEATURE(IFM( 6,  9), X86_FEATURE_EST, NULL),
+	X86_MATCH_VFM_FEATURE(IFM( 6, 13), X86_FEATURE_EST, NULL),
+	X86_MATCH_VFM_FEATURE(IFM(15,  3), X86_FEATURE_EST, NULL),
+	X86_MATCH_VFM_FEATURE(IFM(15,  4), X86_FEATURE_EST, NULL),
 	{}
 };
 
-- 
2.45.0


