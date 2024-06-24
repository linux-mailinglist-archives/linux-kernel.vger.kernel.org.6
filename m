Return-Path: <linux-kernel+bounces-227209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238FF914A49
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5424B1C23171
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D57B13C9AE;
	Mon, 24 Jun 2024 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KEKj/I/e"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A0113C671
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719232671; cv=none; b=VIBivFe9f+QFn7OS5UcDTwgitu6nAej45auRKnQCn3rc7fxeEHirX2YHuBo9rS8MkyEw2lQ4JLEcRd5aMlphHmIsZLEfJ4dfFW6BhYVVZ5BOSVSf3QCnrh/76eN1AV4yb6CwaH3tH7WUkLQCLIbCISqHNmnkUuPPdtyjVfCrV4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719232671; c=relaxed/simple;
	bh=h7SBJgprK/PqM3HhStAAvdA5PpzlXX7T8W6H1Jv0SMk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=hU00q8x8P1uY/nJn47q/GqOIN9LVn20y5K5e5X1b6uIa2xotvKmQTmhSp/2JieitjcKW9vsKXwz6M/85x0i9PDcLF1kvPqc6K4mWSpsFzoE5/9UFQGjH2a+MjIxVnD5PtZBCVC2urOOVbRbDFUgi0jo+p0lh27F7CzsMX6G1YC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KEKj/I/e; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f9c6e59d34so35691815ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 05:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719232668; x=1719837468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zbZyZ7fz7ak/B9v8/rQ3CdUP5dwY5kUtPEgHFuTvKOM=;
        b=KEKj/I/eBrcoIQsQGjPeYi93kfsPSZzVEx+aEtBcmfGdqHwWS0o740xczPx3nasmCe
         6tFfGTXzaolM9/CNZ8/n41MsHBPdCaLNRLozAOTiSUQNMvC3VIOuIZ6facFvJXMj4KOS
         3gpqF4OHktG8IbpqWze9V6M9GHKpgC5Ump5LRNNHAHWBPeOt/YKtn3tKuejkvY9OWO4z
         KIvXOjbhCsPUEqM561GtZiIyX0KCrLKCcCUnbIa+utXEySEHi2O+KHxA2DX5ZYkUmHah
         +Gfry+iuvq0xPSG1taHbrKrMfdGH3bBgLFjETWB0fmNcxOBldbXiWoi2C6HGxat9pVA0
         Zjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719232668; x=1719837468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zbZyZ7fz7ak/B9v8/rQ3CdUP5dwY5kUtPEgHFuTvKOM=;
        b=HxGddvNMPnvz6Mnt/flFj0SR+faRosqeZe0q5hNMOGVL4BQl/9LIDJDE1Ef8ZbQPFr
         Uy1VNI+Hlo8pyf5VQKl1bBUGfGlAfF8I/+idw3SpeuolkZJ2f6YTKNyr5cGk0rFVmn85
         OdK57X5OztrIqTzxd27TATFnbim2L1mFJRY9Hy/CABBtzr7k0a6VD6m9beTekvU2VKbj
         0yMngzVCaBDAaQxB/8pLyF3spi+gWIa7ufaJJJfmI+gw0qcGDr4YpAVlimJfGhbKdYHo
         SH7JOvFmKCqajDT1q2QL1FScIEpIyT6hTT6lavY0KwAU0MUDouWiirkSU+YllHHrl6J0
         mmlg==
X-Forwarded-Encrypted: i=1; AJvYcCUd4f7evXupyYnNyQIJwY5m/EHV43iIoMtpits9oSTBJtuD58W6ak1m20ltLdvi6tUNPq29YLpUqsgo5BBOy8iB/cve2RjYnPruWWIy
X-Gm-Message-State: AOJu0Yx0DNj6RCQbTU2gRg15jgit3TpOSsG57gm9M7oEa1X3DGNT3qxk
	lgNJ5XvXqRN3+mVy0kt4cbSgm+o/AjaBZkqkhkjJBXJRhCGls5641LYCT5NJl6o=
X-Google-Smtp-Source: AGHT+IHJ9F4XF7VGHuPvKjcxxMV8vO98uROcYUIEgAeMFW3fBwLSElryc+wH0ZZPa4HI2F5PgJ5AjA==
X-Received: by 2002:a17:90a:ea17:b0:2c2:df58:bb8c with SMTP id 98e67ed59e1d1-2c8581d4effmr3947874a91.18.1719232668592;
        Mon, 24 Jun 2024 05:37:48 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c738c1b741sm8675666a91.1.2024.06.24.05.37.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Jun 2024 05:37:48 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: charlie@rivosinc.com,
	rppt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alexghiti@rivosinc.com,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	dawei.li@shingroup.cn,
	jszhang@kernel.org,
	namcao@linutronix.de,
	chenjiahao16@huawei.com,
	bjorn@rivosinc.com,
	cuiyunhui@bytedance.com,
	vishal.moola@gmail.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] RISC-V: cmdline: Add support for 'memmap' parameter
Date: Mon, 24 Jun 2024 20:37:39 +0800
Message-Id: <20240624123739.43604-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add parsing of 'memmap' to use or reserve a specific region of memory.

Implement the following memmap variants:
- memmap=nn[KMG]@ss[KMG]: force usage of a specific region of memory;
- memmap=nn[KMG]$ss[KMG]: mark specified memory as reserved;

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/mm/init.c | 46 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index e3405e4b99af..8e1d93ae5cb2 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -208,6 +208,52 @@ static int __init early_mem(char *p)
 }
 early_param("mem", early_mem);
 
+static void __init parse_memmap_one(char *p)
+{
+	char *oldp;
+	unsigned long start_at, mem_size;
+
+	if (!p)
+		return;
+
+	oldp = p;
+	mem_size = memparse(p, &p);
+	if (p == oldp)
+		return;
+
+	switch (*p) {
+	case '@':
+		start_at = memparse(p + 1, &p);
+		memblock_add(start_at, mem_size);
+		break;
+
+	case '$':
+		start_at = memparse(p + 1, &p);
+		memblock_reserve(start_at, mem_size);
+		break;
+
+	default:
+		pr_warn("Unrecognized memmap syntax: %s\n", p);
+		break;
+	}
+}
+
+static int __init parse_memmap_opt(char *str)
+{
+	while (str) {
+		char *k = strchr(str, ',');
+
+		if (k)
+			*k++ = 0;
+
+		parse_memmap_one(str);
+		str = k;
+	}
+
+	return 0;
+}
+early_param("memmap", parse_memmap_opt);
+
 static void __init setup_bootmem(void)
 {
 	phys_addr_t vmlinux_end = __pa_symbol(&_end);
-- 
2.20.1


