Return-Path: <linux-kernel+bounces-181080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F468C7737
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2535A1F2281E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3328E14EC5D;
	Thu, 16 May 2024 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZPUfDCSz"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C218514EC48
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864736; cv=none; b=HHiQr3n2b31NTxDMYs5H/usSSCA4Hh6xhPEUt1dH4ETic1xeUJL3/Sjbf2ZuYUvQgg8h9cdynQa9eBrvikM4qX2BYiDpZENFIRDUQ1QOJ0SJMsjj6MAqsqQ2/NNXomio2Y7y96IXmGPie1SmWXjjgfJInG4y8v/MKYOqvOfbPII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864736; c=relaxed/simple;
	bh=wUSBUJCSOtsms0zYAayKwF/xjzoMjd+l5I3zX1xUo2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZTzqxECpfy2L/oLtEvnwCsv5aHB/IASYbIYN5RP8N97Qk0VQjzfcjPFvOjH8I4LA0VF/qEqDQnbWK/qY7vREHp0Q0JPVWq+UlkVnK+k/qZTX+QtfaXW3elA3EeI5c3ZbxytdSVHuM9wq1kIPqjLbcbfwrG2lV3aWNZWaqEe1QWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZPUfDCSz; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E4F8DC000F;
	Thu, 16 May 2024 13:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715864733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z6QJBejRB4UIVVBulKVlIb1TBeEN2xAQAhfhefcDJuU=;
	b=ZPUfDCSzUmdvudMPBI5mQrOuAwHCq0i5vGLol7N52HWx5rMztbcYKDnRNtE999CNfQYgna
	DpPFqDSgiX2vU4DsZRAbo8PwlcesRK2YTb6lOxINEYACShU9RRkw5fdmfIMv36W0xGkWLP
	N7WLvosullokUOra6cZLoSi3W21yXKUbW7uoa1Nc02Foup/gVP252NQ2BPoCXDWwyLZQWB
	kLpPzjp0ru7wiKMNY0PNfQX7URVAQ//niHsm63cbXdxhyVdpozxG2V9XqyNs1vPlE/hDyp
	nrEI1i2xsOVUP6g7bP4ToJaIDxxUZlNvw4MYwZDXzBJnsgQu6HTIMMwFBoICiA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 16 May 2024 15:04:56 +0200
Subject: [PATCH v8 11/17] drm/vkms: Remove useless drm_rotation_simplify
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240516-yuv-v8-11-cf8d6f86430e@bootlin.com>
References: <20240516-yuv-v8-0-cf8d6f86430e@bootlin.com>
In-Reply-To: <20240516-yuv-v8-0-cf8d6f86430e@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, rdunlap@infradead.org, 
 arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>, 
 pekka.paalanen@haloniitty.fi
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com, 
 nicolejadeyee@google.com, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1084;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=wUSBUJCSOtsms0zYAayKwF/xjzoMjd+l5I3zX1xUo2g=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmRgSBiBGyta/MMbXW3n2+DHd4wXy82MUpSHV9a
 ysggLOH/PWJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZkYEgQAKCRAgrS7GWxAs
 4jUFEADGPgEqbP8d0e8CRt6yxRXHbaOcl7pc35L0x06T3DiJUAleBXLj1XEdF9hcHWzKUKipkW7
 qEIFWiixb+Lq/SAkP2aWSDhqjqmebNxu7ufhUh/IJbkTXpgg9N0knFk83n/AKYzrLYdURWK9efL
 3XuLMp4z4scoXr9aZ3R4G9gEPZ/ijn6wAd9zA5N7brmxDsJOPB7juGBYxEZKbk5RNDdIyIK2Ftp
 VLgZjgp1bZrzOjOUD/DQ9Lga+Nw0oi/yut0hVTbzegQiQxcUAGBUhD9XjuIAFelncjqWIn7dtsl
 j2FCmpgNm4nSkflb1wopaBT3VCMs9CUoEnr7689RvtwdAyQ/eJUNYqRPqTAc/+MqbREzgFPLpbh
 YONZbTrbcokx/4J+4K7wh9LKQyXTPzA8OHQT1k2l02yK4fnNSWiO9mLp4LK7mhI1Tl6lfmmoTYz
 VOWJAn8r690ziW8yCh+fwFdsCGtj3xqlL/far4UXlrHo20qzlso/y6C1cFaUFUAJBX6AWTpFcnT
 oMcpf63dfkPmxq8Ldsa4FxK07XJGU+p7khWy2zxRRekeQEAOTn2vsx/HxPoqT2atMPLnYgxdPl6
 Cyob91mfLRYyHFCSSsqKVMDZHaR1QrLsVUoHW9Bqf+zyd2HvST3wBzOf+wN2Ws+1OSa2BeDHTJw
 pAQRxuM/Ogqc+YA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

As all the rotation are now supported by VKMS, this simplification does
not make sense anymore, so remove it.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_plane.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 8875bed76410..5a028ee96c91 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -115,12 +115,7 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
 	frame_info->fb = fb;
 	memcpy(&frame_info->map, &shadow_plane_state->data, sizeof(frame_info->map));
 	drm_framebuffer_get(frame_info->fb);
-	frame_info->rotation = drm_rotation_simplify(new_state->rotation, DRM_MODE_ROTATE_0 |
-									  DRM_MODE_ROTATE_90 |
-									  DRM_MODE_ROTATE_270 |
-									  DRM_MODE_REFLECT_X |
-									  DRM_MODE_REFLECT_Y);
-
+	frame_info->rotation = new_state->rotation;
 
 	vkms_plane_state->pixel_read_line = get_pixel_read_line_function(fmt);
 }

-- 
2.43.2


