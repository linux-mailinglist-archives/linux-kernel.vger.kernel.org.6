Return-Path: <linux-kernel+bounces-391066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBED9B823D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C923BB23DA5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6387E1CB53B;
	Thu, 31 Oct 2024 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AmTC2Nb5"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5297C1C9B98;
	Thu, 31 Oct 2024 18:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730397984; cv=none; b=k7Hjp0m60PCs5PDAZraEep7sdK2NEysZRXT0nci9K7VGQ5jhWeWZJayWkDanuClLytmsry95tmu4rZ7w+9P7/LF/Mbtbh/8ASDlfzSimsayO6DlGlBK8zfKFZ+y1+kWqMlGg52WbnUWXvheDBnTqAg8apV+UJHC28HD85cNPqLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730397984; c=relaxed/simple;
	bh=7tjRMSUn1ff+jaTKfg3LLB4Z1WdxYK0a7+YdSZB50Ws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mYQ28rhvSXnEImAZP1UP9TOlCXzHcJ4w4O3pYjSigePWUth3kyHsi0FpyCx48LPjsmfC2nbdROILKcE7mMxZIBCS0RFyDBJIrfeK0oFQTuFgxfC72AtL14stUPSWEbWxFLlzB9O9i9mCrKiN2xf5aWmAo76LDDPMQ0c0M8Y0HMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AmTC2Nb5; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C853F2000D;
	Thu, 31 Oct 2024 18:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730397975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WnxB3DYHE4hlot0SiDmuaPnWv/Qs3ZnmMdNCEu0LXW8=;
	b=AmTC2Nb5X/r7SKiLz0cluzgtNgcCtelTLxq+FfKqJe2ZQdwXI5WBU9wVu+QjOqOpWt1z03
	SUBfqt3By3meI/Kq3dwBqll2/SsmJfGfjLTvVpwPWDCOUxeZgxeo1LatPfpZcNYeBY4JwE
	qtyqWn09SCfQGjSxpXY8eOJ6y2HXRLnKUZjUiGKv68UIACOjckvrPzHM/LRjitd03gZsSY
	tB0lxlqXOBbrLAmR8SBx1R0uwNLEpMrKngFrWNMuOuKbPk5rxg3GFOxSLntu2UsYaNM7Z1
	DYMEKmVqJjpBwjg3RXFMGx2OBnX9xJ71ZcOCQsq73BMG++vriZc5ZCtsmARdww==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 31 Oct 2024 19:06:04 +0100
Subject: [PATCH v13 4/7] drm: Export symbols to use in tests
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-yuv-v13-4-c67a337301ae@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1008;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=7tjRMSUn1ff+jaTKfg3LLB4Z1WdxYK0a7+YdSZB50Ws=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnI8cO4JrWkuXTajcS3TwlAWUM/tx0YtbPwUmWt
 HmGXz61ywSJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZyPHDgAKCRAgrS7GWxAs
 4oBeEADC0xzD/sfcbN2nWw4+6Y6jG0Wla6EVNCMEhkPF0j5rwx7F1GSoDTa1kGuSTdtbe9iMD1/
 ZdSSxfIzTmMZvO0BrF1lCZ7uXApFFYoi3xat5GTVpaQQhk9Dz4yEHgVFIY6nsgQ9ekcCg+GGW0s
 +7myo1+dFhU127Gnteouyz5SGvpmzV1aHNEKBIRqGeEY/AGPAn4OU/U51uiowTzlfoSPdNK+Nwr
 aopFW+Lleee06NVUcIEeQlMx77R1G8NbB+yfxwcs7GeFm0eWHtMxv1mrXww/wax4GfT1zYymD8W
 K/7Cwo/DiU+bOm+qsSOsqgz0vf/bKsrlgqnOYqxN5tGXjRPCADelbUR/qJfH8qG5Tgkw3p6+Ic2
 y+hatDGm5l38NzvB9uEBftzTePHXR/DzxyhtCA2YWTU5fP8sRFKcjM+ReE1f2GDS6dOteecC0Nx
 hDqQWMDsCZXzcQwWKzcW/IVQWb66dyQw+sUvLgLqVJg6mjTQZb43qJwuJg0g8SEA66kUTj16/xD
 FKQJzxcCeE79Hg8tqs11zCVjYZnFelzgRBvksWCqmrZJSijT9EX+3i4A6MNdqaUxCTsY+LLrPm4
 lEgOAfkGXz4E0mN/waShmRqMOIo3eJlpJCDTqGQGytnxHbax7MvDrADBLqL+2MogY7fODHwjWeX
 WkW6jmSSWBYI+ew==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The functions drm_get_color_encoding_name and drm_get_color_range_name
are useful for clarifying test results. Therefore, export them so they
can be used in tests built as modules.
---
 drivers/gpu/drm/drm_color_mgmt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_color_mgmt.c
index 3969dc548cff..509aa4325391 100644
--- a/drivers/gpu/drm/drm_color_mgmt.c
+++ b/drivers/gpu/drm/drm_color_mgmt.c
@@ -494,6 +494,7 @@ const char *drm_get_color_encoding_name(enum drm_color_encoding encoding)
 
 	return color_encoding_name[encoding];
 }
+EXPORT_SYMBOL(drm_get_color_encoding_name);
 
 /**
  * drm_get_color_range_name - return a string for color range
@@ -509,6 +510,7 @@ const char *drm_get_color_range_name(enum drm_color_range range)
 
 	return color_range_name[range];
 }
+EXPORT_SYMBOL(drm_get_color_range_name);
 
 /**
  * drm_plane_create_color_properties - color encoding related plane properties

-- 
2.46.2


