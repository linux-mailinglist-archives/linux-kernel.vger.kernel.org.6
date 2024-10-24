Return-Path: <linux-kernel+bounces-380300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5C49AEBF8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7D61C22D89
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01841F81BE;
	Thu, 24 Oct 2024 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fcaNuoXj"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734DB1F9ECE
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787145; cv=none; b=sKGlln30NpWaH2++STPTMpiZUfaPRdIAW7TUlWs0FFYUQMvk8Js4c5aX5K15foKagtySBq1uykgeAabkGd1hgoUrtMF7O1CO6KOptvH3/xzUJzfCXh+utN+3Iz6gtAg5GJ9IL0TtJ+ugWZqll8pBvtogJHomVzw48+2X+wgkBEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787145; c=relaxed/simple;
	bh=LEBgTUnCCavk4XESlWe8Ym/R2LORUkbfBaXuaMM0wrw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OqxCRK6cfFTveN/dk9qf0Xh5UU8lSWNcvB43dawUsoynI4PuDTtPCM/JSDJfvkz9a9X18Xt0odRJt5h/NNev055S9Z+X8n7FbLJfeNa3IpHqLXOJolQA/InYvmnwQzePxoOIlNYO7l75yQ5wLqAGKfkQlrdO0Sumap3P2v3nqNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fcaNuoXj; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4315dd8fe7fso11116215e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729787142; x=1730391942; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UsCpK9EL3WBrTQl/LxYwj8dMuww/QQmOZNLTkcqzgvw=;
        b=fcaNuoXj/uLcdLiTwTAr/x0P4BysiH5lGA2omDFBlGxPsSmMuC1uX3biIXiO/jOqBL
         TcJykovsNTTE59ydQWN/9EZhEuHqTX8vy5Bn6mIw7/4WpLeqeVrzea9pga7AWgoNRwSp
         +XCWeCUId912oumkq+tUe+0BA9YT/UXfxwnPirVghf9XeqBLsZ/1+J95+JaSm374uLre
         k9Kw5nBh3ghDZ7BJSfs8caMp2dXA6fXsCDCLvy2nj4GPTqkVRGfxbrv8+7GkkTtoA4MD
         DurKvnRLSIiYkiNzzLnhs1pcEqCUfw0D3Ult+vr+6YOapPC2Kmp6j2GQxEXDS5O+BlFg
         qZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729787142; x=1730391942;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UsCpK9EL3WBrTQl/LxYwj8dMuww/QQmOZNLTkcqzgvw=;
        b=XE9H/eV7e8M9/dyMcmoYLB1qQCTChom0g/rp63ZVYVvzDo55spZpgd2vOapMXcITgG
         V8ltkfNk+4X/11rnCZlVZnS1nsFPMGGIOO4lZ+LvQlIvt5lHaBb3sicWQydz3DUFONWA
         8TKJJXFtLERLpy4pm7gkXoiNQuDBK/2bhmRJ1jZzfhOBIjWAaJmpMMXZfNu5tZL0v6CU
         hRY6i5DOeVUcMAPayssWQnAd0T293q764qYu5NKtSMiG9+02LepK8yFImgq/5eqOqKY/
         7kB3b8dbDEDQEOvxBiecN+bZvFnsIImdnj0/Akmc5YKvxLUw+S0GCJkcWoiCeiowl7+N
         K13w==
X-Gm-Message-State: AOJu0Yyze2M73bnwBf2nnDL5PrRdUpPrBOJLiArWbT+3vcxd+x4RKDCC
	uT9up7nhTrWXLKkOA57bps22y0PylasCVLkmD3kobyAwaqqq0i/3dqUMC+UxLts7eNb+wo6CbqH
	7nc46MfRr0kg4kcQid74EOPeum+DRlpUPLvXfCQQ5LmHQ/pBX43BWYgQVc7hwCmF4MyKqJIbnFo
	uZHHhKFaQiUHQMGK5TZ1l6zctn+RDzuWMswzR9sk4++ZyrBXHnWZk=
X-Google-Smtp-Source: AGHT+IG9pePnfv6Q2uIrCeDhwlQCCiK/QZZKTazhUEbVv0rozU2r0vhyS6+O/NBsXh3MroRlMS7z8qAoBEUUYg==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:600c:6b6c:b0:42c:a585:5ec3 with SMTP
 id 5b1f17b1804b1-4318c72bd26mr65625e9.4.1729787141740; Thu, 24 Oct 2024
 09:25:41 -0700 (PDT)
Date: Thu, 24 Oct 2024 16:25:16 +0000
In-Reply-To: <20241024162516.2005652-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241024162516.2005652-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241024162516.2005652-3-smostafa@google.com>
Subject: [PATCH 2/2] iommu/io-pgtable-arm: Add self test for the last page in
 the IAS
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a case in the selftests that can detect some bugs with concatenated
page tables, where it maps the biggest supported page size at the end of
the IAS, this test would fail without the previous fix.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/io-pgtable-arm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 3ecbc024e440..71e8046671a4 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -1393,6 +1393,23 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 			iova += SZ_1G;
 		}
 
+		/*
+		 * Map/unmap the last largest supported page of the IAS, this can
+		 * trigger corner cases in the concatednated page tables.
+		 */
+		mapped = 0;
+		size = 1UL << __fls(cfg->pgsize_bitmap);
+		iova = (1UL << cfg->ias) - size;
+		if (ops->map_pages(ops, iova, iova, size, 1,
+				   IOMMU_READ | IOMMU_WRITE |
+				   IOMMU_NOEXEC | IOMMU_CACHE,
+				   GFP_KERNEL, &mapped))
+			return __FAIL(ops, i);
+		if (mapped != size)
+			return __FAIL(ops, i);
+		if (ops->unmap_pages(ops, iova, size, 1, NULL) != size)
+			return __FAIL(ops, i);
+
 		free_io_pgtable_ops(ops);
 	}
 
-- 
2.47.0.105.g07ac214952-goog


