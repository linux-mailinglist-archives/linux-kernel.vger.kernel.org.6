Return-Path: <linux-kernel+bounces-329269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4F5978F67
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 11:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800A01C21B14
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 09:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C291CEAB3;
	Sat, 14 Sep 2024 09:20:46 +0000 (UTC)
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911D7145B3E
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 09:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726305645; cv=none; b=IreGCWFLk3xHYLJG8RuqXKx5pFpZ4Ak3xNFZERMCBhdF9ewYL4j4/2phJzeN1780Z0hISOQZM7Dm8OOnpEDvfXj9FhhW+hrdyqIudihFb4/SqcRm4HQPY1Ai4vDhQ7tmxCaoJ5StHoeBOKa/uQQpecEqNovmt4cb4SSiHBWPTyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726305645; c=relaxed/simple;
	bh=UjB9gBf8sJCCXJNqhT8o7ZGjftbmdnamRYlrZhAHKwQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FIa1NXzriwMgq2S5rBfjaNWfDWtn7cVhFTkl4nPVCLwpwsDOrq4Pv7iec6/EPo2+ha7JMPvoEgMO1gV6X7vvnkyYf+/hq1KKOy9L+Z73awFB5wS6nVYEueZG8pBh2LAmGAUGpwX6xN2Iv9Ehq5SNzI6rehXgDZvm3oNOf14ZuEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1726305631-1eb14e31a61061d0001-xx1T2L
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id PDaJvOkdiu51byKb (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Sat, 14 Sep 2024 17:20:31 +0800 (CST)
X-Barracuda-Envelope-From: YongLi-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXBJMBX02.zhaoxin.com (10.29.252.6) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 14 Sep
 2024 17:20:31 +0800
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXBJMBX02.zhaoxin.com
 (10.29.252.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 14 Sep
 2024 17:20:30 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d]) by
 ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d%4]) with mapi id
 15.01.2507.039; Sat, 14 Sep 2024 17:20:30 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.6
Received: from zx4.zhaoxin.com (10.29.8.43) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 14 Sep
 2024 16:53:28 +0800
From: yongli-oc <yongli-oc@zhaoxin.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
	<longman@redhat.com>, <boqun.feng@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <yongli@zhaoxin.com>,
	<louisqi@zhaoxin.com>, <cobechen@zhaoxin.com>, <jiangbowang@zhaoxin.com>
Subject: [PATCH 1/4] locking/osq_lock: The Kconfig for dynamic numa-aware osq lock.
Date: Sat, 14 Sep 2024 16:53:24 +0800
X-ASG-Orig-Subj: [PATCH 1/4] locking/osq_lock: The Kconfig for dynamic numa-aware osq lock.
Message-ID: <20240914085327.32912-2-yongli-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240914085327.32912-1-yongli-oc@zhaoxin.com>
References: <20240914085327.32912-1-yongli-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 9/14/2024 5:20:29 PM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1726305631
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1614
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.130433
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

The make menu to choose if compile the dynamic numa-aware osq lock
or not, default is N.

Signed-off-by: yongli-oc <yongli-oc@zhaoxin.com>
---
 kernel/Kconfig.numalocks | 17 +++++++++++++++++
 lib/Kconfig.debug        |  2 ++
 2 files changed, 19 insertions(+)
 create mode 100644 kernel/Kconfig.numalocks

diff --git a/kernel/Kconfig.numalocks b/kernel/Kconfig.numalocks
new file mode 100644
index 000000000000..feb1751b637c
--- /dev/null
+++ b/kernel/Kconfig.numalocks
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+menu "NUMA Lock Supporting (OSQ)"
+
+config LOCK_SPIN_ON_OWNER_NUMA
+	bool "Enable dynamic numa-aware osq lock"
+	depends on LOCK_SPIN_ON_OWNER && X86_64
+	default n
+	help
+	  According the cpu numa architecture, the numa-aware lock
+	  always unlocks the process waiting on the same numa node
+	  first. It is different from the kernel inbox osq_lock.
+	  The dynamic numa-aware osq lock switchies between osq_lock and
+	  numa-aware lock automatically, according contention level.
+	  Enable: echo 1 > /proc/zx_numa_lock/dynamic_enable.
+
+endmenu #  NUMA Lock Supporting
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 27539c2626bf..eb2314d47420 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1337,6 +1337,8 @@ config DEBUG_PREEMPT
 	  depending on workload as it triggers debugging routines for each
 	  this_cpu operation. It should only be used for debugging purposes.
=20
+source "kernel/Kconfig.numalocks"
+
 menu "Lock Debugging (spinlocks, mutexes, etc...)"
=20
 config LOCK_DEBUGGING_SUPPORT
--=20
2.34.1


