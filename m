Return-Path: <linux-kernel+bounces-293691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9358795832D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD2028299E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D1A18C00D;
	Tue, 20 Aug 2024 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="E04d0UFW"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EC417740
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724147386; cv=none; b=WMURzZdir91ReRsEi4J8nXvtYeROVm2DLYHnBWFNHV6rQhtqjeKmOXV7EZ49YDGwnxNtAHIycDZSFgqLqrUITgovG0TiCRgp1ZoFtH0VK9LLDRnWHSKWWPgxQOPS6qG62wfmR/Gzi++IYvfE8GPsp2gigVlAFKXfNsSe2jvEOTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724147386; c=relaxed/simple;
	bh=l1RbqkQZq6sg915lsa18n793u3IXlgyjR0yfShXEC1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XLM1bI2luOg2ZqYbQDYT5a3BsxPgzqO3P4SDetkdNM9abSrJjQQvGXT2yB2VhE021qvK00Cg+ZgBohuLnH2D2COeLSBiiEkXKKP53iiP1xSYyxhHarZ15cisAp5I1j+MidD1k7NqCmBa20FZokXZNGSr49GY8N4ApCrzcAMdGrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=E04d0UFW; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724147380; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=3wTFA0rLCCOfQFYiLlDDLZ/CL/lY+xV11hE2CPpQNZs=;
	b=E04d0UFWjdLWeS6aHoXbTQvlMbFLUdfPSUcbtRJtwFyj2UjiD5NT3dPurrUfGkBlEP375TlXfVrLuVZDwb0dl3HU2C0YN0fluHE3P6gR+luU6VFY1/Dc9tCY0mwzDjliq9DmMYWxvlabJECQjsMnBOIYzylga2D6HDc6FJhTo0w=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WDIEwhX_1724147379)
          by smtp.aliyun-inc.com;
          Tue, 20 Aug 2024 17:49:40 +0800
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
Subject: [PATCH v2 0/5] support shmem mTHP collapse
Date: Tue, 20 Aug 2024 17:49:12 +0800
Message-Id: <cover.1724140601.git.baolin.wang@linux.alibaba.com>
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

Changes from v1:
 - Simplify is_refcount_suitable(), per David.
 - Add reviewed tag from David. Thanks.
 - Update some comments.

Baolin Wang (5):
  mm: khugepaged: expand the is_refcount_suitable() to support file
    folios
  mm: khugepaged: use the number of pages in the folio to check the
    reference count
  mm: khugepaged: support shmem mTHP copy
  mm: khugepaged: support shmem mTHP collapse
  selftests: mm: support shmem mTHP collapse testing

 mm/khugepaged.c                           | 62 +++++++++++------------
 tools/testing/selftests/mm/khugepaged.c   |  4 +-
 tools/testing/selftests/mm/thp_settings.c | 46 ++++++++++++++---
 tools/testing/selftests/mm/thp_settings.h |  9 +++-
 4 files changed, 82 insertions(+), 39 deletions(-)

-- 
2.39.3


