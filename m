Return-Path: <linux-kernel+bounces-560036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB25BA5FCE6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE11E7A5038
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E1F26AA8C;
	Thu, 13 Mar 2025 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOwJDeMX"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DAB26AA88
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885281; cv=none; b=btX/wFHdBAAUGmAKZCA8K9zphHwGd1OQp9ciuXR5XcbFb+0gqsjA2S6uRGPTGRLBrNz4Y9HDTRmx+cOLxRf2GqYwCJU6AS2Mx6G24AK2aF1gg0XxpXS63iSINrW+YEMC7mgmsqTJFgAhJGo+O2YjtzpPhIWHzzGrSxc2eKgL9RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885281; c=relaxed/simple;
	bh=CKet4m8V3++JJj6egp5O6U4HIkFGKFAGQObq/K0Fa08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Go3lGFVGPIOta7kvZxFrkDp0G4xRRHK0RMjTIIUATvFyu6J6zKHwVSt2c7x4cPEg1jyxPSj9KB0kWn3VMi5+9sF6+2iczfQpFwpaZuZlCSS4E7rNXHxrX1lSnZvOUACD8DM4ZQpi4BNaAqzq8taTWpl6C7V0V2gzER8VQ2iqUKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOwJDeMX; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22423adf751so19963065ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741885279; x=1742490079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nUQ+OrAh02CbWtjPdQxW9RlcKT1xdT7Rpo6ksTT/P0Y=;
        b=mOwJDeMXAheJUlyiTrI/PYWU/nw28LfMI5YOZaKbV2RtXOJ/kxltGfg5ucGkWKeH23
         IKm/1PxkMUv3s3KMv6BFIUUHZAJdnfSfbSs4TWaIAhlrmeBE0QXcpW0Q1ROG5IeHD6+D
         +4MIPUhYwJgFj4wv4Z+6TDAmVAU//B30D+Bfx0SwnopSi517AIfIwoB0FTMwMylxaAYU
         6GhHPZmyFRz+Jc4gBnN6oFZTnt1SByvDFTd60JGwOGCXzDmnLY8vwUA06b51nusqIZyr
         VgenVPAIKxCL0n6xdo0cSCvaub+/QhuqB+vfOjMzTV28Bbrhn4aArln1roI624w0rmxp
         kpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741885279; x=1742490079;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nUQ+OrAh02CbWtjPdQxW9RlcKT1xdT7Rpo6ksTT/P0Y=;
        b=AciLOxgjxuL6Er7pYd9HyEUjhtkGmcBLrwzPOeukSy/O+az2zkEBSGzTbMtGXAgsg9
         74+KUbJ/lzoL1mLdpTufMBz/fQxpmVP2kfKyBp2VbhiviDPoJgUTU+p39OJ/opa5qwLL
         2japNogiqi0zqhCIGbUY9HRYehVQ50I+5ELLLBtxg40RoK3AUUPtyaKFK/DRBApc3dL+
         RQQlU1jsXzOlh+qllsz3vqGWS5fEq1/2PwErGD9UJNbsQr2Isg+NtoJoSKdDk1fGXY3B
         SxjTkiAl1gFpUxLUIVHwng/zH7z0dGY6ZBV2h+jeRzHD+A0CfoSUMPeIVKcud1dwmLBw
         PiIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyd+Y6uMKfla6cXvRHqmZYHuUdgvZwdHMc5FlxQ9LQTA2Vl4/X/DeVkRJk7FhiLo13GfxCWdYv+r5BSnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyshFX0eCiExNydkt3uJwo9gIwDnqLbyyMPjN/Spn3HuQKtlcZw
	BCEzawyuP0uk/7PJsK9lrL/uQVKWhmqeZsZshl15wGIDnZF6aaNl
X-Gm-Gg: ASbGnctDgemTKpOmkiaDWe+r4WXqGoJjFQdXlFadJD6NPP3Gc/85gJ/fAOepcYS+yo2
	JEG1gIvg21qXvXb4dxAicTPIn7ViEdhL1UzvrujIvjzBXCjVDNJ/9dqzEky0H4qsTwwahuD2j9M
	+Qv0X3MEUEaumEI7dCDr56Crf7IJJM4XaR45iN03rPNDu794RX2om9kSvhcqYopcUdmqxNdkqAU
	wAdcGblR6pKQ+o86Tb3HQwSF2mZ6WJRkjENgQOl6o3wYPxNMVLvJQe8hOYQ7LnCc4x5s+Fexg7M
	ZvyDQzJhr6vnF6qA6khkT7bFlRWp5bMRjBhYcdCoq/vwcymFOdo4ptPOla2U0MNkkA==
X-Google-Smtp-Source: AGHT+IEtL0owIxoYlBZ71gxEIW/LFwX9S1V54rOpGhTHmxstlznzvgnxMsNk+OzJF8x7byESxSp3WQ==
X-Received: by 2002:a17:903:1c8:b0:223:26da:4b8e with SMTP id d9443c01a7336-22592e21948mr178552515ad.4.1741885278863;
        Thu, 13 Mar 2025 10:01:18 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.123.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167df0esm1613529b3a.93.2025.03.13.10.01.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Mar 2025 10:01:18 -0700 (PDT)
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
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v3 1/7] mm, swap: avoid reclaiming irrelevant swap cache
Date: Fri, 14 Mar 2025 00:59:29 +0800
Message-ID: <20250313165935.63303-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313165935.63303-1-ryncsn@gmail.com>
References: <20250313165935.63303-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Swap allocator will do swap cache reclaim to recycle HAS_CACHE slots for
allocation.  It initiates the reclaim from the offset to be reclaimed and
looks up the corresponding folio.  The lookup process is lockless, so it's
possible the folio will be removed from the swap cache and given a
different swap entry before the reclaim locks the folio.  If it happens,
the reclaim will end up reclaiming an irrelevant folio, and return wrong
return value.

This shouldn't cause any problem with correctness or stability, but it is
indeed confusing and unexpected, and will increase fragmentation, decrease
performance.

Fix this by checking whether the folio is still pointing to the offset the
allocator want to reclaim before reclaiming it.

Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
---
 mm/swapfile.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index a7f60006c52c..5618cd1c4b03 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -210,6 +210,7 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	int ret, nr_pages;
 	bool need_reclaim;
 
+again:
 	folio = filemap_get_folio(address_space, swap_cache_index(entry));
 	if (IS_ERR(folio))
 		return 0;
@@ -227,8 +228,16 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	if (!folio_trylock(folio))
 		goto out;
 
-	/* offset could point to the middle of a large folio */
+	/*
+	 * Offset could point to the middle of a large folio, or folio
+	 * may no longer point to the expected offset before it's locked.
+	 */
 	entry = folio->swap;
+	if (offset < swp_offset(entry) || offset >= swp_offset(entry) + nr_pages) {
+		folio_unlock(folio);
+		folio_put(folio);
+		goto again;
+	}
 	offset = swp_offset(entry);
 
 	need_reclaim = ((flags & TTRS_ANYWAY) ||
-- 
2.48.1


