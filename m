Return-Path: <linux-kernel+bounces-173148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D4A8BFC35
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47AC81C21142
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454A982492;
	Wed,  8 May 2024 11:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yBiLQNIf"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A2A81AD0
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168189; cv=none; b=ug14IVVyjAFFXNKub0ew8ghaSUUeCXdV8h0IfbyYrQK5esIlmNreOR5Xd8/tS0gKZI36zzBl/MU9NYeQvGbyg007emJjuHQmeM0g+ocUYd5EEX8P4M19nVU0iz/Hd7jZ4cJP7RhUqCkNuTDu1QcSOGcyrB89GZTYPGnKzMCjUpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168189; c=relaxed/simple;
	bh=+Fl34XZCnTBozqKQN1RM+pVRa0O2c176ao71VrsxAaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zoom9hV05lSmicJC7ZZSMln6rEWpnSf018J1ntAn/NDMBoFO0rzJaUhPfgrPlcRHgtuvQvCukMiMuauYT82vfPSYQqjs0otrxOVr4W7rfMEcMwYbbZlREhUXIvF/3z9vHXCTn1ss/he6Hul49hodNiscbQvABnA6DRQIr/UHslA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yBiLQNIf; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41b79451153so33337205e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 04:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715168186; x=1715772986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oM+WuwVvF178uIr+5Dc8IcJyYSbzDoUf3sQGwgQ7LEI=;
        b=yBiLQNIf2GlIfvr9C8dAQOmARw2fEspcT2lgk7eQWPXM4ogrEX8tZRL0cyQrP77FH+
         NG5C7Hl3HCi/YBWhaVUq29vaNj1vZigP8vLTpMORYy3UHDcF/Hj/eO0POOc23/h7qnxt
         VUdutZCRAPmZgFPdeii4bH3IKaHzz1J/ZIGNHCJRULrNt33cZm2pUQxlqkM9F2sTT8aB
         HF+p30k4n35aoQPix6hhT9aaHWqzCtWor/j18g1dVjagiXz231CD1Rc2Fjvv9vb865LP
         YSMxpJsnSkYFKu+Y+hObmftofE5hXx/FYWTbEFYpjrglB43WaV2IOFwamDVoMfCa0wJa
         KIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715168186; x=1715772986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oM+WuwVvF178uIr+5Dc8IcJyYSbzDoUf3sQGwgQ7LEI=;
        b=N8FfPeJcRhmXM22eA9xB0wtyKbZHF0+S9aSD8Ngw2p1z7jmvGS+2L8jRUSfELdXcI7
         Ealx4UzkoC+WdYY0OzolXLsdPX0shCzgqsZQxqd8U26yr3YPR99TC+BSpCfa7o2uqKCK
         UWlA2R81+hoNy5FFu+guFWr8fCWtao+QC9A0RD9DGk3SwSadrXXhCeVqJoNHdVCyCylo
         lJZKrklJFzC/RG72XZZonZS7KGUCbF8iMwmbA6tTEoL+V/BN1rplWqY0LUX9w8a8Zz2S
         3AmCIpHGu1llnJGFJSJ8C+4sPFiEu/czjG3R1gQj4VHg3nr5AI02QKg9TpGoFyW9GJQ7
         JvWg==
X-Forwarded-Encrypted: i=1; AJvYcCWZNzPs8HaMhF10MSdfOI2F1PA5bmKP+jZlPzgs6Hys7QizxOs3dcUAoB7B0WLStcNX0AUbcEm8pZ7yxHGzqkvWWr2eRHZzE0gBitto
X-Gm-Message-State: AOJu0YzmMSYX/p2e/M9aZRYDgyEe2EmjIZpiT4RHcs1lw4B8yhr7sL4O
	rpHtk4ERMOKVg8xxCPSmV861LR47AXemfWyZJKxof10VXuE7MQxuHBotn05naP4=
X-Google-Smtp-Source: AGHT+IHVO5vcmWKipbJIGDQ+CDJ8RhNP/JYjB5jDnNbYNNxR9pALzbWj/fP/sjh1jhNLJi0qhKSTGw==
X-Received: by 2002:a05:6000:508:b0:34c:77bd:2545 with SMTP id ffacd0b85a97d-34fca810737mr1911157f8f.70.1715168186464;
        Wed, 08 May 2024 04:36:26 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id dn15-20020a0560000c0f00b0034d9012e74bsm15283014wrb.72.2024.05.08.04.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 04:36:26 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-mm@kvack.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH RESEND v2 2/9] riscv: Safely remove huge_pte_offset() when manipulating NAPOT ptes
Date: Wed,  8 May 2024 13:34:12 +0200
Message-Id: <20240508113419.18620-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240508113419.18620-1-alexghiti@rivosinc.com>
References: <20240508113419.18620-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pte_t pointer is expected to point to the first entry of the NAPOT
mapping so no need to use huge_pte_offset(), similarly to what is done
in arm64.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/hugetlbpage.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index fe8067ee71b4..f042f5c8bdb7 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -274,7 +274,6 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 		return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
 
 	pte_num = arch_contpte_get_num_contig(ptep, 0, &pgsize);
-	ptep = huge_pte_offset(mm, addr, pte_num * pgsize);
 
 	orig_pte = get_clear_contig_flush(mm, addr, ptep, pte_num);
 
@@ -319,10 +318,8 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	}
 
 	pte_num = arch_contpte_get_num_contig(ptep, 0, &pgsize);
-	ptep = huge_pte_offset(mm, addr, pte_num * pgsize);
 
 	orig_pte = get_clear_contig_flush(mm, addr, ptep, pte_num);
-
 	orig_pte = pte_wrprotect(orig_pte);
 
 	set_ptes(mm, addr, ptep, orig_pte, pte_num);
-- 
2.39.2


