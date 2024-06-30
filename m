Return-Path: <linux-kernel+bounces-235285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DE691D2F5
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 19:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74FF61F21218
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 17:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E98C155A5D;
	Sun, 30 Jun 2024 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUAFoTlv"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7533015572F
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719766836; cv=none; b=ArqxN4ewJSTdKV9Lf6ikkALfV8f7SmQNGQOx0sO4CJkj4IEUwGR0Jj6/kFV/bVAopvmy7/tOKX6PD8wfR0hGXuuKaHwqtRJcORywpRj9WixRiWp1Z/2uKQuxxpJDGnydz72R2GhbYykjhp2nLzdUaKivKft5Ggdp1QQ608IOxUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719766836; c=relaxed/simple;
	bh=iX3Lh3JQVijtFa9VNA6uEUMFceyEx9AFavXCRd3VyW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mf8LKntHh41Mm2Ypv5mcbwY3C2lap1C1YVvO4eaxlTUjt0tPB+rlTOyWATwkSPh2W0MEg2rcPxq8ioaLojk03HNBl6d/7xuMGRkt4Y1pE7Vvq2G4xeYmfVqQp7s3X8JzgQHrz4XkhPTS+wswJPF8YJkJOoH8s5xVNKwisw6YG5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUAFoTlv; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-79d55fe9097so177206985a.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 10:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719766834; x=1720371634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOAqEF8HBq/c8/HLVMEZy1JjMjgUXa4TTTkMry5URs4=;
        b=FUAFoTlvoGnSlZOPo8ZZ7XH0D8xaiM4YQc/FLiomUSkTXCNKkQUmKFgGspj79CwVpT
         lvGWpuo1EUgOUXHOFR4wqtYkVJZN0YmlDr/0ktPWjJqU3HBmFMIipsRQxYSVmnArfc/K
         kUbg906e++efYtWZKAJ/AY0AQJ18+UzALL+PdKOMhHTReiMG2MFVhZZnB0lQLPDUhjdx
         E7mId+DpxfcccYEF/wn1nb0ltbMTsFqIKyMGnxMmBo506P11xHgd2zO8OG57XB6PZuHQ
         d6JSFXDvcBHLvU6maArW6QU3EzEnTt3px2ih7zvWvPSW8CAyjOEKHpZ0iEoCBLqq1lr9
         QI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719766834; x=1720371634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOAqEF8HBq/c8/HLVMEZy1JjMjgUXa4TTTkMry5URs4=;
        b=TNRmHKjlZ/2zMvSwurZM5dC2KkgVbnyHUJXtm/Vuo7ozGT89MuK+mqRxi2OwGIPY4z
         2H3K4aoFgZSDBI/nTt6ZhX4pVuJr+ONXyWtk3CCZnbdGlhC/DhG/W/kHbB3rDb9rI7k+
         iO2GkGxSDtU4hetJADw+0u7QaOK78f4+15tyRPKCMgD9FtaVHp9kVPvnK7AnUmacuBnX
         r5BtRnlbsI3+xfbQFrsO20b2m35z2pC2xvWoXNkKdULIRgfJ5QfuqWNryU+/BccDJjsj
         LycxhGekeSoMNzPdz8BWDFODBzs61kMoFqLhM0VZgOYzPeTfmj5BmIFUQqoqfvub01LF
         ji9g==
X-Forwarded-Encrypted: i=1; AJvYcCV7fdxC+IhK8MxYacV2Gwpyru0vtKGNkuGHGiANYJ/Fy7S9KkgNBkDOQdcaf+PBOvrI6U8lMpBSQaMHhSlQu0jwAInjPdS/islurtOj
X-Gm-Message-State: AOJu0Yx8AUMN/OG0cG8HuX1PhIMorKhPv2mZVPwCvOO83G/UBhXdtpvh
	4HP8BtBiT72Tn7Rn4b8G3JURceDSu5LsiOgGiF8j78Jm3HlL3Xe4
X-Google-Smtp-Source: AGHT+IHk5xMH+iHy4kgznjXyO/Fbae7oHqigKr2e4C+Oquw5T9HXa7nj+zH8AokmUX3S0CDkJ/rPMw==
X-Received: by 2002:a05:620a:1098:b0:79d:561c:bba1 with SMTP id af79cd13be357-79d7b9d68b8mr412701885a.25.1719766834330;
        Sun, 30 Jun 2024 10:00:34 -0700 (PDT)
Received: from localhost.localdomain ([142.198.217.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69295f5esm263431785a.56.2024.06.30.10.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 10:00:34 -0700 (PDT)
From: Wu Hoi Pok <wuhoipok@gmail.com>
To: 
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Wu Hoi Pok <wuhoipok@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] drm/radeon: change variable name "dev" to "ddev" for consistency
Date: Sun, 30 Jun 2024 12:59:17 -0400
Message-ID: <20240630165949.117634-2-wuhoipok@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240630165949.117634-1-wuhoipok@gmail.com>
References: <20240630165949.117634-1-wuhoipok@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the probe function of amdgpu, it uses "ddev" as the name of "struct drm_device *",
so I suggest renaming it to be consistent.

Signed-off-by: Wu Hoi Pok <wuhoipok@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 7bf08164140e..739bb1da9dcc 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -259,7 +259,7 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *ent)
 {
 	unsigned long flags = 0;
-	struct drm_device *dev;
+	struct drm_device *ddev;
 	int ret;
 
 	if (!ent)
@@ -300,28 +300,28 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
-	dev = drm_dev_alloc(&kms_driver, &pdev->dev);
-	if (IS_ERR(dev))
-		return PTR_ERR(dev);
+	ddev = drm_dev_alloc(&kms_driver, &pdev->dev);
+	if (IS_ERR(ddev))
+		return PTR_ERR(ddev);
 
 	ret = pci_enable_device(pdev);
 	if (ret)
 		goto err_free;
 
-	pci_set_drvdata(pdev, dev);
+	pci_set_drvdata(pdev, ddev);
 
-	ret = drm_dev_register(dev, ent->driver_data);
+	ret = drm_dev_register(ddev, ent->driver_data);
 	if (ret)
 		goto err_agp;
 
-	radeon_fbdev_setup(dev->dev_private);
+	radeon_fbdev_setup(ddev->dev_private);
 
 	return 0;
 
 err_agp:
 	pci_disable_device(pdev);
 err_free:
-	drm_dev_put(dev);
+	drm_dev_put(ddev);
 	return ret;
 }
 
-- 
2.45.2


