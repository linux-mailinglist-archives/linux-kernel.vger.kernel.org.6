Return-Path: <linux-kernel+bounces-235286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A699C91D2F8
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 19:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EBFB281253
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 17:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9448D15688D;
	Sun, 30 Jun 2024 17:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAYm1h6/"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3F115664C
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 17:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719766840; cv=none; b=uHJeQdwU9E3bqffO6NkKdPwZw2Na+9xaG5chSq+KrZCBWfJVpnXWU+blkjjDkeuk50rqOgU2UOAyhsUVFld04+Y3sUwbdcclsN8cm1nCxYdt+fkeruoDvJqX0Z5Dq8DhpvcUoG7mF1tv9nzSZtzuOTtwEp0ytVamLK3xpjA/+Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719766840; c=relaxed/simple;
	bh=QOitObv8cUyLYNALEgmobT3Xc1Io3M5A325QgAWj2Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T74wEcteiDpygUSNlzIfOjGrE3/EEOtVhXOFeSVIFSo8eAsqRBtceT/AAXFn2tD5cciiicblwosGRSGLxKkLynr/IBTtG21/GVa+LaLEbvtSwyjFzL0f/7rziL29wfEuIA8nWag57r4Vmev5xYZ60nVBeFwHD+kvgOc3dnxHhvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAYm1h6/; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-79c05313ec8so116899285a.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 10:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719766838; x=1720371638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+fUm0J60rhD0JfSfR+ec8NGlbRdea8idCqnnknLyK4=;
        b=XAYm1h6/sNhMSRxDPQ6r6j4YenPrnUiHl8bPacN8sgwZURGzrQD4t/ZaCUy1REsz6t
         GAk67Pet0zJAcbeL75XjI++WHCU/am3tZCNWulsoJ2OLFgZ/Hql1Gl8VIfbPoXeUbLym
         +kybzAY9sSQ99wq2NR/gIspTmKHWGRpuvCvnVLl8y5rB2LRI5xLphLQ6uM1uxLtEdlbR
         H1VrqNQwuXPy7VWtK6LYqTCx3In9pQQywiFM6XxpImfi3vtPzohQ8UuSRNqbqXBRDSJm
         wvcjUSmdy1D6P4/08/B+750MmTZoMklgDibkN2VbKL+7L7ItaFEKtEIi2YRJ0CeM44SM
         tGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719766838; x=1720371638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+fUm0J60rhD0JfSfR+ec8NGlbRdea8idCqnnknLyK4=;
        b=EyP/b1K5eUs9W+2BD0szDPYCSJHg7jTHj5clAmq+a6EUb5JQNoQqwAhjctn1ycC5+g
         sis5xSIJLfgGxHaqvmCSOtYgRbYgDsaZuZUxL1HnjkKiIF4yKBJkklESIC0qhq1LO3cA
         vfCVmJJ3WP1pf1zWr3azlDpQjTt0e2zM0Oxh6OCdcjzOB7GelSxQxLlfof0ShlR5E/OH
         ntQa70MyLXPipWJzC5X9MTLZNIkiNO5EUlhViSlWBRjJ5SJOvI6RV0F1/V7iuxYVww/x
         Iv7OBzgJhJSQDkHqeyF4PTxHCh6fAcBUhG/VH/ZUjlc/rPiU7nsYoi0N9a22pPmLfSf2
         yzbw==
X-Forwarded-Encrypted: i=1; AJvYcCW+GL1oDHkqNXLUxDP1VvtMAy09rW6hAsIPSeqh5bfOmBb4TTuxDmgkLfHDTqk/wmtWTHOqEPFMzBKn/5y7HaYLvi5J781CLC42/anq
X-Gm-Message-State: AOJu0YxSCe9EA6qGT9nqyrbiXBMe3Y+x0WiCm4mzK/Q8QkhxS8dJUXQD
	wIHDqecQb7ENgJM48SFH/WGyleP5IsfSKIMF7UQ09/cgioiz2vto
X-Google-Smtp-Source: AGHT+IGTdfbTavrCYOtrr5ya6VIyVg2UfyDv+wbK3tnZFumCzPT8mI4PkDxBQsgVXsZo2s4ZzqGaqg==
X-Received: by 2002:a05:620a:21db:b0:79d:747c:75b6 with SMTP id af79cd13be357-79d7b9f2333mr428624885a.40.1719766838374;
        Sun, 30 Jun 2024 10:00:38 -0700 (PDT)
Received: from localhost.localdomain ([142.198.217.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69295f5esm263431785a.56.2024.06.30.10.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 10:00:38 -0700 (PDT)
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
Subject: [PATCH v3 2/6] drm/radeon: remove load callback from kms_driver
Date: Sun, 30 Jun 2024 12:59:18 -0400
Message-ID: <20240630165949.117634-3-wuhoipok@gmail.com>
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

The ".load" callback in "struct drm_driver" is deprecated. In order to remove
the callback, we have to manually call "radeon_driver_load_kms" instead.

Signed-off-by: Wu Hoi Pok <wuhoipok@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 739bb1da9dcc..88d3de2a79f8 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -310,6 +310,10 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, ddev);
 
+	ret = radeon_driver_load_kms(ddev, flags);
+	if (ret)
+		goto err_agp;
+
 	ret = drm_dev_register(ddev, ent->driver_data);
 	if (ret)
 		goto err_agp;
@@ -569,7 +573,6 @@ static const struct drm_ioctl_desc radeon_ioctls_kms[] = {
 static const struct drm_driver kms_driver = {
 	.driver_features =
 	    DRIVER_GEM | DRIVER_RENDER | DRIVER_MODESET,
-	.load = radeon_driver_load_kms,
 	.open = radeon_driver_open_kms,
 	.postclose = radeon_driver_postclose_kms,
 	.unload = radeon_driver_unload_kms,
-- 
2.45.2


