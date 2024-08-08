Return-Path: <linux-kernel+bounces-279770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621EC94C1A9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C0A1C230AF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E3618FC70;
	Thu,  8 Aug 2024 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="nRyZ0z34"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79C218F2FE
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131763; cv=none; b=rPdkyYsV5aGvpEghHL3jGOgYRYtEUdF6ZeRjrD66eB7d+qGBD/1Rx6TjvpJ+tMiCB3SA2kB9h4vVam9iu4dwTJhmYwttDEeAbcyIcCpFSYs8SCYMal/IGNH5pR27BFMODlin8oN/bTH3EVCPB720O9aiMNL5KVEXni7E6CSmiB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131763; c=relaxed/simple;
	bh=RrfqIOuouVyiFfEs/ry+HWzLi1ojcMi58Cj0sWJhrio=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=D1R2iGGpVajMCWhrK7nflQvEBUMfqO9IUJCWXqEaXI1HI+jX40WQMcXY7I0F5Xc9cePcDQX4bOVrkNP82GCwhbh2wNGCme3I4rK4aL1pxYBB/8lyoaZRmQMlvVZTs8Bhsr5lO4ubzgZHuK9mCq1vbkSqOejaUR/I0NMRr0r/3pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=nRyZ0z34; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6bbc1cee9b7so6581946d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 08:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723131760; x=1723736560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OoS5c7AqTIEc3lMd5dOxMQfYeBpBDya+0ZxkeiTfX/s=;
        b=nRyZ0z34N1OIErGtmme6OKx/b0JIDFYuQA702qE4KNDJsmMOFPQQrw+v7NK8l2LADG
         JVxfGUcyS4Uv5oEcnELN8CheSzLuvB3RYG7otTNVJpiAMzG1DWlPjHKQzE/cZhjdwey/
         R83h/BJ3t7RU5YFNwzFY1pFirV/SJ70viHzUFlA9Pc0Ozw1KXAc1qlx6qHzSzlkJ43Ir
         IpDpb5pK3wobseW7VoHCwGgalDuqzkY9rCvMpKWp2XoSW0Z8Nn+BXWSwBQb28MDDZWG3
         pWw4+WRx6sUnXgO18NnOaXRMxdIPTMgg97Ids06Rt24YvLEBAfS2gqh+oCiyG4uLr052
         LU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723131760; x=1723736560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OoS5c7AqTIEc3lMd5dOxMQfYeBpBDya+0ZxkeiTfX/s=;
        b=YGKXcBhzJWXEmUO+ax582s5KQW9oy8Xom1ZHzL89flLPSAKNx7IYuBBI2WmtWzGi+e
         e/qmK2uYYp1ztVjXnby0s+T7Gsj+dMsefEJ8sotdtb8QnxiGtQFcn0I+NHD5vPP3Bh7s
         smkkc1jyCaYvrm1rZ/tbbjikaYO66tizTGLyxaWa0JDugYHwNkltLh8/4AceHhAT9itt
         ONcmi/WupKJ62yb2DnnTCcPFdoOKrFN4FiZw50t1o1VzAiOR0tJjNY1IBJ16tLsMXyX+
         k/GEd/yvsT6WjeTeUW5YtGut+rtd+A2TLx1NlzM3g8HAAKDdvZIKFD8tjvXyrftBFCOu
         2UHw==
X-Forwarded-Encrypted: i=1; AJvYcCVPIatUYbr112YCYWCuZIN3IILBa+q7MJEeBN1r1aKx2PD2HwEJdDjH0t4XjB+cNEVwM5rG1uPN1qSP+NiS1Pv1nNgQaDbui+YHkM3B
X-Gm-Message-State: AOJu0Yx10vzaZDXnqviSjOI7sEVbymn/ZUuGGqHMQNDQP/iYsuHTFnPA
	fk4IZe5SLH2ISndDfm+5Y5+cyP3eDpVLkOkZit7lsOk0jD+TOb6UXlvz5QLu6Bg=
X-Google-Smtp-Source: AGHT+IEcL0yZePXhMPPsTPK8VSthHtq/oqJtvkGQFO/6miHrQpul5UYc/wo62QVWJrz61dTFYt0okw==
X-Received: by 2002:a05:6214:4886:b0:6b7:99f6:98b0 with SMTP id 6a1803df08f44-6bd6bccdec5mr35072366d6.17.1723131760505;
        Thu, 08 Aug 2024 08:42:40 -0700 (PDT)
Received: from soleen.c.googlers.com.com (118.239.150.34.bc.googleusercontent.com. [34.150.239.118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c7b72d9sm67160936d6.60.2024.08.08.08.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 08:42:40 -0700 (PDT)
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
Subject: [PATCH v3 0/4] Fixes for memmap accounting
Date: Thu,  8 Aug 2024 15:42:33 +0000
Message-ID: <20240808154237.220029-1-pasha.tatashin@soleen.com>
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
	- Added patch "mm: add system wide stats items category"
	- Changed from using system-wide events to system-wide stats
v2:
https://lore.kernel.org/lkml/20240807211929.3433304-1-pasha.tatashin@soleen.com

Pasha Tatashin (4):
  mm: update the memmap stat before page is freed
  mm: don't account memmap on failure
  mm: add system wide stats items category
  mm: don't account memmap per-node

 include/linux/mmzone.h |  2 --
 include/linux/vmstat.h | 22 +++++++-----------
 mm/hugetlb_vmemmap.c   | 13 +++++------
 mm/mm_init.c           |  3 +--
 mm/page_alloc.c        |  1 -
 mm/page_ext.c          | 15 +++++--------
 mm/sparse-vmemmap.c    | 11 ++++-----
 mm/sparse.c            |  5 ++---
 mm/vmstat.c            | 51 ++++++++++++++++++++----------------------
 9 files changed, 49 insertions(+), 74 deletions(-)

-- 
2.46.0.76.ge559c4bf1a-goog


