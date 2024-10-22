Return-Path: <linux-kernel+bounces-376853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178EC9AB6C7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0811C232D4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8F61CBE96;
	Tue, 22 Oct 2024 19:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQlT7m+/"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222531CB32A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 19:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625393; cv=none; b=jhRX2cVuEV4IHjVc2UIIcWJ1R7pkJah5g3l++fWp7zo+urs8YaiJuy2pHO2dsu3uF2/LHH4odlbX+M5f1EuE6XORmULkeCU+jsl+EccLc/K46TaiIrz393AolcblStuip8jReQ0UlwFoku+X9wjVr/KKGv5j/AmVwH9qWugptag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625393; c=relaxed/simple;
	bh=mu+293/6zhp2wt9TGN1VdqjlUJ7m2B4LDDL9My/DXvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBPnkl7ynzd7Cig+940a3GlcC0n0gmaDPgClt0k2FrvlYuM0tFcL5uA58NywGEmsxPNgJokSdSfis2q5mj9y41xthcbE/Bvvjj0D7VtNzaYykrRoFnKF0mVoXK1zMhPz7QvV3r9bQQGTBq/QxBu8uAZyHsuZDE7fXMKFtUf3tqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQlT7m+/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20cb47387ceso54187715ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729625391; x=1730230191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0kiDuJ4tEKZSj0qaWySVrFhdnZUjCFe9iUFsOZ0gkhE=;
        b=LQlT7m+/R7vwqdObI2RtBh2KjxUjGRrX1X2NI8KNcZ+XZQQDj+rTy0cwupThPf3+sD
         OlJSgqoNZX1N8T/xlj3DCCv+PLUy0jundACrHyGGaYFf+MN4gU+0qTYoWRipw7//RUv0
         JH5IdrKCR+NnaVqXYgpJz+/Sn32zMPnCdhFydAynfHIn9lGt2YMvpJfL9+vvfQnt8kCZ
         0a5FXfQLn3F21PP0yu52u0cDcMqGJx+pCQCYB2K2GRazaUCuJOd++Luj1wRskgdqHeVM
         RXewajIzi3ELtHdT7UOPTvw7ciihBQFlvtuRpVGxf6L0P8I7+3GYs4+N2Y4FGQwjkbPM
         LcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729625391; x=1730230191;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0kiDuJ4tEKZSj0qaWySVrFhdnZUjCFe9iUFsOZ0gkhE=;
        b=K/3nYnUrCNfIoMg9VxA6Opd4EJyaPTIa6ROggqW3r4oRIBKgOBLF8V6ArpJj/bOEqY
         a3iXoJUvQUENWzicvgidH1mghFLbaVgLucQJ1UXJme17/zGr4f78FrltCAnsRgbSoQCk
         RjjeWFXnYBST3ikfT5GFZ9uf7dpQrTn+zIR4pZixI/+AHjBhhETobTMCOdNTu6Aikfge
         YQ3MEfoCNFTRvUaZpnVRmW6+0F439fOuTAadHIJb2u1Igh2MPb61DO1f5tsfvQjb5QCw
         /aujhmsGG4twUWSdnF4pr2vEMdqhsWgt9Oo5ZyWAlLBnOJyYShtBxqCGpZXQuytvZOtQ
         Bpxg==
X-Forwarded-Encrypted: i=1; AJvYcCXBe70oQA8Zzppz4F2XfPdCShpupU2aV8rjhOZ9PLkHdQ0MPd9tvP565L4hWG283jSJRLkGcaRjVYM/Tw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/bAhE4VP7Sb4O9FM4OUG5qSVWeUKOfHo4wZooa7PxU956cClu
	dnlD5E47pC0dhMqN6KUvoOVtz54rvfmTEhb04dF7VzJGBaLMgaaC
X-Google-Smtp-Source: AGHT+IHJ/mmbPeQO7m1JzLu61hvPRuxTG4vZV7GSls5xo1lWKGBwkK8GicKhDQOEb/5V/S1g/+bTNg==
X-Received: by 2002:a17:902:db06:b0:20b:c1e4:2d5d with SMTP id d9443c01a7336-20fa9e72980mr2645385ad.34.1729625390976;
        Tue, 22 Oct 2024 12:29:50 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.123.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0d9f05sm45895305ad.186.2024.10.22.12.29.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Oct 2024 12:29:50 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Nhat Pham <nphamcs@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 02/13] mm, swap: fold swap_info_get_cont in the only caller
Date: Wed, 23 Oct 2024 03:24:40 +0800
Message-ID: <20241022192451.38138-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022192451.38138-1-ryncsn@gmail.com>
References: <20241022192451.38138-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

The name of the function is confusing, and the code is much easier to
follow after folding, also rename the confusing naming "p" to more
meaningful "si".

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 1128cea95c47..e1e4a1ba4fc5 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1359,22 +1359,6 @@ static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
 	return NULL;
 }
 
-static struct swap_info_struct *swap_info_get_cont(swp_entry_t entry,
-					struct swap_info_struct *q)
-{
-	struct swap_info_struct *p;
-
-	p = _swap_info_get(entry);
-
-	if (p != q) {
-		if (q != NULL)
-			spin_unlock(&q->lock);
-		if (p != NULL)
-			spin_lock(&p->lock);
-	}
-	return p;
-}
-
 static unsigned char __swap_entry_free_locked(struct swap_info_struct *si,
 					      unsigned long offset,
 					      unsigned char usage)
@@ -1671,14 +1655,14 @@ static int swp_entry_cmp(const void *ent1, const void *ent2)
 
 void swapcache_free_entries(swp_entry_t *entries, int n)
 {
-	struct swap_info_struct *p, *prev;
+	struct swap_info_struct *si, *prev;
 	int i;
 
 	if (n <= 0)
 		return;
 
 	prev = NULL;
-	p = NULL;
+	si = NULL;
 
 	/*
 	 * Sort swap entries by swap device, so each lock is only taken once.
@@ -1688,13 +1672,20 @@ void swapcache_free_entries(swp_entry_t *entries, int n)
 	if (nr_swapfiles > 1)
 		sort(entries, n, sizeof(entries[0]), swp_entry_cmp, NULL);
 	for (i = 0; i < n; ++i) {
-		p = swap_info_get_cont(entries[i], prev);
-		if (p)
-			swap_entry_range_free(p, entries[i], 1);
-		prev = p;
+		si = _swap_info_get(entries[i]);
+
+		if (si != prev) {
+			if (prev != NULL)
+				spin_unlock(&prev->lock);
+			if (si != NULL)
+				spin_lock(&si->lock);
+		}
+		if (si)
+			swap_entry_range_free(si, entries[i], 1);
+		prev = si;
 	}
-	if (p)
-		spin_unlock(&p->lock);
+	if (si)
+		spin_unlock(&si->lock);
 }
 
 int __swap_count(swp_entry_t entry)
-- 
2.47.0


