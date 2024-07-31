Return-Path: <linux-kernel+bounces-268547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD3394260B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55AEE28498A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 05:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E9253370;
	Wed, 31 Jul 2024 05:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="j6OMWOjw"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FAB19478
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 05:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722405298; cv=none; b=g2tEjPw6h2OYxuieRBdtzEnXONayro4RzU8MYfYBK+wMrKVmBpEIUDsg9iUG+MqioNSxmsqkhm2jyEeGxh2yosf4B93O4JJNZfOCdFjwkhJJz/fwOu5vqWeUStocLBGfURjyfhI9XJmrHZlt75RCfsQA48K7gKL5jrhtG2dZC7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722405298; c=relaxed/simple;
	bh=cwyFIu1cSoyn0zMzWAtkwWlFKfT5rGb/RT3pVVBRS1w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tUgWFRA+6ZZJc2MJTpK6jP2H7IB4UOoqPsIKBCw6jQaWJWERX2Ihth8hO54x7KF79OoEXcksYv8HgJs/OvZqO2V41T05DQe3CaGHzSsYT0VpaI9LwvVfKEeJmZthJz6kcn+ziTvSOPqFLo2vbnLVn7olQoenQV+P5ENhlM+ipLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=j6OMWOjw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ff1cd07f56so33748485ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 22:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1722405296; x=1723010096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tKqvRSmHkIVmsY2tE+MEGPilglpL1hNRDaBy1R6HENs=;
        b=j6OMWOjw7McneSrdbgNGXXhE19oUsMFA7SM6vVWR0HcKoTgg4hdJ3DoGJaEiUi52SH
         PYVlEzUS7lrYiu56ZGS/LITPkteKRDHRUmm9CJfcd0TQgPeODaHf2CuKj3zt9q8u9P+H
         yPo3naMeO70IAn7uOdOx2feNTA1dd6M8QWtpGfqXQtLg6xz++DC1aHjA2Las3DJz2BXY
         rAskue3rqoYmcpJyP4njlu+IhgrN0gmzhxdMWmZIVwZZBQQVAadvcdHNIglXjKxbIDjH
         vmwVUBCllxPhjs5Wg729acfVWwLh7FxTOrUkzcWC0FT8/LvO0yHcAwb5VePTbmmVtE0R
         SNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722405296; x=1723010096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tKqvRSmHkIVmsY2tE+MEGPilglpL1hNRDaBy1R6HENs=;
        b=ZGaHCnFsW+5N6DoN4g1fTYRhgFShOwnjyRiKVQileKwQqCbGNL+86uwynmEGvsHz2D
         pUmzPBZxVp5MciLiTctrtXXfDzesxd6NcRoajOpVAQggwH3dXgOEf3mjPzdB+gqwLUnM
         39lA+EfutJqOM3eJk84e2NI2usuY2mkD1xA0XC/bzvbqbBeGNiW1Faj3DobJzsbSFkXn
         wesHH2cbIIn7VFv1WTL5rjYxg/XcZm49eWG4ztMqIBa5N+QdvILbtTx3Wvzpp9ZeRs5v
         zQBv+C1WRu9QjMQdu8WEXyn51mYzHaf603UyDz5T8r85On4WkIE9jRrqag+V6PSi/Qvw
         J5/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqECbQ3ksGy4Npnx8dS9BP//U9ZA5yxRFyXDju2a5/xGQNHjsMJCuc0tNjY379JS3VdFhouteU1IrT+yGFRoziKpoV3BuzDQ2Nna0/
X-Gm-Message-State: AOJu0YwgipC2BV9npqlapRyIu50s016abVpRGEmFXHwvMWKZImP8ZvS2
	c1Vw1mNWQIiSvC8ne/0mBFtDJv/p9E8pp+xTWduy8MRgfiRyy1tZVYmJGXxevxk=
X-Google-Smtp-Source: AGHT+IFhCVV0PZXpK0cSSWZ1v4yPQWI6euzChZEKm8M/bxSqMPBGp7wJxtefAjhZ7cUEpLN3KGIPHQ==
X-Received: by 2002:a17:902:ea0e:b0:1fc:6740:3ce6 with SMTP id d9443c01a7336-1ff048270a2mr147043735ad.20.1722405295409;
        Tue, 30 Jul 2024 22:54:55 -0700 (PDT)
Received: from alpha.mshome.net (ip68-4-168-191.oc.oc.cox.net. [68.4.168.191])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee4ce6sm112339595ad.157.2024.07.30.22.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 22:54:54 -0700 (PDT)
From: Remington Brasga <rbrasga@uci.edu>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Remington Brasga <rbrasga@uci.edu>
Subject: [PATCH] drm/amdgpu/uvd4: fix mask and shift definitions
Date: Wed, 31 Jul 2024 05:54:51 +0000
Message-Id: <20240731055451.15467-1-rbrasga@uci.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few define's are listed twice with different, incorrect values.
This fix sets them appropriately.

Signed-off-by: Remington Brasga <rbrasga@uci.edu>
---
The second UVD_LMI_CTRL__RFU_MASK is incorrect, so it was removed. It should be
`0xf800 0000`.
The first UVD_LMI_CTRL__RFU__SHIFT is incorrect, so it was removed.
It should bei `0x1a`.

This change aligns the uvd definitions, please refer to:
drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_3_1_sh_mask.h
drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_4_2_sh_mask.h
drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_5_0_sh_mask.h
drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_6_0_sh_mask.h

 drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_4_0_sh_mask.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_4_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_4_0_sh_mask.h
index 8ee3149df5b7..2ef1273e65ab 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_4_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_4_0_sh_mask.h
@@ -340,8 +340,6 @@
 #define UVD_LMI_CTRL__REQ_MODE_MASK 0x00000200L
 #define UVD_LMI_CTRL__REQ_MODE__SHIFT 0x00000009
 #define UVD_LMI_CTRL__RFU_MASK 0xf8000000L
-#define UVD_LMI_CTRL__RFU_MASK 0xfc000000L
-#define UVD_LMI_CTRL__RFU__SHIFT 0x0000001a
 #define UVD_LMI_CTRL__RFU__SHIFT 0x0000001b
 #define UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK 0x00200000L
 #define UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN__SHIFT 0x00000015
-- 
2.34.1


