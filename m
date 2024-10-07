Return-Path: <linux-kernel+bounces-353800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEC69932D8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E2991F23FAE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF771DCB39;
	Mon,  7 Oct 2024 16:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aShXEHrO"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BF61DC756;
	Mon,  7 Oct 2024 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728317466; cv=none; b=DRoWxfOQgkcqBvBinG9aDkGv1AAOG0tvmWRhyR/tNXNmz+wejkPwB7GbwUf6SSffmez2sOpf6xFid6j0Y8J2HnR5Zu9BXCgZAYqTbasIU+apyu8xeCzrAOUTG+lnidzD2pitvDXy3NIOudWwusxsLravMkZxnXjMs2hcevsQYNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728317466; c=relaxed/simple;
	bh=L2eAww3XB8bl9Sxnoiq/z6nn2Apw5rKlRY7sfjjDvWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BEDiEh9e/xz1Iuj8PqPk1Hgl+6Dtwa0jjj9bEZA5PbCQtKdGjcyTwUR4kd54pOfv45eIUi3mwxJC1OecnrelNRPdMcaGyCZxJSSHUmniOsSkw2QaXs2BsUtqAmv3ztuZZWhbNBymlDcM66lKO/H3r1DAJlzCfVzNuEMSpVwmQTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aShXEHrO; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CDAB940012;
	Mon,  7 Oct 2024 16:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728317462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4dr23WBAY8ZlBbMVkhnAU+t1UPEWAWhnUCz8S7CEndk=;
	b=aShXEHrONs/7rS4bqP9H684U7ISlZA2wLtsV0tzsWbwENgVR2HGJdl7BHewxUA6Sl+TQZm
	1qBPXcSSFDzAalMekNCP/ZCj0axn8AxzMPnvDWwtIm+D2P7EEMZVwxf5X5BQcin6kPzmL3
	W1y1/PF+RFIz4WiU6NvmJ0rU0b9ujKOv0soqJyomiEs59vX4mB3HTksaXhEbHX0lyta332
	3xmnULcQAMfDLAOPIzJsP9FtibIwdL3Aw6TNEwLeQnfv88vamiwU+K1Pp6KyQ/ZKpfBob/
	Do2TwKUDRqQb7y/QEoXJzDFZz93iS7ANpKrlsnkBf3N+hAt6kq2FwK/n3/uepA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 07 Oct 2024 18:10:48 +0200
Subject: [PATCH v12 14/15] drm/vkms: Add how to run the Kunit tests
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-yuv-v12-14-01c1ada6fec8@bootlin.com>
References: <20241007-yuv-v12-0-01c1ada6fec8@bootlin.com>
In-Reply-To: <20241007-yuv-v12-0-01c1ada6fec8@bootlin.com>
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
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnBAgE40zHTxiatMRHM9aZFY+JrnSZSSetvhWQg
 MAa321tyr6JAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZwQIBAAKCRAgrS7GWxAs
 4jOVD/4lmEATNrmbsR/mLiCxSC1E4SFS9kMxbODvJTE+a4khMPPeGL+GDgYGr+SbxdPqM37ZfTv
 Na8K8IoMXgw371than9uD32L9pq59/m1NiYOtd4ZU+JYQ13LqxVZFgHqzEp+mI4JxBv/eTMm+wM
 zsaeOBBCEPVw0+lNFi6MQu3RvDjQe7OQk/1FAB6SHhh7hoyRE/CD78rMSnVXydsZP2mm0fNY2VR
 1Y1qJ4I/Odkv+WegWzIAb2IqsDSVyi7eswlByNpQi0hTm6j5pdgus9r0rsaKRY47c0mUJpWOQwI
 afsX99NIaT4svvxUJfn/E96K79kVD1wWLB9oHslWj1qAVY4qcoWdzNSvkxYoJ6hMxey6g87H8hU
 tGZsmta1tEgdml5kDt2+FzMlAcgn/YmYRKfBSw7k/KVp330kKPSqf5o7pfix6s633fqTMHbxmv+
 KtESD9j26sBdf1869xmTaoJ98k1Dzpxm7GjEjW1Nf3RUspbmHfmjs76ewxUupPlLcDd3luS72lq
 mFigUmd0DitbXR2hF7oBjgAlZAVc2DkevX1UZEt7GBDH/f5r/2nxfAuqW8xE0Qwu/7hcV2qNz1n
 v86hiQNjFoU/gA8vicnjuyzl+Nj8kt8bXG360Jv/fUvlAHNDZ+v0pPMNPlziTG9bp9WbAbZ5erR
 /y9N3qU2cBH8RgA==
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


