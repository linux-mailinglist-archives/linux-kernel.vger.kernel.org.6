Return-Path: <linux-kernel+bounces-296109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B33195A5C2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 22:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC59284643
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 20:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47C716FF41;
	Wed, 21 Aug 2024 20:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYUOqFaP"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF97728DCB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 20:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724271714; cv=none; b=EgZ19tuCeWb7EAjbreSEGem1FZynC7VQ7xFnUcMHtFzrX+j68DWaHJAAO1wGVmpHU2wRQmyOm98i/+6CgNx2rCjOCCEWB3InsH1sYPllBa7/Vm96+sE/u4IwbmPAa1ZAljA8WAXgd6PT0xFbsEYSNu4WKBb+vNn+D5ZpQLhrNms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724271714; c=relaxed/simple;
	bh=FrN4JvW6EYNJCVvzAp2Q3uBulRZKiB0RUfIT53d+hyY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c7HVNFZuRdbyXafRxiWpHHeX07+qa8mqgIedWMegRRyiW3EfHPjyriTTVKIDJJPj6YRzrl3NM0FYAArTxUC0gVgz3VRnTBS7G6aDMTP5wXLvZABqdR4hYIGeTOncfrMFeAoPWE7hW3d2knEJNjXWFOJm1OvogLRT2GQjyE7ocJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYUOqFaP; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d42c59df79so6722a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724271712; x=1724876512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pdEtI3O/iGeWeBxm8urkX5KxXtMLJvXUlzR+ZSGfwBE=;
        b=YYUOqFaPTZweC1fH4kQBOKbsTd9rNnNssHXJjY5KYSuDMShaN0Nv1SmAfV0RZ0sLQJ
         TSX9mplscVCJa0mybG1vN9IjXvdBjWTqf0UfyFVtbck3mtokWM9TLEeLFtIZjZh8UENL
         eQiK3HCuHNLisSMCw0gHzCZDXbklJ9bMu4HzmoTLeb3Tjjp5xssUZjNq/RCMWZv3M7Ow
         r0gfR5m+ybgNLtxNc5bJyAoa2iKCTNnLVah/tSC+k1sX+x5PYk9zBSsi/MslaW+EvJ45
         wJIBPmp860rXPs68clcrBVZnlZqA99Vb8E3BIz92BdUUd6zV//JMmy+4yQ2leKFAHm/z
         0+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724271712; x=1724876512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pdEtI3O/iGeWeBxm8urkX5KxXtMLJvXUlzR+ZSGfwBE=;
        b=UAyR8t/N/aHbfO94rn7FZgBum97NWoB71e0T79vhv07OEtEyB7FG2vicMq4gKWKe+a
         rSjaxxHq1CKYH4Xyga4OW0DXob0zuyjZxcRzWp2SxtJUJFBqMGRselKPRq1V9KSmDfsJ
         om6ROtvyUA4xwVi+EM+z502YDE9+geMLrj2KIDr/SP+o7Ihu3q7VJlumWfHXgjZnb8Kz
         LjKtw9YAzXMpdh5lsl8HgFK2LAlzkzaBmxmwoUg49+aIQXUugGGtm8MO0PrZbtCaGklt
         AMGzXo2EhiomXhldOemYBpXbdg00i8fumb4HQXrfnxhWKIKMEIUS3ePu64mI9sG1Uak4
         tEzw==
X-Forwarded-Encrypted: i=1; AJvYcCWyI487mui6jIO7QELywRc2yMfNbGyO93aS2S+LTnfOjA8+ehYqErdE2QUN2+naF7amRrfwCFid/oNWh1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBaUkP0ils5siH5f31IKkbtubGJkbpzYpRjVdzgcpD6BzdahZN
	M3YKzNgorm4yWTQxOMci+/KJjg5IP+XTt/eOf8/Z+sW0p6E7KD9h
X-Google-Smtp-Source: AGHT+IGGgNc2ZGslMC/kIvseelSPc6tnyKCegD1knqA0y2M+DqC1rV3TUQh/vwMStjuMVjBFtb3hIw==
X-Received: by 2002:a05:6a21:7884:b0:1c6:89d3:5a59 with SMTP id adf61e73a8af0-1cad9ccf6abmr2400052637.0.1724271711902;
        Wed, 21 Aug 2024 13:21:51 -0700 (PDT)
Received: from iac.. ([171.76.82.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eba239f9sm2341503a91.28.2024.08.21.13.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 13:21:51 -0700 (PDT)
From: Nihar Chaithanya <niharchaithanya@gmail.com>
To: maarten.lankhorst@linux.intel.com
Cc: Nihar Chaithanya <niharchaithanya@gmail.com>,
	skhan@linuxfoundation.org,
	tzimmermann@suse.de,
	linux-kernel@vger.kernel.org,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] include: uapi: drm: drm_mode: fix documentation and coding style issue
Date: Thu, 22 Aug 2024 01:50:40 +0530
Message-Id: <20240821202039.63516-1-niharchaithanya@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix documentation and coding style issue in include/uapi/drm/drm_mode.h.
Changes include:
- Adding description of function parameter.
- Correcting block comment style.

Fix documentation warnings in include/uapi/drm/drm_mode.h encountered
from make htmldocs:
./include/uapi/drm/drm_mode.h:869: warning: Function parameter or struct member 'width' not described in 'drm_plane_size_hint'
./include/uapi/drm/drm_mode.h:869: warning: Function parameter or struct member 'height' not described in 'drm_plane_size_hint'

Fix coding style warning in include/uapi/drm/drm_mode.h reported
by checkpatch.pl:
WARNING: Block comments use a trailing */ on a separate line

Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>
---
 include/uapi/drm/drm_mode.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index d390011b89b4..bbdba76a5d25 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -147,7 +147,8 @@ extern "C" {
 
 /* Scaling mode options */
 #define DRM_MODE_SCALE_NONE		0 /* Unmodified timing (display or
-					     software can still scale) */
+					   * software can still scale)
+					   */
 #define DRM_MODE_SCALE_FULLSCREEN	1 /* Full screen, ignore aspect */
 #define DRM_MODE_SCALE_CENTER		2 /* Centered, no scaling */
 #define DRM_MODE_SCALE_ASPECT		3 /* Full screen, preserve aspect */
@@ -864,7 +865,9 @@ struct drm_color_lut {
  * array of struct drm_plane_size_hint.
  */
 struct drm_plane_size_hint {
+	/** @width: Width of the plane in pixels. */
 	__u16 width;
+	/** @height: Height of the plane in pixels. */
 	__u16 height;
 };
 
-- 
2.34.1


