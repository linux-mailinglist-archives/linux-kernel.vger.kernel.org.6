Return-Path: <linux-kernel+bounces-310285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD997967773
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 18:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B8E1B212F6
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 16:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EC7183CB4;
	Sun,  1 Sep 2024 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="pNt2hVpf"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F342C1B4
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725207588; cv=none; b=rceGZmcqevALaeHNP7yvdEs/wehBxwimF49Um6WmuBYTLEZT/MieKqawH/s81ul20AeLvAfNeG7tQSkZfX9AHvEm7OIU2SJE8vpHKx4qoaIatmvH29GZrvYH95taEzxXmXuxU4ISFufR6ABmvEi+Mp9/7R3T4k+L+v4icL6Itlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725207588; c=relaxed/simple;
	bh=lm9tjfZQgsoefmrIiw7t02owl3uvWdL/KtvHtx5V6L0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kJj0lYXODz7LD1lLMHc62oc8SS5fcTk1a2T5EV3R0bKzybRD38z7VeyhvpyQJ9j231yDao6/FXIELOxZl6uHI1vkLPGy+Cje8qrqMcOMGDm7qWnPatyI/HpDn6A+1/cvTtFNY7uWHKbU0yw4kIVru4tQVcNJbixRDfyrTRuZlR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=pNt2hVpf; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a86696b29d8so15251366b.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 09:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1725207585; x=1725812385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nI3i22KwgZnkUxlnZb1O9ZWeCUJAdA3POKLSePBt0ZQ=;
        b=pNt2hVpfI9IIwwgyX3xdxQL6m3KuAhYZ2Q88kaR4DIsVkq0Zk2/lj4eppREUoiLaLf
         X+UDCHsXe1aPjaYHeyKdxrsw1NiMxow/zrP4vBeq2TkwEXQTHPMZfFgkpEW37g9CX0fk
         LhtSie3q2DhwRhSyUzAGSb9oX4kMOIMFHOo4c8ce4AiJLxHgIde4piDxtmLO/SYD0Y7w
         bmBC1Jhf4NI98JeKwrAJvQ8fwXoTnR2jiKG7L88Mj0oEkhQNS+faEFQ0r3EI2mahyNyA
         4GRTEYRI2GGKSZAWM6TSD2i9M1ZLzLZRs3kY0byi66DMylsxeD5ayTEjVWVESSzM9MlA
         f5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725207585; x=1725812385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nI3i22KwgZnkUxlnZb1O9ZWeCUJAdA3POKLSePBt0ZQ=;
        b=Z3rGzCyNT9/RJl/4khftNynFzFbN5ZtGVaueTVn4fd2aXjRRsJ2BvIUlZbJnHd9Jax
         klSMAO9eUoBYIyUY5wljb7KElnEPI7UnfYNB+wXwG0WWffkw/4y3+UyjuO6cnX6IyiB9
         Ms3Il/OQKIyZxaZTqn7EpwSoGk+qLAbj2KzQn6J9Wex9Qt0XI5zRp6GA8O+XpvbAaHXq
         Tx6TzZiakMy2LAS95A4e6B4ZBePQQBO7cXQJJVpTFPK71d+7beBvLkAt6dU362XgmHgK
         MZh8Mrqvf29jDabA1t1bGLxdk03A72vR+bLseXJOVwQRrCNZ5Lxyu/x3ko2zcWW3XyCv
         8Hbw==
X-Forwarded-Encrypted: i=1; AJvYcCUfiqmbyLMzy3JWY4R2GPdDk8yXmrZoYgVB+59wBeZwlB2SZ+UWo6yXSppw9pAUNNVdZX2kIx/PmgSN2W4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJY9IsAor3WZHF283GxILzRaRF/GeePLPzK9UooZPKqPbIdkdS
	DTaJ9E58YokLrw+JEf1bf4VMa7ZijJDRs0YHtvP1bNO1bByPqW0coFZ5Wqtv0is=
X-Google-Smtp-Source: AGHT+IHZK+KvAvt2qU4ICz3naVrtnFtg1vdPvWBd8nYL3wdzd/2eDU2Z1MeJDIAdEOTr2tVvU9FRcQ==
X-Received: by 2002:a17:907:3f0b:b0:a80:f54c:ad68 with SMTP id a640c23a62f3a-a89a34743f5mr307002766b.2.1725207584554;
        Sun, 01 Sep 2024 09:19:44 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-228.dynamic.mnet-online.de. [82.135.80.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89892164f5sm450365866b.192.2024.09.01.09.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 09:19:44 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Benjamin Coddington <bcodding@redhat.com>
Subject: [RESEND PATCH] nfs: Remove unnecessary NULL check before kfree()
Date: Sun,  1 Sep 2024 18:19:13 +0200
Message-ID: <20240901161912.117045-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since kfree() already checks if its argument is NULL, an additional
check before calling kfree() is unnecessary and can be removed.

Remove it and thus also the following Coccinelle/coccicheck warning
reported by ifnullfree.cocci:

  WARNING: NULL check before some freeing functions is not needed

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/nfs/read.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index a6103333b666..81bd1b9aba17 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -48,8 +48,7 @@ static struct nfs_pgio_header *nfs_readhdr_alloc(void)
 
 static void nfs_readhdr_free(struct nfs_pgio_header *rhdr)
 {
-	if (rhdr->res.scratch != NULL)
-		kfree(rhdr->res.scratch);
+	kfree(rhdr->res.scratch);
 	kmem_cache_free(nfs_rdata_cachep, rhdr);
 }
 
-- 
2.46.0


