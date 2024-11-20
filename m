Return-Path: <linux-kernel+bounces-415738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A828D9D3AA9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3AB1F22CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CD41A0BC4;
	Wed, 20 Nov 2024 12:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTedBPhn"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D7819F104
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 12:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732105751; cv=none; b=gApa12CZuJX64mnVbFK9zQWvWnE7mpjAJd/K2k0L6Tg/jJnDO63xKJ962eim4EwOWudRHuS796nM6L5X92LEmaVksgl14ci9pQ18tuUpzaUPKhENBOzvP//eCeyiLlv7GQQ/U4n4qK3CZktEbipGr816UqaaSMZNF9NOREr2WtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732105751; c=relaxed/simple;
	bh=3iMcYMUpUS0v7mWjPAP0Miv7Jpq0mqEYNhzWh3CJpLI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZH1+OMh9fMgRHB0BFDC5yGPzBq8QHvYuzigkUN+tk0lLg1PsjYdzf+QQEKKvFV7maP8596OUVj37M6TeiUNW9F4q22PXr5EtK1xA0wCYukbOEy1qeOXhSmZ9IhhOHhPg/qqv9JSjdE1iBMjZkLv/9NoPUYSlcaDZjjiJEUj3ddc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTedBPhn; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a6e960fb5dso16736275ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 04:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732105749; x=1732710549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NtOv+NmLL7jaJ88QcCcYp0K03z3WzuUgslz170zMe9w=;
        b=KTedBPhnutjd/fuyhn8X8rJLgFa7gVpzLorb3uQKNuk1CXMUFah32EIJUAQlQvvZBw
         PaLtvTWA9ZDVtlrvj2t1x/LplqT6jNYasrTdmELyo5m3laa5g1jWgGOZP5e+lbSCbdOB
         T5Du0Iv3uzcR5YjFzbfDIAn2Osjf2DJ5aofJHnDHK5ehaQsZKDaL0U/1MxVRtGz7DW6s
         a9htLTjAzeKr24qhlkRpZ3laUOOdKiIq3XJ1oBV212fajcla7pN96Nn45Mjw4BhIwOrO
         zYSIwOoaBof2UookIqsmANa6o/EcOvpuQDdvoAvUYrHJYXVs9AURGs6/1zxL9I8Ihg95
         AO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732105749; x=1732710549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NtOv+NmLL7jaJ88QcCcYp0K03z3WzuUgslz170zMe9w=;
        b=cMzadZ3PxBYQ0Q7T+DI3CqqPx9t1FdZd0zD00rBoTpEbyCMta45r/lpFeeUPCWF3zh
         jqbe3RUyexQXnaBt9EHos/6/Gbz2dTd2/wwab85AKZ2QbaGtH9ssx2FrDpzj2qcUnMgZ
         DYDEi+EwR2yEH4uVSdl6I147yYHAhOESo9h0rb50mXm9Y4xYXeTiMipbH1XZDOQc1irH
         IW+Ya73JYo+ORWmuAUzOrwQwNiJsfdIHf2dztxcX5to5Djbv6sU4RixYdu9BZdY74puz
         fHZwo5oFBNqklQWw+Ynt1C8D6LLjRDYO44zmmRvKPa2rl39we5kuyoxXn04VnbpL5xNh
         8SeA==
X-Forwarded-Encrypted: i=1; AJvYcCXyIHV0B+sjToMP09Pq+Q5n5yrSrplXo0KekbEHd3L4GI8Uo5828ZvBxMV9r7GnhrC0pUgBxIQQEuREPYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHgLAboDso1KreDNv7Ftj976r11bndH0YL6AqN8YglUj7v9xyg
	fy2wAjTXXBfcm93/WzPnA2F7XNmbWfslIlP/cwFf3Vyyfwuzc0QZx/NnCEY0VD8=
X-Google-Smtp-Source: AGHT+IHQbNK5lcJqGeGooQHovbY0rx8rxPlz7DFW/JvyAruFC96YhGWaUcqBSpWfQcWj4vNqz2XwDw==
X-Received: by 2002:a05:6e02:1b0e:b0:3a7:7ee3:10a2 with SMTP id e9e14a558f8ab-3a7865851b2mr28574725ab.19.1732105748679;
        Wed, 20 Nov 2024 04:29:08 -0800 (PST)
Received: from localhost.localdomain ([39.144.106.132])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1c62895sm9479100a12.41.2024.11.20.04.29.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Nov 2024 04:29:08 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: mingo@redhat.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] /dev/mem: Add a new parameter strict_devmem to bypass strict devmem
Date: Wed, 20 Nov 2024 20:28:58 +0800
Message-Id: <20241120122858.22190-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_STRICT_DEVMEM is enabled, writing to /dev/mem to override
kernel data for debugging purposes is prohibited. This configuration is
always enabled on our production servers. However, there are times when we
need to use the crash utility to modify kernel data to analyze complex
issues.

As suggested by Ingo, we can add a boot time knob of soft-enabling it.
Therefore, a new parameter "strict_devmem=" is added. The reuslt are as
follows,

- Before this change
  crash> wr panic_on_oops 0
  wr: cannot write to /proc/kcore      <<<< failed

- After this change
  - default
    crash> wr panic_on_oops 0
    wr: cannot write to /proc/kcore    <<<< failed

  - strict_devmem=off
    crash> p panic_on_oops
    panic_on_oops = $1 = 1
    crash> wr panic_on_oops 0
    crash> p panic_on_oops
    panic_on_oops = $2 = 0            <<<< succeeded

  - strict_devmem=invalid
    [    0.230052] Invalid option string for strict_devmem: 'invalid'
    crash> wr panic_on_oops 0
    wr: cannot write to /proc/kcore  <<<< failed

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         | 16 ++++++++++++++
 drivers/char/mem.c                            | 21 +++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1518343bbe22..7fe0f66d0dfb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6563,6 +6563,22 @@
 			them frequently to increase the rate of SLB faults
 			on kernel addresses.
 
+	strict_devmem=
+			[KNL] Under CONFIG_STRICT_DEVMEM, whether strict devmem
+			is enabled for this boot. Strict devmem checking is used
+			to protect the userspace (root) access to all of memory,
+			including kernel and userspace memory. Accidental access
+			to this is obviously disastrous, but specific access can
+			be used by people debugging the kernel. Note that with
+			PAT support enabled, even in this case there are
+			restrictions on /dev/mem use due to the cache aliasing
+			requirements.
+		on	If IO_STRICT_DEVMEM=n, the /dev/mem file only allows
+			userspace access to PCI space and the BIOS code and data
+			regions. This is sufficient for dosemu and X and all
+			common users of /dev/mem. (default)
+		off	Disable strict devmem checks.
+
 	sunrpc.min_resvport=
 	sunrpc.max_resvport=
 			[NFS,SUNRPC]
diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 169eed162a7f..bfaeefce4709 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -57,16 +57,24 @@ static inline int valid_mmap_phys_addr_range(unsigned long pfn, size_t size)
 #endif
 
 #ifdef CONFIG_STRICT_DEVMEM
+static DEFINE_STATIC_KEY_FALSE_RO(bypass_strict_devmem);
+
 static inline int page_is_allowed(unsigned long pfn)
 {
+	if (static_branch_unlikely(&bypass_strict_devmem))
+		return 1;
 	return devmem_is_allowed(pfn);
 }
+
 static inline int range_is_allowed(unsigned long pfn, unsigned long size)
 {
 	u64 from = ((u64)pfn) << PAGE_SHIFT;
 	u64 to = from + size;
 	u64 cursor = from;
 
+	if (static_branch_unlikely(&bypass_strict_devmem))
+		return 1;
+
 	while (cursor < to) {
 		if (!devmem_is_allowed(pfn))
 			return 0;
@@ -75,6 +83,19 @@ static inline int range_is_allowed(unsigned long pfn, unsigned long size)
 	}
 	return 1;
 }
+
+static bool enable_strict_devmem __initdata = true;
+static int __init parse_strict_devmem(char *str)
+{
+	if (kstrtobool(str, &enable_strict_devmem))
+		pr_warn("Invalid option string for strict_devmem: '%s'\n",
+			str);
+	if (enable_strict_devmem == false)
+		static_branch_enable(&bypass_strict_devmem);
+	return 1;
+}
+
+__setup("strict_devmem=", parse_strict_devmem);
 #else
 static inline int page_is_allowed(unsigned long pfn)
 {
-- 
2.43.5


