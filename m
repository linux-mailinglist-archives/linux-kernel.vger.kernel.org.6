Return-Path: <linux-kernel+bounces-418491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C77C39D6236
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7166F160FB3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A8F1D9598;
	Fri, 22 Nov 2024 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IKw830vz"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3586A009
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292714; cv=none; b=K1LqOZFBfD9+r2ODjr2GoLq4SgOAY4zuFYyswSVR3gavT04CvMSyW4oedo3XJ6URNLge0Ylgkg3Re42/7reaahJa/MQeXYIObm0Oqou0VcdAr3tqhB6mZN/X22o8nFCcaBF4F7m1AsXkk/+xuC3xts+YIBRsSPqJjdBabnD2T5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292714; c=relaxed/simple;
	bh=eaNKgDeGpchtLQ/lC1Y53hva6pEAQrbyqvD3im/Sq5o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=alCL99wXh4teJxET21+br/N5dx/WjVCZclgPQ9r6s/NZztAq/m6W0yS5K+R2sOLchAH+hjTzxONuvZOzRU8/x9BjfWvOHyitlJDFRt73H6KGiXgbkfrR0bix2CDGCM+1Rbk/ks+jEdHZZW9IK7kbV1Vihfr3Cln7POazirII5+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IKw830vz; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D5666E0005;
	Fri, 22 Nov 2024 16:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732292704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cmHLvQRID3FEQEwwvyLcoVQq/CH/RW/c2n0dDDi8tB0=;
	b=IKw830vz5d+u13bD/AgxPLXBxjNVRcAxcWwu0PWREDNFR0ESJmazF4LKQLx5hbI6chMf/8
	Mi2wkeRivfIChwHoadf+39RCJ8GnKRpX0Cu+FyqYCPEyI3H3Vb5NF863obgq0RXa9yb2nL
	m8RPeDyGXL+F8oBBiIX+RkWuCcVhGWKaUPKoSh3YuQGMtkFYmZGpDUPzm37SMR8xEkye86
	WPabHulfsiszOjCbYXHCvQQ26HgcXBWeVAhlB4I9EOUnvOOFoNGc+uggAbMJUnnxomiVnB
	lLWS55gxwEwRslaw2utL+fmNrwHnT+41YmT4mCU7q+t+gY0zmhZdSar+64/iig==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Subject: [PATCH v3 0/3] drm/vkms: Reimplement line-per-line pixel
 conversion for writeback
Date: Fri, 22 Nov 2024 17:24:59 +0100
Message-Id: <20241122-writeback_line_by_line-v3-0-085d5810f6e3@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFuwQGcC/3WQ3W6DMAyFXwXletnIDwS42ntMU0WCWaM1ZEvSt
 Kji3WdA07RKvUpsy985PjcSIViIpCtuJEC20foJC/FUEHPspw+gdsCa8JLLknNOL8Em0L35PJz
 sBAc9by9tpKrqstJsqAzB5a8Ao71u4Ld3rI82Jh/mTSeztbsjK1Y/QmZGS6o0B6HHdmSmfdXeJ
 xw9G+/ICs38D9Qw+RDEESTqSjKjGNq8Ay273QDfZzw/7Z6J7iNQnDubumIIjjobzcvvh05wTeu
 dDmLst5S6YvXBGGY0nzO6l6gKdT00YuDNUJp/qo9WtUT0BYVPPtDRB9enSLNAFBejUqpmrbpPY
 ll+APuDxUbHAQAA
X-Change-ID: 20240222-writeback_line_by_line-8475605b1d5c
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net, 
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2694;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=eaNKgDeGpchtLQ/lC1Y53hva6pEAQrbyqvD3im/Sq5o=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQLBdK2J5Agc/+lR3N9V+R8J4l4bct7v2tgu8P
 jFVV7IEfmyJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0CwXQAKCRAgrS7GWxAs
 4lpdD/4y8M/lqLkr7og/lSMo7ZpFpSrvXwAbRhsRxqQM/y1GyoijhS8Fq5sd2MHv59Jt4DqhsOY
 uhyMCUAYDOn7ONjtMmPW4J2o2a9d0Ikdtp7N3EHSEZRq012FcGwS1OvHGnjQM/QQ+EuY/5nfeil
 /7J2609yRvXYKfXa1S2BuvVwzYtsg94/+XYnyFxlZUUghmI8590FnrZxT6H9jKGe/4lvZwLhf+3
 y7MbwTFyzpfL9soQ+X9I5dywLpLZWZZJ/4TCefkisQDSrSIedsHcib4UNSz1ZrP5jeEXW8KlK/g
 IQZdWtaUaohSMfpmpFBxvu8ChuBr7+sDrFIa0KfCnz1UGXENyFQ6XbZ7p688VO1HoNapCbLFB/6
 SJJ5pHweuWyorxSgKzG2pjjuWsZtDlifnNoKJSE2pZ7/p+i5OItMf+oMecks25iN5MpI/Cf0gc3
 Mk4PG+ZGRkRmuzh5sClsUlux4/zQDxXAL2yn1jeyW5fv7FCadchYzr0+g7OpOXOYW0jyZDzaKMq
 CoNS0sukEZCEo9PLKbnKpZjeEZ8DYuaDyPZGGdHHoZFxfksNU3Ku8TAhiYYm7AHag2/5m5FvWeK
 6POEHZASKKQLhYAhN3CQQ3iBgd3lISH4uQZM2yB7GZBuUm9hLwxDJYdTqDVYJtCclRIKI3yL9vV
 2hbXCcUER1Ol31Q==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

This series re-introduce the line-by-line algorithm. This is simpler than 
the read part because no rotation/translations are involved. 

PATCH 1/3 is the re-introduction itself
PATCH 2/3 is a proposition to avoid code repetition using a "big" macro.
PATCJ 3/3 is the usage of PATCH 2 to support a new format

This series depends on [1].

[1]:https://lore.kernel.org/all/20241122-b4-new-color-formats-v3-0-23f7776197c9@bootlin.com/

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
Changes in v3:
- Rebased on new iterations
- Link to v2: https://lore.kernel.org/r/20240814-writeback_line_by_line-v2-0-36541c717569@bootlin.com

Changes in v2:
- PATCH 2/3: Remove YUV from supported format list, it is not supported 
- Link to v1: https://lore.kernel.org/r/20240516-writeback_line_by_line-v1-0-7b2e3bf9f1c9@bootlin.com

---
Louis Chauvet (3):
      drm/vkms: Re-introduce line-by-line algorithm for writeback
      drm/vkms: Add a macro for write_line functions
      drm/vkms: Add support for XRGB2101010

 drivers/gpu/drm/vkms/vkms_composer.c  | 17 +++++++
 drivers/gpu/drm/vkms/vkms_drv.h       | 17 ++++---
 drivers/gpu/drm/vkms/vkms_formats.c   | 86 ++++++++++++++++++++++++-----------
 drivers/gpu/drm/vkms/vkms_formats.h   |  2 +-
 drivers/gpu/drm/vkms/vkms_writeback.c |  5 +-
 5 files changed, 92 insertions(+), 35 deletions(-)
---
base-commit: 98efdd02e220fea84c1491012d7292749a71faeb
change-id: 20240222-writeback_line_by_line-8475605b1d5c
prerequisite-message-id: 20241122-yuv-v14-0-e66d83d28d0c@bootlin.com
prerequisite-patch-id: d08b040cfd7aeba4a237029500f5aa8266450cbd
prerequisite-patch-id: deda292af6d8bbf6762b0bf4d351ffd2225995d8
prerequisite-patch-id: 6c2aa2645c7d854951608aa4d15a02e076abe1fe
prerequisite-patch-id: 62f509c48590dc333dc84e2185dc8b9edd61761b
prerequisite-patch-id: 7d988613c79a1ab056110418c04865bf019402cc
prerequisite-patch-id: 43f37e9c1bc041d491e41dfb59548ed258a1e071
prerequisite-patch-id: 1b2a3898d5f8c21b0d306c07b424414bcb14554b
prerequisite-message-id: 20241122-b4-new-color-formats-v3-0-23f7776197c9@bootlin.com
prerequisite-patch-id: e6717b75d79ae5cfb0815bab88d722082107dc0e
prerequisite-patch-id: 4b3b1ea5ad2e3ba1922cd4b3d3d46214b27c8c2d
prerequisite-patch-id: 060874d5a7433cc8cc654bc63e0b411036727ebb
prerequisite-patch-id: 43115d21842e508d9d8b0468e15f67d442bffe3c
prerequisite-patch-id: 627d0970e76d4154c982d0d4172e7a0c4dfb9a4c
prerequisite-patch-id: 582445144ac0ab11175ef96262060b08a5e1467e
prerequisite-patch-id: a98fac5a2c60fe23fbc6a455e9a4ab8b0f187ee8
prerequisite-patch-id: 62c8d109a22b9978f755255b67f13fe74fb7008d

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


