Return-Path: <linux-kernel+bounces-267541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72506941299
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CE501F237B7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC3E19F49B;
	Tue, 30 Jul 2024 12:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4O04Ubr"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEAF1991A7;
	Tue, 30 Jul 2024 12:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722344053; cv=none; b=p0IDr4kjAIOcryxH7ORzrNHr8nPZJ8A/wMriD1DlKH4gslMLuJlkX0PYlnn8SkXNuNhXDdr6PjJOeIc+xlTh6uSvRCY2zZR7SqWuJ5p/45QoYBCEjdLyv/qslJyMpm1DJWwlFOke9YRhtrjkkyMCNDATpeXMSJXEdnvKOM8VfwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722344053; c=relaxed/simple;
	bh=hMifvmNy6jSvPiHEg2g5JNijSpLu2sbjQPsrq9O1zvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MxO1cPcBqAQz/oVmwBlSqe7cM59rt/U2Uo9WRMQ1sw9HYv1hRpdBQ3DcIvrM6VfIW6WYPhjVMdGFyGT/DbDVtOgkPASrTgJTiGYvJ2MnS8SplafNsCyRFBAGyNbDlcD9zuZGzRYUAE2NhOt6Ko9TIOzMPH2DGBs9zfx8OHuZ2uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4O04Ubr; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a1e0ff6871so266746085a.2;
        Tue, 30 Jul 2024 05:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722344050; x=1722948850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KP/Cz3QVNU5uyUnKyaSLbXt0q/kOvLrAG+hU9UnZ/BE=;
        b=H4O04UbrYXXl9To4EKPfYL55GxQrD2MI2z1hACXcwe+bv0nl0i7i8AioP+8dSCy8dk
         5/LWp8jqCMuQLHTdxxAFZ2kWwRZHycQ5jhyjZYmo3XdJ3COtQjDlR64gibKiVdzWE8Z+
         e7wRVXFRTJToeCeTEbD53nrn0KZCc3zIU5nZXzKLakEehY1NCaIxlmd26Gb0Cmm6P+WM
         rGgV3GQiaPrYBpIAokLZpKswaQJ6NlNc3gKWLngwBozdBURsVhHoqEK2rXxtjpIMHSwR
         Pyrjotu1++uyymZU/wJLbJEdYsc9FA/HotzHKZF/FTH2+daHr3523AxVF05gBO4b9Ie+
         0yDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722344050; x=1722948850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KP/Cz3QVNU5uyUnKyaSLbXt0q/kOvLrAG+hU9UnZ/BE=;
        b=bPxDoyFZ06Occh9X4rMqohSxWoYlPy2xkV2hO09dTGEksWlvhzoUBrfb8lGdejc9eX
         8fhejPFGozL2zB/jT7QBCM+4B13m3lDkp55dD8uC+k4qnQfVhrBv0lWyvJMQIVGYBaoL
         zhszPaGRfQ2eY4ZR1ItWV8MDChUZHVD6uBd8b3UThSqanZwmFoET6TUed5YIlhZ2qJia
         kMx/Mz6shbJZriq6DiueM4P0LVippDtGRu5mwJ9vxl+7QMLbx/8f/QN+lQwyAO1/gHwV
         VQlRKNsa2q1J2/RFB3DNG6WScCiK3XvSp8Mm33+Vu71BPGUM59J6x7SDx0yh+A+PdmU3
         rZNw==
X-Forwarded-Encrypted: i=1; AJvYcCUEZr0yDNq67fKmKEIwMOg0+3ukVvHAzZNl6SGt3WIYZ0+OQyN8Jr1S6E0wf/K+t0Z9CpY40idn5AyoKPDjD3akGt2Z8pf/A0X8ws6vPJLXia7U+QCtxE7PRSjsE4cU5N84AxCv4n+8
X-Gm-Message-State: AOJu0Yy2PyQgF3zEnIoQeXMZvW2W9enJBzoLTlpMzBfs3LoSvW2kTcfZ
	ycJ+IxwYVKaaWrB6Xb0M8lJJBVvXQ3kWdOXPjyhp1LPZa4iEDrjE
X-Google-Smtp-Source: AGHT+IGKfomzFh7hnhpcESd3MD/dzvcJlg6cDEKXingUGcZg56zluFUVdo6AMVlaIlW4lTWHXPgxoA==
X-Received: by 2002:a05:620a:24c3:b0:79e:fcb8:815c with SMTP id af79cd13be357-7a1e52cdbf2mr1496430585a.54.1722344050589;
        Tue, 30 Jul 2024 05:54:10 -0700 (PDT)
Received: from localhost (fwdproxy-ash-009.fbsv.net. [2a03:2880:20ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73ea990sm626878885a.55.2024.07.30.05.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 05:54:09 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	yuzhao@google.com,
	david@redhat.com,
	baohua@kernel.org,
	ryan.roberts@arm.com,
	rppt@kernel.org,
	willy@infradead.org,
	cerasuolodomenico@gmail.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH 1/6] Revert "memcg: remove mem_cgroup_uncharge_list()"
Date: Tue, 30 Jul 2024 13:45:58 +0100
Message-ID: <20240730125346.1580150-2-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730125346.1580150-1-usamaarif642@gmail.com>
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mem_cgroup_uncharge_list will be needed in a later patch for an
optimization to free zapped tail pages when splitting isolated thp.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 include/linux/memcontrol.h | 12 ++++++++++++
 mm/memcontrol.c            | 19 +++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 07eadf7ecbba..cbaf0ea1b217 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -713,6 +713,14 @@ static inline void mem_cgroup_uncharge(struct folio *folio)
 	__mem_cgroup_uncharge(folio);
 }
 
+void __mem_cgroup_uncharge_list(struct list_head *page_list);
+static inline void mem_cgroup_uncharge_list(struct list_head *page_list)
+{
+	if (mem_cgroup_disabled())
+		return;
+	__mem_cgroup_uncharge_list(page_list);
+}
+
 void __mem_cgroup_uncharge_folios(struct folio_batch *folios);
 static inline void mem_cgroup_uncharge_folios(struct folio_batch *folios)
 {
@@ -1203,6 +1211,10 @@ static inline void mem_cgroup_uncharge(struct folio *folio)
 {
 }
 
+static inline void mem_cgroup_uncharge_list(struct list_head *page_list)
+{
+}
+
 static inline void mem_cgroup_uncharge_folios(struct folio_batch *folios)
 {
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9b3ef3a70833..f568b9594c2b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4717,6 +4717,25 @@ void __mem_cgroup_uncharge(struct folio *folio)
 	uncharge_batch(&ug);
 }
 
+/**
+ * __mem_cgroup_uncharge_list - uncharge a list of page
+ * @page_list: list of pages to uncharge
+ *
+ * Uncharge a list of pages previously charged with
+ * __mem_cgroup_charge().
+ */
+void __mem_cgroup_uncharge_list(struct list_head *page_list)
+{
+	struct uncharge_gather ug;
+	struct folio *folio;
+
+	uncharge_gather_clear(&ug);
+	list_for_each_entry(folio, page_list, lru)
+		uncharge_folio(folio, &ug);
+	if (ug.memcg)
+		uncharge_batch(&ug);
+}
+
 void __mem_cgroup_uncharge_folios(struct folio_batch *folios)
 {
 	struct uncharge_gather ug;
-- 
2.43.0


