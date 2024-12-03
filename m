Return-Path: <linux-kernel+bounces-429759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A683F9E234B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6617E286AD1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43AC1FBEA8;
	Tue,  3 Dec 2024 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vI3+LtaN"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A16B1F942C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239971; cv=none; b=JdGdyOn8Mn05miQTX4xRyVhJvFgjYBukySt0uEbgZln65cMl1bKpiFvkHjFqJcJFgwcSLg6+/wiwrBDn+RQwsj4c5H0ktjqUhLH0M14as/9JLcBguSC2UshvkiON5eW301513IKILx2deZL9DXZNBEGLhyvJJ2VFuRqxQW3CvUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239971; c=relaxed/simple;
	bh=8Bb0MfS/J32mJVu/hCpTfSTIXsQUeZKlcznJ/+p92u4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qV9bktfmXCAexAlJ91v8h2OPVXvYJNAkNgBBP4xlI+UsaDTIGUyIs16XNhcpHtSAUkX09YdU+Ejf4CPWkqQUdBCwndYq7YDrPIhgii9bp1LHLqKhP2H0UOUonvZwv3K8zabDQXsClVseREPpCL7nMVZfNia/onNjDR1n/x/Lpjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vI3+LtaN; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3ea6b011b27so3129180b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 07:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733239968; x=1733844768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mQz2vdNaN9LdJ9L4qyJBm7ibQRSfX5SzH0nqDyaIZA=;
        b=vI3+LtaNq/TnQ0w9S52h9H8vdWp5zjIWm4vmECGM4OLUaQkVfjYLWSZeBzwm8RkN+t
         QZBOBOs37SFN0AXY4lgL8QvsA+LIbBOvJy3jYzYBEf0DFjOW2Or/4MqeT4sUsqcdyKxH
         krxdvKTFDTUK4+uMvXVKGrP0QdooVKLGOdsjyPFAGiaROrSAHqUKPQqb2Esm7zmu755q
         L3snlWcVxQRYPSKR05GHn/anLu77M0zcXS+LauovAaCJGM/WjuKY9xah6ct2oTdUJ2vf
         7xoXj9DChXxJKIhOnduYaKYh1Aiuwk/HeB70IdkRDyMFoj6lCcMhzdBpqWm16E2K/Wkb
         URNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733239968; x=1733844768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mQz2vdNaN9LdJ9L4qyJBm7ibQRSfX5SzH0nqDyaIZA=;
        b=Q6pdBmAEhCYyjl2FdpNjZjQKf3o23+jUWv6ZJgUE6TOl8U8p417EZyNV0WLWd9ho17
         0m2ZUUvjv1x6hQ4ndgS8MoZVq753vJKPNPELQBxji/lasJKBgpUMgYqujJswVWo5422E
         PmfFbNQ78dbol3fnilvtN58uX6fE2l8nXHNMbnKGFnA9mJfHO1Kqn+l/6JLWLAV91Tr/
         j0Y+vLU3QSQ9rK0+qmXmxpVbrTDMmLsHkiIjMyN2P4alvK0SX3FkQoRkBOxu8cgeOmc5
         6AMBAqtSBlseFKYtuPC9+86uBO0321dSr3X2m4Vhi1gloych5XjE7aISMf3GWcmfr5Il
         +08Q==
X-Forwarded-Encrypted: i=1; AJvYcCVmgRxfcdI5LEF847663Wr7nW0TLtj7k672P0DFop0hafsxZ4sP9e04Y7KxEQ7An1YHKK3vA7imKDQez/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnp4nB+Sd1O4qBc2a9aPvm0PJKscBU2P/LjO2SmlpYZI/nG0uX
	FmFm8KPu9ove1+i3jaY0hRd4CieyRe55gDDQY3OvMiHgDl6FxhfRNIr4sWyL3+M=
X-Gm-Gg: ASbGnctZYfhqWYPpX9s45855nxi5eY9brefw6mOxudWHs66Oqasz76KGdT3e8KibIId
	8xslhcuSeEnSP3H2zGM2i5XDwpBfinkSEMJS14el/VKAYSieMROvkDTVam/OLV1kmzvWA52i+Be
	lTIUuVaHx2Wj/ETTpARZh18rW4WQGnzzsYS8+YNlHuiVsBNkxfkyPunfHmsC4mcpq9AyPNyGQt+
	U1umMfuyjDdrtXgeC88WE467I+aUIIpRAMyIrHpakU3s7cZYRCIXIdxjUQ=
X-Google-Smtp-Source: AGHT+IFPC3QIjfGmFueYpArbFjHsCE/nJs1cTRfjgQkZc7hdX+t3EH5eMgGO4h5vvPNqW5LyAgQfEA==
X-Received: by 2002:a05:6808:1454:b0:3ea:45d1:de13 with SMTP id 5614622812f47-3eae499b2b5mr1606169b6e.11.1733239968341;
        Tue, 03 Dec 2024 07:32:48 -0800 (PST)
Received: from localhost.localdomain ([130.250.255.163])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ea86036cbbsm2891878b6e.8.2024.12.03.07.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 07:32:47 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/12] mm/readahead: add folio allocation helper
Date: Tue,  3 Dec 2024 08:31:38 -0700
Message-ID: <20241203153232.92224-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203153232.92224-2-axboe@kernel.dk>
References: <20241203153232.92224-2-axboe@kernel.dk>
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
index 8f1cf599b572..8424bf1b67e2 100644
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
@@ -265,8 +271,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			continue;
 		}
 
-		folio = filemap_alloc_folio(gfp_mask,
-					    mapping_min_folio_order(mapping));
+		folio = ractl_alloc_folio(ractl, gfp_mask,
+					mapping_min_folio_order(mapping));
 		if (!folio)
 			break;
 
@@ -436,7 +442,7 @@ static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
 		pgoff_t mark, unsigned int order, gfp_t gfp)
 {
 	int err;
-	struct folio *folio = filemap_alloc_folio(gfp, order);
+	struct folio *folio = ractl_alloc_folio(ractl, gfp, order);
 
 	if (!folio)
 		return -ENOMEM;
@@ -751,7 +757,7 @@ void readahead_expand(struct readahead_control *ractl,
 		if (folio && !xa_is_value(folio))
 			return; /* Folio apparently present */
 
-		folio = filemap_alloc_folio(gfp_mask, min_order);
+		folio = ractl_alloc_folio(ractl, gfp_mask, min_order);
 		if (!folio)
 			return;
 
@@ -780,7 +786,7 @@ void readahead_expand(struct readahead_control *ractl,
 		if (folio && !xa_is_value(folio))
 			return; /* Folio apparently present */
 
-		folio = filemap_alloc_folio(gfp_mask, min_order);
+		folio = ractl_alloc_folio(ractl, gfp_mask, min_order);
 		if (!folio)
 			return;
 
-- 
2.45.2


