Return-Path: <linux-kernel+bounces-262092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCCD93C0AB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E95E28115C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A68A1991D9;
	Thu, 25 Jul 2024 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Zl9Ts+f"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9E373440
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 11:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721906500; cv=none; b=HIAIiobvna2g/uFwBvVkPOd3Ax2cxdAlAZDCOn1q5XNWX1e4+jgRwiRi5vRVzKCSeXms8tpCAWHu6/OyiUlmBHg/ZyGx1NzpBWgTHaBcsIewdEkT9UyI4EdXGdz+Fu1PHY6uRdZNKKrOghZH1H+pBgv9MR8Vt0KAB9rvehVkH4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721906500; c=relaxed/simple;
	bh=bNK2Rdb+sbPRuTNNO52XZgJ4Mc01lVByhyX1fO2QeF0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IyKt/5dEwRpuksOzqA1sXpJTLiIvJB6T8U9GwGYG/1mnclR8N1iuy1fFC8Ad6qA7yucX2N7216xt8C5+792h4nQdxgZtr17ZW6q1xtUv+7o2NnKEORRvl5YSzRBqo4hQyxfJJvjq8r9EizA5rXK9I/nFoo7OrYIsBdnokUgVngM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Zl9Ts+f; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03623b24ddso1522312276.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 04:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721906497; x=1722511297; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qXxzvoTYw9Q90MrAUj707Lx9EKjgQYfFYb1jceR3KGg=;
        b=0Zl9Ts+fSbWO1FUZ3567/yfd/ctndC+3AwKo0fBVWiWBZkbJkcxVD4ouGQbSbPjFLg
         IUAp44XsgdjzxvcBLTwJzAcDuY/4szCX7ZrizV3JgPwkqxlqpmLyGJUWDbSIQXV6f/Nf
         +U+05stF8IP+CKmbfQ4aTvAgpJ5wJgXUtbwlXvGF50GKVO+l2FesQqu8FGbBE6BqiTxY
         3XYgYUOco7MEfWoLLKfuAkBbPr6v233F5f6vYIrdPa32uEJEowPq8C21cFyZefriAM2N
         gssYGJQinekv+ct0esnIJVMWxFxng4v0MDx3pyNT/gQeUd6rYR2s9iBergxQLX5ZTvd9
         ee3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721906498; x=1722511298;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qXxzvoTYw9Q90MrAUj707Lx9EKjgQYfFYb1jceR3KGg=;
        b=tMFKm9jUHF3FgKvQQ9nWSKV1zUVJQ/0enLqOPDZfox8YMSzVVgLVZHHatJ5qSqz16m
         hicHHDr22fgY5QpRss0f1iLWxBdOLu42PzZilEjzkrpSI1bXz9ApT0h+7pwJKgLmMruU
         RPNE/3aAUgifj+WhuEJeFclhULNDVDTc6Pye9km19mrer0UQaOSUvrSziizcahMF/0zs
         Co7inAPo0tzGLQbfvh50s+9RgEeOWJkFCyDfyyrns/Rd0LxpWXlJwULjnuFWEfV1JJqb
         mQZg9ufWxVTkZ8YXnm8q3uUtcI2ehbQe7mcwQtwSE6NeasgBojRzjncn84T1r00Z19+s
         FGOg==
X-Gm-Message-State: AOJu0Ywhp16IPHoWIeKdNGgJ022SZBoh5u9A2V6wfa9DvA6+z8r67IY+
	EhgxtYHHHsGqWiuaT/KRV6UHJNDqB53ZmxLpkqmm2MRzMqQc9yATlNxa5zdM7L8tMinPkhcWw0E
	912Se46ZAlQ==
X-Google-Smtp-Source: AGHT+IE1CuavMDLzmwhVhYdF9UUQwYY/6XMxw6XUx6aRr5wG/fcuPFq+V2QW03BkBTV4306145yRHHHAgNs+OQ==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a25:9381:0:b0:e03:6556:9fb5 with SMTP id
 3f1490d57ef6-e0b2cd60603mr3189276.11.1721906497626; Thu, 25 Jul 2024 04:21:37
 -0700 (PDT)
Date: Thu, 25 Jul 2024 11:21:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240725112126.415071-1-joychakr@google.com>
Subject: [PATCH] nvmem: core: WARN_ONCE on nvmem reg_read/write() returning
 positive values
From: Joy Chakraborty <joychakr@google.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-kernel@vger.kernel.org, Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"

Nvmem core currently expects 0 to be returned on successful read/write
and negative for failure from nvmem producers.
Warn incase any nvmem producer returns positive values which might
happen if any producer ends up returning the number of bytes read or
written.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/nvmem/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index e1ec3b7200d7..0a42e6a0e8bb 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -58,10 +58,13 @@ static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
 static int __nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
 			    void *val, size_t bytes)
 {
+	int ret = -EINVAL;
+
 	if (nvmem->reg_read)
-		return nvmem->reg_read(nvmem->priv, offset, val, bytes);
+		ret = nvmem->reg_read(nvmem->priv, offset, val, bytes);
 
-	return -EINVAL;
+	WARN_ONCE(ret > 0, "nvmem reg_read should not return positive value, please return 0 on success");
+	return ret;
 }
 
 static int __nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset,
@@ -73,6 +76,7 @@ static int __nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset,
 		gpiod_set_value_cansleep(nvmem->wp_gpio, 0);
 		ret = nvmem->reg_write(nvmem->priv, offset, val, bytes);
 		gpiod_set_value_cansleep(nvmem->wp_gpio, 1);
+		WARN_ONCE(ret > 0, "nvmem reg_write should not return positive value, please return 0 on success");
 		return ret;
 	}
 
-- 
2.45.2.1089.g2a221341d9-goog


