Return-Path: <linux-kernel+bounces-226555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AF491404A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 04:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66FBDB22401
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 02:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187B146B5;
	Mon, 24 Jun 2024 02:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TQ4kdwic"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9290A33F7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719194566; cv=none; b=hPLKKKG/IwQ2+88/shcPNSWz80+C2DmOzPXazaYFU+cM1e2re+FY9VCkHtuK2eReIuE6AgpZMMB4wzjgz2YR7NcDBOkV3Z9+sHuU8A6FpE5Ecx8rJU94yo/TS/yH4MMN7yUPl+yJ/Azf7FeedD+6YTPA2RIOmWX2kn+figLWGcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719194566; c=relaxed/simple;
	bh=tNnqahw2MNRxLzc0/22pn+P6saQU3Bz7sIub+/GCeTo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mxkfSysxgAZSivRDfNwa2Ny90HPSZfh5GtkyYQWWUXxghA5e2RZ6dSXYOubvVqwiAZ1fCiQJtdJbWczmhefu8LPZK51mmvNnvN07EQdZczqP5Se86uBOPaaAkd9WLB5gue9IJlsKLQREaN5DOSdgnL5Xw/fklkM8rq4+8fDZrqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TQ4kdwic; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719194555; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=kEmEdnA6MmtMya8ZtsQJGZHyWERAexbeV4W5aGUBu08=;
	b=TQ4kdwicIr1gpo6cqWNhIzOKTekG8dwCuDDQAmYbCMm7HCCOTfp7LYcAX5GrmF7v6vt3c4JArLeP1OHEtU8jBK2aYuwEppORNd6Mg/trkfHmIl39HuiRPGd3QG0GYhcINZD0oLTdFYv093e3yyVYY6P+ujGKdxnsU83G5Ytf6C0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W90odGI_1719194229;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W90odGI_1719194229)
          by smtp.aliyun-inc.com;
          Mon, 24 Jun 2024 09:57:18 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: harry.wentland@amd.com
Cc: sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/amd/display: use swap() in is_config_schedulable()
Date: Mon, 24 Jun 2024 09:57:07 +0800
Message-Id: <20240624015707.121287-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use existing swap() function rather than duplicating its implementation.

./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c:1171:103-104: WARNING opportunity for swap().
./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c:1231:99-100: WARNING opportunity for swap().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9400
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index 7272a04b9d1d..926d45496e79 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -1158,7 +1158,6 @@ static bool is_config_schedulable(
 	schedulable = true;
 
 	/* sort disallow times from greatest to least */
-	unsigned int temp;
 	for (i = 0; i < s->pmo_dcn4.num_timing_groups; i++) {
 		bool swapped = false;
 
@@ -1167,9 +1166,8 @@ static bool is_config_schedulable(
 			double jp1_disallow_us = s->pmo_dcn4.group_common_fams2_meta[s->pmo_dcn4.sorted_group_gtl_disallow_index[j + 1]].disallow_time_us;
 			if (j_disallow_us < jp1_disallow_us) {
 				/* swap as A < B */
-				temp = s->pmo_dcn4.sorted_group_gtl_disallow_index[j];
-				s->pmo_dcn4.sorted_group_gtl_disallow_index[j] = s->pmo_dcn4.sorted_group_gtl_disallow_index[j + 1];
-				s->pmo_dcn4.sorted_group_gtl_disallow_index[j + 1] = temp;
+				swap(s->pmo_dcn4.sorted_group_gtl_disallow_index[j],
+				     s->pmo_dcn4.sorted_group_gtl_disallow_index[j+1]);
 				swapped = true;
 			}
 		}
@@ -1227,9 +1225,8 @@ static bool is_config_schedulable(
 			double jp1_period_us = s->pmo_dcn4.group_common_fams2_meta[s->pmo_dcn4.sorted_group_gtl_period_index[j + 1]].period_us;
 			if (j_period_us < jp1_period_us) {
 				/* swap as A < B */
-				temp = s->pmo_dcn4.sorted_group_gtl_period_index[j];
-				s->pmo_dcn4.sorted_group_gtl_period_index[j] = s->pmo_dcn4.sorted_group_gtl_period_index[j + 1];
-				s->pmo_dcn4.sorted_group_gtl_period_index[j + 1] = temp;
+				swap(s->pmo_dcn4.sorted_group_gtl_period_index[j],
+				     s->pmo_dcn4.sorted_group_gtl_period_index[j+1]);
 				swapped = true;
 			}
 		}
-- 
2.20.1.7.g153144c


