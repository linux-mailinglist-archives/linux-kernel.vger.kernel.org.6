Return-Path: <linux-kernel+bounces-272696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F80C946009
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAE511F22C50
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391132139A7;
	Fri,  2 Aug 2024 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Z0CFzP8z"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA631E504
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611738; cv=none; b=KU4i6stsCcF5/4bfACWnzi19Z+/50r6BJg2Rp6vsSvf0PK2PD18/keZ4XM9euEDh9fI7SIKPgwX7ANkG2R8+x/VkLmHEFhUX32UwKKq/6sDc5mH/WIVM8vAit63/8UDGB7N3Ye2YRPoKDp3hDXeyirXumV/f7/lyrz3Vcb6c3Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611738; c=relaxed/simple;
	bh=lXPN0zAr41aya+3WNiJQA3eWzEBSucGk/JihnpGrsD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MFYgmJ/5Uw7frM+Zd8vdNZckq3tpbqpIH0CGm07Ifqvxx6MAMfHQrB0ycGcXD4xdwew9PDZ39GsNgpBuaPJTP+hQuQYEQvG0LAdkmtkSi8nTDogmHrsih5id0rbuiMYcvFQnX9bzOcR5djN4OKyd0Op6LA0s7hAL5j5o7k5ECtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Z0CFzP8z; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso61257325e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 08:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722611735; x=1723216535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlgUGAmuTWGVKaOGr6DQU8bhY7gyR7CYcPHPJxmYPTE=;
        b=Z0CFzP8zqzYmcET408ZpjcJPyIkcYQW+2WRlRso3Lu7Gj2m9fFp81Vih39wXIKaxWb
         acfEK0At2Eo3efeKHtzT9Fvet9o8j+lBFAQjFVktsrzEMIq1VOOt24yoCXnoss72fBCa
         zBW2/OtRnYIYOjCe7ICK7mmXmPnrxDcMRsDoJLN25LFIE6sLXK48zj+kVsBK7HhPyj9B
         DBQUbgSvXW0bhNm7vHvI/0YoKdqShrzwx/Ubojy4m1ngO+ps8K+pXhypyuk0YRaoCzCH
         WmVt+6DOyr9emJkTB9h6av+Ov5LECt38lwXz6MD8tmAZS8IpvpO60foa44QuFE/aeFqV
         DDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722611735; x=1723216535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YlgUGAmuTWGVKaOGr6DQU8bhY7gyR7CYcPHPJxmYPTE=;
        b=pEYuV3zIk+PI+VMEQRgHL9f4JlTSHi7AN0y8kJAqWXPPcKpKu/QBVoCpMa2/nU2/wC
         UURPKGUh/5XjJevva5er/2ZvIbdNw8FjZUZ5KjPoUAQHhaSvhq+mTlQUljtWFqXqO7Y6
         /aB51aHa6JHrTfaplOxS4aHQB1WR9VLz8KvrStwKSf6rvAHFyeaBx6dzWtVLVpzxA305
         1vV1es1ULnrS1PjLJJj1Cdw/OvmxM+PFx+1+y2P4xg7W6uJ9uOYFETDaRqS2HYLiyQBR
         GYbT97P+0NDzXGH3tzkuef6/DVyf8CW5gEToc1Sm5ZY6ktS8VKqQv7e0nye12lArgqmh
         /5Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVWOBBF/Vq6jeFNm9wgc1l8D7MggQi+4eTSiiyMjUM/AHwP/fo6HtTf88jjnECqnpOg8QjIK403QxFn6BAiSdqbaoXbqc+01zh66fon
X-Gm-Message-State: AOJu0YzLvHaa3w7zoGhixpZkrwa6s0zezRx2qBFo3wACx/xm2bcm3fsD
	xkWARAzHmimt2LQ+19PhKHdbn3AcRNK1fqoROqb9Mti6QXytFWxDMOL29JZtLZM=
X-Google-Smtp-Source: AGHT+IH4Zu+tW3v1CbjrzMX8UC2ElJa1MqCyLtpkk5dkYfGnqCXlVjQZLgHhH8VhTadf1xkkn6UFcw==
X-Received: by 2002:a05:600c:4713:b0:426:593c:9359 with SMTP id 5b1f17b1804b1-428e6b954cfmr36381225e9.32.1722611734897;
        Fri, 02 Aug 2024 08:15:34 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd06d078sm2168897f8f.94.2024.08.02.08.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 08:15:34 -0700 (PDT)
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
Subject: [PATCH v3 1/9] riscv: Safely remove huge_pte_offset() when manipulating NAPOT ptes
Date: Fri,  2 Aug 2024 17:14:22 +0200
Message-Id: <20240802151430.99114-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240802151430.99114-1-alexghiti@rivosinc.com>
References: <20240802151430.99114-1-alexghiti@rivosinc.com>
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
 arch/riscv/mm/hugetlbpage.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index 42314f093922..6b09cd1ef41c 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -276,7 +276,6 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 
 	order = napot_cont_order(pte);
 	pte_num = napot_pte_num(order);
-	ptep = huge_pte_offset(mm, addr, napot_cont_size(order));
 	orig_pte = get_clear_contig_flush(mm, addr, ptep, pte_num);
 
 	if (pte_dirty(orig_pte))
@@ -322,7 +321,6 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 
 	order = napot_cont_order(pte);
 	pte_num = napot_pte_num(order);
-	ptep = huge_pte_offset(mm, addr, napot_cont_size(order));
 	orig_pte = get_clear_contig_flush(mm, addr, ptep, pte_num);
 
 	orig_pte = pte_wrprotect(orig_pte);
-- 
2.39.2


