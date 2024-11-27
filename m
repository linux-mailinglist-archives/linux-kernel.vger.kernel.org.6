Return-Path: <linux-kernel+bounces-423714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0139DABCA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D646B23C2E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDEA20012C;
	Wed, 27 Nov 2024 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="mLMgjsKa"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF63200BBC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724929; cv=none; b=W/hDmsoBA6kObdOHCzlBaBN6eVeZ8czQFQL642AjRMAUtE0hysca0AdDSLeQ+6KfuTpl7q+gamh0bTjL+WONrs5hF72Rxvsn6BFLXd8JS7Zt0wnxbw6GHHPOX8gWxQhPhDx7YerQSMr3pEPH8oeO8uu/yKJNrdTOgXEkLLje5zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724929; c=relaxed/simple;
	bh=0RcAtz1MZo4W7JBinrRSZMWTgHLFy84GDh0d66nWFPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UgWenqUzMx1wHxFvfGi9jF1BYj75d4JZ3OWbaZvl5PEpBBWm7TwWwNcCRLxgcq74ug26QXWOV/RKTULESSVogSq9N27tUbzCqcxlpvHnNw3/LK89NUJpy7r19jwVTPcQgVnIld7yIbl3KPWJ6VcToPitDf3+IDxvs/u/r1IiWVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=mLMgjsKa; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-466966d8dbaso22118891cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 08:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1732724927; x=1733329727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qVD2IQ6TUVnIPl8KOFrC6kDkrJSATgnAz7c/+Cb6G4=;
        b=mLMgjsKapO1NJbkSIh+OjtDzBpHVUfcPNhhe25pSvn/Y5pbGraWslHyAtKWhmlZlWb
         saKvxwHVJ9z2IkvzQ/REnNsolJ2BvpCo8Rz8rbioylDAPh0tVrBeyYmmsbUzT3KcJwdn
         rHdTKNGgsdrQi+R9Z81pynpQhvtNnWlKxVsh26TkDXE4lm1RsIGYP2rh5iH3xMRcK3Bu
         a89Ui9Sz4f7opFS0NtyHbkiKndKLd1TOb3YvKMpQePR1aUfv/nS2qfk+k9wbLnZBF2Jb
         pynMRi68ghWZUUE7GxTYpg1R2P7wik8B+i6nXIYVKK7NA6MxrhjijWu8ZMzV8wdcKb4W
         goVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732724927; x=1733329727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qVD2IQ6TUVnIPl8KOFrC6kDkrJSATgnAz7c/+Cb6G4=;
        b=UyChvWp3F7Gh6gMwL14fsqFyfzryhb+4qeEfJbqSEVBN4kQM4MaATLe/hUc8bnbJCA
         yZUGLOD1h7R2bVzBEWE+HQ9bL0cO5MK6j01mZeQwV/8ZGsVfQnXoQ98xEVJX3paH0Q2N
         beGdizgRdM3aHlrr5tf4HXutNxe5psYsCZ6YJeUInzsGRPyuaOZgNuN3CLV+V0nz8yN1
         Otaonv4koghcytzlZj+sq2MRgpNXBPR1cKjEdiiMNTxJ0zHppCHhYkJoyEdNHWltaz6Y
         oPuPN65vrhgAgu9VCFIcIK4xGGrzLJhK0RSumsyadue0AOMooIz6aa8qZVYPBlNhi8Zv
         wh0Q==
X-Gm-Message-State: AOJu0YzlLdB0QxoQ4jHmozaLurAsFQ7AQfz6xiVWNUiFEXCCEORb8II9
	+h1VZpf+iBOjXHl71ZnDkYBOU5NVOa4nE7Lr7yvNz4OyD7BEgEP5ht9zFjuSWnk=
X-Gm-Gg: ASbGncu4qgi7V8odG+awvenSlLKhM1GRy+GnaDS4nQIpoX9SmTTUWzOKX3PRQCYdeUj
	bznHXyK1n2w+zDfNSutGqq1ki+K7hs1fvGE/pKXQ8gB5/m35OJEreRGzih4tJkcTklk7O0UqlGT
	HaX8colW/nyt29g9yVmvJc0uudkdcoDthjvsKCeMPzDwe8zoX7LMm/UfBLIrJVDws5ulSD9F3q1
	G7sHWRrH2uD6wByxLkAU0W4FRGndbYeW+gxDGJJ+GmGv0zpBxoWcJy/MK1v0DXDvLJ+osJKJPRh
	EpNqsrMeDIZlLRcdIg4XaaSd3qOVf1K9pxo=
X-Google-Smtp-Source: AGHT+IG/ToEOt1Gt6Ry1TUTbihCqZ0qO6hIYx2iJN602ReOwj0JgnK+caF+0walmHaDLqNcTTiZU1A==
X-Received: by 2002:ac8:5811:0:b0:460:e9d3:e989 with SMTP id d75a77b69052e-466b34d31c1mr44603091cf.8.1732724927143;
        Wed, 27 Nov 2024 08:28:47 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466871721c2sm45002921cf.17.2024.11.27.08.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 08:28:46 -0800 (PST)
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
Subject: [PATCH 3/4] vmstat: add page-cache numa hints
Date: Wed, 27 Nov 2024 03:22:00 -0500
Message-ID: <20241127082201.1276-4-gourry@gourry.net>
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

Count non-page-fault events as page-cache numa hints instead of
fault hints in vmstat.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/vm_event_item.h |  2 ++
 mm/memory.c                   | 15 ++++++++++-----
 mm/vmstat.c                   |  2 ++
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index f70d0958095c..9fee15d9ba48 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -63,6 +63,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		NUMA_HUGE_PTE_UPDATES,
 		NUMA_HINT_FAULTS,
 		NUMA_HINT_FAULTS_LOCAL,
+		NUMA_HINT_PAGE_CACHE,
+		NUMA_HINT_PAGE_CACHE_LOCAL,
 		NUMA_PAGE_MIGRATE,
 #endif
 #ifdef CONFIG_MIGRATION
diff --git a/mm/memory.c b/mm/memory.c
index a373b6ad0b34..35b72a1cfbd5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5507,11 +5507,16 @@ int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
 		*last_cpupid = folio_last_cpupid(folio);
 
 #ifdef CONFIG_NUMA_BALANCING
-	count_vm_numa_event(NUMA_HINT_FAULTS);
-	count_memcg_folio_events(folio, NUMA_HINT_FAULTS, 1);
-	if (folio_nid(folio) == numa_node_id()) {
-		count_vm_numa_event(NUMA_HINT_FAULTS_LOCAL);
-		*flags |= TNF_FAULT_LOCAL;
+	if (vmf) {
+		count_vm_numa_event(NUMA_HINT_FAULTS);
+		count_memcg_folio_events(folio, NUMA_HINT_FAULTS, 1);
+		if (folio_nid(folio) == numa_node_id()) {
+			count_vm_numa_event(NUMA_HINT_FAULTS_LOCAL);
+			*flags |= TNF_FAULT_LOCAL;
+		}
+	} else {
+		count_vm_numa_event(NUMA_HINT_PAGE_CACHE);
+		count_memcg_folio_events(folio, NUMA_HINT_PAGE_CACHE, 1);
 	}
 #endif
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 4d016314a56c..bcd9be11e957 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1338,6 +1338,8 @@ const char * const vmstat_text[] = {
 	"numa_huge_pte_updates",
 	"numa_hint_faults",
 	"numa_hint_faults_local",
+	"numa_hint_page_cache",
+	"numa_hint_page_cache_local",
 	"numa_pages_migrated",
 #endif
 #ifdef CONFIG_MIGRATION
-- 
2.43.0


