Return-Path: <linux-kernel+bounces-314568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AB796B548
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9715928B8B1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352F61CF5DF;
	Wed,  4 Sep 2024 08:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="S5IPLCIZ"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE4A1CF5C3
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439271; cv=none; b=nBCBcspPmiakuZqJYYdwnLUK2MqQ2LTB3SBFZf6hoJfRqDO13n//Sh7Cmh+Ft4bSRLhcuH3m0Y4ltOBfIt+jC//CwGntXbal4IMG9PxPmEebashLzjmu2vnZ1ehdT/DMawEAL1VikWsuwWwpT+T8HdM5F0mEBEklv1Cd1fAqsnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439271; c=relaxed/simple;
	bh=ztiWE7lPSf5Qz3/xb/OElUVpR656wNTzrQbQRyJfRhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oUGmWDSAlj1DzCp+X7B9CDRDWd7ckDHusLHvmuxZA01vbVp2G71GFgT2PLTihd/sl1CHUU2l4100uJUd28BEcV2O/OVtIx1d6X00oQXFuK01HidUh7Ex7Ue+PP6Rcjj2aTR1iZkxmvfzVZO3CJG9OpKPEc3hNChK35q5VwJKDuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=S5IPLCIZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20573eb852aso3452845ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 01:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725439269; x=1726044069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mwcb7WVpeL59BmxGU8FtBVb/FvaDY4mjrVacU9l97yw=;
        b=S5IPLCIZu0tOxgny9stAU34AGmZRLAdlHqzvwAul8Z6n7RXS5hC6v9DmtbH4HEbRX3
         ttLgX7p/oh20N1Z1PZFgJhvt3ysLzRMAhaDdD7zmg1Xwt60YryH4K9gSPAC70DMzBUEY
         j6ApuKfgntVAIJxEvOEzWVMjGpKwdJYnUM0/yyGsZVcXm9tyNBIYCqXGQG69DBottaiN
         UP5eRuCplGs5bX89dmQRs2+E3Tac3rSHJvn/7Juv2I1yLQzkOMNZgHX2B/vGxLAAuAW+
         YGrchhfbdSzAI0v/ClwQ8Bm+4+CF/KHNKHSBoh6bNVErR+d6jdHTwFyZA3mxGk7pgk5R
         aK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725439269; x=1726044069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mwcb7WVpeL59BmxGU8FtBVb/FvaDY4mjrVacU9l97yw=;
        b=p34AzCmKYTxJoDGXz71gEGoPAtw+3HCfXTC0PYD0tb2B99RtU2pYGmiGPOkcU/oxOO
         Fn08kbe2+b7+hs1tm/pCiT8FG2XfnjKWUEtdP2UJTkn6ndVvVp7w6BCPydxbXbguQTvp
         /7bp3znOXUIu+lG8DnkINhzhOGRrP2JgvyHJIL33iZWX18s6ro8qaE1nf+Q1zuBbUDNk
         lpKls8sWg9jmS0WEWGX5CIz5mdVdbl+vv4zkzMbndCNB/riL2RzcqADFVJa/Lw4FCdKt
         PDyXqURc7VCKCmIj5kmYHM/tEk7W+kXBqOaGHuk87XYdEGSFsijfDTb9OkGVvrES7/ON
         btiQ==
X-Gm-Message-State: AOJu0YwncBqBC7ZCG9f479vTLiEHa/pIvzXGDZCySSHUHAtlAaH/hif8
	OPmAWDMCwv8MTQAsHatj64YB9wKnWfHE8fpr5UjIMmXkAFbWmzfYfobjEK9aS+k=
X-Google-Smtp-Source: AGHT+IHVi0h+YpQWstt2F+C2N++FuREpmzHqlVlqHX+adh/zaJT2MbahvdDpXAnk4gZu2G3FJSfhgA==
X-Received: by 2002:a17:902:f60b:b0:206:9dfb:3e9e with SMTP id d9443c01a7336-206b832146bmr25150715ad.10.1725439269514;
        Wed, 04 Sep 2024 01:41:09 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae95a51csm9414045ad.117.2024.09.04.01.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 01:41:09 -0700 (PDT)
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
Subject: [PATCH v3 04/14] mm: filemap: filemap_fault_recheck_pte_none() use pte_offset_map_ro_nolock()
Date: Wed,  4 Sep 2024 16:40:12 +0800
Message-Id: <20240904084022.32728-5-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20240904084022.32728-1-zhengqi.arch@bytedance.com>
References: <20240904084022.32728-1-zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In filemap_fault_recheck_pte_none(), we just do pte_none() check, so
convert it to using pte_offset_map_ro_nolock().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
---
 mm/filemap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 20346df53df3b..216405ba497ea 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3251,8 +3251,8 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
 	if (!(vmf->flags & FAULT_FLAG_ORIG_PTE_VALID))
 		return 0;
 
-	ptep = pte_offset_map_nolock(vma->vm_mm, vmf->pmd, vmf->address,
-				     &vmf->ptl);
+	ptep = pte_offset_map_ro_nolock(vma->vm_mm, vmf->pmd, vmf->address,
+					&vmf->ptl);
 	if (unlikely(!ptep))
 		return VM_FAULT_NOPAGE;
 
-- 
2.20.1


