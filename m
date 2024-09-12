Return-Path: <linux-kernel+bounces-326855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14245976DBB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82742B23792
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25FC1BC079;
	Thu, 12 Sep 2024 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UPURCvKu"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C781BC074
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726154793; cv=none; b=H1bg5g+L1bk+q19ZJx2ycENT3Jl0vgssh0daTLTT5+AusKgtC+7HC2QtKJymqm9sqDzvgAVXF4mBIPLY5IA2+1XFVSOwzv8U24jD+t7iuCxseOTrxDUYiLkDvLQFfdq/T9DdE7qCMs5TqNIuxv+L6wzZ60+dkfvkK9RH1BWiRLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726154793; c=relaxed/simple;
	bh=/qs6pBE+6TXI6raTey9HQj8iXVGyKi538F1VSOwPpiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UlfNra8s52QDkK7gSnVHtxRRorsVIGzCnWUjoWaxtL3gokPNic+cB2o127XNoG6ieXhuHwVtwNJG9Q3xJ8vaDxZruY2jjFW/McuxTxAflwm1gYtNTQZkBFB0RRv9Rzl5jPaI3wq4bG/TWDa5fSbW1z/cooXGcFadqxlE66jnoEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UPURCvKu; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7BAB940002;
	Thu, 12 Sep 2024 15:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726154788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1N6F3NgoFy3d7URwWvnHA4RSAADZLw/Lv40JW9LXebE=;
	b=UPURCvKu35+P1Q8LdtRdWy7EZSXK74XR92SWyKBwNilWaA0zfEq5O6cbqF2ZH/8RoKD9sV
	iRrrwREOW38UPTen3l/TV9Ds24vlyejs4d/UTEMH6OU/bxH4cY+wHf8iHibc0QWjaDshRn
	WWUImmJ/b82yiUt6EWzkvDwPkE6wjJBUt99vtRBPmCHXZps1WPjC3v9EoIpPxpxI816Jxo
	3kLbpGGqtxcHyfw73/sSlm/gtR3B6qB8xtTRbiIfQgVcY7uthhfHCMbFdmzQCW+lZKQjZS
	vjhrJYEBZ/8lGVFKwMKa8Y6x/I2lpcZCIZjXhI8xztk2XCHxx2MsPTiT3xSEZQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 12 Sep 2024 17:25:33 +0200
Subject: [PATCH] drm/vkms: Suppress context imbalance sparse warning
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240912-vkms-warnings-v1-1-59f3e13ea8e5@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAOwH42YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS0Mj3bLs3GLd8sSivMy89GLdVINUY2PDpGTTVLMUJaCegqLUtMwKsHn
 RsbW1AJyIn4RfAAAA
X-Change-ID: 20240912-vkms-warnings-e0e331bc5e6d
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>
Cc: thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1435;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=/qs6pBE+6TXI6raTey9HQj8iXVGyKi538F1VSOwPpiA=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBm4wgj0iAgp/MqkajSlDB6sB9SLJZEDklvx0dLN
 V8oHHDpCpWJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZuMIIwAKCRAgrS7GWxAs
 4lX1D/0T5LCCTxAr3zJUW8h+hK6OuEwnsQqzPdoSs7c9PrIzFs/uQvdT8pvO+rgHTZIo/3z36FX
 aANh/DAGCzFyhwlXRH84O8uSK0NkGdT4tgKUwr8PBiZnACywiTzczyzCI28HBG3GLW+8k6Rrf/o
 zv3JpzgV/l1DpYJuN6ChAIgzyiS/WDI+K3BaktVqwMylUaCWrfqGrLjIuNQl7zxb7WIY2mksYGM
 7bqWv6OEnqp4QumLaksxuR9kULOK8Grq7pKZqdxBU8nRMxgHcpAYVIFYcT3Za4BOEWQQ+eixN/+
 Lde25x5Kw8bpJfBNJCz2zj5BHcMlE0jtRYE2cxs3aH6XFGhgdDMZVvmUM/v98t3o+my3E9XmDlb
 7H3QqOKdlQBTnHUrbOg3NvOkQ151z6sB37CaojFaobgQ9efprle/EKrsuToLJV2bMdYagvOBN2F
 VDJTbwJ6a3JXpGn/0nhmbSFw7E7/No7L70pUjYpsNS8fLNV1+3E6eDtMQxrYfkg4/xdBnXBKB/P
 xzIgK5X/ZALiwOUyX2VzvSSju3adc2enfla755yTULv+ZyuawTta2bAgfbLHz2vkXI1K4XLxF0D
 earPOdf0sgRYRMDqZKpIMRJm3dyhxXp+InX7Pgo5wuvpral9+eZq17eCd02NUArQWFmgZv++PFN
 sl7cMo+RPzutfGA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The functions `vkms_crtc_atomic_begin` and `vkms_crtc_atomic_flush` are
responsible for locking and unlocking a mutex, respectively. Add the
`__acquires` and `__releases` annotations to these functions to prevent
the associated sparse warning about context imbalance.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 40b4d084e3ceef9e1e24b7338efdd9253afee8d6..2ad164b518fb93f5b6b86948116ff7ed97770b60 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -232,6 +232,7 @@ static void vkms_crtc_atomic_disable(struct drm_crtc *crtc,
 
 static void vkms_crtc_atomic_begin(struct drm_crtc *crtc,
 				   struct drm_atomic_state *state)
+	__acquires(&vkms_output->lock)
 {
 	struct vkms_output *vkms_output = drm_crtc_to_vkms_output(crtc);
 
@@ -243,6 +244,7 @@ static void vkms_crtc_atomic_begin(struct drm_crtc *crtc,
 
 static void vkms_crtc_atomic_flush(struct drm_crtc *crtc,
 				   struct drm_atomic_state *state)
+	__releases(&vkms_output->lock)
 {
 	struct vkms_output *vkms_output = drm_crtc_to_vkms_output(crtc);
 

---
base-commit: d2194256049910d286cd6c308c2689df521d8842
change-id: 20240912-vkms-warnings-e0e331bc5e6d

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


