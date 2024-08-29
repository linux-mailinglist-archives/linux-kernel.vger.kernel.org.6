Return-Path: <linux-kernel+bounces-307643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FC99650B1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE341F22ACC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C8C1BA88F;
	Thu, 29 Aug 2024 20:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W2vvt1bt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C9B15AAB6
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 20:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962964; cv=none; b=jLj77203cstalsCfT4HoLF7y5FVfOOFdxTxv3JwcOdWjW7n7Hwk34+8fadcNo8PQQ9m4ktpoNEo7XKDXC9QAi7/pXPlIQov/iOI9dxVlciN9v5v6wKAPk3iFcz6Jgtvzvo2woC7d8ju0fXuOJKcO6g0owY3R4rWUFIvPyw+Yn4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962964; c=relaxed/simple;
	bh=kKj8zc4tlLcBltcCReUg6Uzn747Y/w89aEMAM8WYEDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r5/cNwzt6IT+vR0J1Z0nh0QJQ5r5xCDO6UCor7D5BQFRf6dztbdUW05bvxTqeboxNG7v+5sqr7fX18cQK3ht2sU2TS7HL8ES8+YgnnWjPdLjmqYHdsQYNmXZa9Fjh0NZttSL4C3lY1mFheXr8idHlT4n85HLvCJ51Mco65AVty8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W2vvt1bt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724962962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yIlcCFkBaiUavKPXgyUjDxL+3t1TXE/zaK2phWDIt6w=;
	b=W2vvt1bt+xd4tc4y8D+H5ePuZGxP0y/qZzhkR0WQsYEQJsyDm2SuOkpsYY0MFxNBCgKO8A
	ltxWRGGmuLaDLD47NDEyrSWr2b+kQUB9KYy7b7fQYghhfvcIgBa8gbpLx4yzEVu5m09FkJ
	8wz5YMpNbgpi+POzbetBQtgv/9FcNpE=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-KG3OR4p_MC-FUz0wTGj1JQ-1; Thu, 29 Aug 2024 16:22:41 -0400
X-MC-Unique: KG3OR4p_MC-FUz0wTGj1JQ-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7092fa5079eso1125490a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:22:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724962960; x=1725567760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yIlcCFkBaiUavKPXgyUjDxL+3t1TXE/zaK2phWDIt6w=;
        b=K1SUnh9OgReFptAgnWhf97W3J9x0NRSO+Ao4Y6v+stWzYiqdGdOOkl5iEkAlH19KQ+
         EF2HEVrHRlehNiH1vR1P77IN+aK8My0PHbeWAu6kS1EWUiaJ4x1VCNtARiZidM0OHf6e
         YFxDjXFrla2yV3/G2N/CQWThlfsrLyYJOc8dLSPaCzp8D+J65RVmK9USt1eO5j5PiSFw
         hk11ZX0uRrkFDpbLSRQqiF+GY3h9M+3B8WVXO8pOuPWvUAoCkPnniZ0nnq0hAZflWHop
         soQ7+Iut4h44YApRxhvnok3ZfVafYR7uhhLqVYqA1GJw71X1K65ldu/3vobCe0oecSJk
         uvIQ==
X-Gm-Message-State: AOJu0YyI7K7OYyj9Ihl7qdBl6LdD76gagKx6Cz1RXY3K524EQcJi7Bau
	fOKdYFYfNmHStPwM1y54BWTbQOaMqbCpGXmQhQGV9JvOcv/NAG35ECmR+qXHkXFVCbIXCszPN/P
	QKP3U9Fw0hk3VTT+tRyJGOpqWc6sgGYiNhwNjxUADRdlbTFMeaI/IFvFUryUo/QGubtldIG2qd7
	1B1ry0PrcyJtHCvB0PKXSOed0Ovjwn/QM8pOvGoY8b//Q=
X-Received: by 2002:a05:6830:6884:b0:704:470d:a470 with SMTP id 46e09a7af769-70f5c48b465mr3967276a34.28.1724962959732;
        Thu, 29 Aug 2024 13:22:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3D/QgmuWSAwu0zH6SqxrhZIuLPdZ2EGJ8cbRJq+lkIvuviP800t8fhORgXtIOqGLTluRh1Q==
X-Received: by 2002:a05:6830:6884:b0:704:470d:a470 with SMTP id 46e09a7af769-70f5c48b465mr3967254a34.28.1724962959366;
        Thu, 29 Aug 2024 13:22:39 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70f67173fd3sm68688a34.45.2024.08.29.13.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 13:22:38 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: peterx@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH] fixup! mm/pagewalk: Check pfnmap for folio_walk_start()
Date: Thu, 29 Aug 2024 16:22:37 -0400
Message-ID: <20240829202237.2640288-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per David's suggestion, remove some stale comment in vm_normal_page_pmd()
as we start to have special bit in pmd too.  Meanwhile move the
pmd_special() check here from folio_walk_start().

Signed-off-by: Peter Xu <peterx@redhat.com>
---

Andrew, would you consider squashing this patch into the commit
"mm/pagewalk: Check pfnmap for folio_walk_start()" in mm-unstable?  This is
so far the only thing I plan to update on the huge pfnmap series, thanks.
---
 mm/memory.c   | 9 ++++-----
 mm/pagewalk.c | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 06b42db8a2db..b95fce7d190f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -672,11 +672,10 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 {
 	unsigned long pfn = pmd_pfn(pmd);
 
-	/*
-	 * There is no pmd_special() but there may be special pmds, e.g.
-	 * in a direct-access (dax) mapping, so let's just replicate the
-	 * !CONFIG_ARCH_HAS_PTE_SPECIAL case from vm_normal_page() here.
-	 */
+	/* Currently it's only used for huge pfnmaps */
+	if (unlikely(pmd_special(pmd)))
+		return NULL;
+
 	if (unlikely(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP))) {
 		if (vma->vm_flags & VM_MIXEDMAP) {
 			if (!pfn_valid(pfn))
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 12be5222d70e..461ea3bbd8d9 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -783,7 +783,7 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 		fw->pmdp = pmdp;
 		fw->pmd = pmd;
 
-		if (pmd_none(pmd) || pmd_special(pmd)) {
+		if (pmd_none(pmd)) {
 			spin_unlock(ptl);
 			goto not_found;
 		} else if (!pmd_leaf(pmd)) {
-- 
2.45.0


