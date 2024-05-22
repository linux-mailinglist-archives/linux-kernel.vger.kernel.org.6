Return-Path: <linux-kernel+bounces-185923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A748CBCEE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03D41F23087
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 08:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84D280029;
	Wed, 22 May 2024 08:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLay6nv9"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC1F7F7D1
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 08:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716366457; cv=none; b=mNUe+Ivn8LoE8fx+8MKH5/YBP9DkcY+6MgNc6Y9FM+B87xz7qzTVT9IyYgaMM2Fg5TAxC1yDwqKfERATFb3D9oicekvi6vbNwLXUiQpftMzAjHonM4cA167ZXcurYvgbh4MilPGW8U/zhuL1CG9EsVvrzLxUvwV9S9pG2IFbciE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716366457; c=relaxed/simple;
	bh=EzbbarVAceIThGcdDJQMoTLX0eccNmtcHB8EGB1fufo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lu1PMwAqEYTsRzhjlf3UplpaNA9de6DT0bYLocO0zYfP325vKfZp+WtK8In1DScyquCxB2UA0CAdsFWlBwPjp+ugTUqqpuxa97Hq+naP1PtvX9ZCoZWjt3tkyLJ7k84u7fDDo3FjsXdanBJUlfQY7jQP3MATTSeNyC8NW4IgQsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLay6nv9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41f9ce16ed8so6850015e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716366454; x=1716971254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tTr2u/xpZoc7xpf88V/G0TB2e+qjtO4Yfevyp6Z/VM=;
        b=LLay6nv9VfqaC1cJuSMyv0a5k736OcWAnGwJKwk1UuN9x/5n0BfqLGDBjc+1zTCUGU
         ou/PQl2p8shzNdxOY9SXQdgYfiguJ1LaO7hmLaHBjCJtLZErfQ4I09IKLWrLm8yBxvjO
         /7XAuGvmIPac/2r4RhDobzUrM5rcf7iRHfuaohwOGmnXeHukzWClTWwSiZXHs4Z9qq+w
         XOf7XXf8Wuc07fIuY+GjlJ3Osur9eFFuRo2/OhwmhQpnYh8ah4CDgXrvnnmpcd8aooFL
         zu6JH11mBIsUbwX10oQIhq10NPOFZbGEcGK10kphBxFIfoF1ymsBv0bRd0kq/qQzmUQd
         czlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716366454; x=1716971254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tTr2u/xpZoc7xpf88V/G0TB2e+qjtO4Yfevyp6Z/VM=;
        b=XUOfXejG49XvOJO09Lc7NwgD9AAAaZUFnZs35unSloTast9lzi4gfXxgwDQHENEuMJ
         BGbmysBJBDRIQF4JisIYJyfhg0x8FyXCqwpjZrY7FHX3qohOgVeFLf8Ebte5vHfsdGNW
         ZRckU+i6BeG2OiFmGjEyPk9p6TKbVq/NqQY3VCvkBW+mgSeKvdPdnH0jaTPZ5HDai2Ee
         SZe1DSmW7S7eVOx4MEWeDZHriRnNmxZ/dCxw51cAPpuk5AHL0az3mJy5eB+LTm/0QI+Q
         9kSCIFu7VjMQd3jgcFGvSHXBBaO2zcN6kPj+e504xU+cQuQyV/rMbGMvv88eLSQc6FVX
         ZUaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWCQtkJBLa3ge00UPIE6dHzTX3ILfNH/6dgpj3QydbuVEWIKr6Vh73dcO6/spo7MrlHbORTZ+1CiQnRG7uP4GgKpVs4L2W2nZNEoe0
X-Gm-Message-State: AOJu0YzQ+/di8AdJj0thngWwlzN4eAOoIkdjESmzXx5KFyBLD1T2KsOb
	ZUhlsVN5cq7avonkYsdBPaR9OVzit/2s64nYXEU4DZK6pgGBZYiV
X-Google-Smtp-Source: AGHT+IG9IJ8rp3fmMs48dAk6Y747OYcyjpxClqnc3kVxDzH+SdddvdkpIdEFObD0FX56tEt3Spe1fQ==
X-Received: by 2002:a05:600c:21d5:b0:420:2cbe:7f16 with SMTP id 5b1f17b1804b1-420fd3726d5mr13217935e9.34.1716366453292;
        Wed, 22 May 2024 01:27:33 -0700 (PDT)
Received: from fedora.iskraemeco.si (84-255-245-182.static.t-2.net. [84.255.245.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bc0asm33964495f8f.1.2024.05.22.01.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 01:27:32 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 2/3] iommu/vt-d: Use try_cmpxchg64() in intel_pasid_get_entry()
Date: Wed, 22 May 2024 10:26:48 +0200
Message-ID: <20240522082729.971123-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240522082729.971123-1-ubizjak@gmail.com>
References: <20240522082729.971123-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use try_cmpxchg64() instead of cmpxchg64 (*ptr, old, new) != old in
intel_pasid_get_entry().  cmpxchg returns success in ZF flag, so
this change saves a compare after cmpxchg (and related move
instruction in front of cmpxchg).

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/intel/pasid.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index abce19e2ad6f..9bf45bc4b967 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -146,6 +146,8 @@ static struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
 retry:
 	entries = get_pasid_table_from_pde(&dir[dir_index]);
 	if (!entries) {
+		u64 tmp;
+
 		entries = iommu_alloc_page_node(info->iommu->node, GFP_ATOMIC);
 		if (!entries)
 			return NULL;
@@ -156,8 +158,9 @@ static struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
 		 * clear. However, this entry might be populated by others
 		 * while we are preparing it. Use theirs with a retry.
 		 */
-		if (cmpxchg64(&dir[dir_index].val, 0ULL,
-			      (u64)virt_to_phys(entries) | PASID_PTE_PRESENT)) {
+		tmp = 0ULL;
+		if (!try_cmpxchg64(&dir[dir_index].val, &tmp,
+				   (u64)virt_to_phys(entries) | PASID_PTE_PRESENT)) {
 			iommu_free_page(entries);
 			goto retry;
 		}
-- 
2.45.1


