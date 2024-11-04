Return-Path: <linux-kernel+bounces-395641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2709BC0E7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 23:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19548281D89
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92DA1FCC78;
	Mon,  4 Nov 2024 22:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vtp3rzdW"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26221FDFBE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 22:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730759291; cv=none; b=isXD4+UDSVxQQDxU8MY0qv3TLKk8bv1qZDRXeqmeqaiW6KCo73Y5ObWsmd4UzpinmEolcYDQ4NM33ndWTHHhx36CJwCL+RyJyfL4iRojGsfdGRlRQSSFX+KJDnBuA2q2W+0V0Wqz9FCg+UeR2eNaLNJn0bvY7SdwV8rSPZeaYl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730759291; c=relaxed/simple;
	bh=2ulKgS1WJ4dbuBnCKxnqeyIGe4MyeNcFUS3/7Qh/Yto=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hL36ekdnf2PKed74fdhNgmGPOfXEBY5SLIuWCRKXyLn5NHDDqGRQ/ZwLlXHwa/LxnFD0AaLNKsXDv+ACwpLeBlBA24JaRSGLZMDt3u4hmkhoLpU8hSk3TAD2zrZHQTiBVcKYGYOcgOAqaYVA2aKsyaZT7bR+oiIl9/s1KlFNIzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kerensun.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vtp3rzdW; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kerensun.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02fff66a83so7475582276.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 14:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730759288; x=1731364088; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=15O9ca4pVZTESzuvBdGrLRHe530YHW6qwFu9Oe4DO8I=;
        b=vtp3rzdWidZf3C/8B8T5T36g2m2yAh4UzT7nJvtEPnSY1lLbPDQXkifhZRVSCgupIH
         +V0Ow/e0ohARg8vr9kBTLgTxvul/BQv3PsFkszxG8bMmS2K3mQiayERZZrKqunanQnOK
         jxhw+p1VBXc50MpOscDDSWYYyaYIQGhtLIy6vG1ylJRf1bk8aZJ1fcYTJRguMZCBIlHx
         NJwSrmEyHnO9UDgAwG56Sl5nW0p1+cjXpQ3HIgacTKHM6kHi9tvE7mfJoy8jOmoUDo0W
         JufZVYykULhG6q0SEB1+X8UbgRWcB7pUE08DSO/uYU7hjKhRRiKkwyPlfzBaxC9jCM2H
         bDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730759288; x=1731364088;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=15O9ca4pVZTESzuvBdGrLRHe530YHW6qwFu9Oe4DO8I=;
        b=qW6xTXOzsYYnIl+JhMG2XMKopopxfaL/dCCxd+fwwfSugQ9y0JYv/NLRG8aUhqCzwU
         mKWRDvkqqO3IsXh1g+fjE/tpqpn/HLfVB8x2ZtPiuQyP6zkHiuILlXpco/6IKL4lGdNE
         vaKX31c58BsCGbtBkaKxjBUJQM8DqzkSTB63Acgp4VWOpCcZR7/dEuroE1W7uRbD1i1h
         +AcMXeRCRsp56igerhWZu7P4UXe7IzLYs21RUA3c/9LzOeGyHDljeV13hAKNK6zoAyrw
         v6haLRBVIidqIdE8MYS3OqAIYN2g9ZqLVqt8FrIJJKjvqyeeGkSujLXXUcgZlIuO7qcr
         gNQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9vnz8HV6gwTojQu9WF9MLkVQ8BDFDdTUDTd4DdbOHQ84Yy/KoVYVamPG9VVLudTahbKoryJ9KaBCf7WI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdLGBzJ4sjQAuXGMUJyewCrq8zXC5JMAG38yqLlGRL1QyDR/H3
	ma+lllMEeEAVXuwW+00B1C7g/KrQChG4MIECYei2l0JaLI1mUnaxNwfdaBrkZpgD+RcLxptfO3r
	N4W2ZL1srkA==
X-Google-Smtp-Source: AGHT+IEpn3Ozfl3bEakiUcys3vke1g1CcEk4jHzka3T3PWfF9UiVOWvD6xNRzVdmFNyJHcOxgC4N0YzCvE4knA==
X-Received: from kerensun.svl.corp.google.com ([2620:15c:2c5:11:2520:b863:90ba:85bc])
 (user=kerensun job=sendgmr) by 2002:a25:b411:0:b0:e2b:da82:f695 with SMTP id
 3f1490d57ef6-e30e5b0f56amr10735276.6.1730759288333; Mon, 04 Nov 2024 14:28:08
 -0800 (PST)
Date: Mon,  4 Nov 2024 14:27:35 -0800
In-Reply-To: <20241104222737.298130-1-kerensun@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241104222737.298130-1-kerensun@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241104222737.298130-3-kerensun@google.com>
Subject: [PATCH 2/4] mm: Fix minor formatting issues for mm control
From: Keren Sun <kerensun@google.com>
To: akpm@linux-foundation.org
Cc: roman.gushchin@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Keren Sun <kerensun@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a line after declaration as it's missing after DEFINE_WAIT(),
replace the spaces with tabs for indent, and remove the non-useful else
after a break in a if statement.

Signed-off-by: Keren Sun <kerensun@google.com>
---
 mm/memcontrol-v1.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 3951538bd73f..5f9d3d6d443c 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -460,6 +460,7 @@ bool memcg1_wait_acct_move(struct mem_cgroup *memcg)
 	if (mc.moving_task && current != mc.moving_task) {
 		if (mem_cgroup_under_move(memcg)) {
 			DEFINE_WAIT(wait);
+
 			prepare_to_wait(&mc.waitq, &wait, TASK_INTERRUPTIBLE);
 			/* moving charge context might have finished. */
 			if (mc.moving_task)
@@ -490,7 +491,7 @@ void folio_memcg_lock(struct folio *folio)
 	 * The RCU lock is held throughout the transaction.  The fast
 	 * path can get away without acquiring the memcg->move_lock
 	 * because page moving starts with an RCU grace period.
-         */
+	 */
 	rcu_read_lock();
 
 	if (mem_cgroup_disabled())
@@ -2096,8 +2097,8 @@ static bool mem_cgroup_oom_trylock(struct mem_cgroup *memcg)
 			failed = iter;
 			mem_cgroup_iter_break(memcg, iter);
 			break;
-		} else
-			iter->oom_lock = true;
+		}
+		iter->oom_lock = true;
 	}
 
 	if (failed) {
-- 
2.47.0.163.g1226f6d8fa-goog


