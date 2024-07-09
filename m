Return-Path: <linux-kernel+bounces-246793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5D392C6C3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B441B222E6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8561189F41;
	Tue,  9 Jul 2024 23:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mdiqsbRs"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF0D1474BE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 23:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720568960; cv=none; b=KPkfyg2xu1RrEoi8cLIJzbaRvU4EpDaANv/5wmm0z8ypfVhIZcVBoQ5bG/8HgqOY8uk5a/QFOE8VYuQ+tceupgEZ6q6M3I8WH3O/xWudBUd51/5nCuQA6EUJf+F2WgNYnVpVSvjLgfnE92vjTxuqVlmRCq33LGWHjLjLBhE0eM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720568960; c=relaxed/simple;
	bh=yGKs/GKCL3nl4YxWXN4A6FvutpRKPliWYBfVVipIw1w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=S1Mca4jpV5K/DV7erVmjc72UidHbLXo6YzxtknXVXsq5O6A5r2I9AvFjqthSHFgwTIH9plwidnjaaQ9CBLFnlX+Bb1ZE/N2Xulwu2hbZBxAdMpGAGpJYikyxCpPZz+l8uPas4hM8p0fL1NUWoE9F57DCQK2YDf/PwCvQl3lEJLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mdiqsbRs; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-64f4b849b7cso98323647b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 16:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720568958; x=1721173758; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7mDbytgqOLMqMz+EYXhiJVnxk2hfmw4URx/DKSaIyt0=;
        b=mdiqsbRstXoVR7obHo0tIaNmtBTA/4hTuEyzS3SxKpe4PgzNlWZg5jfZk+t1BLYKUE
         LqIGf7qBNT9sH2waTkJsOrfudiwUKhUBVmjxuXjmSgr4WSQ8V3rswyedOXImWl4UFJbD
         vM0nJOzqUa0oFCuQnhGqnKOD/oLz/OwYr+kS7Xzlfi9ELVxLU8JIEVkZeTy8y7JJ7QKZ
         7o0qKwe7Zx3hCw9OgEvlUP7q1NVeHXX+SNQTlIBDK0mpexC/uTgoV/Whgc96GBBXZFgE
         5MulyUuphNIBczBOaBJvzT2wV492XCQO8BnTXB/NNVHRxMNwxC94pqj3Xab1rv3silsB
         ADFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720568958; x=1721173758;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7mDbytgqOLMqMz+EYXhiJVnxk2hfmw4URx/DKSaIyt0=;
        b=KkzrfCCoLkelQEPVFeTDkscvrKtRB+5iOllC532sfmTuUCHX1UEsa8hujsi/+nUfeO
         HYOjXclX/b5cgzdhiFw6rbLGXbrOuPB2FWLoD024qQka5M7f2rNI2aJmEvsOm0ATpG6Q
         86kUUWLLPtUKfgNZ3sDDclqBAQxy2HkDZv50u4POZD8PC2WqRrM0XHtdAAl2eg1otcw7
         QCSK2FG9ZjPnuOa++qSZEcOQz2p31PLRtyipZsgipY6+vIJA4dJYb3BV/ftlvLgwUNcr
         o+CRx/vd0SaC22pdIfSVO6lOCCJMNDxNiyXd3pQEu1dmQBQZkDEdegwmQBA6HvDPZu9o
         NxMw==
X-Forwarded-Encrypted: i=1; AJvYcCUMgXLjc7EYZj9FFAj6t/ehVG0h6oRld5P24UNkzF00iSplPUrl70AOu+Xk1g2wv3lHU2x00YZtCzp4Jr9g2L7On7omiu+rmlMc5gde
X-Gm-Message-State: AOJu0YxRZ010+QiqiO3vtXunWNd1KrSLloNMB/TDinolAA9XG/gqP5sG
	al1pgPTNOSDl9rtHB7jraSuWQaH668AGJdCznyq93amF8qMt/3bCLo4Q42PhkYtnMNDq6F4MTgc
	Row==
X-Google-Smtp-Source: AGHT+IG8cNE725G12Kfa72RNPLrZxQ2HsAiG8z2ywoOGl1i6XzVN390kI4TOHDz7MkFev5cilMkjvotl9kI=
X-Received: from pandoh.svl.corp.google.com ([2620:15c:2a3:200:dc7b:3f1c:f4a8:f387])
 (user=pandoh job=sendgmr) by 2002:a05:6902:161a:b0:e02:6dcf:e9ab with SMTP id
 3f1490d57ef6-e041b0688b2mr7939276.6.1720568957867; Tue, 09 Jul 2024 16:49:17
 -0700 (PDT)
Date: Tue,  9 Jul 2024 16:49:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240709234913.2749386-1-pandoh@google.com>
Subject: [PATCH] iommu/vt-d: Fix identity map bounds in si_domain_init()
From: Jon Pan-Doh <pandoh@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Kevin Tian <kevin.tian@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, "H. Peter Anvin" <hpa@linux.intel.com>, Tejun Heo <tj@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Jon Pan-Doh <pandoh@google.com>, Sudheer Dantuluri <dantuluris@google.com>, 
	Gary Zibrat <gzibrat@google.com>
Content-Type: text/plain; charset="UTF-8"

Intel IOMMU operates on inclusive bounds (both generally aas well as
iommu_domain_identity_map()). Meanwhile, for_each_mem_pfn_range() uses
exclusive bounds for end_pfn. This creates an off-by-one error when
switching between the two.

Fixes: 5dfe8660a3d7 ("bootmem: Replace work_with_active_regions() with for_each_mem_pfn_range()")
Signed-off-by: Jon Pan-Doh <pandoh@google.com>
Tested-by: Sudheer Dantuluri <dantuluris@google.com>
Suggested-by: Gary Zibrat <gzibrat@google.com>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index fd11a080380c..f55ec1fd7942 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2071,7 +2071,7 @@ static int __init si_domain_init(int hw)
 		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
 			ret = iommu_domain_identity_map(si_domain,
 					mm_to_dma_pfn_start(start_pfn),
-					mm_to_dma_pfn_end(end_pfn));
+					mm_to_dma_pfn_end(end_pfn-1));
 			if (ret)
 				return ret;
 		}
-- 
2.45.2.803.g4e1b14247a-goog


