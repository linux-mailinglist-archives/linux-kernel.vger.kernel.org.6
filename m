Return-Path: <linux-kernel+bounces-309928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B259671FF
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 15:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5741C21339
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 13:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F1817555;
	Sat, 31 Aug 2024 13:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLa3nKUM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72F0AD31
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725112650; cv=none; b=X8Ktxe8PUIEmy9cDx7AicUNKiaXeTJueWnfPcJTm6SgVm873U7Ij+dDf8EdrwmQ4DokgCfOthbl45W94DOTcOMy78CRdccwxWUE2B5ABdJIpMtP+DGAHMz7EaYePKsvcMW31HZGoAKqlvFbrF4t2wd22yI3kbn05j8HmTxZ348I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725112650; c=relaxed/simple;
	bh=XIhYSiuc3CegS9lQeEmgm6zvFmowXPL+aTtFAdFl1F4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VqTVgvj8aavaXi+z/tFfiV9Iz64or7i9WPvAdT6GxTOI6v8V8uXg/sVP2I3Byuu53hPc5rbCCZBIW8gNniiZD9AwbI+vgdxvfSU7WYMr+N27bUtypdpJSgsZEC8pYIGVJ7hPbxZaLz6SbWw+Go+FxYCz3emYnFY0nnDQdnCy31Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cLa3nKUM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725112647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gGvFqBYZ0mJYAL43Kngp1Y2c6axCaBW19/mnkvxliow=;
	b=cLa3nKUMlC8/dClyjdd86ZJy2z88R0kwVRZd2ZlKPlQyyGhNpYOOA7/kmUMawls67lBckO
	Fw1ZzwHNWayAMUONxJVdlksDvlfMqD3yqVygmKeySv4Ei83Fbx0B/0IsQh98GFiY0FDtwc
	nxJjjr8fa5B8uT6pUCmwJf/njnK1hJo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-KSFo2yQNNDOpPMj1Xk7HAg-1; Sat,
 31 Aug 2024 09:57:25 -0400
X-MC-Unique: KSFo2yQNNDOpPMj1Xk7HAg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E13641955F43;
	Sat, 31 Aug 2024 13:57:23 +0000 (UTC)
Received: from llong.com (unknown [10.2.16.3])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 16F411955DD8;
	Sat, 31 Aug 2024 13:57:20 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ridong <chenridong@huawei.com>,
	Waiman Long <longman@redhat.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH-cgroup] cgroup/cpuset: Move cpu.h include to cpuset-internal.h
Date: Sat, 31 Aug 2024 09:57:03 -0400
Message-ID: <20240831135703.881282-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The newly created cpuset-v1.c file uses cpus_read_lock/unlock() functions
which are defined in cpu.h but not included in cpuset-internal.h yet
leading to compilation error under certain kernel configurations.  Fix it
by moving the cpu.h include from cpuset.c to cpuset-internal.h. While
at it, sort the include files in alphabetic order.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408311612.mQTuO946-lkp@intel.com/
Fixes: dd46bd00ab4c ("cgroup/cpuset: move relax_domain_level to cpuset-v1.c")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset-internal.h | 7 ++++---
 kernel/cgroup/cpuset.c          | 1 -
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 8c113d46ddd3..976a8bc3ff60 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -3,11 +3,12 @@
 #ifndef __CPUSET_INTERNAL_H
 #define __CPUSET_INTERNAL_H
 
-#include <linux/union_find.h>
+#include <linux/cgroup.h>
+#include <linux/cpu.h>
 #include <linux/cpumask.h>
-#include <linux/spinlock.h>
 #include <linux/cpuset.h>
-#include <linux/cgroup.h>
+#include <linux/spinlock.h>
+#include <linux/union_find.h>
 
 /* See "Frequency meter" comments, below. */
 
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 13016ad284a1..a4dd285cdf39 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -24,7 +24,6 @@
 #include "cgroup-internal.h"
 #include "cpuset-internal.h"
 
-#include <linux/cpu.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
-- 
2.43.5


