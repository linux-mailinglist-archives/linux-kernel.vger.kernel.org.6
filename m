Return-Path: <linux-kernel+bounces-343475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5A2989B5C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35CE81F22153
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E21A155346;
	Mon, 30 Sep 2024 07:24:54 +0000 (UTC)
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0B21547F0
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727681093; cv=none; b=E6mMiXCxFMeN6+4klX/JJdkXhga5sMDKIuGDbXbLeLmRMxBRb3Wcoq9ff+NsMiRMhpVAUziez3FoDInlXMnV5YmlO/OB+KGW4/PD4xsdsBgsciZU9aVCvqLdb/mqC5qlskctNzvWHIUqMcyDT2ErXKVDBfQ4G78Aviu6X0Ow7SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727681093; c=relaxed/simple;
	bh=oQI1Wz8AgGMdI1DVBdYLWQf2tPZrSIXZveWfGFzELmo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hHmJ2yCBw1gtOfO00+R7WGLOJuodir5rtJRlnSd3vDql0RGTtCGgph4/hvv1exVNcRModvExdDGkebDPmJ/QB0XxS+D0O2I7P2i7RTyrH0DcY28aIdKKYzmhRz2b7JHzmozWyYz1HXhn2GyYx9VFnMctD+dHeAAy5ACb+c2sBro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1727681080-1eb14e31a6126b40001-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id z54oDQQBXNGMb2oT (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 30 Sep 2024 15:24:40 +0800 (CST)
X-Barracuda-Envelope-From: YongLi-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXBJMBX02.zhaoxin.com (10.29.252.6) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 15:24:40 +0800
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXBJMBX02.zhaoxin.com
 (10.29.252.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 15:24:40 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d]) by
 ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d%4]) with mapi id
 15.01.2507.039; Mon, 30 Sep 2024 15:24:39 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.6
Received: from zx4.zhaoxin.com (10.29.8.43) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 15:23:55 +0800
From: yongli-oc <yongli-oc@zhaoxin.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
	<longman@redhat.com>, <boqun.feng@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <yongli@zhaoxin.com>,
	<louisqi@zhaoxin.com>, <cobechen@zhaoxin.com>, <jiangbowang@zhaoxin.com>
Subject: [PATCH v2 1/3] locking/osq_lock: The Kconfig for dynamic numa-aware osq lock.
Date: Mon, 30 Sep 2024 15:23:53 +0800
X-ASG-Orig-Subj: [PATCH v2 1/3] locking/osq_lock: The Kconfig for dynamic numa-aware osq lock.
Message-ID: <20240930072355.2892-2-yongli-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930072355.2892-1-yongli-oc@zhaoxin.com>
References: <20240914085327.32912-1-yongli-oc@zhaoxin.com>
 <20240930072355.2892-1-yongli-oc@zhaoxin.com>
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
X-Moderation-Data: 9/30/2024 3:24:38 PM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1727681080
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1610
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.131164
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

The make menu to choose if compile the dynamic numa-aware osq lock
or not, default is N.

Signed-off-by: yongli-oc <yongli-oc@zhaoxin.com>
---
 kernel/Kconfig.numalocks | 17 +++++++++++++++++
 lib/Kconfig.debug        |  1 +
 2 files changed, 18 insertions(+)
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
index 27539c2626bf..cf9344eb61a4 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1337,6 +1337,7 @@ config DEBUG_PREEMPT
 	  depending on workload as it triggers debugging routines for each
 	  this_cpu operation. It should only be used for debugging purposes.
=20
+source "kernel/Kconfig.numalocks"
 menu "Lock Debugging (spinlocks, mutexes, etc...)"
=20
 config LOCK_DEBUGGING_SUPPORT
--=20
2.34.1


