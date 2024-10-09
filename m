Return-Path: <linux-kernel+bounces-357853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2689976FB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9163FB21196
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7404E1E25E9;
	Wed,  9 Oct 2024 20:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="l79Ms5YQ"
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A36188926
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 20:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728507207; cv=none; b=mm+mSmsIsDUebOA1VNnMqV4+l4O1PhPQzVYNILn7T59L+tkfIn4ZKm7SebgJWX+ePda9yyn6SzvREih9FA2T5zc/LG5b4COa4lonBofyuIxTAY9woAbT8FP9/IFV3tVF7fSCgDkCSS4nelIusfceUDkCfGlqu7hBIwP8mzqXuMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728507207; c=relaxed/simple;
	bh=ekPqjQ2dHnJ035CLRD35iLHb55UjhEt5HHfSh+y+Q5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofBB2Wolb8l/EVKleniHqaCqjgMsJR+vvR41ve/NLu10TaBdQ9rxtm7dhx8ZjeDgBWP0jhV6Kb1ewkEQvWmVyKYQDhX9+xzjub7mDqGycpt/vHj+6qzX1RLsU8jhA8UxXK2MAAgPpWlt9dVbRutCanuIX4i56aICIsGkfz5Deqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=l79Ms5YQ; arc=none smtp.client-ip=80.12.242.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id ydgIsdEnS6TFnydgLsgFfi; Wed, 09 Oct 2024 22:53:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1728507197;
	bh=Yqu53K0lI1nXfnkJIPwVNUp3/6poySz8F2BQ5rNMqHI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=l79Ms5YQ4tcp7DvjRTv2RnVxeYMtyXnOc4I6JeQ+ZQEQYuTJTDjbH1+CvMy/GZrFD
	 5sTNDgRMoHZCecnPZyhx23AU1dRNqLVW2Z+0oVLZxTJh2y4qVW4jyZ9KvJ7eRRQFhQ
	 ExJmvbD32Pe9AJduH+eS0xGO5/BwKyrha3oUeVJ9TMYzUhl4vV46jH8OaU0ZPgNBgj
	 47HmpJqr6Le/Egc4udXtCNJn8HZckniMh5/+uqNyb275C1cnMI4oQ3BTxJzX2Hdf2x
	 OrGDAOWaPW5rIKTHOVuI320v5NM9snnFnI/FSJSNadQMn6yfxvZEACaFHSj3KgZArF
	 KglL3pGgc5ZhA==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 09 Oct 2024 22:53:17 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] rpmb: Remove some useless locking
Date: Wed,  9 Oct 2024 22:53:06 +0200
Message-ID: <b1fcc6707ec2b6309d50060fa52ccc2c892afde2.1728507153.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <df8bfbe2a603c596566a4f967e37d10d208bbc3f.1728507153.git.christophe.jaillet@wanadoo.fr>
References: <df8bfbe2a603c596566a4f967e37d10d208bbc3f.1728507153.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need for explicit locking when using the ida API, as stated in
the doc related to ida_alloc_range() / ida_free().

So remove rpmb_mutex.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
See:
https://elixir.bootlin.com/linux/v6.11.2/source/lib/idr.c#L375
https://elixir.bootlin.com/linux/v6.11.2/source/lib/idr.c#L484
---
 drivers/misc/rpmb-core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/misc/rpmb-core.c b/drivers/misc/rpmb-core.c
index ad1b5c1a37fa..2d653926cdbb 100644
--- a/drivers/misc/rpmb-core.c
+++ b/drivers/misc/rpmb-core.c
@@ -13,7 +13,6 @@
 #include <linux/slab.h>
 
 static DEFINE_IDA(rpmb_ida);
-static DEFINE_MUTEX(rpmb_mutex);
 
 /**
  * rpmb_dev_get() - increase rpmb device ref counter
@@ -63,9 +62,7 @@ static void rpmb_dev_release(struct device *dev)
 {
 	struct rpmb_dev *rdev = to_rpmb_dev(dev);
 
-	mutex_lock(&rpmb_mutex);
 	ida_free(&rpmb_ida, rdev->id);
-	mutex_unlock(&rpmb_mutex);
 	kfree(rdev->descr.dev_id);
 	kfree(rdev);
 }
@@ -175,9 +172,7 @@ struct rpmb_dev *rpmb_dev_register(struct device *dev,
 		goto err_free_rdev;
 	}
 
-	mutex_lock(&rpmb_mutex);
 	ret = ida_alloc(&rpmb_ida, GFP_KERNEL);
-	mutex_unlock(&rpmb_mutex);
 	if (ret < 0)
 		goto err_free_dev_id;
 	rdev->id = ret;
-- 
2.46.2


