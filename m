Return-Path: <linux-kernel+bounces-203510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 465E68FDC4A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 03:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C996128538B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFE510A3E;
	Thu,  6 Jun 2024 01:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVsousw6"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6867440C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 01:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717638464; cv=none; b=h5Jr5ICO5GW0PujpUo77HQcllS3isjyXC9WP8RW6rpCUDkzX4FZrsVDop2Ei9E2V80XHmjuD8D2DGrsyoa6PqOYAeq+qACjqYMJ+GdT4R+KV+EOOgFgH5M1RFJV8BSGrXiJ9YR4mJm9ujfMtSjxXVn9bHh2CusGE+p6OW2ipBg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717638464; c=relaxed/simple;
	bh=fYv4TCA3U547S8t0KRlnnrul6JyCJ4iRZ7/yOb91gMo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=DYNk6BDnZAJAU76CNPohLQyAtwiWJrYS6P97RXlcGk5JM3H2tAP6a6R4JDa0eKi0e13cAKIY2vUZDlqFCH2FqUto1Bxmeai5oAFyoZKxfojWYy+xB+/iYoXHzkxLq9zRznM1eqj/tiio3oRIYThLz3KRHJSwJv6BX165tCNUSmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVsousw6; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70264bcb631so356754b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 18:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717638462; x=1718243262; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCGVKRzrLeEfLG4s7yhSSh5l6gP/ezDtq2C7b5lSB9U=;
        b=fVsousw6i5hhS0NhvcIzFEnftAIMLK3Kfe62gvpyUTCV291PzPuQeXFT1krbfxRsdP
         pfH1KzUoNeiwhq22Vw+EsnDUS7SnJGLeHpMEpsmXJESQMMBoZfjqduf9gg+4hwlReu6Z
         pKBXIqX8h0LPedVwc/mz68BUXZ89nV9f+vSXoTdJsf4ZTNPlu3BOiQoq0XgabJKDDCyb
         EImhZOYMK1Npf5nBBLe0SVJ5OMkmN1DwMLsOsa0ewFf7Pj96JRl/zxdrSwlsPJObX1Of
         rJ5d1AWXNGYztTDU1vJMjoxtHUrw52hUJQc58TrjbU2YVWr4OhSbYFFCMnAxOTXFvzSj
         UpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717638462; x=1718243262;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCGVKRzrLeEfLG4s7yhSSh5l6gP/ezDtq2C7b5lSB9U=;
        b=qDaPsaVmCl5xvO8oNpl7BudZUvHZTq+RjxLrlIV9MjLV1Q9gOpngdtjkoD8ZUwBY/a
         66yS0wDLXSPQKgPkQzVguwXDtpOoU46+Ou10zR79W4vDsHC6l1YGexF7WDu2ycnlyPVa
         1ZhJRYkJ+7TMWmQNm5Z8hRlMT5JtOa2R+ZCby4r5ATcDpIDeOsyO6tnafynSaTlU0mtL
         hJCUhmkqowXK5GWPBDBrpWPpqeRuIH9j2carJUeuMF+eRwqYFRMj0LWpyPxQzII5lJO1
         Zn3aVJ6ELSUbrvirC7xOVu8dxCzJrINAJ0E5sNjQQAfXIKvyakW/aMx63piXgevGYJMV
         yErQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6MC4fhuzRpWOZbU62CMZSZF1CM5152bk+wp2TA9pHAKXxxsBFu+06lvIG1r2a3OXNbVhpz5fJ0mDRbvQXHTV3FFR7KYiHpUS2dOTo
X-Gm-Message-State: AOJu0Yxpvju+J1HnmWvUTwGOP4waHFV7pEDLQUgOed+bq95ZksAJSvSJ
	cYkGekGJuoMNVHuCdBXLdLtFd+ocGZ2HMLikmGIrmbDwmKr0XyM6
X-Google-Smtp-Source: AGHT+IHrFgZpRXqoAzk9BtvfWZNPXMchLJFCSJIeog7KtgF2ATaxkZ29qZ5ZagvPkkH19S/NyJWo/w==
X-Received: by 2002:a05:6a21:998f:b0:1b2:afc4:ff71 with SMTP id adf61e73a8af0-1b2b6b08f37mr5425937637.0.1717638461870;
        Wed, 05 Jun 2024 18:47:41 -0700 (PDT)
Received: from localhost.localdomain ([180.69.210.41])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c29c20d7f4sm281307a91.6.2024.06.05.18.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 18:47:41 -0700 (PDT)
From: JaeJoon Jung <rgbi3307@gmail.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: JaeJoon Jung <rgbi3307@gmail.com>,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] maple_tree: modified return type of mas_wr_store_entry()
Date: Thu,  6 Jun 2024 10:46:56 +0900
Message-Id: <20240606014656.7491-1-rgbi3307@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Since the return value of mas_wr_store_entry() is not used,
the return type can be changed to void.

Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
---
 lib/maple_tree.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 2d7d27e6ae3c..aa3a5df15b8e 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4203,31 +4203,28 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
  *
  * Return: The contents that was stored at the index.
  */
-static inline void *mas_wr_store_entry(struct ma_wr_state *wr_mas)
+static inline void mas_wr_store_entry(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
 
 	wr_mas->content = mas_start(mas);
 	if (mas_is_none(mas) || mas_is_ptr(mas)) {
 		mas_store_root(mas, wr_mas->entry);
-		return wr_mas->content;
+		return;
 	}
 
 	if (unlikely(!mas_wr_walk(wr_mas))) {
 		mas_wr_spanning_store(wr_mas);
-		return wr_mas->content;
+		return;
 	}
 
 	/* At this point, we are at the leaf node that needs to be altered. */
 	mas_wr_end_piv(wr_mas);
 	/* New root for a single pointer */
-	if (unlikely(!mas->index && mas->last == ULONG_MAX)) {
+	if (unlikely(!mas->index && mas->last == ULONG_MAX))
 		mas_new_root(mas, wr_mas->entry);
-		return wr_mas->content;
-	}
-
-	mas_wr_modify(wr_mas);
-	return wr_mas->content;
+	else
+		mas_wr_modify(wr_mas);
 }
 
 /**
-- 
2.17.1


