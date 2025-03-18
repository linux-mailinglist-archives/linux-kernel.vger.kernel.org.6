Return-Path: <linux-kernel+bounces-565630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A273DA66C4E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 553BE3B7A27
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7649A1EB5D3;
	Tue, 18 Mar 2025 07:43:59 +0000 (UTC)
Received: from mx9.didiglobal.com (mx9.didiglobal.com [111.202.70.124])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 5474F1A7045
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283839; cv=none; b=a/JySwwwkKlsuCK2lpGNWrqkFnGNhlvGJe8bhH4hJTncTsEkeXZiclEd9rVqENgjRZX4tBlAObc5dndpxU9ngazO722CLKsFzh/Nw+4OK7kp09P4Mc38Mwhj1m1zunqsKcYr2i51RYNc02KY9cSCU9gXIpaS5P24k8LiwXLxcnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283839; c=relaxed/simple;
	bh=pzO6IBpK7lGc763ET9hR6TFiyK2dBPi9gU5KxOHieZY=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P0526jZN+gNTlFuOWGgzDt/XxKOI0rvd/FQSb3Jtssgkh+nU413obTkM7ZHh6n6qX4LkDvFPd5vWaORdakZB8PBF7uCr440E+QMOhPvkDwJUxtMrQnMad45JPkjp2k4kvoDHHNiYWDq9Kde2Ve1IxBjLnSSgGZO71oKO1QQ3r5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; arc=none smtp.client-ip=111.202.70.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.65.20])
	by mx9.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id 4336518049A9F8;
	Tue, 18 Mar 2025 15:30:50 +0800 (CST)
Received: from BJ02-ACTMBX-07.didichuxing.com (10.79.65.14) by
 BJ02-ACTMBX-02.didichuxing.com (10.79.65.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Mar 2025 15:31:08 +0800
Received: from pilot-ThinkCentre-M930t-N000 (10.79.71.101) by
 BJ02-ACTMBX-07.didichuxing.com (10.79.65.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 18 Mar 2025 15:31:08 +0800
Date: Tue, 18 Mar 2025 15:31:02 +0800
X-MD-Sfrom: jingsusu@didiglobal.com
X-MD-SrcIP: 10.79.65.20
From: Jing Su <jingsusu@didiglobal.com>
To: <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <jingsusu@didiglobal.com>
Subject: [PATCH] dql: Fix dql->limit value when reset.
Message-ID: <Z9khNixRKEVRG4Yj@pilot-ThinkCentre-M930t-N000>
Mail-Followup-To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	jingsusu@didiglobal.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: BJ02-PUBMBX-01.didichuxing.com (10.79.65.22) To
 BJ02-ACTMBX-07.didichuxing.com (10.79.65.14)

Executing dql_reset after setting a non-zero value for limit_min can
lead to an unreasonable situation where dql->limit is less than
dql->limit_min.

For instance, after setting
/sys/class/net/eth*/queues/tx-0/byte_queue_limits/limit_min,
an ifconfig down/up operation might cause the ethernet driver to call
netdev_tx_reset_queue, which in turn invokes dql_reset.

In this case, dql->limit is reset to 0 while dql->limit_min remains
non-zero value, which is unexpected. The limit should always be
greater than or equal to limit_min.

Signed-off-by: Jing Su <jingsusu@didiglobal.com>
---
 lib/dynamic_queue_limits.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_queue_limits.c b/lib/dynamic_queue_limits.c
index c1b7638a594a..f97a752e900a 100644
--- a/lib/dynamic_queue_limits.c
+++ b/lib/dynamic_queue_limits.c
@@ -190,7 +190,7 @@ EXPORT_SYMBOL(dql_completed);
 void dql_reset(struct dql *dql)
 {
 	/* Reset all dynamic values */
-	dql->limit = 0;
+	dql->limit = dql->min_limit;
 	dql->num_queued = 0;
 	dql->num_completed = 0;
 	dql->last_obj_cnt = 0;
-- 
2.34.1


