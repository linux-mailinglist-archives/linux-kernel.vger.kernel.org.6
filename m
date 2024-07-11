Return-Path: <linux-kernel+bounces-248515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4898892DE46
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 04:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C7A1F22462
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 02:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B2712E61;
	Thu, 11 Jul 2024 02:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EteHRKx/"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02FDDF78
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 02:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720664010; cv=none; b=olDJCTAodIGYQ0YP6o5qmklWHIcwVD8A2qHTWBFGi7WeaGFsB+dYhijo3RDzdUZOuiW/7r//TKTgoUDozFjWC2w1nAqU/LWgTtd6t/cUuvzrQWMjZ8O7Z7VH/G5/oXAGPwstxNW+NwBA6gbMGJTd+hNghuCGXvB8QYx+Y2l+Qsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720664010; c=relaxed/simple;
	bh=swqsDkPvw6N6omPNGa5/j5p0uymSXIdVOTnWFKLeiCw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UVQYM1+H36+IFJ7otU+ody3XwU3EQncQvccLCG49FpLoZ5q2//c+KJ4LrXigrpPHhTOKRBIID69XFpRd7TWGDuyE/fy1Xn/boK3AGwvRRDy2UlwdeR7t3U3Cu9EOKSCWM6YxWO9iFOYl1jgQjbMWFJ132zXpLNWP9xm9jDuG7QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EteHRKx/; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02a4de4f4eso698997276.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720664007; x=1721268807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mz1u87ev8DYclZ/2H0TBqU+M5VpYJmHKMXbGaF77G5w=;
        b=EteHRKx/HrpKN7yEzpos7730bj3Hd6fxCLzbD+kcUDDRtTN/mbZtm2GeVNU5nXQ8mY
         blt2f0noTjfPBPEqPMMrywBNTn/i03EzdCVaEwy70kp3JK5SX1lvMYckttYflpqIs4+Z
         7W/eJ4KoDxoCBFbiJ32Y9SORoCrIgmqsH9F+VYrmTTDTELhPnAnHy+t74eusWgcvC/zs
         3IYcUpK7Ekhfh3vzjMUt4GY7OwvlVoxkwR6gaiXq5a9FvLBVTcWHnqlo6GW7SJ1nMcyd
         qwJfzemaTru1/7zJW7dEG/gM6DTxLBxusUxA6ToQaI0kN2s6C0TaH3hkfvBrFUt8QxLX
         Pdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720664007; x=1721268807;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mz1u87ev8DYclZ/2H0TBqU+M5VpYJmHKMXbGaF77G5w=;
        b=JX071JufJbLQfWU0uwWlw4ltJm/cmpHpuVLmxEyDbhYSnwekjse+xo4g45d/XyiM24
         HkpJwg2FZUz2+QSFxbkOKvLI+LdwhNZGf1ff8NXt/6bCaLWHIVCjXwFxg3TPaaQ9HaGW
         tvpjM+mOmnbuWAlujg2h1SRhXGj47kdMaxiYGQUCe0lw25TFxR3nA6xy9v/zVti2xJag
         3dWEGyRNudQan1Ra6xkjWd5tDa87EzRhSmbJr92jPfsw9tBofewYrKzlfazmyaJPZYqH
         erJMcRyog4vtTjLzqqag722owcp4J3A239fIt40YaS+IywcRs6sqPgYURKA9Uowdvhs4
         nK6w==
X-Forwarded-Encrypted: i=1; AJvYcCWBbBTMB55K/KVM9aXuz9R4+WKX3ReuYqOkFVIrFrXTyzJkmdG/4NzVyWiFAK9z1CzM9p1mQFbgwXEjCIgFH8qrQcgsHndys9wyTlce
X-Gm-Message-State: AOJu0Ywm/4w+oWS1ZrmubDK7jPnl5yDwJdfr4AHHo9Yd2GctnWERHtfd
	DGTbZqjlqvMj3h1w9H/5NfESgVg0PoVOif/SP8zv1RsGnZu664fD+7JTdvPXlHf3FhHnnhsswvA
	7Ug==
X-Google-Smtp-Source: AGHT+IEFx7WEmcVLtwhV7MLkiuoJz3OGus58zTubJgwlkdvY2QBLN+8BvOJfH7aoBGbgNkKVhQae3bL0CsI=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:9b06:2f28:6675:a98b])
 (user=yuzhao job=sendgmr) by 2002:a05:6902:729:b0:e01:f998:fea2 with SMTP id
 3f1490d57ef6-e041b14337emr15713276.11.1720664007468; Wed, 10 Jul 2024
 19:13:27 -0700 (PDT)
Date: Wed, 10 Jul 2024 20:13:14 -0600
In-Reply-To: <20240711021317.596178-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711021317.596178-1-yuzhao@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240711021317.596178-3-yuzhao@google.com>
Subject: [PATCH mm-unstable v1 2/5] mm/swap: rename cpu_fbatches->activate
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename cpu_fbatches->activate to cpu_fbatches->lru_activate, and its
handler folio_activate_fn() to lru_activate() so that all the
boilerplate can be removed at the end of this series.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/swap.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 952e4aac6eb1..e4745b88a964 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -67,7 +67,7 @@ struct cpu_fbatches {
 	struct folio_batch lru_deactivate;
 	struct folio_batch lru_lazyfree;
 #ifdef CONFIG_SMP
-	struct folio_batch activate;
+	struct folio_batch lru_activate;
 #endif
 };
 static DEFINE_PER_CPU(struct cpu_fbatches, cpu_fbatches) = {
@@ -331,7 +331,7 @@ void lru_note_cost_refault(struct folio *folio)
 		      folio_nr_pages(folio), 0);
 }
 
-static void folio_activate_fn(struct lruvec *lruvec, struct folio *folio)
+static void lru_activate(struct lruvec *lruvec, struct folio *folio)
 {
 	long nr_pages = folio_nr_pages(folio);
 
@@ -351,10 +351,10 @@ static void folio_activate_fn(struct lruvec *lruvec, struct folio *folio)
 #ifdef CONFIG_SMP
 static void folio_activate_drain(int cpu)
 {
-	struct folio_batch *fbatch = &per_cpu(cpu_fbatches.activate, cpu);
+	struct folio_batch *fbatch = &per_cpu(cpu_fbatches.lru_activate, cpu);
 
 	if (folio_batch_count(fbatch))
-		folio_batch_move_lru(fbatch, folio_activate_fn);
+		folio_batch_move_lru(fbatch, lru_activate);
 }
 
 void folio_activate(struct folio *folio)
@@ -371,8 +371,8 @@ void folio_activate(struct folio *folio)
 	}
 
 	local_lock(&cpu_fbatches.lock);
-	fbatch = this_cpu_ptr(&cpu_fbatches.activate);
-	folio_batch_add_and_move(fbatch, folio, folio_activate_fn);
+	fbatch = this_cpu_ptr(&cpu_fbatches.lru_activate);
+	folio_batch_add_and_move(fbatch, folio, lru_activate);
 	local_unlock(&cpu_fbatches.lock);
 }
 
@@ -389,7 +389,7 @@ void folio_activate(struct folio *folio)
 		return;
 
 	lruvec = folio_lruvec_lock_irq(folio);
-	folio_activate_fn(lruvec, folio);
+	lru_activate(lruvec, folio);
 	unlock_page_lruvec_irq(lruvec);
 	folio_set_lru(folio);
 }
@@ -490,7 +490,7 @@ void folio_mark_accessed(struct folio *folio)
 	} else if (!folio_test_active(folio)) {
 		/*
 		 * If the folio is on the LRU, queue it for activation via
-		 * cpu_fbatches.activate. Otherwise, assume the folio is in a
+		 * cpu_fbatches.lru_activate. Otherwise, assume the folio is in a
 		 * folio_batch, mark it active and it'll be moved to the active
 		 * LRU on the next drain.
 		 */
@@ -829,7 +829,7 @@ static bool cpu_needs_drain(unsigned int cpu)
 		folio_batch_count(&fbatches->lru_deactivate_file) ||
 		folio_batch_count(&fbatches->lru_deactivate) ||
 		folio_batch_count(&fbatches->lru_lazyfree) ||
-		folio_batch_count(&fbatches->activate) ||
+		folio_batch_count(&fbatches->lru_activate) ||
 		need_mlock_drain(cpu) ||
 		has_bh_in_lru(cpu, NULL);
 }
-- 
2.45.2.803.g4e1b14247a-goog


