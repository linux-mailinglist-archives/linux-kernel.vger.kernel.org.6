Return-Path: <linux-kernel+bounces-296766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1F995AED7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9F3D1C23E64
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0087185B46;
	Thu, 22 Aug 2024 07:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MUbnGPUw"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F3E149DFD
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310865; cv=none; b=HzJHw5UfSGOBasmfkJH5wDdgWoTKNTq8SEkIoAQtDVsv0oy0+idumCWdUvkTYgfapMI9NE4AQLrCAMJzMgLJdX0fRBiO/wyeD/yTslD29tmOCBqSGYtwkcxLPeBmlPjWhYQEf+Su4vRt2DF1AqnbctpBiu3hxfd1Q5RA7dfE01U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310865; c=relaxed/simple;
	bh=zGFC12VfR2Lu98Id6HwQmHSrNI/SYJwpzP6u5eIGDC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fFwottnYIOPXPQCk/ZwmFewLbvVOFrkDEAX/nSyuvmwUJcZi0WT30CfmsVtKqwfQqCt3Yd7RP0oATBfTjRX9m2BAXJdK5zMcFkXqcARZ1HsaGcUuxvi8xiEmMXXuJQ+gpnrAII5u6jU6uyDmCNYvBinkXfFbc+HJ7xQosJXr+ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MUbnGPUw; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7142a93ea9cso394349b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724310863; x=1724915663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTJMrM+GLhYLeZwUuiK6dImcBAbTGjqYt196yQPATUA=;
        b=MUbnGPUwopBF0lbcogAfE1boCRWCwqj/TWznuIZBqg2NBazuHglqRR2JVgKXVS5ZpY
         32w7S9cMkQTvyLfprxeMLC23wItX6kNzz+gxVddOu/6vnkqNcJ5Y9efbZLavwCVMPJsC
         OcuvTHPMbiiAtatCHdJE0NCVe/8aFQ0C4I12dZxJwTSNJmhVCyGqzVqY60Qft1rYUuwz
         10exixL6x/rjS/X4mlyzefKDVDjiE3lJsWA/8oTp5+zVSz/2YGix/zEO8/XEUhBGHva9
         yNWP6WBHF79+5c2xVMuYt130tmaHj5dT42D5qXYyfoOteDo0Rf961v3slFJm7NYyxxYp
         noCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724310863; x=1724915663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTJMrM+GLhYLeZwUuiK6dImcBAbTGjqYt196yQPATUA=;
        b=mfstBvW5rnkmOEJAVu6Rwm+FZCJFm4og6BibEHii3QbqnzdT1saaE+W9Hfj5qbmIld
         jp2F5i+iW8CdI/Qy1BOqHH3isVYJVuxZcHPy+vmis2FacnfIuSvdavG0aSr2sOno59IY
         UgWhYXvKk2hz1WG2oqi64Pml2nOwFwafNbWjYdM8+7vwPM+xIZuSoZ50yMLfZVYTV/bi
         bayLfbR4nBQzvf7YzUV9H4afwHXHr4QZuZXJjTp25lYg15RsZh+LGnmBIdFeBXiZWHgM
         uma6ijfoap/aR1zPWXgwLz6Ns/JBkmKSJ/7cnH0YMnPCoTHqiGDec02OMKxjYAUr+n/F
         7hEA==
X-Gm-Message-State: AOJu0YxSjOii6sp8wjWHrJg7un6ecur5eHnnW4krc7RRSzYSnfEO/Rsh
	ahLjZS17oVFugm2OgMgtUvcE8HFDrFwhGeojtHU5e3jrab6xa55gxOTpdkh1R4Y=
X-Google-Smtp-Source: AGHT+IEJaUpX6CQIEutPHebqIOZXfyMaKxdLW1UElMR3gb10gY3PgzFG7UEaK+UwdtskMN8KUpfIGw==
X-Received: by 2002:a05:6a00:cd4:b0:714:1bce:913a with SMTP id d2e1a72fcca58-7142356e960mr5852557b3a.21.1724310862916;
        Thu, 22 Aug 2024 00:14:22 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([240e:473:c90:f96:d029:ea8a:4e6d:d272])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac994a3sm695095a12.16.2024.08.22.00.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 00:14:22 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	vishal.moola@gmail.com,
	peterx@redhat.com,
	ryan.roberts@arm.com,
	christophe.leroy2@cs-soprasteria.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 06/14] mm: handle_pte_fault() use pte_offset_map_rw_nolock()
Date: Thu, 22 Aug 2024 15:13:21 +0800
Message-Id: <5acabedfae7ded01b075960b4a91f2e15b4d76b5.1724310149.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1724310149.git.zhengqi.arch@bytedance.com>
References: <cover.1724310149.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In handle_pte_fault(), we may modify the vmf->pte after acquiring the
vmf->ptl, so convert it to using pte_offset_map_rw_nolock(). But since we
will do the pte_same() check, so there is no need to get pmdval to do
pmd_same() check, just pass a dummy variable to it.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/memory.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 93c0c25433d02..7b6071a0e21e2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5499,14 +5499,22 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		vmf->pte = NULL;
 		vmf->flags &= ~FAULT_FLAG_ORIG_PTE_VALID;
 	} else {
+		pmd_t dummy_pmdval;
+
 		/*
 		 * A regular pmd is established and it can't morph into a huge
 		 * pmd by anon khugepaged, since that takes mmap_lock in write
 		 * mode; but shmem or file collapse to THP could still morph
 		 * it into a huge pmd: just retry later if so.
+		 *
+		 * Use the maywrite version to indicate that vmf->pte will be
+		 * modified, but since we will use pte_same() to detect the
+		 * change of the pte entry, there is no need to get pmdval, so
+		 * just pass a dummy variable to it.
 		 */
-		vmf->pte = pte_offset_map_nolock(vmf->vma->vm_mm, vmf->pmd,
-						 vmf->address, &vmf->ptl);
+		vmf->pte = pte_offset_map_rw_nolock(vmf->vma->vm_mm, vmf->pmd,
+						    vmf->address, &dummy_pmdval,
+						    &vmf->ptl);
 		if (unlikely(!vmf->pte))
 			return 0;
 		vmf->orig_pte = ptep_get_lockless(vmf->pte);
-- 
2.20.1


