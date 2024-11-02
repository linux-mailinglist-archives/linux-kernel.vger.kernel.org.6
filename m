Return-Path: <linux-kernel+bounces-393058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ABE9B9B72
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1532B219F2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3101448E3;
	Sat,  2 Nov 2024 00:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EEaSHmvi"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0364412C54B
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 00:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730506133; cv=none; b=s7+B8j9kST35jbNLDFWvFGch+m2Ti5Be8hFws4fKiromZUB2njjPOSIocBlXmpSivCm/gKTRlWiFH1sG8exlmmKEr/MGTIposHOeMwwEobs4z9ADJecNDdU996iGF6CCRFD3QMXGC+wkgyc4z3yFqRe42OowGFTldCkq0KRV1fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730506133; c=relaxed/simple;
	bh=kPKiUpdbZj7NFAlCd+2g4pMw6xbfq48soTfJ1aybsPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCA0SebFcKXtGIGioZNa9dn6m/lkEYZNoVTqtGOSU8ur33J2X19pQd4kDhDO0OrVedDhcojAQgnyB65SbAP9Y1RwukMPzbL3ThPM+Rkk5O8odE9GTMXUOF3FA5Ttryu5qdKunlqTd1RqDevuZC2pGRTxjT9Q8wsaVXruvpyvmzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=EEaSHmvi; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2b549799eso1923028a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 17:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1730506131; x=1731110931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGKCUDOPoqSxjqjZbl0XFkIURJ67OmxtD1LdZJwnrMc=;
        b=EEaSHmvi3TKK1a5EWbpZGgi2TeJMdMLJMhNCDCG4vzT8ApPIBQPCjEGogYNjvdst2d
         1lxnxwnq22GJYQTHnEHaryVa20En6omZHTxaSz88U15heEBWz6wDIa417X4HSptU7kgp
         dvA52cHMOTcFg5EhDCD9lrueTqvEh4kDOKv6kvHoZaVQBVzcy0ZJ4MD2G8zPhiovRVQV
         haDrjbvS+nCR6iThsUHrOTFSm/qBtjvCRisYYu7mjTWNAwUxX1NXeXT/ofj1iGmJnYuJ
         U2SYddtMpV6zcYVKEECzGnNt/7qsgkpUxoC2UGWHKMOMr9f0StMh/l7L0d90RdNndDbA
         bROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730506131; x=1731110931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGKCUDOPoqSxjqjZbl0XFkIURJ67OmxtD1LdZJwnrMc=;
        b=Q1Kgub8eEO8zFZUTs9l5m8FMIZwUEkOGjWXxV4GgNnVlfoV1AZAji3tqRNTM2hkdH7
         mIrQxWB5GauJ1UIsf+AgrWrz18qO5uj6CnODEKfYLxQD/3lJUfGsX2wSH1DrnzzWadOa
         E32I3dXGPJb8EW173+aSNfbqqdtOYJ6ooNtOga3eHy6Xua0LOQHVlH3KWz4V0UNSlglo
         8VkMbXADQUIKBn01D6PuTBIC9Q/rgiGU+qyR/4v+kPd72Ft5788t03lKAjJiyDn6sRJz
         ebOJL1svR+mEkHgND140wHSyVaLlJHarY3BbYyXH4PWzBW91j1H4xFwYQgM/mSaqSy3F
         sRHA==
X-Forwarded-Encrypted: i=1; AJvYcCXBlYizYzTjqsqJqmSTLeauhc9eSJU6ul1AOquQIpD4BhCPOjO32Jm6ssLts1q0t3BtHzmyBy3VJY6Ietk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1vsvoJP8x+AZvb7GTuVDdCkRL2B/LEthavsi5Bc+bPxnou6bx
	66RKT2eS0E2hRX3TpAWR4gAZPRCuHfnQqGtSb5wWPI7sdE0b//g2p77NvHS/6BU=
X-Google-Smtp-Source: AGHT+IGCxiVZb4g11Y9M7gntQVTVm+MFF1ZkzqRsWftmVRLra8MKii1/bFnU2KEsW1jE0QSKLkS3ow==
X-Received: by 2002:a17:90b:3c49:b0:2d8:8430:8a91 with SMTP id 98e67ed59e1d1-2e94c2b3825mr8142120a91.10.1730506131400;
        Fri, 01 Nov 2024 17:08:51 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fc00856sm5505749a91.54.2024.11.01.17.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 17:08:51 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Conor Dooley <conor@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 04/11] riscv: mm: Deduplicate _PAGE_CHG_MASK definition
Date: Fri,  1 Nov 2024 17:07:58 -0700
Message-ID: <20241102000843.1301099-5-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241102000843.1301099-1-samuel.holland@sifive.com>
References: <20241102000843.1301099-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The two existing definitions are equivalent because _PAGE_MTMASK is
defined as 0 on riscv32.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/include/asm/pgtable-32.h | 5 -----
 arch/riscv/include/asm/pgtable-64.h | 7 -------
 arch/riscv/include/asm/pgtable.h    | 6 ++++++
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
index 23137347dc15..7dc0751d67dc 100644
--- a/arch/riscv/include/asm/pgtable-32.h
+++ b/arch/riscv/include/asm/pgtable-32.h
@@ -28,11 +28,6 @@
 #define _PAGE_IO		0
 #define _PAGE_MTMASK		0
 
-/* Set of bits to preserve across pte_modify() */
-#define _PAGE_CHG_MASK  (~(unsigned long)(_PAGE_PRESENT | _PAGE_READ |	\
-					  _PAGE_WRITE | _PAGE_EXEC |	\
-					  _PAGE_USER | _PAGE_GLOBAL))
-
 #define pud_pfn(pud)				(pmd_pfn((pmd_t){ pud }))
 #define p4d_pfn(p4d)				(pud_pfn((pud_t){ p4d }))
 #define pgd_pfn(pgd)				(p4d_pfn((p4d_t){ pgd }))
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 33e7ff049c4a..4ba88592b8d1 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -66,7 +66,6 @@ typedef struct {
 
 #define pmd_val(x)      ((x).pmd)
 #define __pmd(x)        ((pmd_t) { (x) })
-
 #define PTRS_PER_PMD    (PAGE_SIZE / sizeof(pmd_t))
 
 /*
@@ -166,12 +165,6 @@ static inline u64 riscv_page_io(void)
 #define _PAGE_IO		riscv_page_io()
 #define _PAGE_MTMASK		riscv_page_mtmask()
 
-/* Set of bits to preserve across pte_modify() */
-#define _PAGE_CHG_MASK  (~(unsigned long)(_PAGE_PRESENT | _PAGE_READ |	\
-					  _PAGE_WRITE | _PAGE_EXEC |	\
-					  _PAGE_USER | _PAGE_GLOBAL |	\
-					  _PAGE_MTMASK))
-
 static inline int pud_present(pud_t pud)
 {
 	return (pud_val(pud) & _PAGE_PRESENT);
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 3e0e1177107d..afa0b455eaa4 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -201,6 +201,12 @@ extern struct pt_alloc_ops pt_ops __meminitdata;
 #define _PAGE_IOREMAP	((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_IO)
 #define PAGE_KERNEL_IO		__pgprot(_PAGE_IOREMAP)
 
+/* Set of bits to preserve across pte_modify() */
+#define _PAGE_CHG_MASK  (~(unsigned long)(_PAGE_PRESENT | _PAGE_READ |	\
+					  _PAGE_WRITE | _PAGE_EXEC |	\
+					  _PAGE_USER | _PAGE_GLOBAL |	\
+					  _PAGE_MTMASK))
+
 extern pgd_t swapper_pg_dir[];
 extern pgd_t trampoline_pg_dir[];
 extern pgd_t early_pg_dir[];
-- 
2.45.1


