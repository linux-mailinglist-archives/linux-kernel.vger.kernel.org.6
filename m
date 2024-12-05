Return-Path: <linux-kernel+bounces-432616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A12929E4DBF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628712849C1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 06:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA7819E819;
	Thu,  5 Dec 2024 06:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H1O3RPlA"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277FF194137
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 06:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733381420; cv=none; b=VIkNHiWesxYU+fTU8TNo4K6JBlXhWzcwJ8p6rgyQhPzY+UnjKIkh/cbf/8ASsaZwhC1b8xORKCh+t/XpiWBLw7m373GhwmciaNLH7nOn+sGeBBGYCKI/Br7kdsq/ILPafUySMKyclTkB276FFKH6ML+BFlSsKprwShgXVZTdceI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733381420; c=relaxed/simple;
	bh=XlbiBJpp2JIlNlNpaP/EMZUhdERdFrlARnEooJHZvwc=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=RppMtXNEsk7EICPwiUAJFG/Xps2TzXoNegtniBas9RDrD0bQLG9saBMhOsl4jyiVjoKsDlVfJo83tj4xA9vfEufISK9tf2aCOoasL+U/WSmI8g0RvwiR1hDJHq29H4ZRce5zLURTpuUBJGSTn+wd2Ut2qtVfC2Q0DFtVVnKSd5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H1O3RPlA; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee6dd1dd5eso459225a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 22:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733381418; x=1733986218; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cvk6ttttbcv19F25dJWS3cOizDMg1rIr9u4lTY5RSA0=;
        b=H1O3RPlAdr0HNo/JUAVY+0iK7009GZ2oINr/8zuHGqp+w+FipRWt7tBcubhCD7A2ro
         ILcS6i/nnMxbHgzaf2zfdrF53q9ghqX4OuEp6Zj7l7PKRzZjf6vnsvZeszW/NB9t2/EC
         qV9MyPo4MU8Ih1RAnsWZeFN3EMs4XRD8tCpSYzA+uAKsjcDFCMgy8HyO/mpPcHZUQY6E
         /9p7k8vlmU9ujhBzJUo4dcdhGkWk6mvXQ9aQ3E6+Xd+nRiwx1qLqp0Td3rD7Ognne0Tm
         c9ImL6EEMdkeydazt7UoaeYtnbahJvuN80sFp4CKnE5gAPjTpLzwipwTV/bcJqoILBQJ
         UMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733381418; x=1733986218;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cvk6ttttbcv19F25dJWS3cOizDMg1rIr9u4lTY5RSA0=;
        b=rqvokuB3aH1Mro8bPB73nvaUk+OUCLs2U8Zp7HaDDsQKW9q7uMTtf4tioPyGN2H1UA
         xbxfC0R1qa+olhpJCsvwMppOqV227R7tLJ77SdoVIDhw8CtNtk7kIubCgGo3qAor0K6j
         3LxisJthYbxveP49AIVM3qOWpc7CYoSBZH5Hlwbj3KWxz4B+/Dp9Tu3ljYRQK/qnqi0C
         MMCyJuZgthhwR7ZZbpX1EgewUEwGVJL2HREDH9h52myGf2PCu/p+Ifwk2PbDOVzAhIwJ
         1STEFFqWZiVhi/A70J3StryzD/mo+fD/l+P/16XL5UahN95x8yGma0mG8cJWHwq564TB
         dOZg==
X-Forwarded-Encrypted: i=1; AJvYcCUUCJXGoXTbUHLNXx1uceQfU80DVUtH6sb6EI5kctdCTmDeHpoUS4rDZXkK3kgCP9H01lVA5nxKdwOp27A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8kpL5sOlD7RnOMt10i8TNyRuuFX+BS/p0ee//pXJjRltDh7EV
	qG89WIpaDqJCmlB81nolFyAt6l0k37sWZnSObo4t07l74LKAPQAyRFAWIL4sog==
X-Gm-Gg: ASbGncuA1TeCODSF7PgmDjRuSLt2fVZexxDqC5Mbd+COa95FmpVP6Os6310oN+Vhf99
	7QffzHdvmhlO0ihHL7q+DBRE6GjQC9UpA2lqYtOSW8VqmGJ32bMXh+833AnbHasRxHPMg8V841b
	JXI0j52W3of+Tpp4AE3o7PN4gkixUVx3q3eSSJ9xrm+giMuouVP/IqqAZ5zKDkLEf1fO3fUILWt
	HOO81vXYv4SNh/K8tXYjsAsPnl1ZUhCZd0KmmTEbNzDfj8ppv6F0HMM4q7Hofk+RQJG1vJCox7u
	jrP7Ulnw0ZU0tUMCDpbH/zPI/0rrsiTo1kjghg==
X-Google-Smtp-Source: AGHT+IGPvwnGHMEiovh8VAQa9ivd2fvLTCiDTZovipWBmITfYcLHvTnKGEwY9d18d4z6Ra/2K6+yeg==
X-Received: by 2002:a17:90b:380c:b0:2ee:edae:780 with SMTP id 98e67ed59e1d1-2ef011fc474mr14791127a91.15.1733381418257;
        Wed, 04 Dec 2024 22:50:18 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef31715ba8sm1997649a91.13.2024.12.04.22.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 22:50:17 -0800 (PST)
Date: Wed, 4 Dec 2024 22:50:06 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: [PATCH hotfix] mm: shmem: fix ShmemHugePages at swapout
Message-ID: <5ba477c8-a569-70b5-923e-09ab221af45b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

/proc/meminfo ShmemHugePages has been showing overlarge amounts (more
than Shmem) after swapping out THPs: we forgot to update NR_SHMEM_THPS.

Add shmem_update_stats(), to avoid repetition, and risk of making that
mistake again: the call from shmem_delete_from_page_cache() is the bugfix;
the call from shmem_replace_folio() is reassuring, but not really a bugfix
(replace corrects misplaced swapin readahead, but huge swapin readahead
would be a mistake).

Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: stable@vger.kernel.org
---
 mm/shmem.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index ccb9629a0f70..f6fb053ac50d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -787,6 +787,14 @@ static bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+static void shmem_update_stats(struct folio *folio, int nr_pages)
+{
+	if (folio_test_pmd_mappable(folio))
+		__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS, nr_pages);
+	__lruvec_stat_mod_folio(folio, NR_FILE_PAGES, nr_pages);
+	__lruvec_stat_mod_folio(folio, NR_SHMEM, nr_pages);
+}
+
 /*
  * Somewhat like filemap_add_folio, but error if expected item has gone.
  */
@@ -821,10 +829,7 @@ static int shmem_add_to_page_cache(struct folio *folio,
 		xas_store(&xas, folio);
 		if (xas_error(&xas))
 			goto unlock;
-		if (folio_test_pmd_mappable(folio))
-			__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS, nr);
-		__lruvec_stat_mod_folio(folio, NR_FILE_PAGES, nr);
-		__lruvec_stat_mod_folio(folio, NR_SHMEM, nr);
+		shmem_update_stats(folio, nr);
 		mapping->nrpages += nr;
 unlock:
 		xas_unlock_irq(&xas);
@@ -852,8 +857,7 @@ static void shmem_delete_from_page_cache(struct folio *folio, void *radswap)
 	error = shmem_replace_entry(mapping, folio->index, folio, radswap);
 	folio->mapping = NULL;
 	mapping->nrpages -= nr;
-	__lruvec_stat_mod_folio(folio, NR_FILE_PAGES, -nr);
-	__lruvec_stat_mod_folio(folio, NR_SHMEM, -nr);
+	shmem_update_stats(folio, -nr);
 	xa_unlock_irq(&mapping->i_pages);
 	folio_put_refs(folio, nr);
 	BUG_ON(error);
@@ -1969,10 +1973,8 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
 	}
 	if (!error) {
 		mem_cgroup_replace_folio(old, new);
-		__lruvec_stat_mod_folio(new, NR_FILE_PAGES, nr_pages);
-		__lruvec_stat_mod_folio(new, NR_SHMEM, nr_pages);
-		__lruvec_stat_mod_folio(old, NR_FILE_PAGES, -nr_pages);
-		__lruvec_stat_mod_folio(old, NR_SHMEM, -nr_pages);
+		shmem_update_stats(new, nr_pages);
+		shmem_update_stats(old, -nr_pages);
 	}
 	xa_unlock_irq(&swap_mapping->i_pages);
 
-- 
2.43.0

