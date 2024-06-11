Return-Path: <linux-kernel+bounces-209193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382DC902E8B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBF32282728
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD18215ADBB;
	Tue, 11 Jun 2024 02:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zVIzuFRW"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2A6A2A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718073922; cv=none; b=VXIeTFMduLomn/TdzMAjoUslupB8+O+B3bOJz9QmFVhf3t11QaUx44eE1Pu58G3kRhs1+lxtkJ8xE1MK2GjBAbLmNOFd1WXHMtMJzZTELbgTsuTngSzRCi+KfhB1/U0aPecX1NI8kalfGWihvBoAm3sPS602uXRVWIWsoNkkD9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718073922; c=relaxed/simple;
	bh=KlWwNTJbnJtKYJtruw5ba7WJcmLia8cxq0tQbQUqaik=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=u6bXaGEAu/6KDQ+tAppRzRrE4sd2FpUtYREGQfp6DwL5/fqYUqBkRi23/gxfFRqEr87DOYU3wfGKcAWYd7D6SwN6DPR2lLYkGSCqWcYoKO0UIZuJgOIdMNVUtNXkuLmRzMHPt0TgKTu6HFxUj4YjMuarcxHhGhebCnHiSuMFSfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zVIzuFRW; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfa56e1a163so9440666276.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 19:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718073919; x=1718678719; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gw2fVBeEZMK663ax5icKG8q0wolcMNh0B93tTF9ptJo=;
        b=zVIzuFRWJNr+f0pdTX04lxXh4fXGFK/Qi1BdIi8N+/QbJwOo4w1x+7Zn1/SLIglEbN
         A8WSC63RcC58tMp9zmd+Y49MQNAvst+wwDNrqmY/UzEp1ttBq2ts5+/WXKTeBKiFF1NI
         W+VwXJAvTRsOudU/ThDpXOjl6R7Ir1KfN6E9QHjUr1ySud7yTG7rQZSfB5Y4zS9/KV68
         aa7uag2ZVIgIi6bb6i/MEDSrWtFTTYPmJi7nFMCYZcYGqxe3aBt7++9zA/7f0+j43xoF
         ztoB1m6m22UVY3NRQqMYIHBp/qzPhugS8yo+g4jAreVk/aN2FWftz0zRQ9PGVMy9IIt3
         KqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718073919; x=1718678719;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gw2fVBeEZMK663ax5icKG8q0wolcMNh0B93tTF9ptJo=;
        b=rk3PPrw0GpbRszn8lwORcfulUi7SajstsF/ODfX245dt8sdrXYfjqlAZ/jd1waRQdo
         HqfeZXfXobDiqjM6QKmRurzzdNPcfQC3w//fZkXMwcIGJ5t1SfssHaghqSd3o7GIdDye
         IuDKSphwPGEscfcL6XoZuW65TxdiLlCdD+oJLBQcdIk3y59UQxcAIhJfsQ2GRI3P9kPZ
         VHddEuN6+AkmEBXYqwub0NLZBLxb8JRqc6EeVWWtRGUtTJiMRUSQ0+U4x1WSBRVW1jJC
         0nPo/h8NihsNdVGh6yWpFgrzV6p/Oz9RaLJ2TpDV5MbZmF/SO1rX68S7Z/F+bq4jKCOj
         7EPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQnCmvCpe3xo0Jt8wL30rtEPYWvwfJuo9LjfJuJ1iprpkHG4rbeftU2sOT4DPE0en+QKmNdQxD/KeG2MbCEoKlfcqZ8apoK7UVITTX
X-Gm-Message-State: AOJu0YwQMs2MZTiTqe5mjOBYBMl839z4rjpCKQ2YM+Mqjyaf7th5U7Dk
	1P8NKMdLVF7EP7c1+P8yDRAyHol43G4ze/9etdlc/ov0I/nTeLgyvBOz+ME/U6uUcfKRZ5xgVHu
	jDaioo3pD9hDCfwXfPA==
X-Google-Smtp-Source: AGHT+IErIy1eYfnrABkOmVD9J5eyfhJx+kNkb/sBrRXlcmpYHfut7tKeNb+mtfB4c//I0/TnhK97XtmSed3uvDPF
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:188f:b0:df7:8c1b:430a with
 SMTP id 3f1490d57ef6-dfaf64ea35emr3779077276.3.1718073918970; Mon, 10 Jun
 2024 19:45:18 -0700 (PDT)
Date: Tue, 11 Jun 2024 02:45:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240611024516.1375191-1-yosryahmed@google.com>
Subject: [PATCH v3 1/3] mm: zswap: rename is_zswap_enabled() to zswap_is_enabled()
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Barry Song <21cnbao@gmail.com>, 
	Chris Li <chrisl@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation of introducing a similar function, rename
is_zswap_enabled() to use zswap_* prefix like other zswap functions.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/zswap.h | 4 ++--
 mm/memcontrol.c       | 2 +-
 mm/zswap.c            | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 2a85b941db975..ce5e7bfe8f1ec 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -35,7 +35,7 @@ void zswap_swapoff(int type);
 void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg);
 void zswap_lruvec_state_init(struct lruvec *lruvec);
 void zswap_folio_swapin(struct folio *folio);
-bool is_zswap_enabled(void);
+bool zswap_is_enabled(void);
 #else
 
 struct zswap_lruvec_state {};
@@ -60,7 +60,7 @@ static inline void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg) {}
 static inline void zswap_lruvec_state_init(struct lruvec *lruvec) {}
 static inline void zswap_folio_swapin(struct folio *folio) {}
 
-static inline bool is_zswap_enabled(void)
+static inline bool zswap_is_enabled(void)
 {
 	return false;
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1303ed01bb5e5..a811dfff10cda 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -8469,7 +8469,7 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size)
 bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
 {
 	/* if zswap is disabled, do not block pages going to the swapping device */
-	return !is_zswap_enabled() || !memcg || READ_ONCE(memcg->zswap_writeback);
+	return !zswap_is_enabled() || !memcg || READ_ONCE(memcg->zswap_writeback);
 }
 
 static u64 zswap_current_read(struct cgroup_subsys_state *css,
diff --git a/mm/zswap.c b/mm/zswap.c
index b9b35ef86d9be..a8c8dd8cfe6f5 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -131,7 +131,7 @@ static bool zswap_shrinker_enabled = IS_ENABLED(
 		CONFIG_ZSWAP_SHRINKER_DEFAULT_ON);
 module_param_named(shrinker_enabled, zswap_shrinker_enabled, bool, 0644);
 
-bool is_zswap_enabled(void)
+bool zswap_is_enabled(void)
 {
 	return zswap_enabled;
 }
-- 
2.45.2.505.gda0bf45e8d-goog


