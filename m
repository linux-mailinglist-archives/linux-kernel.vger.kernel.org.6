Return-Path: <linux-kernel+bounces-237393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5F891F065
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB3262884A7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 07:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE57144D36;
	Tue,  2 Jul 2024 07:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C6jXk31x"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915F7537E7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 07:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719906073; cv=none; b=s+3CDxLWEVhtnS0zZSzB5o06D3IHwdEXLBvMGlifdYe2tOB+srKIFZVyq9FKC83sQl8UCdKqUqETDhecMB0sLaWvMrCt9D/IIjzFlLNgb1Z74ddVAmqcEFblUFG1lsBxoFzl8YNpi+6PV8g9Uy/cRSiIXfwYSGC4y2M/2MOrdFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719906073; c=relaxed/simple;
	bh=I+/KVAKa+iu7BOmDHKd7r2SEZ7ik2265e3cSYn/Fqo0=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZQpyGI0vJJ1+dtI3HxHAK7yULKCP4lPCa7l8LWmAmBdGn6QFBixJ5CQaObYut7OD7eegDw0vl3CNkHvsqGW7iXE4QYT5pSbOo91Ez9WFznUF2EbwVEoausJ9dzbnIbrvkxv8kqjHCvuI9AC0BR2e2zggWPM4I5ZrgBuegfFKysw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C6jXk31x; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-df4d5d0b8d0so3580740276.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 00:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719906070; x=1720510870; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v96APnDdVOJx5oTshVzUPV7cP/8jCbffCJX62A3mfo8=;
        b=C6jXk31x6uZgJVfVQLYo65THXgLzxBNc7rQt26c79hJrf83K8MmUUo/8yORE4/GiBK
         eqnhkiRed5fu/nzofsY1aGwsD2K92ADLu5sv8xaalvoPH/dUmwEOVx7X9WNHBGTMvgCI
         S9QjczNu7QfM6U9yBCGOWEZmm6/OId44Q8jBX0nG6tdakGldL7KdBK/7kGWEDTGlnmE1
         GPkRdWOtZXgOyRv/6IFG/P2GBzkUKvaBDnRSnPPHobeAcUkG7PjAPepvnPqKtoV8nFFY
         oFJ4AN5bTQ+F+INHd9PoXJfI9np17HmdKCRTeGTbtXGk8MMtcCY30syllbuSm4PKZt7x
         juJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719906070; x=1720510870;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v96APnDdVOJx5oTshVzUPV7cP/8jCbffCJX62A3mfo8=;
        b=MHmHHU3M7hSvwFaR3I9HrXHiHmuMV61uWq0FaLme3GiSWd2h2lAy7V5lRUkHJG7uJf
         MN8SsjuUInqGbC5izz/hdSsw/1QJw176EL5NmAMLXGRZKA3lXIgzqmh+ixYpmH88aF6z
         3ra6sw2+oMGL1InlCFydLVWYEtJMfY3fd1Lia0m/udKb/a0wRPuxvZUCZIawlY+dhjon
         CJnlLDh7jp5B+0LOKv/9J1UgqDyILCSylm5GPcInWubTk07C+MscbioIoUrgZ0t+jAeq
         7UDTkKhXcnxdY2czHCwBNKdWkNdsu+kYhcbp7k6PyMcmJTYzG44L6tZzQUSpbMttxQVs
         iHZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUagMeARzU855l1zdQqgu49dCf9k8hQ/8hmIA1ioYy3fLkvE5SgyY4NiPqwT5a7d6sU/NTFTxrC20Vol8hLo+wNyX1XWHwyZXNtmgp6
X-Gm-Message-State: AOJu0YxLp0Hi1N8CVoCWHLCajCDTP7qyh40VMT4ckcyJyjzq6Fz8fLpx
	MfY+yW4LhER4NjE3hHoy3I0VrF+vlUS1QVIzAkYTQ+o9j3H97rB2qj4f7t9OJg==
X-Google-Smtp-Source: AGHT+IEcCHJR7/DobPvgviabErk0cRA95wcHifggrrRYP7p9mHLzm5PGv7GjbQBauYxFT8hwA3QF+w==
X-Received: by 2002:a25:8811:0:b0:e03:4e08:c93c with SMTP id 3f1490d57ef6-e036eaf4975mr8118729276.13.1719906070304;
        Tue, 02 Jul 2024 00:41:10 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e039c802626sm125563276.9.2024.07.02.00.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 00:41:09 -0700 (PDT)
Date: Tue, 2 Jul 2024 00:40:55 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Baolin Wang <baolin.wang@linux.alibaba.com>, Nhat Pham <nphamcs@gmail.com>, 
    Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>, 
    Barry Song <baohua@kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
    David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
    Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: [PATCH hotfix] mm: fix crashes from deferred split racing folio
 migration
Message-ID: <29c83d1a-11ca-b6c9-f92e-6ccb322af510@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Even on 6.10-rc6, I've been seeing elusive "Bad page state"s (often on
flags when freeing, yet the flags shown are not bad: PG_locked had been
set and cleared??), and VM_BUG_ON_PAGE(page_ref_count(page) == 0)s from
deferred_split_scan()'s folio_put(), and a variety of other BUG and WARN
symptoms implying double free by deferred split and large folio migration.

6.7 commit 9bcef5973e31 ("mm: memcg: fix split queue list crash when large
folio migration") was right to fix the memcg-dependent locking broken in
85ce2c517ade ("memcontrol: only transfer the memcg data for migration"),
but missed a subtlety of deferred_split_scan(): it moves folios to its own
local list to work on them without split_queue_lock, during which time
folio->_deferred_list is not empty, but even the "right" lock does nothing
to secure the folio and the list it is on.

Fortunately, deferred_split_scan() is careful to use folio_try_get(): so
folio_migrate_mapping() can avoid the race by folio_undo_large_rmappable()
while the old folio's reference count is temporarily frozen to 0 - adding
such a freeze in the !mapping case too (originally, folio lock and
unmapping and no swap cache left an anon folio unreachable, so no freezing
was needed there: but the deferred split queue offers a way to reach it).

Fixes: 9bcef5973e31 ("mm: memcg: fix split queue list crash when large folio migration")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: stable@vger.kernel.org
---
This patch against 6.10-rc6: Kefeng has commits in the mm-tree which
which will need adjustment to go over this, but we can both check the
result.  I have wondered whether just reverting 85ce2c517ade and its
subsequent fixups would be better: but that would be a bigger job,
and probably not the right choice.

 mm/memcontrol.c | 11 -----------
 mm/migrate.c    | 13 +++++++++++++
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 71fe2a95b8bd..8f2f1bb18c9c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7823,17 +7823,6 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
 
 	/* Transfer the charge and the css ref */
 	commit_charge(new, memcg);
-	/*
-	 * If the old folio is a large folio and is in the split queue, it needs
-	 * to be removed from the split queue now, in case getting an incorrect
-	 * split queue in destroy_large_folio() after the memcg of the old folio
-	 * is cleared.
-	 *
-	 * In addition, the old folio is about to be freed after migration, so
-	 * removing from the split queue a bit earlier seems reasonable.
-	 */
-	if (folio_test_large(old) && folio_test_large_rmappable(old))
-		folio_undo_large_rmappable(old);
 	old->memcg_data = 0;
 }
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 20cb9f5f7446..a8c6f466e33a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -415,6 +415,15 @@ int folio_migrate_mapping(struct address_space *mapping,
 		if (folio_ref_count(folio) != expected_count)
 			return -EAGAIN;
 
+		/* Take off deferred split queue while frozen and memcg set */
+		if (folio_test_large(folio) &&
+		    folio_test_large_rmappable(folio)) {
+			if (!folio_ref_freeze(folio, expected_count))
+				return -EAGAIN;
+			folio_undo_large_rmappable(folio);
+			folio_ref_unfreeze(folio, expected_count);
+		}
+
 		/* No turning back from here */
 		newfolio->index = folio->index;
 		newfolio->mapping = folio->mapping;
@@ -433,6 +442,10 @@ int folio_migrate_mapping(struct address_space *mapping,
 		return -EAGAIN;
 	}
 
+	/* Take off deferred split queue while frozen and memcg set */
+	if (folio_test_large(folio) && folio_test_large_rmappable(folio))
+		folio_undo_large_rmappable(folio);
+
 	/*
 	 * Now we know that no one else is looking at the folio:
 	 * no turning back from here.
-- 
2.35.3

