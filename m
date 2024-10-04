Return-Path: <linux-kernel+bounces-350785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 112069909AD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B123A1F23A61
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0073D1C7292;
	Fri,  4 Oct 2024 16:48:41 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26221E3789
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728060520; cv=none; b=PCva4nYt780mn1BMoMFAIj1i6bt6keq8zO1yiJFpSnjXyuT35bpPErEhrE/smffPa9kj75Xiha18i9eggAyPnLdIu0jqikQqBdLBeuS/gQGxvmq8Zz93u2xmG/7CXc8TeoG64LSGoZ5yDvsR7pXgVLctF96V1HCYH46Y/dhDziU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728060520; c=relaxed/simple;
	bh=9lKhJJ/QjmMQmV2xKqfO2s//s8Nq5B6tcf/3+zZ5wFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xzsl3P0eU7TLGsZbX/oo45JvDBis2jjHHDT4MqJM2l0RZ1ZMXpV945PfNRTA2bT14G+s8sQDEnfM34kjHVXMXuJMZYmnV4z16b2LEyEA+z0idaX+UB7V15hvMaj8oEw26Tk2Ze+7drFPmjwd/p+QWUt/f+0fvHZpyr55ALGqwVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5398e7dda5fso2449700e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 09:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728060517; x=1728665317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJ8pYY6Zd7fddNahTZhdRdnv30EEZoS+DZMVU4schMU=;
        b=W8rLbepn3bRh/X+vvWdWEKipHhY10npu+yu5xk5yIc7r8yC3i23HepabBL8r+yjheh
         v5tm0VVSCR6CdPjoPleT31NSWfgqbBs4QyqmmP2ka0PNipU9/YtTu6Z29JevE0sYeqma
         X4V4+4R55gS6AzJnewyjGgFhJN02/V26mVMAUNDNgK4KrR0PvFAgcLMumil0fZsLk8Nt
         Tbk62av09Wu3efVXxKFcQqhrvfR0KtBFLo6susU5OZ4i2X/YsW2N0evUDUKIK93bDZuO
         zNuebAvJUp+1zytBlPqXSqnDWLLgAvByFqbqcqnvIdUpzmDV8QHCTzWexOPZ40O+Xcww
         lmZA==
X-Forwarded-Encrypted: i=1; AJvYcCWqD3yljQhMdIWnCLM94ZoHb2qaDHG7cWcxMEHDl0SF4KJHvH/PTcn/LJjH8FRZPj3Bgh30n4y06HzPq5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy59dyMQdab5lCXTq4CITwWI5e9Wz2RfJMNBGlPbFkdSoKoXUbi
	MmT1k0tGWi9pY6sD8LXnkDjY3eImD0UQfXxj2Sv4vh+PZ3MHDm5S
X-Google-Smtp-Source: AGHT+IHHbsB5ExN8EODYivpvboNCip8OBKovQd6mcj5VWlTiHwfnQxJ0d1YJMNb1m762tSIe8X7/dg==
X-Received: by 2002:a05:6512:281b:b0:536:a583:2777 with SMTP id 2adb3069b0e04-539ab85b5bemr2219263e87.9.1728060516717;
        Fri, 04 Oct 2024 09:48:36 -0700 (PDT)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e7c46e3sm14141766b.180.2024.10.04.09.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 09:48:36 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: kernel-team@meta.com,
	linux-mm@kvack.org (open list:VMA),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mm: Remove misleading 'unlikely' hint in vms_gather_munmap_vmas()
Date: Fri,  4 Oct 2024 09:48:31 -0700
Message-ID: <20241004164832.218681-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Performance analysis using branch annotation on a fleet of 200 hosts
running web servers revealed that the 'likely' hint in
vms_gather_munmap_vmas() was 100% consistently incorrect. In all
observed cases, the branch behavior contradicted the hint.

Remove the 'unlikely' qualifier from the condition checking 'vms->uf'.
By doing so, we allow the compiler to make optimization decisions based
on its own heuristics and profiling data, rather than relying on a
static hint that has proven to be inaccurate in real-world scenarios.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 mm/vma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vma.c b/mm/vma.c
index 4737afcb064c..9d4fe794dd07 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1250,7 +1250,7 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		else if (is_data_mapping(next->vm_flags))
 			vms->data_vm += nrpages;
 
-		if (unlikely(vms->uf)) {
+		if (vms->uf) {
 			/*
 			 * If userfaultfd_unmap_prep returns an error the vmas
 			 * will remain split, but userland will get a
-- 
2.43.5


