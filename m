Return-Path: <linux-kernel+bounces-278570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F0094B1FD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7779A1C21BEE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF134149E16;
	Wed,  7 Aug 2024 21:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="sX3uf7M3"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E53C4D5BD
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065575; cv=none; b=kEic/VozX8mSPpU/XT+hkEjaQMQvycbalN0nMdB+T+4hj5WjD8jXprYi+bMLw9KN1iunqiUEZUnPWB9+s41cj9glP22D1wH37ONW5OIvueoczhisPTm9W7h4X2jkzw2QwRyFPGk9Yw3vltLfPoOPfYYUQhGYvdYMub/ghIDYS3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065575; c=relaxed/simple;
	bh=ETNqQNPIfMuNX17s9DqUxbob+sV2Y2EoypUlDooNpuo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nlVDvWlWucH5G6+0q0DX5CVGjHY41avsl9ipMoPtYtIRYVaOS/8kor6DR99+0NRvyqm8sbb4FAhcR/hAQIbylh2aB9Z5BQF5tkHJFhplfY4VfGHrv/fO+WI6XmSg0q7rfPswpva95c49Yzt56oVnnc8qHcHDaxmz3H7Jugks1hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=sX3uf7M3; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b7a3b75133so2130816d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 14:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723065573; x=1723670373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=82MTbIplkl6C6hc9tdsrePKOyyI0I1cQ+GLt7FOBykw=;
        b=sX3uf7M3/mmsUJjfW40ivvtMzD9QIwMzZaAkRsB9S3DfSd4yUhugazBe8B/Jzo3DM1
         TJ8ip8vaxQMiFN1HH7rMeSj2UtQAWzBmefUFGKTuZolp/ScuzM6+upA2FNXyj3rANM4P
         /UoLkL7Wps9S5sbwolVBeu1L+MoXgKQg41eoaHcjVSXiBdyrevx4xysD7XbO7HvtZyN0
         A7nchsn8AEJkaP70ADG9d4tNhHbT5I8UoZSOm4nzxe3GeYo3mbIFDCiGAmPYmZ8ZbQ6R
         ugswEmJn68JZDgkAA2f2PyvQJerqN1bbfxJPxC4xLrPZirnpMBdoljCatxLX6qvuGCFq
         wMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723065573; x=1723670373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82MTbIplkl6C6hc9tdsrePKOyyI0I1cQ+GLt7FOBykw=;
        b=Rb8wK4J0rBFRsA8DntFeqS1bnWNkoZAGfoPhz1ouvjiHiu/UTNtajuKsKk3ACZowQ8
         nKUSMoKZjwr+9/h+wgspJdMzN1vStAKhRn/bQcQc72/HPwJi7MN7eGTisMSDIV3xT9lw
         4bEddpHeBjdD6EAFPyI1gDpA7CN7gU73PtcrUe6AVMhIYvEEDW1oEgtt5R2dcCbt7Ka/
         dsHxZTPS6pAg7QR6u8ZpxUKWRBP4qYoz7d9we2lthvb2hg/yLZfRo7Ay0BHLIg8OiyOJ
         kb9nAEIXVW7NxaxAUFt4dV6lL7E5gagq+ApYYPm1Q3oNKfYWa32Sn2Beb4A0eOdvcJ/e
         7EaA==
X-Forwarded-Encrypted: i=1; AJvYcCXtRdsxQrZt58xUoO07/lF7MQdQhEvWxktEyxgVibZsQXV7PL1ZBF9bt7f1WtBvcZPciqYw9dmR7ya2SwmO5Qji0HTCV+gZgA7xXcZx
X-Gm-Message-State: AOJu0YxChVjxRsCZ9F/JzW44p1eYUhk2rekTD9F4fSVPepMaDGuYtDsB
	LRiOsSonMI9DIPQxlSuyHQOgMn7pLQmFSYL+KePU+JMPeYH+nNT8Hbw207dKg3M=
X-Google-Smtp-Source: AGHT+IFHbg6vfWToavDfEVxfj+vJ+/gx7b55MHC2YJNJ/O6LLN4LUhYgYdejRhwepbYuL6YbUk18Wg==
X-Received: by 2002:a05:6214:5b85:b0:6b7:9567:7cdc with SMTP id 6a1803df08f44-6bb98420125mr274115696d6.53.1723065572823;
        Wed, 07 Aug 2024 14:19:32 -0700 (PDT)
Received: from soleen.c.googlers.com.com (118.239.150.34.bc.googleusercontent.com. [34.150.239.118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c839ee1sm59976976d6.89.2024.08.07.14.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 14:19:32 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
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
	willy@infradead.org
Subject: [PATCH v2 0/3] Fixes for memmap accounting
Date: Wed,  7 Aug 2024 21:19:26 +0000
Message-ID: <20240807211929.3433304-1-pasha.tatashin@soleen.com>
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

v1: https://lore.kernel.org/all/20240806221454.1971755-1-pasha.tatashin@soleen.com
Changes:
	- Added patch "mm: don't account memmap on failure"
	- Changed from using nid in hot-remove functions to non-pernode
	  system-wide accounting for memmap data.

Pasha Tatashin (3):
  mm: update the memmap stat before page is freed
  mm: don't account memmap on failure
  mm: don't account memmap per node

 include/linux/mmzone.h        |  2 --
 include/linux/vm_event_item.h |  2 ++
 include/linux/vmstat.h        |  7 ++++--
 mm/hugetlb_vmemmap.c          | 13 ++++------
 mm/mm_init.c                  |  3 +--
 mm/page_alloc.c               |  1 -
 mm/page_ext.c                 | 15 ++++--------
 mm/sparse-vmemmap.c           | 11 ++++-----
 mm/sparse.c                   |  5 ++--
 mm/vmstat.c                   | 45 ++++++++++++++++-------------------
 10 files changed, 45 insertions(+), 59 deletions(-)

-- 
2.46.0.76.ge559c4bf1a-goog


