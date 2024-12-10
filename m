Return-Path: <linux-kernel+bounces-440340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67B59EBBF2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68FBB167E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F77C23873A;
	Tue, 10 Dec 2024 21:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qo9co1FA"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF96237A5E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733866694; cv=none; b=pDq6jw0258pQVMYnKGNlQATw0o7ZsvIh7dBSQG8oMGG2CqjXxlTxCIYa3weK2gmyFPqi2ahUTj/7jsLLocX87rkRK2IQ1Pj4GXby9yzedojfpytcW7YyUb938hExBprrb3d2bpWAA5H7/8gmqG4pJ46jGCU2EdetKFcTR6p8d3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733866694; c=relaxed/simple;
	bh=4ESIYq/H6qTs9FLOoJEIeCHtazL9GkHE2RwwJuHRH7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYjrZ/TRZ24qF2IC0/TpgLfhLde+oB8mEsnXpbTBoY9y6CVsWytA5Bq6047uu3KzvXpMng6gjr1ZpivatPJ3Oz5l4P/GgVWOeu5ANScbI/ylAABZPJShgmHjH9AdlD600o4F9OLoko61YuLMHomnOIHsyskK/EHNRmqg10XVEpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qo9co1FA; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46760d9e4daso22873011cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1733866691; x=1734471491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQZEugtHND2zHmh8pPoKkZgS6JzSbLVFT2/QKBK/z+4=;
        b=qo9co1FA7LMKg2SpmL16pBIEPGNcf3CXTSOL9BBnhZ3ytZE0s3toZSYbZlH/JVIERT
         9JV0ibUudXWZzJHpcq3Hs8uKLrNSXlylThIGgBA6ZrSTXjaYVmX5bStcRDdrSYMbcLbc
         JNpWJ9a8PRWCzANJZ3n30SFv66obPWZL9ok9kMXiihnxykrM2wbnqew9ZQeKqnE6/bBm
         fmxvmdVw87PNsj4IsYPB0piGPBIyYr7+CIKIN22BzETk8YNYzVb1RE8ry51/WReQk4rz
         qvuyqsbUy2c6CtzQ3J7tQJeq0gXk51h0+kH1VxEp2vvNv3MwHm8JGZhFcZyupNr0aBY4
         V/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733866691; x=1734471491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQZEugtHND2zHmh8pPoKkZgS6JzSbLVFT2/QKBK/z+4=;
        b=YIOdYN8W36UCuGSXRUtp+OMpTRrtWFofdufcNtIsUnA5fsvzvLo8OvBQpXN59PEzv3
         /mp3lTPIfK4nb7sDWUVQzHRmXL0tpBhXNaYA9c7Twi53A0PqfZDmWiJvxMMLthO7WFWZ
         wPo7zXeUWMkkzkgmTGgjD/Kl6b27zqXe+gdWb4lfx+kx1begFTRfjpCW6SJVbYsp/Ewr
         Bw2BFmPFisBxBoOdc8lmeIA3cgNPkf7REAIFjfB7I70eAayW3zq688OSCCP98x0OAdei
         JhUjrW0ffkr0H+daKhNSziIEhkG5jj3yVlSa6vJqPGe0+Y7pALhgo3e7NA/3SY4Bwsuk
         yBjA==
X-Gm-Message-State: AOJu0Yy8CEtWRsp7enCfJuAUjxU83j0cZ+hPYPG7yyI8bcXJuDaaXxXz
	o3SYAf1o2Ic+18sQ8J/IGjrvVQj5G5DheK5q6QMlqqZorkJJ9er3/xC+gJSnRkM=
X-Gm-Gg: ASbGncuOzRDoaBoEgmvfhU00NH6RqZnwIc2FJYqEi/FEa1G1f8vkAX1wtDX/qs9aZar
	pyNSe2n6CbJwUsMupPLwQ9Jmav5ejRXoA2jeucJtTku0sU93guon4yvVWOhT1rIf+rQn8wNT1Kv
	354LLgqjPjDso6x+Oq47y/z94ZeGRH5aaQaAQJCmKY2wG1k7OZZNNLrO2lx5HrKKIBSFGqROu8C
	Xi75wLP+PFp8/cQMdPv0zfVqplIQ9t2HRQuzpuC4HI/o+g3+LIdDAXZY3DmowNfrtoAGfy7OmoG
	3VbWZbS75bLjieE8MgQjb1srnfJ6J65IRoW9fEE=
X-Google-Smtp-Source: AGHT+IFYbR7aXy36yPVN9o7PP/Nyz3CEWrs6BuemC8qkn+p43Ye5cXgiGx1LfhBNIjaaOLXxBrl2Ig==
X-Received: by 2002:ac8:5947:0:b0:466:9197:b503 with SMTP id d75a77b69052e-46789379413mr8570201cf.46.1733866691608;
        Tue, 10 Dec 2024 13:38:11 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467296f61f6sm65978991cf.43.2024.12.10.13.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 13:38:10 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	nehagholkar@meta.com,
	abhishekd@meta.com,
	kernel-team@meta.com,
	david@redhat.com,
	nphamcs@gmail.com,
	gourry@gourry.net,
	akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	kbusch@meta.com,
	ying.huang@linux.alibaba.com
Subject: [RFC v2 PATCH 1/5] migrate: Allow migrate_misplaced_folio_prepare() to accept a NULL VMA.
Date: Tue, 10 Dec 2024 16:37:40 -0500
Message-ID: <20241210213744.2968-2-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210213744.2968-1-gourry@gourry.net>
References: <20241210213744.2968-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

migrate_misplaced_folio_prepare() may be called on a folio without
a VMA, and so it must be made to accept a NULL VMA.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index e9e00d1d1d19..af07b399060b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2632,7 +2632,7 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
 		 * See folio_likely_mapped_shared() on possible imprecision
 		 * when we cannot easily detect if a folio is shared.
 		 */
-		if ((vma->vm_flags & VM_EXEC) &&
+		if (vma && (vma->vm_flags & VM_EXEC) &&
 		    folio_likely_mapped_shared(folio))
 			return -EACCES;
 
-- 
2.43.0


