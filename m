Return-Path: <linux-kernel+bounces-276930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5BC949A2B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEF571F25314
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C4A16D9B9;
	Tue,  6 Aug 2024 21:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZwjIj+p"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86A115ECF1
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 21:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722979735; cv=none; b=HZo8mfeQp2zhhW9K5rc+uC9yqbfK0NjJJKKPDhvJOHJpc6I5Ez2euVGnK4AJK8zX2QGJrs4672+z+gxyzyvwI45+Mx8fd2e8ILpfdmUjdkmaiQFixvoTjk4Kycb6Go0QPRPhh2yyYaOfMYH2HsylgR5dZGgTwMzTNjmbonBdvdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722979735; c=relaxed/simple;
	bh=2kirhTVWWLqlAI3lvuPfg0Feo6DhPI52QGhLkxgRIEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oc8M2JY7m9Cw1SEQTwLFA8EmSweXCj7s54PUOYLbFb0vXrialExqTLmTZqQPLmI8/7q+LlGTdr/lMRXtDOd1+rOOEA7jzvI12kwlEBfuc6scsnyDrDsgZG+TpyhXjY43pDgj71H5OLoGRQeCoqq81L3NcBpXQqpomgbeGmNs+Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZwjIj+p; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-36bcc168cdaso726938f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 14:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722979732; x=1723584532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDYcnh60WLoSK67nH2jZrndTdBIH1a9KEd2iZeOMQIo=;
        b=dZwjIj+pUeZihwtTJ/9CBovCcJS9VhFxGOAzQxRfzzgg+bxCx5DYufQeE5B4YXmcJs
         adxWaAEXFk5G3nwzUnulVc45Euyor7pRiOjJc79Djb9YqL3CqF73kp0DoMMx0Pdsi4pr
         aPv2pOVWXxG4wmgT+Bx4Nn1sqBVIBb02o12Er3phhctRxRgQ2H0fApVG1G5DxE84aRlj
         vVUkseO+j0HQq+MteN47Q1eKP1f/9iiiOv+Fccd6wNIw0J5i62mtu+sWyWqzhzWlHwmH
         szmN3/WjcXnty+1poGF+MdPj+gWvEdfW8R6KMaoHssn/zBOMBYTFVn+6KR9iXhI9zbkz
         WqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722979732; x=1723584532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDYcnh60WLoSK67nH2jZrndTdBIH1a9KEd2iZeOMQIo=;
        b=hLdyHOwSE95y5uVCZt66i/Y0DUAcu0+GZ2nhgXqSRdu00q339Uq8oBDZIY3lLix5wM
         N9gKc0grb4AwZHsQzvhxiXaAze5UL1JhKKTBgUefqWznj5ZHEo0MR7n1CvXzZxFezeoS
         pXaMYYhjXlgxAeroBJVu5y8qlAVO39WWuB8ZAko/lJpDFaZktBjunWE/SBeSYuxN45gB
         xVj2rHkyAxOhUar71Jw2z48dK/4RswQXzBrUDzi+SD4Tj2SKPNxWj0EUvtQSfS9zQBu6
         lXX6+Dtr7+Qy+AwlH77DVLPrsFAo0K/bK2XR0MFaDhKYGcKq/b2DOf6AZnHbpZUP+T0I
         wRZA==
X-Forwarded-Encrypted: i=1; AJvYcCW6k0YyAUrweQBj9PLYde++fFBnXVzBkLizQe323/7/goSiZa6L0+yj+XAvUGBhOrmYnDqlNadO8ZyT4aX1jppRyCsdzNcuIivwVLJ5
X-Gm-Message-State: AOJu0YwsLr66qbyQomAI/CIbY0YO07cc+uwaIzyuq0O5G/onQFWNduRX
	0MPIOniyVZ+bM9tKpcHBTycHjETGnRA5UPu8zet+q8HqMG57sXJM
X-Google-Smtp-Source: AGHT+IECpd6uu3mztQTqtGvaZiXG0ELcfquameBpR13yoTcX46i5hVhlohITc7cPF5b9qvvv15HFCA==
X-Received: by 2002:adf:a11a:0:b0:367:9c46:198 with SMTP id ffacd0b85a97d-36bbc0e0cfdmr13298361f8f.1.1722979731922;
        Tue, 06 Aug 2024 14:28:51 -0700 (PDT)
Received: from PC-PEDRO-ARCH.lan ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290501f0d5sm1858545e9.31.2024.08.06.14.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 14:28:51 -0700 (PDT)
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
Subject: [PATCH 1/7] mm: Move can_modify_vma to mm/internal.h
Date: Tue,  6 Aug 2024 22:28:02 +0100
Message-ID: <20240806212808.1885309-2-pedro.falcato@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240806212808.1885309-1-pedro.falcato@gmail.com>
References: <20240806212808.1885309-1-pedro.falcato@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move can_modify_vma to internal.h so it can be inlined properly (with
the intent to remove can_modify_mm callsites).

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 mm/internal.h | 24 ++++++++++++++++++++++++
 mm/mseal.c    | 17 -----------------
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index b4d86436565..09ea930540f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1497,6 +1497,24 @@ static inline int can_do_mseal(unsigned long flags)
 	return 0;
 }
 
+static inline bool vma_is_sealed(struct vm_area_struct *vma)
+{
+	return (vma->vm_flags & VM_SEALED);
+}
+
+/*
+ * check if a vma is sealed for modification.
+ * return true, if modification is allowed.
+ */
+static inline bool can_modify_vma(struct vm_area_struct *vma)
+{
+	if (unlikely(vma_is_sealed(vma)))
+		return false;
+
+	return true;
+}
+
+
 bool can_modify_mm(struct mm_struct *mm, unsigned long start,
 		unsigned long end);
 bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start,
@@ -1518,6 +1536,12 @@ static inline bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start,
 {
 	return true;
 }
+
+static inline bool can_modify_vma(struct vm_area_struct *vma)
+{
+	return true;
+}
+
 #endif
 
 #ifdef CONFIG_SHRINKER_DEBUG
diff --git a/mm/mseal.c b/mm/mseal.c
index bf783bba8ed..4591ae8d29c 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -16,28 +16,11 @@
 #include <linux/sched.h>
 #include "internal.h"
 
-static inline bool vma_is_sealed(struct vm_area_struct *vma)
-{
-	return (vma->vm_flags & VM_SEALED);
-}
-
 static inline void set_vma_sealed(struct vm_area_struct *vma)
 {
 	vm_flags_set(vma, VM_SEALED);
 }
 
-/*
- * check if a vma is sealed for modification.
- * return true, if modification is allowed.
- */
-static bool can_modify_vma(struct vm_area_struct *vma)
-{
-	if (unlikely(vma_is_sealed(vma)))
-		return false;
-
-	return true;
-}
-
 static bool is_madv_discard(int behavior)
 {
 	return	behavior &
-- 
2.46.0


