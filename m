Return-Path: <linux-kernel+bounces-344366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E0898A8BE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0AABB28503
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A92119D094;
	Mon, 30 Sep 2024 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hhs871b6"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3189219CD17;
	Mon, 30 Sep 2024 15:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710404; cv=none; b=boUGu3b4og3rUZr6zey3Jj4er9CVNjFXBRgvZyNZ6L9ZVME2YQcA90FUfbgfqoCDdPglb75dEdGeUJ4k8AsRk0PjQ3oji4ZXUbJJp38gkVv33v1MdFi+9XyKUt3kefLfoiNDNgVvvzurtUFO5igB02BDOCjS5yFbgQtqwrIdDso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710404; c=relaxed/simple;
	bh=L2eAww3XB8bl9Sxnoiq/z6nn2Apw5rKlRY7sfjjDvWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bhx3OuvvaOqKNP/JJ2t7It2ftA1Gun6Ju7twnvDlsysb9Bjd4TRlRAFHonfArjxYMOv2NTW2363LrEFXcItIo/IJhaApk1KfQf4np89qzIWuW7L6NMKI4TnP7tuFGC6rGr5hGmpqZvSG5Pe8oWzCKafUJVZCDGpL65VH/GM7d8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hhs871b6; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E92A340004;
	Mon, 30 Sep 2024 15:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727710400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4dr23WBAY8ZlBbMVkhnAU+t1UPEWAWhnUCz8S7CEndk=;
	b=hhs871b6yomt3aiEOQLzbAETgn3FPHlVA+c+wddMHiE+PICwyWkbL9cn8G9eC9d1oTpvU2
	FnHOVhDUJW8yIRbjDQu1SR/QcLLnJ8DQr+sE6MOvedMOBV9B2B695uM16AesCqARR5E28H
	+wlDEzWi4jByXxZ48jFYERgGCmaqeEdOYb8uNpcP4W0hK9RHkZ0uikDJemky8n8qUjeWpo
	l7XORrkM/LoDPdSXdpSkxVxtdiW5Z5cFj77mI6Qb3qpkHQd2WfBkZuGf9GuOZG0G1oGfdT
	YkvyTl3xF/CDwD3RvIRFJ9k3ZOH8NxTalFubongesTVM3S2sQTltzBRkbmtc1w==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 30 Sep 2024 17:31:54 +0200
Subject: [PATCH v11 14/15] drm/vkms: Add how to run the Kunit tests
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-yuv-v11-14-4b1a26bcfc96@bootlin.com>
References: <20240930-yuv-v11-0-4b1a26bcfc96@bootlin.com>
In-Reply-To: <20240930-yuv-v11-0-4b1a26bcfc96@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, Simona Vetter <simona@ffwll.ch>, 
 rdunlap@infradead.org, arthurgrillo@riseup.net, 
 pekka.paalanen@haloniitty.fi, Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, thomas.petazzoni@bootlin.com, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1115;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=cnp5oJy7nuzGGG9ERF9CFtbtr9GkJcMMWvS4L3S4Vps=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBm+sRxxPH8PrtvYnvsiETBjlH2karQ9lUU50ydp
 BI9qSNHKoWJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZvrEcQAKCRAgrS7GWxAs
 4kPIEACLPurbVFYWDcJD0z0ykYTymbh7Qp+oh/k/+1nKtC9zb//wF9oKwkJvktl1LD34crsEq0T
 RWeKdWGwwS5BuYVwW6SRYNLElT9NRZQJf9Uc/p0DZ+/M1tL3bGveEFSF5mLYiKpw1WeKa4E37Bj
 ve5ZRlAAJ5s7/r02vUnzaP0lpifngW5ujXJb6b5rSKTXV+eSJ0AWyOfzV47eVCWzHush9Ici8k1
 HLQ+gHL1S4r3lCDJnVhnL1SIxmvNqOlDCU2+fR2s6QzXTZKZUkjj5SCgDgVQnRBU9cAFfKkel7M
 wg0gmOIFANGCoWaoMGfWLhZrrnTDuorfAODPSVHcTQMuJn5ov1MaKv03y97qVHuf1fnxxGL4jpR
 2u6PHvpMbwATAJbJnTmwUwHvW6Xxykhozgh6uCTAbUHSSz0HXH59SQh68fbKGPz0eJhAZNVLfgK
 oujTlEt3QYV+MlElfnGxDZKsY8uDzOP/RwoKHfUR+b1wDX7bfz7KSr2kGMOpktrwa3B5kqzYLqD
 izZyQ7gRFKHVYBTFu34L+OcpgsqT44vSYDnwMeUuzaW9TQzK6MgiVKp0VumxmtyF2daDPz+X9sC
 TmzNmrIPoX3bxuW2HG1vboBcE0P/u+jnGQj4trqWZRSYcMfvv8cRQA0ul4jZCfi3RPLE6Eyi3Pm
 gUoYGrAoXjX5oIg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

From: Arthur Grillo <arthurgrillo@riseup.net>

Now that we have KUnit tests, add instructions on how to run them.

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/gpu/vkms.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 13b866c3617c..5ef5ef2e6a21 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -89,6 +89,17 @@ You can also run subtests if you do not want to run the entire test::
   sudo ./build/tests/kms_flip --run-subtest basic-plain-flip --device "sys:/sys/devices/platform/vkms"
   sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./build/tests/kms_flip --run-subtest basic-plain-flip
 
+Testing With KUnit
+==================
+
+KUnit (Kernel unit testing framework) provides a common framework for unit tests
+within the Linux kernel.
+More information in ../dev-tools/kunit/index.rst .
+
+To run the VKMS KUnit tests::
+
+  tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/vkms/tests
+
 TODO
 ====
 

-- 
2.46.2


