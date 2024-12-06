Return-Path: <linux-kernel+bounces-434222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B309E9E6379
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 02:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67CC61884F4A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDFC13C9A6;
	Fri,  6 Dec 2024 01:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S0z7PE2X"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AB376048
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 01:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733449177; cv=none; b=Yyiv/NpZzX2EAB83nSwj26EsL45WnivpvL9afRU7MjTrCs1N2le5aA+xoPs4XiIbfk19k0XsQpDo3FZVtjNNDrUv9dlQ9foATGee0jlgD2buc7mBls8Ac8UfQ8gVMY/qB4YCrG7VYQUwUt6lrhgy6t9vKEYnIg/1ZQ6jQdpDu50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733449177; c=relaxed/simple;
	bh=tq6idRPlH9QbeZXVYLBlZDnSxi74kYOKjPG57wGwzlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LfUCTaTpp/hQFdCRqdrxsX6Ad7OoQlQkqsG0/iEdRHgf4RT9SJ/OWZyumkRcP5PHsdPDUc6jsBM6tl/WkArmiuygvcyWV2/skJNJm35JyLnC5SuIdSeLqfd4kvAcM1iBzC77oq7ALvqcbHd+F7cvryJGdiGxejhNdkAwg2TMPeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S0z7PE2X; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-215607278acso1322385ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 17:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733449175; x=1734053975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XSQJ1HOy65NxdTTDtOXYHpi4KVX/eOZdGvlizxFTiXY=;
        b=S0z7PE2XLQvVrZ+JAsVw9V2uDeqzbavkMFpQahEqdE2EhtwqoV6iSl5NeK+ex07qMN
         X/lAS4Z5TQF376GiWIXyswEFRlxrw2DIuFbirF02MoZfLBu5OiX0dOgrRG+Bcr6MRbeU
         c+g4lgqhUiVcP5CmcvAN0tqBXHa+DMJMe8kys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733449175; x=1734053975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XSQJ1HOy65NxdTTDtOXYHpi4KVX/eOZdGvlizxFTiXY=;
        b=cr1Ym5jNA9ZkSUlk1FcS8n7L45hPTP9yTZuwlk5PnoiSfWpMglxz84A7yzz73Tev41
         JqWzrQGu9HIxWmFZNuDYvvW/eBiYgIalZmopCmjtMla6aIktQkGcBCeVotdXAQdXb7bb
         DgM+h9I2wNAzgSCL6vO6iadmVBkjbBIVJYyJTlYOlhhqqqtchD6ucK2hoTPsPLUPR4wP
         IWN3iMii+qSGX6wp2yqEWJE4iq6kLOv32Ap1UAB4/v+SaVmiLv548cDuFw130fhgI0Rl
         ReV4emsmOphEqAnG//16S4zxsLJ2QG6C/zcQovjEyKAu16rhO61sM+d+Qn9mvkhFpdTm
         cuvQ==
X-Gm-Message-State: AOJu0YzWWdAbHq4zwU5YRtNRjc0kpxK2aGmFUySm8mU1U4DBKc9KU4DV
	2hK686t3/PIUjhwVBjt5cEnpfq7nmuIRD4IoJo47Fy54AUbA72suaDMg/2+/9g==
X-Gm-Gg: ASbGncujqwi3SIr5Qe9bT8Xr6J8CdHuQNCRoXQh3fC8QmgDYQC2t+cDQ4fEOWyVEoEG
	LyJaJ4qRp+W2tcl+7/rj3Ag54aHNnDSd4TWwYmu3MHhx1iOIqghH/MW6yCMYEHJlxVMJhvSYHHw
	MQWJ1HgrhkfveWD0Y63z9irxj5pFNvAAWWdAles5XrEGuat9WIGNpDCBKlt6VKqI9ibgOdPKCoN
	OYaZNRfIxL9rcERDpNNqLvPWmEvn+Qqw1GI9V50sTWFla/Wk8y3pVzU1lO8xp4ihpyM2WAL4/QH
	/k5BlI8Wick=
X-Google-Smtp-Source: AGHT+IH3Fdeuwj9S9gBBbgIm2RrejRpYnXUO7GaCkJRgcg3/NVfmxr6SCUcgXFAlwY+/gZdwpnrdaA==
X-Received: by 2002:a17:903:41ca:b0:215:7595:9474 with SMTP id d9443c01a7336-21614d44b20mr5508645ad.5.1733449175580;
        Thu, 05 Dec 2024 17:39:35 -0800 (PST)
Received: from localhost (238.76.127.34.bc.googleusercontent.com. [34.127.76.238])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-215f8f092e2sm18343865ad.202.2024.12.05.17.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 17:39:34 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	keescook@chromium.org,
	pedro.falcato@gmail.com,
	rdunlap@infradead.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v1] mseal: move can_do_mseal to mseal.c
Date: Fri,  6 Dec 2024 01:39:34 +0000
Message-ID: <20241206013934.2782793-1-jeffxu@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

No code logic change.

can_do_mseal is called exclusively by mseal.c,
and mseal.c is compiled only when CONFIG_64BIT flag is
set in makefile. Therefore, it is unnecessary to have
32 bit stub function in the header file.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 mm/internal.h | 16 ----------------
 mm/mseal.c    |  8 ++++++++
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 74dc1c48fa31..5e4ef5ce9c0a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1457,22 +1457,6 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
 unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
 			  int priority);
 
-#ifdef CONFIG_64BIT
-static inline int can_do_mseal(unsigned long flags)
-{
-	if (flags)
-		return -EINVAL;
-
-	return 0;
-}
-
-#else
-static inline int can_do_mseal(unsigned long flags)
-{
-	return -EPERM;
-}
-#endif
-
 #ifdef CONFIG_SHRINKER_DEBUG
 static inline __printf(2, 0) int shrinker_debugfs_name_alloc(
 			struct shrinker *shrinker, const char *fmt, va_list ap)
diff --git a/mm/mseal.c b/mm/mseal.c
index 81d6e980e8a9..e167220a0bf0 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -158,6 +158,14 @@ static int apply_mm_seal(unsigned long start, unsigned long end)
 	return 0;
 }
 
+static inline int can_do_mseal(unsigned long flags)
+{
+	if (flags)
+		return -EINVAL;
+
+	return 0;
+}
+
 /*
  * mseal(2) seals the VM's meta data from
  * selected syscalls.
-- 
2.47.0.338.g60cca15819-goog


