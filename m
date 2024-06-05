Return-Path: <linux-kernel+bounces-202331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D902F8FCB54
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83F31C21BBB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC661953B7;
	Wed,  5 Jun 2024 11:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="QcTx6qP1"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE3C1953AD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 11:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588245; cv=none; b=IR47cPiKkfhIycrCqjE9r8jJwUpFgyIayKi65r59hxUEOupgkY1Xt68RQNFO3WNied+RnlrAXcuL28aqflLawa3MROwL1Vlc3BcHtheBH7u73NhkCrpnpWOk1vxd3nFOAjS3tud3PcaN5TNBzyOvbpw13N7K9BUGKregaKmd1KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588245; c=relaxed/simple;
	bh=SntghWWYXHpvUMrfmeO17O9aa2fOgBu9KzWTKtKy24s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FQVE69DwM19Y//XB2M/aQJc7FsiaGJ7fo7XOKtdc3jvb5FP8DPp43At8aXITl+C8mjx6yTH6JYkGy8BlvfCKuawhR6CkVCPSEQZG1zCOSso5tceuN+0fINKDra5Pr3frU1RbKdmtGKrAhWOhI5bBlRPW7aPeIDC6B10lHr7A8+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=QcTx6qP1; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a691bbb7031so402590866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 04:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1717588242; x=1718193042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=si8jm3GzWRqXx1IokxC0CnOeeKfkWKdxlqw96jlz8gE=;
        b=QcTx6qP1n4/ppMGehliHrJVBy2bqfvrhK0l+0CKw8gpZUjZ79T6pGYEp7XYKmI3SPZ
         M/Un12dljeP9EJrEp8exDl54B3MlwZ09NDCtqxGxgE+Ka32MruPLSNzlsix+v6kks3kO
         k9HvIZWXiP5b6hFFrEt//Fyub5xTyAQy6ejGM2GfMORracV7TSF7hNDqPApECOylNNXE
         17XsHmynaXDRxyXyW3KR3hm6ex+/tqMw4XXnBbUphx/74WZM2Xi9pky76gBIkKgwR0S3
         vU1N58X0FLoVgXii3yWQAl9xc+sCJo0x8UbPhKauSqWz/20rBwWwtbpM9e3NnraFafMz
         vOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717588242; x=1718193042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=si8jm3GzWRqXx1IokxC0CnOeeKfkWKdxlqw96jlz8gE=;
        b=b5EcywTnB/6aWcu1Dvfwcb53gTIQE+kZYE2ASUKI4Z+YYrmy6j2UXZHC/4dLzq+z1b
         zpgl+G1IOfEUXNF0xyv/A3QYfokoDUEX3jRqG9umPv6C1UHPS5Iu5BfZ7B691bWoZG5+
         /2PBwgDM3+J/g9OhsWdIxFYWja5+xdKVAnwrkZYfB2Ylulx7Nlnf4xWSt/4YlBqLtW9Q
         2O1SWOK6c+64ZMSdURtkg9ZMXdLpKoddC2zeCDOXYQoI0vy29F5qv14Au2hKD7evsedM
         lAJaVsIczWN8nG4+RVwEuN2NErGcSPJgjlcvxW54yO33M0Huno3JqnE0d0RJ0C3GepCS
         R/AA==
X-Forwarded-Encrypted: i=1; AJvYcCVChm9tx4oGVPuwx/FHEH4+svwmMdes4PmCgeXmVdJS9owcl+NSBzFOyXHQzsDz3AceATp94NzoyDjz/GdkH0Mc5F//RKwj0pzkY4gd
X-Gm-Message-State: AOJu0YzEFlTgSbUVyB5baN19Ij0/mv1wBnpXoiGLSGehRip1irCOyN3p
	Ae4QQu/ta//Sw1TcsiZPHC8qi/u2PORYoeTPfw8W6OlWd0oMk1P7Qf8fB1HuRFU=
X-Google-Smtp-Source: AGHT+IF5ti3wzThIx0McGMRIE3AiHKcPjjsf3XWSmVpmGVH/jBbxJzXHej+rEPhsvqWN+HUoB9bqsQ==
X-Received: by 2002:a17:907:770c:b0:a67:7649:3c3c with SMTP id a640c23a62f3a-a69a000e966mr187050066b.56.1717588242051;
        Wed, 05 Jun 2024 04:50:42 -0700 (PDT)
Received: from debian.fritz.box. (aftr-82-135-80-164.dynamic.mnet-online.de. [82.135.80.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68ed879eacsm533329966b.99.2024.06.05.04.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 04:50:41 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] drm/managed: Simplify if condition
Date: Wed,  5 Jun 2024 13:50:01 +0200
Message-Id: <20240605115000.83102-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The if condition !A || A && B can be simplified to !A || B.

Fixes the following Coccinelle/coccicheck warning reported by
excluded_middle.cocci:

	WARNING !A || A && B is equivalent to !A || B

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/gpu/drm/drm_managed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_managed.c b/drivers/gpu/drm/drm_managed.c
index 7646f67bda4e..79ce86a5bd67 100644
--- a/drivers/gpu/drm/drm_managed.c
+++ b/drivers/gpu/drm/drm_managed.c
@@ -197,7 +197,7 @@ void drmm_release_action(struct drm_device *dev,
 	spin_lock_irqsave(&dev->managed.lock, flags);
 	list_for_each_entry_reverse(dr, &dev->managed.resources, node.entry) {
 		if (dr->node.release == action) {
-			if (!data || (data && *(void **)dr->data == data)) {
+			if (!data || *(void **)dr->data == data) {
 				dr_match = dr;
 				del_dr(dev, dr_match);
 				break;
-- 
2.39.2


