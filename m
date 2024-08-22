Return-Path: <linux-kernel+bounces-296756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6D295AEB4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F531C2346C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A58B17E010;
	Thu, 22 Aug 2024 07:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jgVV2gB5"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29AE17E017
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310842; cv=none; b=b4DaRN5XBe/TqYUU78YD6SYhmfwNzo3EPYvQ7jCdBCNDGOJLJz+v712Xn1C0EeTXYlNL3XUnanTLYBPG3dqNjvOelz9N7SrwDj9G5zeja0s/gYEaBQC4HQvk1Z99inQVUM8jO54DrXdbDOKg+mNzhhqWhsLmApX8fO27eHMFvXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310842; c=relaxed/simple;
	bh=teCrZ+KkZo6t4Or+udcvaGbXMI71z8Jup5FtH5y7iEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F3u34HMo8a3jnsTkQswrTWtS3qWgLgI7Zb3nC3du5IB+Er15TiZz7ylWxW/TeA9qklSX9BRdxQg/G5dnHNFMTxD/VClnI94b/1yK1tWu6E7MyGedwwc+OxHoU7jaEkQVkIyblhd7OJahrQ0cBvQ3xsmK6Y9rDfD8i1Do26k9JGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jgVV2gB5; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7cd830e0711so482772a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724310840; x=1724915640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/m1IXPfk7xvDU+Qn41r4NiqBFnWc/gEWMU/opSilGI=;
        b=jgVV2gB5HUOcTcQdvv/+80zLDKJW01SWXJSVjMSFhFIu4hIloKYuC4+dSWaY2Vxrgr
         6m+UDN8wZ5gdfGZ3Z61GSEE98Qwiho5wfSiVxJp5VgxQfz0bHZVD5N9zNO2wEqMxFs91
         aIzh2YTPejzQ02S78aX5SoaE01lqhRJAN6Rg0vX3IYqVXMu7z0PPNgxvcwdEY/T7LTlw
         7h6Sv03dUppIvVQQybaxIsWyYafvyATJDPyTlvVOf9afKP1b0wIJFbN19rlafBOasUUF
         Yo43ZzSHh5UEf+RnMZ+ysu7VbxjnZAZ/Mo+FLdhIVcLMD80cjUjwNyE5eOPsrt5MxpmG
         oY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724310840; x=1724915640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/m1IXPfk7xvDU+Qn41r4NiqBFnWc/gEWMU/opSilGI=;
        b=WmjefoIX7Yc4mNsoFkcUzRK5666b4eJSJjHnDjX/TFGZykdSLl7xkyIO/ncdcIjFpr
         woJrgwRUnxuLKGuG4x+cbcVkVHhLqN8B04wdJ3amajRg0JGJYnDwQi2x2Rd3muS6N2zY
         3nFoH1uPqQ7ZUIMEzePRfPpMMJFUI5uXOQvPKMwBFG32ctxZ2ffPkRy14BYN/sePMwhU
         ZejPjLQkdyVmy8qIl1rku3+B6ZzQncH9fei4O1YQ8e+G9fVbtjRGOFKhB3RPRILyrSWK
         VI7+pvBWV60oBdbeUDwB+ZKppYbJX1vjXIeKOoMqqyIMMB4KTnPc/y36OtxQ/sfbS6qE
         TYQQ==
X-Gm-Message-State: AOJu0Yy3pp4DEpxvzfzqbYt/D2PYj3un2M3yT3FPWuxVfHTnNLWVekgn
	xNCDGtEOmmgTlVHcvP0tXIyo2hpdv0fqqjf8DVTHLaFtVw4ovlUg3OcjkBYj7Go=
X-Google-Smtp-Source: AGHT+IEhsa9RMy8FC6eeC7Dc/qzW9nWoiqPGY6DtNfgP/dDTOo2T0oKgHsMPC17UGp2n78kSJG5uNg==
X-Received: by 2002:a05:6a20:6a2a:b0:1c4:9c08:5df3 with SMTP id adf61e73a8af0-1cae51cf01cmr3205085637.7.1724310840022;
        Thu, 22 Aug 2024 00:14:00 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([240e:473:c90:f96:d029:ea8a:4e6d:d272])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac994a3sm695095a12.16.2024.08.22.00.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 00:13:59 -0700 (PDT)
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
Subject: [PATCH v2 02/14] arm: adjust_pte() use pte_offset_map_rw_nolock()
Date: Thu, 22 Aug 2024 15:13:17 +0800
Message-Id: <7915acf5887e7bf0c5cc71ff30ad2fe8447d005d.1724310149.git.zhengqi.arch@bytedance.com>
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

In do_adjust_pte(), we may modify the pte entry. At this time, the write
lock of mmap_lock is not held, and the pte_same() check is not performed
after the PTL held. The corresponding pmd entry may have been modified
concurrently. Therefore, in order to ensure the stability if pmd entry,
use pte_offset_map_rw_nolock() to replace pte_offset_map_nolock(), and do
pmd_same() check after holding the PTL.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/arm/mm/fault-armv.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index 831793cd6ff94..de6c7d8a2ddfc 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -94,6 +94,7 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
+	pmd_t pmdval;
 	int ret;
 
 	pgd = pgd_offset(vma->vm_mm, address);
@@ -112,16 +113,22 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
 	if (pmd_none_or_clear_bad(pmd))
 		return 0;
 
+again:
 	/*
 	 * This is called while another page table is mapped, so we
 	 * must use the nested version.  This also means we need to
 	 * open-code the spin-locking.
 	 */
-	pte = pte_offset_map_nolock(vma->vm_mm, pmd, address, &ptl);
+	pte = pte_offset_map_rw_nolock(vma->vm_mm, pmd, address, &pmdval, &ptl);
 	if (!pte)
 		return 0;
 
 	do_pte_lock(ptl);
+	if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
+		do_pte_unlock(ptl);
+		pte_unmap(pte);
+		goto again;
+	}
 
 	ret = do_adjust_pte(vma, address, pfn, pte);
 
-- 
2.20.1


