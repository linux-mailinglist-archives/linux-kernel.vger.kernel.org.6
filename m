Return-Path: <linux-kernel+bounces-355331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C5D9950B8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E081B2621A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BA71DF993;
	Tue,  8 Oct 2024 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="jV6wqAvy"
Received: from smtpdh16-2.aruba.it (smtpdh16-2.aruba.it [62.149.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7CD1DF25D
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395629; cv=none; b=FlyQEYBFBgOGg8lorE48/CYTFyBHH+yWTBZk4EBAeedGgEs8B4a47VUohprw1L3hxQFZrP1wGYqPwbqFtJZ66a5oOUFPSXhXrJVfAelLuXAjbybHjswqP0jUkgAEzbpgdrnwgkHyChDDz9DgGyYl86GiUFIVMr+KbCEsY1sLPiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395629; c=relaxed/simple;
	bh=VyRvpnQ3XBxkjfPAZbExFDOfmuIPnnj3g+LyGrP/bnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LUJ8AWZxN/heAgcVCzUGUhPfQZui/YciDaVExFVO3wSVWlZ70csLLIglL4lueN02bihCqrk7nR2HL3p1lkN+dhYAKX0b36dfnizQWhrGmKXC9YhUNLM0nH3zXQi49qHz4WMChaJJzWoBYfdW3dYC/0+DoiFO+pTiZNihc9YxGxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=jV6wqAvy; arc=none smtp.client-ip=62.149.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from polimar.homenet.telecomitalia.it ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id yAbisgixkbsngyAblsUWWf; Tue, 08 Oct 2024 15:50:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1728395437; bh=VyRvpnQ3XBxkjfPAZbExFDOfmuIPnnj3g+LyGrP/bnk=;
	h=From:To:Subject:Date:MIME-Version;
	b=jV6wqAvyLsgEW+vzvJ2ntqZFPDEYpNZTn8rnElfOAr/gWD18sx6HyBMzgHYuSgNAM
	 Ckq4ig9BmT44Hgg039Mx/D/47zFKfxtvPe6+9DgB7ycqqvXYs5L8Z9Fv3gzAHE51OY
	 sunm92uPdegqsb98zDtA5n5LxZMa6KxYmHRqAERJmd/f3q8iX43W/FrdJKzxyxTJYi
	 Z8e2/wBLb3zG4uUFyYOcdGpq9usd2nVE/95GXYW+giZv3RJVVYzt2pSfq57XwuGCH1
	 J6SQEHlsrU38q/7rTTiWHVo+A87GgRUljn97GME13MMaqCy7N8FxF+3Ds+ALoTkbYd
	 P96lxjM+y68Nw==
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
Subject: [RFC 3/3] Documentation ABI: add PPS generators documentaion
Date: Tue,  8 Oct 2024 15:50:33 +0200
Message-Id: <20241008135033.3171915-4-giometti@enneenne.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008135033.3171915-1-giometti@enneenne.com>
References: <20241008135033.3171915-1-giometti@enneenne.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfP5U7jx3B81F686kX4T4Oiv6i3eEj04luOg7Go0TsFKHNeWefdCGahxXs0bq0y6bSAWVQDwGt9M/FTkV8o0S1xmz+8C29+HJ5eAN3J/Ool1mKM2VW8eo
 M5v9h8m/zApegAdfFXMXCQoErVNyLTD6QuIPWpVAZ5TVr9HDfQDl14EhVYkTex8FD5vPRyANzCfMkR+Hid6RaO4OiwyxnJhqSheZ7737DcNo2lCOc04sdCfs
 ponx0u1zOFt3ED3zu/pUY/su66i/8mgox0dmQsvNIdoLeWG7gcSmc1ZDftYSDHyX+tyJ8MrAsB+eG+8odaRF6XS+QQSB4Qofhf8x0JMjNrgaf+ITOwG5rdFR
 xdrjJRCXnwNoVb1wqpmYqh7nVToNYOfgy4+ofLtTqf0Id6aUTHlWd9rJ/SRMcRcHSDODw/4CB5nQArEsFPYvJQixTgCtvTN2Q9eibw/ASbxuYcrDgQnig4V/
 AJx8Aqz1YeiwWNuDcgtq0hqFo9VRWqgNIk2KQ9csg8qz39TXnsN0jIKdhp2vZPgoLvejAY5mIpoig8jaXSu3lLzBSyhnpNME4o0UDBXXcBP8o/0FcDW7Zttg
 3iSYkdSRTrJRkUMqGjAcMmdBwZ1Ezrnnl1/ZMsvl6KZbl1LKbad8ks5enQqbx7hi6tlu1Oa2BUMunO24F/K7aOIMb2h+yO1mSNZyK6OBnreG40wgs0HYejzM
 vxN2uIEVsCt3MjVbyQpyXMXvHcR6tM8i

This patch adds the documentation for the ABI between the Linux kernel
and userspace regarding the PPS generators.

Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
---
 Documentation/ABI/testing/sysfs-pps-gen | 44 +++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-pps-gen

diff --git a/Documentation/ABI/testing/sysfs-pps-gen b/Documentation/ABI/testing/sysfs-pps-gen
new file mode 100644
index 000000000000..9ad066cb3ce5
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


