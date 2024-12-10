Return-Path: <linux-kernel+bounces-439735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE3B9EB35D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62BA166ED9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A3F1B9835;
	Tue, 10 Dec 2024 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pNmhsDRP"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A301B6541
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841099; cv=none; b=DmsYdA0hrJ68ImyT+0RXkhaKkBReFaOxs247xeXqBXV+FtVThlzG+P7kqCN6GsuXTZJT6py4dRBg2p0kLAm7cGUfoAZ9qD+9urgx7ezNCs6mfAfA14xHAt8X0IJ/b02zg8oZN/d/ei1mlawU5WbRpwn6MTR18HCtAOIvMXgoWv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841099; c=relaxed/simple;
	bh=Uw4pdPuj7RQuQpX2ZJLEmQOMp+U9isTb7zR1xRQDXz4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MkE2KXgM7uR5Pp01H2HnN5FuC6viZIbgHQ/ET50lP1dPPV6MemOtGoVQVivSYfNQXIutb9JT7Uc6TE7oFkQNZJPWBorvHVdMDZnjnkDPe63XGu1yE2c1Nedt+TpjT32gx37P6dZqswP65P/lAJDy11IsEbc5eW8yh0K3mzPqAj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pNmhsDRP; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2161d185f04so29750595ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733841097; x=1734445897; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gCCqnAEZK+ZKpJb5t5zYVlo4wXMTT1QvqaeCY/ftsfA=;
        b=pNmhsDRPaMwEMH74pW4kAqY4I1zxHS1loe8mDyrj9rsjywr46S+y0uBZXjbCqg6n2r
         Bu+3mJuxZEYZFmKXdenLqMQgLuls6IhQUqr6FHp6rcqhnX4/bGVeUlsF20DrqQIzT4/R
         CJPu4AXw1nD+tnrscBEilHWGoUkDV0am/eus8HuooycC6vMsR4R22If9Ag5ng1p5q02O
         CY+p/OEnsnlls/uCwpv6XszyykwYFkhAI7POtvBrT8HkLE6qCaMVulKmlvYtFs4ydmXf
         wHCZ6QmYJgcNiU4dpl7uBitl9nMmTrMYUtmJ1fd1CArzU5nHQgXWq7FQ0fZ7NxSNabJX
         oetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733841097; x=1734445897;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gCCqnAEZK+ZKpJb5t5zYVlo4wXMTT1QvqaeCY/ftsfA=;
        b=rw5TsB9e+j3g5XIQFgpQuW65or3vZdRY/5/r3OQsl0XwzZZvoovNPUshs978wyZtVK
         lQsWtCCpA2G0dRoDjfTgiidEOau4Mlm7I/w/Z5JOS8zqo39TCJnnQ4Wq+OrKAkQCAliq
         bbDJd/2oZFxeh0A1ARcBlSL7N3rg4NzcSkBy8tD23bAvAXAFYbHdTWGrbhjBqfjXJX+f
         D0jFH6aCgBtq8IeklQhyunglz41ntAfpOopVvXOxDv3YtYbvUwB04aBfaO6aRUtLWCSm
         zKc9f0WoIlcmjBVq8r7wzVP41zoOc0Q9wjl7aEjeO/vE7L98qBm2VQI0A6KAyhvzCfx0
         FFtA==
X-Gm-Message-State: AOJu0Yy9dmyvrcM7ouPi/39EQXZ/2SMBS7vgQu2kC0EN3Lc3m+zlTL3/
	fqxZp3jvnqNBvcqlTzyxnYFqfbhxs7rP4qgmXha3OQRD/OKVT4TOkJlMoM9WEDfHP68IXbREZ6T
	70YqZ4Zeysg==
X-Google-Smtp-Source: AGHT+IEsH9ZxZsGesuCwiOacIa/wLEwXxyWks1Cq2BFM/fGYUHpGxbbD3bfzyazGIJHsE5cN5lJIZUPGipO8Wg==
X-Received: from pjbso15.prod.google.com ([2002:a17:90b:1f8f:b0:2ef:8055:93d9])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:35d2:b0:2ee:f80c:6889 with SMTP id 98e67ed59e1d1-2efcf26e386mr7443476a91.33.1733841097038;
 Tue, 10 Dec 2024 06:31:37 -0800 (PST)
Date: Tue, 10 Dec 2024 14:30:59 +0000
In-Reply-To: <20241210143114.661252-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241210143114.661252-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241210143114.661252-4-cmllamas@google.com>
Subject: [PATCH v7 3/9] binder: select correct nid for pages in LRU
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"

The numa node id for binder pages is currently being derived from the
lru entry under struct binder_lru_page. However, this object doesn't
reflect the node id of the struct page items allocated separately.

Instead, select the correct node id from the page itself. This was made
possible since commit 0a97c01cd20b ("list_lru: allow explicit memcg and
NUMA node selection").

Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index f26283c2c768..1f02bec78451 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -210,7 +210,10 @@ static void binder_lru_freelist_add(struct binder_alloc *alloc,
 
 		trace_binder_free_lru_start(alloc, index);
 
-		ret = list_lru_add_obj(&binder_freelist, &page->lru);
+		ret = list_lru_add(&binder_freelist,
+				   &page->lru,
+				   page_to_nid(page->page_ptr),
+				   NULL);
 		WARN_ON(!ret);
 
 		trace_binder_free_lru_end(alloc, index);
@@ -334,7 +337,10 @@ static void binder_lru_freelist_del(struct binder_alloc *alloc,
 		if (page->page_ptr) {
 			trace_binder_alloc_lru_start(alloc, index);
 
-			on_lru = list_lru_del_obj(&binder_freelist, &page->lru);
+			on_lru = list_lru_del(&binder_freelist,
+					      &page->lru,
+					      page_to_nid(page->page_ptr),
+					      NULL);
 			WARN_ON(!on_lru);
 
 			trace_binder_alloc_lru_end(alloc, index);
@@ -947,8 +953,10 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 			if (!alloc->pages[i].page_ptr)
 				continue;
 
-			on_lru = list_lru_del_obj(&binder_freelist,
-						  &alloc->pages[i].lru);
+			on_lru = list_lru_del(&binder_freelist,
+					      &alloc->pages[i].lru,
+					      page_to_nid(alloc->pages[i].page_ptr),
+					      NULL);
 			binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
 				     "%s: %d: page %d %s\n",
 				     __func__, alloc->pid, i,
-- 
2.47.0.338.g60cca15819-goog


