Return-Path: <linux-kernel+bounces-293402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DD9957EE4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A333281B20
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 07:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA03916BE23;
	Tue, 20 Aug 2024 07:02:28 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09D318E367;
	Tue, 20 Aug 2024 07:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137348; cv=none; b=A2jX7RmhaBKvmsTnohbwQ4W21xOg+raqB+3395bhQOmE+ltUpj9wp0j3Erpl8hRR7wKJiyLSoZJyntzKcUwTyQ66kklqyrL3YfkEJLZHJis9bPt5hUcz9Ix6wEBzPmY3gv498eEa/TGKuULBa413bX7ia9unJG2LyhsLf3R/5kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137348; c=relaxed/simple;
	bh=GC0e8f/SxLOKOHvdE3yJ93M1+xzh+1xcKQ7XKfCjAtI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=j27pY79RJOS/+rllD3QgZBfus+EhqZJTzOjXcZRg4fZ59LlbAW4n6PlN342JkUuwxLV5UW/4I2tGj6NpBqWiKzYr+kuG2FweuwdLj+wq+jcN5CJ7ed9C/teXjuOsFhOIiBT3ywGa4regQ7kYeJCdUWDa+sJK3l3bWBKQmI1Qz3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee666c43f762fb-38bb6;
	Tue, 20 Aug 2024 15:02:15 +0800 (CST)
X-RM-TRANSID:2ee666c43f762fb-38bb6
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[223.108.79.99])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea66c43f76dab-fc091;
	Tue, 20 Aug 2024 15:02:14 +0800 (CST)
X-RM-TRANSID:2eea66c43f76dab-fc091
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: suzuki.poulose@arm.com
Cc: mike.leach@linaro.org,
	james.clark@linaro.org,
	mark.rutland@arm.com,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] tools/perf:Remove unnecessary assignment
Date: Tue, 20 Aug 2024 00:02:12 -0700
Message-Id: <20240820070212.4572-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In the function cs_etm_decoder__init_def_logger_printing(),
the correct logic should be to return within the function
when ret is not equal to 0.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index e917985bbbe6..dc80576180d5 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -238,6 +238,7 @@ cs_etm_decoder__init_def_logger_printing(struct cs_etm_decoder_params *d_params,
 					      cs_etm_decoder__print_str_cb);
 	if (ret != 0)
 		ret = -1;
+		return -1;
 
 	return 0;
 }
-- 
2.17.1




