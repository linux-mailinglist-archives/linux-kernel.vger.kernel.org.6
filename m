Return-Path: <linux-kernel+bounces-392314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3999B9250
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6462E1F220D3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117061A3BD5;
	Fri,  1 Nov 2024 13:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="AXWIq9IN"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DF01A2545
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468839; cv=none; b=FRKcu7cUaFN1C3S4Dia0VTNNysEla92PmPsigiMJx1YTD0UWEOGY/bVvfDfQtAi/P0ShQIcOuqJKYMX3iQb9jnFlfCSgLdd/HNyc3gjLQxV2VMvhfuJR0GJZ7Ld7gXEdYyO70vCGt02OgXNt0JBAf0y0F6yJBH+KQfklHusZ1UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468839; c=relaxed/simple;
	bh=N0XPOmy3aARI7v9y/OYZfrAo+KC130k3/XQolnRqYXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTib1Kgwkn6flovCSMOA/Mp50uIJ3X4FurDsE1sVB0LGAl6yY2C+rqpklEmEKkIasbgzGVzNkCBM9qv4NDBjBV42byPPf+3QI9hW1Bs2vK4GLjc0IhlysTm+Uvr3mt0UuX6yJEwbF5IxyC9sR/pUScuLVJ56oB84n4RyroQF+Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=AXWIq9IN; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e30eca40c44so1557300276.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 06:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730468836; x=1731073636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqBWIQFF5FQxg66rq7hDVwvrkSgx0UrsiyD8ZLE5CIc=;
        b=AXWIq9INy2KD4MeakrhKW5WlAPb2H5dMjc4Lx3WARI5PzgmlA8XcrfR3qsNYpQlwRi
         iOQByHwq00Nw1ChbAVPBI9oGEwwxfjNQYRdXrwpPgoJmcO150RRm37xAqmQKZcpjLO7l
         b5k8MEn7JXLLI7Wgkv6r19YMt2JceBhDjB6uGRPWyKCw2PfzFuNzvRXJo7KnM9Xfxzor
         yT3r7OrFve8JTOQlpl0Ki/YWg7ShWW5A1OOGkvwhyVVTZ7DRWfamsbuU4WS3QCYDgIgP
         DutLUtss43CdiiBT8OwnVoSUYRT2QTp7QmiaA1xuVMhXDuhTYMuI5VVPiLSejanJAQrS
         YnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730468836; x=1731073636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqBWIQFF5FQxg66rq7hDVwvrkSgx0UrsiyD8ZLE5CIc=;
        b=T6l4fPM9xsygG1nGEq2nzkgEFcKzkchTa/dD8sf6XuaWnwR3dAs3Dt3MeHh8LcUGzP
         8gbHviduX5Wpt84lE4d7brBjpM7RVaIFdoljiLnJBQsWaeRcE9lpiZZNxOOEkIoi5imB
         xRGDvXS9NzLCVJguN+nzAlnyoRYwDOh1CGo3yBa1mfujucPJc/NUM0VSfwLX3MNiu0+s
         K+BEBpZ4TZ+7w8L/er+P0pHInSWDba6t3UdHwwk8CnlQOeOmMkYzwl5NE/z9GClCceA7
         sB9u8AXj+IVaMq7j2ZJZTuxOgRGgsESVUwgVxvn2V+olT2AJi9UhmpmYqnGebLyXtvp/
         Ujdg==
X-Forwarded-Encrypted: i=1; AJvYcCUDqGBTQIwtDZgyJrchn8bj7SG9vTldJ2M0eGITlcXt/3ei+bgH+1CNtwEmY6+ZewO+GVzWRVwg5meG2Gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDnklxeRSKrZzVuM/DBy27JNjYwULzA68e/DYrbZomPGvYvJQg
	U1KSVgHk3p14yOU4AsbW6UMJsRjS3MEh82ZqbDiwH7uvPlW9iZGHUGWZhJvEqfA=
X-Google-Smtp-Source: AGHT+IHc7ueHoeZ78qtsNy3gd8c/oEoo2nOnDyxntt3wb0tJLgWmBDNYSZb05h7Av17dwgQfREUg1g==
X-Received: by 2002:a05:6902:b01:b0:e33:14fa:2273 with SMTP id 3f1490d57ef6-e3314fa232amr169232276.5.1730468836506;
        Fri, 01 Nov 2024 06:47:16 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com ([50.193.156.113])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad0cac07sm18840631cf.48.2024.11.01.06.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 06:47:16 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
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
Subject: [PATCH v5 2/3] x86: probe memory block size advisement value during mm init
Date: Fri,  1 Nov 2024 09:47:04 -0400
Message-ID: <20241101134706.1185-3-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101134706.1185-1-gourry@gourry.net>
References: <20241101134706.1185-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Systems with hotplug may provide an advisement value on what the
memblock size should be.  Probe this value when the rest of the
configuration values are considered.

The new heuristic is as follows

1) set_memory_block_size_order value if already set (cmdline param)
2) minimum block size if memory is less than large block limit
3) if no hotplug advice: Max block size if system is bare-metal,
   otherwise use end of memory alignment.
4) if hotplug advice: lesser of advice and end of memory alignment.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
Acked-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/mm/init_64.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index ff253648706f..f1a495e998ce 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1452,16 +1452,21 @@ static unsigned long probe_memory_block_size(void)
 	}
 
 	/*
-	 * Use max block size to minimize overhead on bare metal, where
-	 * alignment for memory hotplug isn't a concern.
+	 * When hotplug alignment is not a concern, maximize blocksize
+	 * to minimize overhead. Otherwise, align to the lesser of advice
+	 * alignment and end of memory alignment.
 	 */
-	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
+	bz = memory_block_advised_max_size();
+	if (!bz) {
 		bz = MAX_BLOCK_SIZE;
-		goto done;
+		if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
+			goto done;
+	} else {
+		bz = max(min(bz, MAX_BLOCK_SIZE), MIN_MEMORY_BLOCK_SIZE);
 	}
 
 	/* Find the largest allowed block size that aligns to memory end */
-	for (bz = MAX_BLOCK_SIZE; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
+	for (; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
 		if (IS_ALIGNED(boot_mem_end, bz))
 			break;
 	}
-- 
2.43.0


