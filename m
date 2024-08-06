Return-Path: <linux-kernel+bounces-275512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5B49486B0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432661F23D62
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 00:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E518C09;
	Tue,  6 Aug 2024 00:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCFMoQIJ"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A280879C0
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 00:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722905122; cv=none; b=Iw7JVYpG68KNfDWjRJtjGVZP3s73h95LsYmwniveTCfUPfZWPwtdqfqmPqFxQDNPdj9QjQqnswSziDSG8S54TPgF4PP57HRZgHeMBWLXy7jr0S0ftChNoQG+7UhnGd4UFA5lCxLRwnMdBYp4kmNaVLR2ZQzy/1QRCx/QWYEtpeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722905122; c=relaxed/simple;
	bh=6C/fTNhPHhkUTQdoDQrJjS8z9bO+T0i8xzItOP2C5lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ITkknpINFQEI4OHD3nakU6O5nlyY74M6U7c0Opno1n3GIsRHFzvVLiJMIbbSlAW/05Flk20yyAhKERCOzFE3SI/RonQbPqbz5Yi5848Oih1N8u+ca5PXzPsKgC0GYMZBf0ckk5kai6rF6XeAJeUCkt9t0rk26WGYy0pIr3F/7jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCFMoQIJ; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6694b50a937so874047b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 17:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722905119; x=1723509919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f24byKXBsDdCoUziB9qpsoPdrCNk3SpbbSe3cKaZfUE=;
        b=jCFMoQIJ39Bw9Z226TgkwFryI/j+Cb0j7O//xP7zZmKt9DA5fjDMNljnmioLT/4KhD
         nAZ2EmKamXkBnDjyBDDfmBa+WF6HBVKF43akOTBZGL0wOTib0o4JvwLxjfxsoozHk4Cr
         8oGxdvyPyecfnN1JE3nVhJ0ayzhbxWd+nFmv5+iXnwDk7DrAh8PE/75abWEl3xyRwp9X
         M7/MLU5UckA2oEoJ3vgR7JBWUq6MF4m5de7G9ORMl4y2AIKagA5c+dQXGWWZBnOs8vU0
         TPnG+Jphm9JwM30n54niox2sj59YreTgOXaX0ay5o5wz7GEo/R2DrosKxfmC8zcuozhb
         HHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722905119; x=1723509919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f24byKXBsDdCoUziB9qpsoPdrCNk3SpbbSe3cKaZfUE=;
        b=VTeJ18UBKID5L8M1zNkHFh/T+1g2LxrEViHwYU+llCv4WxPh/WqetwvEBI7Oe8aQ1v
         3uCAtrdrxxmeGyMjeeSDSFYr2DlxNBE2ttMpHII9AWxaJZ7hvPvcVuRVSsJt92+6es33
         Tpi9HkcHkVVNtCiCiJYMbf97nhSovwNWKSMhvD6vYfBRzYS4HKHp4TGPp2YwyKV++/5O
         7Nzl3W529hdic1HsXA00CcZ0NpNnthUw03fyBgmza/D6PzAcTvFZKJWe4ez/QB0YwamW
         InbMXxKcf8jJ3b7lim+ESrLf3luMW0ejYqfjNkk+9xN396FmwgqX2Ds1PFkY+2nBpX6M
         NH6w==
X-Forwarded-Encrypted: i=1; AJvYcCXnvjqi4Xq6nXLx2ktiPDIFoRz840rTTQEV2Sxcv0M7csE7gePU0XUGUV+b4iB4m2eZV2ZIZQ+WAVKvQmCTzgK8gblguOZ9OeqZieFv
X-Gm-Message-State: AOJu0YzJWAxpZGo2KGoc9ISjSsU5LPgT2lcdzr7sbCpbPScqXNQTjXac
	khDN4ulGXQDUbY2j6c9oLiG66QdRY8PHBC2DSjfTrlMrtOd6gkDa
X-Google-Smtp-Source: AGHT+IF72PxGyYKZU1R2KLVxeLyw0kVXVNki+xiuoaf/qeGWyE98VmgZ8Qgl8Mg9GbrUKkWIdbm3vg==
X-Received: by 2002:a81:9e0d:0:b0:631:78a1:baf with SMTP id 00721157ae682-6895f60d528mr143494237b3.6.1722905119522;
        Mon, 05 Aug 2024 17:45:19 -0700 (PDT)
Received: from localhost (fwdproxy-nha-116.fbsv.net. [2a03:2880:25ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a0fdb3c2csm13912147b3.47.2024.08.05.17.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 17:45:19 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	shakeel.butt@linux.dev,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	flintglass@gmail.com,
	chengming.zhou@linux.dev
Subject: [PATCH v3 2/2] zswap: track swapins from disk more accurately (fix)
Date: Mon,  5 Aug 2024 17:45:18 -0700
Message-ID: <20240806004518.3183562-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805232243.2896283-3-nphamcs@gmail.com>
References: <20240805232243.2896283-3-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Squeeze a comment into a single line.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/page_io.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 0004c9fbf7e8..aa190e3cb050 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -524,9 +524,7 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 		goto finish;
 	}
 
-	/*
-	 * We have to read the page from slower devices. Increase zswap protection.
-	 */
+	/* We have to read from slower devices. Increase zswap protection. */
 	zswap_folio_swapin(folio);
 
 	if (data_race(sis->flags & SWP_FS_OPS)) {
-- 
2.43.0

