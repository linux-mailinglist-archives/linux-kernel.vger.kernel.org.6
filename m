Return-Path: <linux-kernel+bounces-418452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0142E9D61CF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75059B23C8A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41471148FF3;
	Fri, 22 Nov 2024 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SkVNJBJX"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253F71DED76
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292117; cv=none; b=qB+eSmh0vw/koFTTTJ9HrGVGcBYyDqGmOCwcZrZyjphtZM8oiJtsKtWcZlqON7DcnsiyzrQS7hVqHo03XhqkqjfE0s1kSXgtwmSf9V/tFMIk3+25xdIodcOZdokBapfwSHX3BPPUwf2tKk0RwzOxbLq5fSxPgcr2HjMl/UXdp+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292117; c=relaxed/simple;
	bh=UVavjxKhGJ9/Mx+njM6iq8QUM0yoeq/APHA6FGXHkJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gU3/7yoUSrqZJU33fFPYwi69pGoSbcH9tYnPPyoUEtjVXpxA511lIJLB3Wh2nbCID/AwY1Ijl8jfO15wbNlfg40ycrlG5ETJNAmIHPDzjZZwPTmZuzC7O2TkFJP+MzTcLakwsYxR1JTAPQHxZYuZVcHsqxBEtC9ziFqND8l2pZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SkVNJBJX; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8DF0A1C000F;
	Fri, 22 Nov 2024 16:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732292113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfHoqEBmoVIVQo1Iw5eRxgKBa4FOCahU3iIkG6Ku/Eo=;
	b=SkVNJBJXxKYgIOc9BwWh6Xjl5oit/A94GpPF5zdXIWsEki+OwfLHPwusXqk8qG+DwpU87T
	FddI6Q1AHwd908TX9Gd5tj+koHeILJmxB9e0RpfjPpCqGLylIRIIx6sIRQn4iV6KDsDNH0
	nEQ8WbbCO/twKPJylTkoY0z0XXx1Eqi4BOBX825TVI+2gFZpbW24ZMlEQOUGow/2c3+y4w
	B41Rg24Il3D3TNJAV69g8CjcevwIUejpAY2tUk+NBfJ2KaaxWaogaCxDi6z2UcqW7mdMFK
	aj8zepM8h+IQj20ci3ljWEMa4eN5sSiuvg8aUD/Frb1KfxYijenwbPTBqLMJkA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 22 Nov 2024 17:15:06 +0100
Subject: [PATCH v14 6/7] drm/vkms: Add how to run the Kunit tests
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-yuv-v14-6-e66d83d28d0c@bootlin.com>
References: <20241122-yuv-v14-0-e66d83d28d0c@bootlin.com>
In-Reply-To: <20241122-yuv-v14-0-e66d83d28d0c@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, rdunlap@infradead.org, 
 arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>, 
 pekka.paalanen@haloniitty.fi, Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com, 
 nicolejadeyee@google.com, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1171;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=KcZXKbnDJcUNaO/ryK3mrQAB5uKi2etnbYIX4nCF2Hk=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQK4Iv/OP2lDMDsNSQsMOUoHjXv/gzq0HVDkz9
 TiaJefBG7OJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0CuCAAKCRAgrS7GWxAs
 4pcPD/9zvbPt0PRgMxyU9gNTqj23mnbl5cQ+bwA6Ejill6Iqk2wBN3m0OCvwQ0vshvxvKX20LsT
 pY8oklqWMkaod2/KxEUD6Ht1AFQRxoQQ2Y33PmcsYXIkHOkadPAj7RtsL7wL8a2CZUD1qcnzvpC
 myFdbjesALlgpJkFUAzO2CUGGgDP1eCDhvEgUDCRUZ8Um3mpP+iSxOF25DTo3p6+IsUrWpholnj
 Sa6GLFyHcil7dry1XtWUiU4i6pe6S5jT3g/jsyoxg80iZctsVf5DvxFLN50KkbJjGgzj8PJICNo
 O7wKiEQiOWDscDxMTk63SBA/cs1f6Wrbnyd9wXz69GBtuvmTvKAXwSFTwP0oytbPxjtTPWBgn4P
 j/+gBC/eJmBKhEGwH4dn3q1PpVgNDEqkNZsZUutudUC0sU2NdFNqKJAlu/+imO2kbZsUfZqxHMK
 rMk6csPY0Dn4jPwBZ2vvgVS/6vdJFkZoqItXz97XhxewIOoaeZOzLRdsoZ9VCeLbEA2BEKAhx8Q
 MQ88qaX6S7FLaF1wggFokgKEoyxHwHRJI3bYekIXVrYGSL1nX0C99ByC6cHuoi0RT245iWzsAMT
 8JxihdFKVraz5YvJmSqS9kIA8rePbAa5YN09BlzATchfRXYjK2HOTcAgaWxw14zIzCK7cQAKY8P
 nuo+ZyDkzw15QLA==
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
index 13b866c3617cd44043406252d3caa912c931772f..5ef5ef2e6a210382a070eaf3552bbce75b04ff0c 100644
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
2.47.0


