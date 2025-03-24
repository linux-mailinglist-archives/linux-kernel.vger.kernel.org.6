Return-Path: <linux-kernel+bounces-573415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A996AA6D6E9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 10:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3562116D97A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F63A25D54D;
	Mon, 24 Mar 2025 09:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uLTNeC3D"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B25B197A68
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 09:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742807294; cv=none; b=BT/uk74WEz5D9jvAu2tVQwXfmErr513X+z8buNtm7YGm3U/KdF8ZQyl4cKdQYxE/M1xKWQL7Aib27QQuO6UxS8R3A9IaYAkZoo9HSp/Vhs79rS6vtjzF8IOPmngFn1Mud8CSqQludOPFXUaFUW3N1v9CoiU0mnMwnAdP0LiLTDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742807294; c=relaxed/simple;
	bh=9c0qnNBwL4W511xnM7lQi+ej4Ln4wLS4+aPk+T0Tkpg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tYXFEW/UA0urYCAoMiIUE1mxz/duyQm3EeS/CLVjagcKAYe8IaMtgBJyhVDQwh7JS4p0mOow2EoOTRrBCaFIwfH6oH7xpXjdhMhXrc+zK1T6L7vm969UnqSMwSNiTK3fp6OhaznaVvKxNu79QsP00MJ/RJ1HwHtbTi13nd8f1Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uLTNeC3D; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742807290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ju8YhxAeIWVks58bb5bS15Y91bhn7jS/clG4jnFtOa8=;
	b=uLTNeC3DSItybl2bwGf7B8bMm4mKVbm+ZZ53Y+Ieqz+b0S1SAgkuMyU69DGsrdGyxpg4UQ
	y9evjluonBkoR3l7Q+o/wd/ENLgd28w7uhTRXXi9cvduUxirwPk5Vx83hvtRQXas+apCsT
	3/Fr1t73HXf3WDK2+rp8zQ7uXMLaV6s=
From: Ye Liu <ye.liu@linux.dev>
To: tj@kernel.org
Cc: jiangshanlai@gmail.com,
	linux-kernel@vger.kernel.org,
	Ye Liu <liuye@kylinos.cn>
Subject: [PATCH] workqueue: Fix incorrect error return value in apply_workqueue_attrs_locked
Date: Mon, 24 Mar 2025 17:07:48 +0800
Message-Id: <20250324090748.753195-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Ye Liu <liuye@kylinos.cn>

Commit 84193c07105c ("workqueue: Generalize unbound CPU pods") introduced
a change that caused apply_workqueue_attrs_locked() to return error
pointers using PTR_ERR() on failure instead of a negative error code.
This caused unexpected behavior in functions that rely on the return value
of apply_workqueue_attrs_locked, such as alloc_and_link_pwqs().

Specifically, alloc_and_link_pwqs() expects apply_workqueue_attrs_locked()
to return 0 on success and a negative error code on failure. However,
returning PTR_ERR(ctx) instead of -ENOMEM led to incorrect error handling
in __alloc_workqueue, potentially causing system instability or crashes.

This patch ensures apply_workqueue_attrs_locked() returns a proper negative
error code (-ENOMEM) in case of failure, restoring expected behavior.

Fixes: 84193c07105c ("workqueue: Generalize unbound CPU pods")
Signed-off-by: Ye Liu <liuye@kylinos.cn>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index bfe030b443e2..8ba679d9b566 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5363,7 +5363,7 @@ static int apply_workqueue_attrs_locked(struct workqueue_struct *wq,
 
 	ctx = apply_wqattrs_prepare(wq, attrs, wq_unbound_cpumask);
 	if (IS_ERR(ctx))
-		return PTR_ERR(ctx);
+		return -ENOMEM;
 
 	/* the ctx has been prepared successfully, let's commit it */
 	apply_wqattrs_commit(ctx);
-- 
2.25.1


