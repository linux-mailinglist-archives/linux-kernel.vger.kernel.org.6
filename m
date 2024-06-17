Return-Path: <linux-kernel+bounces-217369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FD290AED1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DA22B282A7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF795195985;
	Mon, 17 Jun 2024 13:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="R4hQBs5j"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7CE197A9E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630082; cv=none; b=S/GkEoDAILHERUE6p3HOCf9SObPrED0gKfX9qJehkKBpZC4UYOfk4Q3SgORXBkG8ox4PkFck4JVbuS/OijVKGlj28vUmdQr0JibMLWYT+OwcpoURfBi6MRc7AZJvu4CGWMO/fkdXYM4RfrcQjql8RZCDpsvORESPpyKGbmBKG0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630082; c=relaxed/simple;
	bh=+JzJj8ucCazBC6mptHHx0+nGx8xyX4nB++98g/I1ZdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cTUGtjJgCsD6peiyDB3gHMwxmpeP+b4/T0SSGw1AttwFsFaIo0NVwXEVtaNS4PGdUijX4hC2sEwkftFKB5D9hjPSKFl+tkU3iaaY+oLenthiUPM06M7F7bEgV3n4XpB0FvjW0rkyy0RQnkEB0wYR0bQryr0I0rgXjUdY0ycqD3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=R4hQBs5j; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-703ed15b273so3285560b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718630080; x=1719234880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/f2nZESk5IwUhjcBCwDQD5m6WSIwM88cL3SwI9ltT4Q=;
        b=R4hQBs5jjD109BAZ583iZIwha7pp0epmdo/8HFEmMY3Rz5wKmtFi2RCscf5XBFi0yZ
         Ucz8hpFI5v+J8A4cfP8Pr8LDfa4ke3DY/KHmZTLigRe5latAO7g3tw7op8gM5evlIYVt
         CiHUJbj8EdvNSFgOlcgdIbwV8+ju2zLdI+3tdDSqXmaBYvgKVGYCkJHvXRB2KEqpZW+r
         VPd1jk939uRY8oA8TNSfsxx6s74AqO2GIkTayeQStoUN112n+W3YqTQiuws9lQ4vUriJ
         AC6EXoLGLx3PQRux0hwlz70uYG/POO4gsEaSidIAdfz528SaffQDpuaj1Ay+hftGrvCP
         35Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718630080; x=1719234880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/f2nZESk5IwUhjcBCwDQD5m6WSIwM88cL3SwI9ltT4Q=;
        b=TTr68QmOZ4zeFAlCOwHjDURluMcsq1Xx94LUbLv9CTnYIWvNyotEGIl5Ss++52ajcM
         SSPYTH8Sb4ivSm+914uAcK7VbCpT5oxWhB2/ymy1LpXcRciqCasR4SB0T2+0lKyt0Qci
         ymQjdKiPvzo54Vin5Ziv4hu+9o3ZaAN7UVV1eseugMsrgZFpC8go+pAaWjDD7zfm3yBB
         ROwGMQtKFFuNM/DPAidpI82w/d8fNhN5RAElZU6aOtqiRAzLk4NTRqfePGrjRSIbRPQo
         WfqGnSIlBjk4hKQroTTv9JHDi8IUTb7gAz2vSeFeJovGH8PXaYMg+cHy3na78msWylsG
         Zlkw==
X-Forwarded-Encrypted: i=1; AJvYcCXb3/FQubI2oDcDxTwdYRjQup4inVZuHC/akS4vcAjqWGf7ztEih5lf9RkhhP1YY2AJ8Up5tO1zBwA0H/zH8D5mcfIpH9VJ/LtpUXjt
X-Gm-Message-State: AOJu0YyQBkK6LCV2/GGBoFEjptUYqEBEXVkcz40BIh8Lhxiil2nKJOJl
	vGbRWjCGKqKDvyKb24MEH8pnF0dEXr1VQOXqzzYVTfUWt6RjI/wlPzmRDeQbhOg=
X-Google-Smtp-Source: AGHT+IFyXVXcwEnHkFr+M+B09gwoggwiZPCR+TNh4urQv2uHfL8+aZj9PiLWU/sney1s+CzXzICoGA==
X-Received: by 2002:a05:6a20:6597:b0:1bc:a4c5:445b with SMTP id adf61e73a8af0-1bca4c54494mr873421637.24.1718630079903;
        Mon, 17 Jun 2024 06:14:39 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f0260csm78801785ad.200.2024.06.17.06.14.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Jun 2024 06:14:39 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	sunilvl@ventanamicro.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org,
	bhelgaas@google.com,
	james.morse@arm.com,
	jeremy.linton@arm.com,
	Jonathan.Cameron@huawei.com,
	pierre.gondois@arm.com,
	sudeep.holla@arm.com,
	tiantao6@huawei.com
Cc: Yunhui Cui <cuiyunhui@bytedance.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 2/3] riscv: cacheinfo: initialize cacheinfo's level and type from ACPI PPTT
Date: Mon, 17 Jun 2024 21:14:24 +0800
Message-Id: <20240617131425.7526-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240617131425.7526-1-cuiyunhui@bytedance.com>
References: <20240617131425.7526-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before cacheinfo can be built correctly, we need to initialize level
and type. Since RISC-V currently does not have a register group that
describes cache-related attributes like ARM64, we cannot obtain them
directly, so now we obtain cache leaves from the ACPI PPTT table
(acpi_get_cache_info()) and set the cache type through split_levels.

Suggested-by: Jeremy Linton <jeremy.linton@arm.com>
Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/kernel/cacheinfo.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 30a6878287ad..d6c108c50cba 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2017 SiFive
  */
 
+#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/of.h>
 #include <asm/cacheinfo.h>
@@ -78,6 +79,27 @@ int populate_cache_leaves(unsigned int cpu)
 	struct device_node *prev = NULL;
 	int levels = 1, level = 1;
 
+	if (!acpi_disabled) {
+		int ret, fw_levels, split_levels;
+
+		ret = acpi_get_cache_info(cpu, &fw_levels, &split_levels);
+		if (ret)
+			return ret;
+
+		BUG_ON((split_levels > fw_levels) ||
+		       (split_levels + fw_levels > this_cpu_ci->num_leaves));
+
+		for (; level <= this_cpu_ci->num_levels; level++) {
+			if (level <= split_levels) {
+				ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
+				ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
+			} else {
+				ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
+			}
+		}
+		return 0;
+	}
+
 	if (of_property_read_bool(np, "cache-size"))
 		ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
 	if (of_property_read_bool(np, "i-cache-size"))
-- 
2.20.1


