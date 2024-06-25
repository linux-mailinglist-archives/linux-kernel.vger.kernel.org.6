Return-Path: <linux-kernel+bounces-228102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974E6915ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1D6283661
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D927EACE;
	Tue, 25 Jun 2024 00:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TBmTCVga"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D810A921
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 00:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719274360; cv=none; b=szLILdSZPLhl/AKi1RJPWpwuDYfABWTecKmJJO/AyTAxNJEXR9+LIDWC97Unr9dNTbl5CHF3t9YsrAMB7qwkAyEzFFQ5abuTHQWBEx5gHmTUFvYkWOiNEIP0+noijD/9PR65/nDvUOJvrDd18Yfw0NI0+9UCB/Wq1CjAaBpfIUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719274360; c=relaxed/simple;
	bh=3ep+CbANpHhFJaC2drnPTQWkiZcTYE5FjKpnbpXQV7g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VUcNVT4uB39M/DE/LpibrLIH0G689CKEgYLQA9/LrMg6WJjGZNpWEO9DxW23Es6aa9QWoIXLZB7lHZHPo1vUkTqhOge07OlzCfKhamqTU6iRc+l7Z+FbdjUrc1L/66qb0p2rbUruFnWiH95NkLcED8koR7e1voOAW2u32USYUoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TBmTCVga; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-643acc141cbso22851657b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719274358; x=1719879158; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TtD/X0CR+SKpWtRnl2DcH3z3T/krE94I8KG3Kub/k5E=;
        b=TBmTCVgaIaeAqDV93pPQ8tc32hs7EcJXmiXNS9pZmN87/gT91B3wP47JWLnO1oGbWQ
         tLVoBhjGk0KZDyCvUdAUGX/w1dd3jWkxv9uKPI6uIk4HY4PHERVE6R3XxYuHaPbaI/L8
         yiYhqmByWmR4VcRTAdok1+BWkFJQ2ON0gZjo3/ur5JEG77Ak3xE7jHiBFPnNS9w8wnBO
         HRl2mRgLH2364JNbL1sco9oU/UjtnvAdoVxSXJ2kQ1ilLsmCRohpg6FNyajVSFUq/oJF
         NtkUSgd16C72UdgQESwOmhzVtTQ1FvB9hIkhLxIIMedmqL9YMRUI2Y+9YexpsYKG8BpK
         z81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719274358; x=1719879158;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TtD/X0CR+SKpWtRnl2DcH3z3T/krE94I8KG3Kub/k5E=;
        b=YbUL9GO+2j+km+8Jd2+kNraLCro+/FI8yOAGwRZABl+OO5CkrZLdDfFA6+Qw3xUsT7
         v5IgvFmgkdlB0YgoXTGQgE8GYQPwLfJnBQ81wyB9JXUhzlcOcitWevG6o8wqAPQqmzse
         upecxKLX3KGFweUUfthRx36LmdLpxXS3J9m6SZwV9JUeQbJKdu/uIiGas6Ap4B7mzwdC
         lkPithGO7BnRjl4Zs1424XB0cyvx0JF6a67WlwhTPjCuwEBUp+Xggyzxdf5BsFU7YAG5
         FoANXqd6hBi5TjsS9R8+sJlFUlnC5wHy+Fvr1RkKxsMs/l+fI5zLb8Lwy4DzEH96P66j
         FKWg==
X-Forwarded-Encrypted: i=1; AJvYcCWudk8bkwDSOpvCV0GKzgsGr5KaxDudYGM4/dSYPVmariNPGw3YIR5R+Ye1mZyqmVqMrFBLCxtckA0lCXeun7jnexxpUsEeVF8v2CWz
X-Gm-Message-State: AOJu0Yzfhp96gfN82G74CeNcvXBwZszOqg+PeVhEInYgfp+V3FUu7Rr/
	1RnYumkC7cLSnyEZwFIui1VO9f9xlrFDSrew5K4g8LPtNOPkpEF3pDAeUE2pjJ9w3ZsH9bkxDaX
	KlNPNvNFHAjGs0g==
X-Google-Smtp-Source: AGHT+IF1MrPDVeNmWsnTZYOUg4QJX63wItVeWqFoL5W2t0vn62fxYIZlxh9/0Y127DtwjcVkJw2Wp5kqxUSEgDQ=
X-Received: from ziwei-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:9b0])
 (user=ziweixiao job=sendgmr) by 2002:a05:690c:f09:b0:62f:1f93:939e with SMTP
 id 00721157ae682-642544fa2a5mr374377b3.2.1719274358209; Mon, 24 Jun 2024
 17:12:38 -0700 (PDT)
Date: Tue, 25 Jun 2024 00:12:27 +0000
In-Reply-To: <20240625001232.1476315-1-ziweixiao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625001232.1476315-1-ziweixiao@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240625001232.1476315-2-ziweixiao@google.com>
Subject: [PATCH net-next v3 1/5] gve: Add adminq mutex lock
From: Ziwei Xiao <ziweixiao@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, hramamurthy@google.com, ziweixiao@google.com, 
	rushilg@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We were depending on the rtnl_lock to make sure there is only one adminq
command running at a time. But some commands may take too long to hold
the rtnl_lock, such as the upcoming flow steering operations. For such
situations, it can temporarily drop the rtnl_lock, and replace it for
these operations with a new adminq lock, which can ensure the adminq
command execution to be thread-safe.

Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        |  1 +
 drivers/net/ethernet/google/gve/gve_adminq.c | 22 +++++++++++---------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index ae1e21c9b0a5..ca7fce17f2c0 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -724,6 +724,7 @@ struct gve_priv {
 	union gve_adminq_command *adminq;
 	dma_addr_t adminq_bus_addr;
 	struct dma_pool *adminq_pool;
+	struct mutex adminq_lock; /* Protects adminq command execution */
 	u32 adminq_mask; /* masks prod_cnt to adminq size */
 	u32 adminq_prod_cnt; /* free-running count of AQ cmds executed */
 	u32 adminq_cmd_fail; /* free-running count of AQ cmds failed */
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 8ca0def176ef..2e0c1eb87b11 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -284,6 +284,7 @@ int gve_adminq_alloc(struct device *dev, struct gve_priv *priv)
 			    &priv->reg_bar0->adminq_base_address_lo);
 		iowrite32be(GVE_DRIVER_STATUS_RUN_MASK, &priv->reg_bar0->driver_status);
 	}
+	mutex_init(&priv->adminq_lock);
 	gve_set_admin_queue_ok(priv);
 	return 0;
 }
@@ -511,28 +512,29 @@ static int gve_adminq_issue_cmd(struct gve_priv *priv,
 	return 0;
 }
 
-/* This function is not threadsafe - the caller is responsible for any
- * necessary locks.
- * The caller is also responsible for making sure there are no commands
- * waiting to be executed.
- */
 static int gve_adminq_execute_cmd(struct gve_priv *priv,
 				  union gve_adminq_command *cmd_orig)
 {
 	u32 tail, head;
 	int err;
 
+	mutex_lock(&priv->adminq_lock);
 	tail = ioread32be(&priv->reg_bar0->adminq_event_counter);
 	head = priv->adminq_prod_cnt;
-	if (tail != head)
-		// This is not a valid path
-		return -EINVAL;
+	if (tail != head) {
+		err = -EINVAL;
+		goto out;
+	}
 
 	err = gve_adminq_issue_cmd(priv, cmd_orig);
 	if (err)
-		return err;
+		goto out;
 
-	return gve_adminq_kick_and_wait(priv);
+	err = gve_adminq_kick_and_wait(priv);
+
+out:
+	mutex_unlock(&priv->adminq_lock);
+	return err;
 }
 
 /* The device specifies that the management vector can either be the first irq
-- 
2.45.2.741.gdbec12cfda-goog


