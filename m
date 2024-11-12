Return-Path: <linux-kernel+bounces-405327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF819C4FE9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8259B283216
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 07:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7BA20FAA7;
	Tue, 12 Nov 2024 07:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="J9x9ZEkl"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D24E20DD64
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 07:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731397566; cv=none; b=Ivujf05dXxJQRz7Dy7qm4WoxpSSpytKOBHqHwC+AOy+8lmg+IFEnB8+2J9HS2y8uWSLQ5yVteVPr316GCXflfUDBfDmPTX4tviXXgiJ0QnxkLX//4c/Ws9y4fZfdSjYoc4ccCpV8W2izqiUS5qVP2vjzH9F5aULoc8nNdn/dBY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731397566; c=relaxed/simple;
	bh=L7rFdPe4RkTCRnaVXfTFgkfc8ImPN+u8+wGEVH5vCeA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RGrLuD+mlTTI8xfFhQ9yMMjHceM6NXM9cQakvsKEFz/QEOlJWi+s6Jkiup4NYfQHnFemtOgkuM0+cFfFdlpEqegvhAAueY6VtimGsvNlpK/wZQYjk0EkSep9flF2DWWbMAv61cr5R/OtocsBGo+0PGLGkjTJUml0E0rz1ueFQ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=J9x9ZEkl; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731397561; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=QrGwmL/EZQwRk4LD22fvlkOHU0IkeaUKNMscFX8f1w0=;
	b=J9x9ZEkl3hPePvX8j2T0pRH26LEcJiMJGaWm69ms2kPBJ+jT4UZbNuz2FpWo47vp69QNXKk9J0WiinF9VRQuqUDJIjIo83SB0yz2x5kW14K1F8HVYp9bJiYyg+fehjcgILKjO+L3sGtAsKrX5Q8gTZPGIKqAG9vi+F6ewaER2Bo=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WJGDWo8_1731397559 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 15:46:00 +0800
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
Subject: [PATCH v2 5/5] docs: tmpfs: update the huge folios policy for tmpfs and shmem
Date: Tue, 12 Nov 2024 15:45:52 +0800
Message-Id: <c6a2085278292be8ccc24635ad75b0a59f3cd7dd.1731397290.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1731397290.git.baolin.wang@linux.alibaba.com>
References: <cover.1731397290.git.baolin.wang@linux.alibaba.com>
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


