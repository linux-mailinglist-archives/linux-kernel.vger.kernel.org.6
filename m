Return-Path: <linux-kernel+bounces-212704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28763906515
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3901C216B7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 07:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D413013BC0B;
	Thu, 13 Jun 2024 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cs+8D431"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F9A13BAF1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 07:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263827; cv=none; b=iozzjWhRrHSnmpMO/Ut1ScWIPXATZh4HUuKbpuv8bqlNn8fz2y8+QhEzCjULaCUBUVGRdHz2imy623GkSiwf1o7QQSSScT9cj8hraQEmy4EQSCw+KbwAxdornZBFPeJ4089Qj/TiqTxMxBHZv1VNYiCFpH94HiDc87ouh1ufzB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263827; c=relaxed/simple;
	bh=g+KG+pde7EfEMoEuaxFNR4aClT18eqnQRuL9D/Dm8cc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KWiuB0mp5iDmjC4blfeiksujg+1Ywr33cIq/s7JK49HksagCLMrXNIsurfeX80EC7epyUEuZmLCAhpHIEXG03pnUcZdXPGe301iJhhfQHstnZMKfhImjR/jVvKelzVUAcc5IbvjIzUXbOlWYrpFXnxSiBdnjfkqisUREFeNTwjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cs+8D431; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-681ad081695so524359a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 00:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718263825; x=1718868625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYEMCH0QqsMPrWp6539hun3wM0yE8591R1LW+PVzzXk=;
        b=Cs+8D431+jGJJ2GLAWwqouFo8F55yLR84IaUCEZ9A64IHqKaV+vCNiGxoc2H35X0h/
         PM/QRRpwQFqPOUuGZlWR+SetLTeIycjEFPINGfOUQdIsRhRWnWg8gQ17NP88zgsjnSGX
         rnXBGEZ9hGpqFDAHRBTmeembS5d/hOIeQY2m+PAkf7QuQ2HkTa8HNZmn6d6BK8C0a6Vh
         7g2B/3xv6ycDcxJ7FQWzOeBrp+wC3ZBvkeo8dNmvEoPzXgi/eNCuLJaCCwywQq5i7IPt
         UcK+Ud+XDV6Sf8C4AIn9qYcBToZUA87Z0t3OqmsoE3lL2maeuFZHVKEmTa4WQ0a2Asvm
         SmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718263825; x=1718868625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYEMCH0QqsMPrWp6539hun3wM0yE8591R1LW+PVzzXk=;
        b=vIOPqEOZjd2pzfxIAklIrgBB5CE5E7/RHJF+CnvlYOwilJxajxjQK5xuKg7U6UuTW5
         P+peH1fuh7s9tKc89aIVIfEWOkJf/V60kXgdaXHf4NdDnMmeup7XS2BW8yUd3dHrNbtN
         dRDwuzJotJmd3Ml4t2t0ReGC0kIrD3AsUDn+uEBdWxfArjfDfsJDWNQQDkCDJNWeysub
         L6UdSJC5OeNWXWEX/sNV/wo2/eQ48rf3+9QAzz1owV8y2I/XdGztvf1zSR2RdzoJ+cWt
         QQxbozvrpxp1PvcYNilT7597H1j66I4rrs3R8W9h2tiNMO7u43jGEAz2tidL8Cknr44C
         L0wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMKCSZZYwNwnlxiJOElhz6rDzSEl/XKNc5vUrRZNII4JsWkYRb45R0XNbDEwVPPxGNUP5KHoh+Xfzlh6mnynTZccmWFHPqQRPgCMj/
X-Gm-Message-State: AOJu0YwbNzf957hL2yd1oyKP0Sm7Lll4rTO+tnJc0xTR9aiOaouKKeOE
	ujbFLV37w5FqC8M1l2eTkOy/aQOvKqGJ8BBgYQZfgYfTl+c5t3SZ
X-Google-Smtp-Source: AGHT+IGh2gLllxUfXYa80RxX3JEI/Q+HKIcb5idXoXfLmVLeRMcnSs7RHtWsRrfb6ENTjfuKahekhA==
X-Received: by 2002:a05:6a20:3ca2:b0:1b8:6ed5:a8f with SMTP id adf61e73a8af0-1b8a9c64774mr4723525637.56.1718263824902;
        Thu, 13 Jun 2024 00:30:24 -0700 (PDT)
Received: from LancedeMBP.lan.lan ([2403:2c80:6::304e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc921b41sm714868b3a.5.2024.06.13.00.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 00:30:24 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: ioworker0@gmail.com,
	21cnbao@gmail.com,
	baolin.wang@linux.alibaba.com,
	david@redhat.com,
	fengwei.yin@intel.com,
	libang.li@antgroup.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	maskray@google.com,
	mhocko@suse.com,
	minchan@kernel.org,
	peterx@redhat.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	sj@kernel.org,
	songmuchun@bytedance.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	xiehuan09@gmail.com,
	ziy@nvidia.com,
	zokeefe@google.com
Subject: Re: [PATCH v7 4/4] mm/vmscan: avoid split lazyfree THP during shrink_folio_list()
Date: Thu, 13 Jun 2024 15:28:58 +0800
Message-Id: <20240613072858.16512-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240610120809.66601-1-ioworker0@gmail.com>
References: <20240610120809.66601-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

I'd like to fix the bug[1] I mentioned previously. Could you please fold the
following changes into this patch? 

[1] https://lore.kernel.org/linux-mm/20240613065521.15960-1-ioworker0@gmail.com/

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f409ea9fcc18..425374ae06ed 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2707,10 +2707,8 @@ static bool __discard_anon_folio_pmd_locked(struct vm_area_struct *vma,
 	if (unlikely(page_folio(page) != folio))
 		return false;
 
-	if (folio_test_dirty(folio) || pmd_dirty(orig_pmd)) {
-		folio_set_swapbacked(folio);
+	if (folio_test_dirty(folio) || pmd_dirty(orig_pmd))
 		return false;
-	}
 
 	orig_pmd = pmdp_huge_clear_flush(vma, addr, pmdp);
 
@@ -2737,10 +2735,8 @@ static bool __discard_anon_folio_pmd_locked(struct vm_area_struct *vma,
 	 *
 	 * The only folio refs must be one from isolation plus the rmap(s).
 	 */
-	if (folio_test_dirty(folio) || pmd_dirty(orig_pmd))
-		folio_set_swapbacked(folio);
-
-	if (folio_test_swapbacked(folio) || ref_count != map_count + 1) {
+	if (folio_test_dirty(folio) || pmd_dirty(orig_pmd) ||
+	    ref_count != map_count + 1) {
 		set_pmd_at(mm, addr, pmdp, orig_pmd);
 		return false;
 	}
diff --git a/mm/rmap.c b/mm/rmap.c
index b9e5943c8349..393e2c11c44c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1824,12 +1824,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 */
 			if (unlikely(folio_test_swapbacked(folio) !=
 					folio_test_swapcache(folio))) {
-				/*
-				 * unmap_huge_pmd_locked() will unmark a
-				 * PMD-mapped folio as lazyfree if the folio or
-				 * its PMD was redirtied.
-				 */
-				WARN_ON_ONCE(!pmd_mapped);
+				WARN_ON_ONCE(1);
 				goto walk_done_err;
 			}
 
-- 

Thanks,
Lance

