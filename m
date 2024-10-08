Return-Path: <linux-kernel+bounces-355330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7236C9950B9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3C28B25ECD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BFE1DF994;
	Tue,  8 Oct 2024 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="d7+ccx67"
Received: from smtpdh16-2.aruba.it (smtpdh16-2.aruba.it [62.149.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9504A1DF736
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395629; cv=none; b=fLW/Rk/PmQSKdPKyFFXg35pwF3dRtxP1hPOR9uz8rZADcM1ohvHSVtDrvrRgWjlpKDwx5iK8rzJIFZbqjNllC0fpucND1pTcrPWSuVKqXJnkjfXWd0aQ3+aE+JpGpG7rsfmY0HTL0jJWsjdX9SbniqcBfXdUYbdhovq0JNP9puY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395629; c=relaxed/simple;
	bh=cdcJb9H8yy7FXPibF4xVZrLc+VV4/S0BBeF8nOGjdO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=btCJr6TmX7aLEtUCJ/9jJvfWeu7vmghVmsLPbCUOkmIWsCVV6FybN7i/hnez3Q9BoFO9z7a7rZcmlRxIWBgCaCCyU2xRnoxJeSS0StQJj3jAiuVsLWImpNv73Psm4lWfSKtTuEB2ko1zXvyXRjfn593MVGOnTcKSmooUd6uoVus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=d7+ccx67; arc=none smtp.client-ip=62.149.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from polimar.homenet.telecomitalia.it ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id yAbisgixkbsngyAbksUWW3; Tue, 08 Oct 2024 15:50:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1728395437; bh=cdcJb9H8yy7FXPibF4xVZrLc+VV4/S0BBeF8nOGjdO8=;
	h=From:To:Subject:Date:MIME-Version;
	b=d7+ccx67fpCFwxby7OiE7Qs+i6levIS/5JOKtlw3uX0B+j5CSt9vYE0K10LrfLscZ
	 pr2jG4oebUqDOgJojv7X/cK5xkX5OeEORP3hcxEQTg0+zwYH7m+GZ0wItIMjH7TR8K
	 xrujnFMX0M/VghA3/6G12B6GQ8NvaLk/Krw2bTOZ4rdrnb3PQcnHRD5n54WAA86yXl
	 KBMj5EUDCfR/7Mf3S03Ez3OWgVl47m7Q6k0fXDW7gGV31oTl2lDskwWJti3QhB3923
	 kzd0jXSwbDmdqORGmYbq1CPSdeotVW+Z/zB5z++CjAzhLFYvVdmwO1NZYgToFiWvco
	 q6h6114JxuPzw==
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
Subject: [RFC 2/3] Documentation pps.rst: add PPS generators documentation
Date: Tue,  8 Oct 2024 15:50:32 +0200
Message-Id: <20241008135033.3171915-3-giometti@enneenne.com>
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

This patch adds some examples about how to register a new PPS
generator in the system, and how to manage it.

Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
---
 Documentation/driver-api/pps.rst | 40 ++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/driver-api/pps.rst b/Documentation/driver-api/pps.rst
index 78dded03e5d8..c71b3b878e41 100644
--- a/Documentation/driver-api/pps.rst
+++ b/Documentation/driver-api/pps.rst
@@ -202,6 +202,46 @@ Sometimes one needs to be able not only to catch PPS signals but to produce
 them also. For example, running a distributed simulation, which requires
 computers' clock to be synchronized very tightly.
 
+To do so the class pps-gen has been added. PPS generators can be
+registered int the kernel by defining a struct pps_gen_source_info as
+follows::
+
+    static struct pps_gen_source_info pps_gen_dummy_info = {
+            .name                   = "dummy",
+            .use_system_clock       = true,
+            .get_time               = pps_gen_dummy_get_time,
+            .enable                 = pps_gen_dummy_enable,
+    };
+
+Where the use_system_clock states if the generator uses the system
+clock to generate its pulses, or from a peripheral device
+clock. Method get_time() is used to query the time stored into the
+generator clock, while the method enable() is used to enable or
+disable the PPS pulse generation.
+
+Then calling the function pps_gen_register_source() in your
+initialization routine as follows a new generator is created into the
+system::
+
+    pps_gen = pps_gen_register_source(&pps_gen_dummy_info);
+
+Generators SYSFS support
+------------------------
+
+If the SYSFS filesystem is enabled in the kernel it provides a new class::
+
+    $ ls /sys/class/pps-gen/
+    pps-gen0/  pps-gen1/  pps-gen2/
+
+Every directory is the ID of a PPS generator defined in the system and
+inside you find several files::
+
+    $ ls -F /sys/class/pps-gen/pps-gen0/
+    dev  enable  name  power/  subsystem@  system  time  uevent
+
+To enable the PPS signal generation you can use the command below::
+
+    $ echo 1 > /sys/class/pps-gen/pps-gen0/enable
 
 Parallel port generator
 ------------------------
-- 
2.34.1


