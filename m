Return-Path: <linux-kernel+bounces-219446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C8790D286
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A37284B41
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374B61AC771;
	Tue, 18 Jun 2024 13:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ls5WQkd0"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E1A1AC77C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716704; cv=none; b=mPOh/sOrzP7Ck7iEjI3ZBTzKXeteSS4RZNLE1t8XGFR4KrXXX+nvM2sF2wwg+XAquVNaIrYEkTqGuU7l031jzdwBmLP786bQMHx7eS9yqHEGqWLObtWZU3XlakHkWWH2aKbwU4LPRCUMhVAxji70UyAV0D0J8OPAhnY7FhebKAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716704; c=relaxed/simple;
	bh=xdNJyy7AbGdQ1i50lrsLKpWuwkwIPlV0VSoeVxgrHnY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nPXAXW1i0tiEuJ6v/o15ieYBfqNEePsXQYJUMV9H76qQfLUdhrX04ALJW9I3Vj1tG/rrz80X/d9PJ921BIsmxYY13D0+ox2eQ9EAWS8IBMAQPkRjpT/E2Rp5uw/eaqjexiUZeI/4yO4VsjZ6S23jdiUIlS+UbFepoR7Uc28kuFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ls5WQkd0; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: davem@davemloft.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718716699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kOHzNpRqSeMMg3Mv1dLmq/tYAO6AeuY9nP4v5FPhv0M=;
	b=Ls5WQkd0ds60je0Q4pHsltFc+6tFgkyi7RtkkSvypiWlOdhmtjQnd1c/5p4KlphUpnI7QB
	YUonG9gnx3uv3LYukSUMkIwXnyMocg4EoK04Swx45z+jJNE9E5OvZ5Npd0kvjJuhYplMTL
	3DLtJ6KaLt9V699peCFCtzG5dvMIqDM=
X-Envelope-To: edumazet@google.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: yajun.deng@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH net-next] net: core: Remove the dup_errno parameter in dev_prep_valid_name()
Date: Tue, 18 Jun 2024 21:17:43 +0800
Message-Id: <20240618131743.2690-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

netdev_name_in_use() return -EEXIST makes more sense if it's not NULL.
But dev_alloc_name() should keep the -ENFILE errno.

Remove the dup_errno parameter in dev_prep_valid_name() and add a
conditional operator to dev_alloc_name(), replace -EEXIST with
-ENFILE.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 net/core/dev.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index c361a7b69da8..29e4c786cb8a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1151,8 +1151,7 @@ static int __dev_alloc_name(struct net *net, const char *name, char *res)
 
 /* Returns negative errno or allocated unit id (see __dev_alloc_name()) */
 static int dev_prep_valid_name(struct net *net, struct net_device *dev,
-			       const char *want_name, char *out_name,
-			       int dup_errno)
+			       const char *want_name, char *out_name)
 {
 	if (!dev_valid_name(want_name))
 		return -EINVAL;
@@ -1161,7 +1160,7 @@ static int dev_prep_valid_name(struct net *net, struct net_device *dev,
 		return __dev_alloc_name(net, want_name, out_name);
 
 	if (netdev_name_in_use(net, want_name))
-		return -dup_errno;
+		return -EEXIST;
 	if (out_name != want_name)
 		strscpy(out_name, want_name, IFNAMSIZ);
 	return 0;
@@ -1183,7 +1182,10 @@ static int dev_prep_valid_name(struct net *net, struct net_device *dev,
 
 int dev_alloc_name(struct net_device *dev, const char *name)
 {
-	return dev_prep_valid_name(dev_net(dev), dev, name, dev->name, ENFILE);
+	int ret;
+
+	ret = dev_prep_valid_name(dev_net(dev), dev, name, dev->name);
+	return ret == -EEXIST ? -ENFILE : ret;
 }
 EXPORT_SYMBOL(dev_alloc_name);
 
@@ -1192,7 +1194,7 @@ static int dev_get_valid_name(struct net *net, struct net_device *dev,
 {
 	int ret;
 
-	ret = dev_prep_valid_name(net, dev, name, dev->name, EEXIST);
+	ret = dev_prep_valid_name(net, dev, name, dev->name);
 	return ret < 0 ? ret : 0;
 }
 
@@ -11395,7 +11397,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 		/* We get here if we can't use the current device name */
 		if (!pat)
 			goto out;
-		err = dev_prep_valid_name(net, dev, pat, new_name, EEXIST);
+		err = dev_prep_valid_name(net, dev, pat, new_name);
 		if (err < 0)
 			goto out;
 	}
-- 
2.25.1


