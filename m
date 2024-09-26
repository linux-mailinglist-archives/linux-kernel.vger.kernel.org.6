Return-Path: <linux-kernel+bounces-339966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4C5986CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B5F282684
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C965C18784C;
	Thu, 26 Sep 2024 06:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Tr/fvUKc"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E8718BC11
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727333226; cv=none; b=YIvejsFn2IsSOlMlxhmMGVojmc9m9pLwdBhoIJlkwjH4bFKiO+dteLL0p2EsRHxYC2DxEb5YattSOiGI7HFw56beP7IK3X+CdN3XBnkxHIAX46Or7i6y4PqYqIngkWFSIrXXWkuriKhyIpTByzh2aRAJMrZb79fNTOKr7WhzZSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727333226; c=relaxed/simple;
	bh=Ks+ctZjoe6oexIKNJorWHsj/FHxBIY1SArqgBxdFKSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aQ9yI6cBaszecsBxzBU8DLx1sm4rm4kvF5HpGP3sVmZA0mi12QXJLsurk3VDvWsscPazc/zG0Rfs4uXOWDT8i2e4i/HdQ8uqJh5aRqKfuyYkHzzd8KdOId2L+K2TAfP9lbzZ8SBRD3y44AHMTmrYk2eAOuo8WGSaFmpCZADtPiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Tr/fvUKc; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4581e7f31eeso4520651cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727333223; x=1727938023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WBwKEY9MWquOlo01BPdpzLz4TZdRIsQgPATlcDwMyk=;
        b=Tr/fvUKcc58vOt9T5WNPQo5DDKH4D5fwF3PLuyXco5Bry1fpyt9uMM6WYlM3gLSOJC
         qXhRmuOvoEsnwppLbU7qOcDV9fFrBix55WOrZj/vFJHUuAFNzYW6SuDTym1FuXM/p0dc
         ZfLrK7lnUAMECNqDg8gDoy/Add4CPKaIeA7Y+0f8fOWAhH0sV8CfTwjFcZZ4/f/rLYo9
         pg3phgzpvGEs9ZqF+WaX6Z8vD6EznVSExwi7314QlF1hiq+G4n7FdsURkx9JRtPIQB3Z
         UbPtpF5D98IPg+aSFPTj1iRxObDFfWL+yUTXeln+87HoBblQYhNzLxFqSHkX4wUZvF1H
         NN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727333223; x=1727938023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7WBwKEY9MWquOlo01BPdpzLz4TZdRIsQgPATlcDwMyk=;
        b=SusIVyAVJunkJYSBUHpqG0Go2hLYK5dFQAeTZpwddb09ZhK7o1fsTxKzVWiBMZodoc
         7ngjEn5KnKohEg4kmfsLZ6lB8OrE8g+TIBLp3JYnzp3bT7dGYuQ6DNXSqC/gal5HO35Y
         lWYtlTxifFtu0aqxDkt78S8f3UzG04YnQa8vLCUp66eYXXLR89kVJBmvHpf07QBGXVpe
         I+mQpeH2njZB4MjTPqJoT2FIxMXZjO/pMMiSOFnCAdGYGx6RMtrHxYiscIFUe+ziIu2Z
         L0RQtHVx/Y/ZfvL8iJqnkWpTfYLMUXlF1HyvPr+357st7iDG4mvFAoqIXI8QGdzYAzkl
         u6qg==
X-Gm-Message-State: AOJu0YzChHFfwtulKfEzswOmm6RJM3buxi+R2OJHIGH6eMMWOVlecgC9
	5AvHkHuiXGFooE5IqXzMsvNOk2quDrGQFQLxQ3iOOyC+pRIBrlcwMvE7iiepqfo=
X-Google-Smtp-Source: AGHT+IHKcdRFC9q2GD6595fUPe4NgxH7f7bGHM/1jVFUOYjtanMZU2hJPsIx01XdKDMweQg9NQ43+w==
X-Received: by 2002:a05:622a:105:b0:458:4c86:4564 with SMTP id d75a77b69052e-45b5e0952b0mr82475131cf.37.1727333223424;
        Wed, 25 Sep 2024 23:47:03 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b5257ff1esm23024611cf.38.2024.09.25.23.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 23:47:03 -0700 (PDT)
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
Subject: [PATCH v5 02/13] powerpc: assert_pte_locked() use pte_offset_map_ro_nolock()
Date: Thu, 26 Sep 2024 14:46:15 +0800
Message-Id: <42559e042eb6fc3129a40f710d671712030646b4.1727332572.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1727332572.git.zhengqi.arch@bytedance.com>
References: <cover.1727332572.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In assert_pte_locked(), we just get the ptl and assert if it was already
held, so convert it to using pte_offset_map_ro_nolock().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
---
 arch/powerpc/mm/pgtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 7316396e452d8..61df5aed79894 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -398,7 +398,7 @@ void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 	 */
 	if (pmd_none(*pmd))
 		return;
-	pte = pte_offset_map_nolock(mm, pmd, addr, &ptl);
+	pte = pte_offset_map_ro_nolock(mm, pmd, addr, &ptl);
 	BUG_ON(!pte);
 	assert_spin_locked(ptl);
 	pte_unmap(pte);
-- 
2.20.1


