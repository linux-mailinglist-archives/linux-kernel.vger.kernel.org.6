Return-Path: <linux-kernel+bounces-371862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DFD9A416B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92DEC1C2384A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92441FCF6F;
	Fri, 18 Oct 2024 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="fOT+jI20"
Received: from smtpcmd0986.aruba.it (smtpcmd0986.aruba.it [62.149.156.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC4A20E312
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262549; cv=none; b=hiNTxiH0Nz9OyLOemD95QUXpsdzpV45aeGw7ZoukvERPblxCv6WzXaMZIizgGMED+9LSdVgcjtcM6Ay/CzDIXs0W9GtP6wHnUcu7+k8MtGA+OuTeQ8mvCxt0Ec0+4THv6jXpQM8nQ8U5rYDk7AOPKZmR3RVXvevrmab8fPNs5yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262549; c=relaxed/simple;
	bh=L/7lI5InFA2FdeoR5QCDWagzEdB/60JLN6iA+Qyt6+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=owcNMxim+X5jrvcVwbQb/mK6O8tds5P9npmANHyde96XXtHyTDeFFDPf6I8gD/3886tXD2mawL/LXZVN8IDndWUSfBM5F+i1ufY/2r79tYYhhZmv81LzFoDSYPMNF3+Ja9HvTmwobFuXiW3R8FblbvZOsCvq5o8rW15plxOYyog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=fOT+jI20; arc=none smtp.client-ip=62.149.156.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from polimar.homenet.telecomitalia.it ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id 1o8JtbKaEcvwV1o8LtrUBE; Fri, 18 Oct 2024 16:39:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1729262358; bh=L/7lI5InFA2FdeoR5QCDWagzEdB/60JLN6iA+Qyt6+8=;
	h=From:To:Subject:Date:MIME-Version;
	b=fOT+jI20ZByatyzZu6FqG9VJL6UADfEkHFzu4f3bygyfSEJN9n1ArFHWjPC0WzJpN
	 7ueVqzXnwR9Yu1RAL4nJp9ppNK9Yw6xdObGTCGuD2xfB+fkzL5ErBDhiFJQpXL8W5v
	 SJq+qW2BGVWmVHUz7y5jwu16LQpYVMHgTgftyDMMUYSqa69F2JCwtPoj90ksNV5Mqh
	 2yBjhqpO6FVOW+7JYGC4ls78dlCYJSz7h9eHp9Th7euVmjs+RPpz/wexGW/w83iYEU
	 sxmAcrDplWY4vz76It9WTqwhsBLpPpGk47EGEuW8zcsuCVHNmyVczunCQmcL8F3Rcw
	 1K4WJlsly2w4g==
From: Rodolfo Giometti <giometti@enneenne.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <greg@kroah.com>,
	corbet@lwn.net,
	Hall Christopher S <christopher.s.hall@intel.com>,
	Mohan Subramanian <subramanian.mohan@intel.com>,
	tglx@linutronix.de,
	andriy.shevchenko@linux.intel.com,
	Dong Eddie <eddie.dong@intel.com>,
	N Pandith <pandith.n@intel.com>,
	T R Thejesh Reddy <thejesh.reddy.t.r@intel.com>,
	Zage David <david.zage@intel.com>,
	Chinnadurai Srinivasan <srinivasan.chinnadurai@intel.com>,
	Rodolfo Giometti <giometti@enneenne.com>
Subject: [V1 4/4] Documentation ABI: add PPS generators documentation
Date: Fri, 18 Oct 2024 16:39:15 +0200
Message-Id: <20241018143915.3877425-5-giometti@enneenne.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018143915.3877425-1-giometti@enneenne.com>
References: <20241018143915.3877425-1-giometti@enneenne.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJrnHruLi3tY5UzQyuP1rDyaDg/+bwqZDkO0LeUU29FCatvnZx+2biKbcQwlQiAM+3tIzxrridS1H2GE6mADoe23fMmhWK4KyuyheffSfuA/YW7UN7Ez
 hgbxk7eVNSum9UkK3ON30Hsmp+4kBqDy87Sj2MRiTjl3xniglg8eGx1cgK8CfS7Uu3CFKSrNY7frP6oEafPCYt+0yWVpkYTZXIv5bYBIlU/c9ScQouMf3GyA
 wtVUhe0aV1/0/XhvRBIGm+UCyQ1MLH2YKykxjSaLTFd5XvGhSnZStC+23lOlD9qjKLjdjasNsCOxLGXVvG/9eyzmNATQU6rN2SIzvnQmNNqur+LB2vj2lPfS
 LUFhIhJ9C0eOqGd7Gs2fnjsOzjxdGlkjCCWMdtQZi3+uqsCWNelzL80r/Pf5HHShjRDIXpSpUmOEs4l1vXXjxTByWfvdYOCR16CkJbVfxyRKHAw2QcXF4+ur
 khYORs/JK+SMwlLU8u8xjO4QsdD8ktS5tDfxFmbiNRXR4yncdueVdirqVqOoJpGBw4yPgL45uP5x6+ifrMLh6aC4j0iyj48BTe1bjBzVqa9lYOeA/K09Swix
 y2TrMhyaqM2pyGtucEGK9uq5EPzR/4ZghMxTB/xLZbUwsaWOmgAfx/sH8zpYeJYaBTL/7dJEwEPZAbkBFXS2Sbn1m9e4fvkbQASja9w8wCA+0r36rxIrzVNf
 3KoU5wq5fSQBaXQ6IQvj3JET1jHonfP4

This patch adds the documentation for the ABI between the Linux kernel
and userspace regarding the PPS generators.

Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
---
 Documentation/ABI/testing/sysfs-pps-gen | 44 +++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-pps-gen

diff --git a/Documentation/ABI/testing/sysfs-pps-gen b/Documentation/ABI/testing/sysfs-pps-gen
new file mode 100644
index 000000000000..427ba985f413
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-pps-gen
@@ -0,0 +1,44 @@
+What:		/sys/class/pps-gen/
+Date:		October 2024
+Contact:	Rodolfo Giometti <giometti@enneenne.com>
+Description:
+		The /sys/class/pps-gen/ directory will contain files and
+		directories that will provide a unified interface to
+		the PPS generators.
+
+What:		/sys/class/pps-gen/pps-genX/
+Date:		October 2024
+Contact:	Rodolfo Giometti <giometti@enneenne.com>
+Description:
+		The /sys/class/pps-gen/pps-genX/ directory is related to X-th
+		PPS generator into the system. Each directory will
+		contain files to manage and control its PPS generator.
+
+What:		/sys/class/pps-gen/pps-genX/enable
+Date:		October 2024
+Contact:	Rodolfo Giometti <giometti@enneenne.com>
+Description:
+		This write-only file enables or disables generation of the
+		PPS signal.
+
+What:		/sys/class/pps-gen/pps-genX/name
+Date:		October 2024
+Contact:	Rodolfo Giometti <giometti@enneenne.com>
+Description:
+		This read-only file reports the name of the X-th generator.
+
+What:		/sys/class/pps-gen/pps-genX/system
+Date:		October 2024
+Contact:	Rodolfo Giometti <giometti@enneenne.com>
+Description:
+		This read-only file returns "1" if the generator takes the
+		timing from the system clock, while it returns "0" if not
+		(i.e. from a peripheral device clock).
+
+What:		/sys/class/pps-gen/pps-genX/time
+Date:		October 2024
+Contact:	Rodolfo Giometti <giometti@enneenne.com>
+Description:
+		This read-only file contains the current time stored into the
+		generator clock as two integers representing the current time
+		seconds and nanoseconds.
-- 
2.34.1


