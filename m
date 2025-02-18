Return-Path: <linux-kernel+bounces-520045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F71A3A517
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094C01891298
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C6927290A;
	Tue, 18 Feb 2025 18:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hhtf70F/"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A6727128E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902633; cv=none; b=Q4RHBwjFR0jE0oTCJpyLB5Rl6YBnOQ4ofLZsSg4fEaBzq5e7tIzgzPos22UC+Z9+fCMwF21ImQhy/P0OM8gjToXahzsv8/ZmwqwdivBrGm3LycUn9Z3j55dDCx1mhlzW0By7/QtZ6vq20pXCZH59dxulMhnTFRx3wegf8nbSsKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902633; c=relaxed/simple;
	bh=O7o+HWviERTdl/2M2SHuibwM8esj60P3sjEF4srvJ3Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qAyyjX3ZsVctJfC5H+UmVpd0vwzSvvNQ7IfJQuIvivEeyroku+dblkIezyax6PEM7fBBTd6wUOW+5phlqtwq0PfX6QWUWC+e99mOrxHMfMngmjR45YA04R7zF3X7WDgjMERBF7xw6Yyd9vB8yR/J2LeNI16ELwm/R4D4KHzqeMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hhtf70F/; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc1a4c150bso11310483a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739902631; x=1740507431; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tllVc7X/acXyb+IoDErelML7G/kmBDOgXbXRXqPobDE=;
        b=hhtf70F/Tpngy7+D60Xer0WBEDd/D1wA9YTNjUm0jEpDY9mxHIQFtbl0rzVNtgdKI3
         nB3sWoBw3RS5y8BmRal5rdvwEN/TXCF6o7MnZEGy6w8medvluPdkFqMAg0mrivw4vfWb
         9oechwNyxMroMwqiQW+JUvgbmCqlD4L0EcwxiLKJw2XAPivZkaVpOqYfHCCS+DEPDN4J
         o8+4frOLmUsG6oABSFKG+fc+zwsG9zydGqGAP04yz3bGVe9qzP10+b5Af5NkoM8mbFHf
         Fb0yYMHN9RbDHIHT+XzOJ+mt8vBp4XwogEDcrZVwJ8usU4fLbgVwgkNLFCtH0phK6hwN
         S5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739902631; x=1740507431;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tllVc7X/acXyb+IoDErelML7G/kmBDOgXbXRXqPobDE=;
        b=EavudakR3VEZMVX/NzQ6mpVRi1VRNMMGr6fCWiSr0KAQoSJeK8OQCFXCzn0h/iLZm3
         eInKDCu0qr/PNw0K6IwsQ/iI0bQG0okaUHF+vVGG+fkz8Yc4EnDa+oQekJVXNq4EQtRR
         /8u/+3iNwMTtMqeO1y05BxSjc40QImsAb3oRu0a3iIJVOTPyXMBFZiUWGak2jTSsRIFt
         RYx6KmNU+Q10J6NFFwqiOV+mQkRB2upR++qeqbk3pnHb6Fxibq1j7HE6GsEv3M8weZqV
         Ia43HZ7+78d7nPb+QT/0ihTd5VbyBlZzzgc3ccAfVtEuAxs7TS4YvBDXjXoUWghgkgB8
         aVYg==
X-Forwarded-Encrypted: i=1; AJvYcCVt0MdNE7AI2sQGzs6Od+5JPUwFCWIpz+4YV8W8+NViMGPRHbNQNpVFlLiLAGXmmctxux9PhF4H13mTl1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMhelW95ad8iFbElbw6O+Qn9bX1H7dUDfqVW8zeVg0K4k90t7B
	jrMEdtwB7xSNzMmzgAiP6RaE2BKq661u2APTRklMoqNaNLBMtC/+E70wnAl5aqiT9R2AGg==
X-Google-Smtp-Source: AGHT+IEImgj/kN4IDC2d0OdCVCT/P6/c0Qlb8Kol3LFJI2Z9hlrSwi6kxHopJVJc8L3J73IZc+vlmUAx
X-Received: from pjbli10.prod.google.com ([2002:a17:90b:48ca:b0:2ea:448a:8cd1])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d0c6:b0:2fc:a3b7:108a
 with SMTP id 98e67ed59e1d1-2fca3b711a8mr4781829a91.2.1739902631607; Tue, 18
 Feb 2025 10:17:11 -0800 (PST)
Date: Tue, 18 Feb 2025 18:16:31 +0000
In-Reply-To: <20250218181656.207178-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250218181656.207178-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250218181656.207178-4-fvdl@google.com>
Subject: [PATCH v4 03/27] mm/cma: introduce cma_intersects function
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, Frank van der Linden <fvdl@google.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Now that CMA areas can have multiple physical ranges,
code can't assume a CMA struct represents a base_pfn
plus a size, as returned from cma_get_base.

Most cases are ok though, since they all explicitly
refer to CMA areas that were created using existing
interfaces (cma_declare_contiguous_nid or
cma_init_reserved_mem), which guarantees they have just
one physical range.

An exception is the s390 code, which walks all CMA
ranges to see if they intersect with a range of memory
that is about to be hotremoved. So, in the future,
it might run in to multi-range areas. To keep this check
working, define a cma_intersects function. This just checks
if a physaddr range intersects any of the ranges.
Use it in the s390 check.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 arch/s390/mm/init.c | 13 +++++--------
 include/linux/cma.h |  1 +
 mm/cma.c            | 21 +++++++++++++++++++++
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index f2298f7a3f21..d88cb1c13f7d 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -239,16 +239,13 @@ struct s390_cma_mem_data {
 static int s390_cma_check_range(struct cma *cma, void *data)
 {
 	struct s390_cma_mem_data *mem_data;
-	unsigned long start, end;
 
 	mem_data = data;
-	start = cma_get_base(cma);
-	end = start + cma_get_size(cma);
-	if (end < mem_data->start)
-		return 0;
-	if (start >= mem_data->end)
-		return 0;
-	return -EBUSY;
+
+	if (cma_intersects(cma, mem_data->start, mem_data->end))
+		return -EBUSY;
+
+	return 0;
 }
 
 static int s390_cma_mem_notifier(struct notifier_block *nb,
diff --git a/include/linux/cma.h b/include/linux/cma.h
index 863427c27dc2..03d85c100dcc 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -53,6 +53,7 @@ extern bool cma_pages_valid(struct cma *cma, const struct page *pages, unsigned
 extern bool cma_release(struct cma *cma, const struct page *pages, unsigned long count);
 
 extern int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data);
+extern bool cma_intersects(struct cma *cma, unsigned long start, unsigned long end);
 
 extern void cma_reserve_pages_on_error(struct cma *cma);
 
diff --git a/mm/cma.c b/mm/cma.c
index 6ac9173d3a7d..c7116a5819c5 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -978,3 +978,24 @@ int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
 
 	return 0;
 }
+
+bool cma_intersects(struct cma *cma, unsigned long start, unsigned long end)
+{
+	int r;
+	struct cma_memrange *cmr;
+	unsigned long rstart, rend;
+
+	for (r = 0; r < cma->nranges; r++) {
+		cmr = &cma->ranges[r];
+
+		rstart = PFN_PHYS(cmr->base_pfn);
+		rend = PFN_PHYS(cmr->base_pfn + cmr->count);
+		if (end < rstart)
+			continue;
+		if (start >= rend)
+			continue;
+		return true;
+	}
+
+	return false;
+}
-- 
2.48.1.601.g30ceb7b040-goog


