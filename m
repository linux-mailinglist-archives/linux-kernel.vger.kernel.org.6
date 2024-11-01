Return-Path: <linux-kernel+bounces-391818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A99DE9B8C0B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 08:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E31F28312F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 07:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87BE14F126;
	Fri,  1 Nov 2024 07:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLxQavlV"
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608A21537CB
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 07:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730446052; cv=none; b=Aq95gpDA47hY8kuZynXqiyYPOJBMyHdaOwmFfeNqxdYf28Wi3+LLCOE46vYrV+3fCEnoTmt/wNxkwJ3QMZ0G9eHB3Zer3PPX4sKbWvlGnDLcBixUbJ8X7xC/reHBtFV3fFsH7299hEArhKXSXwWSqDGJYxi7C0kApOzquOe+ruI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730446052; c=relaxed/simple;
	bh=vbwCH43v+F+cqZSu7qSklVC9B4S9wbxwdeC8XG9OmJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nEuH/JGIGMO05EOt+GDUnI/UmD3vtuntdqwaPipL6+TGZoqqJYZvB+/Fk0QBWZ3g1JMy+olhsuH+uccAlr6ITSId/qu0PhO4vyoZRaV49jhiZkSs6W67WWBFoMsRByTgsLyGbSRXb0KhWXFayiyIOy81939PvUyZJuJor/B4gG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLxQavlV; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-7ea7e2ff5ceso1437684a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 00:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730446050; x=1731050850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S5K5NRKTjgozwbq4TI9INicCOEVBgTK8ZAiuC+AN6Ug=;
        b=mLxQavlVVCUxjk3QctvmybqVJkeD+TNKIl+Y5GWPqmSlnhBkOsNuQUhaRX+PqISOoi
         elTf+dxpM+08oWOQMuusqkkixTgvMzgZQ/ZoG9XktxDzEwIcnjOPZVMTf9a8fWFJterE
         v78WxeoQruaGFMLHPDW0hA5E2cM907b+IWk13wyConGYzZYGToi2mAWufY+7MlTW81l/
         +6eg9bBPd1VFpmwsEcgF/lHFJk/dK7X+M9x8wBGefzRJENFIco7mzhNLRjeim8vvVvFC
         v6JY8dRw2Xkw4QyZfyYAZahZyYggFBbLS8y6Q89pb4Iy9XHJq3NJqd8lqscG1LPX2inz
         YbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730446050; x=1731050850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S5K5NRKTjgozwbq4TI9INicCOEVBgTK8ZAiuC+AN6Ug=;
        b=YKU/GK7vRgAbv42h5tGfgP7mr/AARZyycZoMpHl7cEMxhZ8ssZay3SvjZl/ugDsa4H
         B33wQ91WcZdVTaTxbHy091V3Nr7eiaVIYRfuNBj8duQnx0ytu4MoMIesVAlsB4aAGlYH
         6Fj8/P/MbwXxTxvDwPnkfX1iACfuF8B7zqDlWWqwWdPACvLNEm1oi+KubjVSAvaW/E/J
         okXOH9TgHeLzesXfeADvTNeSNbu+y5Na48yop4J4mvDEmhgvE3i40v0X4w/SWmZmYd+c
         XPchrxF2pNXLsKBFq/9D39OEOV706ASoUydqzbWWNPqf2N5W9ZgsXlPX/1pZLLRRrZv/
         xSZw==
X-Forwarded-Encrypted: i=1; AJvYcCUtgtnMOA50T7aHJm58Fu1mUD32eGhrR2MMaHW1IW5u0twUwg+j6GifQwkFiOvcZj1YlrHy++k+cQ8reWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeSHvdJvqVUDN3Z7jjY1mVXKzF7ROxxnOmwEzFacUHmURN1fFZ
	li5hvxtKNFl1JFn+H6BzpAZWW5Gacz3pPfkAyXOLR4tg4JLJpbyAVzTrJCGCh+MPMg==
X-Google-Smtp-Source: AGHT+IFkaQSma+gxqA7eJVlCs+LIM3I5FsMgjCZKd8hGaEuwwFW/ev+Eu/5LoRtR0gowvT/Uxfh8Zg==
X-Received: by 2002:a05:6a20:2d29:b0:1d9:2335:a893 with SMTP id adf61e73a8af0-1d9eece4daamr14904566637.28.1730446049556;
        Fri, 01 Nov 2024 00:27:29 -0700 (PDT)
Received: from localhost.localdomain ([2001:250:4000:8246:8007:bb90:49ad:3903])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc314670sm2162749b3a.191.2024.11.01.00.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 00:27:28 -0700 (PDT)
From: Gan Jie <ganjie182@gmail.com>
To: robin.murphy@arm.com,
	joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	trivial@kernel.org,
	ganjie163@hust.edu.cn,
	ganjie182@gmail.com
Subject: [PATCH] Driver:iommu:iova: Fix typo 'adderss'
Date: Fri,  1 Nov 2024 15:27:09 +0800
Message-ID: <20241101072709.702-1-ganjie182@gmail.com>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo 'adderss' to 'address'.

Signed-off-by: Gan Jie <ganjie182@gmail.com>
---
 drivers/iommu/iova.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 16c6adff3eb7..a28197b88c92 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -506,7 +506,7 @@ __adjust_overlap_range(struct iova *iova,
  * reserve_iova - reserves an iova in the given range
  * @iovad: - iova domain pointer
  * @pfn_lo: - lower page frame address
- * @pfn_hi:- higher pfn adderss
+ * @pfn_hi:- higher pfn address
  * This function allocates reserves the address range from pfn_lo to pfn_hi so
  * that this address is not dished out as part of alloc_iova.
  */
-- 
2.34.1


