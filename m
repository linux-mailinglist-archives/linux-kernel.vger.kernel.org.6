Return-Path: <linux-kernel+bounces-286336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3609D9519D0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681181C20D41
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08231AED3B;
	Wed, 14 Aug 2024 11:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="dfvJ/BYc"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72F733D8
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723634665; cv=none; b=rgbWfYdqBwUznusU64uqEJl3LjpyKaKAo+s68g2otLdHqNUbIlUdi8nG53wFwVYbhv/YxCmlJqCiL4ijs1hBdxiS5ZS75+Tfj4xgISy3c3qcmf/jcxKOMj2lSkEhiZFEn9UY/jMdZ+V0EF4EMniFUtq0H0RRVFSqrCsFbeoMJtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723634665; c=relaxed/simple;
	bh=kqDpV6GW4s9LS7UCsXnQnFTFNDMtjqH17Enqz0woQgs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vlh+Yx2lzPdfXR5ObySHNkVtMxANMlT+nXH3mDf6mNH2FLNP5rQL0sRvDD7vk2CuAmf5+0EXSX0l6cSFb0vBo1HHu1zvK2ln2/rDZPnCbyu2bCpWQCxy9BuPdbzVs7aQr4IWwpswf4M5jSgBmKZn7nPzHzXvnYDVJ9kPIjmYcnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=dfvJ/BYc; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C7AC93F322
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723634654;
	bh=DGRTrpULtBgL9ziW5qYGERpz+KbgogQRgUFpUA3ONkY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=dfvJ/BYcniG8ZTZ9kzNEpMMJavOyHkX14qW3lJqDLSwRnwnH71jPL/1lGQqgvWJS4
	 EOt3z5ASvInzCNoX2PXcVutdRGF5KJKIUCu8jgCwx9CApOev8rxEf4ElOi1Zg4fiTb
	 eIXznJS88urdS/2KQCIasrktvIY5WkRcuoq7JzJ9PJmAsVCq7umVfHZhwROnIzMear
	 uG+dj2wXYeDNkLkm015GVyWqhNWAbiub2Nz5PNAtCfZcZlFnNJmOZYodI9CFnho6Xn
	 MyigY5MtfaJf+NRua8erVYIswelBa92dWMuz1tS6PC4LLAX5YwyFo5i+Y7Ybg6nMip
	 zf+df4tlRpXSA==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a7a822ee907so522951566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723634654; x=1724239454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DGRTrpULtBgL9ziW5qYGERpz+KbgogQRgUFpUA3ONkY=;
        b=V+tGc40Rh9zqH3QfD0PUsAeY3A/ZY1gU8an3G6sBn3dKqwvag1mcq8Pj8mpZMb6RL0
         9IHsO2KiWVlBx3eVLvWa7AoESD43R+X4iljsrHe0wLahvQb+PRo7JjswQtDWhHWiPKuu
         GZm8Emt46c7WHWif6B4h3UH3Y8GQYR50oGoYqgbBap5lLEASmWOG4sPhs/oR/KSw8Som
         posdg8liL6sRopvjOKvRY3eXl4AljHv7wLLb4bGVcSbpea11ZTIpyJ1glpHHdmp0fZPv
         b17asT0vehItIibVVw+sCqExHCZHG/6YO0cj/3nSJj+Yb1XkZJDWDxNC1X3Om75RuY2W
         ZIHA==
X-Forwarded-Encrypted: i=1; AJvYcCWWj4cFqUkTcah486mAJR90UZTiOrUlEDVkR71O0vfo3SaOpmmi6nxxp/vXqitjk7SBB6cgiaIxx4VESY/+cKES01UDrx03OL6gfOng
X-Gm-Message-State: AOJu0YwouZjgczCQRDRHgt+WpI3RlMq6WZ2PwQM+L8gP0cb72+9I2mG0
	3GuUmejLGNuDxy2ek4+8hwdx+8U0TZuTiCAx2EAHaGMHqk1Xr55mQR/yzL3GWaxwSRffRlFGsVf
	QmiSRusQygy2VlFBhNOa7DG/isNWzdi+XF5jMTykYDNSJPkCK/HQ+srKv9SXkUNI7LlWCzb3BKo
	8s9w==
X-Received: by 2002:a17:907:e2d3:b0:a72:750d:ab08 with SMTP id a640c23a62f3a-a8366bfc25bmr166647066b.14.1723634654202;
        Wed, 14 Aug 2024 04:24:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqJ/FYMhm3HKEPcMJXzca42gbyfdyklEBH91iFSJATAmPNeFRFyyNn+G3/we+Qa3Mu8pH8iw==
X-Received: by 2002:a17:907:e2d3:b0:a72:750d:ab08 with SMTP id a640c23a62f3a-a8366bfc25bmr166644666b.14.1723634653684;
        Wed, 14 Aug 2024 04:24:13 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fb2110sm159919966b.78.2024.08.14.04.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 04:24:13 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: miklos@szeredi.hu
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fuse: use GFP_KERNEL_ACCOUNT for allocations in fuse_dev_alloc
Date: Wed, 14 Aug 2024 13:23:56 +0200
Message-Id: <20240814112356.112329-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_dev_alloc() is called from the process context and it makes
sense to properly account allocated memory to the kmemcg as these
allocations are for long living objects.

Link: https://lore.kernel.org/all/20240105152129.196824-3-aleksandr.mikhalitsyn@canonical.com/

Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: <linux-fsdevel@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index ed4c2688047f..6dae007186e1 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1486,11 +1486,11 @@ struct fuse_dev *fuse_dev_alloc(void)
 	struct fuse_dev *fud;
 	struct list_head *pq;
 
-	fud = kzalloc(sizeof(struct fuse_dev), GFP_KERNEL);
+	fud = kzalloc(sizeof(struct fuse_dev), GFP_KERNEL_ACCOUNT);
 	if (!fud)
 		return NULL;
 
-	pq = kcalloc(FUSE_PQ_HASH_SIZE, sizeof(struct list_head), GFP_KERNEL);
+	pq = kcalloc(FUSE_PQ_HASH_SIZE, sizeof(struct list_head), GFP_KERNEL_ACCOUNT);
 	if (!pq) {
 		kfree(fud);
 		return NULL;
-- 
2.34.1


