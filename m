Return-Path: <linux-kernel+bounces-219197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BA890CB2A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AFB51C21167
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CE512D1E7;
	Tue, 18 Jun 2024 12:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EoN+B/8k"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1122312B143
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 12:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718712538; cv=none; b=TDPOXa59h+wuK9aIikNhbOvELoFiNIJHLx6gosf8usPKmsxN82xZmDg5JxNwDzLhMcNUBZUsq6l1WwWeP+5RixokzLRLhvkxTmkXnYWgbJg7vchTy8uD9XUzS6/Qhl7SChAMahHviEVdz6nMcHRZvvLGx50uxBP6Kl3vqxSiD+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718712538; c=relaxed/simple;
	bh=ZzBmKuEEkth/YRBQ8vefOsJT/hSbve7kia0zeEt9PEg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=UIVYOEtiJ1z+ticcb1Rf3evMBXxsgsTcueMOzgsE1qNQ7Ys1ubAebQsTvA/POeAuiKwcl1Q32OI2H8BjUgfJhmGFNKI0mqweAOg9p3/leYRJHKU+rrKxR+V9NMfPguUtqFIPxUC/+aNJXwr5t/3fTZQ6W8BoXONSfEGsQ0kwb+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EoN+B/8k; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70623ec42c2so240216b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 05:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718712536; x=1719317336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jb3JocXcPiCbvg54IdlUeWbprQs3KRQNAcfXzKSxCzo=;
        b=EoN+B/8keV7z5jiBZLMWmB1tfwlMCX+/CGohO3Vg/zLNAg9GpYm+WunkpPoVZgaPCp
         YJbMMy3zDGQA0/7rWKOgeeLm6xFj17K1J390ZI1HctPwv4aG/le8OnOV9qttnwC1eueL
         u9dIa+Gl+2lTM7GwO9fVRCed9AljEkrp1tQjUS6De1gjtVTf7M/IG64MOY4yZOEHF8y+
         9GOrC5MEN1f6EtVC4amCQUPrqFZAzOMAa/O+WTy1iF2Qak0Av8kWUZ6mOGIDKXxhFj4I
         Slbmb5Xn6O3YFUVeOJ9MDqF1vyK30E90MuySiTQ8w0T4UQMYHs2jZChpyXGSlBn4Xm79
         ivsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718712536; x=1719317336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jb3JocXcPiCbvg54IdlUeWbprQs3KRQNAcfXzKSxCzo=;
        b=NAYc4hfbcTG+nBKYILfDHGVhl4V2xxQdBQ//zWgcXwQBILo0BLYi5oXeMObnYtXuDK
         oAJCaoRmVdfNZuJ14lKUFqC9BPS1MOrjl7P7p8yYnfw5ucSpDLI/3DqNl5R5h3zhCIh9
         sacQJZuPM5OgDJ6scddyhvxlD2u1e9uqo2WWpilGpTzyL165KygZyiTCgqMuqtwH03ZH
         OgXqHO/gZ7ic0B6Q//I56KJaUTrvQp1/g+Hva1y2i/15NEDRujUdcrX5EU7m5ZfwnoAD
         VlRlIPuO0oGR3epfD+Kh5y2MqjqQwsOkEI+jcv9UVH7I8xAP22x8Gl3Wto1s6kGbLZLV
         gZqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVidm/tV0Wv1t+XH/QbfIu2RgeDSq3HfncKxcZNgv7rptKrzaOM0ZTufXselgKcJEK5ue3JJoDAflHKvJJtsZD+3+Ph8T4nGsVAjyk0
X-Gm-Message-State: AOJu0Yw8ZXspW1025h0r9lYCtaU5t2GOtd7m0RADFAhPix5XgwUDwsTk
	Q8hD2f6Z56c/j0kldTAtBEztg2186DN+qQiw0oPndFabRcnL6mr53ylCd4YXU5o=
X-Google-Smtp-Source: AGHT+IGPDDLTRJt3JTj42pXv8laxMbqSrwxMqulIK7TC6bhLPFsR8V1mfHcuYeDyepiUmjYmIbzU4A==
X-Received: by 2002:a05:6a00:8f03:b0:705:d2da:62ae with SMTP id d2e1a72fcca58-7061ac2e94amr3241529b3a.16.1718712536276;
        Tue, 18 Jun 2024 05:08:56 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb4c621sm8853029b3a.115.2024.06.18.05.08.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Jun 2024 05:08:55 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alexghiti@rivosinc.com,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	rppt@kernel.org,
	dawei.li@shingroup.cn,
	jszhang@kernel.org,
	namcao@linutronix.de,
	chenjiahao16@huawei.com,
	bjorn@rivosinc.com,
	cuiyunhui@bytedance.com,
	vishal.moola@gmail.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RISC-V: cmdline: Add support for 'memmap' parameter
Date: Tue, 18 Jun 2024 20:08:42 +0800
Message-Id: <20240618120842.15159-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement support for parsing 'memmap' kernel command line parameter.

This patch covers parsing of the following two formats for 'memmap'
parameter values:

- nn[KMG]@ss[KMG]
- nn[KMG]$ss[KMG]

([KMG] = K M or G (kilo, mega, giga))

These two allowed formats for parameter value are already documented
in file kernel-parameters.txt in Documentation/admin-guide folder.
Some architectures already support them, but Mips did not prior to
this patch.

Excerpt from Documentation/admin-guide/kernel-parameters.txt:

memmap=nn[KMG]@ss[KMG]
[KNL] Force usage of a specific region of memory.
Region of memory to be used is from ss to ss+nn.

memmap=nn[KMG]$ss[KMG]
Mark specific memory as reserved.
Region of memory to be reserved is from ss to ss+nn.
Example: Exclude memory from 0x18690000-0x1869ffff
memmap=64K$0x18690000
or
memmap=0x10000$0x18690000

There is no need to update this documentation file with respect to
this patch.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/mm/init.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index e3405e4b99af..7be7ec3092ad 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -208,6 +208,56 @@ static int __init early_mem(char *p)
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
+	case 0:
+		memblock_reserve(mem_size, -mem_size);
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


