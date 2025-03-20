Return-Path: <linux-kernel+bounces-570243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C80A6AE11
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D6E7986B7E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809072475E8;
	Thu, 20 Mar 2025 18:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aW1mdpX6"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D67245014
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496845; cv=none; b=qBhCOUpfDm/YQE0H50YQFXePko060etTz0gTNeXoIPVS6xZZqrHHnkWBDKVsZk0qhMTGxe5w03UM2G127ja6C373vHIFs4Ez/lOk8bcn8m+35cMdoIpI2jIvkpymEssS0p7btdZI0EC9XqgwV7YR/NV8tntvdiK6F1NmWQrcZxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496845; c=relaxed/simple;
	bh=SjSejjyZ/55nTJ9bgxnHE6PQ8OHS1Xh0Xc0rMHnptQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYQFYh2L02wL3Ggc1vDfrN7Vui+RiIZBV/7E3JwpYYW4X01ANzrdrm5WW7JRF0KygeBvkQbSYcHQEqA7f6Tvm9YDCZFKQRj40pq2xjNWz/F/aV5+uuz/MBXn1AoWtzrhV1+Qzz80x0A3loasa+CexMQuTIwiWvKr4k0kKIcfxW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aW1mdpX6; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-85ae131983eso125390139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496843; x=1743101643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhoA9XaTmEGFO/43twqabJw5GWuyyTcgJpDDhp+La9k=;
        b=aW1mdpX6OE4pJuPfUaVfyion//yQrLwcmA1VCtOd5a1zKdNi99qYRITS5XiyMtC32g
         PZi1COJysAvxkosVrFi1GCbYRCe3IQaTzq5aIU++vyPQYeHVvCvBukF1q5A7qj9v8GN+
         5m3rEiHEtco02GqFyQtnvSwsl3xPg0MPQX2BqWW/4zduWKsVVttXCh4vdR5H4xe09zxo
         5ZT4MPcVyvoJYBCkDp/0XJFQym410fnT2nQhH1SH/8tUlP8vQdtaUcG5JELtGOsMhCMG
         GLacvhu18Asj1xbhq2HOXQDLlOCB51LDe7d43Vvbg5RE0jY9qa/G71kmzX6vG5N/zwx+
         bszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496843; x=1743101643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhoA9XaTmEGFO/43twqabJw5GWuyyTcgJpDDhp+La9k=;
        b=s9TNnB5HCs0u78C3rOl0BwHr1odN4cTK+gVikQQp0YlC5fONz2ZdTUJvH2XKd3lSon
         JwzvwFMCbCww5cefEPGdR13Z9uJ+gDlftG0bisoNFnrtELzMOXZKK+Rsds1f6LU8Yce4
         gTmrC+P8eMtFwDe/72FR9WIRA+ECCIr1Z6WAre8o4nDIvlvZXDMKB9RBP8IdL+i/sO/V
         UNXVUBICiLXgPEX0ia50NxpywZU7Plk8XoLEuJHpKx7XhHCcLAD9rclieBonCSOYsv82
         IvJ3cNh6XD5d/NR/txTykRTr2dd5UZZEbBhr7jcS6LToBbBbDBf7kqT+kJB8t7l9CmlZ
         CMaQ==
X-Gm-Message-State: AOJu0YxY7MLn3C/9OEyGbN8ssmEjB1BXk+F3gkfsurzEZdUNFuuD4RXf
	h1j3tOLZddqeFlIAN3jFsGQDalPgCK9jA4t6di9NU3j6MNunULl2G4pgkXn1
X-Gm-Gg: ASbGncvZ0j+r0/0dv5buZEW2JXdJOzjwoksYly0nOuUSD6LSgqLNKpwtTNP/ZSSg8d7
	Lpb5QHn/aZ2c5k6bdONP/qYzioKPoFIXXLDKtN3HDlqD0LdC299nZsisy8aT2WpbkD9BigEwaYJ
	Ktrpd6u6hRJRzYUWL53UO6sSmI/01xoUfAOgkyQ5CGOhdG0Fnb2P2cUetxEgL/uqgApYat2KoO+
	9K9rZNhjT7kDTfU3ao84HvCpodDaatpBBjOSfi17fLsgnRfSf4mRL+EQ3l3PdRdYjIu3DwEZIKy
	bZg7RMm/UHfzvZu8JKfxiOH9X4s/NXoClBf2Wod5aiGhgoPj1t3XDgMgNmxlsTpiq6vWt6fCijF
	9W9o/beEewNv0
X-Google-Smtp-Source: AGHT+IEgHOQE0JzedJrkXwHL1alAF/zpRzjzP5naMxSeByqgvmG3tMoR3XIdy0yOgUxGxTjx2CzHVg==
X-Received: by 2002:a05:6602:4742:b0:85d:9a7a:8169 with SMTP id ca18e2360f4ac-85e2c904c6dmr48889039f.0.1742496843424;
        Thu, 20 Mar 2025 11:54:03 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:54:03 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-gfx-trybot@lists.freedesktop.org
Cc: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 52/59] drm-dyndbg: add DRM_CLASSMAP_USE to vkms driver
Date: Thu, 20 Mar 2025 12:52:30 -0600
Message-ID: <20250320185238.447458-53-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320185238.447458-1-jim.cromie@gmail.com>
References: <20250320185238.447458-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vkms driver has a number of DRM_UT_* debugs, make them
controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index e0409aba9349..4b9da64661fb 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -39,6 +39,8 @@
 
 static struct vkms_config *default_config;
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 static bool enable_cursor = true;
 module_param_named(enable_cursor, enable_cursor, bool, 0444);
 MODULE_PARM_DESC(enable_cursor, "Enable/Disable cursor support");
-- 
2.49.0


