Return-Path: <linux-kernel+bounces-436204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CB59E8272
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 23:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50DD166041
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 22:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E60C190077;
	Sat,  7 Dec 2024 22:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uSz5IAzE"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F91312C7FD
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 22:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733609730; cv=none; b=ltCtCAPggGxNH341TK4VkDwbRe4QoTSpdUL+VL9zpCoqfFEfY5S3lbmCXvxVdGdLHdfpNnY6LarxEA7FMeDqFN8iy0CvpdznsIMmm0n1cuRNE/dyssgiSGENpipk4I3MZyyCbi1DvqO5dg+oqCDQ/euQrCnVGlJLWjBTptaymrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733609730; c=relaxed/simple;
	bh=XiSEz2JJBtdIoxT7K/+uOXzsYf9JPp/DAxpitCZzgn0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S8AoEjjUks1C+Hpxk5++rE2xIILHboiWu9oNAqbzX/2NGCogcqw1wJdK6kuYjL/Qft/R8YhtQJkLGFw1Pf2ifR9jfRmZG/no4JAPg/bBqUeURUjYspo5ju786Ft4pa+Ej6kmy7x1aCe50f/9tNK75mAWLdH5b4FjXToJGuQuf+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uSz5IAzE; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-725c882576aso997996b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 14:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733609728; x=1734214528; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gY9A2hZ07C4gph5EkXou5eK7gRFH6gXGFcx+0iC/Exo=;
        b=uSz5IAzEznrig9BV96zxV8VSib00AsQCg3i7pEPjsuYwqnTKoYv78G71/0j51x1UHp
         KmIk+LyS03wN/nbBq51scnpXiPjwd0J03xdt/phCKz5m6c9EkrAHNwejZucM+12KrY/o
         2qM4yEQs9P9zilXoxw9G1xNxcrbgA/FFEZYPNLXreDOvU5tXLTR4QRZ+8xyLxoInVL21
         sVlNXy4anM/2pBctx4FrshX610IeSxDqyrV5V+CSHCf/+UngpoiEsWOKKg3fS7/QSdq0
         9hMn8rECUHSLm3uo3i6Gbk0SxM8FQ6+sPbnmwgLDiIRTimxUIuISIrni7D5yjJ5y2kX7
         1ysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733609728; x=1734214528;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gY9A2hZ07C4gph5EkXou5eK7gRFH6gXGFcx+0iC/Exo=;
        b=FWnTscjIo+iIAHFywcJ7wJqabpaJmexzJRihfgeC52R2lJ5kQaD5+RAChLQMSzNupu
         KcNy37zdHofdcl+DSdeRtssIFw5cONzou8Q6FmcY9jjBmURUwNf5U3vddMoIrrGQqfbr
         J0f1xezWbuFbfoiiFCWXknwHYnYDoNeimYUJXHpxC9GsyrkFdzhCpFqKzb90HaJzuSGf
         yJHGlVRSApPW87fyRIAIaeNp3OdlcoQreeuLGEVk0Pa8xZ8CreRb2867iyPcmRSphtbu
         LlvBw6WOrT8xdtpGjYIFqaHuRdR2ttqXpO1cYJHQkHS78IM3trKuUUq+Dpx0Bxc6u4gL
         2txw==
X-Forwarded-Encrypted: i=1; AJvYcCUfylgRYtSLDRARDt0Er2N1jyZ0n6sqd+3hs1LvuiXQXo4K4EqSBbQ7nN4CYm1OuSWIpRYXJph4Wk3QfTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz0KEwEMDP4rZTGcwoq47+A+G43Z+oOPH/Fqv+7UpwitHXMDd9
	N9uAUg7c/hqCZPvgkVSOk8gZy5mY5p7NddGaGTSPYl+Vq8o9Tz1PX5ylVfrM/3TMyhYX3uDaJKY
	7EQ==
X-Google-Smtp-Source: AGHT+IHCXiEm/R2rY0sBQTBrLZxsmJB5U1ibMxl9sF0XXm74TaiiQnoh1RCoPUcB5Jt5hjXX9XZSsqYn8nU=
X-Received: from pfwz36.prod.google.com ([2002:a05:6a00:1da4:b0:724:f614:656f])
 (user=yuzhao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1911:b0:724:f6a2:7b77
 with SMTP id d2e1a72fcca58-725b81a3eb6mr12675093b3a.17.1733609728505; Sat, 07
 Dec 2024 14:15:28 -0800 (PST)
Date: Sat,  7 Dec 2024 15:15:17 -0700
In-Reply-To: <20241207221522.2250311-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241207221522.2250311-1-yuzhao@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241207221522.2250311-2-yuzhao@google.com>
Subject: [PATCH mm-unstable v3 1/6] mm/mglru: clean up workingset
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


