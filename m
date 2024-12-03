Return-Path: <linux-kernel+bounces-429763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6129E235B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE7C2864C5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6052040BD;
	Tue,  3 Dec 2024 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0jbp1Iuu"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2886D1FECCC
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239976; cv=none; b=AGO4ON6uDRW6gs0Wbiv3uzu9mRtbjm4ez7zavz3NuQZH2vD4cp7qkMntQg+1qD9H7Fsayrinq9XYErB4RgzSppRgNJgay8bARFwrmZBWsKpxuQ3WVE0cCDZRl/V4UpgYBdfLsieu+cO1o1tVYSmQEmagAesDYA47w4gP85wHj9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239976; c=relaxed/simple;
	bh=YX3XCyHjYzyVsTXZV7qYbvuii/Uh6uyZoNv1uBKQubM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AteHWEhSfzFO7hH00JXM1zSmN+5s7S5n0KEzDq+Bxix/p2q9+3NgPADmooBkzPL0dbokUCXkF4Aij1X/zTREwjJSCKV1SXkB/mJfntyzotb9kW225zCkDQrHi6mFzXJoNCKpb8JBr5nE9twBCQDQsgDJCZLqjhlVGC+C38c5Qag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0jbp1Iuu; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3ea369fdb0cso3320121b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 07:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733239974; x=1733844774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRb+N8QQBu8dVr+Sad3apJL8CLp+dfOfMlp0JKFijps=;
        b=0jbp1Iuur9naulsin3kmi+SybTDNMm5eTWmCVsvE0jKeqIrtgcbOc1lJt0ws5oRJuq
         Sjv3tz5r650N9b6YtmMmXTU/yhqB1dKl7xEj6mVG/KngfILqIJIOFzd9YlgGmSkU+gyK
         TeUfX5VOGwkJBc9Ycn3m5ZfdCG3bRYGBofsi0clxloal7RcEbypUuH3TDPa0pGqGOFC8
         V86km6rLFWOz0gKPgtUnNMOnEcYsJ2UdA6endKWApYrCMpd21bSCCux3aOaEdnldy/vc
         MJRbv7eFoXmkwI/YMFMwW5fMiy+E8DwSYOvkaGYfcOfUO69SCaIXXsO1QEulBG4c9lpk
         mT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733239974; x=1733844774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRb+N8QQBu8dVr+Sad3apJL8CLp+dfOfMlp0JKFijps=;
        b=ERMtDuBNMJy7xtkdtv2kW/7uWN1YHosP6+Aa3YqBJUaJmSSO0dtHOiHxTEVihKugLZ
         9eNx/K65wB053QH+Vp2P7xmhH+9+WAfXrGpm+P38DowmPFw889PqyEa6PxrtjTab5CdK
         Ua1lAk/zGXZ/x8knalRA2JB1Gk7k66JgsovXUFbKH9NENctqyVMkVuMViwFmCHbuMVr6
         MAeOX6Igpb388ytNCgNR/DLuYFtXz1pHVwClV/yOqypbRJRiR37ST4hjrY7V9DmtnE8Q
         FQCTFelxjBxTU//HLOF7CnS325xqTOhoBunGW6laJTm/XLRrVxxo6VsI0HQUx5o574r8
         VDKg==
X-Forwarded-Encrypted: i=1; AJvYcCUPgtpp/77aOGDukmSaTp+S1Waa762FmUXXqHI/WcUc9GAbrFafU7ncOJApHhcfquGah8/7tyzjnn+4uCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5aW9LvpQcW3Tr8v/jSYn3ipIfHIbCIF55JHbovtmHYVSrFYWL
	DBsN39lj+c1+2Tqj1fUk+ItOyOaJiQjUsbDwEf3Wgn3RrfylWCo5m6a9kdHTcvk=
X-Gm-Gg: ASbGnctpItTSwEFRbXrRxb1dd1DSJu9BdowjOTq9VdPhhaxzIBPQmW+00eTG+5y+Mwg
	omsyByUabTtHWZWPv1UMu/8Y6sEjiXVzR7xTYYhhrr1i7hRwIezfVEVlkG9cux+ehEUiR2Lwlll
	zp0K2jT3WwNlf4R82hQU88YXBvCMcJsbTmKBfo7AAHOMudTK5O4R9pGz9Zh3ABcfqa+rB6Je5cc
	sEYGuli47xDPT9zUXiXgyUnE8g/qQBZPqiVN5GQare9u6cCoEZpWx11xEk=
X-Google-Smtp-Source: AGHT+IGHTQ5LeGksRhzqMID0Kqh5YSoxN8Gylam5Ojf1AQcflOZOTzp2gKozYR7Jx08uJ7hl5NcXoA==
X-Received: by 2002:a05:6808:3843:b0:3e8:1f5d:b7f8 with SMTP id 5614622812f47-3eae4edadc4mr3375768b6e.1.1733239974385;
        Tue, 03 Dec 2024 07:32:54 -0800 (PST)
Received: from localhost.localdomain ([130.250.255.163])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ea86036cbbsm2891878b6e.8.2024.12.03.07.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 07:32:53 -0800 (PST)
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
Subject: [PATCH 06/12] mm/truncate: add folio_unmap_invalidate() helper
Date: Tue,  3 Dec 2024 08:31:42 -0700
Message-ID: <20241203153232.92224-8-axboe@kernel.dk>
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

Add a folio_unmap_invalidate() helper, which unmaps and invalidates a
given folio. The caller must already have locked the folio. Use this
new helper in invalidate_inode_pages2_range(), rather than duplicate
the code there.

In preparation for using this elsewhere as well, have it take a gfp_t
mask rather than assume GFP_KERNEL is the right choice. This bubbles
back to invalidate_complete_folio2() as well.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/pagemap.h |  2 ++
 mm/truncate.c           | 35 ++++++++++++++++++++++-------------
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 72b03b37c265..f2d49dccb7c1 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -34,6 +34,8 @@ int kiocb_invalidate_pages(struct kiocb *iocb, size_t count);
 void kiocb_invalidate_post_direct_write(struct kiocb *iocb, size_t count);
 int filemap_invalidate_pages(struct address_space *mapping,
 			     loff_t pos, loff_t end, bool nowait);
+int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
+			   gfp_t gfp);
 
 int write_inode_now(struct inode *, int sync);
 int filemap_fdatawrite(struct address_space *);
diff --git a/mm/truncate.c b/mm/truncate.c
index 7c304d2f0052..c1dfddb1122a 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -533,12 +533,12 @@ EXPORT_SYMBOL(invalidate_mapping_pages);
  * sitting in the folio_add_lru() caches.
  */
 static int invalidate_complete_folio2(struct address_space *mapping,
-					struct folio *folio)
+				      struct folio *folio, gfp_t gfp_mask)
 {
 	if (folio->mapping != mapping)
 		return 0;
 
-	if (!filemap_release_folio(folio, GFP_KERNEL))
+	if (!filemap_release_folio(folio, gfp_mask))
 		return 0;
 
 	spin_lock(&mapping->host->i_lock);
@@ -570,6 +570,25 @@ static int folio_launder(struct address_space *mapping, struct folio *folio)
 	return mapping->a_ops->launder_folio(folio);
 }
 
+int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
+			   gfp_t gfp)
+{
+	int ret;
+
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+
+	if (folio_test_dirty(folio))
+		return 0;
+	if (folio_mapped(folio))
+		unmap_mapping_folio(folio);
+	BUG_ON(folio_mapped(folio));
+
+	ret = folio_launder(mapping, folio);
+	if (!ret && !invalidate_complete_folio2(mapping, folio, gfp))
+		return -EBUSY;
+	return ret;
+}
+
 /**
  * invalidate_inode_pages2_range - remove range of pages from an address_space
  * @mapping: the address_space
@@ -629,18 +648,8 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 				folio_unlock(folio);
 				continue;
 			}
-			VM_BUG_ON_FOLIO(!folio_contains(folio, indices[i]), folio);
 			folio_wait_writeback(folio);
-
-			if (folio_mapped(folio))
-				unmap_mapping_folio(folio);
-			BUG_ON(folio_mapped(folio));
-
-			ret2 = folio_launder(mapping, folio);
-			if (ret2 == 0) {
-				if (!invalidate_complete_folio2(mapping, folio))
-					ret2 = -EBUSY;
-			}
+			ret2 = folio_unmap_invalidate(mapping, folio, GFP_KERNEL);
 			if (ret2 < 0)
 				ret = ret2;
 			folio_unlock(folio);
-- 
2.45.2


