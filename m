Return-Path: <linux-kernel+bounces-235324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F7691D3B9
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4648B20C82
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 20:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7572513D2A2;
	Sun, 30 Jun 2024 20:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="oqf55MEZ"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15FE42076
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719777805; cv=none; b=UQZ/KTgEbGPOoXOpJo76KJtjJlgVAwJEifR9+tIjNO9cow4rTeJ3/U27qtiKe7b/lx4d5vMjWUxg8KFaZvkmjG+csRYDO8/+e3FpTd/YsFmHiEFlT6tBaAA9fu9ezZjDwWZEDY1pNE/I86PRex6xCp585LrQWyF1JbETQZSWQtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719777805; c=relaxed/simple;
	bh=h7lfA5uZt7r7J5mHUef+QF5PBro74mNzq8Wqvr4OTrM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M0a8MWq3TBFJqM2PfPhzyK1fvM32ry4wQO/wz7iEMSZ8fZh3zZu2r2gnWhXUQ9IqmzpLPqdF4GYjR+ljrCA4BaRobMX5KLu9PHHpKEIpoKCtG91+lcqsdmNrubOzOdjVFUVsKZtAMPr+TQdmEZOx2LSVv+d+gs1uWhGmHNLhoQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=oqf55MEZ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52ce674da85so2507957e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 13:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1719777802; x=1720382602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h9Q37mPUVdBsBv0LJEdyyFRm6NNx0RFflJVqcxR/aA8=;
        b=oqf55MEZB0kTSmDreY01q4LJ+l1b5Pq/ySAJGzWI8zVrUA+8AlOXfrCJ/A+S5CeM61
         u5V9HhQFnEgH2KxbYVgFXsBMrJKhyHu7VBBb7XeeD2pQ6/HW7n+WM1q1yqvtv6q2kK3V
         npkFhvncZUW4KO2XTqBBmYr+tIPsstIf/345E70cB/4zs3aEAjWVN1RHHHAKiIZTij3d
         bTcPlfX2L8UoO7Dovl3nafvVhPAzQdjwBFcDdYmkiPrO3dozXbzbZtjsiBQ2vmtuBnp5
         RRmdVR4Sz7Ht4oPeY294Az9hybcGDScHVS5dMRBzkRT7n59Q5nGXW7OrIY+JYUVGpPk4
         +AQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719777802; x=1720382602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h9Q37mPUVdBsBv0LJEdyyFRm6NNx0RFflJVqcxR/aA8=;
        b=rOL8zPNPAvRXAzCpiDgqN2GDWCwsA1NeSyOPZoDqBQa5320gv0fU/hztNdh5M0fAmT
         rk+3UHpAuavbuBoeqRu8mAkRkpR+Mdjz0ZTA9QNz3olWenFcg5Vf3uzrohKan2jJn0Dm
         caC5lcCA8JQSJMjnEh9kWiDyrE2p2lTIt7LBLpa1BAx3uFa/rgxu8IJ1rnBYblYdQvQc
         SJZBrLo8wHrkV2POUFZsSaqSzneE7g/CZ47U6gOWu9t7dmkMaWPQ40o3ezeZj6JE84i1
         QghHP30A0gkq76cZtPbzvr0MTrZf+HBaCE+mTZEKzLDoH2x37x7izy3N893EZuszDYgx
         JIHg==
X-Forwarded-Encrypted: i=1; AJvYcCU7rz+4Dbxz6rzaJNMgNLZ8QpBdxRAAtsP+RN6ux4tAb8f0h6+a6RCGc3JRtxeSffE7IvuuEH9e7gdS0IuCDuQT+HIQOnBzLHIuRTqH
X-Gm-Message-State: AOJu0YwudTTnKgiLmKVJdDKiKcsNDkwLrJr6OnixMY9AxKYpphOij/6v
	BLT4D98zeLTdVuYooEsBIdpTTqV/qJVzA6g0LGZEKZWpZLELU7PZTuPbDhHqj7U=
X-Google-Smtp-Source: AGHT+IGLuFPND9+lxrsUs5OxPlGkQAa4aYt3z0F4qwrAZa7oG4zAzGA+l/Q6P/IRByMCuqP0cMmjOA==
X-Received: by 2002:a19:8c14:0:b0:52c:dd3d:85af with SMTP id 2adb3069b0e04-52e82671e7bmr2213301e87.25.1719777801879;
        Sun, 30 Jun 2024 13:03:21 -0700 (PDT)
Received: from debian.vc.shawcable.net. ([5.180.61.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf628cbsm266752466b.57.2024.06.30.13.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 13:03:21 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: elver@google.com,
	dvyukov@google.com
Cc: kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	David.Laight@ACULAB.COM,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH v3] kcsan: Use min() to fix Coccinelle warning
Date: Sun, 30 Jun 2024 22:01:37 +0200
Message-Id: <20240630200135.224108-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following Coccinelle/coccicheck warning reported by
minmax.cocci:

  WARNING opportunity for min()

Use size_t instead of int for the result of min().

Compile-tested with CONFIG_KCSAN=y.

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Add const and remove redundant parentheses as suggested by Marco Elver
- Link to v1: https://lore.kernel.org/linux-kernel/20240623220606.134718-2-thorsten.blum@toblux.com/

Changes in v3:
- Remove const again after feedback from David Laight
- Link to v2: https://lore.kernel.org/linux-kernel/20240624175727.88012-2-thorsten.blum@toblux.com/
---
 kernel/kcsan/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 1d1d1b0e4248..6863c67b058e 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -225,7 +225,7 @@ debugfs_write(struct file *file, const char __user *buf, size_t count, loff_t *o
 {
 	char kbuf[KSYM_NAME_LEN];
 	char *arg;
-	int read_len = count < (sizeof(kbuf) - 1) ? count : (sizeof(kbuf) - 1);
+	size_t read_len = min(count, sizeof(kbuf) - 1);
 
 	if (copy_from_user(kbuf, buf, read_len))
 		return -EFAULT;
-- 
2.39.2


