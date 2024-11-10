Return-Path: <linux-kernel+bounces-403252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8373C9C3325
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 16:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4798F28154C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 15:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F9713211A;
	Sun, 10 Nov 2024 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uCQqbBCW"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE284DA04
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 15:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731252559; cv=none; b=uMjioGgsHX4x7rP6+h6o5tbpi1AKeGeX7wwfo9TepogfJMu0k/2D8tq4HaK6Kb+eJYN/MnZKuZNpZAGIt9lXGZGhjDWvXkFrO+6fFySYqpA0Iw7siN1Rbi0yX5S64YNICM8bQX1Wjl1idHbM4Y7dki7dsQjKxjdlMg8ia3uja/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731252559; c=relaxed/simple;
	bh=wdE7j3SXsvf8mZ3WLeO9bDbqT1xBl9uoI5Ta1MifPnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/xN0+IZVMCfVLFkRhv5LEbLR8EeSJoMT+oazItOlfpjOxC4Nit91QUdmtZ91N3Jjyw/dM+Pec482DrSc8HWq1HxegJ7hx/66+UF1zSuc2sXlkF73iAHcf6/8tIfxzUV3xGdRI101OgypbifhQrL6O7t3jWht44mrEEro8lO8/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uCQqbBCW; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e9b55b83d2so1735624a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 07:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731252556; x=1731857356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7YIma1TSdS4GVKncfhre22V8DGIHalzmKUoqzgwI0E=;
        b=uCQqbBCWKXwXYqwtTldcjEciA9O/jswHvB8sLHez+k1MKrdrexbKmmLlB/2xSJNehQ
         zuenZR0qWPmvPing0Yi5k+ZkBLHdMbPMqOqZJQnQiVwt9tVjJhPoykkq92T+mJD7mQoa
         lni6bK8H6oHmdCTtAeO2TEYmshXmLFggiMg0gaFKq+ZH17jiPFxRK8ssBeviSxnhO72r
         lI7jc0oBbhqdTX8v8xLwtecgCnTQw//ddS5raCd0WoJiLtKDMxyfa5Lb5SlI3KVhG+b5
         l3W4+EASOfHXCGRQqQM4MFMb6MuaBaR/gwe8C6CDdjetfO2m8GEvGkYZKTcWmA5kYsiw
         4Bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731252556; x=1731857356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7YIma1TSdS4GVKncfhre22V8DGIHalzmKUoqzgwI0E=;
        b=ibJ8bYeUwUOD9PMh0GyPh4In5A9SRycCcDHQlzwNIDpJO2syGsP+2GHRbJuQy/0nuU
         F1OSnvYMKM+dEVmszsRxXokteQkV8P8qvbz9JLniPQ1jN8dUN9rxLUAT+gz0yETsR9Ir
         YCTbaWNRBxFV2cWjC0vQ1le5aYREpuqqRX6iPq05opWP5FrmQDR0S2cZ/qEZXU31jvCN
         2MYg+MHw+86WNaXYoOVrFsp7g9Dh7iGfddn6MuL1X6pz/nnP694QJW+7Mylo5QkEQAYg
         9BMisJ2Zp33tmUzyq9sQ2yKerKrOS5HDXCN4xuFc7aarYiRAHvFRhe9WSgHW6Jn1xG7s
         CaHA==
X-Forwarded-Encrypted: i=1; AJvYcCXDf5aZZeFxDi6zIPV0DeTGjLaRPNnxX2O10An/OBM8hAyFE5Axx0oFI1Pj3n4h/uvIvs/+DSOpzPPVYZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk/O1e7Dn1Td1DecfpTDbcXuYty7M9ISAsA7YpIGpEcE6VtTc5
	M+HBwxE3AkCe8bR3NWx0DZFIi4wJl4bB6C/XuptcJYv53ONVJ+zBMlEv1E2B+90=
X-Google-Smtp-Source: AGHT+IGMsIWblwQtQWO8JcRHCLRTN0pIGof64EqqksTz4TFFvZ2UD/wQcBuuSf4CK9eKe+atZiR/kw==
X-Received: by 2002:a17:90b:4acb:b0:2e2:be64:488f with SMTP id 98e67ed59e1d1-2e9b1655945mr13617134a91.6.1731252555726;
        Sun, 10 Nov 2024 07:29:15 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f935dsm9940973a91.35.2024.11.10.07.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:29:14 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/15] mm/readahead: add folio allocation helper
Date: Sun, 10 Nov 2024 08:27:54 -0700
Message-ID: <20241110152906.1747545-3-axboe@kernel.dk>
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

Just a wrapper around filemap_alloc_folio() for now, but add it in
preparation for modifying the folio based on the 'ractl' being passed
in.

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/readahead.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 3dc6c7a128dd..003cfe79880d 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -188,6 +188,12 @@ static void read_pages(struct readahead_control *rac)
 	BUG_ON(readahead_count(rac));
 }
 
+static struct folio *ractl_alloc_folio(struct readahead_control *ractl,
+				       gfp_t gfp_mask, unsigned int order)
+{
+	return filemap_alloc_folio(gfp_mask, order);
+}
+
 /**
  * page_cache_ra_unbounded - Start unchecked readahead.
  * @ractl: Readahead control.
@@ -260,8 +266,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			continue;
 		}
 
-		folio = filemap_alloc_folio(gfp_mask,
-					    mapping_min_folio_order(mapping));
+		folio = ractl_alloc_folio(ractl, gfp_mask,
+					mapping_min_folio_order(mapping));
 		if (!folio)
 			break;
 
@@ -431,7 +437,7 @@ static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
 		pgoff_t mark, unsigned int order, gfp_t gfp)
 {
 	int err;
-	struct folio *folio = filemap_alloc_folio(gfp, order);
+	struct folio *folio = ractl_alloc_folio(ractl, gfp, order);
 
 	if (!folio)
 		return -ENOMEM;
@@ -753,7 +759,7 @@ void readahead_expand(struct readahead_control *ractl,
 		if (folio && !xa_is_value(folio))
 			return; /* Folio apparently present */
 
-		folio = filemap_alloc_folio(gfp_mask, min_order);
+		folio = ractl_alloc_folio(ractl, gfp_mask, min_order);
 		if (!folio)
 			return;
 
@@ -782,7 +788,7 @@ void readahead_expand(struct readahead_control *ractl,
 		if (folio && !xa_is_value(folio))
 			return; /* Folio apparently present */
 
-		folio = filemap_alloc_folio(gfp_mask, min_order);
+		folio = ractl_alloc_folio(ractl, gfp_mask, min_order);
 		if (!folio)
 			return;
 
-- 
2.45.2


