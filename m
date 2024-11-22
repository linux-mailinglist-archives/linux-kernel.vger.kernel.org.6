Return-Path: <linux-kernel+bounces-418454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65129D61D3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCFCB1608B0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C844E1DF755;
	Fri, 22 Nov 2024 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pnqziLrE"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254511DEFC8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292119; cv=none; b=hCJUtpyDf2T47dcn63rh4Ug/5loxqRb8scXCo6S2OUPBJedV0/VYoLsrXYNHrE0EeDDueI0JOflOJV8uxY9FKr6rUnwRr+2v9DdGT0e0n4o6LyGeCA3U6Dl2z5spDbo/AvpGPT3AdOSqwIG/jn8BugXzeHhgmJWiZRWOoFibz8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292119; c=relaxed/simple;
	bh=6afLNmbpWMMUr24f5V8wd1wG1/7tV7O/RaPm2B/klEk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lmtJhoYblvIuJbVPZ0tO5DdxFJMspfFhxw8VN34CEFZuvg+CTbvLSuBpS/0MK3zYueBQAy/JSkX7jCrKabEYAGX9zxBgb8QBsWSPvSz2wAxy6RoBQIGC+iO+Jg7HKo2kGRc/HWkqoTJ3JGiI/6zlW9XWJDrdb9Al1bpFMAMn3Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pnqziLrE; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 399AC1C0002;
	Fri, 22 Nov 2024 16:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732292107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/pndL6mHgrCMldSSRyJgSVZ8xm3wPmOCmYMw9pc601M=;
	b=pnqziLrEfmJIpoFkf9XF89cUI5chdwcHkJgkkhoQMNkmFWZsjPRicFBp4n9ZsxrtrC/JMF
	RzNxQBrGHWc6DdEJTLSJAqa02vUnnmiVPeKbFAHEbQLjFzUO6g3DBJpXtJPQoC3NkEfXAX
	sR7gbynOurTMbItXTM9jsMltm18b7pzzmttESMstsBPSOvsfaO0MdgAQEwtGduw4Lu8uyv
	9+jc0yhWep8YqYA1TjDzcP8KvFCKKcK7le/NUMD6LIgqy+IDuZbOGfbNPc7RvkYTzvT5if
	tWYEdOm2p9q/4Gv7JKzn6KhIDTYO+yinp9ho+TJh7OdcCBhe9YFiKcYAH0K4fA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Subject: [PATCH v14 0/7] drm/vkms: Add support for YUV and DRM_FORMAT_R*
Date: Fri, 22 Nov 2024 17:15:00 +0100
Message-Id: <20241122-yuv-v14-0-e66d83d28d0c@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAASuQGcC/23T226cMBAG4FdZcV3aGR/Gdq76HlEufOwi7UIKL
 EoU5d07LESQsnfYzMdvPPZHNeS+yUP1dPqo+jw1Q9O1PED141TFs2//5LpJPFEJEAoEYP1+m2q
 U0iQHyWlDFVcGP+Q69L6NZ65tb5cLT772uTRv928/v/D43Axj17/foyacZ79/dMIaahm9NFSEI
 Sl+h64bL037M3bXOeVerZGWasvVsdhExZKSkL9Vz3mT2GUIuSjBynsKWVhhQjBHJfdqzZKsSiE
 SBZxTKRyV2pQEtSjFynCUjzY74+RR6Z3CdYWaVSaEGBLIosVR0aYUuEURq5QxaiNsSQaOymxKf
 2WZecctZFdKjhoeZLlNWRCLcqzAegNE5DLSUSHs2bpEZFWjN9GQQqLyYO9xdyychNXN50IF9IJ
 CLNE9yttajQBmdXOvASP65In/zz5wW7MR0a5u7raPkJJC4fT/Hfhcjnaf/974tozL+V5uAL+/N
 uPTKfXX+toM8dfXQ93mt5Hp5z++jI6pcAMAAA==
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
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2217;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=6afLNmbpWMMUr24f5V8wd1wG1/7tV7O/RaPm2B/klEk=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQK4G/F3fBEVElFPDoKvEd19n8xqe8+IzrvI+y
 MutcOaGUoqJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0CuBgAKCRAgrS7GWxAs
 4l6PEACS9lyQ3Mh01dlk7lbW1fxZaQDAtEeGV+HGeX5Y0rB3Y9AyZBVIT/V5cxBJY1fsHtJubN/
 15n+KIq7yakeSAeRUXgquq+Rpy6AoI9pBuZua1QHafCSaeL7k47hc7Lp6hzWjIYGCDB7N8dWc7A
 aFiVKsWMXdjFAqrMVwMrCIks+/1nRIFqcqDkOlSw2bH437s19mzBwpM5rIx+NwnGNS9VbnWUJet
 OSBb+t9mj6PUTS6DtELtvxNa/9SQcetY7jqf8fWV8aC4mhKIZkCOBMtUQZrJLsmQVZz+0cY33WI
 4Ozvy06vCIcWu+sdaGbREm2NWmnTFjQHmr+wnpOzJl3oSaNZraKjltcLfTc/HKJRCFa8yoapE8M
 uMmOH6iJmcnmtWvZqM2FoYxbQ9QTZ7TOY0EYup+RjzFXkOON53ZhUYA6bZ5oXKcf6EjzKLnDTkc
 WRm1smoWYZY6gopxS2G574AkjJ39+yVXwCRqLwp+Lvdi/At/oEGa+OtojTspE3uhjMBFJ2JRvwk
 JC8auN12IYe73ya4udFpRFxlKBYoRVztsPwnH03JbRM/ZkjqH+tONLGhBgLrUwpDw+diUSg3C5m
 opkSG1128zNPOakFPOSOJGFR5pxYjFKnfakflXfqKkzPnmXKsTLdmJBGg7hLLNSylyVwv54v6ps
 BV85WFWZuYE3VKg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

This patchset is extracted from [1]. The goal is to introduce the YUV
support, thanks to Arthur's work.

- PATCH 1: Add the support of YUV formats
- PATCH 2: Add some drm properties to expose more YUV features
- PATCH 3: Cleanup the todo
- PATCH 4..6: Add some kunit tests
- PATCH 7: Add the support of DRM_FORMAT_R1/2/4/8

[1]: https://lore.kernel.org/r/20241007-yuv-v12-0-01c1ada6fec8@bootlin.com

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
Changes in v14:
- Rebased on drm-misc-next
- Link to v13: https://lore.kernel.org/r/20241118-yuv-v13-0-ac0dd4129552@bootlin.com

Changes since previous series:
 - Fix build test as modules issue: https://lore.kernel.org/all/202410110407.EHvadSaF-lkp@intel.com/
 - Export required symbols in DRM core to use them in kunit
 - Update the kunit comments according to Maxime's feedback
 - Link to original series: https://lore.kernel.org/r/20241007-yuv-v12-0-01c1ada6fec8@bootlin.com

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
base-commit: 98efdd02e220fea84c1491012d7292749a71faeb
change-id: 20240201-yuv-1337d90d9576

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


