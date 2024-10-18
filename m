Return-Path: <linux-kernel+bounces-370873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBDA9A331E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8C61F23CEB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A53214EC56;
	Fri, 18 Oct 2024 03:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TQXpYFNj"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8C72D05D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 03:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729220441; cv=none; b=o+Mlx/OVuBgda3LJPdVnPvNL3DUGTP1HkA0Wg5otChfnz2Afh/c/XFMUqRzMIo8ofOlZil/vkBr7vZJv1WA3NSQXCmFOXmXur2BgqCx0mieOTaeTZoLnedQUXmhh09RrsVdR+4yxpEX+YmVS+NKHi5hovCse8lobnavptvH3E68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729220441; c=relaxed/simple;
	bh=TgGwme883e2mmeyDm4J9kGlW8z2yl3S0q13gir9HtfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gn2QsXL0DgNJVaJPY7aSRGkOqD3md6eGTiSaNGDFwpgr9yV5iul4j17mv9L7qHhM4l7Kp3+4ve/LOAMA5AWpyOCEntsO/mOzRg6gDKl6pTHqfJDha/MTALbc9bNIujOeEoEN1sswjlZ0YtdkoMXPlTTAY4BPI6ho9snouxTwkB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TQXpYFNj; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729220435; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=b7EskSvgvdOAp4v5R718ehHA8SmBGTMmQBGnhhWZuCo=;
	b=TQXpYFNj/XcAV8e2VuI1cLhh/wXHtJsoA0cmwlwO5qcr9I28Z7HHOmBSlGTTNkAVcMWOVWFeK9nEfHftN7MxzE2Cxvhijp27b/n63vKCMGoxK9YfXER2Nzdefl/Cr9disy5519qA9KzHGqZulFt+9u16kC3J7IoIjcbeL2B53r0=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WHMZWVB_1729220434 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Oct 2024 11:00:35 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	shy828301@gmail.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Improve the tmpfs large folio read performance
Date: Fri, 18 Oct 2024 11:00:26 +0800
Message-Id: <cover.1729218573.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tmpfs has already supported the PMD-sized large folios, but the tmpfs
read operation still performs copying at the PAGE SIZE granularity, which
is not perfect. This patch changes to copy data at the folio granularity,
which can improve the read performance.

Use 'fio bs=64k' to read a 1G tmpfs file populated with 2M THPs, and I can
see about 20% performance improvement, and no regression with bs=4k. I
also did some functional test with the xfstests suite, and I did not find
any regressions with the following xfstests config.
  FSTYP=tmpfs
  export TEST_DIR=/mnt/tempfs_mnt
  export TEST_DEV=/mnt/tempfs_mnt
  export SCRATCH_MNT=/mnt/scratchdir
  export SCRATCH_DEV=/mnt/scratchdir

Changes from v1:
 - Move index calculation to the appropriate place, per Kefeng.
 - Fallback to page copy if large folio has poisoned subpages, suggested
   by Matthew and Yang.

Baolin Wang (2):
  mm: shmem: update iocb->ki_pos directly to simplify tmpfs read logic
  mm: shmem: improve the tmpfs large folio read performance

 mm/shmem.c | 65 +++++++++++++++++++++++++++---------------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

-- 
2.39.3


