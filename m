Return-Path: <linux-kernel+bounces-364964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 796B999DBB8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE591F236D3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2690C179972;
	Tue, 15 Oct 2024 01:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFYwILq0"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D25717278D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728956053; cv=none; b=Tcz/d0HySuwLjY/der0oiYKQ0eLIlJkduxwdV1bsd8R5KjP5aoSqFqoRXw/iiCahDrK+2qQCF2XxTrLIpWBWaarp652e4OkEmBiuHPRQasvwlMIK7BnnrzsNYt+tlO6398wL265My8KWtzIQxtF3tQdo0yvMm0Wd3gErwfkp41s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728956053; c=relaxed/simple;
	bh=lGDU6+XsEZA63vePePBnGkCzitISc6raOI8xarwqjFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0+QtYlZ5bPPo5NPK/3XbxT/OYqAeGb+GFMkZWyNrNZusMk4LKz0GzPVpi34Gy+0U5u5wXBFFaA+k93vT7BbaGNnKWTyMITyZGQ4PBd20QZN2Yb9W4j5fuyXb42FFuy3Om415Ka/umYv5R/QTJLOPHtmK01CbEA4N3fMotESs4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFYwILq0; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso3595510a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 18:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728956051; x=1729560851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+q0qzhvgy5Htf+jNoj0jpwh62QEw37SjQucvD3DcJc=;
        b=BFYwILq0VylmbJ3mf4GVmrtMBlY6Q+Laqd4qCqNVJYrVtlZ3H42JRMxxMhXT8+3t/+
         Ci0HmDnMBA4hxuweGkXUIzyExaKiV7bMRv/VNTRWBcle6yP5n+62k3bu4lAfFMJRT8Dp
         UGUb0pScI0VOzPQ+9ZyQgQe5sJJNDdgicvUi0VYE1jg896pcKgV5xlqv3QOJ+trdhhc+
         C0/eADjurf4OCE10t5g3bCdx3Vld6I79ttvFPIaXKpm2khu9pZ6UYvIWCPsqZO890+rZ
         54vTDXE+HmPSHjXLXDqA8KBszbUxjcsGWORgYx/xlr59+kRxx7EVqBT3yMqRuaJSNovV
         dYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728956051; x=1729560851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+q0qzhvgy5Htf+jNoj0jpwh62QEw37SjQucvD3DcJc=;
        b=RbcwiaBtdeVobC3Gw+4VO86BQlvcF0w5DHreFBmUu9bskiKgsKDQzJOifXH4u70kxc
         YardUm/8B+F0tRXn/iJiwuFSeFJFNhpL49ILw+x8KqCSH14u7tdmy9E3NhAKkNWgpnb2
         IvQHJ0+xY+axCnDyJYuKIAW7qZqA4fZVAeHvVG7Lqmughq+ipHCy/RayTsBU5Cespe+V
         Z/nIj1ZHI30BUzYo2JJZQONh08PqVEKLgd5k8BN+mJ+A+GuS5fwZdaNTBv4YfGv2FVwo
         mxAnTtNTuflEcBoGv7XGAgsxo1h2zF6Omb6QWhpXjuculgPsU7hDXzfpFr55SE/Xhn3P
         53cw==
X-Forwarded-Encrypted: i=1; AJvYcCWNnlLGHz/Nao6XYQ73osd2VdXjD8Gydxdrilw9Td7nc3V9pwWix3aNR+N2DQbF/LTgypI4n7IDUojJ9l4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmgMdvryR+nQwgEGk2mret787rCdTo1MCIcG28p7n4824RB6vO
	71Zf5ntKGrdud7st/FOVS3AkrlUJ2p8Q1HdkPoa1YJtydiuJwnAE
X-Google-Smtp-Source: AGHT+IEG9dZAng0ihOIRx501nnz2kIcPdMnvgADTGVh5vNpZ9v3ZsQlVB5geCgNicOYeTFxr8a+CGw==
X-Received: by 2002:a05:6a21:710a:b0:1cf:9a86:6cb7 with SMTP id adf61e73a8af0-1d8bcf2c37bmr19861897637.20.1728956051333;
        Mon, 14 Oct 2024 18:34:11 -0700 (PDT)
Received: from dw-tp.. ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77508562sm189349b3a.186.2024.10.14.18.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 18:34:10 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Donet Tom <donettom@linux.vnet.ibm.com>,
	Pavithra Prakash <pavrampu@linux.vnet.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC RESEND v2 05/13] book3s64/hash: Add hash_debug_pagealloc_add_slot() function
Date: Tue, 15 Oct 2024 07:03:28 +0530
Message-ID: <7fc9a78423fceda0bfd07f80583a7c9c0938e339.1728954719.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1728954719.git.ritesh.list@gmail.com>
References: <cover.1728954719.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds hash_debug_pagealloc_add_slot() function instead of open
coding that in htab_bolt_mapping(). This is required since we will be
separating kfence functionality to not depend upon debug_pagealloc.

No functionality change in this patch.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/book3s64/hash_utils.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index 82151fff9648..6e3860224351 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -328,6 +328,14 @@ static void kernel_unmap_linear_page(unsigned long vaddr, unsigned long lmi)
 				     mmu_kernel_ssize, 0);
 }
 
+static inline void hash_debug_pagealloc_add_slot(phys_addr_t paddr, int slot)
+{
+	if (!debug_pagealloc_enabled())
+		return;
+	if ((paddr >> PAGE_SHIFT) < linear_map_hash_count)
+		linear_map_hash_slots[paddr >> PAGE_SHIFT] = slot | 0x80;
+}
+
 int hash__kernel_map_pages(struct page *page, int numpages, int enable)
 {
 	unsigned long flags, vaddr, lmi;
@@ -353,6 +361,7 @@ int hash__kernel_map_pages(struct page *page, int numpages,
 {
 	return 0;
 }
+static inline void hash_debug_pagealloc_add_slot(phys_addr_t paddr, int slot) {}
 #endif /* CONFIG_DEBUG_PAGEALLOC */
 
 /*
@@ -513,9 +522,7 @@ int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
 			break;
 
 		cond_resched();
-		if (debug_pagealloc_enabled() &&
-			(paddr >> PAGE_SHIFT) < linear_map_hash_count)
-			linear_map_hash_slots[paddr >> PAGE_SHIFT] = ret | 0x80;
+		hash_debug_pagealloc_add_slot(paddr, ret);
 	}
 	return ret < 0 ? ret : 0;
 }
-- 
2.46.0


