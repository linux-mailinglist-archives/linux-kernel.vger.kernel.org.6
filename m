Return-Path: <linux-kernel+bounces-177303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF198C3C9F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65FFB285261
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5540E14C590;
	Mon, 13 May 2024 07:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oZ09u6SH"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21EF1474AD
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586664; cv=none; b=EksiLFZN3GQWTiWouOLRRtD5I2bQOKW6j5xV3OkFyE7iwfr93HH7NJzrdIuji/i3/aMI89KinDs6Lx86mBGC9Y2+NmLaGDZQDi/sAfOOzXpE3TSj+yC97ENYCxnRJPFUcLvHJoAG1RuizSWnRKZTsdXpiTkTv+/how7IQPMP3fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586664; c=relaxed/simple;
	bh=hm5ATuKM7k5b9USDBiGDlrypUOaR2PsBlAUrZCmPJyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qB1UNfza0Lew9iKPGl35+m5Zp55yjDhVDQ6qrr4vHRY8JOCWxb50jey9wWD2tW0LkZ95SF7WCoPShnDOii6ckjRD8InDCgZwYVJft1ip0OTm/hMX7Zu4ER4ERVCOYr5wOA3SuLSPBAu3q0XiNE4kvPGqpy9XDkjACd6iYpLyMgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oZ09u6SH; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C0A2B20013;
	Mon, 13 May 2024 07:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715586661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4cJjr1rOvBelPGZzHZVBVCtP2dmTpPXKO+w4HPsDO+0=;
	b=oZ09u6SHAxKkNeCbzcU74zQtE7AwnglI/p3Rpn8ZqGafrPa+/ZV7r7IiMYHpwXEEdtDOC0
	YVBLfU9/b1nXvjD0sVgevkenX6beT8NJXcZhX5AwyHETTxgnlwmFQUffHvOTD4ZbSsYd/Y
	UqNv9xkN0YnZGEP2ijHkklM4gTce0H7+IyyoSeDHsjWdkpRMSprz5+UZg6zR3BzrZemRdz
	ys05x8Xm7/oW7xrqv7EDYyiOmAHlFSfdJg6VKIc7Pu6pnLfv8V6vRM5XNM20iPnKWSGQEK
	phHNQgK3RoalegaC8RECCRGnXPRa9g+VUkElU1d62sPfC/Av5jLzKv5Dq/s4fQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 13 May 2024 09:50:37 +0200
Subject: [PATCH v7 16/17] drm/vkms: Add how to run the Kunit tests
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240513-yuv-v7-16-380e9ffec502@bootlin.com>
References: <20240513-yuv-v7-0-380e9ffec502@bootlin.com>
In-Reply-To: <20240513-yuv-v7-0-380e9ffec502@bootlin.com>
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
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmQcZFuQJFnph7uViNC8DOiWO4J86q45Oihr/ye
 bhpxcp1uBSJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZkHGRQAKCRAgrS7GWxAs
 4vV0D/sGvCkyayAUW4s6xhCaqMk6yEn6NUsHEQChoGJyWTLjJgnnnr54APCWNsJI/c9O0RPkgmQ
 wWd8SUM+OoqTBDx4htrwZmDPPdGk7gBdIZb4IBbSJ/iyxZ+qJVfcER9sLe+odnJeTEMc8tILq7w
 ZiRPamMhrn1hl8xFV4YTtK6gqUA1lnexkQRAkjqjzeU0yW3BYRFMJS3mx4ss0Q8FGaf4gS3sMCL
 Gf4GUS+0NQED3LKOcb2c+lSyAt4tZ/t2iFqsZgfVbHQlRyowr1oX2uTGQOkETd+Di4NpH89q828
 hVFL/je0Dvg+qe+xvU9yKD5bPMbGNKFfAGxXMIowzKTy89LivZbjFjSbTivLIvizLod310VB+ZR
 ZVt+oGhclDQ7nBZbihha9PkXusT5J9Br5a3KUeN0opTVOvxpKQKI1EebaY9K6lb+AcMyOIjZ2cN
 WGtFsp3K4/5mJPzYakacNPP+JQfUTUarsXn1FQG4Zf62eeCjuaKT+Nau3Gi3fYCUwc2uItuPyAn
 9hOP8zVwhDSyDWj51Or6T4xpMYUhuKXABqbcmV2en093UAd3OCd2hytSpsrwk+05dFTzWDDGaoR
 12JPRtvsyopYrjp6Xts2eBK9FnQLrbecZ2ks62ISij+XlaEir4lSB4xCgM4SIEKECgbKZCyx9oP
 3a2PayanFBpTprA==
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


