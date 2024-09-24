Return-Path: <linux-kernel+bounces-336809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0788984120
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7111F22FE3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B0B1531D2;
	Tue, 24 Sep 2024 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHM24gDL"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AD3149DF0
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168084; cv=none; b=VDVlVVvvf5wG9GhR1TgxmU+jRASIbrnfZ/JYJ8+5b4ZJ/k4UwF7gxBfUYAru+i4rgRDncpZw7cVRYVas0GaYTRLdpf6oefPpZYGoV8YyzN6lzkvdXVA2I3AZUfyKb/Nh2nTXTbxVqq1RejahMFti55PpCtwjtgimX2q7PJlHSME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168084; c=relaxed/simple;
	bh=It8KmbiNVywuJRrNOhlX86pbhNe1mt/pPRIkqV8wzzQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=W+1EAd4lfFohVXsMQQTVF51jBUMrxJ9JdJtyKbKwaMvWvUXgoZlQL1ndrDTVZcJGQQpprwRy0Ma1PwVGCjz5rrAHvbjvgC6aPP2rNfusyVsSppnq11GUsx4tXqnAm50gVx3RLJMckXXVBbr/CmHck9ijwuDoEPHHfSYDQegoFOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHM24gDL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso51657045e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 01:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727168081; x=1727772881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=E8PfYcY31BFyjkya50NQFN5gx01igLjx4gLhGrbptp0=;
        b=QHM24gDLS4ZLasWKEmq3MiU7TNOO75VykGwFHtfX2eGUn0oBAb2xyzUgrVGQ+lOSoQ
         Z0v5GkG/K9CUG0J4Lc9zMvlyDgMhxMH43lHgExvsr9YfjIWf15Wh4XqmNQ2f/FMDNF4u
         PAx0XGpcaMW+gSVZiwt9u8nC2qfzyMxJ5Kunx71JZe2UezWshxV496dewGpgWGbGPDJJ
         9vej5HFln9K+ZDiE8PFUHYl3ELhP0TZ6Ffjoo4w0jaQC+QprMahZ1gt7KijwA3f+FSYU
         S1Ew09yT9TjFxluMDAqwOIvyLgI916WoasFG/oKx6YtNY1N6zBkC0+wbxUV0hhlYikXh
         ZcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727168081; x=1727772881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E8PfYcY31BFyjkya50NQFN5gx01igLjx4gLhGrbptp0=;
        b=QVEuMJREh4tQNX/+OHo//1QXrpLwyGM15oX2YSsESsAh5g/VG79Ad99D8gSM6kv6sq
         LximI8fd5BABp5ZInN0MyuLXt0yvevNKCJMi9gvcdzCZx/XLf9U8QizFP+udCPjSvOBH
         CocAoOe0T3sNhdQl+T1/imjVjJBV1ZT5cTkNhOO9YE7VLVryp8QEGc/gXYIl3+/ENnKy
         ZXQ/4qdaDE6qO6dmR1QA7UylsEe86AzUWbq0KdNYarywQfm+yOHk4pCqSHo1/Wxe5o5q
         MsWmo2TLxB+0SsXCJNP9UZhKJ5vL4q8ssXuJ8xh0q588KBOUWVZ79bhrA8JYZQTf1+6r
         qfYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiulczGGmFPhFPPwdL/d2DfMI0xL6ZNzqozqHQznm7eeCqkwpN1tW+Bg9p2K4DxwKJl7z49PP+nzIj0sA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvc3j+gaByBVIGg//HQeBoTUuvv14WmIpXiSOxoqGk9iwZ+dOS
	S7jo58a+4ZVRlMIRjen3TJkEPlEN4jtfW8pIMmEyA9MxlPveksrV
X-Google-Smtp-Source: AGHT+IElq1z30Aq6Y3sJSrzrvTzKoK5AlyzQkWDVv8hQPMqhTj70joSERnFtQfuPsexeuBUvA1QPfw==
X-Received: by 2002:a5d:4647:0:b0:371:8e0d:b0fc with SMTP id ffacd0b85a97d-37a4315bdd6mr8122763f8f.35.1727168080377;
        Tue, 24 Sep 2024 01:54:40 -0700 (PDT)
Received: from wheatley.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e9029eed4sm15004175e9.24.2024.09.24.01.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 01:54:39 -0700 (PDT)
Received: from wheatley.pinto-pinecone.ts.net (wheatley.k8r.cz [127.0.0.1])
	by wheatley.localdomain (Postfix) with ESMTP id 2966726AB1DF;
	Tue, 24 Sep 2024 10:54:39 +0200 (CEST)
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
Subject: [PATCH v3] x86/resctrl: Avoid overflow in MB settings in bw_validate()
Date: Tue, 24 Sep 2024 10:53:09 +0200
Message-ID: <8d028c5f6f23e92fb83cbf20599366e896abc5b5.1727167989.git.nert.pinx@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory bandwidth value was parsed as unsigned long, but later on
rounded up and stored in u32.  That could result in an overflow,
especially if resctrl is mounted with the "mba_MBps" option.

Switch the variable right to u32 and parse it as such.

Since the granularity and minimum bandwidth are not used when the
software controller is used (resctrl is mounted with the "mba_MBps"),
skip the rounding up as well and return early from bw_validate().

Signed-off-by: Martin Kletzander <nert.pinx@gmail.com>
Co-developed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
v3:
 - use u32 right away without going through unsigned long

v2:
 - actually save the value in the output parameter @data

 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 50fa1fe9a073..53defc5a6784 100644
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
@@ -42,14 +42,19 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
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
+	/* Nothing else to do if software controller is enabled. */
+	if (is_mba_sc(r)) {
+		*data = bw;
+		return true;
+	}
+
+	if (bw < r->membw.min_bw || bw > r->default_ctrl) {
 		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
 				    r->membw.min_bw, r->default_ctrl);
 		return false;
@@ -65,7 +70,7 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 	struct resctrl_staged_config *cfg;
 	u32 closid = data->rdtgrp->closid;
 	struct rdt_resource *r = s->res;
-	unsigned long bw_val;
+	u32 bw_val;
 
 	cfg = &d->staged_config[s->conf_type];
 	if (cfg->have_new_ctrl) {
-- 
2.46.1


