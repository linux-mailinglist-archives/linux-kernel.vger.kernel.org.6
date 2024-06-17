Return-Path: <linux-kernel+bounces-217370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5609490AED3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C32A1F27BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B630C197A9E;
	Mon, 17 Jun 2024 13:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="APqNQZsQ"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DBF197A7A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630087; cv=none; b=g9in0WGZmfOVksy0l3cYiVNQvUrJpsmdGXiN66jtqgrWqpfN+iYf6IPorfPclIJ+N0B9WSWfoxzim8Lwwn4pfmUEUB391aR1OYz53uOCkN3t2tOTSrXqr5ZqQeD7KtVq+CXRNCVRxPiRj0iWhUa/kl6VFdWwA1e4udUrDMFWeOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630087; c=relaxed/simple;
	bh=OCESIZEsN6lzcI6fYlcJjhkKfQLZHYvy2cJISU/VEiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bp5skGNm4JaTb6QNwTDAIjkzgg8PQChShRFXGHuBy7K+jchqYGSVRWZJNZYHEa3Zz7ktoAcxL/62PkyEMZfcMUJm4I7z/99drVsuPohTRzL/OnYiaiD/+n2w+RIzmUKc04AE+NuCxK6a6rryFsLBYj4nTbf8Z6GMMCkLFpuU91M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=APqNQZsQ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70423e8e6c9so3791115b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718630085; x=1719234885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqH5PnYnV4OCHciC6unnqcv3QJd6vOkUagh67OcQSZo=;
        b=APqNQZsQWZBAkMN6ajq9Lnefzr38sgZdKH9AZnIzsdeNhZfXlEv246aIx3yB1Jy3as
         oSrgO35J1tuEH5mteCnb7WjVSvqFKXhx2B8W4uVpZIp3sOD8e6w87lcKwF1+tuWLpQX2
         W10FfnFBMF026aOYa0shuHZosG8JUE6FNjqq8yjDYGULmn4rTstMIsM0CX1qMnXj6C4X
         zunyUNmQ63/Su+8iHrgA4QhZ5PIqx3N4qS2p1Rb8+NCGBjvcXyuCWlBvxWi7sZyLu1sb
         JUNi6k7tHhK5/OGiwYeJchb67Me4W3EyRvx0La5Z2bvA/ngoQqor1cQuMtPr9hzRkLj1
         CjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718630085; x=1719234885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqH5PnYnV4OCHciC6unnqcv3QJd6vOkUagh67OcQSZo=;
        b=ZFdPaJNoLz2MMiWoOvHv6FVUrYcnn0/ibfXjvK36noWfysyYgRvymjcRBgxPJ0hhqt
         vT/ikjwc6vjWSs+GZKGsyxa+RHFocvTGlkaGZmNHSJWlzIVxvEBoxTh1O26684uT1xE0
         RauHzhKehmpI5DVFwailZU6HClFx3fIRgycdxIil38KjKl39vZfkGkJ3vTU93R1eHG1F
         gWgDnARYLFhxs5ke7a7JrZYFciLG4R9bD3cc378ZVK1yMwcGV1wT1CJ6CKKwncxsrRmT
         ihUaIyZ/3+ansG3Xabtz0la8e/uYFZfKv4bN8BSfprHIEKuWTEs6lhtI49827TTgNWjQ
         vfmA==
X-Forwarded-Encrypted: i=1; AJvYcCWjVES5CMsHvK03TTMxFzXYamCpK6IGUzKo+cZwxgeQgO4Ev7S8EMj69urATx7kKHGovtWWCaCc+T5jAwfyeRAzN6ER50VHs6C5zfI5
X-Gm-Message-State: AOJu0Yxu9gFztciUSaY66i2x5RXJelijr3yrBKX1u9ZlubFk43ZDnXcX
	FlG69vwG+h+4ZlFD5k2vxDdQ5JxwTaBQ9zMrhXyPyOJqKO1yRE2FBdFKpBn4W2U=
X-Google-Smtp-Source: AGHT+IHUp84UpJvFEPcFIvQ17kOX+r6zqro+izswgYoYp+hs6jkxCQlxN7m1kXBF5qblIw630FU0lw==
X-Received: by 2002:a05:6a20:3caa:b0:1b2:b2b:5698 with SMTP id adf61e73a8af0-1bae8243b5fmr9208865637.33.1718630085193;
        Mon, 17 Jun 2024 06:14:45 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f0260csm78801785ad.200.2024.06.17.06.14.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Jun 2024 06:14:44 -0700 (PDT)
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
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH v6 3/3] RISC-V: Select ACPI PPTT drivers
Date: Mon, 17 Jun 2024 21:14:25 +0800
Message-Id: <20240617131425.7526-3-cuiyunhui@bytedance.com>
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

After adding ACPI support to populate_cache_leaves(), RISC-V can build
cacheinfo through the ACPI PPTT table, thus enabling the ACPI_PPTT
configuration.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 9f38a5ecbee3..1b4c310a59fb 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -13,6 +13,7 @@ config 32BIT
 config RISCV
 	def_bool y
 	select ACPI_GENERIC_GSI if ACPI
+	select ACPI_PPTT if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
-- 
2.20.1


