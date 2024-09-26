Return-Path: <linux-kernel+bounces-339968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63F4986CCC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032241C2149D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB741898E5;
	Thu, 26 Sep 2024 06:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MmNDotZc"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3A313D276
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727333241; cv=none; b=jwksG5CreD5vxNsZNvbhH3QxaV74V5cQiTzF6BlKvpIqYbpwT8K0dLB7Lg0w9ZTefodoGgaQm3FpII0n5J4rSemYfxTeg+AZv/66xrlcrDxV0bXNHfNG0TPYu+gczL+AOjmka2nlih6S50EWtmbHLtIqqfZ1+zlkyGNv8qqpYPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727333241; c=relaxed/simple;
	bh=v+8eBabVrYBW01Qi/P2m8jF8QqAnjVEwJS4a+M2dkLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IWcTu8KIpEoL2o4Dob/DWN/Hr5mUp/Rt6KfZ2MGJBnHHBO0SjcMkrb/dWgEJ/NLAP2lByXStHqI00y1r5e64bwAt/7qQMpzLJH8phqISLbjtZlIQhOWgGpPoecyNJBgC+QF3PPxN9X25giFQ6AKHmXrhuXaITJJEHTUcBV0m7wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MmNDotZc; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-49bdc6e2e2cso272660137.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727333239; x=1727938039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6e2rRMn75kFV6Fv258+yl1EB6KpOV48BOzHpMuHQ/Y=;
        b=MmNDotZc1ZT6guSaIWNvWLcaXIj3q/dnhy1ANKdzZAush96XiAT7TMZ5dmjKmU502X
         IEjDWp1qOM41LnR2cdVIcCbqAULtqVIEOCDrlplHoDLZSqUn6TKTG2mndatJ9Uyrecmj
         rsepOxaUb+8ZBB6w7McDDS2CYdtDAexiGO7Phbz5KwmBz0vnTBaiIu1hBSUUrYGyHp3j
         ws6qO85CcMnUSzYRp16jN2kmLdvLqd8452Ji7Hqwr4ZTrEta63BzDx/xsjVt1UHMaGUH
         O9afu/tYLjvVcUr4IXAeCQxT0+mMHOzDGUPidoNBFkcSgNyrTSO4TxXBpDuD0Z3aNlXN
         VS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727333239; x=1727938039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6e2rRMn75kFV6Fv258+yl1EB6KpOV48BOzHpMuHQ/Y=;
        b=u040J1lD8gzd1/x3wGiM2kWYmPs0K5DBUg7pKEQVBVeJr+6KxrzHSxLlQHRjxMTqg5
         kBm2Lmnq/lAMl8op1M8MgdvkesP6xsNZtsOZv4oJQLsRXUda51nKt5tWd9PeNAWL1NKK
         4epb3YWTZw08V7rYVawg09/7SbTp2zZnnfPn3t3FUG4EXih8WCMGuWQGq2nUUh72z8ra
         u2TgF6rCyrB2Zudkc3DQ66kMy0g/dfF0or2TIrFHg/FfnlQaqx29KEr8Bj+lHdJFzXus
         Chkhg9Ln6qXYbdgex5AvQt/zut4bCDpB5ixMCn8Ri63aS1v1Lp9EDxwoL+gmEY7+SNIc
         rmlA==
X-Gm-Message-State: AOJu0YwcY4iPxgOd1Z9lGQrHdQD5hhhfBEGR+IP45DrQfRPkSSr7Rv+y
	zCHLV0UJmfRgp5RtmH7uCOG0WJbF5cxi0v+5dCIL4cpbVSWwmOXM636FC7Ji0No=
X-Google-Smtp-Source: AGHT+IHnBlRBHwKCxjYpHBiGYKwBIoiWGnfAohABSGODP2aU4XU9V+T3qIbiD3kwEf9HDK6sMKBjlg==
X-Received: by 2002:a05:6102:6c3:b0:4a0:1cdb:3eb4 with SMTP id ada2fe7eead31-4a15dd1a11amr7011565137.20.1727333238630;
        Wed, 25 Sep 2024 23:47:18 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b5257ff1esm23024611cf.38.2024.09.25.23.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 23:47:18 -0700 (PDT)
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
Subject: [PATCH v5 04/13] mm: khugepaged: __collapse_huge_page_swapin() use pte_offset_map_ro_nolock()
Date: Thu, 26 Sep 2024 14:46:17 +0800
Message-Id: <dc97a6c3cb9ea80cab30c5626eeea79959d93258.1727332572.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1727332572.git.zhengqi.arch@bytedance.com>
References: <cover.1727332572.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In __collapse_huge_page_swapin(), we just use the ptl for pte_same() check
in do_swap_page(). In other places, we directly use pte_offset_map_lock(),
so convert it to using pte_offset_map_ro_nolock().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
---
 mm/khugepaged.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f9c39898eaff6..6498721d4783a 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1011,7 +1011,11 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 		};
 
 		if (!pte++) {
-			pte = pte_offset_map_nolock(mm, pmd, address, &ptl);
+			/*
+			 * Here the ptl is only used to check pte_same() in
+			 * do_swap_page(), so readonly version is enough.
+			 */
+			pte = pte_offset_map_ro_nolock(mm, pmd, address, &ptl);
 			if (!pte) {
 				mmap_read_unlock(mm);
 				result = SCAN_PMD_NULL;
-- 
2.20.1


