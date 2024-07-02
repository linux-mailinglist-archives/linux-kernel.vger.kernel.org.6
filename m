Return-Path: <linux-kernel+bounces-237230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690F691EDB9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 06:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2451928558A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 04:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929AC130A53;
	Tue,  2 Jul 2024 04:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhctQyFU"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880DF5A0FE
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 04:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719893552; cv=none; b=QbmOxt1FIFidJUS7lCi23nJZyadyvXOqFPFSyAHsOInJW3yFb41NFiLDAQHxZ0tHvflAw4KS/bGp+IUndpz+aEKg4zoJ4dM2cWUpVWd1NH3B+v9qt7/Drd812rHTBP3UliB3k0OVNW9u3mB7aT9cIZporXW8kR3Etz32WXapH0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719893552; c=relaxed/simple;
	bh=d9D77y0p71i8HH+N5bc+JYRyqBwg+cABo2Fllx5tVPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oyVmbQKqt/G16o3Zf+djB22hovHxBhEgyV9oeiXmSJ8K1CUkbPx74tcws8oEe3eMynIIs6jQkd9nQeOX1oUzGajYEIJXFCen/aKGSrQ0zHNRVE9Nxge+P8+gHEDrgpZOh5SbY/jRhrgsUJqH7xgsTm8An+1rT4Y0P4JgHR9JXaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhctQyFU; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-702003e213eso1826366a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 21:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719893550; x=1720498350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oH7C0ySMktpef1FHPyy60fyeYjwvUSz+ek4mpdhRp4=;
        b=NhctQyFUm3GVf61QJkoQjbKtM0RNg9iD4YUFZ3O6eMf63Jv4LOZ1llK66uFqmwF2Vx
         f/nXwvRUiPBIjlRPISENRfWFIVke9cV48w17UvH/SVzI7ms5x2p11rMKe4Z57sD0VGzP
         1bmVGyiQPMA+OI1FbW/4tWzoSyMlHQZ0TGIZZKGH479zafrb4HuRMQzQ2DOb7Ol1KETv
         Z1e5Ew7rOzfvv6qtrJuNcXfYn56eYk5zYcgLelkMKg1czA999y0+jaCr+tfD//cnQWkp
         ucWMo9XitH85Nw8XafJ3aPSd0QSqkCPvvoc5mXO5Ax30Q8eDsHMyPBPXjBFYfVoWW/qP
         qCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719893550; x=1720498350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8oH7C0ySMktpef1FHPyy60fyeYjwvUSz+ek4mpdhRp4=;
        b=Dp7XBEKJLsKHG3WPSlsUZhEyX0MS8GZIjV/4gZczPq6qdwmWjT4xdsvPm/7qGTFiEW
         Miq0FruvN6WLEsy8m2+5Cse7BaAdWwsIQzqfrI3/r02hKo+JFgH2qQVcnt4EGlPlTu5b
         RagCTnmId3BdYCY7qJS+z/EDR/Ok1rEdi29K21Y7a2RE9TDltZr6m70NngklfJ0RUJWs
         V6Fb+P82B6uFVkGCRF/fU02TWSDxA+7rgHfFmKKLqSVnJ7wCjWCLpqxK4TMn6hfLMQQ/
         Y944aWnIhHmNHUAuBoxJV4d0QhzHygvC6C2shlsl4Og95JQ997c9Mnizv/Bz3dD3QTJg
         bFAg==
X-Gm-Message-State: AOJu0Yx0R5W3DvA3eb071jtUqXdpU2PeTLNisu0pvnMdiFz5fRsXzL6a
	f7TB+GFuKA5UxUtAo9rNcMU+Yo0UUGP42FiX02jzrTrtyBGe06FGOOiXVA==
X-Google-Smtp-Source: AGHT+IE2k8MTAdtb6NSKS7+v5pIAn6NQhoE++UiWLLwpnvOpBvxjPjlU2UImE/kdeskjWzpghsX0wg==
X-Received: by 2002:a05:6358:7e89:b0:19f:54a7:4f0b with SMTP id e5c5f4694b2df-1a6acde1b96mr764237755d.19.1719893550139;
        Mon, 01 Jul 2024 21:12:30 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c9618a9c03sm198705a91.7.2024.07.01.21.12.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2024 21:12:29 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 2/2] workqueue: Simplify goto statement
Date: Tue,  2 Jul 2024 12:14:56 +0800
Message-Id: <20240702041456.629328-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240702041456.629328-1-jiangshanlai@gmail.com>
References: <20240702041456.629328-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Use a simple if-statement to replace the cumbersome goto-statement in
workqueue_set_unbound_cpumask().

Cc: Waiman Long <longman@redhat.com>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index a3f9ff4fe657..7a33f958dcb2 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -7202,15 +7202,10 @@ static int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
 	 */
 	cpumask_and(cpumask, cpumask, cpu_possible_mask);
 	if (!cpumask_empty(cpumask)) {
+		ret = 0;
 		apply_wqattrs_lock();
-		if (cpumask_equal(cpumask, wq_unbound_cpumask)) {
-			ret = 0;
-			goto out_unlock;
-		}
-
-		ret = workqueue_apply_unbound_cpumask(cpumask);
-
-out_unlock:
+		if (!cpumask_equal(cpumask, wq_unbound_cpumask))
+			ret = workqueue_apply_unbound_cpumask(cpumask);
 		if (!ret)
 			cpumask_copy(wq_requested_unbound_cpumask, cpumask);
 		apply_wqattrs_unlock();
-- 
2.19.1.6.gb485710b


