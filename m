Return-Path: <linux-kernel+bounces-278561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E8194B1D1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8F1283B42
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0449153573;
	Wed,  7 Aug 2024 21:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4kJw9y+"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7398F14A4D9
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065200; cv=none; b=XW4Lf8qNNPcMMnzuW9Faq+L1Ltg20Ea6GjYNvu6iVUrUDOMNAUV4LpZ3SykYZsGzOOSQPVhI0gHdkkJI7sFFx+IRugdDfZdWF4UAFWQrGxjBNempcn0LmVgRoq2D1NIW0BlDiuTCElVoBOR/2GaTA8s/fRGmLuagjg77xXC0Wpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065200; c=relaxed/simple;
	bh=adc+1M2MuwO5QW0JpRW5+vcWpcbzMyPH3TjLiKofQAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHQj/qnbddxER4+J5R9L6ErFm1lwvkwUezD4WjKntrmsQ3q3qC74TBXQymfiHl4kdHZP0UbgAWu4HwpeuOhEigLoIeu5JOH9ZDB3kaG+UGGTLSGcjqGNlG5H2BLctC3/+YrqLrEKwiiyJjT5yK1SQJOijn5dlPrhtXFJMTCAw4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4kJw9y+; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42816ca782dso2034135e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 14:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723065197; x=1723669997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3k8I48Q9YYmd4N347hipHhtPig8PZRgdw+eINOHLWZc=;
        b=Y4kJw9y+y0n89zX9L4nPtT3PxRtk7u1QwN9KJKH0Ehxb8EBsSgDMuz+BCPhH0Vdv4s
         9tM3Iw6rSOHU3kWesNO11ad88wrE7dCL7p/BRX/yG4rccgqV59FBKPOijDY/NnAC4+0b
         H5o5DE1XgkzypQTNYQ2BQguJNf0oIHS8OoJ0DtpGF9fimN97Caiy8ypRHy4uATC5jaJQ
         FVfEoR1kbstznMx5YDsdfuzjjSkgB8k7G80Vmz3roVyFLil1gabJKoMFbHyxjQiRBjAD
         EZBT2dOdct0gzzNi0ldU6BUsDh1utmybQI1S25tRtpaC7ElbyC+HoUpdDi/3HoflQz8f
         DNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723065197; x=1723669997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3k8I48Q9YYmd4N347hipHhtPig8PZRgdw+eINOHLWZc=;
        b=xJr+f1Lgb64ZzjcHq5Oq6yMHkV1EEcEoy8+CibemYVcX3phTdx6y0Na2v6AJ8vSgrB
         AanBDyz9Vx5iGn9VbC8K2VYMWsrI3/VLBErOBNwqNrbuKAH/kpTSw4C4djR+6+Wbhib8
         3tmUZNAiLRmLuNnUGv36yZRTy+97WIvDnh54127Tg2xOQPm5zaetommWcGt2KKZK/AX8
         oh3FYGavH4CSQvkTTWgsID8kyb33yOVAMNPNN9N/Qa379r2MBY7Ob5pvSZ3Pv13asYvU
         DvICrG3NoYx1AKp0twE5e7d1v7oXf5x44gHmhPWpw/fq0nnIfDbJs1Uux4UEdeFzihcY
         nodA==
X-Forwarded-Encrypted: i=1; AJvYcCWKrjDbm0QjcIq4y1od6gLBGLG0pu9xLdjG64nOU/1Hdbpognrgx89GT6Hz8+lNs6bd6WnZxMTDXwSDwAJ5FSli295x3qf1M6We7iZ9
X-Gm-Message-State: AOJu0YwhLKZ6l6HcrIF9b3dB50prB71XpZhZz5n80DBfnFC9KnPLlUYk
	32sZ1HvE5uqawJaoB+VvYnIzXYpHUGESNLKTuXjHB5/Ty3oSmy5d
X-Google-Smtp-Source: AGHT+IFrulQEOE6yTxkrgAm5+Yjks8+XzbkO2lRTVnCuLyVnQOOuaJYB61OWTGLzsBePku79xWdeTQ==
X-Received: by 2002:a05:600c:45d0:b0:426:6ee7:c05a with SMTP id 5b1f17b1804b1-4290aeaf247mr126145e9.15.1723065196743;
        Wed, 07 Aug 2024 14:13:16 -0700 (PDT)
Received: from PC-PEDRO-ARCH.lan ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429057a92c8sm45869525e9.23.2024.08.07.14.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 14:13:15 -0700 (PDT)
From: Pedro Falcato <pedro.falcato@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	oliver.sang@intel.com,
	torvalds@linux-foundation.org,
	jeffxu@google.com,
	Michael Ellerman <mpe@ellerman.id.au>,
	Pedro Falcato <pedro.falcato@gmail.com>
Subject: [PATCH v2 3/6] mm/mprotect: Replace can_modify_mm with can_modify_vma
Date: Wed,  7 Aug 2024 22:13:06 +0100
Message-ID: <20240807211309.2729719-4-pedro.falcato@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807211309.2729719-1-pedro.falcato@gmail.com>
References: <20240807211309.2729719-1-pedro.falcato@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid taking an extra trip down the mmap tree by checking the vmas
directly. mprotect (per POSIX) tolerates partial failure.

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 mm/mprotect.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 37cf8d24940..11330131e2b 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -588,6 +588,9 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	unsigned long charged = 0;
 	int error;
 
+	if (!can_modify_vma(vma))
+		return -EPERM;
+
 	if (newflags == oldflags) {
 		*pprev = vma;
 		return 0;
@@ -746,15 +749,6 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 		}
 	}
 
-	/*
-	 * checking if memory is sealed.
-	 * can_modify_mm assumes we have acquired the lock on MM.
-	 */
-	if (unlikely(!can_modify_mm(current->mm, start, end))) {
-		error = -EPERM;
-		goto out;
-	}
-
 	prev = vma_prev(&vmi);
 	if (start > vma->vm_start)
 		prev = vma;
-- 
2.46.0


