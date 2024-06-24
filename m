Return-Path: <linux-kernel+bounces-227913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC328915809
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43DB288984
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1B91A0B15;
	Mon, 24 Jun 2024 20:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FR8NKTIS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C3D1A08B3;
	Mon, 24 Jun 2024 20:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261148; cv=none; b=pan8Y/9DvBAXK/mu8jdvd/UTLe/HFV2Jo7bykH0nUb9koecAIpAY93FD7q2/oc+4tuKoafA8AwVrVZhdl/B8gk4iMV+sXP+MKnu4MjAZpF8tIpFvA+dRTj4U6Ffft+o+ygoZbrw0sX9TrrO9ypQw0KZKDblr0GGh8Zw243JFIlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261148; c=relaxed/simple;
	bh=4iWgm+KhvZkjOINMpHdWnTqey5RaQD+vHCGpz1KvSOw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HghkiXjJzjie9EtfM1Vq614+U0CZaUui/Uq6K2GvAH/cqoId8HvcrorlkjcFNxnV4vcr8TwqQR/njNbRgMNsVBADkvuzWf3tmYt0DrYfrD32bZUqFeJCGIqFvkmioae7RBDfyKLsQuN+0nNwAQO1iHn/3gR9g2HwWAn3sYbIpAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FR8NKTIS; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719261146; x=1750797146;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=4iWgm+KhvZkjOINMpHdWnTqey5RaQD+vHCGpz1KvSOw=;
  b=FR8NKTISV3OgPoiynoBu5xCkfMPmCQvKlMm7b8q178ntmMA8OC7ndFS4
   RhA5FMnwi51G5WESY9y5WCgDedcYNXOBj6qi/GAJmGuE07CQJZkMxg2sK
   znCSOlr4ulsCrwbvaPpKiLrxMHLWu9sdh9iR079oye/H/pAns0D/VxgtL
   ZajQrgjyQH/i18WPyPZd2wXa0NzDkMK5hT8MsWuWPRHkCjMob6m9EnThW
   MrZmeYL99PYIVyK1mvSPi+GY05VmSk072uiqErk5igY76HGgb/F5q6OTQ
   joOriUmPXYqJR3Rm42cEorr4fQ0Hoa5Kc61x07pAYpmRnNUWm3u5+Mej5
   Q==;
X-CSE-ConnectionGUID: v/u1roV6Qu6oxvZQqUJnng==
X-CSE-MsgGUID: B0sUBEx8RP2R1/R8YWQI/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="33792340"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="33792340"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:32:24 -0700
X-CSE-ConnectionGUID: zlGQ6eVoTeaQ57Sj1WSAQQ==
X-CSE-MsgGUID: ts1F8s9XT9KMOzur8jy4BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="47949142"
Received: from ticela-or-265.amr.corp.intel.com (HELO xpardee-test1.amr.corp.intel.com) ([10.209.54.237])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:32:24 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] platform/x86:intel/pmc: Add support to show ltr_ignore value
Date: Mon, 24 Jun 2024 13:32:14 -0700
Message-Id: <20240624203218.2428475-6-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624203218.2428475-1-xi.pardee@linux.intel.com>
References: <20240624203218.2428475-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xi Pardee <xi.pardee@intel.com>

Add a column in ltr_show output to show if the IP has been ignored.
A mutex lock is used to protect the critical section as other processes
might try to write to the LTR ignore register at the same time.

Signed-off-by: Xi Pardee <xi.pardee@intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index cb7dd22e7406..3f271ca48164 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -623,13 +623,24 @@ static int pmc_core_ltr_show(struct seq_file *s, void *unused)
 	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
 		struct pmc *pmc;
 		const struct pmc_bit_map *map;
+		u32 ltr_ign_reg;
 
 		pmc = pmcdev->pmcs[i];
 		if (!pmc)
 			continue;
 
+		scoped_guard(mutex, &pmcdev->lock)
+			ltr_ign_reg = pmc_core_reg_read(pmc, pmc->map->ltr_ignore_offset);
+
 		map = pmc->map->ltr_show_sts;
 		for (index = 0; map[index].name; index++) {
+			bool ltr_ign_data;
+
+			if (index > pmc->map->ltr_ignore_max)
+				ltr_ign_data = false;
+			else
+				ltr_ign_data = ltr_ign_reg & BIT(index);
+
 			decoded_snoop_ltr = decoded_non_snoop_ltr = 0;
 			ltr_raw_data = pmc_core_reg_read(pmc,
 							 map[index].bit_mask);
@@ -647,10 +658,10 @@ static int pmc_core_ltr_show(struct seq_file *s, void *unused)
 				decoded_snoop_ltr = val * convert_ltr_scale(scale);
 			}
 
-			seq_printf(s, "%d\tPMC%d:%-32s\tLTR: RAW: 0x%-16x\tNon-Snoop(ns): %-16llu\tSnoop(ns): %-16llu\n",
+			seq_printf(s, "%d\tPMC%d:%-32s\tLTR: RAW: 0x%-16x\tNon-Snoop(ns): %-16llu\tSnoop(ns): %-16llu\tLTR_IGNORE: %d\n",
 				   ltr_index, i, map[index].name, ltr_raw_data,
 				   decoded_non_snoop_ltr,
-				   decoded_snoop_ltr);
+				   decoded_snoop_ltr, ltr_ign_data);
 			ltr_index++;
 		}
 	}
-- 
2.34.1


