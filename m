Return-Path: <linux-kernel+bounces-430251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0079E2E7D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3BAF281D8B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C29209684;
	Tue,  3 Dec 2024 21:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="drE7YeN6"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDCF20ADE4
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 21:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262922; cv=none; b=Yfpf+LrmwpJRP3uR7DfkcaCCieQYKft2+C823EQSD4mQH1S/U82lcgA87imIzUgWMK7yxhnizVpPakrrHXcRjvFBC89Yk24lpII4ju5tK2VeyDGoqQ4fIcWzVVksI/DiPRgN64MpTbs8xPkaUJMZ93HN9uWKvcWZy57lTpJaV5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262922; c=relaxed/simple;
	bh=Uw4pdPuj7RQuQpX2ZJLEmQOMp+U9isTb7zR1xRQDXz4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t7HQtFCA5FYC+Nvm4tdClsvyaEStfZ46u6r30xkAN86H6z9B2Fs7KXx/Xe7R4wD3ocvag1CERU7bCU0+oSzXroaY4+Cn91cUKG6ualPrQmeUeLIwmrodDNXm4BpqEeYQxPfCQwgx74Y7zNdvHBsy+hjB7PJxl6UqykiCzNJRS9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=drE7YeN6; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7251698c10aso5737668b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 13:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733262920; x=1733867720; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gCCqnAEZK+ZKpJb5t5zYVlo4wXMTT1QvqaeCY/ftsfA=;
        b=drE7YeN6V2GmQmgaYpI1jPTKsFeqY1IPosO2Xng5FIZ0R/CQNB1wPZ5MKHzhS4uMBC
         UuC3dRaUDHAwdtKp86KiqKYk4+bqJcUXabMt7c7hRZL2LsoX3W0nIscHYxAXm5FgB+p3
         V+yizb12hHUyoPGJM3xKjYwmZp694o5gC+Z5a3DTzcgCLIK8h++8rskqjkStcrzCo7sT
         C5C19d3gYsmPCpZnUlhikYBxzyoZuRc3f00vJj4YJSzQV/uoJ4Dkq4mB0EVaCp0rXBLN
         z1Cc38To1HpQZvAECnE3zDZaebxzaBc+aGT8+9wvppurN7pabLWpi1oUiSN+D06AyROZ
         vDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262920; x=1733867720;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gCCqnAEZK+ZKpJb5t5zYVlo4wXMTT1QvqaeCY/ftsfA=;
        b=AneHitD2UdgYo1c5s9M0XEwjMjuLebFYWVRigxfN7jW9Qt7Xd9iaZz59axhme3OMJE
         yMez6HEV0ypD4jHFKJjJCHFK7peU9XEbcucSggEt1+BwySix2dZvveLYtkS4ZOpQf++L
         5r7OobSTC8/kfzxYCXu26F1YXqgwBmkRO3KQLog02P6YU7XaWYP5VoSaFPMrwpSkPy9i
         hI7Ef6b1eYwDQEYIPRzv879AieF/uNGU3Rzw06NiaxxUETp1iHznCJN8NSnd4iAxsZcy
         QAJd2k4/2P4i11CjnrLWm3vizqjKpC/3JtCRzqKOlqmZzwdlr/jFtQBx5pKrs0KqgoQt
         /ICQ==
X-Gm-Message-State: AOJu0YweeRR4hHnpv6g/YClHZru/czNk3wgCz5g5WD9oEjfQmxqyOdRn
	o9WDSqpVxKg8eJhJRo83TnnhlMYmwry2pY/4KU8ZupyUxqrwlumm/slmnS+7z4BzTuipVd2boyA
	ULYJaLoh4BA==
X-Google-Smtp-Source: AGHT+IFU6dUxmyTsRGZeIXrIqF1/FJ6uWBI5rS4YG76QjdHGSO5HrdORaRH9j2JEHYUJCjvfteUKzBUWGeoQFw==
X-Received: from pfbcr9.prod.google.com ([2002:a05:6a00:f09:b0:71e:6711:537c])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:181b:b0:71e:427a:68de with SMTP id d2e1a72fcca58-7257fcd7ce6mr6044569b3a.24.1733262920677;
 Tue, 03 Dec 2024 13:55:20 -0800 (PST)
Date: Tue,  3 Dec 2024 21:54:37 +0000
In-Reply-To: <20241203215452.2820071-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241203215452.2820071-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203215452.2820071-4-cmllamas@google.com>
Subject: [PATCH v6 3/9] binder: select correct nid for pages in LRU
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


