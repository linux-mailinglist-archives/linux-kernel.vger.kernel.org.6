Return-Path: <linux-kernel+bounces-176797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39AB8C3524
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 07:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526A8281DB8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 05:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BE6EEC5;
	Sun, 12 May 2024 05:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlQPj66X"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672F6DDD7
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 05:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715492629; cv=none; b=D0DmTe49q+l+e0RiIDKxQKB7s7pefPUEOPKw1AdmZm8ewrVAbsApjN36eF3Z4u7PzKj6N01Wem+RQVw2/hA9acQZSSlctGeuWyh7VBG4+5BzcaNhbYrW2+YLo8hK5lg7Ma+Dbn/ke9atiYNM+oBWYHDM9AecXN6iMHD+REofVkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715492629; c=relaxed/simple;
	bh=E+9laLy9ncR2FoTfsHxV8k8cs1shCthevxLq04fINJs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kNuUczFWTfOZRNMQxfFbzDgpLcGWsnX74N3177e+kcjhd360oyUXCvEquoHgLIVqTbyJRV/p6d1NNg1CLYgIUXRp4JOIgADV8BfO7s4z5adNNesYiU/vfK7WnEd83RmK7Vj9qIAlmZ0vGnYJSY/p0zktuXrcsuZ0Q8bU53Ijbz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlQPj66X; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2b27eec1eb1so2649606a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 22:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715492627; x=1716097427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C7W5FzDsqNNuPa7W+dhU1RB6HY7xI6xf4dtlomIXXh8=;
        b=WlQPj66XY6JMKgqDjDUXMFaIHor3PJolS30mPsD9Ac/jqwi1VWQJa/Ov8hbrd2FM15
         4g/18riXOHTuLyGo3iH8Qy7+MRD4xyxSI+3FlH3FyQqCfKejmbUvf6aqI0QaR4SYakEG
         4WfXnw+4vYDgK0q4Di7UCUydvMKVKL9D8LQuFVkc4GQFDoAwFXOMmiDhkkiD2pQy4mc2
         sGC6AUPVZ7d/kMXSrMpNRCfBGjDuQMmWCKg+9dgffbQij0UvHdO6Mw7mJiUbVhYKb3i8
         qN8lQFKqx6MXvMTwoOQRcZFwwzV/WeXi/awHttSx8UJcjZBCEd1zOQL5OqDFae/rNaBb
         wTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715492627; x=1716097427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C7W5FzDsqNNuPa7W+dhU1RB6HY7xI6xf4dtlomIXXh8=;
        b=kYPn7WGazpOY4Oh0pvU5kINGjW8LMKMAy3IEVPRlDNFmBvtOy5OjDS5DOX2553P2Mh
         VEeSi6UmSsAo1r0LZ/hwfx1GFKKPvwCxZIWWpGLh+PaWggLl9ychvJMYyyaBfEapswKr
         fy0UUB2E0XWYr3oUKoJxlDZcl/16qGcYe5RC0APEjBTmQ62Khq2ycjEM4IC18L8m+Nq4
         Y1zoii3qK6PzJprlx8OEtHf+4z02JfXIY0iBLa8voXyIxjtmPvZTicju+6LYhx4ucwl2
         /ufUg+NUO6YqZSw0gcksbE1uROasovWo7ROqe6ATvuy79sxlFgxgs4MH0Piw736WUxXm
         qKiw==
X-Gm-Message-State: AOJu0YyaayF0JIHGoX4/8ZAGtTQSLody5JO7DW1qRNm2Fq4jWNY2G54j
	A+cE+S1mpRUoeuJ+DTLipXDJgkinR4iVUAVQf9Z1Eba3qtMS3KeH3nRo2Q==
X-Google-Smtp-Source: AGHT+IE4c4X4Tp3180BBWcRr4+bFDZSrBVDW3NE3Vqd6h+4iJF90D1DMg/v9m3mFGilbn3Ny6manjA==
X-Received: by 2002:a17:902:e546:b0:1e2:6d57:c1bb with SMTP id d9443c01a7336-1ef43d1864dmr97866935ad.21.1715492627483;
        Sat, 11 May 2024 22:43:47 -0700 (PDT)
Received: from localhost.localdomain (111-254-41-215.dynamic-ip.hinet.net. [111.254.41.215])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad634asm57203135ad.87.2024.05.11.22.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 22:43:47 -0700 (PDT)
From: Wei-Hsin Yeh <weihsinyeh168@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Wei-Hsin Yeh <weihsinyeh168@gmail.com>
Subject: [PATCH] tools: Fix typo
Date: Sun, 12 May 2024 13:42:11 +0800
Message-Id: <20240512054211.24726-1-weihsinyeh168@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop one '-' to adhere to coding style.
Replace 'arbitray' with 'arbitrary'.

Signed-off-by: Wei-Hsin Yeh <weihsinyeh168@gmail.com>
---
 include/linux/jhash.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/jhash.h b/include/linux/jhash.h
index ab7f8c152..fa26a2dd3 100644
--- a/include/linux/jhash.h
+++ b/include/linux/jhash.h
@@ -31,7 +31,7 @@
 /* Mask the hash value, i.e (value & jhash_mask(n)) instead of (value % n) */
 #define jhash_mask(n)   (jhash_size(n)-1)
 
-/* __jhash_mix -- mix 3 32-bit values reversibly. */
+/* __jhash_mix - mix 3 32-bit values reversibly. */
 #define __jhash_mix(a, b, c)			\
 {						\
 	a -= c;  a ^= rol32(c, 4);  c += b;	\
@@ -60,7 +60,7 @@
 /* jhash - hash an arbitrary key
  * @k: sequence of bytes as key
  * @length: the length of the key
- * @initval: the previous hash, or an arbitray value
+ * @initval: the previous hash, or an arbitrary value
  *
  * The generic version, hashes an arbitrary sequence of bytes.
  * No alignment or length assumptions are made about the input key.
@@ -110,7 +110,7 @@ static inline u32 jhash(const void *key, u32 length, u32 initval)
 /* jhash2 - hash an array of u32's
  * @k: the key which must be an array of u32's
  * @length: the number of u32's in the key
- * @initval: the previous hash, or an arbitray value
+ * @initval: the previous hash, or an arbitrary value
  *
  * Returns the hash value of the key.
  */
-- 
2.25.1


