Return-Path: <linux-kernel+bounces-445115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A46A49F118F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71A41884A92
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E101D1E5708;
	Fri, 13 Dec 2024 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="t+ltFlte"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589E11E376C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105371; cv=none; b=Lelt4Cz4ygSn5f3UBumiKc1KdgU9pt4NPZuXH1wj7ntGhidZtbLctEbOCJl7ZxyVULuoe6Um5coraixmF14hwA7wBcf7mYYG6HXwaQei41nyLtpVQDc/IXiSEcAGRz5PQrafia1jqScGFzSTtu/MXOkS3jm4EfvlXG/N7Wd7k4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105371; c=relaxed/simple;
	bh=QAWYGVCQ4XEJ3pXTfPeihz8wMx0MW0Etgn545GbAEGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTPKCILfXKZpfj0iRSwnF9ZZHIXdThqWDqiOrgBDae8PlyVgcIQKsSLyvlU7G1V7zctCnrpP58Q4TvkAEVIcuQtthaHNB1EDPD5mZ5KWFN+eXcQJypbr884eUHHVSnu5EjC6Jh7h27MCl6NigCkJPa8y/vVW7alZ10YhoY7a8Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=t+ltFlte; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-844d555491eso65541339f.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 07:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734105366; x=1734710166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hANs0KTrn4AbTh3ILmowq5bBaAQVBAkU7MnXkJd6Hic=;
        b=t+ltFlteBGcA0UWWo45gjFMi5F6YPSar7cOq/L5NtqarY+9zPmveE/IW4vEek6yAUb
         QlstFsbxAIu9kEt0zwXjNGD88a9t3fWpCAZpiZUmrG49S4IaVM1WmlpK85VlP3rg5XV/
         kMwNchTRlDJ12UPl0JzyglzdszaKdN9d81I9v7cFM02VYogMGZAtiTOvqbgnIkb1iN1e
         AGmN29i9WDOTh0IGhZqjmiUgwP/YGL7zkZdN0tf0mN8GKf9/vgeDbKYExIw4tkFb15EY
         AdPfmvt+7GErjc501iosLF4jFlpzJPiyobSzkfAB68bBhxVlpp0WLJLXaOrVlhxZAwuh
         3wpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734105366; x=1734710166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hANs0KTrn4AbTh3ILmowq5bBaAQVBAkU7MnXkJd6Hic=;
        b=rItDcPjokpllH9OzUYkfG2RUHuynAVH13Pb19wqvUsc+z9RWOO4OTcUC4fXA1YX+ot
         Rt+ZBqirK4jgqjXzrgf2IBfIopf6QH5UwthhP1mFro/z0X9IOakzeSlJPY8j1dgq0p8T
         7p+3pdrhPmjgTlP0peecfMDX+8XAyeKqRslkHQE9uO5yVc9PTy1Kf+GPGT2H+IcUTv4f
         fBlKYygmyGSRu6uXn+jWp2Y+Glo2i8rxOlSfR8pemHjQFgB4IwTTxO/mC38DoiHD7ryZ
         955fztjilfHwtC6GcwXmt7UHtgjVr0sO0WiIVVMj/ziSDNr0WzGnYotrsF/SQ7Oho/YE
         raJw==
X-Forwarded-Encrypted: i=1; AJvYcCU/EA6MeASgo2FZUEBtiPrVCdQEg72IMB/lmJF3/AFYUDDKZJQVlN1ekggzypJ6/KxmwxFvVvnGKyX/sHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFFLnUP40yR6oFR/teVclDcPYvjdhWzvcUIHQV+o8ApQkVkHyB
	2r6urgmNBM0mrkqXF+L038FSfASo9PxipdsJgiM7Y2scuKxEP3+vWcSpprPzeGI=
X-Gm-Gg: ASbGncu2WP6Go9njtAEiRdt+k4uVKRpvREtj5DvJ63nXpc1kpRRxmSVq1VUyD8Yn0dO
	0vN6GU/LCJFvOyJ3e0WIod06oGxr4n0G5l8DqijWnwiy+NHACSJG1L+PO0AblhI8nLJ71WeKo4y
	Tm0eaNj7nKtCO+fAwe8kI2MRqV38DZ+Z5heJs07ShdR2prH9/MSdcawNlzyiCrb4zmnD2VGB9md
	aOz92SDYaQuLWbSYdf4ikwFf2+bdKxU7g9uLGbxRqjV26uLUxlQuX9taY1o
X-Google-Smtp-Source: AGHT+IFVLcWwM0MIr7oz/Yvc9CHKROeMGY95g0ljJ88B+/rBynMSTGl1ysoTz/aE+AP7fUiTK21pEQ==
X-Received: by 2002:a05:6e02:1a07:b0:3a7:8040:595b with SMTP id e9e14a558f8ab-3aff50b64a0mr26251175ab.9.1734105366472;
        Fri, 13 Dec 2024 07:56:06 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a9ca03ae11sm35258405ab.41.2024.12.13.07.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 07:56:05 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 02/11] mm/filemap: use page_cache_sync_ra() to kick off read-ahead
Date: Fri, 13 Dec 2024 08:55:16 -0700
Message-ID: <20241213155557.105419-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213155557.105419-1-axboe@kernel.dk>
References: <20241213155557.105419-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than use the page_cache_sync_readahead() helper, define our own
ractl and use page_cache_sync_ra() directly. In preparation for needing
to modify ractl inside filemap_get_pages().

No functional changes in this patch.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 8b29323b15d7..220dc7c6e12f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2527,7 +2527,6 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 {
 	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
-	struct file_ra_state *ra = &filp->f_ra;
 	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
 	pgoff_t last_index;
 	struct folio *folio;
@@ -2542,12 +2541,13 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 
 	filemap_get_read_batch(mapping, index, last_index - 1, fbatch);
 	if (!folio_batch_count(fbatch)) {
+		DEFINE_READAHEAD(ractl, filp, &filp->f_ra, mapping, index);
+
 		if (iocb->ki_flags & IOCB_NOIO)
 			return -EAGAIN;
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			flags = memalloc_noio_save();
-		page_cache_sync_readahead(mapping, ra, filp, index,
-				last_index - index);
+		page_cache_sync_ra(&ractl, last_index - index);
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			memalloc_noio_restore(flags);
 		filemap_get_read_batch(mapping, index, last_index - 1, fbatch);
-- 
2.45.2


