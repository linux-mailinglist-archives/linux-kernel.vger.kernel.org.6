Return-Path: <linux-kernel+bounces-510582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DF7A31F0D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62A587A3005
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B23202F76;
	Wed, 12 Feb 2025 06:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oYksgKIY"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C351FF7A9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 06:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341999; cv=none; b=f8mUHrWuEEi4qEXYERmY8rSmPYhg1UHg9L0rl7ndNrzBgnDvLM/t8B+2XFs6xzbRsb+qOeEHuPdZPnJnJN1ZwS46EfbprPQ77nUgzSBSTtqfTfqEqbtv6FtmYiDpKy6YUu0JAkG5tfIUGxH2aMogb+WBL+L3iAXOO7zmeQRjCO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341999; c=relaxed/simple;
	bh=9QiWxrTVWP0FfMG97AshhuEgBRDy8eLuQAYobyFch/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLTgP6iR77ykVUNya4DC4dDoi0Dzeqam/XNPnUo7eeDI5UHAakwkfB+DWaXsG0j7lLdtZqd1zUvtjowsDiN5hg2YKNT7LiQVqTAAp9O2nzDFntHgGgcSUA5l7cmBsY7SFbFWwA6/ab8rpYdQACXeEIlE5qWx8o3zQ5Vc/hFNiaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oYksgKIY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f44e7eae4so108475635ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739341997; x=1739946797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGWR8uwxFV58sLam3cHzynn2zEt595XLKCTA6OHBb4A=;
        b=oYksgKIYNCO/UBfxvt2D5HMQcEaGUpL2tKH/yoDvNCkDKW4dB55zzLDORN+2Z5Llox
         yY2e/1ZpeJTcn9j/xyx8p1VRDL7FtHr7tW7MCZYwmf6SThWb50nWJh49HCIHo6TMF8n7
         RTyaDwMQQARZCzu5oxxgrQGhLYp0apsz+omF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739341997; x=1739946797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGWR8uwxFV58sLam3cHzynn2zEt595XLKCTA6OHBb4A=;
        b=F0Yb4CFUySnQx24GYQZOYdqigjuuuyeWeDcZf3CzuIZXSO3qgMtP5FYY/Uad57b4LS
         3EMpACJap8/rB4J9JeGJa+9RSNCBUjA31trW0mvDEvfmGiS+OFI1+BML8CfEX7pBhCDQ
         B4DJA7RmA6fXY6oivFNMd6Pb01v80eRjic7ky/O5a4wFv3mzcPonRS/6IjJCyibw+Rdi
         R1ox+exIBeeQLBA9d+d+crqkbneADX+k7o3izIIve9DV2r1SYXkxbqNKlK3Uo3V+9Bki
         YvUXUICIyqJrHskNCMCjAak4JDRTrQCrvVcNP8aFntiVA67A7ctZRS9tCMrZ4yGZCl0n
         Sm5A==
X-Forwarded-Encrypted: i=1; AJvYcCVR70KVaOikYwYsYWrftM5uuTRLJD481XmmoNSPEPqgqm3zc8jn6a6J8airNvcgBaPMSTJJJixqjajCt3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfYzFO2zYv5JPWduyWiaOuwmWzo33yVPQ+ivtRiPdVFd9GlzSu
	hnox2ZEm+FYm28yK/+r4TOwbqyf/mBq7WCVtgarOB3bwQzxbZIrAvLEWakqG0w==
X-Gm-Gg: ASbGnctI2Z1NFVfn0js+tp3dcL0csV0V/Pmfo67UxL+y0z+ZbFsHky3sh8VwDNF86uz
	mLFS2t0w2EVv+1lsC/WWfACGns5uAqyurvOnGAFj6/CboST5rGiIeE9Gs4+s5A1BQTldTY8aJEV
	gp+D7z+qaPOKkGdqPeDKp6294+vGvHbLeHdUNbX4gWZqiUi1d+EAlT2f3gV6+8sAOlIiliR4IiO
	vplAGih9mtHlN67lhQXzAGkuxaoDliPtpMaRy5tg7cJX9kBtqyak+/k+k21SDsECnWcrKmB95kW
	TbtaBZJoY+E0aXA9gA==
X-Google-Smtp-Source: AGHT+IFzbH9qNa8XB8LsSRHPJwmV7Dgu2lkCSlxYEmJLzkmFDmA/w+WWTWaak6t0Xswa1OMVGZCLYg==
X-Received: by 2002:a05:6a20:728d:b0:1ee:6187:7fb3 with SMTP id adf61e73a8af0-1ee61878104mr1837250637.15.1739341997477;
        Tue, 11 Feb 2025 22:33:17 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:69f5:6852:451e:8142])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73218c206a6sm2581185b3a.49.2025.02.11.22.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 22:33:17 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v5 15/18] zram: permit reclaim in zstd custom allocator
Date: Wed, 12 Feb 2025 15:27:13 +0900
Message-ID: <20250212063153.179231-16-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250212063153.179231-1-senozhatsky@chromium.org>
References: <20250212063153.179231-1-senozhatsky@chromium.org>
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
 drivers/block/zram/backend_zstd.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 1184c0036f44..53431251ea62 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -24,19 +24,14 @@ struct zstd_params {
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
+	/* Technically this should not happen */
+	if (WARN_ON_ONCE(!preemptible()))
 		return kvzalloc(size, GFP_ATOMIC);
 
-	return kvzalloc(size, __GFP_KSWAPD_RECLAIM | __GFP_NOWARN);
+	return kvzalloc(size, GFP_NOIO | __GFP_NOWARN);
 }
 
 static void zstd_custom_free(void *opaque, void *address)
-- 
2.48.1.502.g6dc24dfdaf-goog


