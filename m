Return-Path: <linux-kernel+bounces-399299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B95A29BFD26
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 05:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CCA7282FAF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 04:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED24191F6F;
	Thu,  7 Nov 2024 04:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="whF32zkY"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462A6191461
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 04:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730952181; cv=none; b=Ipr9ISyU2ttxc6QdqFJ0bmEYQyeCXhwbZcPdyqEbqg8F1GltQ56bm+akv7If6Xoq3bw6ezegDvt4E4k07BkhNAEPFiWbqPTw2m3XBsvIUOeqeHDsCy78zQOpzePOgwh++nA2KHFePEgSRERWhUU8Hrne2yvNycRjc4RAO92QNx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730952181; c=relaxed/simple;
	bh=ACA94rHA3OF/Q/ELh+C5/rtsQZN4ryYvpCJhXM/RVto=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h5LJIq+hBBvLH1tcFiy2Vb7jyXodq3in3SMAYaelUQBR37yl7XQ/BUc0qEp/QmA0v43TLiHFoHMoWpSqPjfHHR+Vj4fmK3bcnaqapf1qdjyHLo08Te90Ok7m0w4nw9AxiTjXYrk4KFid9Oy8UaRc25XkwwfzF+zIMBw8a4DB9iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=whF32zkY; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e30b8fd4ca1so955356276.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 20:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730952179; x=1731556979; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ErYo73+gAWhwTYciX1LO4komCfmpQSriXqDoh6eSQFU=;
        b=whF32zkYpaC48RRYNGrI6K76W+lp7NIDtxP5R7WC0YPisuHNEWuq48ZHRE7KhvpsGx
         tVwdCBGw8TnODYawYXtrZvCxZ30XQWiTOMAYrGNmpuSxunk97ZnO4Uuul7ixGcKeHaAG
         2JQcu7TF0hrsgJQSExj3aF5NiZJxOoNJuNnOdAtOfgYmyA13Rab+qANKZC49N+FkwZJG
         snyvWTwDKWYxr7M4Ie0ZPHgTIAKjp1QUgBV9kAZmIhz4w8CwPzDHTDmbfy4DOVDv4swP
         2Z28TEr4kJPS7pi35FN28TAFBwVWDNoUCgvEQ9AM7x276+VrbedxbwgKm9rBJTl6PUSB
         IiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730952179; x=1731556979;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ErYo73+gAWhwTYciX1LO4komCfmpQSriXqDoh6eSQFU=;
        b=i08dJcswuJAEfur2+nRQ00j/o6PvVp0I/DxPfw3xxXjE2IRqr34n72lEeaDe6sTAqD
         QdDcacDuDCahYanf0X2QBXh6cF8cJnH9puzTO6B5k0p/e5loG3N0e9B1oWckFlGDHZLH
         UOSGhVwYFIEPFxu+yb7C4dE8J01f2I6Q76uZZXmXQfqmHy4/6UNl2KwUtgmjyg166vCp
         A/4XYUycBCaObMzMjY8M2ghNehypP0b1/3PsuBfftl/7F+wyxE6B8mtn16wcVqj+eYTc
         AZCLClag/1spM3vQgeMcSdw9jUuOYrnYYKs2CzBIpZlG3SWOp9uzCSoPbIC1/u1qvRwG
         xAbw==
X-Gm-Message-State: AOJu0YzUbYt7g6b7R2SMk+ObkClg6czxj4xcasn5oFqjkjrMViGMX/nX
	/P2VLybucpd7baCYR46Agc/jBqpAdXFDY1LOwn9ray4EhamEMH5eltuZP2NabxS4Bls9uQV58o8
	viqwmoOfbCQ==
X-Google-Smtp-Source: AGHT+IFQsyOzE0bv1vZ+uFApEsJWUvfChQs+d4izWRMPA8b2quSBJ1ZlzmGu+B70umq1qYq4VeFOZVK5HgafzQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a25:d813:0:b0:e28:ee84:e4d8 with SMTP id
 3f1490d57ef6-e336f3e2204mr494276.3.1730952179189; Wed, 06 Nov 2024 20:02:59
 -0800 (PST)
Date: Thu,  7 Nov 2024 04:02:25 +0000
In-Reply-To: <20241107040239.2847143-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107040239.2847143-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241107040239.2847143-4-cmllamas@google.com>
Subject: [PATCH v2 3/8] binder: select correct nid for pages in LRU
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
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index acdc05552603..7e205b508ce9 100644
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
@@ -333,7 +336,10 @@ static void binder_lru_freelist_del(struct binder_alloc *alloc,
 		if (page->page_ptr) {
 			trace_binder_alloc_lru_start(alloc, index);
 
-			on_lru = list_lru_del_obj(&binder_freelist, &page->lru);
+			on_lru = list_lru_del(&binder_freelist,
+					      &page->lru,
+					      page_to_nid(page->page_ptr),
+					      NULL);
 			WARN_ON(!on_lru);
 
 			trace_binder_alloc_lru_end(alloc, index);
@@ -946,8 +952,10 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
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
2.47.0.199.ga7371fff76-goog


