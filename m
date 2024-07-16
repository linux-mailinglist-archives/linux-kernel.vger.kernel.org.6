Return-Path: <linux-kernel+bounces-254300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7945933191
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 122641C20CC5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4601ACA0E;
	Tue, 16 Jul 2024 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebjOzy6l"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAB41AC444;
	Tue, 16 Jul 2024 18:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156366; cv=none; b=DtMNHsGtOnxCdliT7uRg4JezqYV02FlFnxZWHYGNqZWft88URoZvVelB8AxxTxqjNP9LA1NxdT8FabbkL+bkF/VuMvKVtQ1ibhGLCJ51Hojo7yhsDXA73uVDVy471rVjdkPADNsUpbptXcJ6Jp63J3URH/Wa2tFjd4ei7OlVeLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156366; c=relaxed/simple;
	bh=oYOe2lhXkLlShr79+oMb5s3dimYUvU++xTU1aiSXEBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpPecM6LxRtZrH/0KW1w0j1ewN79ktrbCYad8U2CCBMlm5E7VIc9BtycuPcaXn2/NkWMd+NMgmjJg9/UJb0Wxxt2/9VDn3V479xjmpAz3tF0NGvhZofKn4FpaSp/+lruox/+uf14Qxea4tosi05htfpDP7v28lBlEUH/3PeGLSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebjOzy6l; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7fedb09357aso5239439f.2;
        Tue, 16 Jul 2024 11:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156364; x=1721761164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wh8QJ3ROh21ShBzcCiOPzlcJgoRl8pzdhd6qJVNHlVY=;
        b=ebjOzy6lH87HQXHmm8t30PD8J9iO/bdiTPaXK9OZ7Wed+m/J/MKkmsmtVpjR4iLlC8
         bPl6N1oASWf3Syl23AetpMKkaXNWAZH+BngysPpvmjYjoN17jgeUBdomRNBda6n/PO6V
         ubohT/apvf48rvWAPCUUD1JEIxF/XKrf3WhMD4OtncjxFluXNfh7oLg09koumb7Tgx3i
         EODRLvj2/23791KnoTI8KwcDXrRNutXyJ/mscBr38S/YwjrNjtjrSnWH+oXwvTL7Oma1
         Di0R5pIjv0zf9/Dd+Rh4G+brfXpGzWe4OQm5N+BD+PMoOIgWJHAvm0a1FaKiXDhFrrSl
         R//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156364; x=1721761164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wh8QJ3ROh21ShBzcCiOPzlcJgoRl8pzdhd6qJVNHlVY=;
        b=BgW+cRSKDg+si5XzYS9DkNG4eg64/xsK+JTVPa5Hp3i1M8ep4QIvFtYw6G8f8Kk1Tk
         FdnDo0ZeMYYiURk57+lzwvPIQDEQM9N290uDsFFMcQFprWVDC4/717RKD/4qmK7fLjcO
         u5r1+VYFIvpPTQpS31Bv+V9UpwH6ppGNAcjfW0vSeFyuiNL4Uk5x/rvgH/D7j7Rh8P92
         w9pioIPUA9fe/ms1Au6VKzLz+QrsX69ZjRW9nmGubSrps9gK5e08uiEGHOIOJe0aEcjM
         X0AkXUKF5XCLYmqCQftSzJWLzPow1eriipfih+/sHeSAqQIBefN/0/jPqlNpVoV0ceHP
         W0EA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ2rB1G1k6eEtLnjfpxXXYWU+CmE1co0Vw3uft7uMOBUQNWI5WqVeIuglm2YYkuuMfsBw3DTADoXGDkMvCD3W9TxecLdoZDKIK
X-Gm-Message-State: AOJu0Yz5enm03VaEzLuvB6oV+vlv+sppQek6D86kbn3zzBzuZ5V3ACuu
	39vG7Y+E9e27e2v+jvaRs92QufdIky0mpocZXLrs4LiKtFZgjtJlCVxy/fRk
X-Google-Smtp-Source: AGHT+IE7JSdS637yqmgSK0kAxgcum1cr1TH5x0rj6iYZ0/p71OMWMmUHkP3RXNMmv9mFZHhsjrkz/A==
X-Received: by 2002:a05:6602:1493:b0:807:4340:947e with SMTP id ca18e2360f4ac-816c4a15d70mr32398439f.15.1721156364251;
        Tue, 16 Jul 2024 11:59:24 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:59:23 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com
Cc: ukaszb@chromium.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	linux-doc@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	kernelnewbies@kernelnewbies.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9-resend 46/54] drm-dyndbg: add DRM_CLASSMAP_USE to vkms driver
Date: Tue, 16 Jul 2024 12:57:58 -0600
Message-ID: <20240716185806.1572048-47-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716185806.1572048-1-jim.cromie@gmail.com>
References: <20240716185806.1572048-1-jim.cromie@gmail.com>
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
index dd0af086e7fa..086797c4b82b 100644
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
2.45.2


