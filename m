Return-Path: <linux-kernel+bounces-218428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F0790BFB0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50647B23140
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1097619ADAC;
	Mon, 17 Jun 2024 23:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVUZJNms"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1EC19A2AA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 23:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718665935; cv=none; b=GHq/XT1753oQ4Ss/jrJfo6TYq8tRA8OJ/dSjhPSSS8osqjt0fVMuJBG4qGsiXdhRGWteT/n4Q4+x3DDzUcRgNTm1db6FN3ewaM2pDtVATY17zLjyX9pUlFPoGiuy0xQ3gQ9xARRRm5/Wc3z/WARQUXNOgNihD0Aa5hqRSAEyVOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718665935; c=relaxed/simple;
	bh=4kFuv42JY+J3CylIFBI+kob0JSIsHTaFPp5A1KUGikc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R83zrf9cUek9QKq5Z6hpbSYL4rxidN5Bume4bKnTEvS2Zs5Pet/girKEfMRXDqVFHmGoDWwgHkKR4Zcl9qNyUMELfAaiEmi63f+7QloPCF1pPG/Miv53stBx4SQRZFEfiujoNLgkyGsL5mIYSujFOS0Wb3RnQHcht2e9U6XXzp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVUZJNms; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f44b45d6abso36675255ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 16:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718665933; x=1719270733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGQ6SzdfrQSO5xjCxNwiBFuEcECCL6Ck79QRnw+gZuY=;
        b=OVUZJNmsSlz60clHG3Gt1DonSPziQ2vmKgpECLkyZk1OR09+xcKAPvYrneohds0yQx
         MNu2cDFsRdGDEPteke58zGpiZP4wYEgsdp78WMwPi1eDSbUpecgMWPW8u6OqsbkDlEwa
         ErEQxKhBnRGDCC12EF2sP+PYLCcPE12pvZdLIlqZRyuc8AjYp9QdrFMvWBm5p2xceqIl
         s/R+vR2WD7l1PFHloRe+xScp07R0jAbnPXOSavugriVdTua/sQ+pxmR9YHO58c7vvp2I
         2zFHuaOBPaMATY7/tkE9mwIu91AgWEKL/aV/M/lJLgBC/JHwUBERmkKjmdKL6ADW9US6
         D3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718665933; x=1719270733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGQ6SzdfrQSO5xjCxNwiBFuEcECCL6Ck79QRnw+gZuY=;
        b=Z430VBufeEdXX+aZi9MfJ3U4BbHq2MyI3j4D27FSZsk9sNYOei3FRLR1xi2YG00nAX
         OG6+qcL+OY7IfqnwE5Uox17w20DgqlDZ6jaiWHd7kCmQ0fY/pKoQTa7ucBCEu77T16G4
         cu7PWN0CjhNMbRCPrd6Qd3umRAub+ih9N7je2MVMGplBxXXe+tJk9rtdwpNL4jedp6s4
         Jvx9dfNzq15Id4zxwfsm60NLOaK0ko6kN9kWtrTgOVuBoFeZSlrIW0G2AjZTtLzHq2XR
         9BO0AQ7tdvDdDEwKbQdRHtT5j8JZ94N3XAJM6cyHz5yjUqd+426TsEaZbGaTDliGO4aO
         LTIA==
X-Forwarded-Encrypted: i=1; AJvYcCUHDqM2tufGqB1kZLrRlRnPiVLcjTvDJT0T1UcEabhbKAZOfRlYJYgyMxOdG3PM+9LwAXDzqOeX+O4GoiJvq5Qj4RGgb70Mh5vWDkso
X-Gm-Message-State: AOJu0YyrYs2DFAqHV0vWF/1sdy7oDAGCTgDTGdG6qFtCkI2UwE02dEJ+
	7Ws58yTtRORJ7yrDc348hGadt5e0CLEGQak7T/YqIFaz1jnrKF3R
X-Google-Smtp-Source: AGHT+IGdavghqDun57MXIuOzQguy6J6tZOKWjsQvvQ/r2qtBVtLUA3Gz519TstrQYTx82XqkXwmIAw==
X-Received: by 2002:a17:903:2305:b0:1f7:eb9:945a with SMTP id d9443c01a7336-1f862806364mr90512405ad.44.1718665933275;
        Mon, 17 Jun 2024 16:12:13 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e5a0d5sm84658605ad.43.2024.06.17.16.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 16:12:12 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	Shuai Yuan <yuanshuai@oppo.com>
Subject: [PATCH v2 3/3] mm: remove folio_test_anon(folio)==false path in __folio_add_anon_rmap()
Date: Tue, 18 Jun 2024 11:11:37 +1200
Message-Id: <20240617231137.80726-4-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617231137.80726-1-21cnbao@gmail.com>
References: <20240617231137.80726-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

The folio_test_anon(folio)==false cases has been relocated to
folio_add_new_anon_rmap(). Additionally, four other callers
consistently pass anonymous folios.

stack 1:
remove_migration_pmd
   -> folio_add_anon_rmap_pmd
     -> __folio_add_anon_rmap

stack 2:
__split_huge_pmd_locked
   -> folio_add_anon_rmap_ptes
      -> __folio_add_anon_rmap

stack 3:
remove_migration_pmd
   -> folio_add_anon_rmap_pmd
      -> __folio_add_anon_rmap (RMAP_LEVEL_PMD)

stack 4:
try_to_merge_one_page
   -> replace_page
     -> folio_add_anon_rmap_pte
       -> __folio_add_anon_rmap

__folio_add_anon_rmap() only needs to handle the cases
folio_test_anon(folio)==true now.
We can remove the !folio_test_anon(folio)) path within
__folio_add_anon_rmap() now.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Tested-by: Shuai Yuan <yuanshuai@oppo.com>
---
 mm/rmap.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 2b19bb92eda5..ddcdda752982 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1297,23 +1297,12 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
 {
 	int i, nr, nr_pmdmapped = 0;
 
+	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
+
 	nr = __folio_add_rmap(folio, page, nr_pages, level, &nr_pmdmapped);
 
-	if (unlikely(!folio_test_anon(folio))) {
-		VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
-		/*
-		 * For a PTE-mapped large folio, we only know that the single
-		 * PTE is exclusive. Further, __folio_set_anon() might not get
-		 * folio->index right when not given the address of the head
-		 * page.
-		 */
-		VM_WARN_ON_FOLIO(folio_test_large(folio) &&
-				 level != RMAP_LEVEL_PMD, folio);
-		__folio_set_anon(folio, vma, address,
-				 !!(flags & RMAP_EXCLUSIVE));
-	} else if (likely(!folio_test_ksm(folio))) {
+	if (likely(!folio_test_ksm(folio)))
 		__page_check_anon_rmap(folio, page, vma, address);
-	}
 
 	__folio_mod_stat(folio, nr, nr_pmdmapped);
 
-- 
2.34.1


