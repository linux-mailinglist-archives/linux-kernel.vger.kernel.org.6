Return-Path: <linux-kernel+bounces-422132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 780ED9D9510
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CB66B250B3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0411BC9F6;
	Tue, 26 Nov 2024 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="jSwhb/+x"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF3E186E58
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 09:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732614705; cv=none; b=Ba/YWttyeO8RFVUpz/jjf+i4Ys+7DbgxMHDefaJB3s26EuJTrrQiaFVaN5kZ8AvXN7AiwvsU+OzkZFkGUStg90plOuIhSObAtXpmujqnD/erMZru+FgI7KninEO3xBvmEA840mk8rfkWC4151HEN4Kiiqk/Jbua/BKUr3/ZC1RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732614705; c=relaxed/simple;
	bh=QL+jsKpJlz5b4P+2bQcbr5zSIL44zoHSmizxnSBuhFo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ndLRQky3zIvy8AStDI7fzedbaaxwL8TH41F1xu4HRytmnpUf3nhD1JmoCz2QV3p0XYVbZ/btgOsw9509+xdKF189VJMhwxpJSu50DMDvecDp/7nQQrywLflW6dsKnAg/xK4IIt1LbL9CoMC6GMjI9hv9qyK99UffIcTLXGZcLtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=jSwhb/+x; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so49776975e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 01:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1732614701; x=1733219501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UO4mSSBKzizqKXO9HWAu5xtTzjjab3K6hG1bXe5LLuo=;
        b=jSwhb/+xJGkmRpcDV5yeW4ZHr7qKmu8gg0TsF6fQ/WyLEgCk+J6w4yJlOEpwGWfQvc
         Px1u0FRQRU5O+EAZKwd1NtilFiUd+G83fb3urpPmz1Sihdoro1R3QyQk9bGWgI/LFMTW
         X8rZzBLoflUoWaDYDJWGmNkEOBn9pkoZpYT3pEVLIENYrDJK2QoPoCeW6d1I8YcGs9AY
         mSE3Nr77RVmmqbGsFIGFsoBPPlrzvEP1NzCwApCg0mvIm/tY8omeBUyZziC2QEwboZaX
         /+a2mw77BlIUipmLafYNZhlRST/0+FOOHAHC5Ppzk8yvx8bsAKeaavzTkBchVTgjMmsP
         vXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732614701; x=1733219501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UO4mSSBKzizqKXO9HWAu5xtTzjjab3K6hG1bXe5LLuo=;
        b=kTOpcq6dJ7vIKDe2azb+in/671GYfCuKpqfDGVkJMTcTCMbQTOsQ7xDV3S8WA51BFE
         MScAZp2mgw+TIighzLA+ZmrqDn5V67V9mZeCGkrBegwzzg7Ap/xUsIXGsHB526UWtmc/
         khg0juQCQCBK7Vs2+3w4H+rkz+yfoPXY/LPJG6pvgri5Yc1P4Uv5SiBPyK2+fKBd3t1M
         E4len/ECQ5RnJi9kzyAVrLsPAOi5B55ZUpzb4oHI4PA7f3MffKxDGqXWOKx8T8qdIi/n
         ios/1NNwZGPlDuxH3mfFo/Ozby+s+yOP74JR+4mzikw9EM+XMfTcGBGRLpwtGbHAMDMp
         GGdw==
X-Forwarded-Encrypted: i=1; AJvYcCUk6iGTzQ9rFJ6UoPjBg4OmZhI2bnETpDufselY9JIzrHuH4Mef0hBCq0vUla8QHXSc+GmOSC4tUpeOYLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy8EAN5BmxdNO8H5YddRDqcQO1afrulNt9HmSqJQjP9HyEeIlk
	JPhy8Jby8GeRHn/haK0JAcLddCU3cLD0dAxIjlzWgrtf0oePFDEdLsjUhKsZWF4=
X-Gm-Gg: ASbGnctvh2hJSaOXTrAuClxAIsLUW4/5pfotpaltLbP3Z25qC6XuT4rvLzaSrURIPm8
	HH6bNKHH6pXbtJUJzyvr5PdTEI5K2j4cJZ87L6dWFr9aRGVgpBM4lDyNdOwZ7pIRUug+RzKOoU2
	V4ZnRIAHlrIjdrvIsuADy7tgeM8Vmxn3W3zNqr/5wr9reY1G7Bw3n9s/F9v1gOuaXQlmzxFsynD
	mavNqHdqVn85Wn1gGpYGPAz/4YejCbQIwTlfqOMoqefewTaTh8UO1SSqNVwrvrS6uSSbYTuW+yH
	oIc=
X-Google-Smtp-Source: AGHT+IGy1fknfYw17Hs9F6ZticKpVJz4vkS8NC2H5qrqchJz9nfNpZvrSiMCMB7eggn/X6U7IKtd2g==
X-Received: by 2002:a5d:64c3:0:b0:37c:cc67:8b1f with SMTP id ffacd0b85a97d-38260be3f72mr12341731f8f.48.1732614701364;
        Tue, 26 Nov 2024 01:51:41 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb271ffsm12745475f8f.53.2024.11.26.01.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 01:51:40 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: corbet@lwn.net,
	akpm@linux-foundation.org,
	thuth@redhat.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	xiongwei.song@windriver.com,
	ying.huang@intel.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	claudiu.beznea@tuxon.dev,
	geert+renesas@glider.be,
	wsa+renesas@sang-engineering.com,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [RFC PATCH] mm: page_alloc: Add kernel parameter to select maximum PCP batch scale number
Date: Tue, 26 Nov 2024 11:51:38 +0200
Message-Id: <20241126095138.1832464-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Commit 52166607ecc9 ("mm: restrict the pcp batch scale factor to avoid
too long latency") introduced default PCP (Per-CPU Pageset) batch size as
a configuration flag. The configuration flag is CONFIG_PCP_BATCH_SCALE_MAX.

The ARM64 defconfig has CONFIG_PCP_BATCH_SCALE_MAX=5. This defconfig
is used by a high range of SoCs.

The Renesas RZ/G3S SoC is a single CPU SoC, with L1$ (I-cache 32Kbytes,
D-cache 32 Kbytes), L3$ (256 Kbytes), but no L2$. It is currently used in
a configuration with 1 GiB RAM size. In this configuration, starting with
commit 52166607ecc9 ("mm: restrict the pcp batch scale factor to avoid too
long latency") the "bonnie++ -d /mnt -u root" benchmark takes ~14 minutes
while previously it took ~10 minutes. The /mnt directory is mounted on SD
card. Same behavior is reproduced on similar Renesas single core devices
(e.g., Renesas RZ/G2UL).

Add a new kernel parameter to allow systems like Renesas RZ/G3S to
continue have the same performance numbers with the default mainline
ARM64 config. With pcp_batch_scale_max=5 (the default value) the bonnie++
benchmark takes ~14 minutes while with pcp_batch_scale_max=0 it takes
~10 minutes.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 +++++
 mm/page_alloc.c                               | 26 ++++++++++++++-----
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e7bfe1bde49e..ce745ea78470 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4716,6 +4716,12 @@
 			for debug and development, but should not be
 			needed on a platform with proper driver support.
 
+	pcp_batch_scale_max=n
+			Format: <integer>
+			Range: 0,6 : number
+			Default : CONFIG_PCP_BATCH_SCALE_MAX
+			Used for setting the scale number for PCP batch scale algorithm.
+
 	pdcchassis=	[PARISC,HW] Disable/Enable PDC Chassis Status codes at
 			boot time.
 			Format: { 0 | 1 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bc55d39eb372..ef1d37cefb43 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -163,6 +163,20 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
 #define pcp_spin_unlock(ptr)						\
 	pcpu_spin_unlock(lock, ptr)
 
+static unsigned int pcp_batch_scale_max = CONFIG_PCP_BATCH_SCALE_MAX;
+#define MAX_PCP_BATCH	6
+
+static int __init setup_pcp_batch_scale_max(char *str)
+{
+	get_option(&str, (unsigned int *)&pcp_batch_scale_max);
+
+	if (pcp_batch_scale_max > MAX_PCP_BATCH)
+		pcp_batch_scale_max = MAX_PCP_BATCH;
+
+	return 1;
+}
+__setup("pcp_batch_scale_max=", setup_pcp_batch_scale_max);
+
 #ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
 DEFINE_PER_CPU(int, numa_node);
 EXPORT_PER_CPU_SYMBOL(numa_node);
@@ -2362,7 +2376,7 @@ int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
 	 * control latency.  This caps pcp->high decrement too.
 	 */
 	if (pcp->high > high_min) {
-		pcp->high = max3(pcp->count - (batch << CONFIG_PCP_BATCH_SCALE_MAX),
+		pcp->high = max3(pcp->count - (batch << pcp_batch_scale_max),
 				 pcp->high - (pcp->high >> 3), high_min);
 		if (pcp->high > high_min)
 			todo++;
@@ -2412,7 +2426,7 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 		count = pcp->count;
 		if (count) {
 			int to_drain = min(count,
-				pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX);
+				pcp->batch << pcp_batch_scale_max);
 
 			free_pcppages_bulk(zone, to_drain, pcp, 0);
 			count -= to_drain;
@@ -2540,7 +2554,7 @@ static int nr_pcp_free(struct per_cpu_pages *pcp, int batch, int high, bool free
 
 	/* Free as much as possible if batch freeing high-order pages. */
 	if (unlikely(free_high))
-		return min(pcp->count, batch << CONFIG_PCP_BATCH_SCALE_MAX);
+		return min(pcp->count, batch << pcp_batch_scale_max);
 
 	/* Check for PCP disabled or boot pageset */
 	if (unlikely(high < batch))
@@ -2572,7 +2586,7 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
 		return 0;
 
 	if (unlikely(free_high)) {
-		pcp->high = max(high - (batch << CONFIG_PCP_BATCH_SCALE_MAX),
+		pcp->high = max(high - (batch << pcp_batch_scale_max),
 				high_min);
 		return 0;
 	}
@@ -2642,7 +2656,7 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 	} else if (pcp->flags & PCPF_PREV_FREE_HIGH_ORDER) {
 		pcp->flags &= ~PCPF_PREV_FREE_HIGH_ORDER;
 	}
-	if (pcp->free_count < (batch << CONFIG_PCP_BATCH_SCALE_MAX))
+	if (pcp->free_count < (batch << pcp_batch_scale_max))
 		pcp->free_count += (1 << order);
 	high = nr_pcp_high(pcp, zone, batch, free_high);
 	if (pcp->count >= high) {
@@ -2984,7 +2998,7 @@ static int nr_pcp_alloc(struct per_cpu_pages *pcp, struct zone *zone, int order)
 		 * subsequent allocation of order-0 pages without any freeing.
 		 */
 		if (batch <= max_nr_alloc &&
-		    pcp->alloc_factor < CONFIG_PCP_BATCH_SCALE_MAX)
+		    pcp->alloc_factor < pcp_batch_scale_max)
 			pcp->alloc_factor++;
 		batch = min(batch, max_nr_alloc);
 	}
-- 
2.39.2


