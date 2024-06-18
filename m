Return-Path: <linux-kernel+bounces-218573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018EF90C226
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 05:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2496FB221BD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CDF19B3D6;
	Tue, 18 Jun 2024 03:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OmHDp3La"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3693C19B3C3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718679672; cv=none; b=ImImLzgAgMO136ojXfaCvs5vCLEoOa0GPYE+ts9jutkf5Z1RumAZnzwBDYWPt40dOKccVmGXK0WGL8sgQOCVJVUn0hSh1X6SbpA3rhRYxNq4wV0VvtxLq8+6uMXxWzJklF5rzf46s58FLYyJAKiVvryuVf4bha49Og6r55Jpr3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718679672; c=relaxed/simple;
	bh=+qPg+EvTFwBcl83CBLiEMXmzbCXzJn6KtSH/bEamsUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QxdxEWaleVUdQgInPYDuCSG0wtkY+05ySRnS10CklcsKX6CO3JpKrdJVBXGcWOSBmE4FU6DrWSV55HDGP2eTGV0EeKx8X4paBgfk6+hKAR03s8DJphhF4JlEc8Re50DQ4X3US+tUhjk2RpfQmXE6SFCgoqQ6MIX2xlo2qA9npys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OmHDp3La; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BAKaAobYFUntrejEJZZwpK2PmNSiy7/4l9aRDDrVOhI=; b=OmHDp3LamcdpRGs8+ySxWRMw8S
	q6UVzdFtNpJsyhipzdCLBEWq0QFUlB4PJLnuiaIdTudQw9t8KRKsrDH6JYkN9A5dITLKZYG2n7yf0
	l+78t8GkfSVCKp0plYva7sKS8ycD60rnj+gOpu8ePXDddBJAMUu+t+y05AVgphG8Z5bpQyjRjcqxZ
	83yl8+8REglDJLZ53h/BCwYqnec7nY341dVZYbPN2Qba/tXzYjz4Rbf17vb8Sv7HMUw4zDqcr0Tt9
	E7yy4rA0FnQNOyJUqzZmDQVlnmmWqRlDGsbP7DCEQh3ZsY9Cavcc2zExQzqP+yX5xPUDsmh6dixQJ
	qD4UBQfQ==;
Received: from [191.8.29.108] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sJP5n-004YXc-Je; Tue, 18 Jun 2024 05:01:08 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	nouveau@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: kernel-dev@igalia.com,
	Melissa Wen <mwen@igalia.com>,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Simon Ser <contact@emersion.fr>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	daniel@ffwll.ch,
	Daniel Stone <daniel@fooishbar.org>,
	=?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
	Dave Airlie <airlied@gmail.com>,
	ville.syrjala@linux.intel.com,
	Xaver Hugl <xaver.hugl@gmail.com>,
	Joshua Ashton <joshua@froggi.es>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v7 4/9] drm: atmel-hlcdc: Enable async flips on the primary plane
Date: Tue, 18 Jun 2024 00:00:19 -0300
Message-ID: <20240618030024.500532-5-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618030024.500532-1-andrealmeid@igalia.com>
References: <20240618030024.500532-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This driver can perfom async flips on primary planes, so enable it.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index 4a7ba0918eca..22b8a5c888ef 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -1227,6 +1227,9 @@ static int atmel_hlcdc_plane_create(struct drm_device *dev,
 	if (ret)
 		return ret;
 
+	if (type == DRM_PLANE_TYPE_PRIMARY)
+		plane->base.async_flip = true;
+
 	drm_plane_helper_add(&plane->base,
 			     &atmel_hlcdc_layer_plane_helper_funcs);
 
-- 
2.45.2


