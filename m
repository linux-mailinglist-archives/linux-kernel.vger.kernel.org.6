Return-Path: <linux-kernel+bounces-367777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0193A9A06B2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E772868A2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D4020606C;
	Wed, 16 Oct 2024 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pcgYrn0e"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259F929A0
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729073390; cv=none; b=D6EjjwJL3wmt64eU/DHmH23LwO4otvpc4HmrpYDbo95awXsnytRuvnTPbHi7sNcD20K702mhZiwKYyIEv+xm2l/b+dusvLbx9rVWYKjB4Z4+9SRhUPuKFMv9EwqNZsqU7dqLjyX3xrRv+1NWiieJqzLiySHbj4T1pk8UVeC+3BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729073390; c=relaxed/simple;
	bh=AP4oE3sBc4MLSRsg2t4Ct28Q4zKjwNphddxHq4Za3lQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bprsK6VJ74Q5fClTYFNS/CoDrLNkrbu5l+RKEjXzpjugnmGeYqGCHkGmRTU7fOz3QfGH1hKHWAmYf9ZNdZbh4Mj4WDyF4I1AC4NS44zxtCl42GvJlCg1pbRlBi5UHXRbCAvylav0xeocSkiy9kM9VJOKGiFMjSGEJK+EQWFXg/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pcgYrn0e; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729073378; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=wthfNTj+zL6EOKjwNvCjqXLCtOPgmJseg9bBU6MTnpg=;
	b=pcgYrn0e45zY7TgMkImTmyx9LBT7uYTZnCx//Vt1U9cDzu5k00LXb6uB4Ng59YgLZj9NSnj3yfflDTUaXYxgX/F9h8WoLJcZBpE3b35r+kqVaiBVUeQkbfh82DW2xuNQcsSddxKYyS9S0WJd9tqM0V7X7spB2GFNzmEy2kT2rLE=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WHH-UCr_1729073377 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Oct 2024 18:09:38 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Improve the tmpfs large folio read performance
Date: Wed, 16 Oct 2024 18:09:28 +0800
Message-Id: <cover.1729072803.git.baolin.wang@linux.alibaba.com>
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

Baolin Wang (2):
  mm: shmem: update iocb->ki_pos directly to simplify tmpfs read logic
  mm: shmem: improve the tmpfs large folio read performance

 mm/shmem.c | 54 ++++++++++++++++++++++--------------------------------
 1 file changed, 22 insertions(+), 32 deletions(-)

-- 
2.39.3


