Return-Path: <linux-kernel+bounces-417213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE829D50B0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D1A12839E3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E14E19B3ED;
	Thu, 21 Nov 2024 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKkkdyIK"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE8E3B796;
	Thu, 21 Nov 2024 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732206489; cv=none; b=DCmr19H4tCJ2mcz5XpJSd5OCnMMGIINHHSr2jXr8t0ZVhHSB9kKADUpMfFXotcotejEmyeZXOC44tjv0DO5Lj+blnsCNJ9rzR1nz5P4D+1ChqhLIiVcLA1a2rkHDiLrJBLP8unWu7+u4JgtoFgSvU+GjopQrhxjCh+W8avAFxOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732206489; c=relaxed/simple;
	bh=zVk9BAkvt1HnqTmyLcCypyIgcNNXkakSY0XIL1gabC4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=plSTsjfXgTeep5eCfoCwk/NRX8x/ch+oCWJGDm0stQFCRMiztfnNGNK/aXfYTi8dvF0zOeJ+b1NBd5uOKOHcch6M/qecsw1fT3bD51En7b0b72ZIY6b45szrQBj3dZy6gtOOy1T7xCphynpj+eVHGsiHBVzE5yJ+MaH5aSLk6/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKkkdyIK; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7f8095a200eso1771972a12.1;
        Thu, 21 Nov 2024 08:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732206487; x=1732811287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fYbMhn+O/PdOLgendykEEYqTshCuv9eC2NatkA4BCfA=;
        b=lKkkdyIK0E6jxayOApkoKhlSLul2zTPC8jf1XTFv6qOFeabH4Wswu9MNbFOFhbHWjT
         i93Ul3kkDUWpIZNTXn6XJVZcPJIdLd+a6UbJDM93gR5SsOxpCH+kdx4F5/Zeh4ehxAJb
         /UNMkLsTRV3Yiz7zl8/rFMK/X3gLLXhnVFSOcE+xpNEIqSWSSwqIx7eBzgiT9b20clZV
         B0XXxNd8l97POneXsRwyrGHZ4je5hXXVHb703o4HzR9koGnhni3h8zneEj8Xtr9U6xv9
         JKxJd0ysRrzmiD5UMiSUOHGy966gjylHikObcU8F6+SpuvuZImfwLHc/v5+0vbBvhGWo
         oBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732206487; x=1732811287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fYbMhn+O/PdOLgendykEEYqTshCuv9eC2NatkA4BCfA=;
        b=WSKS/wUsMerOAIo/hGgcHIDLrkaoUVYpmUMNd/HQcSd8Kb9zmDawqqUNn4iHn//u0J
         8iOkYFvL9WwaA6KT08h9XphPV0IWBTYz6cHL5cIWsQ+pd3QsLCIrto568PU3byqHtmgb
         M5eXpKf0cuwdTdW+lyGYUmQzThDma1ljDOKWCrBn9EKWAHcdUf6wabHbCTYXfuaZzdfZ
         iLPFJPpkhYFPgGjHXqKq4mV3M1amI93B+GcQbtw4pqdP1WU4gZKTsQDBVOTbqRdkT8VH
         m+qGR/tBLPgXKFzwVEDGssgBS0eIp2bJk70B2PQtQir7VmAQSMGUJ3oYSyn8vehDVYJh
         ozPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNbgSrJ14Ikbn73ePo8HltvIMCafwdY0BhfpD61jGRKTGu0M1/S3TBPDx+pCL26qASXEg4/Ity6R/0NSO2@vger.kernel.org, AJvYcCWMl2Zdt27SmmkIMpPnGlDAyLNbAaS3vJPxdVqhYVHyt47/+JzkpOuW2ciV+nKUOd40bOx2cw43BpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg/x6wa3aO9rnY2AaJKLq255NUWnL7LD43dlodyo3rMTM6GEYN
	zoRT8oKu8YCqmEyemjIjnEn6kf16TfpsLI+Sk4X0INxRyaW4Ftim
X-Gm-Gg: ASbGnct0MJrpMd7FUVg/+mQh4UoyhKuGlG/NnBf6o2M/e4Fgrcr/SkytDJhEYT1xMci
	jmwhbmPyEvcJqezFxeOs0bt7CVdT1vTbDSOQp65TkFyruu8378dk0GUyRoYN/zFez8jKDuonMg1
	lhXXNtcqI6dJbsFsp/YRLolRTTxtzAhFfnx0Ra4RW0w0EQGMM8HlJd7Wy367EwuWRLwtR4Q5xfv
	wD8f4k40tyIi0RgtRop+UnxE1AcubB8hITepcQ+qbpoI/aBhwhMZZjZQC+r4/fwNTKhTzv5oWM=
X-Google-Smtp-Source: AGHT+IFz+jBkxsWaONKMNJNklRjrdFnYIvcTcgGwbRZcbPXsMhd4+ZGYWBAXIpEQk96vXKzSeLeGvw==
X-Received: by 2002:a05:6a20:12c6:b0:1d9:3747:fb51 with SMTP id adf61e73a8af0-1df9c805af0mr6412811637.8.1732206487069;
        Thu, 21 Nov 2024 08:28:07 -0800 (PST)
Received: from localhost.localdomain ([112.2.230.32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbb659e913sm1518418a12.71.2024.11.21.08.28.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 21 Nov 2024 08:28:06 -0800 (PST)
From: Wenchao Hao <haowenchao22@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Usama Arif <usamaarif642@gmail.com>,
	Lance Yang <ioworker0@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Xu <peterx@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Wenchao Hao <haowenchao22@gmail.com>,
	Chuanhua Han <hanchuanhua@oppo.com>
Subject: [PATCH] mm: add per-order mTHP swap-in fallback counters
Date: Fri, 22 Nov 2024 00:27:35 +0800
Message-Id: <20241121162735.9558-1-haowenchao22@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now large folio swap-in is supported, but we do not have a method
to analyze the success ratio of large folio swap-ins. Similar to
anon_fault_fallback, we add a per-order mTHP swpin_fallback to help
calculate the success ratio. The new counter is located at:

/sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats/swpin_fallback

Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
CC: Chuanhua Han <hanchuanhua@oppo.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 5 +++++
 include/linux/huge_mm.h                    | 1 +
 mm/huge_memory.c                           | 3 +++
 mm/memory.c                                | 1 +
 4 files changed, 10 insertions(+)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 5034915f4e8e..f5c775457913 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -561,6 +561,11 @@ swpin
 	is incremented every time a huge page is swapped in from a non-zswap
 	swap device in one piece.
 
+swpin_fallback
+	is incremented if a huge page swapin fails to allocate a huge page
+	and instead falls back to using huge pages with lower orders or
+	small pages.
+
 swpout
 	is incremented every time a huge page is swapped out to a non-zswap
 	swap device in one piece without splitting.
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index b94c2e8ee918..dcf08f8fdf52 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -121,6 +121,7 @@ enum mthp_stat_item {
 	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
 	MTHP_STAT_ZSWPOUT,
 	MTHP_STAT_SWPIN,
+	MTHP_STAT_SWPIN_FALLBACK,
 	MTHP_STAT_SWPOUT,
 	MTHP_STAT_SWPOUT_FALLBACK,
 	MTHP_STAT_SHMEM_ALLOC,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ee335d96fc39..6b089a41acef 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -617,6 +617,7 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
 DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
 DEFINE_MTHP_STAT_ATTR(swpin, MTHP_STAT_SWPIN);
+DEFINE_MTHP_STAT_ATTR(swpin_fallback, MTHP_STAT_SWPIN_FALLBACK);
 DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
 DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
 #ifdef CONFIG_SHMEM
@@ -637,6 +638,7 @@ static struct attribute *anon_stats_attrs[] = {
 #ifndef CONFIG_SHMEM
 	&zswpout_attr.attr,
 	&swpin_attr.attr,
+	&swpin_fallback_attr.attr,
 	&swpout_attr.attr,
 	&swpout_fallback_attr.attr,
 #endif
@@ -669,6 +671,7 @@ static struct attribute *any_stats_attrs[] = {
 #ifdef CONFIG_SHMEM
 	&zswpout_attr.attr,
 	&swpin_attr.attr,
+	&swpin_fallback_attr.attr,
 	&swpout_attr.attr,
 	&swpout_fallback_attr.attr,
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index 209885a4134f..7cda8b65e0c9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4191,6 +4191,7 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 				return folio;
 			folio_put(folio);
 		}
+		count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK);
 		order = next_order(&orders, order);
 	}
 
-- 
2.45.0


