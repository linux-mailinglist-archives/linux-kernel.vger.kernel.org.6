Return-Path: <linux-kernel+bounces-367257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 671C89A003C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC71A1F248FD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC857189F45;
	Wed, 16 Oct 2024 04:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JkIa2I37"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00B1189B9C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 04:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729053390; cv=none; b=HThwHxIg3EMUDT19K29Vp15rwD74k4+1+So7XmK6v0G6NVYihHyCHkljI3b9MKx3h+27oKV0Q9CfEDrc5c+8rzaLPEZWx6e8r3j1zJMJuOLY+UX1w0EcR/khRawIO9zHZ272Z4fHhSHZbPziTnd5VNdLwAFf1B00GBJl32BAa8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729053390; c=relaxed/simple;
	bh=SF1cfD5NyIusAX4cJLE8I0Xl9EStwnnCV4GYsjNRDLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwxnU5l4LACAW1olL5CB6aeDVi2A6onmo1d/xEfAbYNfrYJUcd7orQwgWJQja+up7+H3h52GcIWRncy+DrfyiGPvOgzOEhbSKy1ZzPMKTCETHV95C6FbVHVxjVc8j1YVy7b4VHmeTOzB0B4X+NaqYqQ0qm6ovJBftPLSGcpEODY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JkIa2I37; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e585ef0b3so2501775b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729053387; x=1729658187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7wGUcAWkY/xXNhwj5XB7vCbP6fvR8LLicMUY6R9k4E=;
        b=JkIa2I37b4vvOYkVHed4zKLlOWSIL793PZflr1qe4q5x/BhD4QSOcvNkZkkjQHOBPZ
         UveidUDGKuU6d0RGvnziBNSrF23Nw2DxFjLMJ1vPaag4Mdkinuz8my2E6u/fhu13A2OB
         1VzCL8wXBYZPIlolpx+WLu+HmYD9LVNijVjnd5tAoyf2OHHaWUXTPWEzCMOKeFx9f7Ji
         MeSGCH2nTM31ITq2YehgkuAuN2SxwwvZM/NI+liR6904h4NgDxcjm3OFZ4sdhxQbfEh9
         KLXohb2uCIOOScHY5IZ+RL5/S14+CGlePxUTufOkTkFFwLN4i42i6/sW2Q5GjKSzYjAG
         Si7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729053387; x=1729658187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7wGUcAWkY/xXNhwj5XB7vCbP6fvR8LLicMUY6R9k4E=;
        b=k57sSj1FwV81pY3Byrt9yKsH1yGwhNjE/r2quu28QRa69BAWJhHoKr+D/oPB52z63I
         AIUrgGflBI0F/+GBlVr4MLglgv2VUFYTAoyay2mMN8VE2FfOAkMwNnkUscR2RzECEWCv
         q4kaW8MXCDI9DKeBU1pBOA2ucrV83swO8q+owHOMqxw2DWbnocIcOwJOd91LSdy2AArA
         MCWLq7aGR1JjfSMJcSIu8hMC/6Oo2H3l61dq+3Mr8Mp6O0lzdDAOR6ks5c/WB5Ghy3S6
         U1aaxrrMYg0KwjODgj2u2DxFhHJusur2M/h6wATEEyRHym0g/F0Yoas4afD6znH5Pufl
         diPw==
X-Gm-Message-State: AOJu0YyAQPkMhGJh/KGCcaoE+Eyau9WFgGkh4vRMIWFyaIouk9yfMMQW
	06AX69bWTwYd3auzqgb8tw3tYKLSS6VCS4NOio6m3FIfrqWxku2NpphdCzttF8c=
X-Google-Smtp-Source: AGHT+IGsHi96TSHaDa9/5tTO7fMcmHr9rDiWd6O9B7Avgxv2U6sxlJiV4p4N3nYNqbJHGkIB2KwGlA==
X-Received: by 2002:a05:6a00:2288:b0:71e:4dc5:259e with SMTP id d2e1a72fcca58-71e4dc5275dmr18417384b3a.17.1729053387124;
        Tue, 15 Oct 2024 21:36:27 -0700 (PDT)
Received: from GQ6QX3JCW2.bytedance.net ([203.208.189.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77518a76sm2189192b3a.220.2024.10.15.21.36.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Oct 2024 21:36:26 -0700 (PDT)
From: lizhe.67@bytedance.com
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	boqun.feng@gmail.com,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lizhe.67@bytedance.com
Subject: [RFC 2/2] khugepaged: use upgrade_read() to optimize collapse_huge_page
Date: Wed, 16 Oct 2024 12:36:00 +0800
Message-ID: <20241016043600.35139-3-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241016043600.35139-1-lizhe.67@bytedance.com>
References: <20241016043600.35139-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Zhe <lizhe.67@bytedance.com>

In function collapse_huge_page(), we drop mmap read lock and get
mmap write lock to prevent most accesses to pagetables. There is
a small time window to allow other tasks to acquire the mmap lock.
With the use of upgrade_read(), we don't need to check vma and pmd
again in most cases.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 mm/khugepaged.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f9c39898eaff..934051274f7a 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1142,23 +1142,25 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 			goto out_nolock;
 	}
 
-	mmap_read_unlock(mm);
-	/*
-	 * Prevent all access to pagetables with the exception of
-	 * gup_fast later handled by the ptep_clear_flush and the VM
-	 * handled by the anon_vma lock + PG_lock.
-	 *
-	 * UFFDIO_MOVE is prevented to race as well thanks to the
-	 * mmap_lock.
-	 */
-	mmap_write_lock(mm);
-	result = hugepage_vma_revalidate(mm, address, true, &vma, cc);
-	if (result != SCAN_SUCCEED)
-		goto out_up_write;
-	/* check if the pmd is still valid */
-	result = check_pmd_still_valid(mm, address, pmd);
-	if (result != SCAN_SUCCEED)
-		goto out_up_write;
+	if (upgrade_read(&mm->mmap_lock)) {
+		mmap_read_unlock(mm);
+		/*
+		 * Prevent all access to pagetables with the exception of
+		 * gup_fast later handled by the ptep_clear_flush and the VM
+		 * handled by the anon_vma lock + PG_lock.
+		 *
+		 * UFFDIO_MOVE is prevented to race as well thanks to the
+		 * mmap_lock.
+		 */
+		mmap_write_lock(mm);
+		result = hugepage_vma_revalidate(mm, address, true, &vma, cc);
+		if (result != SCAN_SUCCEED)
+			goto out_up_write;
+		/* check if the pmd is still valid */
+		result = check_pmd_still_valid(mm, address, pmd);
+		if (result != SCAN_SUCCEED)
+			goto out_up_write;
+	}
 
 	vma_start_write(vma);
 	anon_vma_lock_write(vma->anon_vma);
-- 
2.20.1


