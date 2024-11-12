Return-Path: <linux-kernel+bounces-405392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BADF29C50B5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4D0281141
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA3D20ADE4;
	Tue, 12 Nov 2024 08:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUI4HFWy"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968ED154456
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400468; cv=none; b=tf3D7AukP4ZpmXP7n+pg1FKhZgUgq128k1uWQ2T4Lo6EZTVj+YALv2acsb6ZXfheie+fynYKtWRVy/AH1IBIKCCFFkgSEGDfUuB5ELtgnBaB+b6E8Z4Qgd5qJ2N8aZFEg/vtUNN7hpTQitcD+BkVwdFDzJZbLo0PJVUZajer/Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400468; c=relaxed/simple;
	bh=At0eOt8P0LjbIjIGgVeVZ7gUo5FYJ77jlQGIW1hvG+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C60IKWWncrZh3Op/+DnkG8q3K4UuzdAUPduSoOQ9MnHHTdiibq/UGlb2z1c+ruFX/QGGJNAakaMBavYy8q9n5yBCyzB1EEETffbnqhmwIsj+vuK/mCBdHaH8y95etc5zAgJtQxCekCV5SB9j/eB+/MMY33CQ4CvTmOpJOOKhtvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUI4HFWy; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2689e7a941fso3112235fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 00:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731400465; x=1732005265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mrwF4esGn5JmInQXjA96wKWFKN7/g9VujNYRkGHUmPU=;
        b=VUI4HFWyxlJVLKIIaI+OKnS+Mv8Ku/5yFFfbEFFEt5cDg2pYNqKpW9Jt+A85W3d+K6
         ZxEedX5VPUt34WIhjHwM6RXs2LWw6555V10+GpQbvt7ulxx0mnvQthCong6zAc9re+xM
         /onSe5MuPv5XoqVeTJPu9Ulp6OzdK9xS920hk2W0ShvEO5Q6b910FB52KanhnTXP0dj8
         FHRT/+nPnrB//iOmsxfJV/tz0T356OG0SWjOs328TE1/CcLZndAqQm4ZUFqKty493gBy
         ZT0e1pX1E0QVfxC0xQtF/UwuJv+FhoIpiZ2qYq5SMyWOkCPLb7LI2KrdrG489UcFJs/o
         /fWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731400465; x=1732005265;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrwF4esGn5JmInQXjA96wKWFKN7/g9VujNYRkGHUmPU=;
        b=h/3okODzPV0U7OioAB7neojI9h2b4Vf7S66gftvr+INK4TeqSlqtHEPccJobkB9VPj
         X6Gg+DgIT5X4Il0E1Tn3sST8PE/fv8cBnqiIpVdgNjk4dNurjdF/9W6q+zEok5YjOpvC
         hIOtuFWzjwBnZS286a2+uMVBR9jmNa8Yo/S7xmf/XzQqIlZLu3gXktMJ1Gpj29cKRocO
         rJ3DW0ybLg+vKCCcVgE63QfLexYbw0OAJ2AyYabyM2aB/w3olftY0pvtUwvbM6ZHFt8n
         cn5TdU+9m1FuPqZ2E79oCGtpERqahmiXzndjOAZWJ3Eb+tKxaASTfxol40z+UUblwjza
         vYyA==
X-Forwarded-Encrypted: i=1; AJvYcCVq38ftuoop6OvE/r0ywKFZreyR4hHai6NCIMdDZgjrHzQGYjnEvW5pN6bMyR8Zg0eqhyQ07xqzD2F1Uu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4eOpt8sS07RCbK6HrynHUMI3CJjym7BQ+Yzq5P94bObW/Z3ol
	U0EKjb6nJ+ODNuX6LkZM9LwzawVvbkhgVEv5W3m+NGrlpvWOcLZj
X-Google-Smtp-Source: AGHT+IFXnIkq1uAs6pS9cvPyOSonJKo7e0Gj76mQMBR29irmJ+fGEx3tclEsJ9Vs/nd5A3ztaOGcxQ==
X-Received: by 2002:a05:6871:7bc7:b0:261:1b66:5ab1 with SMTP id 586e51a60fabf-2956010aadamr12801246fac.21.1731400465558;
        Tue, 12 Nov 2024 00:34:25 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f644036sm9885452a12.66.2024.11.12.00.34.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 12 Nov 2024 00:34:25 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH] mm, swap: fix allocation and scanning race with swapoff
Date: Tue, 12 Nov 2024 16:34:14 +0800
Message-ID: <20241112083414.78174-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.47.0
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

There are two flags used to synchronize allocation and scanning with
swapoff: SWP_WRITEOK and SWP_SCANNING.

SWP_WRITEOK: Swapoff will first unset this flag, at this point any
further swap allocation or scanning on this device should just abort
so no more new entries will be referencing this device. Swapoff
will then unuse all existing swap entries.

SWP_SCANNING: This flag is set when device is being scanned. Swapoff
will wait for all scanner to stop before the final release of the swap
device structures to avoid UAF. Note this flag is the highest used bit
of si->flags so it could be added up arithmetically, if there are
multiple scanner.

commit 5f843a9a3a1e ("mm: swap: separate SSD allocation from
scan_swap_map_slots()") ignored SWP_SCANNING and SWP_WRITEOK flags while
separating cluster allocation path from the old allocation path. Add
the flags back to fix swapoff race. The race is hard to trigger as
si->lock prevents most parallel operations, but si->lock could be
dropped for reclaim or discard. This issue is found during code review.

This commit fixes this problem. For SWP_SCANNING, Just like before,
set the flag before scan and remove it afterwards.

For SWP_WRITEOK, there are several places where si->lock could
be dropped, it will be error-prone and make the code hard to follow
if we try to cover these places one by one. So just do one check before
the real allocation, which is also very similar like before.
With new cluster allocator it may waste a bit of time iterating
the clusters but won't take long, and swapoff is not performance
sensitive.

Reported-by: "Huang, Ying" <ying.huang@intel.com>
Closes: https://lore.kernel.org/linux-mm/87a5es3f1f.fsf@yhuang6-desk2.ccr.corp.intel.com/
Fixes: 5f843a9a3a1e ("mm: swap: separate SSD allocation from scan_swap_map_slots()")
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 9c85bd46ab7f..b0a9071cfe1d 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -664,12 +664,15 @@ static bool cluster_scan_range(struct swap_info_struct *si,
 	return true;
 }
 
-static void cluster_alloc_range(struct swap_info_struct *si, struct swap_cluster_info *ci,
+static bool cluster_alloc_range(struct swap_info_struct *si, struct swap_cluster_info *ci,
 				unsigned int start, unsigned char usage,
 				unsigned int order)
 {
 	unsigned int nr_pages = 1 << order;
 
+	if (!(si->flags & SWP_WRITEOK))
+		return false;
+
 	if (cluster_is_free(ci)) {
 		if (nr_pages < SWAPFILE_CLUSTER) {
 			list_move_tail(&ci->list, &si->nonfull_clusters[order]);
@@ -690,6 +693,8 @@ static void cluster_alloc_range(struct swap_info_struct *si, struct swap_cluster
 		list_move_tail(&ci->list, &si->full_clusters);
 		ci->flags = CLUSTER_FLAG_FULL;
 	}
+
+	return true;
 }
 
 static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si, unsigned long offset,
@@ -713,7 +718,10 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si, unsigne
 
 	while (offset <= end) {
 		if (cluster_scan_range(si, ci, offset, nr_pages)) {
-			cluster_alloc_range(si, ci, offset, usage, order);
+			if (!cluster_alloc_range(si, ci, offset, usage, order)) {
+				offset = SWAP_NEXT_INVALID;
+				goto done;
+			}
 			*foundp = offset;
 			if (ci->count == SWAPFILE_CLUSTER) {
 				offset = SWAP_NEXT_INVALID;
@@ -805,7 +813,11 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 	if (!list_empty(&si->free_clusters)) {
 		ci = list_first_entry(&si->free_clusters, struct swap_cluster_info, list);
 		offset = alloc_swap_scan_cluster(si, cluster_offset(si, ci), &found, order, usage);
-		VM_BUG_ON(!found);
+		/*
+		 * Either we didn't touch the cluster due to swapoff,
+		 * or the allocation must success.
+		 */
+		VM_BUG_ON((si->flags & SWP_WRITEOK) && !found);
 		goto done;
 	}
 
@@ -1041,6 +1053,8 @@ static int cluster_alloc_swap(struct swap_info_struct *si,
 
 	VM_BUG_ON(!si->cluster_info);
 
+	si->flags += SWP_SCANNING;
+
 	while (n_ret < nr) {
 		unsigned long offset = cluster_alloc_swap_entry(si, order, usage);
 
@@ -1049,6 +1063,8 @@ static int cluster_alloc_swap(struct swap_info_struct *si,
 		slots[n_ret++] = swp_entry(si->type, offset);
 	}
 
+	si->flags -= SWP_SCANNING;
+
 	return n_ret;
 }
 
-- 
2.47.0


