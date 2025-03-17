Return-Path: <linux-kernel+bounces-564609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A4BA65836
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0043BE0A4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2381A314C;
	Mon, 17 Mar 2025 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBvBe2fi"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CC31A23B5
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229379; cv=none; b=mqROIMwsCf/M0yJkRxyNqmtXweEDANiwl7n4TGd2GRN+z6XdymN8IiynVD9cVtq/xxgeld0HcYfU4+o+UriB81DE2o3OnuWtKmksaVpFhDMjtVXRR4pQxqg5bxnNg+t7jG2ZABxff7FYKRsb7/dU9/jQHGlNUQ5tksKNzEY1tTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229379; c=relaxed/simple;
	bh=+5qOoiQ9fJgCIchDENR3sXW+cpUgNlPDH1B+xKZEJEs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LcFRPRvQ3vxl8h7B8WkIRUvHDW5nTX67O2eyAxzSQfsv1zKd5kQcLNXgF5WFOwkStnPbx2vbgFYNcqwiKxDQR+Ato5Cbs4E8LPYLbZRyq4QiUbgfH1dZdLC/oB0ikK73BbBlcTEIy/4Vrch24MX4B2UGydvu6DilYh8gnoOKbMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBvBe2fi; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30795988ebeso48143661fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742229376; x=1742834176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fm+Vc8Ft3wj+TdV2Qy7sCZQLNLQL3Vgkfnk4EUOWKbA=;
        b=cBvBe2fioVkZjKS+HtqMYPn4uhG/KpkRneExZYWyAH/p9YQNnw3njRGEySeZtvrh7T
         ZCH9Gk0wrRkcrZvJ0Hd+QWPPxyh6AQcXYv7rboONT7hPN2tv6OkWAWvzqUv+QD9vqnB5
         RwzzX8Q1z/paMNN5I+RFfxBVRPwqWWZHv2q31LjkPjk4TtoBs+usur1oRnSi292p3XPY
         ku6SXXZYA1GPGBO7+Bt/oDXjfl4G7hByUScmN50GpFcc0LjWUabIYUlskWgSv+bhB+AT
         w0UMlNRB+yl7M5r1ikE3dZQPdbniLCyKaTzMeYYQG4XM9R+BhdiElND5Ic2fQ1x8IItf
         FA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742229376; x=1742834176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fm+Vc8Ft3wj+TdV2Qy7sCZQLNLQL3Vgkfnk4EUOWKbA=;
        b=iuI8w8N9OmwomqhSIRPf9qnAWVCpbJRiSV79qwVhX/xGdBUkzjuXvW8zy2svLiRmro
         /B5BzNeHzANnYk99wOmdEg6WaqL6MZv/TIBvMVRiD1CaxEombBRH0bMw76AcJJE77E76
         dnUm1eE0me4MJZptUkOrYYbk8W9pb7yUdlL3wUlvsF5RFGgQaVf7TKSdFBDlbZpWpumD
         29Hy3VAGr7vUVMntPsmXi81NN5LhVmP3xuZekHMiDQ5e41SI1zH2RyUwCiZGU3lA+Cs5
         yRH1UonLswxpiELl7eFdLOH8DyZISTPOl3ytAW9Eswy//ITS9179YG3AXvGlsMT6+o8D
         cpjw==
X-Gm-Message-State: AOJu0YyiIeBoMYK3xwlHcejKTqtZsx1rphQRZJLKkvRv6cIhWsm0w+ZK
	lS0wmnhiywB9oYHIn/58d/aE1wGaCzXbf1r/whE2IAL6R3zxcmw7vJUTUA==
X-Gm-Gg: ASbGnctRipW4xi4vJwn/1/fm19OEPAGws/d6nhQrFhrCS8BjlnaBL9FlIDwaYpA4tD+
	DhycKKnB47061vyOhBpoKZyJFTITf6QeBdY3H1/nzG+BX4dyKY6Dt+mtmYQwvhENPrGBrxQrteF
	P3pdA2VxBf6y4kAAksI+jLohWCyOEZJABbq+P0Ijk/RH2DKatNId8Sdi6/aH4fO7UoceMjIRRLz
	JhYQWaL81XCq9Hkpvelf9hS9GJfKSs2tFcX9VDkxLqy0nrxjv7nyhqd8sCVu9Y8yWo9LRkqUBGU
	DYkTRwmxSokiBLc9SJTHyDjrhE+oqVcadJeCIgXU
X-Google-Smtp-Source: AGHT+IErnjd1NSIMGuhSG/RxgeAIAcxg08vAi/aa0NwoW1lo5isTMHntblkxDcHvV8JQPOGA6bZkHg==
X-Received: by 2002:a2e:be89:0:b0:30b:bba5:abfc with SMTP id 38308e7fff4ca-30c4a863416mr76221661fa.9.1742229376263;
        Mon, 17 Mar 2025 09:36:16 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c4012af5dsm16457911fa.15.2025.03.17.09.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 09:36:15 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH] fork: Use __vmalloc_node() for stack allocation
Date: Mon, 17 Mar 2025 17:36:14 +0100
Message-Id: <20250317163614.166502-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace __vmalloc_node_range() by the __vmalloc_node() function.
The last variant requires less parameters and it uses exactly the
same arguments which are partly now hidden inside __vmalloc_node()
function.

This change does not change any functionality. It makes the code
a bit simpler.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/fork.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 2fa2a3582925..72d9e7c7639e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -311,11 +311,9 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 	 * so memcg accounting is performed manually on assigning/releasing
 	 * stacks to tasks. Drop __GFP_ACCOUNT.
 	 */
-	stack = __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN,
-				     VMALLOC_START, VMALLOC_END,
+	stack = __vmalloc_node(THREAD_SIZE, THREAD_ALIGN,
 				     THREADINFO_GFP & ~__GFP_ACCOUNT,
-				     PAGE_KERNEL,
-				     0, node, __builtin_return_address(0));
+				     node, __builtin_return_address(0));
 	if (!stack)
 		return -ENOMEM;
 
-- 
2.39.5


