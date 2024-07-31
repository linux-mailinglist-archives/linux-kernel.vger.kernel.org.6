Return-Path: <linux-kernel+bounces-268748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115D99428D7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5C96284BD4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A581A7F93;
	Wed, 31 Jul 2024 08:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NtS0f+2G"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB0F1A7F72
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722413257; cv=none; b=sJ+eCAX8QBdIGatvcVeD+G4fAIZ9zmdnMlnjRgi91dqBn0B3p8ohYb1JH9B/V1CsDouJ9MctTltT5XmCKgPQp01KPXIvZ6XadOVgoH+STZqLg4CfLZUv/wLAR6aAz/j8ZdUZOVD9EljHY+ElQZdjYagZ/RL7bGwfbx2qXyqYqIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722413257; c=relaxed/simple;
	bh=NlUfIRtseUBQYVGnui/zSiSx3dk3o57iRqzrPtGrAzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eDFD/Yk1ujRUhmH6NJPIievTE66sFWmjHZiAfsZ9Apr0o0CuQlwyEPE1f6zBfotRmbYOFqah0ALr67o4slq4bdFgm/ukq5QU0sjJKCJzEWIEZRUHJ2+6Kcnpx4HpiAAMars8s83mIdx9hoYY3e7KDWtui99pQ1X1S1/Jiz3Xj5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NtS0f+2G; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722413246; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Uxd2jJIXAH3PIE6CxqCJs50kLW+TbFbI4fsGjKI3nc0=;
	b=NtS0f+2G0pDhp+fPreuiLMHyzoDYTiIhbGXI7buwaeyX/LDA3TDd9M36Xztr1sjNJzuAG/j1uKqIr+yNXJDNEC3tr8zGZjDB3fdcL0Xf9ocUen3//dbBQniD8MCuiGj6zgHE30DenxTWXdJmhUpcr/cOxnHCAXYLfNHYRwIQvYE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0WBin-mG_1722413244;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WBin-mG_1722413244)
          by smtp.aliyun-inc.com;
          Wed, 31 Jul 2024 16:07:25 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	lihongbo22@huawei.com
Cc: linux-kernel@vger.kernel.org,
	Hongzhen Luo <hongzhen@linux.alibaba.com>
Subject: [PATCH RFC v2 0/2] erofs: introduce page cache share feature
Date: Wed, 31 Jul 2024 16:07:02 +0800
Message-ID: <20240731080704.678259-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
- Update the `Implementation` section.
- Update the `Effect` section.
- Add the `Restriction` section.

v1: https://lore.kernel.org/all/20240722065355.1396365-1-hongzhen@linux.alibaba.com/

[Background]
================
Currently, reading files with different paths (or names) but the same
content will consume multiple copies of the page cache, even if the
content of these page caches is the same. For example, reading identical
files (e.g., *.so files) from two different minor versions of container
images will cost multiple copies of the same page cache, since different
containers have different mount points. Therefore, sharing the page cache
for files with the same content can save memory.

[Implementation]
================
During the mkfs phase, file content is hashed and the hash value is 
stored in the `trusted.erofs.fingerprint` extended attribute. Inodes of
files with the same `trusted.erofs.fingerprint` are mapped to a list, and
this mapping is accomplished through xarray. When a read request occurs,
one of these inodes that in the list (the first inode in this implementation)
is used to store the actual content. In this way, a single copy of the
selected inode's page cache can serve read requests from several files
mapped to it.

[Effect]
================
I conducted experiments on two aspects across two different minor versions of
container images:

1. reading all files in two different minor versions of container images 

2. run workloads or use the default entrypoint within the containers^[1]

Below is the memory usage for reading all files in two different minor
versions of container images:

+-------------------+------------------+-------------+---------------+
|       Image       | Page Cache Share | Memory (MB) |    Memory     |
|                   |                  |             | Reduction (%) |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     241     |       -       |
|       redis       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |     163     |      33%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     872     |       -       |
|      postgres     +------------------+-------------+---------------+
|    16.1 & 16.2    |        Yes       |     630     |      28%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     2771    |       -       |
|     tensorflow    +------------------+-------------+---------------+
|  1.11.0 & 2.11.1  |        Yes       |     2340    |      16%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     926     |       -       |
|       mysql       +------------------+-------------+---------------+
|  8.0.11 & 8.0.12  |        Yes       |     735     |      21%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     390     |       -       |
|       nginx       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |     219     |      44%      |
+-------------------+------------------+-------------+---------------+
|       tomcat      |        No        |     924     |       -       |
| 10.1.25 & 10.1.26 +------------------+-------------+---------------+
|                   |        Yes       |     474     |      49%      |
+-------------------+------------------+-------------+---------------+

Additionally, the table below shows the runtime memory usage of the
container:

+-------------------+------------------+-------------+---------------+
|       Image       | Page Cache Share | Memory (MB) |    Memory     |
|                   |                  |             | Reduction (%) |
+-------------------+------------------+-------------+---------------+
|                   |        No        |      35     |       -       |
|       redis       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |      28     |      20%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     149     |       -       |
|      postgres     +------------------+-------------+---------------+
|    16.1 & 16.2    |        Yes       |      95     |      37%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     1028    |       -       |
|     tensorflow    +------------------+-------------+---------------+
|  1.11.0 & 2.11.1  |        Yes       |     941     |       9%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     155     |       -       |
|       mysql       +------------------+-------------+---------------+
|  8.0.11 & 8.0.12  |        Yes       |     139     |      11%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |      25     |       -       |
|       nginx       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |      20     |      23%      |
+-------------------+------------------+-------------+---------------+
|       tomcat      |        No        |     186     |       -       |
| 10.1.25 & 10.1.26 +------------------+-------------+---------------+
|                   |        Yes       |      98     |      48%      |
+-------------------+------------------+-------------+---------------+

It can be observed that when reading all the files in the image, the reduced
memory usage varies from 16% to 49%, depending on the specific image.
Additionally, the container's runtime memory usage reduction ranges from 9%
to 48%.

[1] Below are the workload for these images:
      - redis: redis-benchmark
      - postgres: sysbench
      - tensorflow: app.py of tensorflow.python.platform
      - mysql: sysbench
      - nginx: wrk
      - tomcat: default entrypoint

[Restriction]
================
Currently, this feature only supports reading uncompressed files. It do not
support:
	- over fscache
	- compression
The upcoming updates will expand the range of support to these.

Hongzhen Luo (2):
  erofs: introduce page cache share feature
  erofs: apply the page cache share feature

 fs/erofs/Kconfig           |  10 ++
 fs/erofs/Makefile          |   1 +
 fs/erofs/inode.c           |  23 +++++
 fs/erofs/internal.h        |   8 ++
 fs/erofs/pagecache_share.c | 189 +++++++++++++++++++++++++++++++++++++
 fs/erofs/pagecache_share.h |  15 +++
 fs/erofs/super.c           |  23 +++++
 7 files changed, 269 insertions(+)
 create mode 100644 fs/erofs/pagecache_share.c
 create mode 100644 fs/erofs/pagecache_share.h

-- 
2.43.5


