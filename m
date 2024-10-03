Return-Path: <linux-kernel+bounces-349503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9A798F708
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53BE0B210F5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A1A1ABED9;
	Thu,  3 Oct 2024 19:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="q7OTvF1l"
Received: from msa.smtpout.orange.fr (msa-217.smtpout.orange.fr [193.252.23.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC1E1A76CF;
	Thu,  3 Oct 2024 19:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727983933; cv=none; b=FRQ6rp3wXevSwdn+X95VR4ojkk6yTDK+ZSuiov/Foaa5Fbln5VjJykaEYjb7qS3Vhrzfgw1cFB6WNtlPtBIkTMJuBfGaxSc2cpcoYZueVonkk8VldTl7PgnrD7+m4qeesZbrfXmjBHSodjSeajR6ELe4xlhjMA8Y5MJNKeDXkjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727983933; c=relaxed/simple;
	bh=d5iKgHRJaHd1qOIZNZ6AtOmvXTo3H3/Cvogev0/hzIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ELlZJgm1O0ivAYF/gKmHcDpH75eKJ/nFCeKM+mNfWpK4rppcdtxlHEpxMCnvm42te5hL8IL+s/2facnZfgIFfR5xpAQofCpJGX56uA38bd1oVJA7a5UardIDRANMaDCRpE3WnVLqbdGBCm/20fYr9KPUb972gvpHrf4CwMbZIFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=q7OTvF1l; arc=none smtp.client-ip=193.252.23.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id wPq8swhqS7qAjwPq8sLNUA; Thu, 03 Oct 2024 19:42:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1727977336;
	bh=LhnrapA1svnmlMx7xGYpTi5BLYj0TEUzRvNk0AItb2s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=q7OTvF1l62ehUvp8N5YxrlB6RCO6AOPpdfa7wRMrXMlm93JNTsppGGLP9A8sHnIb+
	 TBo21exNKKTSnk8bsTG/tEfJxIs86mw/w4CCW/8LczKq5xPprFXZj0ntGDHZ4UB7Gz
	 hxGNQrO9HY1sIqTZrMGrCJRkRQBxCsv0BpNr8CPPbPGHe5lg+ZFyVcuJ4W+qgz4SAv
	 4pWMJa/9P9xHm4cJfbSecW6SFoZJ7z8uyUrBwyBa5K3DIH5pCgaUWTLOJk/Qne7SA/
	 l2MSKn7Q7681nyR0gSt51hlH2iXFI5ttMw7DiuM0UUKSzwjxzbbhzefjPOtVVSO06c
	 ghuSldIi556sQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 03 Oct 2024 19:42:16 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/i915/display: Remove kstrdup_const() and kfree_const() usage
Date: Thu,  3 Oct 2024 19:41:08 +0200
Message-ID: <f82be2ee3ac7d18dd9982b5368a88a5bf2aeb777.1727977199.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kstrdup_const() and kfree_const() can be confusing in code built as a
module. In such a case, it does not do what one could expect from the name
of the functions.

The code is not wrong by itself, but in such a case, it is equivalent to
kstrdup() and kfree().

So, keep thinks simple and straightforward.

This reverts commit 379b63e7e682 ("drm/i915/display: Save a few bytes of
memory in intel_backlight_device_register()")

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/i915/display/intel_backlight.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/gpu/drm/i915/display/intel_backlight.c
index 9e05745d797d..3f81a726cc7d 100644
--- a/drivers/gpu/drm/i915/display/intel_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_backlight.c
@@ -949,7 +949,7 @@ int intel_backlight_device_register(struct intel_connector *connector)
 	else
 		props.power = BACKLIGHT_POWER_OFF;
 
-	name = kstrdup_const("intel_backlight", GFP_KERNEL);
+	name = kstrdup("intel_backlight", GFP_KERNEL);
 	if (!name)
 		return -ENOMEM;
 
@@ -963,7 +963,7 @@ int intel_backlight_device_register(struct intel_connector *connector)
 		 * compatibility. Use unique names for subsequent backlight devices as a
 		 * fallback when the default name already exists.
 		 */
-		kfree_const(name);
+		kfree(name);
 		name = kasprintf(GFP_KERNEL, "card%d-%s-backlight",
 				 i915->drm.primary->index, connector->base.name);
 		if (!name)
@@ -987,7 +987,7 @@ int intel_backlight_device_register(struct intel_connector *connector)
 		    connector->base.base.id, connector->base.name, name);
 
 out:
-	kfree_const(name);
+	kfree(name);
 
 	return ret;
 }
-- 
2.46.2


