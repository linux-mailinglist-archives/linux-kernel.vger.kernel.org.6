Return-Path: <linux-kernel+bounces-409539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BE09C8E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982EC1F24BCA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE7219C546;
	Thu, 14 Nov 2024 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SVrMbxI5"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F251ABED7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598101; cv=none; b=B1Iw048bu3M+IRrsX705g5mrSrgmHyG5aXRUeKuN3HzFOphXEMjlADO4+9xycYKp88R0V2zOAJtOkD2mULjlpB3lPm3iLBqxBwfzmHKpwbc8sOUXiIAzCTzfyXUvzzs+NroaYsFSd3+JQlJjCjxi6eVAEncWFsYgUYUm42YWLiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598101; c=relaxed/simple;
	bh=lNhwCmzwFphLkSB9taIvs4WJ/6CHD1yuvvg662y7/aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KpZfS/wQtrYlgOPauOoHS1T8k01R+WT3M++Hw4oYArS53Dy0uTKdAwTa9WxqKyhOHF3CIfOfrKELUMnT+A3q7NCbTfHPXz7MBeelaxG7mdtYvxE6Jhj1y/vIBQbgbN72qZIlcAwzrz9jAP0wQvfG3PKPlHsmIGgB7j1scwSvikM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SVrMbxI5; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5ebc0c05e25so344704eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731598098; x=1732202898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bh4vHLcSKYCCRkbDjlhjn1EJt3wp9QgKXbTvV2Vr6u0=;
        b=SVrMbxI5HUdJ+oGYj469+T374H88/9gwfszmBpWundKS7Y43s6hygEFdIBbqJzVbbl
         SbQu0RNUsOk/eju4spW3OuP2ZOiOFKEJBKgaUppYsVUy3IAhsR/qnzoXWClNIJWMbr6l
         KNM84FWUZYttbT0yYFVwyE3DaFda1vz+18ywpMEpT3mNcEZrrwP6oC2UbW84l4cOuhlz
         76nMmzfJ67XOHJ8TvfSKs7x8gaqc7pg+eU4MJhKPp7gGQvO/gNiwLHFAZZV1kSRfBt6o
         AADvjhk/iSnKTkXutc/JyULDFSc1N4QnVNkFNWDcw3OHGy/qxG6aEEXb1O93Jkdi26zm
         RNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598098; x=1732202898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bh4vHLcSKYCCRkbDjlhjn1EJt3wp9QgKXbTvV2Vr6u0=;
        b=HcA0zynoRagxoFCgrMbzyn490eO3zb3/BEUDhHjlEfcVUyixPNLS4GmVtpnEnDKLc4
         gwaACQN4QVXOqDFHWqXKX+/goyB0sEyk9JjJ1rE1ax62aAJHXLuwClOefaF5ZUvPaerp
         ALQxmxD7af0rygPq/6jxkc9vlyGwFlDbCLosICOrLO73oJvU4wL3te7wSBY1g1WAEYJk
         Guo7ax19pBk2QAJQhrho1KafEX+nBNUdtxCjmmkvL9hvnk0olraMJWvueBP5uhdojbsF
         urVhTYE2FjkQyDRrVqaVvLWqxFWGsTc7lO9bFPRAUG+giZNuu1JLrP8BwtBe4r+dOYTQ
         Ydew==
X-Forwarded-Encrypted: i=1; AJvYcCW3pwRkIQTOmSw4GAM3nldv0mf4CYho1kRwPPsFzPiLps0GjYuaXNVksTdcl7kIVvQm9nIqefqzg+nz3RE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7OvLAMC+Xsp2iYLvVuauNH3kNTWMX/W0UFhMBYg3S70I7xpBa
	aj8SRtIT2Wdnk2WV4NbhBn8zJNpoKwMuUf4COQGAKbYOZoW0ZduZ30YjQDSwnXs=
X-Google-Smtp-Source: AGHT+IECtJqHxvsDZk559Jqz444iSDToPVSz/2QlEeAwby3Gwu7O3Iv2UCv4dhdd6n28ENyvjODyaw==
X-Received: by 2002:a05:6820:1e0c:b0:5e3:b7a6:834 with SMTP id 006d021491bc7-5ee57b9c8e0mr20035625eaf.1.1731598098551;
        Thu, 14 Nov 2024 07:28:18 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eea026eb41sm368250eaf.39.2024.11.14.07.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:28:17 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 12/17] mm: add FGP_UNCACHED folio creation flag
Date: Thu, 14 Nov 2024 08:25:16 -0700
Message-ID: <20241114152743.2381672-14-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114152743.2381672-2-axboe@kernel.dk>
References: <20241114152743.2381672-2-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Callers can pass this in for uncached folio creation, in which case if
a folio is newly created it gets marked as uncached. If a folio exists
for this index and lookup succeeds, then it will not get marked as
uncached. If an !uncached lookup finds a cached folio, clear the flag.
For that case, there are competeting uncached and cached users of the
folio, and it should not get pruned.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/pagemap.h | 2 ++
 mm/filemap.c            | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index cc02518d338d..860807e34b8c 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -721,6 +721,7 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
  * * %FGP_NOFS - __GFP_FS will get cleared in gfp.
  * * %FGP_NOWAIT - Don't block on the folio lock.
  * * %FGP_STABLE - Wait for the folio to be stable (finished writeback)
+ * * %FGP_UNCACHED - Uncached buffered IO
  * * %FGP_WRITEBEGIN - The flags to use in a filesystem write_begin()
  *   implementation.
  */
@@ -734,6 +735,7 @@ typedef unsigned int __bitwise fgf_t;
 #define FGP_NOWAIT		((__force fgf_t)0x00000020)
 #define FGP_FOR_MMAP		((__force fgf_t)0x00000040)
 #define FGP_STABLE		((__force fgf_t)0x00000080)
+#define FGP_UNCACHED		((__force fgf_t)0x00000100)
 #define FGF_GET_ORDER(fgf)	(((__force unsigned)fgf) >> 26)	/* top 6 bits */
 
 #define FGP_WRITEBEGIN		(FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE)
diff --git a/mm/filemap.c b/mm/filemap.c
index a8a9fb986d2d..dbc3fa975ad1 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2002,6 +2002,8 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			/* Init accessed so avoid atomic mark_page_accessed later */
 			if (fgp_flags & FGP_ACCESSED)
 				__folio_set_referenced(folio);
+			if (fgp_flags & FGP_UNCACHED)
+				__folio_set_uncached(folio);
 
 			err = filemap_add_folio(mapping, folio, index, gfp);
 			if (!err)
@@ -2024,6 +2026,9 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 
 	if (!folio)
 		return ERR_PTR(-ENOENT);
+	/* not an uncached lookup, clear uncached if set */
+	if (folio_test_uncached(folio) && !(fgp_flags & FGP_UNCACHED))
+		folio_clear_uncached(folio);
 	return folio;
 }
 EXPORT_SYMBOL(__filemap_get_folio);
-- 
2.45.2


