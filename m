Return-Path: <linux-kernel+bounces-215150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FE7908ECA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CDB71F22CF7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD64D15CD64;
	Fri, 14 Jun 2024 15:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVi+iwaV"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921FC2E83F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379179; cv=none; b=fxCmTOm/BjLuPfHXLchqc2AxRKNOYPlRJ6WDNRGjvv5wuBVmMt0HWZxRLjomBUEl89QFEp7s9Lo8pBwV4VJTU34H5b+PTjAeE8JbXBtajwsoEfSy4fkR22tKI7B8bHdq7BbyswWsCz2YYL7tXWBvckJqSGJZWWekNgeJwZMns7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379179; c=relaxed/simple;
	bh=P+WFwznpBt593DGVR8mEfRJAN9nB2s1GBxsGF7JJM/k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d5f1SIs0QV/zSWwb9uo1Q3geJKPIeiCxg8bkhhZCEBgaGo2WrWQP0HUt8HTlhgxxDol1fXmjpYJUNYCEAJIHdcmLVFeIEmSdoVBHx4pRutpX8LQ3guBVOs8K0w4am6VcWPj/ABNug0+Ofx7gRu5fOJ8bTz33Zdp63r/lj+hwnCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVi+iwaV; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7043684628cso57172b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 08:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718379177; x=1718983977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5zan80ew+KQM5XCtc58jDVXdQTsa4mrxsFn9SUqykKM=;
        b=eVi+iwaVgbxy4X0VJf4QoknT5paJqm4Aitsh1Tr8e/5EdbjS6D9Qz/lbJC1PWfF7r7
         IWDi1AZLGp0ndN1Ivp3z0YN3Iayopc8kgDL7bzxMtGsQl+3mZBOksVUebJ/k8Ccw6a8M
         XLuhtVm0bEmfZjwsrneQ3G542OboFsc2sVAesOtz00BwtPH/9GBq3XF3EeOTX1Ref3Aw
         AZPqw3hLKKK/7Ms13WGuuHoMfvsJqT/YEIFl2AHkBs81CFhbYK4PVukTmc+jk5LVWu8K
         /VXPdGtyXYfhYKdzkIZnd+dUwWUJyeIPOVbwGKgi3p/D/uMOD2ttE0xT081hYasHEbmy
         aPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718379177; x=1718983977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5zan80ew+KQM5XCtc58jDVXdQTsa4mrxsFn9SUqykKM=;
        b=Qw+OZpGZ0aVTuMKyYo2tCOCmaa6oKAUppvx2HccqtzlBgLztPz4/cnjCK0ciBpkiZV
         tjS1ZAhE0Xto2j6BqpSWNjWDk3+i51UNG2KOzLwiUofFoHbKf1tA3kOCVxky16qOTzgW
         qtyS/q9r9eoQuJ25fXIFZkCxAxR9DAooFpsbK9L8e6w22k00YOzAP/d1Ha/MrLKAb8U9
         l0CNtJQPEX2HqfwO64g3OC7rMnYjcNpyfmj8t6exy82s2m/bA4XUGH1IwqY5b5+QQ/sW
         G8HGLclzAOAUVH2VVl+cPa3/NXOvdLGZmBXigH0BYsNcqIaNaamhes68X5faS0Eg+miI
         RkAw==
X-Forwarded-Encrypted: i=1; AJvYcCWVnJWlcOHkgGzxhmYkSZWREgQYC2+uEkQNHU7yPwylKuCC1OKvlH+T+fQ8lVbs34crVWc1vd+nULQBO/XJLHJYqJ5MBz1G3t4cs1n5
X-Gm-Message-State: AOJu0YzlvIhyIzmxpk7Y200q3Atw8eaTgqR3v8gYD+qU+0Oo+HHRWHus
	G10MBZJt7FdwO2JQq4/wAMfwL4/YJgtp2M4uD+l4Ezn0hv/84s2O
X-Google-Smtp-Source: AGHT+IG630/YQWok6f5wNn8gBoei7dXbHaRv27zqzh7JiIlnCtbEjRjP2kXvrojD6lrSjiAJoIYh1Q==
X-Received: by 2002:a62:f94f:0:b0:705:c0da:bdc1 with SMTP id d2e1a72fcca58-705d71bd22emr3042829b3a.2.1718379176681;
        Fri, 14 Jun 2024 08:32:56 -0700 (PDT)
Received: from vaxr-BM6660-BM6360.. ([2001:288:7001:2703:7415:39cf:af58:4dff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb99f4dsm3165562b3a.216.2024.06.14.08.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 08:32:56 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: akpm@linux-foundation.org
Cc: jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH] lib/plist.c: Avoid worst case scenario in plist_add
Date: Fri, 14 Jun 2024 23:32:29 +0800
Message-Id: <20240614153229.62961-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Worst case scenario of plist_add() happens when the priority of the
inserted plist_node is going to be the largest after the insertion is
done. The cost is going to be more significant when the original plist
is longer, because the iterator is going to traverse the whole plist to
find the correct position to insert the new node.

The situation can be avoided by using a reverse iterator at the same
time, doing so the maximum possible number of iteration is going to
shrink from N to N/2.

The proposed change of plist_add pasts the test in lib/plist.c to
validate its correctness, also add the worst case scenario test for
plist_add() in plist_test().

The worst case test are tested with the size of test_data and test_node
growing from 200 to 1000. The result are showned in the following table,
in which we can observed that the proposed change of plist_add performs
better than the original version, and the difference between these two
implementations are more significant with the size of N growing.

The random case test [1], and best case test [2] are also provided, with
result showing the proposed change performs slightly better in random
case test while the original implementation performs slightly better in
best case test, while the difference in both test are minor, we can see
them as even in those two situations.

 -----------------------------------------------------------
| Test size      |   200 |   400 |    600 |    800 |   1000 |
 -----------------------------------------------------------
| new_plist_add  | 140911| 548681| 1220512| 2048493| 3763755|
 -----------------------------------------------------------
| old_plist_add  | 188198| 774222| 1643547| 3008929| 4947435|
 -----------------------------------------------------------

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
[1]:
The random cases are created via the following code
test_data[i] = get_random_u64();

[2]:
The best cases are created via the following code
test_data[i] = (ARRAY_SIZE(test_data) - i);
---
 lib/plist.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/lib/plist.c b/lib/plist.c
index 0d86ed7a7..06cf2169b 100644
--- a/lib/plist.c
+++ b/lib/plist.c
@@ -72,7 +72,7 @@ static void plist_check_head(struct plist_head *head)
  */
 void plist_add(struct plist_node *node, struct plist_head *head)
 {
-	struct plist_node *first, *iter, *prev = NULL;
+	struct plist_node *first, *iter, *prev = NULL, *last, *reverse_iter;
 	struct list_head *node_next = &head->node_list;
 
 	plist_check_head(head);
@@ -83,16 +83,26 @@ void plist_add(struct plist_node *node, struct plist_head *head)
 		goto ins_node;
 
 	first = iter = plist_first(head);
+	last = reverse_iter = list_entry(first->prio_list.prev, struct plist_node, prio_list);
 
 	do {
 		if (node->prio < iter->prio) {
 			node_next = &iter->node_list;
 			break;
+		} else if (node->prio >= reverse_iter->prio) {
+			prev = reverse_iter;
+			iter = list_entry(reverse_iter->prio_list.next,
+				struct plist_node, prio_list);
+			if (likely(reverse_iter != last))
+				node_next = &iter->node_list;
+			break;
 		}
 
 		prev = iter;
 		iter = list_entry(iter->prio_list.next,
 				struct plist_node, prio_list);
+		reverse_iter = list_entry(reverse_iter->prio_list.prev,
+				struct plist_node, prio_list);
 	} while (iter != first);
 
 	if (!prev || prev->prio != node->prio)
@@ -255,6 +265,32 @@ static int  __init plist_test(void)
 	}
 
 	printk(KERN_DEBUG "end plist test\n");
+
+	/* Worst case test for plist_add() */
+	unsigned int test_data[241];
+
+	for (i = 0; i < ARRAY_SIZE(test_data); i++)
+		test_data[i] = i;
+
+	ktime_t start, end, time_elapsed = 0;
+
+	plist_head_init(&test_head);
+
+	for (i = 0; i < ARRAY_SIZE(test_node); i++) {
+		plist_node_init(test_node + i, 0);
+		test_node[i].prio = test_data[i];
+	}
+
+	for (i = 0; i < ARRAY_SIZE(test_node); i++) {
+		if (plist_node_empty(test_node + i)) {
+			start = ktime_get();
+			plist_add(test_node + i, &test_head);
+			end = ktime_get();
+			time_elapsed += (end - start);
+		}
+	}
+
+	pr_debug("plist_add worst case test time elapsed %lld\n", time_elapsed);
 	return 0;
 }
 
-- 
2.34.1


