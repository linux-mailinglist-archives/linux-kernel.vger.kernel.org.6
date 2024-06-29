Return-Path: <linux-kernel+bounces-235078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3180391CFB7
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 01:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B161C21095
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 23:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F3713211E;
	Sat, 29 Jun 2024 23:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnarpeiC"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B749F224CE
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 23:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719704529; cv=none; b=QBolLB7EVvlUNGTVv76kTwUhq3oyFSOew2vrK6ZFcstndpVFHwACUqH9BNME+YZ9VSkhHzJrcCBh1NCbrfFV2PMtelnE36ehSztavBCoGQPzgsrDocF68damTT2j0Q665V5n0aCPlAufI3X5HKf79irupI6sAweaDjoW094JTb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719704529; c=relaxed/simple;
	bh=/RVI+NuTW83Ntxmw+C16AWLP8jraqs9TGJc2ijesKGE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SwNNFYKcGkqbiqudePctk8PzqYYVS89hglUt/RWBNgnoDkr6s8uaVhMRdvows1H+WAEknkLPnWDSu1RlD/sH613W68jnnnGjnHdubF1sz89QcZ34hiEVrK/EjrqNfWsZbisLFyfMjoXOplHg0nPrHRmWVO4zMMYph9jd+SozSfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnarpeiC; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70a078edb8aso713099b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 16:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719704527; x=1720309327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlOndXAQYIA/gkCwrk2GQEBTFD9obTR1n2sQ+YWZvbU=;
        b=TnarpeiCD9f8+G7/B7EUPUMI2NIERIKiFLaIj7Y3CuZljKxXclircLHb6+JNaTocgh
         AcnBFAptTU6RfdYRCbewYyR+83d2fTqS4CxWBvFI85ddkxbfjgf61VKfBkgOCySM41Dc
         qvt4bcma0cQ9EO7HXLRA+/OBC/f7vg9ZjpEPn9/iY3soUa/iFJI25+m13bBeBhg+SI0x
         uwW/Pubhd++H2wgKg8xZzWEZUQYYcKNi+hU1+IThGaAZg6ik0uRa2mlgCK1WtRDKddVZ
         3Ao3eVZqAjtCkV5PwzTuGwM7+QsQKWHS04mpzG8U8vmreDkKQV0yAFrmb9TGJxdgASem
         J5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719704527; x=1720309327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZlOndXAQYIA/gkCwrk2GQEBTFD9obTR1n2sQ+YWZvbU=;
        b=ozKholfL/CHD2Uysn44L61ipnlJ8BckG+mYZYDYFdz3Olq5geadNa1mmNR2f6bU6Bv
         X48kxlkVw4Qut8gnjgKmHjlvlkBmoy6T0IIBJes/Di339w6ISyrEjLD55cKRkUk/vaBN
         96uSLmN04TN/Ykj3QNi6Xk/oIs8HsHXy2rdWDy2DIul75CDuETuTAdSv3UGz6rBvP0NW
         RrQvN7afqEoXyrnsySvlhW35yzH/tahdC9ntPKgYzfqhovAgdkwJv2r0/6Ne+2UVNqW3
         NKT23yppDdEK9e85yuBqOobC1nr5SpImrZRnubCACqfLZ/LF5PDyrntzS9+dw2r6V61/
         FUiA==
X-Gm-Message-State: AOJu0YxW8ev6cqELWx3mjFvHrajFhit/xHXtNqdhQh0KIlWzVLnqmhk2
	Jb9K9uBRpDnJNCd/8LruZWT30CEbYiTD5deKVIYlGpmBoRsnMf4j
X-Google-Smtp-Source: AGHT+IHNvRvSLdv6mjuw6V64R4JnaBcm1WHMuRvefgESl1YG1bBt/ZuuPsKKx3UjbO2Vvrq6vxH+AQ==
X-Received: by 2002:a05:6a00:8c9:b0:705:a9d9:62b1 with SMTP id d2e1a72fcca58-70aaabc0162mr3284197b3a.15.1719704526992;
        Sat, 29 Jun 2024 16:42:06 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080498a021sm3760061b3a.203.2024.06.29.16.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 16:42:06 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: [PATCH] mm/vmscan: drop checking if _deferred_list is empty before using TTU_SYNC
Date: Sun, 30 Jun 2024 11:41:55 +1200
Message-Id: <20240629234155.53524-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

The optimization of list_empty(&folio->_deferred_list) aimed to prevent
increasing the PTL duration when a large folio is partially unmapped,
for example, from subpage 0 to subpage (nr - 2).

But Ryan's commit 5ed890ce5147 ("mm: vmscan: avoid split during
shrink_folio_list()") actually splits this kind of large folios. This
makes the "optimization" useless.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
---
 -v1
 * I remember David and Ryan once suggested that this check could be dropped
   while the patch was being pulled into mm-unstable. However, for some reason,
   I forgot to request squashing this change.

 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 3d4c681c6d40..0761f91b407f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1291,7 +1291,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			 * try_to_unmap acquire PTL from the first PTE,
 			 * eliminating the influence of temporary PTE values.
 			 */
-			if (folio_test_large(folio) && list_empty(&folio->_deferred_list))
+			if (folio_test_large(folio))
 				flags |= TTU_SYNC;
 
 			try_to_unmap(folio, flags);
-- 
2.34.1


