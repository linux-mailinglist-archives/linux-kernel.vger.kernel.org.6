Return-Path: <linux-kernel+bounces-576078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 131A5A70ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3FD188FA1F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E5A1F2B82;
	Tue, 25 Mar 2025 19:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aa6yIzBq"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105C11EFFBD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 19:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742932171; cv=none; b=DCsVwaVXxZ2/i45wpAt/kQ6MScvTg6vP1ODK1kePG9ub3nofl6OQbwLBO9102mdr9b1tokrdXaZJjHwogWNveEKcZEYwpFcLooghk65KaFg/P1yr7gVtsfcipqR4DuBZUqBYkIoNqhWXNAv8HLSjHp8UIEFozrRrUB8P/CxR1iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742932171; c=relaxed/simple;
	bh=n9X/LHaKjTAlTu3Dq9YOdSywp/+I73X0hcr7Z9IQjI0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eJANUlOtL1wnZM4JU6iB/qL3nlQuJgNBOUBite5Q9XK3IHM4WJPAzS2gYkGEOUT88sy2/MQqUn109aEfY8X/HIozV5U5BXiVp6IcGKuzLoPT2HjWl/mft8hbj5LTmo7OUldQjTgO+cZCWLAi+u+2BZYgBQSl4pgS68iZMv4F0BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aa6yIzBq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22401f4d35aso127549175ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742932169; x=1743536969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=34tbpW8BH2aqAy4+jZFikzk4k9oyhAq1g+2Ui0jyM1w=;
        b=Aa6yIzBqz9wf9HVoAl5/ToRcH7Q+6Rumlj/uRsOHlDH4M7wz1EGeQtq7DOrXnrUcDs
         NChgnMfFQGeqjNyXoXYwnj2QbV53aJRjpRp3sM0wDAiMTPV8W3smR4nWMy+B8YmdyMzo
         Kyu3lx10Pn3vk09CVmahH4QHb5Lai5whKWUI41568cAP34jlcZAUw51JWggftTtEB2+H
         J6HwHpCQkdyFrjcFNaAsfh70wFnZVmkL82MgbBr7Xc0QwPafNRU5YWquoSoZqzZOy+7q
         jsUTwei8+0XJzGKLSSwS6ppJ7ULWWHbXqUW89b3AoZhT9GC09wJBHqWHjO6RIKScpVGz
         SsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742932169; x=1743536969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34tbpW8BH2aqAy4+jZFikzk4k9oyhAq1g+2Ui0jyM1w=;
        b=NF1B0cBQ3C+OpaJsuag4aYgGeQ1XzW1kaBxSbgjIApt49hKDwInMelJi9uk1L7BBUB
         qw3N8xPVTZg9jmG0KD9+XH1AEyaC7eX3VDTuRv0DS8OpvuyBwipINxAfjYHzo67Qnr+0
         vQCoX4cz4SsrY0bVI/U0QeqddVcsK3Z7Q0sI632LzN0SuW4U7nxeLjuKFCOLCby9R+9r
         2+2o5QSqT4dbg4gAnUBsbnEWPkjA9Boyx/Ki+iw91Co3F8II7XRcSOBJOtqwkOa5H+vR
         /rYQm1cjkWWBgW44CIHhkK60YFw1A8WB0NfMCIo6TtqusfaAQsYhX7UciXi0OdhULjOR
         lIsA==
X-Forwarded-Encrypted: i=1; AJvYcCW8Z9jXWAAfAJ2zfqYYtHRdLmwwqOq9fo+liYx0SwLCwpX+L+3IJ5JZcZlEWjFqA2r1dDGzeOhzUfPVRGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlwh5dyVeNa9dtnCZeojs752gk0a/vrtnRyobU7k7iCV3NxDH4
	mjfqQ2Ty6OZ8JDLZhtWt5xdMfL26/SNF4XEk6nXqVjmaOqSQj70y
X-Gm-Gg: ASbGnctVQ0mm8SixT5+/xSbcStxaqunkl+my4oMjyCpY+jVycq2NSgKopoVz30+3tEo
	fALnYH3st9Rv9Uc7hKqABUIvyRYh8e1i5faiRYrhvfM7loHg4QmtVGB02AsXMZ6/gFaKZZi1vC8
	5BEkbXHhpUBP/+qCLe0wzwXkSJ7Lt2C2fSZQQecG4LR5z6qJK9Ctrfn+TqvRr8r3NnelpYf44e3
	6DXLNB2qB9WeXsqD8fN9qyU+iNwWHmbi3LMCuZnZ20Re0RdBRVMb2HysJM4uRKNvY8DwIDedqmm
	V2n1CpWJ8yIbDtg5dJxE86GaXxciq8HBvNMIRmA1EWhiQwZPgTsp/60EH6QutaHbJdoxIy6z9yv
	S32U=
X-Google-Smtp-Source: AGHT+IHuD4gU2NB/Cm9OJi4UNA2DHkgt3xOtYAV0HSQIHALTmHNx1aZFVH90L3KBo1cExPRliedHOQ==
X-Received: by 2002:a05:6a00:234c:b0:736:4e67:d631 with SMTP id d2e1a72fcca58-73905a50170mr24970197b3a.23.1742932169094;
        Tue, 25 Mar 2025 12:49:29 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:4080:119f:3ad6:66e:eb88:9ca5:b5e6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fab592sm10992435b3a.19.2025.03.25.12.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 12:49:28 -0700 (PDT)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH] mm/vmscan: Initialize dirty to prevent uninitialized use
Date: Wed, 26 Mar 2025 01:19:20 +0530
Message-Id: <20250325194920.53307-1-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix Smatch-detected error:
mm/vmscan.c:3509 walk_pte_range() error: uninitialized symbol 'dirty'.
mm/vmscan.c:3522 walk_pte_range() error: uninitialized symbol 'dirty'.
mm/vmscan.c:3600 walk_pmd_range_locked() error: uninitialized symbol 'dirty'.
mm/vmscan.c:3614 walk_pmd_range_locked() error: uninitialized symbol 'dirty'.
mm/vmscan.c:4220 lru_gen_look_around() error: uninitialized symbol 'dirty'.
mm/vmscan.c:4232 lru_gen_look_around() error: uninitialized symbol 'dirty'.

Smatch reports 'dirty' as uninitialized, leading to potential
undefined behavior.

Explicitly initialize dirty to 0 in walk_pte_range(),
walk_pmd_range_locked(), and lru_gen_look_around() in mm/vmscan.c
to fix Smatch error.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
---
 mm/vmscan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index c767d71c43d7..39c49fcd960c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3456,7 +3456,7 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 			   struct mm_walk *args)
 {
 	int i;
-	bool dirty;
+	bool dirty = 0;
 	pte_t *pte;
 	spinlock_t *ptl;
 	unsigned long addr;
@@ -3535,7 +3535,7 @@ static void walk_pmd_range_locked(pud_t *pud, unsigned long addr, struct vm_area
 				  struct mm_walk *args, unsigned long *bitmap, unsigned long *first)
 {
 	int i;
-	bool dirty;
+	bool dirty = 0;
 	pmd_t *pmd;
 	spinlock_t *ptl;
 	struct folio *last = NULL;
@@ -4147,7 +4147,7 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 {
 	int i;
-	bool dirty;
+	bool dirty = 0;
 	unsigned long start;
 	unsigned long end;
 	struct lru_gen_mm_walk *walk;
-- 
2.34.1


