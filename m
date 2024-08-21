Return-Path: <linux-kernel+bounces-295113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA8D9596F5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546BA1F2195B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 09:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C316E1C86F8;
	Wed, 21 Aug 2024 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="c+asUPRD"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEB61C86F2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228423; cv=none; b=I6X3QYIsaJub/17vW7EafN463VwWpHh4cmqa+7e9nOFF4/JxMlwqv0EUAtEeKWb42G3a1xbaTLWfq5G20JxQPUNVzvFeT8FqROrrPzGVeLyyGciEACcJTZ8XY58W/ocI1HPE0PMOz1IdQRbfcc8fx2N9vDQKqYMFeb8EuvVy7VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228423; c=relaxed/simple;
	bh=xZxfKK2WH1d1pr19c4Cwsg5EAO66G+hvyLkF40Xhpj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mx0cDFz+mR5kwYUfJIXE+DTAiJYVorZUSiwIlLz+WEhgooZMsOXqLC0Hqa2heltRZsfN7jX1pKhL872HAZ19ABe4lssJjkdvwQaY+DxzLNQNaatpK096iGw6qkXVk0YmwTCLlsxbaGu8GjZ14kSvEQaI82un/fTXk4P09ouDZow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=c+asUPRD; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7c1324be8easo376477a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 01:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724228421; x=1724833221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ib2peXsn8Xzv08d3et99PPledeQt2suHPjEB9mw45Nc=;
        b=c+asUPRD4R4IaZErVcVCapOTusoSxw2z9GaG5BsWC7WPQOhC2LRQyRdCcB9yXp5woX
         NMj1mEK1tzrOo4zxyTpHVYnoTkmjUII1lcNVncxwhulouLuvLMvxI8UCZpCMDw64AxJC
         wDPsm2/wC5FJMwoEsjiCespNwvDliHUYbCx0Eg2WOJTRsDJsH7h6dGeHzubxgyWbt5Ae
         YWC1kqDB0fOVJ/QPmf44RfHrL7kLh1hp6FAELx8cXgHKtQ9Fb3FFE/L7ubsWDjjRpJTa
         WIOqYzmdVMdVHrN7FN0WJ0HoNVcjJh6ZUVmzPUlyMiqIo4SUqiSqK4nYaxBRWsr/xabX
         q44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724228421; x=1724833221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ib2peXsn8Xzv08d3et99PPledeQt2suHPjEB9mw45Nc=;
        b=bmvQ2jwePaGpYAINFNJLtWsxR+ooS6IOzR/rHsOeEsT39WzSCsA2F5bT4Z3RUTFsrr
         zYdkDdpM/1r1jJJL1zIjfiL5+fNR+COIW9YGCOpUcPA2NusBE99DKPCE5hu6MMK8suP9
         HpgMUCo0wu+YUI7jAFrgM004GThdU0Sbox2jXuiVRRucXGscRXuqh8XvgzMdPU8oMJP8
         V+Mn/2q/FRczL8164DKIF4L0gHfWXFx+hTzUo8c+zPYBBtluU3VVJuQmqUzqhFs808lM
         g3KIU3+LQIaauLUgFhZlpBmij/AYKvbnqmAulP/kR8LHQIU9wPrIahVNtzNYdbQpUyi+
         kCjg==
X-Gm-Message-State: AOJu0YzYCAajupPAWdoDE9Am73WuRHEkiOYKLdrjtYDDD1eHP9kuQijz
	wJzpvm6u3Z+AXpsC3N/r3SdKi2EHAv2MCXyT0g1PHR1Husu6uRHAZZ8vhtmkTO8=
X-Google-Smtp-Source: AGHT+IE93wrdhvj1jPWy5zvxTPwSbhlcdosDYnf+NOlDda6ytSjhdKrpXWKVADSrOUal4AF7Aqrd8g==
X-Received: by 2002:a17:90b:350a:b0:2d3:c084:9d93 with SMTP id 98e67ed59e1d1-2d5e9a2f0damr2610948a91.14.1724228421082;
        Wed, 21 Aug 2024 01:20:21 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb9049b0sm1091453a91.17.2024.08.21.01.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 01:20:20 -0700 (PDT)
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
	ryan.roberts@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 08/14] mm: copy_pte_range() use pte_offset_map_maywrite_nolock()
Date: Wed, 21 Aug 2024 16:18:51 +0800
Message-Id: <05c311498fc8e7e9b2143c7b5fef6dc624cfc49f.1724226076.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1724226076.git.zhengqi.arch@bytedance.com>
References: <cover.1724226076.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In copy_pte_range(), we may modify the src_pte entry after holding the
src_ptl, so convert it to using pte_offset_map_maywrite_nolock(). But
since we already hold the write lock of mmap_lock, there is no need to
get pmdval to do pmd_same() check, just pass NULL to pmdvalp parameter.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/memory.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index d3378e98faf13..3016b3bf0c3b0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1083,6 +1083,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	struct mm_struct *src_mm = src_vma->vm_mm;
 	pte_t *orig_src_pte, *orig_dst_pte;
 	pte_t *src_pte, *dst_pte;
+	pmd_t pmdval;
 	pte_t ptent;
 	spinlock_t *src_ptl, *dst_ptl;
 	int progress, max_nr, ret = 0;
@@ -1108,7 +1109,8 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		ret = -ENOMEM;
 		goto out;
 	}
-	src_pte = pte_offset_map_nolock(src_mm, src_pmd, addr, &src_ptl);
+	src_pte = pte_offset_map_maywrite_nolock(src_mm, src_pmd, addr, NULL,
+						 &src_ptl);
 	if (!src_pte) {
 		pte_unmap_unlock(dst_pte, dst_ptl);
 		/* ret == 0 */
-- 
2.20.1


