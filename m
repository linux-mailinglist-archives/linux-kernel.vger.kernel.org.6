Return-Path: <linux-kernel+bounces-281354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9928094D5DF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F19DB216E6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B29A1990D7;
	Fri,  9 Aug 2024 17:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nOpwgwZO"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858A618C92D;
	Fri,  9 Aug 2024 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723226118; cv=none; b=POtnH08m795GAaYnyVkgm2cg/hNSiHGZ8TXCx1fgzEmmDLyyI7nFgUFYE56xh74Tu3Yvbdb0g1OlpmuHrlxjxYug+/Gqj67CXCek11p2G7fLKbBHEhn7kT8rtjc+M58bDdNNIv/W4kLheuKfMrFFGMG8GUn1rIWq16fbBqETSrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723226118; c=relaxed/simple;
	bh=6wRzSExmyjQ3/rT9ql2wLPE7pvUtqGJ5gOqrMPlN3MQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uJB2Vof8HIuHgaidIQ4AF4ErBdhJFFzauPU67aHkrMGJeEqLv0GXLxIWP6dn23PyVpixEH2CfaJtkVnh0xRPujlVoy91G3yyZKa52D7q7NnMuvB4FigxUl4JsWD4aYCcq5JfVs8lwGOdURssJpETkcaaYK6Cu+Wf0F6Hy+DFH64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nOpwgwZO; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3D4EDFF804;
	Fri,  9 Aug 2024 17:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723226115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rzFKeSqiY4vFvEcNgDBqwksNHERVh13Inx7aPCMRfMs=;
	b=nOpwgwZOBfbZF4saM6Fyn7MxszjsJwBrdEh2vWKchPW6smU8CdHoNWtYazFH5t0yG1IXlV
	SbRz2CI6VPHw34R41fFsjmhCKb4dV4xd7T3FRcccLau/L7NBUteGhh27elsqugMrftQhGo
	K2tj2W8ViJE2NHSyAT3JFUwqLbj7erP+kqWKB4EkTWVqv85a3LozRy2avjjq8+4maDAWdt
	N7qLBgJbrekcESdSpOcXoxTfz6DVNYvJbc5OhjzO2Aq028N/qMP4xzRiPr1foxhSImWiLx
	EhTi2KN3OPzc/sx1WiWHMWWHfr1pmnY9+pM1JFWgUIIxkMQTcxUr9fp3qX5ATA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 09 Aug 2024 19:54:56 +0200
Subject: [PATCH v10 15/16] drm/vkms: Add how to run the Kunit tests
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-yuv-v10-15-1a7c764166f7@bootlin.com>
References: <20240809-yuv-v10-0-1a7c764166f7@bootlin.com>
In-Reply-To: <20240809-yuv-v10-0-1a7c764166f7@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 rdunlap@infradead.org, arthurgrillo@riseup.net, 
 pekka.paalanen@haloniitty.fi
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1115;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=W1OdILhswR2WQBWaVIRt4ZEe8mhw2+qZswvOt3xLL2w=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmtlfrgouryDlGMA5PNMQMZ5CVsVglsQNyeN7Ch
 iLIwbKPLoqJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZrZX6wAKCRAgrS7GWxAs
 4qr6D/9hYhAga7BQUfHAYLq9lEP04icdlwBDhQ6IIgVuL/p2Q5GYlCjC3T29WsId4GSGuEbvGJ6
 sIBAigaWfh2O2Fr6qDSsyeDgVmjmtUeKbu6IrbYkBkWmangFT3ZWrJEo3hRLXUQ7Zse7LkUa9j2
 uchBXpdOLI+dRNg0S/ce9Br2ZytdX7ZHylIwFp2IdXLwsB9hfmixPUscxKyZd54hpGO/1yWTnBS
 9+MhCh73rEOkRImV+6bfdliCfasL7Z07nFhgct5fuUgId2KZle2B5IHdqiaBXXFjwVZt1z9fUzu
 5p9GAQO4Byp4awwFTtKjnOEyonznK1kzG0/YwGxzcIEAxaLQFyoOuQR018ntHkOc0f0o4W7rE8x
 apM/PKgmfEbMajSqLLmiC9JO/7g8uhtSB4TJPW9jujKfOtLdEEYUaDSRpfMxCsN8RZpJwBk5H/Q
 Q55zyWK4YR9DWBjJXpBNXG9F/3W3Q1TY8VxcpfnLO5xlwgpQ6d4qcumY81pHpiMePf+Z4mj5MYT
 DgAb1KEL7EQPuPbEKJrprfZO2LyX5I3+kVs+ZUr0aQQ1a3zfi9EuWJwD+SnRA1gkGtG36LuDRhf
 F0EZIFYRryNVNXdCvpYA/AT9R0eCZqwfYt5KkKdsA0WySGfwdBG0u4I1S9LiZtgKrMJxlRH6t2k
 1Ngd04MS6xgF2PQ==
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
2.44.2


