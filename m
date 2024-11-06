Return-Path: <linux-kernel+bounces-398525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7ED9BF263
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 041D7B24B19
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D18205154;
	Wed,  6 Nov 2024 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="fCRPLyiZ"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF86204925
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908748; cv=none; b=fMnMQi/KzFWnZkvnOKIP1zYB1/XtK7H19ScQbQ6Z8JdUJp/ojmAZ4/097hT+wHeaFQbWVRW5rmCyIxLfsb7cay+yBDzFZNKvMXLU9OUv3z1GtpzvvOPnoGoTyCC3wnIWF76vFFcqINOx/FUK5LJo4aYVICIryI9wOR3Nphw8AI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908748; c=relaxed/simple;
	bh=a2SRNhgByLYkEQQV8w/BUYuqaC8BJarO22cske/QxvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXa/zuGFSpWB6tUorA7UoKAc5d+0Ck8jWObZu4a3Mrszqz1lyK9uKG9eBvb9aTYf6c4IX7k1qePZ8cFpkD15Shv6CWEgtJ7euA05n4tSpYjr0L3YfyWM705FwQrw+bXwrjyMKNfvTzIQDcMJ75ijfjOAAdBMTtu/w4/ntvmpVOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=fCRPLyiZ; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b1507c42faso82704685a.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 07:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730908746; x=1731513546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dE7GBdO27UpsSNU1CxN3p2/3T9xO+pcffcnhhBLFfkk=;
        b=fCRPLyiZs+9ptDNCDmtf7ik0bWzhFKd4BMazhLG6cy/alPFUiNI+GEx1762pXu5mZN
         AKDBm5RFPgL0HN7JFp6vDUJB2F+q6iXUluKrvZonZU6NjYvyIbVsuKUcJ+pFzS3FcZ38
         iD2nip8wqtN6NLt+DFgFlitub6QaIhi+AtsX6zozjH4Lx/Ewt13X+vqV2/P62vbx1PBa
         qPaYkBl683qMGsb/Y/lY2UyTV3NlMYgMahjEFd7UjBqa9ZzDXZTJ1jX0QTDh2Xvlba5/
         Ta4KYbbfXJ7ojUBUVGG0c8LElVjA2wm6l4ToaUY8y8LaVx8gmHELuz3XIF7YvU02YuCS
         DOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730908746; x=1731513546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dE7GBdO27UpsSNU1CxN3p2/3T9xO+pcffcnhhBLFfkk=;
        b=kVf8a/Ds9pGKg7H7x4oUBgXH3yQ/lBTqqq7s02L32gNFIgmZERKF33s8ezry2TsfKl
         Qgw+m7AdFhNy8rw0Zaig2QqTmyJk7Gkc8UZ6nwVSLBcDM+xj2CIwNnzHMUl0PqWha1//
         wSi94Vo4Jn/NfHMmGCxaxVkccBvlggQNShr73C29YupY0Fs6C8+d52ce2RLhE+HgfW2+
         G2PZPAwmYHtRMrZhnUvUFKk9nZGJhTCIXGpFTL2uL99sg36qqhwY/qGMl5uQTWWzLiRw
         Pc+KW1ISGxZENe4bV6Xz/79TgCQLBdDUt8TrRtAsx9+jMTWkNfZD3Drm3UBxHUlvILza
         Zs4A==
X-Forwarded-Encrypted: i=1; AJvYcCVEDn2laRh32TzwC7/wjBl6JM4HmCSMJ+lKp6q1DQj5toFUliCRXiCJsUDIbwCafGMQ6CWLmQYqvWh+tR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqoS90gibCfl2bOxaIfjGIja+8kRVxdNYRG9q+eKK/TQporLxD
	ItoyhbckyohJ3FEGAjncpslswiOatto2fcFrCgqxQfjePCylgYuNo6Fb91v7qnnJyAybtBOA9z0
	H
X-Google-Smtp-Source: AGHT+IEUkctiVyqefq/YK8UzVAb3G1JlrVxWuRVPIwvQYFeNj0t51VLwtemS/L2Zn+W2U6AWN8z3Tg==
X-Received: by 2002:a05:620a:bc4:b0:7b1:3c19:a665 with SMTP id af79cd13be357-7b3217fd138mr445393985a.19.1730908746378;
        Wed, 06 Nov 2024 07:59:06 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39f7b85sm641377285a.31.2024.11.06.07.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 07:59:06 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	kernel-team@meta.com,
	Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com,
	rrichter@amd.com,
	Terry.Bowman@amd.com,
	dave.jiang@intel.com,
	ira.weiny@intel.com,
	alison.schofield@intel.com,
	gourry@gourry.net,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	rafael@kernel.org,
	lenb@kernel.org,
	david@redhat.com,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	rppt@kernel.org
Subject: [PATCH v6 3/3] acpi,srat: give memory block size advice based on CFMWS alignment
Date: Wed,  6 Nov 2024 10:58:47 -0500
Message-ID: <20241106155847.7985-4-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241106155847.7985-1-gourry@gourry.net>
References: <20241106155847.7985-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Capacity is stranded when CFMWS regions are not aligned to block size.
On x86, block size increases with capacity (2G blocks @ 64G capacity).

Use CFMWS base/size to report memory block size alignment advice.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
---
 drivers/acpi/numa/srat.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 44f91f2c6c5d..34b6993e7d6c 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -14,6 +14,7 @@
 #include <linux/errno.h>
 #include <linux/acpi.h>
 #include <linux/memblock.h>
+#include <linux/memory.h>
 #include <linux/numa.h>
 #include <linux/nodemask.h>
 #include <linux/topology.h>
@@ -338,13 +339,22 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 {
 	struct acpi_cedt_cfmws *cfmws;
 	int *fake_pxm = arg;
-	u64 start, end;
+	u64 start, end, align;
 	int node;
 
 	cfmws = (struct acpi_cedt_cfmws *)header;
 	start = cfmws->base_hpa;
 	end = cfmws->base_hpa + cfmws->window_size;
 
+	/* Align memblock size to CFMW regions if possible */
+	align = 1UL << __ffs(start | end);
+	if (align >= SZ_256M) {
+		if (memory_block_advise_max_size(align) < 0)
+			pr_warn("CFMWS: memblock size advise failed\n");
+	} else {
+		pr_err("CFMWS: [BIOS BUG] base/size alignment violates spec\n");
+	}
+
 	/*
 	 * The SRAT may have already described NUMA details for all,
 	 * or a portion of, this CFMWS HPA range. Extend the memblks
-- 
2.43.0


