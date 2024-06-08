Return-Path: <linux-kernel+bounces-207093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 194E690124D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 17:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493C51F21458
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 15:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E1017966C;
	Sat,  8 Jun 2024 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2ACCiU+"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DDE1FBB
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717860096; cv=none; b=ZIhllSSWHNvubtO5IzcPaHal+rUvaCJer6xlhAcCqDkcSTMZFeomvnFU/RMQ6HOuhFnqMgquXmp+hRWqxl8NSF+jVfrGIdVEZ4J4i9AIdkVOfhzcZOA2KOHhhdlpLCctebX4b1r3SPTA7q0ZPR6wrwiyug8RJ4zRSSHdGKXzB4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717860096; c=relaxed/simple;
	bh=c3fAQ94gxpTm0NtQbFgt0zdjDN0GCHf8fZ6KrnECQP8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NetUiM4pMx0HlqeCIeOJl8e1rysB1dUG9UV2LG+EDbrGVZJ61PDJGwyWreos9htv3rv4u30JIwwGJdnviv/GEmIu8k6pfWpjI1FZ/dbFURj2acjFjk6LTfcoK6kV5CctAlC40vJZBra5KWGIfSHeOHSrFNecpqB5lzXS8Fhw+gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ooseel.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2ACCiU+; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ooseel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-704313fa830so91328b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 08:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717860094; x=1718464894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=g+bAMmPzB9gsmQSRxGIuKdSULelXghzr1XiJuVK629g=;
        b=C2ACCiU+X8JU9RwSPsQ+R0WbX8nNk1vf1IeWROHxYaKZzL+vxtf0RJer0ojMPa1Ld1
         hUxzMxsh4iKW6diaINBQJwsNAmjrglacqvqd3NPkP9/u7DLS7EDLOXbeEdsLJSgm3OuP
         LSYDibIQ6pPB5YzOnZla0m2WZb+MtfuW11xOZSQ0qTetsgf/+i4+BjK+QnSjqfsXRuAH
         +ZMiWfMGDwdcL9baHP0myRb1kRWcyYpvNnB1yI4N4ngUWzZxa7I3InpFfg7fXaQy3OZN
         RImFn8NAPnrPm2N71q5ZuH6rHA5L5EMkvHyn2rMQCfpIAICi43cOh8x6tzAPTTbCNilQ
         gTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717860094; x=1718464894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+bAMmPzB9gsmQSRxGIuKdSULelXghzr1XiJuVK629g=;
        b=DBf5nP+g9Et6KbhF/MDxyqiqXP0AxcJJvO3gfgYHj5mA2CNa2zpcSV080l78mxlsh5
         JEbs2uW+/3pSxvnZLE+mTOnSgL4FO9VOJs0uBYzhJAVBwdWvWkzwV3bgxes8tmH147wK
         1iFvzTX+SzayGuib85XM/7BZwaWYwHiNRNocvqYvAgQwfDlyj/Ly9hdwX6PnZHY01p28
         dq7JM361AGzXes4VnL8db1SfcaZel2/9geiSq+n8Yd3zgE5Dc9Rxk9Myyl177MHBo3gJ
         1TUtHrpqW6DAVTCmgok6zL6T4D0BO3FEUCMLjcBCzRZWbW+p9TGM0KsWv12H+V4y/pMS
         CAeg==
X-Forwarded-Encrypted: i=1; AJvYcCWjvzph3RDIx+jdETAoGsiDWkgnqpOUaunUavBCzFgPBIACPipjF2ga1B8cHZH286QrSE793vF/aaSmrN449kSeRkuoEsnY3HqIABWt
X-Gm-Message-State: AOJu0YxPG8jA8d28+sEM1ESvPkyJkiECn5MUfL77eprzOWM35G4/pylt
	o1rS3V+5AoMI5neZ/Ntlu3/4YEFoIir2oDie1a1zZObPLU8DMxzQ
X-Google-Smtp-Source: AGHT+IEM4r5VaFC1ZJ2Ks20iVPWPVgVeDAzF815iSNkzOXJ3tTxa0EBMW/xdG2gpEZc/4o8+r8atGw==
X-Received: by 2002:a05:6a00:2393:b0:702:4139:7584 with SMTP id d2e1a72fcca58-7040c649c24mr5693476b3a.9.1717860093896;
        Sat, 08 Jun 2024 08:21:33 -0700 (PDT)
Received: from SYSOS.. ([115.178.65.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-704207547bbsm1526565b3a.204.2024.06.08.08.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 08:21:33 -0700 (PDT)
Sender: Leesoo Ahn <yisooan.dev@gmail.com>
From: Leesoo Ahn <lsahn@ooseel.net>
X-Google-Original-From: Leesoo Ahn <lsahn@wewakecorp.com>
To: lsahn@ooseel.net
Cc: Leesoo Ahn <lsahn@wewakecorp.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: sparse: clarify a variable name and its value
Date: Sun,  9 Jun 2024 00:21:14 +0900
Message-Id: <20240608152114.867961-1-lsahn@wewakecorp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting 'limit' variable to 0 might seem like it means "no limit". But
in the memblock API, 0 actually means the 'MEMBLOCK_ALLOC_ACCESSIBLE'
enum, which limits the physical address range based on
'memblock.current_limit'. This can be confusing.

To make things clearer, I suggest renaming the variable to
'limit_or_flag'. This name shows that the variable can either be a
number for limits or an enum for a flag. This way, readers will easily
understand what kind of value is being passed to the memblock API and
how it works without needing to look into the API details.

Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
---
 mm/sparse.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index de40b2c73406..80e50ba26f24 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -333,7 +333,7 @@ sparse_early_usemaps_alloc_pgdat_section(struct pglist_data *pgdat,
 					 unsigned long size)
 {
 	struct mem_section_usage *usage;
-	unsigned long goal, limit;
+	unsigned long goal, limit_or_flag;
 	int nid;
 	/*
 	 * A page may contain usemaps for other sections preventing the
@@ -346,12 +346,13 @@ sparse_early_usemaps_alloc_pgdat_section(struct pglist_data *pgdat,
 	 * this problem.
 	 */
 	goal = pgdat_to_phys(pgdat) & (PAGE_SECTION_MASK << PAGE_SHIFT);
-	limit = goal + (1UL << PA_SECTION_SHIFT);
+	limit_or_flag = goal + (1UL << PA_SECTION_SHIFT);
 	nid = early_pfn_to_nid(goal >> PAGE_SHIFT);
 again:
-	usage = memblock_alloc_try_nid(size, SMP_CACHE_BYTES, goal, limit, nid);
-	if (!usage && limit) {
-		limit = 0;
+	usage = memblock_alloc_try_nid(size, SMP_CACHE_BYTES, goal,
+				limit_or_flag, nid);
+	if (!usage && (limit_or_flag != MEMBLOCK_ALLOC_ACCESSIBLE)) {
+		limit_or_flag = MEMBLOCK_ALLOC_ACCESSIBLE;
 		goto again;
 	}
 	return usage;
-- 
2.34.1


