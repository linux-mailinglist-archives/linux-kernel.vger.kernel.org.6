Return-Path: <linux-kernel+bounces-296772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9443595AEE6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5144A287565
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB943187350;
	Thu, 22 Aug 2024 07:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ErxJaY8c"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC91E186E59
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310876; cv=none; b=jAT1ZznNQRpkEP0wliENfiRlQBdVmaKHqH1M6iSdLhX3PgIaOVuq6WuW5pkl+bwbNAlpmrsmujoSb+bY6RLS/2CkgRf2F5YP9/ZUlc0f8g/TxTQf5Sau4+g51vuCHS67gFP8aeKfRDQPbPBf961mv9AYgiq4Q2kdPN/auUNFZjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310876; c=relaxed/simple;
	bh=WdDTWPZUPkSR+kcJuyPx2uR8BaTylSuO9xQOyQmoS7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=csZGugFPKsi6yBnoSCxzn6AUjum74XJMU4z15BOK8B3kaiVZue70RFptJcsLmeOMejOym//fPtjP3fClfeOk8uxLa9tyP5Oz3I30goOdzePXWs5ih4joTEWHuKLmFZ70abMz5RJ2Cc5rVsGshBwPjSOpEHlulHYGKHIlifWkjOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ErxJaY8c; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-713edc53429so393939b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724310874; x=1724915674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lG9D96+xW+VlDYZHTIMi8bcfezh9NEOiBopQjA6w29o=;
        b=ErxJaY8cMvWIqMENGPWTrpgSx/6nOKfPjChRLppkUwiYLndY80aOsf81E2sES/l5mn
         nx/CYnT2s+0rilg1MW/zC0GU16FotNvM445/SoN1PqeinqUuyaPWcclR6sajvoszNlDP
         l741y4q5vi1aOqDYq6JFzKjnqQxcBxnJyn/BX8XNaSv4uhsghzX/7UG4vXPF5ah9aP4v
         RTYvIO0df6CEPGvb9+67vJuM4JEPMTZMw+e5fwOD1zIlK0Rf/ffD93XFkpCul5yF5G4H
         WoseaOcPWwtu8ZJNsqaQ18h4Lk6d1KtMK5GkRy49T8NGSmXHT6K4xNcbgL00O+qGXfkT
         9wSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724310874; x=1724915674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lG9D96+xW+VlDYZHTIMi8bcfezh9NEOiBopQjA6w29o=;
        b=cvejM8v1jF22FpgBd2quc+lllFfyndL8xyKeQJABg3apPU6cnhJvDr9JkCSoPpMREn
         s3Yued6RraTzV+puhcGLCBOVmdg4dRGYDnIGJgwfcdH1B/Lej49yN6Lk+IDTstv0FIFB
         6EaHdfylcyJOG+0g7c9vTIh0cAVFv/tNocKYkXc8s3hDVDFfGEDSaFpFwbI4gCMHhQcp
         wgXcJf165zEw716N5QqpUnj3wJC7sgDgbuqN7ayYruDFiYf6ZytEU3orYTKwJT1/uA+V
         yayqdCcpf0xPOnT3E++bgG4O19P6+nSMZ2iX9hfad/qhG8odlJ4kwE8Ch0LmoQPlT0Ux
         dHug==
X-Gm-Message-State: AOJu0YwyvgLSQ7zHvglrByENZWYTB6LNbiekCrcYUHEg2NLnKEOPo+Eb
	dE3gwELPlMQI22b04OMS7quwxwcO6wUFX5NIwYreTOI+7F080dRI0getT9hYfbQ=
X-Google-Smtp-Source: AGHT+IE1Azw7tBspdYFUO9+EydXCiNKc3KqrNzafyoF+69WNl4yC4JRDYA6cJOAAfX+V+yHVonAuzQ==
X-Received: by 2002:a05:6a20:9d91:b0:1c4:f209:f1ea with SMTP id adf61e73a8af0-1cad80f657emr5853305637.31.1724310873985;
        Thu, 22 Aug 2024 00:14:33 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([240e:473:c90:f96:d029:ea8a:4e6d:d272])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac994a3sm695095a12.16.2024.08.22.00.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 00:14:33 -0700 (PDT)
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
Subject: [PATCH v2 08/14] mm: copy_pte_range() use pte_offset_map_rw_nolock()
Date: Thu, 22 Aug 2024 15:13:23 +0800
Message-Id: <71100c3867c4cf6f5f429ce9f2db8432066d0e99.1724310149.git.zhengqi.arch@bytedance.com>
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

In copy_pte_range(), we may modify the src_pte entry after holding the
src_ptl, so convert it to using pte_offset_map_rw_nolock(). But since we
already hold the write lock of mmap_lock, there is no need to get pmdval
to do pmd_same() check, just pass a dummy variable to it.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/memory.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 7b6071a0e21e2..30d98025b2a40 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1083,6 +1083,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	struct mm_struct *src_mm = src_vma->vm_mm;
 	pte_t *orig_src_pte, *orig_dst_pte;
 	pte_t *src_pte, *dst_pte;
+	pmd_t dummy_pmdval;
 	pte_t ptent;
 	spinlock_t *src_ptl, *dst_ptl;
 	int progress, max_nr, ret = 0;
@@ -1108,7 +1109,15 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		ret = -ENOMEM;
 		goto out;
 	}
-	src_pte = pte_offset_map_nolock(src_mm, src_pmd, addr, &src_ptl);
+
+	/*
+	 * Use the maywrite version to indicate that dst_pte will be modified,
+	 * but since we already hold the write lock of mmap_lock, there is no
+	 * need to get pmdval to do pmd_same() check, just pass a dummy variable
+	 * to it.
+	 */
+	src_pte = pte_offset_map_rw_nolock(src_mm, src_pmd, addr, &dummy_pmdval,
+					   &src_ptl);
 	if (!src_pte) {
 		pte_unmap_unlock(dst_pte, dst_ptl);
 		/* ret == 0 */
-- 
2.20.1


