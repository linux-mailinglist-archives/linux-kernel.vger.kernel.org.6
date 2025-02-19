Return-Path: <linux-kernel+bounces-521614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 321EBA3BFEE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9988B1885198
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F10F1E102A;
	Wed, 19 Feb 2025 13:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qe/H8erv"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813E41C84A9
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971763; cv=none; b=MPUUKBtw9QDQo56nHWpYva4PNt93aAIJ/S2108L7lhsbTtS1upRvm94NHHXGBLtyd6l89DygE5/Kf2hI3kieRIxLSBcsCzAHAPv5aXJmzeSDKlhmXbjqT/VNsIszsfbYAe1i8gPMgzVt6Z1suKZ/kvBRnmu1ZxyQH8mzonBkzS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971763; c=relaxed/simple;
	bh=iI8Vz41XCgDkHXnBPDUUnN1o6/Lxl8M612q6E9Z07Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dfW7FLHojv16UB7ElHnDu9cc51Kkg0YpbCpTYsTtPxEKldUEq5lWnlmqzsQwcfoqBvRUTGkvLnBl/BRsqI8xOhn9FZm7sB0SYJteSJh9CkdmO2D5Uj2ZRcgueRW42gqq7leDdZkZGXAat8ZwxZjr92kYNcWwC9qz12WzghxDGQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qe/H8erv; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220d601886fso90581135ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 05:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739971762; x=1740576562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mq7Uw5syLMBhzfOZyHpRiSzLcn9qEZnpt1LUwjmAIrA=;
        b=Qe/H8ervLvhDQZKbNP6C7mrP5ArC7c4ghSCM1dXjFYb5OK2DQmq2VR8b/kC+o/erO6
         Jd6aSeAWU6FVQ4bYrYtwdb/LZdmnTNy8/ozXJZPYN9F6kwJHlpuCpedAP7VMHtnWtVLV
         r87BvHRI+fo0knMRQbXOt4ryJKtM6o1xMfcb18KPzHQljK0Fv4dCmCcmiqqz1Kk+H4Sy
         Ygh7Iium4s/bjgZzZN54Ln4weCI6mbtiLdP2ErsO1q9hyhzP6rGXAU/tVDzCKbMtjkd+
         KDG6ntYU6o07CYIfnt037NGpB9V8lLf5IGR0bUKaCNPPZB/jpZTwLdJKTlfyhcn8auZP
         nOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739971762; x=1740576562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mq7Uw5syLMBhzfOZyHpRiSzLcn9qEZnpt1LUwjmAIrA=;
        b=XsJngY0FS3b3jMduirDePG7SOdXpSuHHsyco95EGxpK8zDq90O1i4fsxXJZqYj+okv
         KY7xCsbxqe1WwZq4F9j+z+Y803hYtBG3AHEKh8msqpmpEhuETSwxsxnBP52LMQk9q4/q
         EWoxBOZM2vTcm00soEMICpcsuz2wokmE79Ev7HbjMAYSwxx6RU7TDkJor4BajOeQZpED
         gO9eAjYHUNSI7fdSjR7XtPtorP0oOFJ7pYwWzEdXJ4ibFvPhbuoc73TAfVYXP/ZjcMjV
         NgO4Y6p0XGLXLPyHeIHPTJ4vhu9IxUsKI/qe20N2r1S7Qu3zwkbBzR3hJGbYkENS0l3v
         LYfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLDFTsIZu9uO3OxTYvdOvwaF3ETS9ynDIv/bzjjWu0sWFxCedPhVwF7noZxMIuu6po2gM9mjLiueMIccw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVKMzkoqkIslS6ZjXChpAvoGh/kCl+rmeZfdOCi7pbr4dHHGtB
	Ghsu7sXZaQokcCUBR8OfofBcTmbDDb7z1hWoSLLIDFGKFmSsgLw0
X-Gm-Gg: ASbGnctuizQqBAyeeLhTvpR3D9iKjkKZhKK8Ux53e3PsTxrTFQbpHR1gUV+vKL/F8nn
	2qKkdKMT91M9AmBeyd4MtcK+mJqK54i8y0t+H6vS2KkYDOKFIF5bya99+spFZPMTTdxNytwHc+C
	XcOug6pShpYe28o9YEL93HccO6aWr7A0CXXjx5iSRxOXSYhms1QokLFMYeKVIl8ycyw42oMq/Id
	FCjEYtFMM6nV4DKOJ5QA1nQT7IH6p/xibIP05hmZNoE35SOK5mpk1G3Y+j+4da52WckrxQtp6V1
	IQ0LP1qq8LZIzmt9FFEOqh6q1FKQUP7GAG24khoszOLk
X-Google-Smtp-Source: AGHT+IFM0HHwBcR98/sXMvU91juMu8wdIvxc5rlimSNsB+RJgBJ4wYrl5IxiaPUdBwiOusYaR8ZsoQ==
X-Received: by 2002:a17:902:f64a:b0:21f:6c3:aefb with SMTP id d9443c01a7336-221040bd763mr329154265ad.35.1739971761534;
        Wed, 19 Feb 2025 05:29:21 -0800 (PST)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53491c9sm104150965ad.15.2025.02.19.05.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 05:29:21 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org,
	brauner@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	segoon@openwall.com,
	linux-kernel@vger.kernel.org,
	syzbot+a2b84e569d06ca3a949c@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] ipc: fix to protect IPCS lookups using RCU
Date: Wed, 19 Feb 2025 22:29:05 +0900
Message-ID: <20250219132905.8214-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In shm_destroy_orphaned(), we are not performing updates to the IPCS and are
only calling idr_for_each(), which can be protected by the RCU read-critical
section.

And if idr_for_each() is not protected by the RCU read-critical section,
then when radix_tree_node_free() is called to free the struct radix_tree_node
through call_rcu(), the node will be freed immediately, and when reading the
next node in radix_tree_for_each_slot(), the memory that has already been
freed may be read.

Therefore, when calling idr_for_each() in shm_destroy_orphaned(), it should
be modify to protect it within the RCU read critical section.

Reported-by: syzbot+a2b84e569d06ca3a949c@syzkaller.appspotmail.com
Fixes: b34a6b1da371 ("ipc: introduce shm_rmid_forced sysctl")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 ipc/shm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ipc/shm.c b/ipc/shm.c
index 99564c870084..baef5afadfb9 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -431,8 +431,10 @@ static int shm_try_destroy_orphaned(int id, void *p, void *data)
 void shm_destroy_orphaned(struct ipc_namespace *ns)
 {
 	down_write(&shm_ids(ns).rwsem);
+	rcu_read_lock();
 	if (shm_ids(ns).in_use)
 		idr_for_each(&shm_ids(ns).ipcs_idr, &shm_try_destroy_orphaned, ns);
+	rcu_read_unlock();
 	up_write(&shm_ids(ns).rwsem);
 }
 
--

