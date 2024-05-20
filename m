Return-Path: <linux-kernel+bounces-184266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4941F8CA4B7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04BCB281B2E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A4B13C660;
	Mon, 20 May 2024 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V5HZxYHb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD19013CF96
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245216; cv=none; b=ZOCjHTWwxTOcVm2C3jQPJC9GwAI7GnqnBD+gtiyfVWMnZgtZkLW71wBob/b2mx7sctaA0O97vwUzAd6HW2PW/wsQsrxn87X2IBvnHPiyzE47yRHU8hCUoS1DZYPZqOxnQb55CSnNadMbRd1buxHfEnXK+AKKUWu7hqwupl8M3fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245216; c=relaxed/simple;
	bh=PfFXI3d8s3t/NWnQnGzvD1hWBKVfxk2hbTTJbFy8Fl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHo24dbWT6FhK8yIOdzlm+ZVleYqJ+5wHbSXN9MrLi80uvvmHZNAWdT93qH8v00R+Vdt2n2anucbn1JSK70HvLrzD/a0BwbVdtivz3KCz+nuO9SmI/7wgWwygpCg722j1rRE9/eXhMK+9JOQdA5T30YP/HfNcZjGoXUunnHjDzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V5HZxYHb; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716245215; x=1747781215;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PfFXI3d8s3t/NWnQnGzvD1hWBKVfxk2hbTTJbFy8Fl0=;
  b=V5HZxYHbvSbDHrpm234YbQL3spgjBL3oLe1LKf0tE2m9pwEd7ZnBRl33
   BqxjUqwN1kdaZuVITQ4QZt8Tuv8mH4/4IayFxkLxCELNKv0LqWWhgAxbF
   1E+Z9DBIigKTJnrgko/WfO543gO13L23KkkK7fK1qNxJphrShdgd2vSVU
   COHeXijfp5X0rt+oQub2u7hC9KFH/X1DKM7jz5gfzPbd19vTfpEbCMkNy
   FagiMEVxqiQsp2jwqlUpBcKEYRWL3tYD4FSXLS9QWOpTeFC0U1Og1jKgD
   qqdqrKcE5+lVgTXHM3LdNCTKV8r8MBu7SFxjBRq82d22TUUetYWqJdTPT
   Q==;
X-CSE-ConnectionGUID: pm/EWBHWTq6LIUwUrfuOWw==
X-CSE-MsgGUID: QrsrF9RlRA28KvOqRde0Yg==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12199942"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12199942"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:40 -0700
X-CSE-ConnectionGUID: QRLoRNeHQ0Od5z6D8hPZAw==
X-CSE-MsgGUID: FZ22/soYRF2xjxrtSRVzZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32593502"
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
Subject: [PATCH v6 39/49] extcon: axp288: Switch to new Intel CPU model defines
Date: Mon, 20 May 2024 15:46:10 -0700
Message-ID: <20240520224620.9480-40-tony.luck@intel.com>
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
 drivers/extcon/extcon-axp288.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
index a703a8315634..d3bcbe839c09 100644
--- a/drivers/extcon/extcon-axp288.c
+++ b/drivers/extcon/extcon-axp288.c
@@ -108,7 +108,7 @@ struct axp288_extcon_info {
 };
 
 static const struct x86_cpu_id cherry_trail_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,	NULL),
+	X86_MATCH_VFM(INTEL_ATOM_AIRMONT,	NULL),
 	{}
 };
 
-- 
2.45.0


