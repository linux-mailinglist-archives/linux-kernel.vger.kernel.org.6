Return-Path: <linux-kernel+bounces-422728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2819D9DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69322B28044
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B6E1DED57;
	Tue, 26 Nov 2024 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rrpNlNYR"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CADB1DE4E4
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732646432; cv=none; b=OX/TVxY+iX33Z0gWIxoK4eAkCMteZXs0l/olxTQsG07Z1hlq1iXN/x+zq8hydkbvtP2PpO/JwWRwVuCtKRY7JvLH4jbhV/l7ZS9laXAyN+g46J1JDEYTgFDYsfrVsrwhRAXL/3jwA92rbfsq8mz1g2Q399nYfUMx47+3tp7bSxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732646432; c=relaxed/simple;
	bh=Uw4pdPuj7RQuQpX2ZJLEmQOMp+U9isTb7zR1xRQDXz4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oBZb82y45ITXJVUf5pcYX0mHZHK3C/A8b2hoI8t+Sp5bU0+Bs3+KoZml/do9QdbqK7kFGRhfNkTEaYdEUprNGM5+nDsZNl4MFNLLwaGbMPF2Mg1ZFgKxeUIUHz0hhrdpg1rruQNK4QXbSeB5zN54izT3p5UR6W+AGWM9dOewo4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rrpNlNYR; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7eaac1e95ffso5323287a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732646430; x=1733251230; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gCCqnAEZK+ZKpJb5t5zYVlo4wXMTT1QvqaeCY/ftsfA=;
        b=rrpNlNYRMlZlUH+zBu7vZRuRVtkV7txZRf8MhHFXcgMUJNYPC4vXZiCY7fjPjLMHhv
         zZ0641KdDSwPRbNTid92VwrkC+S4MjsLLtO/De/tUBoJtTK98MUJRW8KZSegZR+lqnAl
         E7xLQEnvyGuXdmTmE4uWP0kzvmYpQ8EDzuL8NNoyI8z36ZE6NpfjMjTh08dXPcQBgSpk
         JyN4aASF2bxN9RIRuUTC0hQxbC+kMbE0qqQZgauQqUl8o6mfVNSSHC/B8I2OjwiXFBB+
         1eQGIvtebQdccZtph6UquNwW5zydGWiBwQnKNiNF56QpeUosuUmk1hO71PwFf4Zlrocm
         TjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732646430; x=1733251230;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gCCqnAEZK+ZKpJb5t5zYVlo4wXMTT1QvqaeCY/ftsfA=;
        b=YMjNNGZZTKWPOKhj7XjhbMSKFCXDgvEvmmV1AIzTfLP84fvv+vfcJGPdvxFc7/SFHy
         Ty9eRUz0/qoE+0Aj8BQIoPo1rK/raaBTHJylSLaIxWL27wLTWAEt3CRUu2zUOzbVM+i9
         cP3lIxaa4QBGVZ7MyoNto5IOPIXadh08jSG8x3bXBAr2PhGb0++dObdDqNMNmkcMq4NK
         /WE+LrTaLNasv9VlZ1jGJ0V+U2iIef+FM5gHPJTets1tW1TgSyJrH8OPyjTz1J14w7bI
         gAfxh+eoWFh4kpANKZNXaYJMQ88u1ysN01z+K2lhm5yPdDSP6GuvYYIDl/fpTNr9DbwO
         FOHA==
X-Gm-Message-State: AOJu0YzU8SKS5uNJLph5Ip+E1L+3oh5J8uG22d4o5hABftPmF3HVr0sZ
	Lx8IQEr4EUWzI4vbBmQ8yc3doVaOAmb4vJmIkAU2zcYaWNLHJF8ZOPf1pG4pJfecoXNat6TvN9+
	f2zVzu8OmSw==
X-Google-Smtp-Source: AGHT+IE3yzrEZwCo4N76XVKa7eBbAO1SbymavsoukvdxbSIMWMXgWq7Tgew0q/GrTc0LySGW5F07uG0FVGb37w==
X-Received: from pfau8.prod.google.com ([2002:a05:6a00:aa88:b0:725:303c:628e])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3987:b0:1d9:1a77:3875 with SMTP id adf61e73a8af0-1e0e0b7e159mr532048637.42.1732646430405;
 Tue, 26 Nov 2024 10:40:30 -0800 (PST)
Date: Tue, 26 Nov 2024 18:40:06 +0000
In-Reply-To: <20241126184021.45292-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241126184021.45292-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241126184021.45292-4-cmllamas@google.com>
Subject: [PATCH v5 3/9] binder: select correct nid for pages in LRU
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


