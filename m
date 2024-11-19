Return-Path: <linux-kernel+bounces-414974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E33049D2FDA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 22:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D507281CCD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F408D1AAE33;
	Tue, 19 Nov 2024 21:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GY8Q5gBn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2271547FF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 21:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732050178; cv=none; b=TgJk4FWX5WPDNGPxN7CPApV0IO+sWL5Rs9vYx9nBTw/JRUQMTH25/B5jhq7mXtGTGdWMDhLpzVdxr4vcFvhECQHdjEanSMDVeLocl+uRk+OlXZasieZ4hqkbHKruseK0IE8AEl/ZmemsxP4sJlceTk8FMEGunzGCHOaYBqkkewo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732050178; c=relaxed/simple;
	bh=sZjtNk7l7C9pzENMMAEf8CF1Tf7grENzHNXiyy+KnmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ET+5vqhabbgOSQPov61OC+P3Iz70FnxW4kssY7pzl7mclmGHF7b1sNPlADYFNMZVeeSJg5W9sur8uuPpBdAk+ncPv7ayghlWfxi0+fyaq9sdjre7B0qDfEvHaSRRuZ8zaszbNL8dHbm+v8Y1A7dEWo56It6nCVBBNIZ2mmsYq48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GY8Q5gBn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732050174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t3TBOVGPHnMk/PpScx+zP3qwXBcwdGmVH4QE3u2wmIw=;
	b=GY8Q5gBnNYts1H4noJ4MLuPViivfcOM+LLLnIcgzlwN+senJsNiXf1zC+Sw7aWIct6zsLg
	kUaREryrGv6hqpIw8A8nPs6vy8yEj7I7trRRFSJWCAx7NPqaB1sIqzauK4fi6YldgResgf
	0j0Hc+RjaaUDENaoKzBcZjfWe+K8Gy8=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140--kt2B4q7MAyu41FxbU0Uyw-1; Tue, 19 Nov 2024 16:02:53 -0500
X-MC-Unique: -kt2B4q7MAyu41FxbU0Uyw-1
X-Mimecast-MFC-AGG-ID: -kt2B4q7MAyu41FxbU0Uyw
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7191aa79cso52387225ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 13:02:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732050173; x=1732654973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3TBOVGPHnMk/PpScx+zP3qwXBcwdGmVH4QE3u2wmIw=;
        b=aFOknD++zYGRXXXMzkichJrp7aO0VWs06jOL75McYV/zpt2E9PansMLD6grPhFv4sX
         jso9i5nvmxZeu7WCw5Z3ThZuBmqCZsYteGRVvnatV2OAi6nve1EO14ltaoh6pDvx/qxa
         U4Z9mX/TCkiVd0/QUNgP6mZ3fZGd83+CWY+Qdh3Lka4+QpgoVgnVBZ4LrE3KQmcGR+ed
         VcF3QawaaV9zq1pseWYIXpm/A3MFWjgXViGlaZu/rTV8Ybecl1b/jYSguW2TnzMfLbwc
         6dfzngMVLO2DHLAfKcJLuxlJRHZInXXXlk80FRQ23nL5hdn3wk2M3/NDRvXxUvtuAPHu
         aQcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH+EduGJt4xekiMoE2NktmUuHqur+fcHeMN2jJnhspSdflTnpfM68NU5hX+T2ctELz5lTRyhz2m3HM4+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlij6nwCux6z4aBA3sPMSHCxb0xoETGVD0oXQIZ7wYJclq5Hea
	n7hEq3zFYy9zUUK0Dz4dV3c9XPIv2SGgj5rwBEBL3ht1PfSXuTaL764V9QMpxme1Uzn2DZS5TpS
	tf15JBRfF/JV8ff3CFDIyCkFmxXDxyHGQLTxzuy4sthr4EvlXbrG58iX4m0uNBA==
X-Received: by 2002:a05:6e02:2163:b0:3a7:7dc9:a4b0 with SMTP id e9e14a558f8ab-3a786457e63mr2505465ab.9.1732050172824;
        Tue, 19 Nov 2024 13:02:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNZhFi4Xzwng9eavnh81Qgmhou8NXC0G0kcJ/atGWwSCqLsA1Fb8DTEeCVsTBJAqR40j3BvA==
X-Received: by 2002:a05:6e02:2163:b0:3a7:7dc9:a4b0 with SMTP id e9e14a558f8ab-3a786457e63mr2505235ab.9.1732050172398;
        Tue, 19 Nov 2024 13:02:52 -0800 (PST)
Received: from jkangas-thinkpadp1gen3.rmtuswa.csb ([2601:1c2:4301:5e20:98fe:4ecb:4f14:576b])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e0756b0e35sm2987964173.108.2024.11.19.13.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 13:02:51 -0800 (PST)
From: Jared Kangas <jkangas@redhat.com>
To: ryabinin.a.a@gmail.com
Cc: glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	akpm@linux-foundation.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jared Kangas <jkangas@redhat.com>
Subject: [PATCH] kasan: make report_lock a raw spinlock
Date: Tue, 19 Nov 2024 13:02:34 -0800
Message-ID: <20241119210234.1602529-1-jkangas@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If PREEMPT_RT is enabled, report_lock is a sleeping spinlock and must
not be locked when IRQs are disabled. However, KASAN reports may be
triggered in such contexts. For example:

        char *s = kzalloc(1, GFP_KERNEL);
        kfree(s);
        local_irq_disable();
        char c = *s;  /* KASAN report here leads to spin_lock() */
        local_irq_enable();

Make report_spinlock a raw spinlock to prevent rescheduling when
PREEMPT_RT is enabled.

Signed-off-by: Jared Kangas <jkangas@redhat.com>
---
 mm/kasan/report.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index b48c768acc84..c7c0083203cb 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -200,7 +200,7 @@ static inline void fail_non_kasan_kunit_test(void) { }
 
 #endif /* CONFIG_KUNIT */
 
-static DEFINE_SPINLOCK(report_lock);
+static DEFINE_RAW_SPINLOCK(report_lock);
 
 static void start_report(unsigned long *flags, bool sync)
 {
@@ -211,7 +211,7 @@ static void start_report(unsigned long *flags, bool sync)
 	lockdep_off();
 	/* Make sure we don't end up in loop. */
 	report_suppress_start();
-	spin_lock_irqsave(&report_lock, *flags);
+	raw_spin_lock_irqsave(&report_lock, *flags);
 	pr_err("==================================================================\n");
 }
 
@@ -221,7 +221,7 @@ static void end_report(unsigned long *flags, const void *addr, bool is_write)
 		trace_error_report_end(ERROR_DETECTOR_KASAN,
 				       (unsigned long)addr);
 	pr_err("==================================================================\n");
-	spin_unlock_irqrestore(&report_lock, *flags);
+	raw_spin_unlock_irqrestore(&report_lock, *flags);
 	if (!test_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags))
 		check_panic_on_warn("KASAN");
 	switch (kasan_arg_fault) {
-- 
2.47.0


