Return-Path: <linux-kernel+bounces-403254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCD79C3328
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 16:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54ADF2812F9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 15:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A6213C3C2;
	Sun, 10 Nov 2024 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ARRTGlBZ"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD461369BC
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731252562; cv=none; b=k7OEnW7qqIX5ar8aGPcUCyOh6/rceoS64JKxoBKfNLBwG0IABWQF6bVuGv9iaBjG+A2UNFZuKSSJFrp4095hvBsh8iouhpHI3mObKGjrcVykFL3QKEy77/4u4Cg4S3RVisk2epV7/xRUlNMbmzybL/cLtsZ/uOEx365FvJoQ/BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731252562; c=relaxed/simple;
	bh=AFLrZl3fH+/hMhwZTjgZ0OWM0ndgzDi220n1zUDQffQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBAh30OH2l+fiWXiTk83FMK+TKGQgv0/xz46TVKUZfMJny5lCPodkz/KWVZZaYz2BQs0tvYNBM9Bp0tct5OxJvAzk9WVxi8RO/dUOHedGX3D7WMCKrcv0iFx+Da8EkjA/0SyZZf4de3TsKVgT/Pz21A2ayDtcNBsOPlmnXzC9aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ARRTGlBZ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e91403950dso2822713a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 07:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731252559; x=1731857359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvfAlDie45/dO/q2Oa4nMUlSYRbUQddnQckYeJvFoiA=;
        b=ARRTGlBZxa5PHUsy9Q2tvu9pwq5hBq6iX1QXmL76/dMi8cd4bCAVhakos3YMhFgzxM
         8L0F5BfA/KXHRhfZ+5fXXW3wO+YH7oZiJbghZtvvdOF1Zg0dWlXnAQOckFK6uHIOrq3z
         3NMgg2Uk3HgKDmBEeCB/W4yVCBuF5a4ovwOgYDiEaoqon8TL8jt9CPezX4OQe6P6/tzM
         ikqmm5eCnG3bBlPI7w9H0f6sQLZGCByWLUs7u9Oyw2wdxEPovJEXROlrYoUZnbU5Fdqa
         nQXK9H8GE4ofJDQVp3nVL/DVlViWOayXNDNydyF2FEB4EBCB1nAUJ48JW2/o7aE3jkDA
         OFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731252559; x=1731857359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvfAlDie45/dO/q2Oa4nMUlSYRbUQddnQckYeJvFoiA=;
        b=XZ+HQksaDD9Ai5f1kMgCpVa73ehJzrQ4HxfuQAfL357cM1ccDYwl9c6x7khl17DH3S
         6p72lkzuKOZlq+zh/vrlBK+3PFuSOIPqoB/Ml2k4il/kvLx4eQz1e4MutjQtrR3L4Mjt
         kISM0siQwb/E5/4TrUezUzxCZCRM24Jv36q/TKifSQXDeiPqqR5jitJSua5FAdONoknW
         fUs9VKnjz/iqg0ukDhR6sgNNr2XsyVRxnY1U81KI02+VNZTxb2uSCQp4yYnB2cOKKgRG
         NnIDmTgJYRiz9SxTv93HM0Aa6szDsu9Wf3LuVZeSPfOsXKZR1PoBkqbe0gKtj9/UV1d2
         M/jw==
X-Forwarded-Encrypted: i=1; AJvYcCX0fSXCANCvs1m6TAntVRGO1uKuthjqoqnRcr5uXsPUg9Mo4cInwO2RpNC+962E1mUM/M8+3tiUZIpjmWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3bDvatI/RUhziI5yM4CEBAyAN+pP2cf6O3lEto3PTpQSREbMh
	dXQRbZu85j2wcNTTOaG41iDg2OEgbf2HDEK8Zd1IEm6MmihIiJyCNSoSuWx/f9w=
X-Google-Smtp-Source: AGHT+IGu/u+FhGsz3wBr1Zsic2L7vJ+0uwzRrgnEJRvL3npe1QZdpxBowle6ldDc43UF6F8F8hYjFQ==
X-Received: by 2002:a17:90b:2ecb:b0:2e5:5ab5:ba52 with SMTP id 98e67ed59e1d1-2e9b173f1ddmr13558707a91.20.1731252559257;
        Sun, 10 Nov 2024 07:29:19 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f935dsm9940973a91.35.2024.11.10.07.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:29:18 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/15] mm/readahead: add readahead_control->uncached member
Date: Sun, 10 Nov 2024 08:27:56 -0700
Message-ID: <20241110152906.1747545-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110152906.1747545-1-axboe@kernel.dk>
References: <20241110152906.1747545-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If ractl->uncached is set to true, then folios created are marked as
uncached as well.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/pagemap.h | 1 +
 mm/readahead.c          | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 68a5f1ff3301..8afacb7520d4 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1350,6 +1350,7 @@ struct readahead_control {
 	pgoff_t _index;
 	unsigned int _nr_pages;
 	unsigned int _batch_count;
+	bool uncached;
 	bool _workingset;
 	unsigned long _pflags;
 };
diff --git a/mm/readahead.c b/mm/readahead.c
index 003cfe79880d..8dbeab9bc1f0 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -191,7 +191,13 @@ static void read_pages(struct readahead_control *rac)
 static struct folio *ractl_alloc_folio(struct readahead_control *ractl,
 				       gfp_t gfp_mask, unsigned int order)
 {
-	return filemap_alloc_folio(gfp_mask, order);
+	struct folio *folio;
+
+	folio = filemap_alloc_folio(gfp_mask, order);
+	if (folio && ractl->uncached)
+		__folio_set_uncached(folio);
+
+	return folio;
 }
 
 /**
-- 
2.45.2


