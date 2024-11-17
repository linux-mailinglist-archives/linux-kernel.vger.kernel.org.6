Return-Path: <linux-kernel+bounces-413663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EBD9D1D0E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FB1AB2291F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 01:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0E933998;
	Tue, 19 Nov 2024 01:15:26 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD76D1BC2A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 01:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731978926; cv=none; b=PYWnDSkv6My/Z1Wca3vzkgUtA9mdnlH439VjlQdbpO9qdzIl5k5Z7Hkrc29C1Yu+lssbEZdpifU5w10wbe2SECeyClX0JREL9KDnrr7MnVgTckH2aNec1DxFyK0hknswMlFABqq+Pm/xqPLhRimoTsYRzrAwnJ6YLRL/HzHYzzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731978926; c=relaxed/simple;
	bh=mqGjaAmUeltmw3E/tgvW4U6VUo4/W1Gqw6C73GWJ/xU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=usOoAVlqEYJU/zsAYFNoH4GaV5xjxseybwUlNwtO2VNBpmohseflXLJUzGnEatyA8xu8se+d6o1ZLx51g08P6UQwOoKATr/3V/njuplmuxzN4ZncgY8gV2JdOD+KZD/vE39XzuVOod/IYZINIf71hYEjXiLr32pAPzn/Jc18ETc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee2673be6a61ba-7b1d6;
	Tue, 19 Nov 2024 09:15:18 +0800 (CST)
X-RM-TRANSID:2ee2673be6a61ba-7b1d6
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea673be69a0ae-f959e;
	Tue, 19 Nov 2024 09:15:18 +0800 (CST)
X-RM-TRANSID:2eea673be69a0ae-f959e
From: guanjing <guanjing@cmss.chinamobile.com>
To: tj@kernel.org,
	void@manifault.com,
	joshdon@google.com,
	haoluo@google.com,
	brho@google.com
Cc: linux-kernel@vger.kernel.org,
	guanjing <guanjing@cmss.chinamobile.com>
Subject: [PATCH v2] sched_ext: fix application of sizeof to pointer
Date: Sun, 17 Nov 2024 09:39:20 +0800
Message-Id: <20241117013920.150829-1-guanjing@cmss.chinamobile.com>
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
index 21deea320bd7..e938156ed0a0 100644
--- a/tools/sched_ext/scx_central.c
+++ b/tools/sched_ext/scx_central.c
@@ -97,7 +97,7 @@ int main(int argc, char **argv)
 	SCX_BUG_ON(!cpuset, "Failed to allocate cpuset");
 	CPU_ZERO(cpuset);
 	CPU_SET(skel->rodata->central_cpu, cpuset);
-	SCX_BUG_ON(sched_setaffinity(0, sizeof(cpuset), cpuset),
+	SCX_BUG_ON(sched_setaffinity(0, sizeof(*cpuset), cpuset),
 		   "Failed to affinitize to central CPU %d (max %d)",
 		   skel->rodata->central_cpu, skel->rodata->nr_cpu_ids - 1);
 	CPU_FREE(cpuset);
-- 
2.33.0




