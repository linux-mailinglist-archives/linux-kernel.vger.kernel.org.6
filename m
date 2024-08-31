Return-Path: <linux-kernel+bounces-309826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BF69670C6
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2726EB21D15
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 10:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BFE17A583;
	Sat, 31 Aug 2024 10:18:40 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AE916A940
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 10:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725099520; cv=none; b=bNx/LkxAKSZfcrkvPQ0sWsbYhPkGnxXkpdDZfQP7gxMRWogAxfIKth2/oHozAyIlhaWuoz+yh6K9e71lAnjtEv5Kij4od8838s1cEvYQIo1+QlJGr/+LbkxHoDKirt7VDmDIl1y674CbdFR84Ns+Ktfh6NgbAN8lnBYhRHBv8cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725099520; c=relaxed/simple;
	bh=Wcad/4peTr6b64efKaD2Vkw530/oNoOJodeP2k2dJXs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fk0zB6sXGrNbCkJMiCFNCmXWx+ptJFB07L+oahw0X8WNZjFiFUAxN+QmqaAjl1rWoG3BTssDPHT7UwltRe11yYrQSyh2Xc+ezwyiqMx2TTVoSzYTgje6/Fj9E/XNnelLkust3lE0PHLEhfGfemGSVLl+RnHVvnoNJ4CyM7favzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WwrXb4pMSzpVBS;
	Sat, 31 Aug 2024 18:16:47 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 341D91800FE;
	Sat, 31 Aug 2024 18:18:34 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 31 Aug
 2024 18:18:33 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <jani.nikula@linux.intel.com>, <joonas.lahtinen@linux.intel.com>,
	<rodrigo.vivi@intel.com>, <tursulin@ursulin.net>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <chentao@kylinos.cn>, <ivan.briano@intel.com>,
	<ruanjinjie@huawei.com>, <vinay.belgaumkar@intel.com>,
	<intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next] drm/i915: Use memdup_user() helper
Date: Sat, 31 Aug 2024 18:26:48 +0800
Message-ID: <20240831102648.92714-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Switching to memdup_user(), which combines kmalloc() and copy_from_user(),
and it can simplfy code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_context.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
index c0543c35cd6a..c1cc41e90502 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
@@ -2159,18 +2159,12 @@ static int set_context_image(struct i915_gem_context *ctx,
 		goto out_ce;
 	}
 
-	state = kmalloc(ce->engine->context_size, GFP_KERNEL);
-	if (!state) {
-		ret = -ENOMEM;
+	state = memdup_user(u64_to_user_ptr(user.image), ce->engine->context_size);
+	if (IS_ERR(state)) {
+		ret = PTR_ERR(state);
 		goto out_ce;
 	}
 
-	if (copy_from_user(state, u64_to_user_ptr(user.image),
-			   ce->engine->context_size)) {
-		ret = -EFAULT;
-		goto out_state;
-	}
-
 	shmem_state = shmem_create_from_data(ce->engine->name,
 					     state, ce->engine->context_size);
 	if (IS_ERR(shmem_state)) {
-- 
2.34.1


