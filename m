Return-Path: <linux-kernel+bounces-267542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D1794129E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C491C211CB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BFD19FA99;
	Tue, 30 Jul 2024 12:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsHVScy9"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC9919E80F;
	Tue, 30 Jul 2024 12:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722344054; cv=none; b=BuDd3q4KPkJiIS752roTNmAFI3svphMxwRVt4Ej7LW/g1A5nIHiMXUT5eEIYpE157BdB/ZqVOqTuR90H+mv8j5i9xdKg0JfCclQ3baVrThiA7URBv9t6P6acogCXX2THB5esvKeRQCWZJN3hhUu5VcqoB192aqYyFbRd5TWwOtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722344054; c=relaxed/simple;
	bh=xqdoAcWmVUYMrD+FVNRpmeoojd2kYweY5GdVkMg2yo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZf3XEQZ2xPt9NMf3VLmmAq6wBONX8J46nmGMVQCs6QM+FnU0hLwnun/eDImkzE/wbyoy5M0SVvDqdPq+0ByP2TAKuAkR3lzd6SvtuRNeAhXGtrBcdHOkMk0Ug317RFms13icz0g6mz8XBTRLsujR3DaGlwJj06UCL2i1f7vzN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsHVScy9; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a1e1f6a924so263811085a.1;
        Tue, 30 Jul 2024 05:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722344052; x=1722948852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xejBMxasF4z7vTbtt633OZCxjB3/TpD8KsbFAqhPXuY=;
        b=NsHVScy9BmTHGBMRJKxpYBzdcbpg6cZzWzhIOC/A7n60hNuQ6zTGPWpLjYzZWHq3Ru
         i+YEyKR4lpCaPfxa2ODcgPOrqKIPxO/vbn93TkrwCDtwHoU4mj4yDj4t9r7vuqgAf+KO
         +MBoZdHuDV3t3TBVXFHK5dQT5lsVMF1KkQSHGod3xA3xhR3RwQF+VxLEATU5WCrl04p+
         EAjuIfgUWxzUVmazK7ySG/6upPGLg3diafsSPXHsfs+ndyk49ze828/nKbFnCwuP5ycW
         uFvlv84oBjlY/c79P8zQGmgZGMoXGIHk/mzWUTzh0E1ovwaPcM817xjITCgmuPi6nDjM
         y6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722344052; x=1722948852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xejBMxasF4z7vTbtt633OZCxjB3/TpD8KsbFAqhPXuY=;
        b=R0Ww9fB6hPlIbpsfYwJn6QEheQJC9QMB6H7+cGn7DPunRG3J9dGqD36stsoZ4KkBmQ
         3CDrff8zK3uDRLLLeH08zcVUnw+zMwtDyjWrhpHVYY3qg3ne21Jx2A2TYxz9BfKQL9PU
         qwjjej31X0ivnc/8NqVGvq62TFANaP9DDpSU7mKOuPTuvat42AopxRsCytuHZGB8ozpz
         hPRTeEMicrNy9PjrnDRNolaoq2ChILvHL7K0+bDhKogcyERWPnEzfbOqoExT1X+jQlFu
         oywIrhlqsIk4LqMPqgIxol9OjZGkpN2vLoLA/ztmpXXP5FgsYF6utt8zupsI829JGPH1
         N/hg==
X-Forwarded-Encrypted: i=1; AJvYcCXHg5a5Gey3apcvVeAmZZfg8lSI5c91FutB6XxCoMGaDNpUlBww1shkU3+hpu08m4juZ4srl4ud6k6g8mFeobvt8i1zzty8/WFd4ESPEkP/ZL7HsDifHlut+o5Efsr5ejv+CQvRHREo
X-Gm-Message-State: AOJu0Yzbrdc1cXZEK1Camr27n8KDlLlI8sY5ru6Bsne4+N1VWu9JHPak
	QblddOIcQOo2Dz7U8cRk6H5EU3qHIB3ttMC7F0ES0A/UwL8cq+XV
X-Google-Smtp-Source: AGHT+IH1TaNMaT1owhjXGb3Te5E+aSoMQp8eh+KW6WOTF5nBI+raPcLbOMS88vx6Ilwbsv6KRamZCA==
X-Received: by 2002:a05:6214:4019:b0:6b9:299b:94ba with SMTP id 6a1803df08f44-6bb55ad89a7mr115074966d6.46.1722344051931;
        Tue, 30 Jul 2024 05:54:11 -0700 (PDT)
Received: from localhost (fwdproxy-ash-112.fbsv.net. [2a03:2880:20ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8123516sm50426311cf.1.2024.07.30.05.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 05:54:11 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	yuzhao@google.com,
	david@redhat.com,
	baohua@kernel.org,
	ryan.roberts@arm.com,
	rppt@kernel.org,
	willy@infradead.org,
	cerasuolodomenico@gmail.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH 2/6] Revert "mm: remove free_unref_page_list()"
Date: Tue, 30 Jul 2024 13:45:59 +0100
Message-ID: <20240730125346.1580150-3-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730125346.1580150-1-usamaarif642@gmail.com>
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

free_unref_page_list will be needed in a later patch for an
optimization to free zapped tail pages when splitting isolated thp.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 mm/internal.h   |  1 +
 mm/page_alloc.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/mm/internal.h b/mm/internal.h
index 7a3bcc6d95e7..259afe44dc88 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -680,6 +680,7 @@ extern int user_min_free_kbytes;
 
 void free_unref_page(struct page *page, unsigned int order);
 void free_unref_folios(struct folio_batch *fbatch);
+void free_unref_page_list(struct list_head *list);
 
 extern void zone_pcp_reset(struct zone *zone);
 extern void zone_pcp_disable(struct zone *zone);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index aae00ba3b3bd..38832e6b1e6c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2774,6 +2774,24 @@ void free_unref_folios(struct folio_batch *folios)
 	folio_batch_reinit(folios);
 }
 
+void free_unref_page_list(struct list_head *list)
+{
+	struct folio_batch fbatch;
+
+	folio_batch_init(&fbatch);
+	while (!list_empty(list)) {
+		struct folio *folio = list_first_entry(list, struct folio, lru);
+
+		list_del(&folio->lru);
+		if (folio_batch_add(&fbatch, folio) > 0)
+			continue;
+		free_unref_folios(&fbatch);
+	}
+
+	if (fbatch.nr)
+		free_unref_folios(&fbatch);
+}
+
 /*
  * split_page takes a non-compound higher-order page, and splits it into
  * n (1<<order) sub-pages: page[0..n]
-- 
2.43.0


