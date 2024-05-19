Return-Path: <linux-kernel+bounces-183019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7431E8C9356
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 05:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 315981F21452
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 03:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BA4B666;
	Sun, 19 May 2024 03:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0I/NpPw"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6305239B
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 03:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716088252; cv=none; b=YXoxRlUrbuf6xuYRpalint/IH/zyMEgPAQijIQ8VH5LGfSrJUlzkaOcpJALPzovZSb/ARnev3rXrpn4SDRtQtD7C/n6sGQasz9TdmMs/jNKnPrmjL9xeDV9LaaFRCq8iVvv9cEUadCNRIMfRlK300FKY5H/oYHjlalXopT9JgpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716088252; c=relaxed/simple;
	bh=FfVJpGlO6teYrVFymUL/fDGFO5nzBWhZE9cAJVX36bw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=robWDm2l4qmxsXmZb78MrX14RiuUuIrKfRSq7TQQWmnBfWgN4EfKgmjnvAsZp9ysXOfs7+dr4cKx9NdBMofIJb+FwkKolo09BilJzzH42MGjsmReU2GrPt/qsS+yXA/KCXcOEgKuMADconKlQgRQgCE+qOiMHPD0IBZ8nVmijLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0I/NpPw; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f4ed9dc7beso1790491b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 20:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716088250; x=1716693050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lFSZbZfTC226eQMjp0sS4xniwqBXpfweUGcjqkUYZ2I=;
        b=B0I/NpPwmHHVG3qo/7pGWaoGmOMvWhTpZXlK372vaIZdSESHds+2aXXlSyegj64sas
         2gK/Yzg5BV62lkbTLq4BP19AfMdGfGep/N1BR1FvNgZ0gB8IMrNu0R2++J5f3fxZyuQy
         K3eXp83acKve/MlXqSYElv5f9YpHeuaJC8f37wwgYNd4kvTH0xNYJ8vttaDfoDAs+mCL
         iT0Ky5JrUIxUMLEHQY9CyxdGpVzbntZuMVxEgeqgSl4+iiGPETwx01YxKp6SWBC8yB4l
         BF6UUsAsFvQfX4yrrMExAeLibd9STTeIMK3VQiqrlYPBUu5aQDyIcILrGR353gkErPMv
         VfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716088250; x=1716693050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lFSZbZfTC226eQMjp0sS4xniwqBXpfweUGcjqkUYZ2I=;
        b=nb9aXPaooLrZh0II+wLII1Uefou6gEKvYBFBzH0tGQycwTwlBdlU0J8Ag9/+rVCOcy
         Y3G2H7qm7I3eZp7jvjMUOhXO9jJ6oXYZHfVw5Gpmosz5nx8kzkCUK1UxK63W7yls0BJF
         IvP+Wy8NmALPRD8x8sTzXOA/OExc7S/e25iULr4bqILGPs1a0gFXAvTijmKOixBQu4xP
         3Ro+l/Lvb5eT1BdG0A8AFy8+w/JGkeK9cfi7t3yOZM5US3cl5YmjlBwZGEUUTz89lpAA
         N/riY+HY1+ywHu285lA8n45Ld91+4tSp5nYvkuvBS0+MlAYly49kKJmZHeAL0FQWyE6/
         IfLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSMQ2snnQsZqKhDRY/LXbYcYsIVtc1/7Ff8aVTtN+lm88/WqMcvCqEbCrhUSls5f3YEQwQs+RQCTnSamd1fxhHl6PcaXGgHWBM4o+3
X-Gm-Message-State: AOJu0YynEQYMKPKtFzNAHay+PlJKlkhwiG08I0n1Wz2T148hcqPilvoQ
	1LBEb6KCtOkKfMnucsy/LZ0v35g8ABTzzW43BJHKFfq3RajITGG2
X-Google-Smtp-Source: AGHT+IH28eff2ZIUcVS0Dp/+G5i8Aj5IcetQJoyI2wjeZ1HW4+g7K+rPcKbEzCzdIFGIFMoPbyHv4g==
X-Received: by 2002:a05:6a00:398d:b0:6ea:dfc1:b86 with SMTP id d2e1a72fcca58-6f69fc15becmr3972824b3a.12.1716088250419;
        Sat, 18 May 2024 20:10:50 -0700 (PDT)
Received: from mari.. ([2804:431:cfd3:a689:b983:dc6d:a9d1:7485])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6677f912880sm1025131a12.60.2024.05.18.20.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 20:10:50 -0700 (PDT)
From: MarileneGarcia <marilene.agarcia@gmail.com>
To: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Imre Deak <imre.deak@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>,
	Douglas Anderson <dianders@chromium.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: MarileneGarcia <marilene.agarcia@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/dp: Fix documentation warning
Date: Sun, 19 May 2024 00:10:27 -0300
Message-Id: <20240519031027.433751-1-marilene.agarcia@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It fixes the following warnings when
the kernel documentation is generated:

/include/drm/display/drm_dp_helper.h:126:
warning: Function parameter or struct member
'mode' not described in 'drm_dp_as_sdp'

/include/drm/display/drm_dp_helper.h:126:
warning: Excess struct member 'operation_mode'
description in 'drm_dp_as_sdp'

Signed-off-by: MarileneGarcia <marilene.agarcia@gmail.com>
---
Changes:
This documentation comment should refer to the name of the 
variable to solve the warnings. As operation_mode is the 
name of the enum, and the declared variable name is mode.

Thank you.

 include/drm/display/drm_dp_helper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index 8bed890eec2c..8defcc399f42 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -112,7 +112,7 @@ struct drm_dp_vsc_sdp {
  * @target_rr: Target Refresh
  * @duration_incr_ms: Successive frame duration increase
  * @duration_decr_ms: Successive frame duration decrease
- * @operation_mode: Adaptive Sync Operation Mode
+ * @mode: Adaptive Sync Operation Mode
  */
 struct drm_dp_as_sdp {
 	unsigned char sdp_type;
-- 
2.34.1


