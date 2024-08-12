Return-Path: <linux-kernel+bounces-283354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A336994F15E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A54C1F22D72
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC91186E3A;
	Mon, 12 Aug 2024 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZKNtr04"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21036184527
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475378; cv=none; b=YUuYaFC/ZuVag4wSx3Im/jyT4LDXCXYPBmoG84bzwyAdmTXcQDX490/Rcjmgs6jRdkC/fc+9symXTELAisN/4VHfNbTMKfmQnM7VWkwK8e+BQgqR3c+13DjqNB8JJpNKMgm7ddrZqaO8x1XnATipQSq+WTO+5LnXazHxUQCOJbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475378; c=relaxed/simple;
	bh=YWljak9lA3hGx8E6D61AwHsQf8+wXj/BfRHOVkK536E=;
	h=From:To:Cc:Subject:Date:Message-Id; b=cXz8txzv5NAp+72TUCRznz8SaHybv+xPTQ4Q2XrMk6btYji7iDYBVzeoIEkD127gI4essAapHQSOwJRBqIzmjMt1YCMh7KoqDBoPPQywT8+pM+3NhCPIg885yQOqC0KiFEHPg9i9+N4h2me86IQf55/KGuVvO8bv3gLLzB1F3r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZKNtr04; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7aac70e30dso500990166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723475375; x=1724080175; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqL+azb22qoy/Ppb3x13FzlBzWE6/71rpTQHRjrMrW0=;
        b=OZKNtr04SyGsVlnCAVFDWlmuV2o//lMoySFYeGjBpqxK0tw/6kj9sKd+b0Gk4UIv/V
         d4wP2+1ajcUB3IwCoRmSyag6m2/FyfO4/S8hLdqevT82h01q25SPATHvEtI2J2dCxCf5
         mLJ4tkj0V2WIsQd91dxF/JlK/Nujzh93SPcjhvZXil9TyGX35Q4/k1dRE5trIIoQe+Zo
         1xZkIfqyghf216YmAjzzIIDkZR+uSmB3EvcrFYcqzGO7CpaOIHX8Hk9PwtepbXyFz6Tj
         iErcFH5ZhHi5HkRHfgp3QlswKmYvngqzdf+BwbP33uOwuyz0c8wTJXlqQmL7Dhs9AHf3
         BWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723475375; x=1724080175;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqL+azb22qoy/Ppb3x13FzlBzWE6/71rpTQHRjrMrW0=;
        b=TQ+niNxDsBWMlM0XhWW8sKdwFSW8CcWFbGlEPLvSfRA0L2TUikB4fYnkg5gR6MXshr
         +Vvw+81neg3QQkYMiFK4nvQsK8gkaFX59cnnJi7rp/QrEJKnEgk6PjZnMP7BGkd98aKd
         TQNvMqPsTTBLNh7Loedqe6ltNXU1xXZB8POBs1NzqMofAOfyR5e4gwaAMYqHPc+Vz/SR
         LcKBIzhkHsBdV9oR+YFscxBa+leLBMMUD8mYJN6Lu4nwL6Kp8RTQZkZtQ1aBheGtCo12
         y/9CEkHm/4UAdLM4itqnUr108YEo0LqltES/7i5OOqqzvrMoSYPBurdxDqzR9bUbw5Ib
         grxQ==
X-Gm-Message-State: AOJu0YxQE7VMiJOhSJ1iWlJ0bQVjsZpx/sLuVZRkXs3YdM+STdHm8jpP
	sZAfn2oj8AI0JNRR3jVVOnGC/Cg9l6o56yGNUO5EmnmxAImPI/hC
X-Google-Smtp-Source: AGHT+IFgdgoGRXPhGUDsPFSDXBM4aOYDZLqtE0uYgt8JNzkGvvpo03nNinagNEn/lAoAIvtKNma8IQ==
X-Received: by 2002:a17:907:9445:b0:a7a:b0a0:ebd2 with SMTP id a640c23a62f3a-a80ed264d75mr48554466b.32.1723475374982;
        Mon, 12 Aug 2024 08:09:34 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb0e064fsm234695166b.49.2024.08.12.08.09.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2024 08:09:33 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	Liam.Howlett@oracle.com
Cc: linux-kernel@vger.kernel.org,
	maple-tree@lists.infradead.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 1/2] maple_tree: fix comment typo of ma_root
Date: Mon, 12 Aug 2024 15:09:24 +0000
Message-Id: <20240812150925.31551-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In comment of mas_start(), we lists the return value for different
cases. In case of a single entry, we set mas->status to ma_root, while
the comment uses mas_root, which is not a maple_status.

Fix the typo according to the code.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 3d2e207d9a5f..14ff54078f9e 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1346,7 +1346,7 @@ static void mas_node_count(struct ma_state *mas, int count)
  * Return:
  * - If mas->node is an error or not mas_start, return NULL.
  * - If it's an empty tree:     NULL & mas->status == ma_none
- * - If it's a single entry:    The entry & mas->status == mas_root
+ * - If it's a single entry:    The entry & mas->status == ma_root
  * - If it's a tree:            NULL & mas->status == safe root node.
  */
 static inline struct maple_enode *mas_start(struct ma_state *mas)
-- 
2.34.1


