Return-Path: <linux-kernel+bounces-447254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 322FC9F2F9C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004E21885868
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06894204F70;
	Mon, 16 Dec 2024 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="TFLqVQXc"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E152200121
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348894; cv=none; b=thFP7cDdVohwnggTRK23EmcuLiUYH9NiUFLW8BbN1A+nCuvuVVTEW5xrS70GSzBamc2b0+yow+12JEiyc6dXDcwr0QGyNtyd1GJTmzsnqrFeXT9tsIY5EhwtWfL8bZqOY5jh59qdhWcI9wSrpX93k/2/aWoR8nCFTPt3ifAftfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348894; c=relaxed/simple;
	bh=o2oExs9IS06W2wuTSfy7oT1l8YCPWwQFt6kUrnFUcG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FJeoCBZmeUvNxlVmYDpiTIvxHFEa64IGctLKgecrAA8US/wHfrY8k5j/Ad6HZdxLzgi6YQ95bWgBtC5DBJL+VAtIpN6v8gljMWRzpd/NOay878fkwcXaaTeW6/SxobEd/1x2Dt60StypyFMn9BazZN2LJQ6CPcjhiAOYu1ASzPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=TFLqVQXc; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734348890;
	bh=o2oExs9IS06W2wuTSfy7oT1l8YCPWwQFt6kUrnFUcG0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TFLqVQXcetsLZl4BIY3y/1jcvzpCNw4sozes71NWxTpoeXNFd/FcaFvjWwhhLY2rF
	 hUl5+AoaGI+/nwWzjIXSRKwa+gGP/K2UyCwgd9Q9ApO0Bm8tNO0LfO8HVKZ0Er4HqL
	 Z3no+vu54umlGSikUT99/vtxnbiDss237I0jhFyY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 12:34:47 +0100
Subject: [PATCH 1/5] drm/sysfs: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-drm-v1-1-210f2b36b9bf@weissschuh.net>
References: <20241216-sysfs-const-bin_attr-drm-v1-0-210f2b36b9bf@weissschuh.net>
In-Reply-To: <20241216-sysfs-const-bin_attr-drm-v1-0-210f2b36b9bf@weissschuh.net>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Qiang Yu <yuq825@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 lima@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734348889; l=1644;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=o2oExs9IS06W2wuTSfy7oT1l8YCPWwQFt6kUrnFUcG0=;
 b=YDmkkKVCgYlLLAJGaraFPnhIxIZeJCB5izojwBThggOwU+itKqHGgNedKgKWJkRPTYsHnYk+P
 abbCqn4jFHpBwSskuQY+JEl64etJ1fYoE5IJrYarbj6F/tbjMPeoIJF
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/gpu/drm/drm_sysfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index fb3bbb6adcd16f3f325a2ae8e35f41851c00b272..60c1f26edb6fad23153c32a29fd3be02700fc938 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -261,7 +261,7 @@ static ssize_t enabled_show(struct device *device,
 }
 
 static ssize_t edid_show(struct file *filp, struct kobject *kobj,
-			 struct bin_attribute *attr, char *buf, loff_t off,
+			 const struct bin_attribute *attr, char *buf, loff_t off,
 			 size_t count)
 {
 	struct device *connector_dev = kobj_to_dev(kobj);
@@ -315,21 +315,21 @@ static struct attribute *connector_dev_attrs[] = {
 	NULL
 };
 
-static struct bin_attribute edid_attr = {
+static const struct bin_attribute edid_attr = {
 	.attr.name = "edid",
 	.attr.mode = 0444,
 	.size = 0,
-	.read = edid_show,
+	.read_new = edid_show,
 };
 
-static struct bin_attribute *connector_bin_attrs[] = {
+static const struct bin_attribute *const connector_bin_attrs[] = {
 	&edid_attr,
 	NULL
 };
 
 static const struct attribute_group connector_dev_group = {
 	.attrs = connector_dev_attrs,
-	.bin_attrs = connector_bin_attrs,
+	.bin_attrs_new = connector_bin_attrs,
 };
 
 static const struct attribute_group *connector_dev_groups[] = {

-- 
2.47.1


