Return-Path: <linux-kernel+bounces-344118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB5E98A4A9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6B01F24EA0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A11191F8F;
	Mon, 30 Sep 2024 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="avUwoIvy"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80A6191F84
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727702376; cv=none; b=ntCP4s2VKVQAg8CLmgV5MlG8gu3wZGBGhEKTeZbiMGHsQRPWV1KmU0EdGDpFgb17HmChhRhCnUKjVoXqvMRgcjCeYiYu1TBkOuQnRffYNH6xHleFnClW97Eq8Jze8dKQoLeFKc8Oa+EHC9R0slcvwm9Bg76fU+ln9njo/VCItjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727702376; c=relaxed/simple;
	bh=qkJkSWDqHo7jC7vv0hNOivOzsRpZFuaQI5nALrxjD08=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=htmvxVGHggA+Ol6m6qeM/ec2nmR/2NoBtZKgX4MANQU4dBEu01gCRI6ph0oGpOsEXkxaCPT5a8AppO7qS7Kt6XulZ+onMvidrgRNxjK6aM3ngXfFCo3Ju4b2n6j/Y2x2Pgl3lT9wZj8xYVXUWzMrFgMEjatrkCg2tnfNWolPbAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=avUwoIvy; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-690404fd230so70491117b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 06:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727702374; x=1728307174; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=doWAxVN5J/L0Ed7YaNwkI39cvWlpAx52VjVcfHJc7OQ=;
        b=avUwoIvyUKhdinvDyXSbxUEwcvjLgEj83LPxgKXn56FWujSfu6sXCPcB9gqIqQkPkH
         E1xn4ZSVa5YlDc4s6vLLqB9Gh4DXENlbCpXvYzr1Z9vHQmGc1awAeItzulpjY/wezbbX
         BhnZ/TiH8Gq+T23UlR8jPjZbxwThXuUQhyHwcI1kHw9+jwAL7Swo6DyA8CWXlWTeF/nL
         ns2+zCl1w3pUf5ko4roJabHnQB8lVu4qANkOfHlm/CJE33chBkDfhNCsndfN8SXJy8Hr
         dK4B9eg8lAbMZUka60JJ7tCPfLU2afdFKDWwFmWacE84ZK5Odt8p8B2oVHb648Z73cpm
         vDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727702374; x=1728307174;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=doWAxVN5J/L0Ed7YaNwkI39cvWlpAx52VjVcfHJc7OQ=;
        b=LLCs4wmA5Bh4lD+5mlLYD5tkB4jVnZHERFwV8HRP/iJYB/ToRrmprp6ZlZQU3I5uqo
         p/2d6KUUA7WPoZtOvcyBoayMTGlmd3H1CFn43Yvj63C8FoDZdOBH5Zscf6VWiJ/NF2NI
         G1GyTkHQ7o1wJDB1nNNthk4ULVkWcwuulo0oS67PEqgEm+7qsSPvXUD93bwtPvbRDJFo
         zhdrF/eo327jYUcdpi1K70awUqrhE95pI/owApLYBXhrulCstxj85i/Hj7TbD4JM3Oon
         yOeCfbqo1V3ljz2jM7TyKm/slzVLe1BoDYbykpj3+a6I6nSf4Mri9KjGIBzjG/0CSYpa
         tQrQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3nqBHM+ghzn1rQF8OpltUrMXj6kQNyPY/NmPuvGJUo4S0Kbm6Uwh51GOvxzDjIP0t40uvkXvWxopc8x8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVoEpiKjptSVEVvcqEkBWqIBwBlt6N0O+yeLZc7diN2XCmpHmE
	3t1pK61ufakJx8HGOBrxiMIZLiQT/MQWUADzKG8GVkI8HFxZJxX8ECgzTrnZ+H4Qn8q48eSiNHk
	TXtif5+1UpdouxQ==
X-Google-Smtp-Source: AGHT+IGPdgpJibr1yfp0X0+jCemoXxyx7N8akB5Pv3w4awlEs6zaJwawSxTtkIdxIhQuk7RIRN/1nZ+2AQnkTIw=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:67c7:b0:6d4:d6de:3e35 with SMTP
 id 00721157ae682-6e2475d39d8mr1073677b3.8.1727702373743; Mon, 30 Sep 2024
 06:19:33 -0700 (PDT)
Date: Mon, 30 Sep 2024 13:19:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2608; i=aliceryhl@google.com;
 h=from:subject; bh=qkJkSWDqHo7jC7vv0hNOivOzsRpZFuaQI5nALrxjD08=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBm+qTRv6lr2h6hJjTCYXUhWOzjlbFE2QW4rMqor
 4r+Yf4XSdCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZvqk0QAKCRAEWL7uWMY5
 RgooD/4xXLmdo+ytpDkC6yKYeUiuk+LHKaEYur6l95hgEs9scy357uIsll0p5wkGJ6St1FXnjmr
 zF8aR42eWfotFNK2URseQR/Z9SftbSXn3rn09iEM2E+hIM/uK+vjF8GvGXMmrzTPaXmrjcKCatR
 /GhYfHCsoFegd8y/bHUABjkdIeUhBYoGGaqdJ7xycuRpYz+BUJ+2BydT8dZRv+ZuRB5zYK5Rm1b
 H4GqbBJxtwkbh07wE2Xi3Y22c3MohQ+XWGsakBeMqQfvb2OXORSRR8HuDFf7y2a3wg9dQR4V6d5
 XL9epWfyGAsG392Wiedd3b5IaKFNz1pLGsyzSFDdbqESXTTkMZxuPfYo9ZyR7VUnss3kGLOVEec
 Pj+Q/xQLlRX23IFhsuz/j8icsK44bN9Y2td972HXSW23TPbWM9Ej+9t9OAaX8TdELvuwtNUPdF6
 2kuMW8+TIJP2Rdn2B6TURD5qOGV3Htpvuv/CgraUthXNppiTR21cLK50Oh86nUrsRBG9H4+TtXO
 gXPRVGLXpxr9hKhFN10FM2mrRpjUkTRXyYWUlGsl8aIb4EEOel+ky5u2gGPJd+YU5UaX3hxdSAC
 ivfSQMglALtu+gPTqk0qwJ7gvtocvqje/h4J++kJRVRISfosKeZMsXwxAVa6YL5+CIrz20liX/H e6RDoxBZ7t2hJKA==
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240930131929.1424352-1-aliceryhl@google.com>
Subject: [PATCH RESEND] xarray: document that xa_alloc uses the smallest index
From: Alice Ryhl <aliceryhl@google.com>
To: Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"

The deprecated IDR data structure was used to allocate *small* ids for
things, and the property that the ids are small is often desireable for
various reasons. However, the IDR interface is deprecated in favor of
XArray.

Clarify that when replacing IDR with XArray, you do not give up the
guarantee that the generated ids are small, even if you use a very large
range such as xa_limit_32b.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Sent previously here:
https://lore.kernel.org/all/20240201084739.1452854-1-aliceryhl@google.com/

 include/linux/xarray.h | 6 ++++++
 lib/xarray.c           | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 0b618ec04115..b525113d8d47 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -860,6 +860,8 @@ static inline int __must_check xa_insert_irq(struct xarray *xa,
  * stores the index into the @id pointer, then stores the entry at
  * that index.  A concurrent lookup will not see an uninitialised @id.
  *
+ * Always allocates the entry at the smallest possible index.
+ *
  * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC set
  * in xa_init_flags().
  *
@@ -893,6 +895,8 @@ static inline __must_check int xa_alloc(struct xarray *xa, u32 *id,
  * stores the index into the @id pointer, then stores the entry at
  * that index.  A concurrent lookup will not see an uninitialised @id.
  *
+ * Always allocates the entry at the smallest possible index.
+ *
  * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC set
  * in xa_init_flags().
  *
@@ -926,6 +930,8 @@ static inline int __must_check xa_alloc_bh(struct xarray *xa, u32 *id,
  * stores the index into the @id pointer, then stores the entry at
  * that index.  A concurrent lookup will not see an uninitialised @id.
  *
+ * Always allocates the entry at the smallest possible index.
+ *
  * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC set
  * in xa_init_flags().
  *
diff --git a/lib/xarray.c b/lib/xarray.c
index 32d4bac8c94c..f0579aa37534 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1831,6 +1831,8 @@ EXPORT_SYMBOL(xa_get_order);
  * stores the index into the @id pointer, then stores the entry at
  * that index.  A concurrent lookup will not see an uninitialised @id.
  *
+ * Always allocates the entry at the smallest possible index.
+ *
  * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC set
  * in xa_init_flags().
  *
-- 
2.46.1.824.gd892dcdcdd-goog


