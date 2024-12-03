Return-Path: <linux-kernel+bounces-429766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CC79E2362
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E10A282DD3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC3D207A19;
	Tue,  3 Dec 2024 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZoXjuGJ6"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFCA205AD0
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239980; cv=none; b=DQImshbPwNMuwB+BXru6bur/65P9+xoZk5Eb9D9aO07iW+eHKnXOMzluZlURQfLD6ck4FtJYhWOm+XC2ucGoTPPGGXsS6rDe+7xiM5P0v/YITGJ++3e42m45DLYkkYKWEZhtffTww/JUMoBrm0Qe/GU5Ds5WCoMeczsztiMA+po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239980; c=relaxed/simple;
	bh=vs/kjKbKvWVyON8cIhVh+OmQAXll4qsNA3yrIFPC0B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D68yXB2eW1YCWtoSYrw3xIy/pvS5W3rgtwyatoKYS9+25Umbwday9RkdTJLumBKpkTRMCCARon7qI1aSKW+B37eou5c2tYua5xoXum3+gKXnJN9o3qng98ilfO5bm3DT2h/m/sNiAjd1eLCvW/5eIg3/XBiRbuKsk7fDTfJ45vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZoXjuGJ6; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3ea60f074c3so3240308b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 07:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733239978; x=1733844778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKUI9o4nURcpztCkRpa2upslaug1l9SMNKWGbNjNG00=;
        b=ZoXjuGJ6LW812fJZgfsUYAW0o3hUhJ1ECO3V3B3mzS9aIwU9AjwvE85cw46HRAI5RZ
         epkxvG7nOJM1hP2wfxke+5kgfquRsWWR65Lk0pAEnMXQ2+gMnh4ysevXl+0+Vx0QEp1h
         cCYRdj3tlbvMIc6o2QzxKIA4awRVNLJiNLD3bcLulb1skvEHqI3ICwDZNgmnR+XJGlta
         PzOYkueg0mzh2ofTcsjh3eUtmS35rpWUUBzZIURqsN2uVxdy0dU5Be80xisMA3sZgCts
         XoQKMOK2tYHYoMpMmSRSQmG2SLD6J2Cx+284FNdBXzFv+ywcAQBF8/n9i4cgFz1lrk6i
         sjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733239978; x=1733844778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKUI9o4nURcpztCkRpa2upslaug1l9SMNKWGbNjNG00=;
        b=vb34TiNB636/bnvwD3D4E0soG08Jg/lwMi38z9+SiL+wU6QVPXl4t7eJpZSDg+p6Pt
         ww0we4sm1J88U7JgrCEYB3Iu6ksy3kR1/T+tj4iom+MYxnXkVSJS8MF9tkWx6+F22adD
         k7o1F4Valln3niPUVtB9y5wgBlJUh4PKmA/+VAw/02kBenBG95khsPDnJqxJCvg1SyrX
         PaHYZ2k0xhmWPh6zA3jvdBtFvbSvbZUKD265L1w/C1CR01cRP7x8A5pg36stzcdCl+ii
         4hA5bcZlHXDIDiGhy522jnsCMfHAjFFdLVsKcWw33PjEC55BEDGNALE9s2/M4qhxnpHQ
         fI7g==
X-Forwarded-Encrypted: i=1; AJvYcCW8EBkEEbrTYDWjwjST/06osCXMNyzQB6By1OJ4HykBo8ApWQ2aDH2ULNXj9A+pgd10rovYfRCrajWXh68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Szke8StCKMgOBMzmiS+fmpAvEZZMeKBpX6KQUsvBb7Gs7mBh
	2QKi1wxZ9O0/ZnfCMuxgE0yk0tsI9j/lOiSdBEspGZWzX8juq/P+XPpz6e6ix1g=
X-Gm-Gg: ASbGncsCWyRcgYBuRieb3sD9idDFf57Lg/Ps+m4QPsOuKho+/S1N0qFW8k2kt86Z0F4
	YsskjPxnRV34RykQAcJOSpqrn3c730qQcMmPNDaLRLe3tOegPJdjEXKdXxgb1gcqeLhDseDC2QT
	q56b72eOohNtOn1JYqmk7Q6D6TRlboRyD7g1YE04cGLtc2mLMhUrq252ejVxR6VzZJKd7gEBjCO
	rQmNaw+GBT6tAMkkfa7b08grej09EOsMwZtPaP2migAteBTdYqZz0BvjGk=
X-Google-Smtp-Source: AGHT+IGmoU9sxAuWmjwWvkKLQ0cqG9D7TpsEEAnWsGzkgwInxbMdKTegKVNOgiZahNH2vDY40Qhwdw==
X-Received: by 2002:a05:6808:218d:b0:3ea:4aad:a877 with SMTP id 5614622812f47-3eae50d7cd4mr2734954b6e.43.1733239978709;
        Tue, 03 Dec 2024 07:32:58 -0800 (PST)
Received: from localhost.localdomain ([130.250.255.163])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ea86036cbbsm2891878b6e.8.2024.12.03.07.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 07:32:58 -0800 (PST)
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
Subject: [PATCH 09/12] mm/filemap: drop uncached pages when writeback completes
Date: Tue,  3 Dec 2024 08:31:45 -0700
Message-ID: <20241203153232.92224-11-axboe@kernel.dk>
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

If the folio is marked as uncached, drop pages when writeback completes.
Intended to be used with RWF_UNCACHED, to avoid needing sync writes for
uncached IO.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 139d1db79ff8..eb6a8d39f9d0 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1599,6 +1599,27 @@ int folio_wait_private_2_killable(struct folio *folio)
 }
 EXPORT_SYMBOL(folio_wait_private_2_killable);
 
+/*
+ * If folio was marked as uncached, then pages should be dropped when writeback
+ * completes. Do that now. If we fail, it's likely because of a big folio -
+ * just reset uncached for that case and latter completions should invalidate.
+ */
+static void folio_end_uncached(struct folio *folio)
+{
+	/*
+	 * Hitting !in_task() should not happen off RWF_UNCACHED writeback, but
+	 * can happen if normal writeback just happens to find dirty folios
+	 * that were created as part of uncached writeback, and that writeback
+	 * would otherwise not need non-IRQ handling. Just skip the
+	 * invalidation in that case.
+	 */
+	if (in_task() && folio_trylock(folio)) {
+		if (folio->mapping)
+			folio_unmap_invalidate(folio->mapping, folio, 0);
+		folio_unlock(folio);
+	}
+}
+
 /**
  * folio_end_writeback - End writeback against a folio.
  * @folio: The folio.
@@ -1609,6 +1630,8 @@ EXPORT_SYMBOL(folio_wait_private_2_killable);
  */
 void folio_end_writeback(struct folio *folio)
 {
+	bool folio_uncached = false;
+
 	VM_BUG_ON_FOLIO(!folio_test_writeback(folio), folio);
 
 	/*
@@ -1630,9 +1653,14 @@ void folio_end_writeback(struct folio *folio)
 	 * reused before the folio_wake_bit().
 	 */
 	folio_get(folio);
+	if (!folio_test_dirty(folio))
+		folio_uncached = folio_test_clear_uncached(folio);
 	if (__folio_end_writeback(folio))
 		folio_wake_bit(folio, PG_writeback);
 	acct_reclaim_writeback(folio);
+
+	if (folio_uncached)
+		folio_end_uncached(folio);
 	folio_put(folio);
 }
 EXPORT_SYMBOL(folio_end_writeback);
-- 
2.45.2


