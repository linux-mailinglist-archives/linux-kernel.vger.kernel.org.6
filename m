Return-Path: <linux-kernel+bounces-345816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5E098BB75
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE3D01C235A4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693521C1725;
	Tue,  1 Oct 2024 11:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjAgC3K0"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CF61C0DFD
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727783056; cv=none; b=S3TwOZYv3Xhy6Sw/yd3ae5yvrOrcfRBsBytP90URlRSP23rUKdTUoEKyc3Q38GxmK4F2d5KqnqMDs24Ug6AeSemw0eEP8BaIMwZRFMXJF1aOgDL+PWnTZw6KJhzYD20zr1r3zIkTy1HOuXpmnusEy8ti6ioKkS9BjKA6jn22nX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727783056; c=relaxed/simple;
	bh=JSWgRqDtMC6o8jXAzgMhgEMgegxVy+BDmFdQJs6enCI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NhMDOynLfiN4neCRHj3mXvLXSQqDiFDZrlZcRWI+Ces6QUWNLo/jFDjx3xo7ns9TZAw9ToIc9NVDjWkI5W0equy3tV8ob0Ok8WCZyl81fBBwCKoqNbCvzx3pCukSI9tKEzWHj4LSpjduOzwY8nOKRRKxbbYWbjYZJGNQHXULq4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjAgC3K0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cc8782869so49996165e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 04:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727783053; x=1728387853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hE8HfYVLQDsZ3wtBhSvRBEn+QK2WZJr3IsyjzHlvzXQ=;
        b=OjAgC3K0rCLDfanVD+5QLj1UsUXgb/D1ZXtq3U7nu7c5AT23BvIem1ewKQVlDKNoqO
         7BmEeVEn/MxoqJ6ffOhBkq7Tr5sWj0dxrOiriqovyNww6dRlJG81Que5GUiYUgIGSA3Q
         8TYPbh8e9NPC5LFuGsNNX/IuSo0z0aMZk8+wPzZNOb3rqKKQ+BMHA/rjx8fbsETG1UfY
         Y4aE9ZvPk/b+f9i62WqfjcwSdePvit0EEg5dMNpN4NXJEziymekYjk3SYOHzwDJayNsh
         8ILPJUi5cM1nKqc0w1vkKNsHQsYsVynVenAwfgC2IJ4Jb4Q+LbFSaz1CffAg0qSTKOZI
         ZxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727783053; x=1728387853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hE8HfYVLQDsZ3wtBhSvRBEn+QK2WZJr3IsyjzHlvzXQ=;
        b=hb7dzQidZBQ9zi2sk4MDXNx8lDTSqb5ZzAZfmsX8Q86NOrui0bIHUbSKmD5TscTbqV
         ssQAkIPG4Uutgd7IyvO+pCT2HFgy4NzP0uPllnzo0AGGU/YzceMOJvED/IlBNXn8OBRS
         n0UoK+6y+R5+eLOZbS/jzuCR88igKAoTSW6icc0fohb574+koS4O5hhkk3uiZtL3+4M8
         Fw+q2vZORNrgbsmUOqoDSYbhxY1av5n+iDlVwxAUKMhtEO1aA69x4e1wLcTmK/DdNlV1
         LWKcS0K6PeEH6wliwCQRfiMrloPtXcrKtfwW5136bWCPdUyufygxse1Tz+TkN2h6BNJm
         YEMg==
X-Forwarded-Encrypted: i=1; AJvYcCWUJ+qogJd/ElNu4e21Jw9mIAC+a7fr68ptNkXF3rCpDsZYEC7ukuGWRWrJxOAw1+O5jI5QKbJWCmFpDrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2ulNxmqb0Rt0X5HhrHgEnDrUOFPDdzvaHDDwUa6qRtrn95Pf2
	eB4Tpswn5CGf//u31Z+fmloxRh2QRjoqA1v82a6kNsCnfjN+1mT4
X-Google-Smtp-Source: AGHT+IGeDz8l92SuJjN7soj2lj2UDtxw6eV6hAuz1M4Uk0QCQjAVN/YVLw0GN6nEogHPSEHosnzvVg==
X-Received: by 2002:a05:600c:4e8f:b0:42c:b950:680b with SMTP id 5b1f17b1804b1-42f5844b9e9mr105142045e9.20.1727783052716;
        Tue, 01 Oct 2024 04:44:12 -0700 (PDT)
Received: from wheatley.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57d31283sm131012725e9.0.2024.10.01.04.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 04:44:12 -0700 (PDT)
Received: from wheatley.redhat.com (wheatley.k8r.cz [127.0.0.1])
	by wheatley.localdomain (Postfix) with ESMTP id 151F62C626B7;
	Tue, 01 Oct 2024 13:44:11 +0200 (CEST)
From: Martin Kletzander <nert.pinx@gmail.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] x86/resctrl: Avoid overflow in MB settings in bw_validate()
Date: Tue,  1 Oct 2024 13:43:56 +0200
Message-ID: <a8c3ef3e3d35924781280064a9f8c7dd2ee60565.1727782826.git.nert.pinx@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The resctrl schemata file supports specifying memory bandwidth
associated with the Memory Bandwidth Allocation (MBA) feature
via a percentage (this is the default) or bandwidth in MiBps
(when resctrl is mounted with the "mba_MBps" option). The allowed
range for the bandwidth percentage is from
/sys/fs/resctrl/info/MB/min_bandwidth to 100, using a granularity
of /sys/fs/resctrl/info/MB/bandwidth_gran. The supported range for
the MiBps bandwidth is 0 to U32_MAX.

There are two issues with parsing of MiBps memory bandwidth:
* The user provided MiBps is mistakenly rounded up to the granularity
  that is unique to percentage input.
* The user provided MiBps is parsed using unsigned long (thus accepting
  values up to ULONG_MAX), and then assigned to u32 that could result in
  overflow.

Do not round up the MiBps value and parse user provided bandwidth as
the u32 it is intended to be. Use the appropriate kstrtou32() that
can detect out of range values.

Fixes: 8205a078ba78 ("x86/intel_rdt/mba_sc: Add schemata support")
Fixes: 6ce1560d35f6 ("x86/resctrl: Switch over to the resctrl mbps_val list")
Co-developed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Martin Kletzander <nert.pinx@gmail.com>
---
v4:
 - format the u32 variable properly
 - use better commit message

v3:
 - use u32 right away without going through unsigned long

v2:
 - actually save the value in the output parameter @data

 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 50fa1fe9a073..200d89a64027 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -29,10 +29,10 @@
  * hardware. The allocated bandwidth percentage is rounded to the next
  * control step available on the hardware.
  */
-static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
+static bool bw_validate(char *buf, u32 *data, struct rdt_resource *r)
 {
-	unsigned long bw;
 	int ret;
+	u32 bw;
 
 	/*
 	 * Only linear delay values is supported for current Intel SKUs.
@@ -42,16 +42,21 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 		return false;
 	}
 
-	ret = kstrtoul(buf, 10, &bw);
+	ret = kstrtou32(buf, 10, &bw);
 	if (ret) {
-		rdt_last_cmd_printf("Non-decimal digit in MB value %s\n", buf);
+		rdt_last_cmd_printf("Invalid MB value %s\n", buf);
 		return false;
 	}
 
-	if ((bw < r->membw.min_bw || bw > r->default_ctrl) &&
-	    !is_mba_sc(r)) {
-		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
-				    r->membw.min_bw, r->default_ctrl);
+	/* Nothing else to do if software controller is enabled. */
+	if (is_mba_sc(r)) {
+		*data = bw;
+		return true;
+	}
+
+	if (bw < r->membw.min_bw || bw > r->default_ctrl) {
+		rdt_last_cmd_printf("MB value %u out of range [%d,%d]\n",
+				    bw, r->membw.min_bw, r->default_ctrl);
 		return false;
 	}
 
@@ -65,7 +70,7 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 	struct resctrl_staged_config *cfg;
 	u32 closid = data->rdtgrp->closid;
 	struct rdt_resource *r = s->res;
-	unsigned long bw_val;
+	u32 bw_val;
 
 	cfg = &d->staged_config[s->conf_type];
 	if (cfg->have_new_ctrl) {

base-commit: 7424fc6b86c8980a87169e005f5cd4438d18efe6
-- 
2.46.2


