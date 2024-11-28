Return-Path: <linux-kernel+bounces-424368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 494A89DB389
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06E852823E4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B171482E1;
	Thu, 28 Nov 2024 08:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="I2rDVUSD"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD2283CC1
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 08:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732781813; cv=none; b=lWGIu90pvwfEIib3Eps2fYXm9MXZUh6BsiLqWm1yWD7/pPXfvGpl2WWEdkkdRvAxdbgzDih5zBDjqaf8lUVou0vZ2BCs21oNofsIizTnT1OukPJr8BcxlBVE1douiQxXyoYa1iTtYEwB12/qvztCNwdyUAfNib0nuWxWbsh7bCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732781813; c=relaxed/simple;
	bh=b9lkoP3jfqcxHk1XeqJCNQqso0v9vbfkbEIBBFSTvgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QvkWOGpek0BhJW8rscp0eDmhUctz6hqzU2rteiz74gkbrB8rOBOQd78ECw9BQ/rQzZJmHjeWOxeCEHrDXFzmaIZ+dxmqmZajv+jJebxfrHY33W+90B99AkvhuZgefm1/NO1eDblbKtea/uZx50ckGcdrQ7TUKhzP3iC0O5i9GGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=I2rDVUSD; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434a1639637so4735155e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1732781809; x=1733386609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XtkNb7ChcpZKeghQlkhwMDhrbK5ce/xMSti4wIKo4Vk=;
        b=I2rDVUSD4imxCE9pmvNP0a8voiLRWGNrO7tnJGB5mAGCEWd/VAdZC9Ueufb+28DzQB
         Y4g3ZXNVNOTvByLa5Fc/E6qOMmxYObJi1wq0WSyckpW1P24YP0rL63YOgI9512tDannT
         pMk8YURgrx5jB+xX03jorO2nS3ZUX5Wbj34Ni8tVBKvIk6GKSH2yWucLkCgCj8iqPNB8
         EdC9qlxebhsAPQ/vGPHEod6WsCGfWZ4T9zpoFpKbGmAwSmPHuzDUTWBNk6Dcz6uTVUwr
         tx98snYGuvvyDDmeQXitWwsis8DvmzEKEcG8pzeN8XdxJMXQh6FLC4HyidnJs12aSLP8
         OVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732781809; x=1733386609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XtkNb7ChcpZKeghQlkhwMDhrbK5ce/xMSti4wIKo4Vk=;
        b=Irw/QYQ9gfc7Fq7pRtmTiiJVf4RfJ1DUz3CUZC5fryqoAdsRCiOVoWnUjkUrP1P54Q
         Y9CccFnXA7yla3S878xLlvKd09R7Wnm4d7xBAxSqvO860vXEl7hl+PxiRcN4UjL9vxkZ
         IU5tuRrCcYfKBU/N9DigbjhDiRQPbdPVtobN+vApyRr+iT7cIFDlm0ey8ae2NsVHoq5T
         bDIP43fckoT/n2gz0scFVB3L7KB9XSChFAEG5xJfknSI531erjXT7Bcw9FOjjK45RKcw
         z4P9vQ0NsCPckzzzZqxFhacN6m2uhTNT7ix0HEkmACLAQCFBLLW0Z19TBCbRUKQu+hIQ
         ZCqw==
X-Forwarded-Encrypted: i=1; AJvYcCXjmqbenec9gQF2x5D/IDHYcKd2O1Nql3fdUxrqmFgNwvRSrGbkKgva0+g/DHlLXYnE1PjfMA2AVMrqvvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHfnXlPOF+fHVFOkeyRzdPM1Nkb+8f1u1axzjqKq4MXGPz2fnA
	gmGnDdhust2XoYaNLK7dWVbgoZwLKS/EdAVOjP1dNPyjAkdhdY49MbEp7ctcZAo=
X-Gm-Gg: ASbGncvbmdv1vaLj82JbE6DkgQG703kD9PBPKCExSn7BPvA7weVg61hifXAuitNfq0e
	SKFvEAtlSgf93Cig3blVEX0oamf2gzsGMPkkXWJWRoQiD4k/NTA8dRJxPh6FnzvzgfsziTDffEt
	XPS4aoyv2Ue5Y/m0UEJCVzD1A2MvV7Lub/L6qtQB63Tn85s1z2VwM8iUhJeBSxBGNr/ippE1+31
	Fk2rnLyED7+p1Gn9Elmf9BM5J+SH59tcJMR6MS46yhARJk93Kw=
X-Google-Smtp-Source: AGHT+IFa2GLouk/rGMVQjtmqkbmXBjVyAfkRwDjDgUh0FP24cjeR4S1FKi1Ih91BYGaVuzDe63g42A==
X-Received: by 2002:a05:600c:5490:b0:434:a815:2b5d with SMTP id 5b1f17b1804b1-434a9de43cfmr51318225e9.24.1732781807910;
        Thu, 28 Nov 2024 00:16:47 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f70cbfsm13945265e9.36.2024.11.28.00.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 00:16:47 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Kai Zhang <zhangkai@iscas.ac.cn>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v3] riscv: module: remove relocation_head rel_entry member allocation
Date: Thu, 28 Nov 2024 09:16:34 +0100
Message-ID: <20241128081636.3620468-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

relocation_head's list_head member, rel_entry, doesn't need to be
allocated, its storage can just be part of the allocated relocation_head.
Remove the pointer which allows to get rid of the allocation as well as
an existing memory leak found by Kai Zhang using kmemleak.

Fixes: 8fd6c5142395 ("riscv: Add remaining module relocations")
Reported-by: Kai Zhang <zhangkai@iscas.ac.cn>
Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>
---
V3:
 - Fix Zhang name spelling.
 - Reword commit title.
 - Add a 'Fixes:' tag

V2:
 - Add Kai Zhang 'Reported-by:' tag
 - Reword the commit description (Andrew)

 arch/riscv/kernel/module.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 1cd461f3d872..47d0ebeec93c 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -23,7 +23,7 @@ struct used_bucket {
 
 struct relocation_head {
 	struct hlist_node node;
-	struct list_head *rel_entry;
+	struct list_head rel_entry;
 	void *location;
 };
 
@@ -634,7 +634,7 @@ process_accumulated_relocations(struct module *me,
 			location = rel_head_iter->location;
 			list_for_each_entry_safe(rel_entry_iter,
 						 rel_entry_iter_tmp,
-						 rel_head_iter->rel_entry,
+						 &rel_head_iter->rel_entry,
 						 head) {
 				curr_type = rel_entry_iter->type;
 				reloc_handlers[curr_type].reloc_handler(
@@ -704,16 +704,7 @@ static int add_relocation_to_accumulate(struct module *me, int type,
 			return -ENOMEM;
 		}
 
-		rel_head->rel_entry =
-			kmalloc(sizeof(struct list_head), GFP_KERNEL);
-
-		if (!rel_head->rel_entry) {
-			kfree(entry);
-			kfree(rel_head);
-			return -ENOMEM;
-		}
-
-		INIT_LIST_HEAD(rel_head->rel_entry);
+		INIT_LIST_HEAD(&rel_head->rel_entry);
 		rel_head->location = location;
 		INIT_HLIST_NODE(&rel_head->node);
 		if (!current_head->first) {
@@ -722,7 +713,6 @@ static int add_relocation_to_accumulate(struct module *me, int type,
 
 			if (!bucket) {
 				kfree(entry);
-				kfree(rel_head->rel_entry);
 				kfree(rel_head);
 				return -ENOMEM;
 			}
@@ -735,7 +725,7 @@ static int add_relocation_to_accumulate(struct module *me, int type,
 	}
 
 	/* Add relocation to head of discovered rel_head */
-	list_add_tail(&entry->head, rel_head->rel_entry);
+	list_add_tail(&entry->head, &rel_head->rel_entry);
 
 	return 0;
 }
-- 
2.45.2


