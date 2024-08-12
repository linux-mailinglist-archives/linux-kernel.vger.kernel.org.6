Return-Path: <linux-kernel+bounces-283621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C43094F6DE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC41C1F21CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C323018E74C;
	Mon, 12 Aug 2024 18:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W7JmqtcY"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37D12B9B7
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723488301; cv=none; b=ZKyiHGJJ6bP4gQS47lzXtL6VZ4qF6Bz2QuMRDppJgeA0/uqF0/5bHl3KzzJsASHRgMN6wnIe+EodMciqTr8T2twh7mLgzqjyZcMkByZszVNNA7cWHHCGWw4jZnGmhGdiXbMn9NBeQcBNZHbP3QdNANIRmfgyWLKch5MEVIqS06g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723488301; c=relaxed/simple;
	bh=zbPEjCRYI897M87PSVTeeSpNQCMqx1QUDxQjO5OMTdE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TKuglTcA+WvuKFCAVtCp2s0rFUyXzBS0cb+NJKzur252CTwzjDn1ELaot74ITbsCb9DB/q1Jnj5qDOo0xJ8VjXwnD+aH2M2SCYcC1Bf/lJvPuLPDs7Sz8gi/Q+2oh87DuFnbF0gbeSp4wKhDvgMejjKqH/9kFQuuA1eV3J075kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W7JmqtcY; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6688c44060fso109902267b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 11:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723488298; x=1724093098; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8xfjsLS0qWmUfrN2bGiDc953k4XM6QAa2JwY+lrUcSM=;
        b=W7JmqtcYk5fGEHHPGEqQ/bPDankoHzQCc3H84qcePGOswiukVYu5xkhGdUu97FFuvi
         EFs34j7TG2b4/H1v8lCV6Pt8QT5/2pdI2PFMTwfs3hk5YIDPipSMVs/gmE0IQBm0YLyH
         +lhy8iF6UQZnb/zHctRL3KUvVxmor0NaNrw4Whq39BisxHEtnh4VBi1jJfHc8KmsToVV
         rbvBSiXCkQVFFikfxW4AsKb7UWjjO3+/jTd6PlAj+5TzjG6Y30MlZgQ4/MaRBcwlZvrO
         5ElpoYfashD25xXRNnd6CFv6YQ3dgp+R38Tpzr/ZwtmCtA6jT8M0/kNKh1DstmXOgplw
         p70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723488298; x=1724093098;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8xfjsLS0qWmUfrN2bGiDc953k4XM6QAa2JwY+lrUcSM=;
        b=itFgWuTxND8TzlDrWPjhmrQkVTovkkCEideEVkP7vXUq18wD374nG0KEjACsFFa473
         VFS8jIhSiH/f4tUe4dEA1jRYHqIYCvNo4p02veTJ85XXaUBdc4/3M1TLh0EoSz9wUFmz
         NzviFY6jZYIgzgusZkKLYnz1WwJsLphdmV4zFpN+IhXxFAeLpa1iAtv3n4HbSpyz2Vok
         udPXpjZQ5ZmdWKkMeSQq5vjP5QMwEZiZEtgkJ+uYUnIqz/wOOL1TGVyyQb/IsgvKFv78
         50n+P5O7Pa7aUjBRajUVyTqFtZUK7U7r/HnvoHtudujdsHJycbWGVLs6sdzVAw2Uf3K1
         BQtg==
X-Forwarded-Encrypted: i=1; AJvYcCW2O5Y22ayV0S65YMeiFP2rvWSisBFpGZdLhufeAsCqEy1Xn/PJtnnAo/muIFAYYjKHk2BQm1tzYWH1oLLk0TB1IxIhUiZ4dLfFAKGz
X-Gm-Message-State: AOJu0YwO0THO/9EF4wkvxzDe6z9EBd13jn7XVPGgG2Sq1ii/+QPpnNiq
	Lx625Tby6DMeKuDqUP15niUPdpMzTS9lAqs4KZZNO2OFWiGfoO2jAo3b7HwuVmSaDnL3i2CEzf1
	n9Q==
X-Google-Smtp-Source: AGHT+IE01xHH4pviDkRute4+F54n9w40B7TDMBtndwx7WiSzaMMX3jLH0he1cbHjQL8t5nUEOC5H3JdOvf8=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:3912:1e97:a514:421a])
 (user=surenb job=sendgmr) by 2002:a81:b40c:0:b0:69f:9a89:4ba5 with SMTP id
 00721157ae682-6a9718f32b3mr24227b3.2.1723488298676; Mon, 12 Aug 2024 11:44:58
 -0700 (PDT)
Date: Mon, 12 Aug 2024 11:44:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240812184455.86580-1-surenb@google.com>
Subject: [PATCH 1/1] alloc_tag: mark pages reserved during CMA activation as
 not tagged
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, hch@infradead.org, vbabka@suse.cz, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

During CMA activation, pages in CMA area are prepared and then freed
without being allocated. This triggers warnings when memory allocation
debug config (CONFIG_MEM_ALLOC_PROFILING_DEBUG) is enabled. Fix this
by marking these pages not tagged before freeing them.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mm_init.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 75c3bd42799b..ec9324653ad9 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2245,6 +2245,16 @@ void __init init_cma_reserved_pageblock(struct page *page)
 
 	set_pageblock_migratetype(page, MIGRATE_CMA);
 	set_page_refcounted(page);
+
+	/* pages were reserved and not allocated */
+	if (mem_alloc_profiling_enabled()) {
+		union codetag_ref *ref = get_page_tag_ref(page);
+
+		if (ref) {
+			set_codetag_empty(ref);
+			put_page_tag_ref(ref);
+		}
+	}
 	__free_pages(page, pageblock_order);
 
 	adjust_managed_page_count(page, pageblock_nr_pages);

base-commit: d74da846046aeec9333e802f5918bd3261fb5509
-- 
2.46.0.76.ge559c4bf1a-goog


