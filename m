Return-Path: <linux-kernel+bounces-413374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7089D1852
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F139B2243C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF3C1E0E17;
	Mon, 18 Nov 2024 18:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MoudyurG"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B690818E0E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 18:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731955403; cv=none; b=qVAU+2s/ycHkx89MeSHJJB7yh5uS0LHeoAWfq7n+Nmvh/WfySmT39tOPKnz9hAt115Ij2QmNopNuqzEVWpi12fyTGTxxmu7cYNuvLCOUEf4IleXjcqQjZccKoTNyKdoax/wdquURD8p78tQQghOC3Tn+i33ulEki4FsE7PrC3js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731955403; c=relaxed/simple;
	bh=1IpTHBx5T6hQG43XSmIApVXYJjBqDcjsHyGHAge/HUg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PH5cjAZ8ubwmq6CIngcLh/mJ1RQZE3W0Jny96APiyTIOJQAxGuop2r6/6XAIRMlvv4gO644rVWg1+ZwNlhcrgyvq1UC9P0OZFclxJp7Kq4Pz/2TV2p5aGX8HvzMMUOch7SnHxU46KXBReBrkF9/CnMA6fXeSc6zeXqmB/AxRtw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MoudyurG; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 23FBC1BF203;
	Mon, 18 Nov 2024 18:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731955399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vvz7jPELyRAfFaHb3cO46WKQISvsQVK1KUnfhr5c3gU=;
	b=MoudyurGtMURl9WHflKGF4dPu/Qbqwm9DK/p69sCDvYxizxex06J/OsiZQRso3zbqKnl1T
	T/SFzU2VvymxWpMmdJn/1LFB0O8O+KskDF0oTAVzXfAd4yYsEPLRP07t7hIFFslXIMtCkd
	l9d1z61aknbv9f5DSOKPhr2xVS9ERLtZygb1fk8uX+9EK5H6R4G3l6WabDcB7bmi4qUSBC
	xpXQ4ICHTRBA204vOWijWaA6Y/GshiAWg5iMTQH1Okk1B9+Wi90T3sQa9/GNDrkNmWLbBQ
	maJM5nWFDhyWQyXz4mr15wFzgDgyJhqovuXpNHkKEgq78M/zNDluax9uYoa3HA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Subject: [PATCH v13 0/7] drm/vkms: Add support for YUV and DRM_FORMAT_R*
Date: Mon, 18 Nov 2024 19:43:13 +0100
Message-Id: <20241118-yuv-v13-0-ac0dd4129552@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMKKO2cC/23T246bMBAG4FeJuC7tjA9jO1d9j6oXPjaWAmyBo
 F2t9t1rAhGk5A7MfPwGfj6rIfY5DtX59Fn1ccpD7tpygvzbqfIX2/6JdQ5loWLABDDA+uM21ci
 5CgaCkYqqMunsEGvX29Zfymx7u17L4lsfU36/3/vX73J+ycPY9R/3qAnn1eebTlhDzb3lihJTx
 NlP13XjNbfffdfMKfdpibRM6zLtkw6UNAkO8Wl6zpvYLoPxRbGirCUXmWbKOXVUfK/WLF5USkQ
 sgTEiuKMSm+IgFiWKUiXKeh2NMvyo5E7hukNZVCQE7wLwJNlR0aYEmEVRUSGil4rpFBQcldqUf
 GSp+Y1riCal6CW8yDKb0sAWZYoCbRUQkYlIR4WwZ+sWsagarfKKBBKlF+8ed7UwHFY390I4tIy
 cT968yts+NQKo1c3fGtCjDZbK8+ln97VUtI9/b6X149LTpcnlepPH8yn0Td3kwf94HNRtfB/nK
 jZxGOz93zifllT+KPHcFRekII6MkrX/pX79A+7G48RzAwAA
X-Change-ID: 20240201-yuv-1337d90d9576
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
 nicolejadeyee@google.com, Louis Chauvet <louis.chauvet@bootlin.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2765;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=1IpTHBx5T6hQG43XSmIApVXYJjBqDcjsHyGHAge/HUg=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnO4rDXaboM/crbcTIDd1ehbG01sj0w1CLZvhRV
 yAnoFXTGN+JAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZzuKwwAKCRAgrS7GWxAs
 4pu1D/4nzwTvIyFMyYnDz0hLG5hXUYW7Vid88G82KUZLpnq+fnlQtbCQTeMGsyexTC2qKENCLlF
 /scvp2lL00O6wlaSGjmtBNVLFmTWDVdm90Ed22BxtnS8XOPB1sDVufI/oogSDwW0S8Ba6GFheyR
 CerT0MMcR8UDAunPFM1wKuiLwfg9zwOx+Hvr/KembiTRTwtQ+pprqzirGP/nTEu//ey65qMim1y
 Y0I7Uw6RkP5kWOh50W36THhOJVOiPZtVuVKo7Ok6wfLGsH25bnWtq0q+VgVIUq9QXELIkUpZBIy
 7R2G84L1sVnP64eR3HmdAW/KiMUhu/VElycD09E5AmLq70/7QgdL9RcZPJb5VLlIk6yu/GngGn0
 2UpTg9zlnF6jn4fef4RSOtkh7rF6wVjpLxIYZX/PppL7asAFFh8S5jzBFZ9/vJjPwoOLQUoiyxa
 /+o6a7vMRAzojXWstjjwKyP5epXdZJxGhzU0jKJE+Uk83PycrUNMxAplG0oZk0FVnqqYlM0FD4f
 J0e4lfOIGpIOInMZ7uxF3yw0HcHO1enTnCmH/ebGb1dPCdCFV6kVese5gihdFNJrnoVIGqNSzkk
 ZOqLaHYY5+Eou82ngyBYs74o6mEV1lWF523x6ruECjHO0nO6ltBCqj6rptaa6l/FHyGZ8TFgrOn
 JT7PH7y4hnMUpIg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

This series depends on [1].

This patchset is extracted from [1]. The goal is to introduce the YUV
support, thanks to Arthur's work.

- PATCH 1: Add the support of YUV formats
- PATCH 2: Add some drm properties to expose more YUV features
- PATCH 3: Cleanup the todo
- PATCH 4..6: Add some kunit tests
- PATCH 7: Add the support of DRM_FORMAT_R1/2/4/8

[1]: https://lore.kernel.org/r/20241007-yuv-v12-0-01c1ada6fec8@bootlin.com

Changes since previous series:
 - Fix build test as modules issue: https://lore.kernel.org/all/202410110407.EHvadSaF-lkp@intel.com/
 - Export required symbols in DRM core to use them in kunit
 - Update the kunit comments according to Maxime's feedback
 - Link to original series: https://lore.kernel.org/r/20241007-yuv-v12-0-01c1ada6fec8@bootlin.com

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
Arthur Grillo (5):
      drm/vkms: Add YUV support
      drm/vkms: Add range and encoding properties to the plane
      drm/vkms: Drop YUV formats TODO
      drm/vkms: Create KUnit tests for YUV conversions
      drm/vkms: Add how to run the Kunit tests

Louis Chauvet (2):
      drm: Export symbols to use in tests
      drm/vkms: Add support for DRM_FORMAT_R*

 Documentation/gpu/vkms.rst                    |  14 +-
 drivers/gpu/drm/drm_color_mgmt.c              |   2 +
 drivers/gpu/drm/vkms/Kconfig                  |  15 +
 drivers/gpu/drm/vkms/Makefile                 |   1 +
 drivers/gpu/drm/vkms/tests/.kunitconfig       |   4 +
 drivers/gpu/drm/vkms/tests/Makefile           |   3 +
 drivers/gpu/drm/vkms/tests/vkms_format_test.c | 270 +++++++++++++++
 drivers/gpu/drm/vkms/vkms_drv.h               |  18 +
 drivers/gpu/drm/vkms/vkms_formats.c           | 467 +++++++++++++++++++++++++-
 drivers/gpu/drm/vkms/vkms_formats.h           |   9 +
 drivers/gpu/drm/vkms/vkms_plane.c             |  29 +-
 11 files changed, 828 insertions(+), 4 deletions(-)
---
base-commit: 7d2faa8dbb7055a115fe0cd6068d7090094a573d
change-id: 20240201-yuv-1337d90d9576
prerequisite-message-id: 20241031-yuv-v13-0-bd5463126faa@bootlin.com
prerequisite-patch-id: ae2d8b2efbbaa9decce56632c498c87e708288b3
prerequisite-patch-id: d1e73379a15c5062924cf2dc8619676e13f35a13
prerequisite-patch-id: 2eed29b53617ba76169e1af303e4899d517a3a18
prerequisite-patch-id: 82523a917646793deeec7cdcc7ff286bd924fd21
prerequisite-patch-id: 3f84c6e64b3a25510e929914e97ae2549451707c
prerequisite-patch-id: a0639eb773bf58c2ffe76f2567a8c74b6275092c
prerequisite-patch-id: dda6bf4692cd1795c489ff58e72c0841ea8ffbc4
prerequisite-patch-id: 11ae7be077ce7022f61101d41a9ba79b98efb273
prerequisite-patch-id: 7a63d245a377d5f5283f48e8f52421b912811752

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


