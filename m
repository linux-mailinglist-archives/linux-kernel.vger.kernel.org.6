Return-Path: <linux-kernel+bounces-314945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB6996BB46
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631F1281336
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5ED1D2F6B;
	Wed,  4 Sep 2024 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="F1oFdvJv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="H8m7fNcD"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44F4170A0E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 11:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725450711; cv=none; b=vBnUin7H5cPybvSt/jQhhSEcf9yJQh3jhSS/8LkuIddc8BBPo29j1mfPGlTiBRrbdlpdtvgcACdGW33HkJZ0Rm3aSYpLZAuTT51e7p1gNGuJshb9e6/8WPFW1tt3RQB9jr8H/WoxHeB6XgUwBUsrmbTizGFb7uCpXBNzBy7oyhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725450711; c=relaxed/simple;
	bh=/44+gQD/UlR0hu8XRMSSUspG16Q/7s/TbW2Y3w2RrHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BWlGGobKagZHRFY41jx5lDSXDdCpca9Owc4SiGB2agGYonk51E8O94/xnQ68r5tgguLJpEw7GXD8b8KRsLoURGfSEcsIBYZ8cZ23XMywfYN4W5V873Yf3F1dMAaCm8jt58DylGjlyJwS6/YHdesrsKva61i3M7xK/l2W1nkHWqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=F1oFdvJv; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=H8m7fNcD reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1725450708; x=1756986708;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9bZTQfFErD83ZpeUe8f6tUjcWK8u+2HNM0QEJ6Cyo2s=;
  b=F1oFdvJvQOUAxfPrDkXDs/TOV8TJV5B8xqnB3GuoAOMHiLqYT6u3oSXm
   mggfVHFCbDBGFalsedgLd4Y7TFqN+DFnYii7EZ6L9LG90yvAjnSrCJjl5
   wouSVpVNp/t+2Rg9VJQLXcQA/QIbAhwtIK8me2n3cZxD0TDRtP4c2TRxb
   Lh/1YDrU64GCSeKclmexbpgIFdr6+pwnzCaPj84nOOqfRBh9fCBb/4LRK
   L/nuqJHuQqyu0zuago7AL8qPW5aDnt3KJQ8fNaZ0P0rQLeCrlaLQwJIsp
   x+xE5X5g+2b06vnoBiQZv2eX4lHFEJ2WE5+rbwXREKzvKMMg06bG5CJMQ
   w==;
X-CSE-ConnectionGUID: IW9Wr4ScQwiKaAfT2Jmmfw==
X-CSE-MsgGUID: x6T6SRwUTl6+Zhy7GadJsw==
X-IronPort-AV: E=Sophos;i="6.10,201,1719871200"; 
   d="scan'208";a="38762014"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Sep 2024 13:51:45 +0200
X-CheckPoint: {66D849D1-3-5FF8EC80-F6CEE9F8}
X-MAIL-CPID: 99D071542BF70ABE41EF222ECB70A02A_0
X-Control-Analysis: str=0001.0A782F21.66D849D1.009F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BB6F4160CE2;
	Wed,  4 Sep 2024 13:51:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1725450700; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=9bZTQfFErD83ZpeUe8f6tUjcWK8u+2HNM0QEJ6Cyo2s=;
	b=H8m7fNcDNEbr2UgXpYCbXLE6+bcLeWCbZZz7su+xMjkRotOqFgAhEmikqiKKJx+5XT1oYE
	bjjSyD4RShMLwboAMSKRUApxwGEuX1enHfHrZSjsHpAQIjZrGVgMhmXPpQjKISoE1hJdrx
	ag7k0gVjL+0HiAzQIDBltjQLPnL7wb7XbzCvRTVyViWFkDzehQufnXrEXcTHwA9IAT6LuA
	jMF867Ugo9ASI6NiSii4EyPKf8yJyYSUWlYZNmuUbcswdq6ipgaH62zeeZbQlO8udLagLz
	Cje9rXlMHttAuEPhCkqcEYzixcRmGLx8r0VMG5Pp4Eusv+wn9KkJ0LO9KyVGAQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Stefan Agner <stefan@agner.ch>,
	Alison Wang <alison.wang@nxp.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Matthias Schiffer <matthias.schiffer@tq-group.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND 1/2] drm: fsl-dcu: Use dev_err_probe
Date: Wed,  4 Sep 2024 13:51:34 +0200
Message-Id: <20240904115135.1843274-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

fsl_dcu_drm_modeset_init can return -EPROBE_DEFER, so use dev_err_probe
to remove an invalid error message and add it to deferral description.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index a395f93449f3..90cbd18f096d 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -103,10 +103,8 @@ static int fsl_dcu_load(struct drm_device *dev, unsigned long flags)
 	int ret;
 
 	ret = fsl_dcu_drm_modeset_init(fsl_dev);
-	if (ret < 0) {
-		dev_err(dev->dev, "failed to initialize mode setting\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev->dev, ret, "failed to initialize mode setting\n");
 
 	ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
 	if (ret < 0) {
-- 
2.34.1


