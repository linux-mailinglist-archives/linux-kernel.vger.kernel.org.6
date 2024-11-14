Return-Path: <linux-kernel+bounces-408792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FD89C8395
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C51F7B2704D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D1E1F26FE;
	Thu, 14 Nov 2024 07:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TFlX+UcP"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75BA1F26E6
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731567676; cv=none; b=aO5kERRzuoElBSiWYYDnmKDRaFJLmLQdWEMSHUW+6skDeZXWVlD3EKusOF53qGO3abscWr6V3rfigmysRQOTeOtu2uWJo5muPOuNSDcFZTKbmhPPZ9OocRXTZzeeFN4/sHd72+XaYIvPXbDmHNebgRrvYSRD2CWufwmtel2RPX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731567676; c=relaxed/simple;
	bh=uQ+ClEI5hwp0ini/MzCR2IyLRxAYlW8WNlB6Q1rs00Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gsE/AzegB7MsFeIxdq79waQS/xAD4htVdyWCgz+2/X8Rp5Xost4Z3NxUcD3MWgb6mopC/FRITTqUJslIa7/aakJIrwKihp2u7pJNuCPXpUKUAdjO7qiXNwGIfh4Jc51RpwNy1hHFqS09CP8lIDGzc8NEP80HZfIoQKbNDK8L9kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TFlX+UcP; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-211c1bd70f6so3357025ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 23:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731567674; x=1732172474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4ITvW0bkgyK2CcMa7XVY4WP6GOaHym7f9gBon+26RE=;
        b=TFlX+UcPwWNnKYWCCLR/Gh9ZporjaE5gqhw21H66ZuGxaWfzytQi+hLJsk1nxiyDsR
         UunBsI16TQzGuEavIO+SdF0YN5mnPXowILPZEC6VIki7Co7srJctKE8H8n67l+c3Z6q/
         b5hGnr+6qOPEJrTcO4/TKpPhlhj5Gv0cNVZipsclZ8ze70AvSRPoBWue0K5kEd6faXq2
         SlTl8c1GE9Ys8+6uU7Q/KXIdNpDRAQ/S1eKBDaiaJL2Rmu29shHhShvrkg51K0O9NLPi
         2Nd24bhCggn3aDkW0APQmQ8Uq0vDh6afy8avfRzJ6jwLhCO7pHCe0CSJCLnYbd99g3fU
         L5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731567674; x=1732172474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4ITvW0bkgyK2CcMa7XVY4WP6GOaHym7f9gBon+26RE=;
        b=Phb9rURuYVB6AJ23bTPz7gAjFbb904QZfjfIkYMl4qpptAqtv2DeuBS4hN+8EKJopT
         fCMrUq9DPW97Y7+RQJ15w4fuUsg8XCdMeQ/bNpjZaCUdjUiT3SwZLtZSlujDkOCmzgQy
         u+gNe6a2mbevdrt41PZKKkgJYWlokf3zKue17tBjRx0wg0KZENKO7UtY53G9GuWVjh2D
         rIrAVaG0AZ4rh5Vi2HoMZZ+Y6O/8bOkE0VW72YlApXI5iKXLv2z7Oca9xj0Q6RLDt0U6
         w99XtyuGieQNJKTS+ExWLziWH8eYmqj2L+nRqLZ/UXO5c7tBqHnseclf74zjxKc4n2ky
         LxTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0mDYiLPOCxRe+pNfcGJJJmzCwJDvUsBiot12glqOiJHMD+bPTHdj5CNvVjRg4vPasAdqa9eAjb0wVY98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/RxGTLYS1bUFBkY4YvzVa6dMSK7E1hx69ftG4PS3ZmCeG3Zy0
	HPNMayw39Eo5PQm2J0xJQzp9LZcob+3I+vjiMjJLLYsdU3v5lmlaDlOYt/DP9KI=
X-Google-Smtp-Source: AGHT+IHMIWeAj04FwYV71IQtIKJmFnsONOBKIQaZTsFXBlA5BRH3Z1Wl93O3jOYR0L0oLnRZ11BTuw==
X-Received: by 2002:a17:903:11c3:b0:20c:5ffe:3ef1 with SMTP id d9443c01a7336-211c0f897b9mr36683095ad.17.1731567674099;
        Wed, 13 Nov 2024 23:01:14 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d389c2sm4119065ad.268.2024.11.13.23.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 23:01:13 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	peterx@redhat.com
Cc: mgorman@suse.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	x86@kernel.org,
	lorenzo.stoakes@oracle.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zokeefe@google.com,
	rientjes@google.com,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 6/9] mm: make zap_pte_range() handle full within-PMD range
Date: Thu, 14 Nov 2024 14:59:57 +0800
Message-Id: <3aaf6c2338372866b85cea78140f5ea497ccc33d.1731566457.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1731566457.git.zhengqi.arch@bytedance.com>
References: <cover.1731566457.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for reclaiming empty PTE pages, this commit first makes
zap_pte_range() to handle the full within-PMD range, so that we can more
easily detect and free PTE pages in this function in subsequent commits.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Jann Horn <jannh@google.com>
---
 mm/memory.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index bf5ac8e0b4656..8b3348ff374ff 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1711,6 +1711,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	pte_t *pte;
 	int nr;
 
+retry:
 	tlb_change_page_size(tlb, PAGE_SIZE);
 	init_rss_vec(rss);
 	start_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
@@ -1758,6 +1759,13 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	if (force_flush)
 		tlb_flush_mmu(tlb);
 
+	if (addr != end) {
+		cond_resched();
+		force_flush = false;
+		force_break = false;
+		goto retry;
+	}
+
 	return addr;
 }
 
-- 
2.20.1


