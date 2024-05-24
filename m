Return-Path: <linux-kernel+bounces-188262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0F88CDFD5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E441C22201
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C54383A0;
	Fri, 24 May 2024 03:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AiCbFcol"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A805A22F03
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 03:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716521906; cv=none; b=NWUrwpEaTVELcvFpPeGxeH6RnuCQHkqgrm8pWqHsvw0VCVehxTmGfqPQNoImZt+BuGIQTEEjDAHkNZrjQ9aehO+XAxMsF8SCtGbg9fnh1OrOOuglc2y+yfIf73N/xyl4Fohhz4HTvr1MaCpM2BEG7T30R2xdUa6o+Uz6322VRJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716521906; c=relaxed/simple;
	bh=InztbE00Vv+/ObCTrqBtTMOXTzCouHOEQrB7Tjyf1mg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ik3KmpEq+dy3r8iwgH6C2CQchoJTZGnbUh2X1O8Bi02K8r6g2kqXb/uVUGF8QaOgcW2soKrLJJ40H0E6Kg7aRooZoNyuSQ8nA0uCssQqmCLY/8pueGCqRojYIn4Gpep5/Wss4+qkiR2N3SxM6x1v3/Y8cLGYav7n8zLRuCMeL5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AiCbFcol; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62834d556feso30796297b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 20:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716521903; x=1717126703; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BKVO8Lg92AmjXALe4s9SIU0KV7xHA1puZ574BkfEyc8=;
        b=AiCbFcologSFa37RTq6fFxbTkFnJ4006aSX13hnkrb+SjMNF2fKGTj2gYJMMY3/KYp
         WfmMGgG7gK2iHmFgkj2IQadx/kzcWnzAimFX8QwPbl9YljFpepxA2WEt4YferH4IFUiy
         RKGjT+T45fTJV7UhIOvLiuNXwz279E9wSXhullZbsSeNDOxe1JSIYg3PcAOVRV0Ip9Tm
         yIOUqEXjj6ttXRgzXu3s+8vLyDxTfx6OEMwHXbQAjXT/i7ZXRvtHGbyphmBYtdKgJHOI
         wJLUaXNJqQmvKChVMZgHMEzBISaipDHz45QKK3Gk08Bx1I6xqXVT0jYN0GQef4KS9bVH
         fbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716521903; x=1717126703;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BKVO8Lg92AmjXALe4s9SIU0KV7xHA1puZ574BkfEyc8=;
        b=fSR7Vn6w3QEKLbXO9Wlkttkmx6+Yr32mtpGI3q0c817hoWjaftt2vNlbMbc9clsz9A
         1YOpmAKga5/qI6DywrobiNnJUj+07MS/cWHJC8mHipJbJ/JW7fTYrnWeQddER0oa9LG9
         KkA1IQT0vFiWJoJepUxgCazxN27dNSYP/t/0C8XWBVbodGwjPRRixnMrDONLMp8qi013
         fNMKNA5r72SxxH/2kjWR4PytGS1wEhmsRPPueGtEk4hPKktiCJOfMbUEJXAG7NGI3lJk
         4/c1yB4t8/J2zIVeY5AUEl6YsJPoeCGtlJ9GrEJIyRI2wcpozc0J6RZ/0RYl9K2WCV36
         DRxg==
X-Forwarded-Encrypted: i=1; AJvYcCXbeoB22GnycmXwL3xBgxu/HVjVMI+99p/uRYa9ktnnJxMy9D5hj20rH/DX+ORK86m+tG0RWsymxashwEq7+azkIr0HQ1dKvxVT5uAt
X-Gm-Message-State: AOJu0Yy/oxTZ9uN0tWcQ8atUVzF1+1gIyQGvdreDSiELfYKRbk2ucg4p
	lxrDP2aNnwaKVGcR1hx+bV6GJoux/NjZZal/75IIvtVC6h3Ty7thiyFpMiiszQ8op8lVeZ3iIxN
	1L5X61FhvKzh02i8TTw==
X-Google-Smtp-Source: AGHT+IHhQTjQkcadv7LLw0o2LYVFVoSUew57m4WVVk3eNvQWrYHyn6s4HbwcRHjmBZKSrfn/K2ulbWyVZYjxfkro
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:281:b0:627:e226:8ce3 with SMTP
 id 00721157ae682-62a08f828cbmr2774657b3.8.1716521903699; Thu, 23 May 2024
 20:38:23 -0700 (PDT)
Date: Fri, 24 May 2024 03:38:16 +0000
In-Reply-To: <20240524033819.1953587-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240524033819.1953587-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240524033819.1953587-2-yosryahmed@google.com>
Subject: [PATCH 1/3] mm: zswap: use sg_set_folio() in zswap_{compress/decompress}()
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

sg_set_folio() is equivalent to sg_set_page() for order-0 folios, which
are the only ones supported by zswap. Now zswap_decompress() can take in
a folio directly.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/zswap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index a50e2986cd2fa..3693df96c81fe 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -917,7 +917,7 @@ static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
 
 	dst = acomp_ctx->buffer;
 	sg_init_table(&input, 1);
-	sg_set_page(&input, &folio->page, PAGE_SIZE, 0);
+	sg_set_folio(&input, folio, PAGE_SIZE, 0);
 
 	/*
 	 * We need PAGE_SIZE * 2 here since there maybe over-compression case,
@@ -971,7 +971,7 @@ static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
 	return comp_ret == 0 && alloc_ret == 0;
 }
 
-static void zswap_decompress(struct zswap_entry *entry, struct page *page)
+static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 {
 	struct zpool *zpool = zswap_find_zpool(entry);
 	struct scatterlist input, output;
@@ -1000,7 +1000,7 @@ static void zswap_decompress(struct zswap_entry *entry, struct page *page)
 
 	sg_init_one(&input, src, entry->length);
 	sg_init_table(&output, 1);
-	sg_set_page(&output, page, PAGE_SIZE, 0);
+	sg_set_folio(&output, folio, PAGE_SIZE, 0);
 	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, PAGE_SIZE);
 	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
 	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
@@ -1073,7 +1073,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 		return -ENOMEM;
 	}
 
-	zswap_decompress(entry, &folio->page);
+	zswap_decompress(entry, folio);
 
 	count_vm_event(ZSWPWB);
 	if (entry->objcg)
@@ -1580,7 +1580,7 @@ bool zswap_load(struct folio *folio)
 		return false;
 
 	if (entry->length)
-		zswap_decompress(entry, page);
+		zswap_decompress(entry, folio);
 	else {
 		dst = kmap_local_page(page);
 		zswap_fill_page(dst, entry->value);
-- 
2.45.1.288.g0e0cd299f1-goog


