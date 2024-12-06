Return-Path: <linux-kernel+bounces-434149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 863EF9E6242
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB8F61885411
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F241D696;
	Fri,  6 Dec 2024 00:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XT2a2La0"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC96E1DFD1
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733445096; cv=none; b=I4FwaujjRmcLm+nihaB2eegW1zk3YXvtWkJ5d+lh7C4PmSt9Ut0ahxI745Tf0kmkNUXIp3BtbUKiahAwa+Kpc5OdCWZ70fAvSXdhF3jfETgI5ha9h5AC/WB1mwSNjqKNsIhAgICDHPW0rBjGY52khsCNIRdR6W3GftTyCiZ4U+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733445096; c=relaxed/simple;
	bh=XiSEz2JJBtdIoxT7K/+uOXzsYf9JPp/DAxpitCZzgn0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hOydbRsFvvCbglrzXiL0Ma7/QCFLLe3daB8E3SSmceBwQzQ4YTg7B0ggsfTaa0adK3S4qKXGiIIjxE6+2cAteWPX2h44pG2kKA04XFIrkBcSuwPgw+ia+NL9QZK5det89s2ymUGCS9DdkMC068nkjqaDOZtaLbjRv33BPGYmXeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XT2a2La0; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7250da8a2a5so1298547b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733445094; x=1734049894; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gY9A2hZ07C4gph5EkXou5eK7gRFH6gXGFcx+0iC/Exo=;
        b=XT2a2La0jZahTt4IX3OAYfCuTwLLPGy2XHv40fX100H2N3eaF9AVmLuHtkrF8oLY/A
         3lqFUXwH8Q2zQdf16DHtBWweucklRJqOIpyxXXKYujUq+Ob+whcguBvRclhHaVekyfCo
         lWdSpE95QeelTEJLXYvzHktwbtusrIJnT2dVwe40b0D4WZ2a7kLLgVZW2UetpS1cpnFj
         vrITU6z02k72Jqpfv2Z/GqhfjZlfTKbu4AZPx9x3OHK77L69KdIsI5McXOflmUueYksw
         0d3uH1XqsMsIO6gpUXMNX+RHnhyEFpamfTlskkf7DsmBZgIf3VfIVz322wLZLYx0D4Rn
         agxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733445094; x=1734049894;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gY9A2hZ07C4gph5EkXou5eK7gRFH6gXGFcx+0iC/Exo=;
        b=PfvevMvOxk3goLRGDfKyFapXy2l47VQ7GX0/oCeNc/+E032/QWChUYtIJbd2LekT0e
         LKwIqdRaYMDYPzKp3xFxCRuTexumqkaT1xNhW4Qs8D4vn9WpdDnIqz3OaUn7/hdza0RQ
         xzWfL8DYFHVmE/mjC15QkiOdZSTL06zu4kcmVkKgAwwIG6Tuxq2hW9KdCoGi1lcypNBI
         yoNhXuQxGBSxinb8geAzD38OiaSIgfkJRUcNY8+L+s6NkVdt0+GNiUgrd90Osxbe04RW
         65oIlr+JZ6AJdzt1OeP1RIv3z/4AZQKQfQFaCCMHfvX5UMPdkcUwkFFEdWsxOZKUFqoX
         Vtng==
X-Forwarded-Encrypted: i=1; AJvYcCXT/sm87Cb0fzzf0xAprgYB6f4ZAQJXmMjJJ0mJveFgsWsH5xGP/lnUlvDh6IWj8xujPLaMyaDdprakhlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwghwKVbufK0Z2MwmTrraAOurCq/ml8DZPAFiHiMVGSkEzNY2LR
	YsQdpZ8Et2XU5N6+BaWcAjitKpos6Tf3dnbKgaqgxSs43mvqDplG+z/wDe+xqoj/mXtpXNpGcG8
	KDg==
X-Google-Smtp-Source: AGHT+IG6Au9pfRghDcM8iM0cy1enSAIDDkXjALs9OLLc2AlZ1mMtncq3AmviK9jGO8YbyJSyYoHMLUHAqO4=
X-Received: from pfbc10.prod.google.com ([2002:a05:6a00:ad0a:b0:725:8ee5:e458])
 (user=yuzhao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8d6:b0:725:8f15:f897
 with SMTP id d2e1a72fcca58-725b80e4a9dmr2046628b3a.4.1733445094214; Thu, 05
 Dec 2024 16:31:34 -0800 (PST)
Date: Thu,  5 Dec 2024 17:31:21 -0700
In-Reply-To: <20241206003126.1338283-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206003126.1338283-1-yuzhao@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206003126.1338283-2-yuzhao@google.com>
Subject: [PATCH mm-unstable v2 1/6] mm/mglru: clean up workingset
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"

Move VM_BUG_ON_FOLIO() to cover both the default and MGLRU paths. Also
use a pair of rcu_read_lock() and rcu_read_unlock() within each path,
to improve readability.

This change should not have any side effects.

Signed-off-by: Yu Zhao <yuzhao@google.com>
Tested-by: Kalesh Singh <kaleshsingh@google.com>
---
 mm/workingset.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index a4705e196545..ad181d1b8cf1 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -428,17 +428,17 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset,
 	struct pglist_data *pgdat;
 	unsigned long eviction;
 
-	rcu_read_lock();
-
 	if (lru_gen_enabled()) {
-		bool recent = lru_gen_test_recent(shadow, file,
-				&eviction_lruvec, &eviction, workingset);
+		bool recent;
 
+		rcu_read_lock();
+		recent = lru_gen_test_recent(shadow, file, &eviction_lruvec,
+					     &eviction, workingset);
 		rcu_read_unlock();
 		return recent;
 	}
 
-
+	rcu_read_lock();
 	unpack_shadow(shadow, &memcgid, &pgdat, &eviction, workingset);
 	eviction <<= bucket_order;
 
@@ -459,14 +459,12 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset,
 	 * configurations instead.
 	 */
 	eviction_memcg = mem_cgroup_from_id(memcgid);
-	if (!mem_cgroup_disabled() &&
-	    (!eviction_memcg || !mem_cgroup_tryget(eviction_memcg))) {
-		rcu_read_unlock();
+	if (!mem_cgroup_tryget(eviction_memcg))
+		eviction_memcg = NULL;
+	rcu_read_unlock();
+
+	if (!mem_cgroup_disabled() && !eviction_memcg)
 		return false;
-	}
-
-	rcu_read_unlock();
-
 	/*
 	 * Flush stats (and potentially sleep) outside the RCU read section.
 	 *
@@ -544,6 +542,8 @@ void workingset_refault(struct folio *folio, void *shadow)
 	bool workingset;
 	long nr;
 
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+
 	if (lru_gen_enabled()) {
 		lru_gen_refault(folio, shadow);
 		return;
@@ -558,7 +558,6 @@ void workingset_refault(struct folio *folio, void *shadow)
 	 * is actually experiencing the refault event. Make sure the folio is
 	 * locked to guarantee folio_memcg() stability throughout.
 	 */
-	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	nr = folio_nr_pages(folio);
 	memcg = folio_memcg(folio);
 	pgdat = folio_pgdat(folio);
-- 
2.47.0.338.g60cca15819-goog


