Return-Path: <linux-kernel+bounces-401045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE0F9C1554
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7993B2231D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4261D097F;
	Fri,  8 Nov 2024 04:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QMJJ5uvD"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51701D0143
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 04:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731039218; cv=none; b=hfhk2PZ5HrsIREBqOp2dWG9M68VELcT8r64uPHoqRHwErFUjpX6aCEqf36qGOp4s2ki1O8WK02WZqFAdhNhnu209g4QECpbwxCJgIEe7jU+7Rb2v4mNZbjjtWZtKX8jhnF38O0D9+WLDw/S7RiE/VafOcFoQ9h182YjWxIw8rns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731039218; c=relaxed/simple;
	bh=TC8NDwoOUMeA/My5O/A8g5mi2sVobB8mozFqxOI+boY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bqLeI6KpDkx4pk2Nhv0BC3a4bq6KFN2/6g1Xx8b6+BK0KleI1I/HYwJ7XZNGmC8sSr5+wUpSTb/ga01qcM1413z/whw1gJ3qItFCwLNcV10G0WPIrO4xdVOYImzH7NC9xqabunWc75M9t07aiLh2pS/i/eW39psG8WUTaMz+BJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QMJJ5uvD; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731039208; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ZMgQiGlmb/wE6nW4qxF+A3bZ7Id2I6Bajbakd8brhAI=;
	b=QMJJ5uvDLvcQ59uDe4rhb6psDskUZfYEmx7Z5vYS+YDUxMjT0UWg9+BXpwReBewdT2bMYvGcbbzIVS2z3unIfoUf1Zs00s6/b+grz2Ayaq9l6A7VRg5w6Sqblnj9VCER1vSXzC6cE4rz0oVGsp8eyWmh34yjN+l0QhVjiwcv/N4=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WIxRHWz_1731039206 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 Nov 2024 12:13:26 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	ioworker0@gmail.com,
	da.gomez@samsung.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] docs: tmpfs: update the huge folios policy for tmpfs and shmem
Date: Fri,  8 Nov 2024 12:12:58 +0800
Message-Id: <f392b852007cc088d932f1ee326afb90f9c27a73.1731038280.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1731038280.git.baolin.wang@linux.alibaba.com>
References: <cover.1731038280.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hildenbrand <david@redhat.com>

Update the huge folios policy for tmpfs and shmem.

Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 52 +++++++++++++++-------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 5034915f4e8e..2a7705bf622d 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -352,8 +352,21 @@ default to ``never``.
 Hugepages in tmpfs/shmem
 ========================
 
-You can control hugepage allocation policy in tmpfs with mount option
-``huge=``. It can have following values:
+Traditionally, tmpfs only supported a single huge page size ("PMD"). Today,
+it also supports smaller sizes just like anonymous memory, often referred
+to as "multi-size THP" (mTHP). Huge pages of any size are commonly
+represented in the kernel as "large folios".
+
+While there is fine control over the huge page sizes to use for the internal
+shmem mount (see below), ordinary tmpfs mounts will make use of all available
+huge page sizes without any control over the exact sizes, behaving more like
+other file systems.
+
+tmpfs mounts
+------------
+
+The THP allocation policy for tmpfs mounts can be adjusted using the mount
+option: ``huge=``. It can have following values:
 
 always
     Attempt to allocate huge pages every time we need a new page;
@@ -374,13 +387,9 @@ The default policy is ``never``.
 ``huge=never`` will not attempt to break up huge pages at all, just stop more
 from being allocated.
 
-There's also sysfs knob to control hugepage allocation policy for internal
-shmem mount: /sys/kernel/mm/transparent_hugepage/shmem_enabled. The mount
-is used for SysV SHM, memfds, shared anonymous mmaps (of /dev/zero or
-MAP_ANONYMOUS), GPU drivers' DRM objects, Ashmem.
-
-In addition to policies listed above, shmem_enabled allows two further
-values:
+In addition to policies listed above, the sysfs knob
+/sys/kernel/mm/transparent_hugepage/shmem_enabled will affect the
+allocation policy of tmpfs mounts, when set to the following values:
 
 deny
     For use in emergencies, to force the huge option off from
@@ -388,13 +397,24 @@ deny
 force
     Force the huge option on for all - very useful for testing;
 
-Shmem can also use "multi-size THP" (mTHP) by adding a new sysfs knob to
-control mTHP allocation:
-'/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/shmem_enabled',
-and its value for each mTHP is essentially consistent with the global
-setting.  An 'inherit' option is added to ensure compatibility with these
-global settings.  Conversely, the options 'force' and 'deny' are dropped,
-which are rather testing artifacts from the old ages.
+shmem / internal tmpfs
+----------------------
+The mount internal tmpfs mount is used for SysV SHM, memfds, shared anonymous
+mmaps (of /dev/zero or MAP_ANONYMOUS), GPU drivers' DRM  objects, Ashmem.
+
+To control the THP allocation policy for this internal tmpfs mount, the
+sysfs knob /sys/kernel/mm/transparent_hugepage/shmem_enabled and the knobs
+per THP size in
+'/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/shmem_enabled'
+can be used.
+
+The global knob has the same semantics as the ``huge=`` mount options
+for tmpfs mounts, except that the different huge page sizes can be controlled
+individually, and will only use the setting of the global knob when the
+per-size knob is set to 'inherit'.
+
+The options 'force' and 'deny' are dropped for the individual sizes, which
+are rather testing artifacts from the old ages.
 
 always
     Attempt to allocate <size> huge pages every time we need a new page;
-- 
2.39.3


