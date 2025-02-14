Return-Path: <linux-kernel+bounces-515455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7448A36517
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD623AF39C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FA7268C7D;
	Fri, 14 Feb 2025 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDfmuN/n"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6B0268C74
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555914; cv=none; b=DHAi9Ll/IuHzNeV0O2zzXQsswH/xAaQuJEZGT+elVa+6uNAWXjsU/D9jQ7nslhUsvquWUMLNfduaHH/p9b218+VpWCgiQPftUSViFFym0c7dFlRI28jzZS6E4kQljiPxDeYOOJuPFQp+TmsYegeosZSxqIuAFPVyXAfeONDLyBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555914; c=relaxed/simple;
	bh=65uh01PCJ1pLc0j2C8CpxLDOIn18OEFNsiMWcc6F3VI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dly6+QE4qD+5rSAhfAUo1+AErP2XbAf8TjHwET0gqrs9P67ZbIlKsvAkSf9SXxyxke/2YyDFpVfhkGOb30T3cPU1z1Ea0HClY2VCMzg0GfnuVx5q4SAVaXJja+OEe0V+vzgXtSOZEeQFrCezRpLITtx1PsNFgWaDkHWkTYIjOWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDfmuN/n; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fc291f7ddbso2029950a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739555912; x=1740160712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gKbcT7HZi918XHMs4NWM+gGN3vz3fffmbZA+qEY+PV4=;
        b=GDfmuN/nEDaHiCPvPRWDH25Tk0IJVKJXXWfGwF7ZCdjRjR16Je2ijdw07XJgEzQN/v
         b81OZF/2XW0SguBWcY6GcRME9Gyuf+Ca/AhonLaphXzohtY+PSd05VD2nk69jmgDKxfU
         XQmhIPUfl2cdUPqzOwiNrYSAaGAWVoTbaOJkSy8SkS2g5KzdcbLDTGp9RlfSutZTPG71
         78Ip22Xc836S9kmY78vDiyyQvuE8sRSwmtQNEdCU+cwrYc29Vje0upbLPVlRBr1rKocx
         vrnQGY1sNrO3PbFjhEi3wKA9twrXPujf+xKyjtfd28lRMdwqlbRp8Ssk1+BltZEEgP4B
         nD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739555912; x=1740160712;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gKbcT7HZi918XHMs4NWM+gGN3vz3fffmbZA+qEY+PV4=;
        b=tjlWfy1aO/3evxlHSX2wm1JDlXwxmQL32+5IeLcPMJP0VVeKJ1wp632ZNx6WUKBCjT
         vrnsax3240rxSJvnXqikBZW7DG8Gz1vXZF6qn0R+xAqDn9j/2QYqLccE+3LTQ4dqa1aQ
         fiTQidwol1Qjz8n39d1yOz2t5GNJjkTgsu7Q5g2AgvgBpPHh+kk8854k5wuAkQJJd6Wl
         Jngf+sS5ilPrn1OvVYlnttn/JYGXURsx5hCOm9Mp1rpCWQjP/OWL01Gq/VjGg3+KyU46
         /iS/6MJv3ilvIyxupgb0wbGIJTAAwWiBtfgJB0LYNCthe/ZaHC44fAmRGyuNs6cRfh3b
         yfnw==
X-Forwarded-Encrypted: i=1; AJvYcCWIaaQDhD/V6t5Lb32aAGUc4hwuKvtK6uRJRud3t2+2WwvHdfxHzPQqqOTEF8YHsD+qzaaHy0fZa6m7It8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpo91foydzcqMQHu5F5TiemTYPpXRdYWonhCZQNFZ/MM+BntU6
	shE4HwOXonASOeBOaOyI6vvZapqZQUo+2ej3qldujhVfkf9/Qkoe
X-Gm-Gg: ASbGncsbhrYBbBLpzIKHPycAQhS3twcmBDLXDL0sAp5HA2C/GU0HS6JATOb+nEt/ZAl
	i8zxd88dOSztXF60uiesp6o9ZRS95hA82AUmbStZdqKX0xRob1gggis0Xuev31iTr6ePqhq3v4x
	3Hu0QXGxzF+mP1rbRuixeyhOFS3Loj88BpaVuaBd1XMQRX+RMMPu7w2z18Wd1kQHv8jIBKIPc+R
	5D+G6v2txMXpnVLjlCJrvKi0BsfD0bxjAQraciOhwywTY1qzlkK6H5qZGMpRHyqTps/OLcQxTXZ
	zR5B2GGEdKgSCbBUEn0+85nmogvMpdydTVfy
X-Google-Smtp-Source: AGHT+IFvP7YLzoold6ZoZzlfgGVoTuFDtB0G5EBYz929UfitJI5tbELQqHkPOfuQHwIrnMxFrJEGPA==
X-Received: by 2002:a17:90b:384b:b0:2f7:4cce:ae37 with SMTP id 98e67ed59e1d1-2fc0e4c17b5mr14365273a91.18.1739555912471;
        Fri, 14 Feb 2025 09:58:32 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([106.37.120.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55943b5sm31216605ad.246.2025.02.14.09.58.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Feb 2025 09:58:32 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Baoquan He <bhe@redhat.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 2/7] mm, swap: drop the flag TTRS_DIRECT
Date: Sat, 15 Feb 2025 01:57:04 +0800
Message-ID: <20250214175709.76029-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214175709.76029-1-ryncsn@gmail.com>
References: <20250214175709.76029-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

This flag exists temporarily to allow the allocator to bypass the slot
cache during freeing, so reclaiming one slot will free the slot
immediately.

But now we have already removed slot cache usage on freeing, so this
flag has no effect now.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index c77ffee4af86..449e388a6fec 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -158,8 +158,6 @@ static long swap_usage_in_pages(struct swap_info_struct *si)
 #define TTRS_UNMAPPED		0x2
 /* Reclaim the swap entry if swap is getting full */
 #define TTRS_FULL		0x4
-/* Reclaim directly, bypass the slot cache and don't touch device lock */
-#define TTRS_DIRECT		0x8
 
 static bool swap_only_has_cache(struct swap_info_struct *si,
 			      unsigned long offset, int nr_pages)
@@ -257,23 +255,8 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	if (!need_reclaim)
 		goto out_unlock;
 
-	if (!(flags & TTRS_DIRECT)) {
-		/* Free through slot cache */
-		delete_from_swap_cache(folio);
-		folio_set_dirty(folio);
-		ret = nr_pages;
-		goto out_unlock;
-	}
-
-	xa_lock_irq(&address_space->i_pages);
-	__delete_from_swap_cache(folio, entry, NULL);
-	xa_unlock_irq(&address_space->i_pages);
-	folio_ref_sub(folio, nr_pages);
+	delete_from_swap_cache(folio);
 	folio_set_dirty(folio);
-
-	ci = lock_cluster(si, offset);
-	swap_entry_range_free(si, ci, entry, nr_pages);
-	unlock_cluster(ci);
 	ret = nr_pages;
 out_unlock:
 	folio_unlock(folio);
@@ -707,7 +690,7 @@ static bool cluster_reclaim_range(struct swap_info_struct *si,
 			offset++;
 			break;
 		case SWAP_HAS_CACHE:
-			nr_reclaim = __try_to_reclaim_swap(si, offset, TTRS_ANYWAY | TTRS_DIRECT);
+			nr_reclaim = __try_to_reclaim_swap(si, offset, TTRS_ANYWAY);
 			if (nr_reclaim > 0)
 				offset += nr_reclaim;
 			else
@@ -860,7 +843,7 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
 			if (READ_ONCE(map[offset]) == SWAP_HAS_CACHE) {
 				spin_unlock(&ci->lock);
 				nr_reclaim = __try_to_reclaim_swap(si, offset,
-								   TTRS_ANYWAY | TTRS_DIRECT);
+								   TTRS_ANYWAY);
 				spin_lock(&ci->lock);
 				if (nr_reclaim) {
 					offset += abs(nr_reclaim);
-- 
2.48.1


