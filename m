Return-Path: <linux-kernel+bounces-413741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9591C9D1E1C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 03:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A280B22C23
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC00149C7B;
	Tue, 19 Nov 2024 02:22:00 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C4E145B39
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 02:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731982919; cv=none; b=gqa8ss1DnYT2kpnuvPVjP3A9ZpK3a6JHQQAzVxfL8kpn005t/cFKLDvXGhde93+0hmU5cjQXTp49NGhJqZ3g26kYKiZUdeB3ff/FZEIt4ShQLUo6rkyJEYHLatkYT5QpemdM9PSUIi8pxcXt1IXtDssLkJ8u2x6CZii6JPOtPm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731982919; c=relaxed/simple;
	bh=V76GVjOU2TfSlitP+o02rRpiOdtOHmZPGkHdn4JVyLE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FoWI5Ju1TH9Hm9j/N03TGodHAEkrwQOYO99PT+jI/xI21VmWyXvGDNe9ibTTsmH+OftKIRZ0Vq4f+V1A/9MaTa/932YcajLhI99AbdWk8fWeUTcyCwI5O6zllN4TZtcVSo76cgEcfs59Vad0gh/ha5nd9fJVkB8Dp+VpMor96FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee8673bf6412ce-81319;
	Tue, 19 Nov 2024 10:21:53 +0800 (CST)
X-RM-TRANSID:2ee8673bf6412ce-81319
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee5673bf6379ee-fe980;
	Tue, 19 Nov 2024 10:21:53 +0800 (CST)
X-RM-TRANSID:2ee5673bf6379ee-fe980
From: guanjing <guanjing@cmss.chinamobile.com>
To: tj@kernel.org,
	void@manifault.com,
	joshdon@google.com,
	haoluo@google.com,
	brho@google.com
Cc: linux-kernel@vger.kernel.org,
	guanjing <guanjing@cmss.chinamobile.com>
Subject: [PATCH v3] sched_ext: fix application of sizeof to pointer
Date: Sun, 17 Nov 2024 10:51:29 +0800
Message-Id: <20241117025129.159014-1-guanjing@cmss.chinamobile.com>
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

The proper fix in this particular case is to code sizeof(*cpuset)
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




