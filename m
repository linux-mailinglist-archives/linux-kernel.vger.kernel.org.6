Return-Path: <linux-kernel+bounces-317943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BDE96E5CE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF3081C238BC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551061AD9FA;
	Thu,  5 Sep 2024 22:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTbGvBat"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A18F172BDF
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 22:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725575964; cv=none; b=iiPSblFlM5m6uNffLtsCrwmyzjntz5vTajfniSIhwwSAUhUdlQEnZLsNOyx1HC5AhCypx/3guEJ6vLfPAlQuMMDgMpgvFovMi8KA2L9ZLNJUj1ZdUJctY9LP1LX4LfxMH9hrFvebDSMbbfBTioNRN2vBCX4G12mdKhMVEA2gBmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725575964; c=relaxed/simple;
	bh=rzfl4i6wwXylhJOHUu0dxixSg+q5nmQ3kdyOs73uV4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S/kk0oFqZMyD+T399/HzJQDIX6ViU3+L9/vCuHiz847Zz7Shjzx1QiBB6u7ByTIg9Eoi5p/GKzfWGUB6XUGvNkfc3aA7GkOvoohryk13Lvh2mtMnDauP6ZmP8tmYsjs4xBTaBvR88PsLNv5USbiEZIwm/wCHrVPnYLFdlN7MLbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTbGvBat; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2053f6b8201so12627055ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 15:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725575963; x=1726180763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rCDYYiCppuB7n7e+YXIEe54LH8OdKy8Qsr87xme6vNA=;
        b=GTbGvBatquCRB0PfNF6uJl3DftmT1y3vmD3CyAEyGlGqWPLx6b9mg5oLN0XA6hslNF
         qO9yJ4RhFfu+SU3YPgTBNxmX5rgAUy2/V0kClAOrX7YPbIQup1BcLqBrdSbkQS92cH+R
         tkQsxecJeOgfQfamKN6p+XHBQh7r+/Lfgu5yJZ863ppGTzqP/9Y3knPNlm3WoW0rVaAj
         XnPYq5BjfWDScm8aHcRCd0pIbJ7iAEWsBJh4Rz2JVCuCWPzcEW7P/D7WmnS0LbJhggXI
         NfWvZdomsOTRBMHSCYNf0sUuaEi38194bS+k2Qb1FnHc3dnthlUxQpVddW3559V682z5
         7BWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725575963; x=1726180763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rCDYYiCppuB7n7e+YXIEe54LH8OdKy8Qsr87xme6vNA=;
        b=gAqlAsycV4eCp9qM6nElnq/SkXXwEenm5+lFH51zYeSMQaDD7rCDyrnAq3ciCPifJf
         Yxh7z6Kd1fNOBRb/aJsvq4mWgDY3W6/NOzkvlcJt/JXr3rPEha4wg+xMnwDR8xvLC5Bs
         dnPqtS9AnVBXSFa2plUuo/QMrnh9UfN9kGUlcSsZbEZR7MAlsiWIyL7bYg7gvl7x4FtG
         eLviPoyn+hJ2kOd2XMbqx7VHIXqocpRjB3zoDqvamQdCjOzFx5ijDU2Q7Z7AfMqwk/be
         yvkDZmR0q/Y1metvvJSYGE6zLXueT3WIqex0UdDVgRWR/lM7+9ccZd+X52GGyGw5Bubo
         OfCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLPOVHHrqgyOa18O2tXIRoHzpU+HTHwKBXgYP88PHPZSS45CJUbb7OzhIdiyGb2eEGZfsLp+aq51JZXTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw114SLyDxfAiCHB9lYW23pQvKG20qLcitRnpzjIZinLsxZcqPW
	DCvBTmp3mY7BwXKVJZuJTz6pOcyCJt/+A0gFyiiQTF3YnWsUcCmR
X-Google-Smtp-Source: AGHT+IFdDlOtC7QKiZljAYe/nH8z6tsEcq87j6lrJJXzigssQI2/0okjfjiTxKTZxUmFaIUPQUJsvQ==
X-Received: by 2002:a17:902:f610:b0:205:eec:5755 with SMTP id d9443c01a7336-206f0526051mr8889545ad.23.1725575962683;
        Thu, 05 Sep 2024 15:39:22 -0700 (PDT)
Received: from localhost.localdomain (111-240-109-89.dynamic-ip.hinet.net. [111.240.109.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea574dbsm33185335ad.214.2024.09.05.15.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 15:39:22 -0700 (PDT)
From: Min-Hua Chen <minhuadotchen@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Min-Hua Chen <minhuadotchen@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/rockchip: include rockchip_drm_drv.h
Date: Fri,  6 Sep 2024 06:38:50 +0800
Message-ID: <20240905223852.188355-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include rockchip_drm_drv.h to fix the follow sparse warning:

drivers/gpu/drm/rockchip/rockchip_vop2_reg.c:502:24: sparse:
warning: symbol 'vop2_platform_driver' was not declared.
Should it be static?

No functional change intended.

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index 18efb3fe1c00..c678d1b0fd7c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -14,6 +14,7 @@
 #include <drm/drm_print.h>
 
 #include "rockchip_drm_vop2.h"
+#include "rockchip_drm_drv.h"
 
 static const uint32_t formats_cluster[] = {
 	DRM_FORMAT_XRGB2101010,
-- 
2.43.0


