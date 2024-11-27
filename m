Return-Path: <linux-kernel+bounces-423712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9951B9DABC8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7D928216B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305F8200BAE;
	Wed, 27 Nov 2024 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="q2iJO2Gc"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75D0200132
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724926; cv=none; b=FSJdnZcvgaoZbkSNp+QcFE7Gqmx4osrgBrVuHPjxqVEb3yTm11d5+wSX6Pgij9uMfaIj6Nh2XwYHM4ymyYh6CC6rw6WxHjuVN8cLsCHvMwTTQD22w6OlrSDcBKisn/pf/MZifL3/GeliyeuzwV2Y7xQuayBMANgonZ99rUCAnAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724926; c=relaxed/simple;
	bh=04Q0ZnnNtqiGHJ5FGrUCZRfXltXGgfyyrDds83wZDEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkqNEiWexcKgRAC2zOOMLBiqs1Vw0UEi6QV7/cVQLVC1CCtS3qupL3I7roCx4qg9APInsjiUhDqbC+kK71hKOWzd8Pt2Nniu137zV8RhzzezEDkfr1l9C6MRF8THMhqVrcXjplrhTTDfgberS2jQkZjkn2xGMq9n+rD0lN29MWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=q2iJO2Gc; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-46677ef6920so8899151cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 08:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1732724924; x=1733329724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prxwR8ozRxMxxXvOfV2zxhvLnEBIflQoHb028mkGmho=;
        b=q2iJO2GcTLDHJjMSl//KzUf0NvDtR0LO46FfDoWmUToTz2aW2mYn0fD80Eo8flMQVb
         8/cuwwZd+PrlN7p466ptqRlCUQYJOPGanO3DFQ4CwpZ8/C6QT3y8V4obeRx9AJWfRDps
         CuXEMC7gMtpsu986vMP602Z8nD4mGfXLse8/jmJxRBo9UCN1ScyeeQrG9pS5LIcsXR4V
         sHWTVVFKMjGmD6uHUspANAQvfmEErb2YMRJJnl+rrQ2BDYqrmb9/Emeu68uxdNkX5M+O
         +/dWOLaD1RAFVvE7vLUAhUzbG66pEfNEKu8+oMarLPv2NheFS4HfFNivOF+dQiup8I3S
         aXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732724924; x=1733329724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prxwR8ozRxMxxXvOfV2zxhvLnEBIflQoHb028mkGmho=;
        b=cxY59iGEGUHYd5OAt/AL/ZXONr4U5XuO2KxiNitjV0+HXb7VHsUm3sVGZu8ZRiIC0M
         +hho7TbiTcUywm7Wd3vIkqPNFFN13EtLUhJK6ac1d04zOZLr6sEGkGyIbwglo43QsY0N
         cbs6GBew21k5LI3qaw3InniCwqgnbaf98b51X7d0cdm3rsAOxTlus0+IEuXDoML04wcu
         VIp3NYAE+39aZprwBhA3MdsES7ryJewBXp8HaRDOjHzfxOCOqNr/9SVxIWDmLigDbPuO
         OaUNdttz0KWGL/tURiXcLyeDQLS1/+HXk3gdFPXnusU3lSoIahuNFROCehn4mSC64X6P
         p9ZQ==
X-Gm-Message-State: AOJu0Yy968uCSJvseve560YUV4olebbVTsSB6nO2jMkbUN3qFoCbN9qy
	DZuL35+KzZ0jH9wJJ130PriTSX4IdUkKzC6+DkIF5VnVjoXSEnrgaNJ9JIfoP0I=
X-Gm-Gg: ASbGncsEA2fAky8fd250FCjYxei7HESWpECnyGOIUB029NyL8Ey1+NXovrzQ8r1SaYO
	uApAAY4Yy2d7ykB88wLtDCToVy7bkvSnbMNv9QbpLcZMB1ohf8DLWL/UX6tw80feDbiWIIQ9OkU
	lelgwFS36Uz/uC8BZZNAtY/NAss+UqyXmCVGu4Rxqi4JJDi7sq9s5TaYPcjZgTEqXJylUJcR1JA
	s6YfG9fCCTyDbzaZbZB7B5N8kvnYIOwrun1sVB2vn27DM8FOBSjxr6+NLxGsAUdzpLqirI+H7WR
	2d5kcYNQo48g0CUOXlMJK3RV2uTEL/6SYXw=
X-Google-Smtp-Source: AGHT+IEVCaFgyRliI/ntnaM1UvjIzFe3wAKf9UlR8ZwU776bFJXRF7ZXcH88bA7pVNDHWLMNqTde5w==
X-Received: by 2002:ac8:59d0:0:b0:466:92e1:37e1 with SMTP id d75a77b69052e-466a3bc762emr134984061cf.26.1732724923686;
        Wed, 27 Nov 2024 08:28:43 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466871721c2sm45002921cf.17.2024.11.27.08.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 08:28:42 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	nehagholkar@meta.com,
	abhishekd@meta.com,
	kernel-team@meta.com,
	david@redhat.com,
	ying.huang@intel.com,
	nphamcs@gmail.com,
	gourry@gourry.net,
	akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	feng.tang@intel.com,
	kbusch@meta.com
Subject: [PATCH 1/4] migrate: Allow migrate_misplaced_folio APIs without a VMA
Date: Wed, 27 Nov 2024 03:21:58 -0500
Message-ID: <20241127082201.1276-2-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241127082201.1276-1-gourry@gourry.net>
References: <20241127082201.1276-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To migrate unmapped pagecache folios, migrate_misplaced_folio and
migrate_misplaced_folio_prepare must handle folios without VMAs.

migrate_misplaced_folio_prepare checks VMA for exec bits, so allow
a NULL VMA when it does not have a mapping.

migrate_misplaced_folio must call migrate_pages with MIGRATE_SYNC
when in the pagecache path because it is a synchronous context.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index dfb5eba3c522..3b0bd3f21ac3 100644
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


