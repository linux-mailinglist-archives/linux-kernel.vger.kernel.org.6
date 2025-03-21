Return-Path: <linux-kernel+bounces-571293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA595A6BB6E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C36A176447
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC77227EB6;
	Fri, 21 Mar 2025 13:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="UUwB57u/"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B7C1F8F09
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742562463; cv=none; b=I2oHMPKPSxw+OD4ttHxe3CAQouIgQ9pkDkr/1WtsazV6XYXcdde53De6YUi4AUlnz98CqKeqewQVa/TS0ea8/oIkRGfznGTUnFybE59sJmtrshVp8wrysRbRHBQFli5zhaw2BOzCJFJA+bE/D9hleO7n25gkpgD58/XFsSJnW9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742562463; c=relaxed/simple;
	bh=3hu/TngcPm/TeOTChz/9uPROqKOaSIqDhVY9hzEgLFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D+Gia5OlatJrz96bje7EHeezR4Eti4oaSAHcEKwX7RAqetX11YwJakOlmHRraDTKQVIywO9GZtQS99Yv86q4ZKZ7Sj16lznhEsMFSLad+HcsAISxbhE+bKfsgdGtVsLEILa78IxZGjjeJwTGFmnZj7YRNwgSrPwB4OvtAJK2ros=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=UUwB57u/; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3912baafc58so1601080f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742562460; x=1743167260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+81In4ilDZ/dsxug/tXtQcTDxsQusJyemdqH5+0jxZc=;
        b=UUwB57u/oG4Shv2MT5DLIE15Sq/A3H+62nGwtcwwabh5HyoAQMRO7JXsM6DWc/rWA2
         ur079LoSl7eMmlo9nsKA5SBabObKefAAF/bFMDZV8zlM43KyWDW5DLBKRCpMdo8XYkm7
         HNfzfZ1ZBud9bO3s5f1K073U8PHJc4/UsT1O8X9Sn5bvTaT2SX3HngXKyfAPBjIcJAaF
         4uaodLOBTwhRLKTntDEmCWnZ7mXGMjP9K9aKYGBUwzM4sj0dyr/YmgFlOt9bGUeU8xYt
         88P3cxqwBkhzEj+bj5Z5p+fD4IuZ3ofCXVF6hS22LunOzLo0pDnUOWcmDzhSKIRe69fU
         S3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742562460; x=1743167260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+81In4ilDZ/dsxug/tXtQcTDxsQusJyemdqH5+0jxZc=;
        b=iU+pKQgZhnhlnJog3Cjyi4owB3f/pHiWVXFW/5V044KkyvU7mmgLWKg98kSzgjXDFH
         eLJPayjn+rITXLTVKxfxQmWRMqV0J7CBLVABeCS1HmoP8k+OPJVY9U/ceKaJe1Og22AD
         t2Afr+K+FXP9jV7P6tNlnfwudnJsSlhrTUGCfYvr7FMp9mQ2BOEdnt66HLhXmswlxbHK
         HlSh9lvJ2YjWDcvY42fqgsgUZntv2bryWXRrfP7e6gOwxeDNopU6tdxrJmi3PgMlPdbd
         n2hO6a0Shjr/h4ZSBAsrkgfQTsotLbb0SLpaLM/t0lTXd43/LhX0MqjeVTUA9859j9C3
         yKPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+TQmPCXZUMXn+FWpzVUtEnFq0ddRNbh0w1di8JkPXMlTM/RhlptOG6jN1/TFYDK/kBb92JoKcIOJZkTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxxu+wLQpCbwppWi+9V0ZkLfHaB+uyzkTNgr0eCbO3B+8Sqek/
	A9IotnbUQh/lcmZS2pA24kvZ0V4+bAwIE1tLYdOgk+wllg8891f/Tfdif/i0z0E=
X-Gm-Gg: ASbGncsVSnF/O3/dAA/ZzuZ8PO2RLuphMlmzKiPt9katY3MjejV4QzZQrXFONvcRzlp
	LwwlTeSHRVrjls7ESek2R8I0x1YbbGxq9II9qXbQrhfWR02VMqEVjsKVWJ8mctXL2IBl7cePsBJ
	a5n28/K7TQoIpJPGKWyNG4BW7RW7+K2QplEll609lDzEzeLtieaD6GChTQdofE+FyuZ9kIgGdVv
	Z2AvId0md4Ra9r1pDHBEQc50aWpx8lweDo2GjW7CZZVbpzGrywc4dUn1pNbars9vziGEt4OnfxQ
	lS8IVzhWOj1ircqJNQyvcTjiZISBYqkW/0fvE4fRFAWaZrF+u4NnX4tFJhv7+ub/kpumrA==
X-Google-Smtp-Source: AGHT+IFGcNIQFtkSrVrMaEJyHkzdoC3QT/2GtmdRgmqzsJ6C1xedRKK8otT6Nr1+/A9BoBAqiRGLXw==
X-Received: by 2002:a05:6000:1f86:b0:391:4743:6de4 with SMTP id ffacd0b85a97d-3997f940e28mr2542677f8f.50.1742562459890;
        Fri, 21 Mar 2025 06:07:39 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com ([2001:861:3382:ef90:3d12:52fe:c1cc:c94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9efd6csm2364857f8f.90.2025.03.21.06.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 06:07:39 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-mm@kvack.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v5 1/9] riscv: Safely remove huge_pte_offset() when manipulating NAPOT ptes
Date: Fri, 21 Mar 2025 14:06:27 +0100
Message-Id: <20250321130635.227011-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250321130635.227011-1-alexghiti@rivosinc.com>
References: <20250321130635.227011-1-alexghiti@rivosinc.com>
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
index 375dd96bb4a0..3192ad804279 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -287,7 +287,6 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 
 	order = napot_cont_order(pte);
 	pte_num = napot_pte_num(order);
-	ptep = huge_pte_offset(mm, addr, napot_cont_size(order));
 	orig_pte = get_clear_contig_flush(mm, addr, ptep, pte_num);
 
 	if (pte_dirty(orig_pte))
@@ -334,7 +333,6 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 
 	order = napot_cont_order(pte);
 	pte_num = napot_pte_num(order);
-	ptep = huge_pte_offset(mm, addr, napot_cont_size(order));
 	orig_pte = get_clear_contig_flush(mm, addr, ptep, pte_num);
 
 	orig_pte = pte_wrprotect(orig_pte);
-- 
2.39.2


