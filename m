Return-Path: <linux-kernel+bounces-416573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AF69D4701
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 05:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F47A283223
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 04:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7221A1C75EC;
	Thu, 21 Nov 2024 04:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="HHTMbeO8"
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84F3137930
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 04:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732165042; cv=none; b=bYFgOvtsRaHfpIDRCHfDSOiYJm5rrBJCscex99u4QbX+a3LZYXlfXxGrY8AIuO2rqQaPyTuNRlpQe6I9fy76FuMvn+zjCmr8iarFltY4uizvRy3yAk+GZOWKLX0kNcNnTGJeBQpeAkGg1RwGIr82UQYyyOmYT3VgcekKsK4EAhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732165042; c=relaxed/simple;
	bh=ztU4UKuOiinqRIzKTE6P8obzPmKKFoc3AYyl5EH9UjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QpkBndoBcdXban7qsksWqWrN0znS6avoa9gnTF8r/PxawcClGNAucjVdkOzmNtYWNEqwLGLwG+Qexxp4FWnQhZm04pRxpIxOnLRFDNvnnF0v3FJPKux4a9UPh3n3bWiGlXE/8mrMKcHBKLeQP+Cg3RMxZXCDVbm7EGssMwEZjhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=HHTMbeO8; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1732165040; x=1763701040;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ztU4UKuOiinqRIzKTE6P8obzPmKKFoc3AYyl5EH9UjA=;
  b=HHTMbeO85hbCMbpg2wU+T2J4G0X3Crn5J7jft10p4XUSN9KtkGLLWZvv
   NIxlbp0yRYzGP7Hko+U497tOCPlk1F+sI5w89Ufoi5vdqPTCrg9HctuEQ
   xRVj8JRD3wMNCnx7UsAWGsVoZjnuEqr5vIX3cB4Kp5nGgt1gpHxtV9pyy
   CdBLDp0Pug1yw+RE5nEplfZjVR+eeSiq5effh6B6mL0pSqnJrClv8kl6w
   L3f8UFz0as3B7npvjyDWiQsJcvswVo7OhdUD0tRL0KM9IiUti5Hl5hpRH
   ma86ry06wWfzxliNITEVK+J2h+WTjTC/2700YDtmnBpIzZdKn/vDAXrmU
   g==;
X-CSE-ConnectionGUID: RGtPzBZXQH2bcM6E3rJ8RQ==
X-CSE-MsgGUID: XamNen8oTT++jp87uz+/8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="181354900"
X-IronPort-AV: E=Sophos;i="6.12,171,1728918000"; 
   d="scan'208";a="181354900"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 13:56:07 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6CE5CC2264
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 13:56:05 +0900 (JST)
Received: from yto-om2.fujitsu.com (yto-om2.o.css.fujitsu.com [10.128.89.163])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 03990D7866
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 13:56:05 +0900 (JST)
Received: from sm-x86-mem01.ssoft.mng.com (sm-x86-stp01.soft.fujitsu.com [10.124.178.20])
	by yto-om2.fujitsu.com (Postfix) with ESMTP id B5A864005E5D5;
	Thu, 21 Nov 2024 13:56:04 +0900 (JST)
From: Tomohiro Misono <misono.tomohiro@fujitsu.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: jiaqiyan@google.com,
	misono.tomohiro@fujitsu.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm: memory-failure: add soft-offline stat in mf_stats
Date: Thu, 21 Nov 2024 04:55:04 +0000
Message-Id: <20241121045504.2233544-1-misono.tomohiro@fujitsu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 44b8f8bf2438 ("mm: memory-failure: add memory failure stats
to sysfs") introduces per NUMA memory error stats which show
breakdown of HardwareCorrupted of /proc/meminfo in
/sys/devices/system/node/nodeX/memory_failure.

However, HardwareCorrupted also counts soft-offline pages. So, add
soft-offline stats in mf_stats too to represent more accurate status.

This updates total count as:
  total = recovered + ignored + failed + delayed + soft_offline

Test example:
1) # grep HardwareCorrupted /proc/meminfo
     HardwareCorrupted:     0 kB
2) soft-offline 1 page by madvise(MADV_SOFT_OFFLINE)
3) # grep HardwareCorrupted /proc/meminfo
     HardwareCorrupted:     4 kB
   # grep -r "" /sys/devices/system/node/node0/memory_failure
   /sys/devices/system/node/node0/memory_failure/total:1
   /sys/devices/system/node/node0/memory_failure/soft_offline:1
   /sys/devices/system/node/node0/memory_failure/recovered:0
   /sys/devices/system/node/node0/memory_failure/ignored:0
   /sys/devices/system/node/node0/memory_failure/failed:0
   /sys/devices/system/node/node0/memory_failure/delayed:0

Signed-off-by: Tomohiro Misono <misono.tomohiro@fujitsu.com>
---
Hello

This is RFC because I'm not sure adding SOFT_OFFLINE in enum
mf_result is a right approach. Also, maybe is it better to move
update_per_node_mf_stats() into num_poisoned_pages_inc()?

I omitted some cleanups and sysfs doc update in this version to
highlight changes. I'd appreciate any suggestions.

Regards,
Tomohiro Misono

 include/linux/mm.h     | 2 ++
 include/linux/mmzone.h | 4 +++-
 mm/memory-failure.c    | 9 +++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5d6cd523c7c0..7f93f6883760 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3991,6 +3991,8 @@ enum mf_result {
 	MF_FAILED,	/* Error: handling failed */
 	MF_DELAYED,	/* Will be handled later */
 	MF_RECOVERED,	/* Successfully recovered */
+
+	MF_RES_SOFT_OFFLINE, /* Soft-offline */
 };
 
 enum mf_action_page_type {
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b36124145a16..6a030610cba3 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1282,13 +1282,15 @@ struct memory_failure_stats {
 	/*
 	 * Recovery results of poisoned raw pages handled by memory_failure,
 	 * in sync with mf_result.
-	 * total = ignored + failed + delayed + recovered.
+	 * total = ignored + failed + delayed + recovered + soft_offline.
 	 * total * PAGE_SIZE * #nodes = /proc/meminfo/HardwareCorrupted.
 	 */
 	unsigned long ignored;
 	unsigned long failed;
 	unsigned long delayed;
 	unsigned long recovered;
+
+	unsigned long soft_offline;
 };
 #endif
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a7b8ccd29b6f..02f845a222cc 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -109,6 +109,7 @@ MF_ATTR_RO(ignored);
 MF_ATTR_RO(failed);
 MF_ATTR_RO(delayed);
 MF_ATTR_RO(recovered);
+MF_ATTR_RO(soft_offline);
 
 static struct attribute *memory_failure_attr[] = {
 	&dev_attr_total.attr,
@@ -116,6 +117,7 @@ static struct attribute *memory_failure_attr[] = {
 	&dev_attr_failed.attr,
 	&dev_attr_delayed.attr,
 	&dev_attr_recovered.attr,
+	&dev_attr_soft_offline.attr,
 	NULL,
 };
 
@@ -185,6 +187,9 @@ static int __page_handle_poison(struct page *page)
 	return ret;
 }
 
+static void update_per_node_mf_stats(unsigned long pfn,
+		enum mf_result result);
+
 static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, bool release)
 {
 	if (hugepage_or_freepage) {
@@ -208,6 +213,7 @@ static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, boo
 		put_page(page);
 	page_ref_inc(page);
 	num_poisoned_pages_inc(page_to_pfn(page));
+	update_per_node_mf_stats(page_to_pfn(page), MF_RES_SOFT_OFFLINE);
 
 	return true;
 }
@@ -1314,6 +1320,9 @@ static void update_per_node_mf_stats(unsigned long pfn,
 	case MF_RECOVERED:
 		++mf_stats->recovered;
 		break;
+	case MF_RES_SOFT_OFFLINE:
+		++mf_stats->soft_offline;
+		break;
 	default:
 		WARN_ONCE(1, "Memory failure: mf_result=%d is not properly handled", result);
 		break;
-- 
2.34.1


