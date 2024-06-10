Return-Path: <linux-kernel+bounces-207575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 960B790190A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 02:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B34C3B219D9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 00:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB59A920;
	Mon, 10 Jun 2024 00:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ph1zYUt0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8955717F6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 00:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717979980; cv=none; b=tebbT6YvXxaWHmTBrGK0U4HT9KWsy+Hbh8K4vx81pwM0JL/lkTPTahf0IjJJl75iqjXWmPkuYCbLcRkQrUsoOhLw1td/d+R3Ysyok/+R4roq9vqnxSumMhd9jxAWbzAoFVb/o9NGcdsHbQQ3+8Hae//M96BBmqENmIBEOnVDLw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717979980; c=relaxed/simple;
	bh=MaTT5NLRLK/9xjGGntVtiy1F2BB5m4kTBp+KyL/z3eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuuhDaG2N/DX0peUvK6YTagRX2WLfhGzf7eCJHu6Zl0yIgcmtzyNaCTMbxM6axN2FEvaWNUGOpmzxpYsDSDVIuCVASSvRl25R700HeTN572DWLkeckbqlKkzQdoeOPqTv6CUNZgKvNbf3uZV5heU7/MbIFj2prVAKQ7zLwQg7Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ph1zYUt0; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717979978; x=1749515978;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MaTT5NLRLK/9xjGGntVtiy1F2BB5m4kTBp+KyL/z3eQ=;
  b=Ph1zYUt0KOEOs1C16hJh282jsEzUZ7H5oS9faBgoMW6RcUsykvMMqcnM
   e9eKk9b3SPdD0EiO0s+eOihY1oRK4SCZuo533tbINQE42stu4wazScyGE
   gflUb0NcP7noIO5BDmzvYK+pQNucHAfo7VUgOS+88Y4uQICK/Fbj/BX+K
   5DSXX928ZEw3Wjv0ssUccapq0GrOcZ7tngRj3qADszUnehGEvxx67BwGI
   TC7HkR5j6TthF+N9YX3FDhjPNSXA7Ly1QJAgZ7R0ayAvdEjIQViObYXBG
   Gf1pgsF4AIintLjrpg1hLNGxNsLF5uFlsFNUhOnwWnATVnDg122YcbLSm
   Q==;
X-CSE-ConnectionGUID: XvtMnPw/SNSjwAWB5iHuSw==
X-CSE-MsgGUID: +eyRt379TmiQnR0FZ2VoWA==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="37154970"
X-IronPort-AV: E=Sophos;i="6.08,226,1712646000"; 
   d="scan'208";a="37154970"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 17:39:36 -0700
X-CSE-ConnectionGUID: kfPTOPqQRnKuDbP8IIMMew==
X-CSE-MsgGUID: LwlmMSKfSraYitRhRBs3ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,226,1712646000"; 
   d="scan'208";a="38829881"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 17:39:36 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 2/4] cpu: Drop "extern" from function declarations in cpuhplock.h
Date: Sun,  9 Jun 2024 17:39:25 -0700
Message-ID: <20240610003927.341707-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240610003927.341707-1-tony.luck@intel.com>
References: <20240610003927.341707-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This file was created with a direct cut and paste from cpu.h so
kept the legacy declaration style.

But the Linux coding standard for function declarations in header
files is to avoid use of "extern".

Drop "extern" from all function declarations.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/cpuhplock.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/cpuhplock.h b/include/linux/cpuhplock.h
index d42d2434dab6..999f475bea98 100644
--- a/include/linux/cpuhplock.h
+++ b/include/linux/cpuhplock.h
@@ -15,18 +15,18 @@ struct device;
 extern int lockdep_is_cpus_held(void);
 
 #ifdef CONFIG_HOTPLUG_CPU
-extern void cpus_write_lock(void);
-extern void cpus_write_unlock(void);
-extern void cpus_read_lock(void);
-extern void cpus_read_unlock(void);
-extern int  cpus_read_trylock(void);
-extern void lockdep_assert_cpus_held(void);
-extern void cpu_hotplug_disable(void);
-extern void cpu_hotplug_enable(void);
+void cpus_write_lock(void);
+void cpus_write_unlock(void);
+void cpus_read_lock(void);
+void cpus_read_unlock(void);
+int  cpus_read_trylock(void);
+void lockdep_assert_cpus_held(void);
+void cpu_hotplug_disable(void);
+void cpu_hotplug_enable(void);
 void clear_tasks_mm_cpumask(int cpu);
 int remove_cpu(unsigned int cpu);
 int cpu_device_down(struct device *dev);
-extern void smp_shutdown_nonboot_cpus(unsigned int primary_cpu);
+void smp_shutdown_nonboot_cpus(unsigned int primary_cpu);
 
 #else /* CONFIG_HOTPLUG_CPU */
 
-- 
2.45.0


