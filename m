Return-Path: <linux-kernel+bounces-284602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC22C9502FA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A3F1F21ABA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D9919AD9B;
	Tue, 13 Aug 2024 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIrGndos"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15A519D8BF
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546321; cv=none; b=fqSL8mmp3clKfGGOtx6lxRWndHxqdI0u21KoAvgwTnNvsuUdMw0GGQ6qUYkZaL/70inTMrQEJo314ZA4xsLg+rkRXUiXZXjmop4xv6AKIqvhAWttOTh2EV7xn4ZdPGbqZ6bGLkIrBJWCI4Yv5bW9veoqTN/9xQCm44nYTsitLuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546321; c=relaxed/simple;
	bh=1vPRXFGHzcZ8LTZc6EHWFkg+E/5uzKpBGeHasFIaYhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W39tP4NBWQr674k+83CqSqmH9aCxx7ssX4AipOY8x7YtEZ/erndXbghWEg3v+FMNPoVnMka9kZkG+dAkIqqWJ73gVvunRejIzHXSQwMu2QpRMmlWkm7xAx50k7ZDmfWJyiYtQX1Ga9QG3TFFLaKXoKRWekh3CBb+/DtkUsT68i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIrGndos; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42809d6e719so40948275e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 03:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723546318; x=1724151118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDXFx9oyQqvcOYhB99pL1IoGdV1beOFs/38ZJyCSxSU=;
        b=IIrGndosh1LhzEkr+vdvwi+eodf1ig8Ggej2ko122tMYemFA819gAtPOz7F5XzMYA8
         QWYJOH9nN9KILtT5N8S+tyu3pMcRvVmcfLuz2YOIUsVH+bbZN/0zQqRYfrQ9nO/l+NWq
         LgtVC55/kEVZySKF2eWe3Vr4HafEjuofgmtMkIQserB0YFu8lG2IEso50yGXndpWhPZ4
         cVkBeddttGaiVyaCJGmwYu7ZL13pt04ZpbXFK+ZpU7lVjYh6O/4Ro+oLQb+Ho2j+0lnf
         MRL3Un+Ve/tBciuwmbDxI/Upmebv398P15hzmuITGfM27d2vMjmvMStbsHMaUbSoltCX
         dDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723546318; x=1724151118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDXFx9oyQqvcOYhB99pL1IoGdV1beOFs/38ZJyCSxSU=;
        b=hLnpehqYTuhsf61o8LNQU5nfjCxNNwkTvlbUhYnprH4/ZTgLFeJnn9Sq5e1b3E4/SX
         Ms3DvjKqoICnqFv7uuvWiMKEar+NZ9H63bKO5QwfEk8TCo52sWfVKMA2qOo4bUY6qx+d
         UAtP1vyk3iDRlesXfZ9dXtb9FdbZoyrOE9HNHuOaRYah2RBYUwNbaZdsbL8N6U6S2HeT
         Q1PQ+7M6NBnRW7fjswfUH4MHo/Hra7PQOIp+WUgfWarAqhYOwlaZ8nUtm98owO8I1G+U
         Tuq+R3ba1QmxBLKYk5udQbCI/z5yToYE4vrvg68C6D2WBn63PhjbYtgQSa31P3aJ8q2G
         OrZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGbe/pgm+d4nwGpg5/IYkqT5TDX99KqCwBQzr7D1sWWFpKNn0UHvu64FWqI0CVtZAhl3B3+YeYCF9K2lDDHbHJa83r66jn/f/264sa
X-Gm-Message-State: AOJu0YwlsewPiADLyT4K9mwdWPwuBwTpt5LaeRG5muQ+1pTfZXhSJwMz
	BeHnG1HQKkudKzhs7I5GlSSydxKYLgsHHx5dw4JhcZWrEKox+Heo
X-Google-Smtp-Source: AGHT+IHLXkMedbpCr6hlAG1DdMuIvHHufBsDrmGhHYgCZ8y3pi5ipgfYN1AcQBwWX1VrGZkNd/p4RA==
X-Received: by 2002:a05:600c:450d:b0:428:6f4:57ff with SMTP id 5b1f17b1804b1-429d48952demr21162335e9.35.1723546318022;
        Tue, 13 Aug 2024 03:51:58 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d877e066sm17290785e9.1.2024.08.13.03.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 03:51:57 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: rodrigosiqueiramelo@gmail.com
Cc: melissa.srw@gmail.com,
	mairacanal@riseup.net,
	hamohammed.sa@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	louis.chauvet@bootlin.com,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [RFC PATCH 16/17] drm/vkms: Allow to configure the default device creation
Date: Tue, 13 Aug 2024 12:44:27 +0200
Message-ID: <20240813105134.17439-17-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240813105134.17439-1-jose.exposito89@gmail.com>
References: <20240813105134.17439-1-jose.exposito89@gmail.com>
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
 drivers/gpu/drm/vkms/vkms_drv.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index f524a9550017..248cb7166256 100644
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
 
 static void vkms_release(struct drm_device *dev)
@@ -230,9 +234,11 @@ static int __init vkms_init(void)
 
 	default_config = config;
 
-	ret = vkms_create(config);
-	if (ret)
-		goto err_kfree;
+	if (create_default_dev) {
+		ret = vkms_create(config);
+		if (ret)
+			goto err_kfree;
+	}
 
 	ret = vkms_configfs_register();
 	if (ret)
-- 
2.46.0


