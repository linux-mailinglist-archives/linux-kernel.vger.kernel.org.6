Return-Path: <linux-kernel+bounces-291666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5D9956557
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A8B2831E1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A81915B559;
	Mon, 19 Aug 2024 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LqrZUB6e"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6719C15B0F1
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724055296; cv=none; b=gMereZx1Wtn6xDf/XeoCI+eTywXcMavYhVy1ylI86kZbK+FxzewNAEna0xqaduyJAC5WXLNIprpDo4n+X8OAFIYhZGcOWY7ZykCzrthLo6VPJIgFijZ/y6MUXwnGZfQqm55bD8O2Fc1f94WffmGxBXD+CqsLPlG5HmteL9ioIVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724055296; c=relaxed/simple;
	bh=iVB9rUsSwBt5CSzB3887UEX8X5Mb1Wf1BayukMXlomw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IaaXX+beZSyVjD1GvD/BvL9Cs/XKrzey9xnj8jnHVQSG4O8IDGke3d+LaylJ2okYpwe5xKkL3HwUT3ilc/PGmiEfVFy/57rYYm7CEkroizYA43FWMQySQWUg1s4yqLK2NpV/m1105ytXk36c8W7R7gTHHNMpA2o9xCBh2tMkhs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LqrZUB6e; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724055285; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=jorS/OAhi2o1DqE879TPVDZXm17fL6EjvHqpR3pvR7U=;
	b=LqrZUB6e8lwnQmuggkiCVihzGhUJ5kshG+g/MypXMQCxyredcI3pIreKyaTkhE/u7EatJ/SjJdrX1KRKMPI7iXSybrfNLPM9ZApyzrzJVJIui8MCpo7jTcDDA8Sf/6vecYsPvJuAuvlBdmIzhgCdCGmkXjAPcd9yQkvUYZMt1Pw=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WD9CrH._1724055284)
          by smtp.aliyun-inc.com;
          Mon, 19 Aug 2024 16:14:45 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] support shmem mTHP collapse
Date: Mon, 19 Aug 2024 16:14:01 +0800
Message-Id: <cover.1724054125.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Shmem already supports mTHP allocation[1], and this patch set adds support
for shmem mTHP collapse, as well as adding relevant test cases. Please
help to review. Thanks.

Note: all khugepaged selftests have passed.

[1] https://lore.kernel.org/all/cover.1718090413.git.baolin.wang@linux.alibaba.com/T/#m4bd7e701c7b5f36f712055e4360cad593a22b3bf

Baolin Wang (5):
  mm: khugepaged: expand the is_refcount_suitable() to support file
    folios
  mm: khugepaged: use the number of pages in the folio to check the
    reference count
  mm: khugepaged: support shmem mTHP copy
  mm: khugepaged: support shmem mTHP collapse
  selftests: mm: support shmem mTHP collapse testing

 mm/khugepaged.c                           | 60 ++++++++++++-----------
 tools/testing/selftests/mm/khugepaged.c   |  4 +-
 tools/testing/selftests/mm/thp_settings.c | 46 ++++++++++++++---
 tools/testing/selftests/mm/thp_settings.h |  9 +++-
 4 files changed, 83 insertions(+), 36 deletions(-)

-- 
2.39.3


