Return-Path: <linux-kernel+bounces-519936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F968A3A3C2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C895D3B2AFD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E384227FE8F;
	Tue, 18 Feb 2025 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwwWcNAv"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2A327425D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898515; cv=none; b=dtS6FNnwOKIheqWpxFavbKnfSc7ExhevGBw7cxtQZx1Nfix53nzD6cwxFxaFlYHB3UNMrmoLZGmBbhEvshSxhlfZobnScb0KMXAIcget6re+h7/mQJaSllfFBDILWkLHYVcZh2q3nbEcku4dnY+Y9JiAYDchOpSUdIb6A8ovklE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898515; c=relaxed/simple;
	bh=P8kC617s5cPjqzDEF8FzEtB0wmnP5TEWqsfop1ClzFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZGzTu/ReHiy+0zr4hmS2z6xDZGFFNtmzdKMV8WJkq90KEfPo9Wgggq4J1CSKmGvikBEJ38Ms+PpGYr3eoldsElviQvtN/ClLZKP5hv+DskM1X34uiZzWIypHfYL+lZkSFT93bLoq3V9FLp585zssJWYyGuiw/WQOPvrYF8/43aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwwWcNAv; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so38958185e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739898511; x=1740503311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46U11AO6xb80BamoNjm5kPpbkH0qTV1KcPGiHji9h2E=;
        b=dwwWcNAvwJDOtYIe3VHDNEfP/hzIv0+159dlF5gzMra02DiHgv/0AQPCbTqAMYiM32
         2y0IVPcBc/dVRR2HFMoZuVsPUqng0brLJSfpeiUAK+/Y/SVzM5ad2oas+BghBV37mO9p
         HKUXU3rnWgS5+MZRhC01fOhBt+OSIFYq7DBpSSjIiCRRLBExTYjZfBOMf2DL09EHO3qK
         pS4bKqBxaXzVwE9fPRfHnC3cMusruWhBY1WdS1aPuplZeKzAR9wyBUyEkKfLpRCMm84Z
         lvJYkSwiPCJD7UpyMXrE+2UM2yGXORMK7ntvGUcExVe+PL45IE3xPYuuwDT/huM82jy7
         fOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739898511; x=1740503311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46U11AO6xb80BamoNjm5kPpbkH0qTV1KcPGiHji9h2E=;
        b=Mjz9Bn5MrySHzqyYEfPoxBosULgxUJt2+djfEUmpB1nAWsq5xyC0Ajmwxko4EtFHML
         NqVEQpqQGmZTxufuTSLH0H8t7zaa5SVh0eYBI6GUvSqUX04KLzh8b2mAlnnkFGApAAVW
         kQ4P4UpwuVG39/1JSTysod01Af2+kAd8hWfL34gj/u7LfZdGRM03Q4xIt+GoRp3iDCxX
         Q7+xy3pMVTUwweFkxpU0276VmbUBoE6rKxsEmcUkp0cKY+rwjUngtBYA54NBNDoDjc6p
         IKNRIyVxn6j8GlCk9p5oh3kdJMsgbz5L1obtaOo9XGM9oB58/7qOf3qgJGhpki6/c2kp
         TMyw==
X-Forwarded-Encrypted: i=1; AJvYcCWKEOKglY3kMz45tjvpGeHk3jKT9dAMXLfvX9bT5wmvGEMR/IwgGZflz11228LMecdtMgQ7Ecj0M+jUE8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvgf3AmysOdTgCLTaPkmAUlLo7uLsM2fT/99pwTaR8jxln7PjC
	m839rESwemo0dKHikN7CFeGOM0WbX1tyMx8xm0nLtUx6CLHBMqZv
X-Gm-Gg: ASbGncugFGqXDu8FmzqDlmtl347sSOCfl2c2stu/LdawO9lKwKbGz+Ew3oA9JLgHPZr
	2fFzYaMifQA6ot4+BV4Fjpeg+/1ZTsIN6rhcgkLsuG5AmViZBflBMJ8xd7JtooOPS8Vlo2YCk7n
	EgU0QBLpN59VO0kmpfXsHELhnmNSjUfoCdyc2/kIyNfeM5JxbX73zr35WdWIrA8YQOXDwQcrBmN
	sWhVWdJS/LS9rVWGFFvGdHfVai4Q7EM/GY24ZOpJa5NqqXQiYcJcc0Wjzt6YlpfjaTuIuaSbVRp
	plaVnUjdA5J2+D7TgQ==
X-Google-Smtp-Source: AGHT+IFj0qB2qfVbC3n33K9GAWHWIFhdo1khdlRmgJtnZwIcOGa13vHbilTat8DaM/+qL3Ncs9+1aw==
X-Received: by 2002:a05:600c:3107:b0:439:9828:c447 with SMTP id 5b1f17b1804b1-4399828c60emr17222845e9.17.1739898511415;
        Tue, 18 Feb 2025 09:08:31 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439941bd54bsm24680135e9.11.2025.02.18.09.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 09:08:31 -0800 (PST)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: hamohammed.sa@gmail.com,
	simona@ffwll.ch,
	melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 15/16] drm/vkms: Allow to configure the default device creation
Date: Tue, 18 Feb 2025 18:08:07 +0100
Message-ID: <20250218170808.9507-16-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218170808.9507-1-jose.exposito89@gmail.com>
References: <20250218170808.9507-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a new module param to allow to create or not the default VKMS
instance. Useful when combined with configfs to avoid having additional
VKMS instances.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 5bcfbcb6c0c5..b4ed19c97576 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -50,6 +50,10 @@ static bool enable_overlay;
 module_param_named(enable_overlay, enable_overlay, bool, 0444);
 MODULE_PARM_DESC(enable_overlay, "Enable/Disable overlay support");
 
+static bool create_default_dev = true;
+module_param_named(create_default_dev, create_default_dev, bool, 0444);
+MODULE_PARM_DESC(create_default_dev, "Create or not the default VKMS device");
+
 DEFINE_DRM_GEM_FOPS(vkms_driver_fops);
 
 static void vkms_atomic_commit_tail(struct drm_atomic_state *old_state)
@@ -219,6 +223,9 @@ static int __init vkms_init(void)
 	if (ret)
 		return ret;
 
+	if (!create_default_dev)
+		return 0;
+
 	config = vkms_config_default_create(enable_cursor, enable_writeback, enable_overlay);
 	if (IS_ERR(config))
 		return PTR_ERR(config);
-- 
2.48.1


