Return-Path: <linux-kernel+bounces-336582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E64C5983CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233161C226CC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EC9770E5;
	Tue, 24 Sep 2024 06:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Oec2x2KV"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3040F74BF5
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158249; cv=none; b=ht8g1WatZGgEg4vVoyHppBOMAZQ+TPyg6QaoOAy3R1ZX11UzEKqCpYZanIisR2O+XVLjguwRd1BluO6vW+RXZjjJey+oOZpdccN/mEeVUt6VUkNSP2OYAsmCx6JZjWyopp2yyYMk4UlD1hXK58VQKxxyCVoUCf0ZV0rFSLYl4Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158249; c=relaxed/simple;
	bh=CYi+EZMylLlMSCqw/uJB5X9IiL/Hx4QgVrtaCgCZ208=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qGTMlibivGixI6SIdmi3JoIz9cdxZ51Z7yz4G74/TfMdwPNrPNx5J59i7S5vW5ZFRHUXrvFAEJJoHIziL0PbVgHzNjO556oB46xfWt/2lao6/dvk9cNlVzqVsebiysO6OnMVHN6YoY4T3mCQP6Bav+HBAQGCv9WN7/4Vf7AtT8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Oec2x2KV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2068acc8b98so47504115ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727158247; x=1727763047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmENsM1LVZMrc0W501TyzYIERT8c75Mhan1AJ9vs73Q=;
        b=Oec2x2KVXW3dfQVoamAzAS9d3PTvzSypv30M057Vd9KG5coCvh5bn/F+f8LqriNumk
         sibw4pjPGETHMb9WAn4Je73OJRORhF23XghApfuJC9RhiffzjbTQz3sepwKGhOM3U3BM
         jfHkrg032omPxzvf3k/vtqBDmf8lYsYKedkjscyKXZAyaH31hkGdKEpq3WSWWLqvTcrD
         orVzs2H33VVFsxrEHHGPP1SM3j6E9FD4QCf/NMksZmQl6X4DhYLAiGsq1JiMqatLLDKI
         y7RJk9vrPdjYX+sKaaPeXwxU7Y9aseUq5V2sqcgK5Q5Xhz63ZqSu/+TzoVI89EN3rdwp
         da3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727158247; x=1727763047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmENsM1LVZMrc0W501TyzYIERT8c75Mhan1AJ9vs73Q=;
        b=f3Ok1pn26Z1CNbrb54zSBW9yXoymywnPj0J4KM6Xiu+FAtTePnhIMmR800EJNafMkk
         r8LQHL1mwSm83F2eiZUsVXtCsHDYssI9ee9G7KM0HtcuJsviV+ge8MAvCs2LJR5DcxVz
         MxllE9hcioKj/9koinqGAGEWDi5n3ZHg2ef7U89xT4eKA4NksnsabgDCdlgca743jWbt
         PzWPs828vHWl++4+GqKxFQsU2iLFNR4gV8ke278MxwwoqVLSlw+D6FbOfQZT8D6YJVAT
         MC0BWpXilQT4fxtj1VBQTJTaeWk01TpMK3IUBFUErj5PtLb5Mve1HY3+mU8h9Eo/fMyu
         OuQw==
X-Gm-Message-State: AOJu0YzU3MjTDrHbIyyepVKsJpkHW1SfhzpPzNklMqsCKH5lnyminhVX
	C2XUOzuE4e/dFj7FbgUeStESLTRy1+9M7zR/nRCDaK4ke5WhtZ9v74p0oTp/gF4=
X-Google-Smtp-Source: AGHT+IGm87aqttqV2Aef0OLuq60VY3Mp4w41J7dgMXq2Y+1L52786e2U6HUOab2ZHlW+VZaRsZgruQ==
X-Received: by 2002:a17:903:22c5:b0:205:6f2d:adf7 with SMTP id d9443c01a7336-208d83a8387mr177369015ad.21.1727158246651;
        Mon, 23 Sep 2024 23:10:46 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af17229c9sm4344885ad.85.2024.09.23.23.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 23:10:46 -0700 (PDT)
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
Subject: [PATCH v4 03/13] mm: filemap: filemap_fault_recheck_pte_none() use pte_offset_map_ro_nolock()
Date: Tue, 24 Sep 2024 14:09:55 +0800
Message-Id: <d90ff787a51aae928324ef2df0a3012818e261fe.1727148662.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1727148662.git.zhengqi.arch@bytedance.com>
References: <cover.1727148662.git.zhengqi.arch@bytedance.com>
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
index 3e46ca45e13dc..6c6ff8722550f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3271,8 +3271,8 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
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


