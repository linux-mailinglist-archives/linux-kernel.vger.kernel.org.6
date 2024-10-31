Return-Path: <linux-kernel+bounces-391064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DE79B8237
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C9DB28377C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E9A1C9EAA;
	Thu, 31 Oct 2024 18:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="faiK9yf7"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C6A1BC097;
	Thu, 31 Oct 2024 18:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730397982; cv=none; b=VRIsnsC2TZj8qV/FQw8Fnll+4GD9LZ3ClGMryMc+hIwwlpqV0/YZSLGOXFiNv0+LBTxXIpRoPc2qS+QARSwQnbMA5MxlwgsO2RprIhIJItgEvgcW4I0kVlI/c19x8i6+GWwnrDpI1GaqcsMH8P1LZta6PY4CTrFOlMUK/Nwp5zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730397982; c=relaxed/simple;
	bh=L2eAww3XB8bl9Sxnoiq/z6nn2Apw5rKlRY7sfjjDvWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AMRR4R8KPHx0wxrC+fbK32TNoarSvDuY20b/vBMUCUYLTInA2u3ViJigBY/Yn9fQPARK6akGTmUB8DwRxowE2Lf4dcp/Q5XqOhuWqg03RxQ+JvbsMToy2FBlUV39DQJg5oc+OMHk6Hy/ViDru6hF43VkxwYGU0Ky3f4tRSoPhHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=faiK9yf7; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E7182000F;
	Thu, 31 Oct 2024 18:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730397977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4dr23WBAY8ZlBbMVkhnAU+t1UPEWAWhnUCz8S7CEndk=;
	b=faiK9yf7SG5VWhqxjI7OQYfTJCjTC/kXWbTKyR85Z9wRBPDHGFGatRmW1p6pfD+NpH7hQH
	qJvECZm+zTdJO9j/OOUZcJpz7G+PQBY/sZMgjxCvkGjwEZuYAJop9bHoxPyoiUAhSJpMSj
	PpDBAYJDLBJkmUtifD5ofUVk46CCHy38rS71lVKGD53E4lgr4jskE2tfVA7440m9tEHWrS
	91itqMj3gHjpazHbvibxm21eqdoKWcpHRnXZ33nlTvOVEYGuYVjH+NTMrIDRwtrkYHu2ME
	c2zV+Uy/80wekas0CgOlMs9+dc0PjEEcA2aO9hM2j2OS9r8AZhevuOSEUANsLg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 31 Oct 2024 19:06:06 +0100
Subject: [PATCH v13 6/7] drm/vkms: Add how to run the Kunit tests
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-yuv-v13-6-c67a337301ae@bootlin.com>
References: <20241031-yuv-v13-0-c67a337301ae@bootlin.com>
In-Reply-To: <20241031-yuv-v13-0-c67a337301ae@bootlin.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, rdunlap@infradead.org, 
 arthurgrillo@riseup.net, pekka.paalanen@haloniitty.fi, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com, 
 20241031-yuv-v13-0-bd5463126faa@bootlin.com
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1115;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=cnp5oJy7nuzGGG9ERF9CFtbtr9GkJcMMWvS4L3S4Vps=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnI8cOFnJu/bZQoRm8WNJWKPZ7P7plt4DDDTlM8
 j66b+RPbOGJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZyPHDgAKCRAgrS7GWxAs
 4rjhD/9wfcZde53S6DmfNyReBfKsHbeMUDS8S1lrLiocRSH5sVv+v55ZHLE0Mc2saY8LYQtJQ96
 TPk2LlZMpuIoCVz5W58wUrRK4zvK8RmY/vC7I+OKGrsl4lN18ytbHTojjtWlBW0Rf0Kvn2GMIpV
 xNBbC89FUpabOywT40Nr91bjdk23FFkmacwBYNAjnOnFHaubB8ldtNx0uYU2BFDWactuxc08qso
 O6PMGQiNUA7dnPYFyA1HsD9PnR39jQ0itseWGpOZ5q6dZfyksL3N16/+dJGer3jloVy1tXD1ikr
 m9cOAb37TsDRXl51RJBVHuMRwi7h8VJgT9t/ERi0w+l+KeGxXVJV4xuRBUAfMi6zbwOwXajxFIE
 QJ5qX38IZWM7Obfgod0IZ/7w1Z7hJifCy9iNb+FOSpTLGThKLWKbTQtPBlvW5V4Eyjh6I7YzGhr
 YwuByOtPMIjdk6GbbyYl1WqodB2bU+2bskr1FHHCOjMqhg48JA0IOJKTxXlnq+HOcC6lMPOwK9v
 q3c+B0irndOdxOwF3b6hv4L3Je9H0lwqir09GGEE2yRYAp99L0gjyQkC6eJg9Snlwl/WObxl8FA
 2oNFXOZ4PyeC4imMKun6PhwgcVLwhX7QAoY9nz83YPlmUp4fdoyUMWlVtlStQu0ZB/nacUPhKOB
 gG1dkbcug/N/GkQ==
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


