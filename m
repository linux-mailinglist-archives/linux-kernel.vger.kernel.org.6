Return-Path: <linux-kernel+bounces-445116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFD99F1190
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27861652C2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2425B1E571B;
	Fri, 13 Dec 2024 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="obyOaWIl"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68E51E3DFE
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105371; cv=none; b=ZT2pBLHA7cRZO1NMsNQHxjnds2wI/YF2LnLwnPOdkIQjKcBS92jtP9cikfDNnyU2RLTc8CZQ/QZGw3rQIby0cPBSD8yyzt+04spgh1zZIgv16fXuywK3JXKuEH63SM/YyUSxDrMnxg5oVveKo4wYza/qX8ndAYHzW1qNXaHhLN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105371; c=relaxed/simple;
	bh=sPnR3qBnsWLGEr22pRK2TCMcNSO2RW9SlspmNOIT9ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ek+LzIUrAiT1jXOTns5m3HO0X1f4tAZ+srJGDLdEWwY86mW9JN4F2e0cun6tkLNefX2Ts/SjF+07RNTEfSe6786o+OHYAVWQ/xUCEF3VvZk8k8Ag8AUsVyn+xCyLM8lIzvjvPJRCaCemjnCDUxjgTYGm0/Zy2AjwCb75Sr321z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=obyOaWIl; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-84435dbda4bso104648139f.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 07:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734105369; x=1734710169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOQaUrSMrbMaSJ8tKHsfpEHyiDws1YYfXq+2bH3/e/Y=;
        b=obyOaWIlLgEsnjXV7gMx/G3rChEhT3ViesKVO0mDuP1ASnoUTdHT/MOdQLx6tFeFCS
         68sfgPX2jZBlKMS6C1TnsGBTyAlkwhdeL3L0rpJqF8gdynDHZGWrxPkH3Z0w+n2gyjuG
         AYUcKJFnFw4qGqcXUGxleGgzUSU9eaAtaubpt4iTHYuofBvbY9MU7xOPAkeV4kBcACny
         WpuiSxbjIxGn89SGOWcguKS7+2MN2HjdezPSoIzCp/88od/7d3eN0ImQtejzPHwvlb7B
         RHO9uDxi72CCUPgseMsdr+YW6Sqjrk22kbaCmHlG3X3OZBs91D1Bjd2tkQqWVvNqv/Py
         kpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734105369; x=1734710169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOQaUrSMrbMaSJ8tKHsfpEHyiDws1YYfXq+2bH3/e/Y=;
        b=C6KFMABgei48U7tE4F9cg5RRygAXM7OK9ItMca0ZZrd2dvxchRtNYkz+nMI1a6Q43N
         ifzaTewV8nXBAdQZAUesNxzetSCKlomPDSBWJedtqv/1xGBu41tOr/0APP7w+zxmJQtB
         17xvyb8ENz2a46OTf4uQiDUoUuDS4lzl1easM9T/ff3mB9VV29rSiyVkhJxMyrs2Z+Of
         7u/b8LjtJOw85TxX0Jrp1d0g5xEJ/ghKFJXAD8l6bmlAfZ35eRV23pnC0JyPpSGgEH/Z
         4yB2uYYSwWiYCjSMF5bBJO5dhwh3IOZqYqWE3VTltI25PcD1te5erY7DeVZqRFx0P3om
         AygA==
X-Forwarded-Encrypted: i=1; AJvYcCURePgvA0qghRn8E8OSyseetQide98aiLULVnqMkehlU5rc09k8ZHQaUsf7Sp0/2qC73T1xGHBjlZhB+fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB0Pqiwi8dYXnteNxWldGqFJAR6SenBQtdZQm4Tgzo2V5l/F1a
	pRGozDoxH9J/PLSQ3mOoQuistO6zXA8+xiVY8QTUhxcTsuf9K6Qc7wA786HapvMB7P3hTkeJn+Q
	J
X-Gm-Gg: ASbGncsjHupvJ6xtU+m9T2ggX3sA77ORhbnmQ36vHN8qpRYz7/x/JU7RVF6E8dGcO94
	3s+N2m+UzNpuJ8s28mU/kl7H55jJuRkMTlYhf77oXMidAMquRZ1z+Tis1zVDEM/5F0NXUJ2DELl
	gJ9JyBVObDN/LqFhS/jHjBxf1alYbcCvgEUC+BvQepCEAACfsguJl/zyOrTjhMoOadMshgOXM9r
	9evze38RjyAwe9o89fjdr/lcj6HcX03Rnk5DiUUoeTMfliwo/AdEnUlFhrM
X-Google-Smtp-Source: AGHT+IFBVlz5yZz/k+skWWprsCIycLK8jgnRkqf8RE4HqF0RJQv2gkIr0yeXfbClfRWoooTGgqlEcg==
X-Received: by 2002:a05:6e02:156f:b0:3a7:e8df:3fcb with SMTP id e9e14a558f8ab-3b02d788a63mr20845625ab.7.1734105369001;
        Fri, 13 Dec 2024 07:56:09 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a9ca03ae11sm35258405ab.41.2024.12.13.07.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 07:56:08 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/11] mm: add PG_dropbehind folio flag
Date: Fri, 13 Dec 2024 08:55:18 -0700
Message-ID: <20241213155557.105419-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213155557.105419-1-axboe@kernel.dk>
References: <20241213155557.105419-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a folio flag that file IO can use to indicate that the cached IO
being done should be dropped from the page cache upon completion.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/page-flags.h     | 5 +++++
 include/trace/events/mmflags.h | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index cf46ac720802..16607f02abd0 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -110,6 +110,7 @@ enum pageflags {
 	PG_reclaim,		/* To be reclaimed asap */
 	PG_swapbacked,		/* Page is backed by RAM/swap */
 	PG_unevictable,		/* Page is "unevictable"  */
+	PG_dropbehind,		/* drop pages on IO completion */
 #ifdef CONFIG_MMU
 	PG_mlocked,		/* Page is vma mlocked */
 #endif
@@ -562,6 +563,10 @@ PAGEFLAG(Reclaim, reclaim, PF_NO_TAIL)
 FOLIO_FLAG(readahead, FOLIO_HEAD_PAGE)
 	FOLIO_TEST_CLEAR_FLAG(readahead, FOLIO_HEAD_PAGE)
 
+FOLIO_FLAG(dropbehind, FOLIO_HEAD_PAGE)
+	FOLIO_TEST_CLEAR_FLAG(dropbehind, FOLIO_HEAD_PAGE)
+	__FOLIO_SET_FLAG(dropbehind, FOLIO_HEAD_PAGE)
+
 #ifdef CONFIG_HIGHMEM
 /*
  * Must use a macro here due to header dependency issues. page_zone() is not
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index bb8a59c6caa2..3bc8656c8359 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -116,7 +116,8 @@
 	DEF_PAGEFLAG_NAME(head),					\
 	DEF_PAGEFLAG_NAME(reclaim),					\
 	DEF_PAGEFLAG_NAME(swapbacked),					\
-	DEF_PAGEFLAG_NAME(unevictable)					\
+	DEF_PAGEFLAG_NAME(unevictable),					\
+	DEF_PAGEFLAG_NAME(dropbehind)					\
 IF_HAVE_PG_MLOCK(mlocked)						\
 IF_HAVE_PG_HWPOISON(hwpoison)						\
 IF_HAVE_PG_IDLE(idle)							\
-- 
2.45.2


