Return-Path: <linux-kernel+bounces-569509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A781BA6A3F4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3D48189D5E5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B64822423E;
	Thu, 20 Mar 2025 10:44:33 +0000 (UTC)
Received: from mx9.didiglobal.com (mx9.didiglobal.com [111.202.70.124])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 24494222560
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742467472; cv=none; b=mn+di7zviIlleWeB16W+5p7PyjlReAZ2OrmTDXsvIuyLfpKbxdv2LX17QXjwW1zjSAF4JHv1LtVeq/E6C5a6uehMfT4rvjq3CmH76OD1PUa9EhGwmcRDYapP6QWx8lIWCuqoh2WvgvjWJ1utCVRDOGwDFn61vQy6WddiOU3pslc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742467472; c=relaxed/simple;
	bh=6UpC/AlAbCMADa5Z6W2003FMP+6UZTc5/GXucY3oe60=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MOkYthS0GK1hTSUgPN4Y1qxR0aPsGqF5AS0aZ6wIueEsaLuHFSa6zCs5rmW06/ACYlUzVvKlIB7cZop2F1cB3unBAch7Wxh/UnGzyhsTrHcQebO0aWVog5ugL7ydTrle8b4EQBjmVV5RxlyZyZFF4/JRipXp5dKYDL1eOtm5GsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; arc=none smtp.client-ip=111.202.70.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.65.20])
	by mx9.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id 45D951873ABDCF;
	Thu, 20 Mar 2025 18:43:43 +0800 (CST)
Received: from BJ03-ACTMBX-07.didichuxing.com (10.79.71.34) by
 BJ02-ACTMBX-02.didichuxing.com (10.79.65.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Mar 2025 18:44:02 +0800
Received: from OneApple (10.79.64.102) by BJ03-ACTMBX-07.didichuxing.com
 (10.79.71.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.11; Thu, 20 Mar
 2025 18:44:01 +0800
Date: Thu, 20 Mar 2025 18:44:00 +0800
X-MD-Sfrom: chentaotao@didiglobal.com
X-MD-SrcIP: 10.79.65.20
From: Taotao Chen <chentaotao@didiglobal.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/damon/core: simplify control flow in damon_register_ops()
Message-ID: <Z9vxcPCw8tDsjKw1@OneApple>
Mail-Followup-To: sj@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: BJ01-PUBMBX-01.didichuxing.com (10.79.64.22) To
 BJ03-ACTMBX-07.didichuxing.com (10.79.71.34)

The function logic is not complex, so using goto is unnecessary.
Replace it with a straightforward if-else to simplify control flow
and improve readability.

Signed-off-by: Taotao Chen <chentaotao@didiglobal.com>
---
 mm/damon/core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 384935ef4e65..a3bdc09d38fe 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -76,14 +76,13 @@ int damon_register_ops(struct damon_operations *ops)
 
 	if (ops->id >= NR_DAMON_OPS)
 		return -EINVAL;
+
 	mutex_lock(&damon_ops_lock);
 	/* Fail for already registered ops */
-	if (__damon_is_registered_ops(ops->id)) {
+	if (__damon_is_registered_ops(ops->id))
 		err = -EINVAL;
-		goto out;
-	}
-	damon_registered_ops[ops->id] = *ops;
-out:
+	else
+		damon_registered_ops[ops->id] = *ops;
 	mutex_unlock(&damon_ops_lock);
 	return err;
 }
-- 
2.34.1


