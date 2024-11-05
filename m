Return-Path: <linux-kernel+bounces-397076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DFC9BD66F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F89283E82
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA3D213EE3;
	Tue,  5 Nov 2024 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JI1CUy4l"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4777B215C79
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 20:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730836994; cv=none; b=tLQRQXMKPEq3JD9jpCESJCGuSqajfPenUCAN29tiWX/NSlCWKxDr78FKoQ0r27IUj17QyfHa08Z0b0+lJIETkwkVapVIhyQjCDeOAEmGT0EIlpqUdrSU4dc/QhbKCF0abWWoiFo4jNaZ6vAJFC2vcyh2G1PlP7GhuYDNYOYemUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730836994; c=relaxed/simple;
	bh=mPllwDesyBEdlBxrZ5g/Firgv1x5wRgJxsWO2xuBapk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WF97OEwXHpQb0iSq5V7jWBKtSZAeiSHoo8G59GlVrlGmnAPsFK6iB/J4FngNlms3413ksrSerOgEiHBBe1RC6JD+YIPBZyBzrWG5G8YuIHdQGxml0U9ZX9J9P5YeBFtZ7tcPx3cVDVCKxJH8KeG80CqwdPQxEguzZyYETu3r3s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JI1CUy4l; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28fc8902e6so10788065276.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 12:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730836992; x=1731441792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BzW62C5MAhdQp+8Al+uImyA19s54Ggsxbj0WN64RFYo=;
        b=JI1CUy4lyleY8c0uGZ6hCSF3mHyGs01PmlvtmEeHWEOg9JRpvb9QTTW6mvTEdFRFQt
         /3QPo9qnXSdelogaMLcjKX6JLKg3FG8xQCnZv9CHTilldCg7NMogsgKCEOemEGxBbTxz
         h2yKOX+gGglSV9O/S7lyvLDcmPe0su7OoIXodBx+dnjdm0JVeo4BovfkqBGZgxJO6eNQ
         MUcQStcueLUCq8XnlOQvnrsLaR8qt+6cyfluKYrI1xC98F1FiLCOigv46ioc4nvPyJ/d
         3twPlatGQwEVRPYgfTpjvdVUfdSzWzb75I1OjDAK28mE4K+rSyCu2j1H4dSgDMihn+VK
         XwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730836992; x=1731441792;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BzW62C5MAhdQp+8Al+uImyA19s54Ggsxbj0WN64RFYo=;
        b=N0O/r4MPkJ8geN31NbCIdfmUswLE6BXf8/OGuhd93WfqqlRGK1v818oIRNhYDInd31
         bve0N8O9zeDANoUM7FMV2SAfxJIWAt+g0RqgHtYyNXdiGiaJkkDiGc3kjDIofBtaZg7L
         FBP52fg6wPmeP0vme7zm83u6doTv0ttETx3wHb2EkUTuRyzVNNdz/798+lc5Xk8ZzPST
         RvlLJ49R20Cv3izMceKLhEvM9E4h53oILn5lTDtMpRNUxo3plHRlRPCxONQk317IOAYv
         oQtEeJ2AX23LIq1LGcGkm//ij++/pRRECCcsVMPzbnSuSAXLjblCUEyG6/t0pKh/ix/1
         QSnQ==
X-Gm-Message-State: AOJu0YzzIv6Mky6CJz+32zat9cEaPgi0ot7KKcLvOmQ5JP060lND1qlB
	lqf0fNPZa0lHSB5YyJzEMaQziJpjoyfjiCHODFLwoMY5Fk68IgK9h5IruThA1V0cRTZp8Z8Gdsf
	S/WguF04QaA==
X-Google-Smtp-Source: AGHT+IEu3UHssFcaZjCcLxb4vYdTRLy2JjU9p8QLbpFd3bQuV8lLSVUIMqmz/Wg7sU1mC2FqDOmCMdU0eHP3MA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a25:a305:0:b0:e11:639b:6428 with SMTP id
 3f1490d57ef6-e3087722c24mr78035276.0.1730836992271; Tue, 05 Nov 2024 12:03:12
 -0800 (PST)
Date: Tue,  5 Nov 2024 20:02:45 +0000
In-Reply-To: <20241105200258.2380168-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241105200258.2380168-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241105200258.2380168-4-cmllamas@google.com>
Subject: [PATCH 3/8] binder: select correct nid for pages in LRU
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
index 0fc6048cbc72..87011be7d8b7 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -211,7 +211,10 @@ static void binder_lru_freelist_add(struct binder_alloc *alloc,
 
 		trace_binder_free_lru_start(alloc, index);
 
-		ret = list_lru_add_obj(&binder_freelist, &page->lru);
+		ret = list_lru_add(&binder_freelist,
+				   &page->lru,
+				   page_to_nid(page->page_ptr),
+				   NULL);
 		WARN_ON(!ret);
 
 		trace_binder_free_lru_end(alloc, index);
@@ -337,7 +340,10 @@ static void binder_lru_freelist_del(struct binder_alloc *alloc,
 		if (page->page_ptr) {
 			trace_binder_alloc_lru_start(alloc, index);
 
-			on_lru = list_lru_del_obj(&binder_freelist, &page->lru);
+			on_lru = list_lru_del(&binder_freelist,
+					      &page->lru,
+					      page_to_nid(page->page_ptr),
+					      NULL);
 			WARN_ON(!on_lru);
 
 			trace_binder_alloc_lru_end(alloc, index);
@@ -950,8 +956,10 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
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


