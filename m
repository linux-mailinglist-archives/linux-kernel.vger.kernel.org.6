Return-Path: <linux-kernel+bounces-412824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 168A29D0F91
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B6C1F223CC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4B119884A;
	Mon, 18 Nov 2024 11:23:34 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F0615B102
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 11:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731929013; cv=none; b=INdDKnxwk34QONILDW7dR2l6lxPfKmVmRfosOhmUqUzCSf/iOYw/DZt9A7OLQO2upwn1CykTHvQI3USdVsnR6VGi2axNqs8X/twJdAxDU/Ju5q9RtNgqHZfnW0RNnjgLdWcaS2rFPJ8Sn2WxU1icYpnlA/UBKzXc4gg4BJkSC2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731929013; c=relaxed/simple;
	bh=UG44Vtrkxfa53MjULUV8ZnnSrXumVYVHo3LlASYIrzo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OdAU7Wd5zUYkteRm9bAXyDU6a2OjvMNfjMwveM4ZcaX9wDynUYVWuhX3WjKrfi53o3jrs0GlDLc78rVYMnv1Iu1Wgk/j79n58Okfg4PQIKfzZ1AUVcsFAehGO3l+I4uWYSz7V1sWsGdZaCIXcypL8+erIOPwQxwLleXIbIutMwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee4673b23a998e-13297;
	Mon, 18 Nov 2024 19:23:22 +0800 (CST)
X-RM-TRANSID:2ee4673b23a998e-13297
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee2673b239afe0-caa1b;
	Mon, 18 Nov 2024 19:23:22 +0800 (CST)
X-RM-TRANSID:2ee2673b239afe0-caa1b
From: guanjing <guanjing@cmss.chinamobile.com>
To: tj@kernel.org,
	void@manifault.com,
	joshdon@google.com,
	haoluo@google.com,
	brho@google.com
Cc: linux-kernel@vger.kernel.org,
	guanjing <guanjing@cmss.chinamobile.com>
Subject: [PATCH] sched_ext: fix application of sizeof to pointer
Date: Sun, 17 Nov 2024 07:02:58 +0800
Message-Id: <20241116230258.140098-1-guanjing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sizeof when applied to a pointer typed expression gives the size of
the pointer.

The proper fix in this particular case is to code sizeof(cpu_set_t)
instead of sizeof(cpuset).

This issue was detected with the help of Coccinelle.

Fixes: 22a920209ab6 ("sched_ext: Implement tickless support")
Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>
---
 tools/sched_ext/scx_central.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_central.c b/tools/sched_ext/scx_central.c
index 21deea320bd7..74f26423dd58 100644
--- a/tools/sched_ext/scx_central.c
+++ b/tools/sched_ext/scx_central.c
@@ -97,7 +97,7 @@ int main(int argc, char **argv)
 	SCX_BUG_ON(!cpuset, "Failed to allocate cpuset");
 	CPU_ZERO(cpuset);
 	CPU_SET(skel->rodata->central_cpu, cpuset);
-	SCX_BUG_ON(sched_setaffinity(0, sizeof(cpuset), cpuset),
+	SCX_BUG_ON(sched_setaffinity(0, sizeof(cpu_set_t), cpuset),
 		   "Failed to affinitize to central CPU %d (max %d)",
 		   skel->rodata->central_cpu, skel->rodata->nr_cpu_ids - 1);
 	CPU_FREE(cpuset);
-- 
2.33.0




