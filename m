Return-Path: <linux-kernel+bounces-371515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 840FC9A3C28
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CBE21C24B0D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE232204030;
	Fri, 18 Oct 2024 10:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPnTgrtq"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11132038A9;
	Fri, 18 Oct 2024 10:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248647; cv=none; b=eFiLkcBSQu2QPcTgxgSdCTArfmRAL3UoByI/qADjJMURFixzSEriOXhlyxXFjrSR4nPGiGWa7w1zFvLBdMK2wP0yVn/EeInW9LkjIHNf2+WlHJwC30vcZHU/im/xUaGgW7T1cfsFPW9Gdf0QGXlYL7UUCUEwiq4LAoCHeGxy4XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248647; c=relaxed/simple;
	bh=VN9tB+cC2ZAgtEQ/P6Td362Qw7zNVjRkimyM4JgJsQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6F9+bmYXp6ne0Ir7cmb1p8xIleOyO0QGOvSmXbGGbWkosLNEgs7v6AahU3TTRYXaOtWHX3YO9S5314CdQ/deJLc4dSiP6fRtplnCJDDXv/I7pPZkMKkhbDOPzg9Cd4dNyjyFUDKCtrCtQDMpfZ1/KM2QypJwx439CNNzA1tBHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPnTgrtq; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4a46f36158cso675534137.2;
        Fri, 18 Oct 2024 03:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729248644; x=1729853444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRHby0h+uR8HMvD4At3d64Ma8NriZDDBQPHvfHlsfXk=;
        b=MPnTgrtqls01zRUciCy5GzWlx0zHOhUHRI0C8Bu1nAKTsB+JxYjMhmqNuVNiCZMpQm
         x0sZz+pHhSIoVTCN5p2EOMhnUoQDy4yB6wT7F/F3oWRYl5IeXSvB5UXhv0ZkH4GNp+vP
         Um/xhauxP5rhrdzHoGF/+6kCs287YVFV7Lw/4H0ltMTEWsUHNsLLgOTjLn3hpTgs7OkH
         D8w1U5okOJe5sv6RfpCq+ptKfTPIfLEaUlgc7+vYvkyenOg76zuRTCCMnNk5GNBqP44f
         Msp3JeuRa7Xo4YvH61bAWU/qMZrE60SBlOxzkD/v/fy2sZlrKJQalQYhBOfersesj9mr
         miVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729248644; x=1729853444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRHby0h+uR8HMvD4At3d64Ma8NriZDDBQPHvfHlsfXk=;
        b=OIdpHWsvQuI68DcMYGVhDb8JunF0A+f3C6eZnOVb7p4nF78ItDoEDbX+nz6VmKfgLQ
         HkcgFKSt4tkR0DD7kSOD1GAVr1iGv12Pq7bxY32g0B/aa9KdhjnkIt8YCrdlqwSi+f5V
         n/Hpa7gCCI2e8RUs6ne8JbAgeV0l0pU6U9zfqMwi2+zcKMaVIA7Ac6D2dnbnhCyvdfMT
         fuBcl+X9mO24kUMezdHsWCTDq6osVmAPW+w+4peA3XF0CDFCXIv0+nGBAI6XdU40GYab
         RVxhc7IkyhxhvTgiyFlzJFVvZzn/crFE3Jgx4WMwNCmp8xCoxJV7vT+i0vTQUMeuXlRr
         gYGw==
X-Forwarded-Encrypted: i=1; AJvYcCWH2g05EviyFGi4QH+wjoKMjyUCZJO4L6ZFjIFOfV3Z49FsG3TX0X/ZG+Zpddxm6IpxKcOJUWYg3KpRKDwz@vger.kernel.org, AJvYcCXIp84iXTPF/gpCTKLrhilIYv6PI6tcAihuUgCkqV5h3UjaPv/dNAX+18ZVWGcbwYLtzfWVDTSxPMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxilQXJcICTzK3jyor/PuThkEBJktI4D+YkjeRszJOJwSAmukMF
	ZKR22EfoouNJvky8LyFRz1qSA7RtU5uxNb5VxiYV7oJZUn3cmyg/
X-Google-Smtp-Source: AGHT+IHykbO3DzKF2g7UHtYVZ/jRuN9Qj89t9+anwaQLDnm38LEAsEEjNjDjKrfF3i0TApP/IeNGHg==
X-Received: by 2002:a05:6102:d89:b0:4a4:7928:637c with SMTP id ada2fe7eead31-4a5d6aae56emr1935661137.8.1729248644408;
        Fri, 18 Oct 2024 03:50:44 -0700 (PDT)
Received: from localhost (fwdproxy-ash-013.fbsv.net. [2a03:2880:20ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b156fa81b7sm58410885a.68.2024.10.18.03.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:50:43 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: hannes@cmpxchg.org,
	david@redhat.com,
	willy@infradead.org,
	kanchana.p.sridhar@intel.com,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Usama Arif <usamaarif642@gmail.com>
Subject: [RFC 4/4] mm/zswap: count successful large folio zswap loads
Date: Fri, 18 Oct 2024 11:48:42 +0100
Message-ID: <20241018105026.2521366-5-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241018105026.2521366-1-usamaarif642@gmail.com>
References: <20241018105026.2521366-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added a new MTHP_STAT_ZSWPIN entry to the sysfs transparent_hugepage
stats so that successful large folio zswap stores can be accounted under
the per-order sysfs zswpin stats:

/sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/zswpin

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 3 +++
 include/linux/huge_mm.h                    | 1 +
 mm/huge_memory.c                           | 3 +++
 mm/page_io.c                               | 1 +
 4 files changed, 8 insertions(+)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 2a171ed5206e..68a9790908b2 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -534,6 +534,9 @@ zswpout
 	is incremented every time a huge page is swapped out to zswap in one
 	piece without splitting.
 
+zswpin
+	is incremented every time a huge page is swapped in from zswap.
+
 swpout
 	is incremented every time a huge page is swapped out to a non-zswap
 	swap device in one piece without splitting.
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 3eca60f3d512..28a275d3107a 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -120,6 +120,7 @@ enum mthp_stat_item {
 	MTHP_STAT_ANON_FAULT_FALLBACK,
 	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
 	MTHP_STAT_ZSWPOUT,
+	MTHP_STAT_ZSWPIN,
 	MTHP_STAT_SWPOUT,
 	MTHP_STAT_SWPOUT_FALLBACK,
 	MTHP_STAT_SHMEM_ALLOC,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a7b05f4c2a5e..587f7dd81500 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -612,6 +612,7 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
 DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
+DEFINE_MTHP_STAT_ATTR(zswpin, MTHP_STAT_ZSWPIN);
 DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
 DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
 #ifdef CONFIG_SHMEM
@@ -631,6 +632,7 @@ static struct attribute *anon_stats_attrs[] = {
 	&anon_fault_fallback_charge_attr.attr,
 #ifndef CONFIG_SHMEM
 	&zswpout_attr.attr,
+	&zswpin_attr.attr,
 	&swpout_attr.attr,
 	&swpout_fallback_attr.attr,
 #endif
@@ -662,6 +664,7 @@ static struct attribute_group file_stats_attr_grp = {
 static struct attribute *any_stats_attrs[] = {
 #ifdef CONFIG_SHMEM
 	&zswpout_attr.attr,
+	&zswpin_attr.attr,
 	&swpout_attr.attr,
 	&swpout_fallback_attr.attr,
 #endif
diff --git a/mm/page_io.c b/mm/page_io.c
index 2a15b197968a..477f9d4fc009 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -620,6 +620,7 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 		folio_unlock(folio);
 		goto finish;
 	} else if (zswap_load(folio)) {
+		count_mthp_stat(folio_order(folio), MTHP_STAT_ZSWPIN);
 		folio_unlock(folio);
 		goto finish;
 	}
-- 
2.43.5


