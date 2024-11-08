Return-Path: <linux-kernel+bounces-402242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B71449C2561
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88721C221AA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8CB1C1F26;
	Fri,  8 Nov 2024 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gpFErAKl"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F191C1F0A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731093074; cv=none; b=ZZQb9W7tpb6QVFzlbu8LA2m+CZCTLFjwkrqVTeoOb2vJIjLe1yEhqYCahJ8xMYMSAa+DBy77owYAqiRuPWTNaQdLKRjMNMBqR53QS6/PLk/09WPasky+T0vfR32GXv1Nd5DBSYhJoUkGW3C457ktH414+x2fIPzzMAaCn/gtyHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731093074; c=relaxed/simple;
	bh=Hx0EQ2Kr8Du49RUPIOBNzvmHVS9zJDGYynBmxc8SeWg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EEf4/owKVfMHZPP+o8YY55rzx7fHr2mhZEFLXWbZtigXtaWKvHmIXyxX8NuNfXy234WUjEFEce3wE5ys+Ka07iCxYU+bSjqRIY9+t/8eSMnTtgOqpSCBWNzeF02k7auKUqIfyo2iGhb8Y5BazBk3MjpbzKD2Dk7flch1WoeSnkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gpFErAKl; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-210d5ea3cf5so20123375ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 11:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731093072; x=1731697872; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kL+UVwsljIj2o4nUo6MdjhrdjZyw3OwGno0tlANfzu8=;
        b=gpFErAKlVh/Ry7gy0JWlSI+hTQaizDLDyXNXEltK4Erfd1ip87ZmBSH4t7GBangR+O
         6krqFBmA1TtYCQUeWlvSYUsPgRL55C3eK649syEsWH1A75+8OfDIGfRcyPczxdfUBHgV
         HjdVuJ78Z3Zh2m4Awe6x2k/kUwoD93sm43ug4KkPScEnZOODYaketR0+bLNQrNZJ18NK
         TRMokEYy/pnQYRHhaaZFx32cLuQB0iepU8zDmLWIMw7o3IcMT875R8EGC32gLwgGPRbk
         0OYxdIzo3PYWPlyPVaASNqMHzEqWv8C79qyHpkm5yB84A4jFCONGRtglEZ5suRhPSKBp
         0ISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731093072; x=1731697872;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kL+UVwsljIj2o4nUo6MdjhrdjZyw3OwGno0tlANfzu8=;
        b=lTBSgxelrsGJ7WeDGnUpO3hxYarCWMmxHH9xJdPf4XrhsXRpDKIAs0+Ut4bvlYU4NW
         Dkr1bNBD2f7b5HeA2VQmqd8Y6SK3iCYy1aEdFFAkWvIkL4yuISHLuhCMNgUu0KC8zTVH
         eVKR94EHXSl/0Q+NtF/cG6XskTTCYyloPlyxROzLJpefVkXRGIrSjh9QahHe1NF3eJsR
         Y+/CExtE6q7WX9FRyPwG3RD9KkMQ8d1d6Wge1SC/bFqqMjcBSBO03e1ra5Mup96ofzW6
         D+AgFXfYb4pq+QNAptGez/q5XGo3C47i0mnUMSGb3mfLbayrePXqTIcqjVWcTH0mi85b
         bmQA==
X-Gm-Message-State: AOJu0Yz2DvY2846xMnCLbXlC7LTJKGFGEqkTEVCBHrMgzBMfmfW8AfMJ
	Al09wGgHB4Htxa7BcSVVT2NdyCamBIl0p/YasQRMjKkx/SUaM7/BiP2O9cs+pfA3SNjiGEd2TbE
	WvgGIJhZKEg==
X-Google-Smtp-Source: AGHT+IHRr7ZlJpb9+f8Jos9UYbFt60q2R1BbncgQSIT5ne9f4EbEpE5p7UrzLpZPx3cALUYA5ZhYpm1xlxDXyA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:902:6bc3:b0:205:76b1:1765 with SMTP
 id d9443c01a7336-2118370cb1bmr218485ad.3.1731093071936; Fri, 08 Nov 2024
 11:11:11 -0800 (PST)
Date: Fri,  8 Nov 2024 19:10:45 +0000
In-Reply-To: <20241108191057.3288442-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108191057.3288442-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241108191057.3288442-4-cmllamas@google.com>
Subject: [PATCH v3 3/8] binder: select correct nid for pages in LRU
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
index 2ab520c285b3..08daf0b75b12 100644
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
2.47.0.277.g8800431eea-goog


