Return-Path: <linux-kernel+bounces-403836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B139C3B66
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E466B1F22FE3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D391662FA;
	Mon, 11 Nov 2024 09:52:21 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1A912C54B;
	Mon, 11 Nov 2024 09:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731318740; cv=none; b=keSaIQ6HesZji34wiHMVZ47Q6V98ij4LbLXwilJEpkl2WNVu9jrcsGzhcboIn38Mi5nUjKTbm6EKciVUln9ulNlqYxA6QlwO0bt+qThmIaqvbkqMPu+iEAyDChTafXfuVrdwOLTeb1KqkOEEGP1bt/bBvO7l7Wk7K6+ZDwLdAGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731318740; c=relaxed/simple;
	bh=ERW2GR67Tq0nHzVPBfvjpP86YoDDBi95JY5vyDsazK0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gkE38IcfcDmUm86moz0qtUSkNnQrimOwuigckdkkuwHJIZh9+TIqiXiTVoZtLUVXy/AVi1ebrJQpmJGTjwKo32VSS2Y/GTRJhXbr8AYvtP7//TPXYT4JpUdxGpb+EGgraLtmtpkIfFcW+MMKVa890sU51r2qhMn7zug1bEfWVs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76731d3cb769-05786;
	Mon, 11 Nov 2024 17:52:11 +0800 (CST)
X-RM-TRANSID:2ee76731d3cb769-05786
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26731d3ca1e3-25876;
	Mon, 11 Nov 2024 17:52:11 +0800 (CST)
X-RM-TRANSID:2ee26731d3ca1e3-25876
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luo Yifan <luoyifan@cmss.chinamobile.com>
Subject: [PATCH] perf timechart: Remove redundant variable assignment
Date: Mon, 11 Nov 2024 17:52:09 +0800
Message-Id: <20241111095209.276332-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch makes a minor change that removes a redundant variable
assignment. The assignment before the for loop is duplicated by the
initialization within the loop header.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 tools/perf/builtin-timechart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 218c8b44d..8388e0d81 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -1158,7 +1158,6 @@ static void draw_io_bars(struct timechart *tchart)
 			}
 
 			svg_box(Y, c->start_time, c->end_time, "process3");
-			sample = c->io_samples;
 			for (sample = c->io_samples; sample; sample = sample->next) {
 				double h = (double)sample->bytes / c->max_bytes;
 
-- 
2.27.0




