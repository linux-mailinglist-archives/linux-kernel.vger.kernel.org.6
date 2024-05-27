Return-Path: <linux-kernel+bounces-190502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D5A8CFF4A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5BA91C222B0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE0215E5BD;
	Mon, 27 May 2024 11:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="hW8JHFtW"
Received: from mail02.habana.ai (habanamailrelay02.habana.ai [62.90.112.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDA915DBBB
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 11:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.90.112.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810522; cv=none; b=UT/TMF+6KDDVi4VxcDmudhuOtFb+QZtJgXxpabC3a1JPHLDmuYr4uOijv+XlovVVF7VVDZl9MdKwOv4B3py3sAEizxhyenDbSngy3PGo0J79NChwfXtmKUiGrhzsVA8ugg4LYZsWKTnqDe4pNt7QMucBTeaGsIDq7M47MdjHkps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810522; c=relaxed/simple;
	bh=ilFlKvDjUOWwDTTLLUhcCL8nUKgNxe8o+4Fl4gvGbvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y0JOtgjon1ZkGnk8bz1poB2nhFVvyq/tHGQXif5PBx3DwSOInCB5Ykr95p6ZWK1AffLybHP/6Vje9ZeJLCfETPRjIpWVuoOG87UyUGrd8ED1kroAefq8AnBrwMddAPgdMR7HowdvNFMjfcniYZjozivqs+Vt0czmB4cLESXn2JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=hW8JHFtW; arc=none smtp.client-ip=62.90.112.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1716810481; bh=ilFlKvDjUOWwDTTLLUhcCL8nUKgNxe8o+4Fl4gvGbvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hW8JHFtWJEuEKxKrXTYIP2v4tu6yLxLvTWog/t/c2BN4HMoSjJ3hkHMgaoJE7p+lV
	 D9Irj8K0sw5TUouEe+9J9kz6NX9U/nVSSoPKTi1agWGUeSVK9g7jxXkzFjnqiWaX4m
	 4Xu6SvSVloohX0FhzsskLYuc4jvv0O7lible8rPEtZgixSjyVVtPgJkn0hbsApTMGp
	 ea/dAX4OrVpZ4mFoYl1riTMBjQ7vVgzvRDUL40qE+6Gq6PNb3Z78oVPwRManRGcW1A
	 63B2cekzew7A/erGrhmj5rKktTMUzu9n0hULE/qDI5x16f8t+B7QBuUBHrmV/36lUW
	 DfDfkb94YrOfA==
Received: from obitton-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by obitton-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 44RBltNm1919357;
	Mon, 27 May 2024 14:47:55 +0300
From: Ofir Bitton <obitton@habana.ai>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 8/9] accel/habanalabs: add device name to invalidation failure msg
Date: Mon, 27 May 2024 14:47:45 +0300
Message-Id: <20240527114746.1919292-8-obitton@habana.ai>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527114746.1919292-1-obitton@habana.ai>
References: <20240527114746.1919292-1-obitton@habana.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ohad Sharabi <osharabi@habana.ai>

This addition helps log parsers better define the error without the need
to go back and search the device name on former log lines.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Ofir Bitton <obitton@habana.ai>
---
 drivers/accel/habanalabs/common/mmu/mmu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/habanalabs/common/mmu/mmu.c b/drivers/accel/habanalabs/common/mmu/mmu.c
index 166c7da8b937..a9813ffcde14 100644
--- a/drivers/accel/habanalabs/common/mmu/mmu.c
+++ b/drivers/accel/habanalabs/common/mmu/mmu.c
@@ -645,7 +645,8 @@ int hl_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard, u32 flags)
 	rc = hdev->asic_funcs->mmu_invalidate_cache(hdev, is_hard, flags);
 	if (rc)
 		dev_err_ratelimited(hdev->dev,
-				"%s cache invalidation failed, rc=%d\n",
+				"%s: %s cache invalidation failed, rc=%d\n",
+				dev_name(&hdev->pdev->dev),
 				flags == VM_TYPE_USERPTR ? "PMMU" : "HMMU", rc);
 
 	return rc;
@@ -660,8 +661,9 @@ int hl_mmu_invalidate_cache_range(struct hl_device *hdev, bool is_hard,
 								asid, va, size);
 	if (rc)
 		dev_err_ratelimited(hdev->dev,
-				"%s cache range invalidation failed: va=%#llx, size=%llu, rc=%d",
-				flags == VM_TYPE_USERPTR ? "PMMU" : "HMMU", va, size, rc);
+			"%s: %s cache range invalidation failed: va=%#llx, size=%llu, rc=%d",
+			dev_name(&hdev->pdev->dev), flags == VM_TYPE_USERPTR ? "PMMU" : "HMMU",
+			va, size, rc);
 
 	return rc;
 }
-- 
2.34.1


