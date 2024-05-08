Return-Path: <linux-kernel+bounces-173124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9895E8BFBD7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24FC7B220F2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C40824AC;
	Wed,  8 May 2024 11:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="X6Azz6B7"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE64839EA
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167242; cv=none; b=k4wPt7IZSOqWTmHE5iMmyGNc5QVo9rsFIoru+GZ5Kl0fZo/TGmJQrx8/qkgbVFscpoJNcIT5Bl5TOlrM+e6ABYjYmuCar3b1or+VWaUOIQmkv2uIUM622Z4TygJZ1MgQ60tLC3XqrUzpB8S195cuYWjOO1Uu/9XtbnmfVwvv6+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167242; c=relaxed/simple;
	bh=+Fl34XZCnTBozqKQN1RM+pVRa0O2c176ao71VrsxAaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SeoyS/uNS/Z92KgHNNBaYa4WykO8So2iQTyjVAJ8XOTbwTx0PD8290mRr4O2x3VkXHJS18ekIXei8qRbnE4J/oS2/TGVW6HV7HSZTjGcgHDjKmjoz+yudnabjaqBG1Vy17eJxz4lohzNPnNc1R9SBueItQ1WIYvFQJFe1AF/2PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=X6Azz6B7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41b79450f78so28471275e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 04:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715167239; x=1715772039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oM+WuwVvF178uIr+5Dc8IcJyYSbzDoUf3sQGwgQ7LEI=;
        b=X6Azz6B7EXXR8FLfABTsol2qyXf89hTxSlS8Lj/b89lP2GQN/C0Y/RtEO1OKuCzz7M
         Za+gbtmcI5FJvNl42sX4mFNafRj5yGYSyyqiAR9lATjvypNlcsIiW/0Che6FMXq4Jt3P
         XckR8webDgI3BoKmNjwPiNVsp1Xpz7rqIuQPjzELoG5DG0Dat9fLSXSzYUkaq9A+sOQD
         BXfPB3hiFG0nTRC5ScOm66JmHAiL4KeJaTEJXH7Io/kzVtvM99FDfl6smCar8egYf6vO
         9fU/PsY4SzHNcM2uq+dE0wHqC4qrJ35zDrF5rNl9gYjgsreHBBxlgOreKVFYoGgzm+9u
         XaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715167239; x=1715772039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oM+WuwVvF178uIr+5Dc8IcJyYSbzDoUf3sQGwgQ7LEI=;
        b=mIxbUi+TqK4dIYEk5ooicFlEvySAbL8b56jbvvXQpesV/Ghnf7TtsAp9Hk/xgXO20Q
         dJGabMP95u0OZjGOY9Uy7NdC5Pms5gIQvqChlXYAMiZdcyLz4loWL+NIttzHa4TE0MnS
         tkJg24roFHhP/6Na2sx1AMqeaplz7+3LuIjotPTffrXaNJSQubobcEbQB4eTjwx78ER3
         n3ssnI8X6YOax5CNX1pw+4Wyj5TM3R9ldfi10fn41aH3u7v+1DkMPyxeydB08wFgfs6o
         iDQfuOhmQs3j9VC2uqNq/IQN6pOifvGW5LbeC0ZZepZEV3S5QoA3o7OGYNNRB4I/JOKz
         SmcA==
X-Forwarded-Encrypted: i=1; AJvYcCVpZPl6sUwaI8Sajjv2Sv6CAKvzZICQ4M2b0TZSWyhOeqD1XX+ZP/5OsigEqcL+denPCOIMTxhIEovgedZS1bmI8us72+xt/iMhaf8S
X-Gm-Message-State: AOJu0YwokFrUeG4AorO3TbG7rLPiDr+l2SDlBEs7E7/Foo/7vWI9rloh
	fOjW8DQpLvDjdIcOjp2vYnH9XSxe3phvi/ZjXTiEIZBCL7n1mgkCfEGhZoFiFrlz33o83S/DhJ3
	S
X-Google-Smtp-Source: AGHT+IEtMJJRHnAlx2d7EmAnwEp8LMaoiRtpdi+BWrYkSsfaWBlt5vRm4skQUYamx6SwwnjaoJRU9Q==
X-Received: by 2002:a05:600c:1395:b0:41b:e201:eedb with SMTP id 5b1f17b1804b1-41f7269010amr20541325e9.41.1715167238957;
        Wed, 08 May 2024 04:20:38 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87c254f1sm19678785e9.14.2024.05.08.04.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 04:20:38 -0700 (PDT)
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
Subject: [PATCH v2 2/9] riscv: Safely remove huge_pte_offset() when manipulating NAPOT ptes
Date: Wed,  8 May 2024 13:18:22 +0200
Message-Id: <20240508111829.16891-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240508111829.16891-1-alexghiti@rivosinc.com>
References: <20240508111829.16891-1-alexghiti@rivosinc.com>
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


