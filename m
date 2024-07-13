Return-Path: <linux-kernel+bounces-251514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D59C9305BF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 15:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409B1282D23
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 13:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA4A13213B;
	Sat, 13 Jul 2024 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YChQfbZD"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A524A3D
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720877080; cv=none; b=sbkXGWzP05NARcLOsHiOH7srsC4fqhWv6nnuxCCGG5ox8H89Q+ZfkJgcGWEEqEd7LGwBx4ICZ//yMdsiHJN4Z6N+rbxxbPyOKv/fQK48SwJ/wso7SJyFU7VbcL8eTm4IbXIIUuC+tEELL+YA7CipcSfGTYu9nNlL5axO6KfzaMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720877080; c=relaxed/simple;
	bh=dZ8U2DGzMfw8Q8ijqGwdM+ed3elaRuDxekat+20SaVA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dij6BqmAEEgPbdmQjm0XjUV1RUpHbEzlFgzUvVqgtIKy9/ShVJPzGoJXwZXFXw4RPpVLqYPqGWei7HKmKA8aOkTARc28IFYpDEGkM9439tNaD5c/L7QoEcVjRUTcXmlPQjTQZhioLHy8DiYm9/h5txDEQYLNDBUIXDrTNcuODzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YChQfbZD; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720877069; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ytypz4bqlRLBeOb2hk6wBu/fHjDnyJ0xf/5Zkw4In5c=;
	b=YChQfbZDDgwP3/2nBil3FcjcMzmqNLQpkXDA/s3PobfmNKSu+P+2WnsnADOOYPvw1+G8B0igCyuvJ0PTFpUlpmeuUjVyJwx93yNW7mclIYPeP+NXdYJMARTZO14Xknl7VsGo6u1AHDfUVWgvgrcfzRyvICeSQb3eoLmL5dx2BIk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0WAR0qGo_1720877067;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WAR0qGo_1720877067)
          by smtp.aliyun-inc.com;
          Sat, 13 Jul 2024 21:24:28 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	ziy@nvidia.com,
	ioworker0@gmail.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Some cleanups for shmem
Date: Sat, 13 Jul 2024 21:24:19 +0800
Message-Id: <cover.1720755677.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series does some cleanups to reuse code, rename functions and simplify
logic to make code more clear. No functional changes are expected.

Changes from v1:
 - Add a dummy function in case CONFIG_TRANSPARENT_HUGEPAGE is not
 enabled, which fixes a building error reported by kernel test robot.

Baolin Wang (3):
  mm: shmem: simplify the suitable huge orders validation for tmpfs
  mm: shmem: rename shmem_is_huge() to shmem_huge_global_enabled()
  mm: shmem: move shmem_huge_global_enabled() into
    shmem_allowable_huge_orders()

 include/linux/shmem_fs.h | 11 +----
 mm/huge_memory.c         | 11 ++---
 mm/shmem.c               | 91 +++++++++++++++++++++-------------------
 3 files changed, 53 insertions(+), 60 deletions(-)

-- 
2.39.3


