Return-Path: <linux-kernel+bounces-405411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B1C9C5100
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A18D1F21BB4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8342101A4;
	Tue, 12 Nov 2024 08:39:42 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425E920EA33
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400782; cv=none; b=VyprxR0Eb9z3fKppdEz3Ks/HNBh2QZpp+DvtAFnpSBSAUuQRBy3tazpOz3gX7ukr+4BPx/chFoRsEtykurO7l6ulaa/H0H3x+jC992c6BlpTGAsqC5FDGbNDQ/UobCQejo/TRnjlEmLvxjql6cU0zXOaQX4n97xdIc8YNqIAC0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400782; c=relaxed/simple;
	bh=8a7IghDD2F19zEoED7hhdIjA/SwpOf9+n+JnpHyC9aM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=taxgOMPjf9WIS0GmCVbDDPW19wvyLqR6LtZizwKLtePExZwKV/xeIHiPd3nf6lAucDOx+eifnPFZ8MvVzFN9L89g9opw2i1l1FoQte9CPWcQ87RLoUQDC80I6PjJdsE1IqpXmc7/DyL0lfmvtEUiGansEsBD/8mYYcYLPkQlqRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26733144420d-44227;
	Tue, 12 Nov 2024 16:39:35 +0800 (CST)
X-RM-TRANSID:2ee26733144420d-44227
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee467331446a9d-37f56;
	Tue, 12 Nov 2024 16:39:35 +0800 (CST)
X-RM-TRANSID:2ee467331446a9d-37f56
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com
Cc: linux-kernel@vger.kernel.org,
	edumazet@google.com,
	sfr@canb.auug.org.au,
	Luo Yifan <luoyifan@cmss.chinamobile.com>
Subject: [PATCH] ynl: samples: Fix the wrong format specifier
Date: Tue, 12 Nov 2024 16:39:21 +0800
Message-Id: <20241112083921.283923-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make a minor change to eliminate a static checker warning. The type
of s->ifc is unsigned int, so the correct format specifier should be
%u instead of %d.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 tools/net/ynl/samples/page-pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/samples/page-pool.c b/tools/net/ynl/samples/page-pool.c
index 332f281ee..e5d521320 100644
--- a/tools/net/ynl/samples/page-pool.c
+++ b/tools/net/ynl/samples/page-pool.c
@@ -118,7 +118,7 @@ int main(int argc, char **argv)
 			name = if_indextoname(s->ifc, ifname);
 			if (name)
 				printf("%8s", name);
-			printf("[%d]\t", s->ifc);
+			printf("[%u]\t", s->ifc);
 		}
 
 		printf("page pools: %u (zombies: %u)\n",
-- 
2.27.0




