Return-Path: <linux-kernel+bounces-258859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B415C938D6B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60CA1C212D0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB65168498;
	Mon, 22 Jul 2024 10:24:32 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36CE14B95E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721643872; cv=none; b=vBzCH3lYvE3Kipj+bNtgvtrRcG5NJSO2RUBrhN1fhgMtYDzaze2aXNGFGOlZMlYzSpkyM0Nep0ORrc8dgCI/4L/iXXUlb4JsoxuXKVxK//rGwpDk2Ua9qKuhVkwu+Le8LPBDd9ossToiVPBe84IZR9/klpW9czUPtvDCAN5fTmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721643872; c=relaxed/simple;
	bh=9GAsu+9PcWwoJuLgl1ru+4eJDTUpW15UwET69p/Xs0Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=swd1DOCU9rzOiTf/HCwUwYfhi22EtpYuMtJv45zjhXxOMsal3ahv13nn5a5oFWOWLGzF9tgePV8sZnhHV5cYgPyUhvaYFaPTB7zx0vIC/7u3dR8QTJ5hALT9AYwqQfh3RgWFvBKGDaHDYuSilLIKrFndRim36g7MuV4a1PTIp/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 46MANwUb069811;
	Mon, 22 Jul 2024 18:23:58 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4WSGSv3ZhQz2LFXjq;
	Mon, 22 Jul 2024 18:18:23 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 22 Jul 2024 18:23:55 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Andrew Morton <akpm@linux-foundation.org>, Yu Zhao <yuzhao@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang
	<huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [RFC PATCH] mm: keep LRU order by move unisolated folios to tail
Date: Mon, 22 Jul 2024 18:23:38 +0800
Message-ID: <20240722102338.2567810-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 46MANwUb069811

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Unlike legacy LRU management, MGLRU will switch to other zones or types
when current lrugen[gen][type][zone] scanning failed, which means skipped
folios could become available in next scan. This commit would like to
suggest to keep the LRU's order by moving unisolated folios to the tail
of LRU during the first 2 round scan to avoid potential livelock on the
unisolated ones.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/vmscan.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2e34de9cd0d4..cd1f38bb1d45 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4397,7 +4397,10 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 		}
 
 		if (skipped_zone) {
-			list_splice(&moved, head);
+			if (sc->priority > DEF_PRIORITY - 2)
+				list_splice_tail(&moved, head);
+			else
+				list_splice(&moved, head);
 			__count_zid_vm_events(PGSCAN_SKIP, zone, skipped_zone);
 			skipped += skipped_zone;
 		}
-- 
2.25.1


