Return-Path: <linux-kernel+bounces-292759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F3A9573F5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90E7B2864F1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C39618A6AE;
	Mon, 19 Aug 2024 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDuQ5EiJ"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52C118990A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724093277; cv=none; b=bQ1/Hej3McEJNxpqapZR02y8XY3kwkuMwDZXlZeJt8jFjj9CY09H033q4Hu9qxQe0hCeiT4NfnDTtycQS2CzuiGDzXFkc9Qo/9SYw7vCucq7YOP4ivFujEr80yuLW2HrgiQovOjblFaaXqBeYUrIW1flI+roeDYti6WPbe3171E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724093277; c=relaxed/simple;
	bh=6XCasH5G+VntlIrJtloIneQFCJs4S554zGSi3xivyVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FOLsaX950ankIeGHdcTgI3EQE4bQ2fEFBqFTlwyp/5q+1ks04kb3GgYdx4RdHtbwZXaTD+7r/6tFVgJ05aVjDmvmBF1zY5ExpEfshYHzSFO2JPYG4F5sJWDOHDMei/LdiYa3OicSICYG4DP9cqIpL6oopDTLoyt13z3AHPh/E5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDuQ5EiJ; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a35eff1d06so330272185a.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724093275; x=1724698075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yAV0+QqMjuZK2KfiSs1YeZVl+6iM1fDnA41Q0No5T+4=;
        b=LDuQ5EiJNaRLEumDWgdet3d4niYEJXNuE9f5Syzz28Y21qbvPwOAxq+BgLGhfk1JzR
         IigEwynUmWWo9d95C+cEsNtOZRp06bt2VdyGzEbw9Rk8Jr13hr6YKvNnZSYvJ+K+8y22
         Qikyx3BDvMyv9L7kW7/5j3X1eVAVJipiQGLUOdzLY7+lqKMCcUxBa8ESi4Onv8jn5J+6
         LDD/AB+woY8eD4GhA6sM9SxKV/ejMm9qzd2mF+3/CcvU4JnimSCH8MOO9nGZpIQ3NvAB
         tcNGTY4ifotjnaZXnVMDABQ54f36/JZo+CXTztBinnPSXwOSQdl2pGDVDW9EDZO3iPx+
         nYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724093275; x=1724698075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yAV0+QqMjuZK2KfiSs1YeZVl+6iM1fDnA41Q0No5T+4=;
        b=Aa6PQExA4jPnCvPoxepAL7aD/DwlYUcLBcAqaVJDLcXmbc045Op1bbm3sj/OU2cZQ8
         uJ7saZ617ZUJQ99bmE1zAJ6PuXA3MBJ8WRyG0vBSNUywmW9LJMr5jg4ECvfqLTaFk+0M
         cAPU2BnUv9kEqcxtl/mTjBug0PiCvZsLTxsoUqqAtoGixRqfE1w5UqFDIOTLl+5OaQt8
         cn7XoUwLaJ97uIg/UfMzjNpAF16LmMJ0UhnbrhtNAOxTt78I/Hp/IqTc0x9ogcvEO2Zg
         kTJHeZSfaCBTxPPxoQft5IQzIi7uRX8Sqkf4VM5W5sxqryegnCvXBmBKF7jVPMA5UW4b
         TEKg==
X-Forwarded-Encrypted: i=1; AJvYcCUaYBgSwsOZ5mdJPL2Uhg1G7vuJjzv5K+BIIQRaPQGMwy/nkDTIV1PLuBmmkLtcFj8uqPF7tcP7VavTzOfXGc8kgg38h1ArCUarEL8R
X-Gm-Message-State: AOJu0Yz/7Ngicfa84XpSa/WhL71nxFaurvRzBOJ9agHXYrKglLJkiM7C
	2z3IrNxNZo75xJTvYy6S6d0y1lBLpmLR9z7WhedyMQQlegOcu+fT
X-Google-Smtp-Source: AGHT+IGoeLr8MA7dtRbTUDZVzc+bUaOrVhUiwpP+/jWbDr8Pmqr1JRUhyTmNon2Ka+KkxdxJqVB5tQ==
X-Received: by 2002:a05:620a:28d3:b0:7a3:78bd:bb78 with SMTP id af79cd13be357-7a50693b2a8mr1448376685a.19.1724093274563;
        Mon, 19 Aug 2024 11:47:54 -0700 (PDT)
Received: from localhost (fwdproxy-ash-013.fbsv.net. [2a03:2880:20ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff02b0acsm459052185a.12.2024.08.19.11.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 11:47:54 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org
Cc: yuzhao@google.com,
	david@redhat.com,
	leitao@debian.org,
	huangzhaoyang@gmail.com,
	bharata@amd.com,
	willy@infradead.org,
	vbabka@suse.cz,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH RESEND] mm: drop lruvec->lru_lock if contended when skipping folio
Date: Mon, 19 Aug 2024 19:46:48 +0100
Message-ID: <20240819184648.2175883-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lruvec->lru_lock is highly contended and is held when calling
isolate_lru_folios. If the lru has a large number of CMA folios
consecutively, while the allocation type requested is not MIGRATE_MOVABLE,
isolate_lru_folios can hold the lock for a very long time while it
skips those. vmscan_lru_isolate tracepoint showed that skipped can go
above 70k in production and lockstat shows that waittime-max is x1000
higher without this patch.
This can cause lockups [1] and high memory pressure for extended periods of
time [2]. Hence release the lock if its contended when skipping a folio to
give other tasks a chance to acquire it and not stall.

[1] https://lore.kernel.org/all/CAOUHufbkhMZYz20aM_3rHZ3OcK4m2puji2FGpUpn_-DevGk3Kg@mail.gmail.com/
[2] https://lore.kernel.org/all/ZrssOrcJIDy8hacI@gmail.com/

Suggested-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Reported-by: Bharata B Rao <bharata@amd.com>
Tested-by: Bharata B Rao <bharata@amd.com>
---
 mm/vmscan.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 25e43bb3b574..bf8d39a1ad3e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1695,8 +1695,14 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
 		if (folio_zonenum(folio) > sc->reclaim_idx ||
 				skip_cma(folio, sc)) {
 			nr_skipped[folio_zonenum(folio)] += nr_pages;
-			move_to = &folios_skipped;
-			goto move;
+			list_move(&folio->lru, &folios_skipped);
+			if (!spin_is_contended(&lruvec->lru_lock))
+				continue;
+			if (!list_empty(dst))
+				break;
+			spin_unlock_irq(&lruvec->lru_lock);
+			cond_resched();
+			spin_lock_irq(&lruvec->lru_lock);
 		}
 
 		/*
-- 
2.43.5


