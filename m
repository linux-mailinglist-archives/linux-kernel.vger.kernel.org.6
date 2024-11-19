Return-Path: <linux-kernel+bounces-414833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BCE9D2DFC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09E88284247
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74E213D8A3;
	Tue, 19 Nov 2024 18:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qkVDwVx+"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A559B1D3625
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732041183; cv=none; b=hmXojaIktYPnsdpHCZ42EIN595XrGBn0zwnmh+m/wVhjYNgtpf8gyAyug+3lOiJx1eR1WYCflsSowUpw19mJuziCwSRbt+I3zXa1NGj3tfyQB7qdF/SsOzp1x41lBL0UrhTJ9Hjs4iIWv49ekp/7nSbr5ZNYmRMEwv0Afpv53rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732041183; c=relaxed/simple;
	bh=Q0SgoeotoT2Y54W79Z28gQJZJWWn+2M7R80hDomp1z8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rnTYHzpbYiR+qFvfnACeQbwd4luLwkWjgJxfU5WFpCIWoWcpW+aQadVq9vTPkVE1wvtW7tOFzmfIm9fa7qk2L1mphxKh8bi0gfRdp5n6zL79SkCIFU3LaNenngc0HfQmzc1zYr/3qCMzZhXuPf71PsrVqCT9W+HkPJv6+jbZNAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qkVDwVx+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2e9b243dccdso3482414a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732041181; x=1732645981; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8XasUXjmO5ZGyzj3NfSvgHBs7VRqzc0tw6KFEM3UDYU=;
        b=qkVDwVx+HXElHuIzAALhOovm+4tdPkAhitdFt9w2e5zOrILXygFKWlzpSVh0fMif6J
         1YwMvw1jitPi54sJT8IVFcM0PFW+MZGA+Ht5t0Uof3GzBT/o/RcPPPaNdLdR8eSC1/NR
         rJbnljvTHGX3197Wz2/TfVmem6Gp075BqJEETwQAtxWvFtNcIif0yTOHarQu5Ezzrdh9
         pj4EdWqzeboccYAMTUelMPgrZsSnr+WJUNi0fUQhbNuKycOKxuhamMyKJ78tT9Kw2w/h
         rdk88zip1leIUg8R5UALtNNEtViIeCossMK1/WoyWKKuYv3p3ey87hOuVFo/71LclEGq
         LQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732041181; x=1732645981;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8XasUXjmO5ZGyzj3NfSvgHBs7VRqzc0tw6KFEM3UDYU=;
        b=iUxn+o3wW727zJIr+UAWs/MHb3ldqoy9CKcdXxtNmwJ0+C3uVHhykSRq9kowRCYvoJ
         wGiQRi3h9RuISb/yabO2phdREQ4Cv8bUzTm0ZeeGE2HivDMpwJIeuD+92Vo9iOZsgvv0
         PzI/wh7tTT9UhNY5jHEvjvpyJC3HJ3GvdTFfY0FiEDUVKVGXC64pL2ffTrqjfLkrWbcN
         10DtKcrxEXF5woEqr55DbaTtb7eIW1tJro9kMAU7eAva+DjBE1sLYlqNCXlfFMLmeAHc
         hit28quOvRMCkFsZvMg3t/B1BIgwIZ9GMbWAiJAF2jcBKLCmBVQ+0nRvlHvWLoZ8TJtv
         ytZg==
X-Gm-Message-State: AOJu0YxOxQxXQAAmNGwfehZBoI9buQKHLgs+t8LgqycxGS4nlmX47r1Q
	zvIKQObKtfYAuhfwivwdvtF/JgicznNX+WRRNdQ2+7GV50UeeIV1Mb8VQBEWBPMMYUY6WxV5lDb
	LDrzAKqhv6g==
X-Google-Smtp-Source: AGHT+IF0dBBqOXmShmD77EFUnhMQTTOcrvsChfMv+7+SGG8FozE1AKx9g8DO/CsiKm2xbeDgm/Lon1y+9TCqtQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:90b:149:b0:2ea:563e:fc0d with SMTP id
 98e67ed59e1d1-2ea563efc6fmr27075a91.6.1732041180916; Tue, 19 Nov 2024
 10:33:00 -0800 (PST)
Date: Tue, 19 Nov 2024 18:32:36 +0000
In-Reply-To: <20241119183250.3497547-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241119183250.3497547-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241119183250.3497547-4-cmllamas@google.com>
Subject: [PATCH v4 3/9] binder: select correct nid for pages in LRU
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
index 0bc6ff1c341f..c1a9a11d2632 100644
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


