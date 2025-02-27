Return-Path: <linux-kernel+bounces-535587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F143A474D3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9DCF1887B96
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DDF1F584C;
	Thu, 27 Feb 2025 04:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HQ5csPYx"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA7222E3E1
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631082; cv=none; b=uweDJveRSS/OgFk8xOnwN2XHuZmqmyN+sypUQ7EbMz6Ayujm2CRK7M2XuV6QjemZMvdZNFOVOHfwiMA6EFGJvQZ8TEyup9p59TYVlw4qeHSXAPfHOmDlmfwBLdH8s2tk9WrQufguT/LWc8/SXo8nHyMleN7m9IbpGxBWjIi9UyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631082; c=relaxed/simple;
	bh=K0rPiG252rZQIexLl37iIDHUBgLaUhjfUVSvoH/f+bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oG/Cfaj/bMdQ6zQHNB1u6CG1HHONbBK1taQnr5LHfsa/wC2jJyMVhQkW2Z0lWL4028EBuYzLpU4PotYZaNtCBhZe2XTrJoHG3UmM2hHGmFASCyEf6BvwS2Z3D1hl5vlt8QCQYeu9JTiU1d5avGiVpuRGuHfACCHhtcJqkNg+Rv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HQ5csPYx; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-222e8d07dc6so9974155ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740631080; x=1741235880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vuEfNhU6ZAruk6qIF6JGw0mo2a915MB6BnSqH9CQes=;
        b=HQ5csPYxIFt5J/1Sappl8cXhjYWhL98FF4Ss2VhRYerYnsoQmofZgsMF5nznRHwjzU
         +gUljwZKhY/BD/ijv6Hd4ZHNqdnM1o5tEvxIS4WhDhhCFMY1Z2dHrU/0yMmb6t66ugUG
         wH56S5umOseji++o8rPuasPOIzsRRyRV3Ko3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631080; x=1741235880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vuEfNhU6ZAruk6qIF6JGw0mo2a915MB6BnSqH9CQes=;
        b=iZxbn+ojrwt7ya5tB9G0alYitqGOkZ51tOk/4aOVKnP9kZh6yQJdimW1d+q6y0hghW
         4XZONxjzBJt5ESKZQSF09+A5xMHK4x8OK2xIFHPjeHyahH1pVekwiCq30ByU9t3p3scG
         5pku4XQPl7F7Uac7YVWXSetb5ShUnZJ6HUJ3MMOxOEBtz8bnrWwKkM485v2niSb6B28J
         H0r4EFAn0UXSSMWPFNGGFTR/hJ0iTJiWkULVpHXIKV2TrTEeZ8PQhlj2bfGqKIWVfYak
         uNceytsPahlAycLf1jTo325Q/yqnlURB3GlrKnHM3v5L4hqPiyg+zQx5Zgtlxnzbnapg
         UZ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUs6xeBTnJ0LoBwmzQT4UknYw1LRp/64j5AqbMs3j9He8kc/k5k4HAcbstCnGfN3+hk+DwTHYix40nRSCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJCzJrK0JR1iLex2RfwV59okJMklWAmuCETxsb0doskKkO9Cw+
	wUFfjpHIg33lDF9J0+P2Gdeo8IF0PKEyL1jMcAmDFiEzkxlfxv1+de2XCiqLGQ==
X-Gm-Gg: ASbGnctGl5vVTQ9t8uheo7ihdofYCRDG70/iucPAaqD2oIWZ8KaTWWq85+W4vIb21F8
	/+Y/3QApuzHilspotBgMIBdvvdYgu0Kud4+9sYPZQjXJ7mL9iK6W/dr0rJ6KANpZzyuRPsUGvz+
	UG/Bjmv/vrwq54HM/C/4bG0iV2u6MjUYp/DZSv9yiJbRGLTgCr2rlmUfAiV/vnEfWzLZwiX5u3x
	i7uN8mmk1xC6qAql0WSTDAybhVBv5C8wlfQR8LqGMR+wvL3xS1FFbJxEtpL4hMTnJ5ASx8Lyp2f
	LYMFK1rRknYkACH9u+CHxCoOuMlO
X-Google-Smtp-Source: AGHT+IEe2V/zeMcvZORXlCVMsgDJF6cKsc0Tcc+m2RnLoDmlcE2u9VnCp5uqjB7GRbUjo0EoaqQNIQ==
X-Received: by 2002:a17:902:e752:b0:215:a303:24e9 with SMTP id d9443c01a7336-2234a1649d0mr25953335ad.3.1740631079813;
        Wed, 26 Feb 2025 20:37:59 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:a9c0:1bc1:74e3:3e31])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22350533a10sm4886515ad.247.2025.02.26.20.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 20:37:59 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v9 16/19] zram: permit reclaim in zstd custom allocator
Date: Thu, 27 Feb 2025 13:35:34 +0900
Message-ID: <20250227043618.88380-17-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250227043618.88380-1-senozhatsky@chromium.org>
References: <20250227043618.88380-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When configured with pre-trained compression/decompression
dictionary support, zstd requires custom memory allocator,
which it calls internally from compression()/decompression()
routines.  That means allocation from atomic context (either
under entry spin-lock, or per-CPU local-lock or both).  Now,
with non-atomic zram read()/write(), those limitations are
relaxed and we can allow direct and indirect reclaim.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_zstd.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 1184c0036f44..22c8067536f3 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -24,19 +24,10 @@ struct zstd_params {
 /*
  * For C/D dictionaries we need to provide zstd with zstd_custom_mem,
  * which zstd uses internally to allocate/free memory when needed.
- *
- * This means that allocator.customAlloc() can be called from zcomp_compress()
- * under local-lock (per-CPU compression stream), in which case we must use
- * GFP_ATOMIC.
- *
- * Another complication here is that we can be configured as a swap device.
  */
 static void *zstd_custom_alloc(void *opaque, size_t size)
 {
-	if (!preemptible())
-		return kvzalloc(size, GFP_ATOMIC);
-
-	return kvzalloc(size, __GFP_KSWAPD_RECLAIM | __GFP_NOWARN);
+	return kvzalloc(size, GFP_NOIO | __GFP_NOWARN);
 }
 
 static void zstd_custom_free(void *opaque, void *address)
-- 
2.48.1.658.g4767266eb4-goog


