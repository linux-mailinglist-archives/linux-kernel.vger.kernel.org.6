Return-Path: <linux-kernel+bounces-272820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4CB946198
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485061F23790
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC306182C3C;
	Fri,  2 Aug 2024 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YFaKCafh"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F143DABF4;
	Fri,  2 Aug 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615030; cv=none; b=YbmRRp+oWUjQUCB1hgj3KBkiYFByO4NWC1axGCjiD2grlTCks6QbeAXFOyPw6001hbeS8D8VZ0mxIOkdBDIDJykoU7y6wpm67oX2Ny4yD3buUpJeZ05yyTEWEz2OkPZ2ltoVtu1oo7yJ5f8CsEpeUMBgzKbrTFDBMqn/lGfHm40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615030; c=relaxed/simple;
	bh=6wRzSExmyjQ3/rT9ql2wLPE7pvUtqGJ5gOqrMPlN3MQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PpsSpn26jllmLgyxHyurIK+8LM5lRZ7w2mT1WbIyeaUa1H338EGYt+tfV32cdMU7G6z9I8mNDDy3lCBWWTik8nWgs37il4SG/QaXuNSGs/SKp2TvxGZH/4AgHaI0HIPY0wxQvoyggx6zsISYzCtvKkyUDVeebR8QHTXR7GzSKm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YFaKCafh; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5533D1C0008;
	Fri,  2 Aug 2024 16:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722615026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rzFKeSqiY4vFvEcNgDBqwksNHERVh13Inx7aPCMRfMs=;
	b=YFaKCafhMjnOPi4FmgpWYudbCqdtE5ffNoykwUfwrovgbxz3fyMnGqN9IpZbYb2rjebljN
	kbXW9z8YoaLyqQIw8Wb+RfCkctf/XYmHZ9nqG29pagKegSSqLnSITB4FQBUBiFxR2iPa4z
	vL+ArOFHmkqkTCHNSoflRX8eh37Bba6t/jCa6eKYqMRU1yIA446+PvSAyKiJaGoCiP8mVE
	5VFB8UAfywWsPbBYlYlpO44QAGYawiWWzrrcHSbZKKE6zNwU8WGdB8zS2oV/Eh2+uiETK3
	U83ZD2VROVtMbyW7ZJ2F0kZXRzyeng8kBvL7PJeyHijiGHPxzNPEtm7zPhtUoA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 02 Aug 2024 18:10:01 +0200
Subject: [PATCH v9 16/17] drm/vkms: Add how to run the Kunit tests
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-yuv-v9-16-08a706669e16@bootlin.com>
References: <20240802-yuv-v9-0-08a706669e16@bootlin.com>
In-Reply-To: <20240802-yuv-v9-0-08a706669e16@bootlin.com>
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
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmrQTbPJ5mhrrigztKjlh5Pq9wYajQfoRaU4Sxi
 1zNZ+iQ07qJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZq0E2wAKCRAgrS7GWxAs
 4p/WEACBX28wFo7zpS8hTfl9u6aThRtHW4UiHtPNBpbRsIEUT9J9sIC60Fz49uIo3DdOnkJczdD
 4k3KuCgIcBF67jJ/BHf5L2pFI0k/wppcX8/o1nKGD+919YVGXxE/tK1b0yjaud+h0HmWPdnrNzL
 oq6c9MZWNZO4+aYZ715FQMygJsQoE0QInKTcktXHay5GLuwvChaYbeDcRxLmqnJcXeRjei0bbt6
 HV8j1xCuurGo7jyFqHy7D3Uqr2mXZ5dMcRGEQLVueO8VRjaT6YijCrwFpKN2Zq5EmnCGKxvox6B
 stBCm9g1QYUPsXAQ99MVcgvRpeRZ3BlzMQHgrN6Rvu8pzvBx4Nmbrxi3LmAgkVrdy3+HFbWKA3O
 ysvMEdYBhxmUGIrqxHicjo3hLLpIZdCEWF00sMJ6HDoLVqA2jQwCQk3329ap+HrqF2mV2Igv35Q
 3wiiFlurPDpuTMnT3lzkEQsVca+69woi0ZKQY4mm3jrM+AEbBcAqq6ztEb2luf2oabD+fktW9Es
 qJfqPVEIGn7dC1OL7aevtxwaR5qTF6pwG/O9714gCIP6ib5qC7ei1Cf+By6FCiagjkQROftuF1b
 i7ubdnnDqveQGeKAskFrOf8SCLpeZ6iug9r3XLRD4PWbaapuMc7zknKTgpYYAhLssKC/PQgCZ3t
 GLb8XGXVAiFayBg==
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


