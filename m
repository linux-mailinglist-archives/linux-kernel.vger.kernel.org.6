Return-Path: <linux-kernel+bounces-181086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD3F8C7741
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BF541C2273A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F1615250C;
	Thu, 16 May 2024 13:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gu97EKuP"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F9A148856
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864747; cv=none; b=WPqdPSqzAqOZhR0mXgl/2axM4JeMdAVhxV9bRlUDoTICM+ltGafllJzqmEzMdaOsqa4D0frw8HcGzj6zj70eQdfZ6UcoLhvUZAwPTJpgZ9cIFiflAHqE6GJT33b45E12GHg8O5w7jF0VaIVP0Yef+fUHgXsNrcKXpFh3Oc8SnCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864747; c=relaxed/simple;
	bh=hm5ATuKM7k5b9USDBiGDlrypUOaR2PsBlAUrZCmPJyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AZHJFljqKceDZYwG9uGFx75GTIe+q4GSTF0MLafEzlmaCF7sFUwNghaVQlUWpwb3CCRe+bNhv4G6sg78I0R/Zxeh5RcSU2nx9W+9G5gTR7GqyRAkkWH6+bIXdAMe5bNTvSTvlESCIHgsQUCHuVgcm3lJfZP3mWW6HBIV40pg0TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gu97EKuP; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 32B3EC000F;
	Thu, 16 May 2024 13:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715864744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4cJjr1rOvBelPGZzHZVBVCtP2dmTpPXKO+w4HPsDO+0=;
	b=gu97EKuPJWBMpU5dY8RaGqA/gulC8FYseQS6vq5Yyj4zRc8VdYWUFKcO2Spze2Fd4GRVSy
	olB6UNf0RtiwI4DSikf3Ko/wGHbfsVtPISmhM80Jaw7HJXRT3XQRRvCrdak+rOzsYtnY1b
	iz34In94gVSuDvj/d1rWV8/28PMcFz1pKt1HFHFmRts4xLw2CuF762+YVRn9hNn7LLf3UQ
	rskVuli+/UsoOiS4aenbzCl3n57sZsIgP7KH8Gd2oTnA8d2O8VD3nAayvixEfpnrYv4Zsi
	vyFkywYvRQr3uATmXa30Z0T9Gt4dhfF9BdH+dXCuhijIUIvDzjJK2gP/SivpeQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 16 May 2024 15:05:01 +0200
Subject: [PATCH v8 16/17] drm/vkms: Add how to run the Kunit tests
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240516-yuv-v8-16-cf8d6f86430e@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1115;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=O8c1f336kiVI3XlL4UTlw6eNE2rwuewoGBkUeNOYiPA=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmRgSC5GoXWRSrnYV9ETBiVDH8Jn5fnArbqKwbL
 dLc8o09IUeJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZkYEggAKCRAgrS7GWxAs
 4uE7D/wPP45RWpxBsLH8jQdqLtt/Vf6KHPDniSNlL5xLVgST6fco3JUUEBOdEXOOnjSKb6/+19a
 fpxu+4HhIesEzlPPN0xoKY9dnVb0ppVqhVJ7gvpKNROSE5hwhtFI+DAawHxyuxVbAV3BLV8hCkt
 yhOOEMSQ3yePbKxaOgDqE7aDL3WJeEO9mT+iKYi8jmHtxgUY00cEdq7BkVk3grUc2I+x3zEewUY
 6T/zBBfYi/8iJk2kNpfiArNOTrIandTmlCJx7BefeOLee7L24sLhdNl20xKQ12VQejQZ9wa1K2H
 z55CXGgkpSiGqMQS6Og04BxiJYwAHhOAimHW+mtk54Evzr47m9iGUrU3LeJCgwCbh90Hi8je/8D
 WPO/G7Uo3TObH1Tam1R78NMFjoNFxMwW4pTLBlj5JlgJXn7eC+kQEGTFPuDE7vOcGYJeZ/mecOz
 bW3ZuUuSGv3wgv9dJr0UafFZIo/W/fH1k/BkLueDlqyqv6LniYThbSlMn5TGUNv76hSWROlOdD9
 r0qB0T0qTfWmDeHLqJ/QE0Hy2vKHmHmFZRo39aDOy/j20sV/4zKjSG85PxZ+mOdcpY8k0DCq/Vu
 zKtNBm2Uz6ucdbZEpIiIqfWMz6g0hBoqIkXfpW5lu4MSo19kAHsCKXnOVJfzeeg2KQqzpdiEihH
 5eaGA/bIW7EyExQ==
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
2.43.2


