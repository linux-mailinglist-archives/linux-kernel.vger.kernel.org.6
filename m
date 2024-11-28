Return-Path: <linux-kernel+bounces-424346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A86CC9DB33F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37FB61676C1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 07:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8855A14F9D6;
	Thu, 28 Nov 2024 07:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aJpe0Hmg"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC72D1482F3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 07:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732779669; cv=none; b=G1PY/RwuWf8HzoiJei5Ba7oU36ijefuMGgklF+cAyQz3Xd0cCB3qZdJ/uKOKVdo3N+1OTkziipAHZs2yu+NwNRM6mQBk88sge4Ec8DUZn4xs7qozUwxEGhmwtYVVElNLnnEhJVyQ8e3o2QbRzPYbLiSiIa6cjTzMn8m0SlWSjzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732779669; c=relaxed/simple;
	bh=1VTUoG2V0gyervSpFGg9a7iaCwc6rFfs5nzrk8u2P+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EoclGHhq9BThDF7A/X4WILUX+3+YdsomI2SW9v8Y8b+PdkackN2ax4zkZotg47JejS1tAGnkZV3pAsGEzf+Dy3bTL8w1Yt6XnLHpmNKddPMjn8wSwiHeIX2nf/Z/REMy/L9fpTHI+yzbCjSnqq+qcv+cwXfRJgSu8tWZH8yq1nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aJpe0Hmg; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732779660; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=4geB5O7mEfI/X7677yTwrrvC9HQS1VjRPAOpYyMK/zg=;
	b=aJpe0Hmg0o3VTImpuD6hAmY2tJNdzR4FocU5j+RovPSRXoJDhknGhgcBRlsvgFSc6u5i27C8sTopDd6mkSDV+ZhpumMfMnv1rqQYKev8MsC7JsaAVum044jpMxR+UgVsKNN9vfbwH+QHyZjlSdbGNTTkYc4/L4lNKpu5IklA2aI=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WKOx1qd_1732779658 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 15:40:59 +0800
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
Subject: [PATCH v3 5/6] docs: tmpfs: update the large folios policy for tmpfs and shmem
Date: Thu, 28 Nov 2024 15:40:43 +0800
Message-Id: <9b7418af30e300d1eb05721b81d79074d0bb0ec9.1732779148.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1732779148.git.baolin.wang@linux.alibaba.com>
References: <cover.1732779148.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hildenbrand <david@redhat.com>

Update the large folios policy for tmpfs and shmem.

Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 58 +++++++++++++++-------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 9ae775eaacbe..ba6edff728ed 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -358,8 +358,21 @@ default to ``never``.
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
@@ -374,19 +387,19 @@ within_size
 advise
     Only allocate huge pages if requested with fadvise()/madvise();
 
-The default policy is ``never``.
+Remember, that the kernel may use huge pages of all available sizes, and
+that no fine control as for the internal tmpfs mount is available.
+
+The default policy in the past was ``never``, but it can now be adjusted
+using the kernel parameter ``transparent_hugepage_tmpfs=<policy>``.
 
 ``mount -o remount,huge= /mountpoint`` works fine after mount: remounting
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
@@ -394,13 +407,24 @@ deny
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


