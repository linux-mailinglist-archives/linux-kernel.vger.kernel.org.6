Return-Path: <linux-kernel+bounces-280145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD6394C654
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 23:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C4D1F23A30
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D6115B541;
	Thu,  8 Aug 2024 21:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="1diaB+tD"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D161465BA
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 21:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723152883; cv=none; b=Dn03SP6sWDYtrJatl5h0Ed0jq1/v+jS185ujlOD0HYKa4OicVMhOzLBV2ETBcziHR1djfAjntTOSvrUfIZmTvubgB95pUzusnFxs0lzVRFZSlHFme/YHdb663dDVD/q9b8W2O/KzuCSmUyDEgJ749WTCHv6/OTRD/CTu1niIjyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723152883; c=relaxed/simple;
	bh=RbMYgA++9fV0EBRect7rFATXup7VOfQbVaa+QMmyIIo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TPkCUefDZmSBBkNB9GirDBCoHzQamuj3UPYItN7aghbHXIrUx14kWyZvQd4cOth4wyb7CBndQ/rcROxi9EcuOgkvzia61TR2qLzFhcUFrj+989VlnFC5DuD0VyJOo/svi0t0i2ieWwHVk/ApQxxYPJqv6iJOFGf4DV0DhNCTpIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=1diaB+tD; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6bb84ac8facso7904746d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 14:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723152879; x=1723757679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sR4Q4RBNyDlEyEtMKpSg2raAJFHhcndUnkwyiIaahuQ=;
        b=1diaB+tD2tnfjkLFy5oNsQx83WdZ4suVKYPD7HWX3jWMOp6wFSqyhyY6ofGUJ0iPFs
         LAv8ADpMmLYKRnUSDfhXNmOFx/3ChwSWCjajfaNKyfKlscjQ2V3l5i6Rb2YqKuM68/Io
         OYBFP9wKzRB0UIhRAnfo9imYHwWp68hYSQbG/ZfVFWOJlKuBy7DL6ygWRmbC63JVVmwQ
         SVusyRFrUpRYY8il4k4qWcSrkQ8a314rlx3NPFvAbwcoFCewge8C2lzytUwW6CJVbq1P
         Jux4GeEw9/BPhUjN4IqlBDNveFd5OlW/28R7BUd8lmYnDXC4C1NjV6nICfyKwL6mWEXj
         7RQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723152879; x=1723757679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sR4Q4RBNyDlEyEtMKpSg2raAJFHhcndUnkwyiIaahuQ=;
        b=lmrxUdy5U7136DlXF5gHXFhrLUmJxk+P8oDb1vKN/00Z8fYml/amLtcPgR2u2AWqs7
         LRIk64bwIYrycJ7t+Jt14egg3/+jMEdNO7PSss8nchTTQwWasnH6RwZx0zezVtUz2c/E
         SplbS6JsFE0oZvYutgRcnepiD1NGC9LyUPz1p732U4h34IvRW6pCJr0ozLPAFUCZ6ONA
         iHzAXCoz6XU4lj0mQHxRM4YWsZCIgin7QwDTBm86tGsgTkVvyMWEVC8vd0EqFhdZMbCk
         jMiWLmYL55DdL4yZBLRJenEp4cScfZAE008XTLy/n4eGL2FjY/X8mtkBiOBYnqD4b8Kk
         KviQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtTKWMzPdcY0PVimNgo9HuegQcw0XCzOE5VKrh+k1zoOI9ExIg+w+S6uQxjcYjPjFESvC+R3n4NKVLaoIMyP5Kd5BdPw19xjrk+72H
X-Gm-Message-State: AOJu0YwygYEWhMKKmFXp2bA1NX6/JQPzB41da1DfBp1Fo3bcppPSVeUj
	2FQZWPyqwA3LD99+Bu8aDiI31vgdits245qZ6h+ti2VEyrMGXffeS5/iSZ+VC4o=
X-Google-Smtp-Source: AGHT+IHhBAY4jB88eZ0nLk17m3lkT6t2c4WPOVLAuUQhNq1gELh0d4mWiwBC5MNPkQLlby32mEfHBg==
X-Received: by 2002:a05:6214:33c3:b0:6b7:a175:29b7 with SMTP id 6a1803df08f44-6bd6bda2ed6mr42811146d6.51.1723152879490;
        Thu, 08 Aug 2024 14:34:39 -0700 (PDT)
Received: from soleen.c.googlers.com.com (118.239.150.34.bc.googleusercontent.com. [34.150.239.118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c762bd1sm70205026d6.29.2024.08.08.14.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 14:34:39 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	cerasuolodomenico@gmail.com,
	hannes@cmpxchg.org,
	j.granados@samsung.com,
	lizhijian@fujitsu.com,
	muchun.song@linux.dev,
	nphamcs@gmail.com,
	pasha.tatashin@soleen.com,
	rientjes@google.com,
	rppt@kernel.org,
	souravpanda@google.com,
	vbabka@suse.cz,
	willy@infradead.org,
	dan.j.williams@intel.com,
	yi.zhang@redhat.com,
	alison.schofield@intel.com,
	david@redhat.com,
	yosryahmed@google.com
Subject: [PATCH v4 0/3] Fixes for memmap accounting
Date: Thu,  8 Aug 2024 21:34:33 +0000
Message-ID: <20240808213437.682006-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memmap accounting provides us with observability of how much memory is
used for per-page metadata: i.e. "struct page"'s and "struct page_ext".
It also provides with information of how much was allocated using
boot allocator (i.e. not part of MemTotal), and how much was allocated
using buddy allocated (i.e. part of MemTotal).

This small series fixes a few problems that were discovered with the
original patch.

Changes:
- Removed patch 'mm: update the memmap stat before page is freed', as
  noticed by Yosry after 3/3 that patch is not needed anymore.
- renamed nr_memmap to nr_mammp_pages and nr_memmap_boot to
  nr_memmap_boot_pages as suggested by David Hildenbrand
- Added the origianl oops information as suggested by Alison Schofield
- Improved commit log message as suggested by David Hildenbrand
- Added review-by's, acked-by's, and tested-by's

v3:
https://lore.kernel.org/linux-mm/20240808154237.220029-1-pasha.tatashin@soleen.com

Pasha Tatashin (3):
  mm: don't account memmap on failure
  mm: add system wide stats items category
  mm: don't account memmap per-node

 include/linux/mmzone.h |  2 --
 include/linux/vmstat.h | 22 +++++++-----------
 mm/hugetlb_vmemmap.c   | 13 +++++------
 mm/mm_init.c           |  3 +--
 mm/page_alloc.c        |  1 -
 mm/page_ext.c          | 18 ++++-----------
 mm/sparse-vmemmap.c    | 11 ++++-----
 mm/sparse.c            |  5 ++---
 mm/vmstat.c            | 51 ++++++++++++++++++++----------------------
 9 files changed, 48 insertions(+), 78 deletions(-)

-- 
2.46.0.76.ge559c4bf1a-goog


