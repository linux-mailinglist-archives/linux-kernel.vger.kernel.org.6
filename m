Return-Path: <linux-kernel+bounces-215178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC10908F42
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE07E1C20ECA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2099D364A1;
	Fri, 14 Jun 2024 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvmqLn6K"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92472F3E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379971; cv=none; b=B/d/wAq6hmyWF8yeH/qu/T8PdldEG8f5h9T9j3xhyhl0YKkcrh0BrLpZzeJi7G05cPaDHecDXweiLy8sFgvX4/S1agBRhQG+cKfQaRoo4uMyz9VQbhG7+Nq8WZmeU1tqqIH9jNuIrgJt+C3GPLCMBJy6oEeO/G7x9xHDcR0Q3m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379971; c=relaxed/simple;
	bh=XNFRwGgQs0AmajRntgrOUObRTNe+qXNYuFZRVs7W3hc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IJ+vs76PBLYHT9QS7pEFXGWxBcGl5W7yM3MX6Gv/zt9Ea7qTiGvLVhrvi6ZjCWGtfMJApGWwSX9c5H9stFMEP8MDV7V94FY5O+hA+fwCWdhGq9G1sMfTliXrrHR+RAWc9hFyHnXLvq3yd6yVSlG6ikPmpRDvlgX/g9p42vIMQ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvmqLn6K; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7043684628cso58432b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 08:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718379969; x=1718984769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pHhXNaU5RbwYqq1iDYAlGO/+PUn+f/432PYR4FenmOE=;
        b=IvmqLn6KPmnblM3sQDZMKX/Wrin5HQTIbZmJVJbtCHoaCOeXEfPwnqw8ZkgEuCx8Uh
         WRK80nXUJ2o+HSbODPKIuwoCQrCSwJ9LHLk7jLk7b4A5rfKhsqluIwCod086kjR6S2Rq
         OqfFKJPVXgRLK3x05fLy6X8AvBtcZ4kNBRTg+VPUSV2seu18+g93/NxJs1QbRsYmPAc5
         EjW60zSRjuk+ImE0G5A0JO71OVjzhx1OZY1pEDc/xUaA2pzrz5iSBQhLHSLTJWPKj1Zw
         9Mjd9GAgUUxtSUC+sjuQnYY+2b3/pviBz5ucDq9Qs4lBpwg18VZOF27SP8SB1pwhXQbH
         Rqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718379969; x=1718984769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pHhXNaU5RbwYqq1iDYAlGO/+PUn+f/432PYR4FenmOE=;
        b=Ckwp0RLjJOXhWrdRfpYy75b/QCkYFGDnBFv+HDznrZcwPAzWH28Cj3YnizkkWfdAxX
         ZMmsRisDq0clEvg9qUHW5Ie0ySDSKR65wP/J2FKwIOelRcVaAT/e5h0Xs5QDBYn2iUvj
         fOnnDlM5JXVYDvfaZafo/yXbUp6Dc+2Mu3TOUTPH7j7VLg6z11gI4iovE/hRO/oATVVM
         CpmHPP6JutBll5Paly7/qTcuOou7sQVU0Mrm3NRupP080fwlPagcBaV86rfIbT1Bg1Yl
         PkH4Hngizg6pbtAO0XWf7KFJ6HXuqcgOlE1WwV+BT7hpyaXxdbObfyR/CjeUxLxma59F
         bTAg==
X-Forwarded-Encrypted: i=1; AJvYcCWhIwnS8K+uiIeW1XejM5EF+u1TMX6lmUqF5ETSdMCfooSUER2E0k/ovjNtHnLMlaL1fl45cseYoHFsHo/s1hNTMhMBLWCWzc9pdRKy
X-Gm-Message-State: AOJu0Yw8c69HlkEJeacqT2rjhDXThDgduq4evUR/RzYiv0FWI1uSuPiQ
	WBp7o3NNHz8UzTZuZfp7v63JRrt7SAG1zBq4R11hs2slc6xPWToc
X-Google-Smtp-Source: AGHT+IHUf0uKVh8fNq+1Ay2u2th6Tdv6VPB0S5U5mfnlL6BSYqKVRDy9oyWYgHr7fjhes7ast2u8Wg==
X-Received: by 2002:a05:6a21:9988:b0:1b6:d2e7:160 with SMTP id adf61e73a8af0-1bae7bb22d5mr3422261637.0.1718379969121;
        Fri, 14 Jun 2024 08:46:09 -0700 (PDT)
Received: from vaxr-BM6660-BM6360.. ([2001:288:7001:2703:7415:39cf:af58:4dff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc96c793sm3178252b3a.51.2024.06.14.08.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 08:46:08 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: akpm@linux-foundation.org
Cc: jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH] lib/plist.c: Avoid worst case scenario in plist_add
Date: Fri, 14 Jun 2024 23:46:03 +0800
Message-Id: <20240614154603.65203-1-richard120310@gmail.com>
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
Signed-off-by: Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
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


