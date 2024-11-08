Return-Path: <linux-kernel+bounces-402047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6B59C22B6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2729E2858DE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F181991D8;
	Fri,  8 Nov 2024 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VR6mA+5p"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1AB1DFD1
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731085891; cv=none; b=Zk0+Twll1SZ9tJeIUFP9Y7rpHHd/vBIcSFUo+7uo+SjkvGmgk1763TQhWkXY29RjsDCf99bVZp6GzYphBTYmIaJqAoBD/uIwm4sy8/Q9D59y4c5E9iJpErHEcCJfz6Uo/WCfn/W2sDIF9NRkftRTAuzAPtHrz+F/nS0Q+wYe8Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731085891; c=relaxed/simple;
	bh=3G6UuML+DndvasPONfiQQ4xb46RlhGddyxDqRIE9TKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jOfj19pes9+yl7ypVQBPL2jqJ1gMVh/gnRJ29cO0OWb9KwuOvwQBSFnQrIJCdy298lx3suWx6bergVhFzZrPzUhl00zsah/JjzUINMHLUaaWTq4pHKMYLLPm9Hv7IhwaOY2jSjl88NaPn3twvjP+vCoXhlfn4Y+Jg26gRtB9VoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VR6mA+5p; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cbcd71012so28724125ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 09:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731085889; x=1731690689; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sbZQNMHhnIDB6LlVrWgRtNHZEDlsEUv5saNArVcX6Ww=;
        b=VR6mA+5pnlX7Wjoch7c0xSCSltg2oxplwTNDZXKD4EXrQp9/7NsSJbv2bVkRr8b9BX
         axuI/1T8k7dSHs+Z6jHACH1V/hK8GBVC8tNNK14gYysYgHKFln+xaxqZIi5M7BgbK0Ey
         JfPbuFAVVUzNB0s7MBeKHIPEiYp3zZfqWUtD0x82Nw44iYgDDvYOqffVWxyeQrbSXOf3
         j+fCl2kc80XCoItkd3ZWLky3O7+zwyUJaaAE2Bhgca73Xy1l24LlcGMkCG8k9BkNcq94
         llFzXvzjPSHDyd1UXZ+FDxkRFPF8i6OlXFOhYnlIdD4ttJXEL1pqg5YJXYCrgZ/gsoQx
         O2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731085889; x=1731690689;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sbZQNMHhnIDB6LlVrWgRtNHZEDlsEUv5saNArVcX6Ww=;
        b=ZoT+4JBW+8spflEwJmu7ER/BHvIgRWjaIBXw3xsYZMMJav4ICCOddeHS0NzcbBj3jF
         fR+6sfkjywYxyfQduiY6WdvnHjKDs8ZKf15cBHYz8kwh7jo5vi8PRwDRAB+nd1tvNY5+
         T0gVOxGaBsS28o9x5zFXb9b+tDgorbq5wcRK6U9aijDI7c+MXjtzfwu++Bxh48Nli1SB
         TT6XVqi84AWwiHA/Xbg4Xmw9qW/iAbeAgYgZSqzieOFYPlUabwUpLugdIO4xNUczWu6i
         shCZTgXtwKgvsiGfgtm/dSXTtTUeBvnTvxYT62kIAePCNs+DZYqatj/i1/h7rCFsAYsX
         55Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUDSsgw4y4CVofErpfPZyZkXfwnateu2h0e13VuDRYOjle5Xrq7EecYkn/quKXCDbXfWRzdKaHQZvkAiFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuofWkwZHXDDivLnsK5+o6YnsyqPUcK21SMmdbLSVGyWr3EI94
	WYcMdxJyX7+ksU1iCs9GSqyCjozFClhM5cyl0GWYvTUHYmLfPYcJ
X-Google-Smtp-Source: AGHT+IGFbp0sHbQZd11U8+WwenFkCpy6wg1vmNsP61MUgFATPEkF5h7IluGfoZGyBt4EiXPIDEnnwg==
X-Received: by 2002:a17:903:2344:b0:20b:5aff:dd50 with SMTP id d9443c01a7336-2118354c06fmr41686595ad.31.1731085888979;
        Fri, 08 Nov 2024 09:11:28 -0800 (PST)
Received: from Emma ([2401:4900:1c94:8072:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e580dcsm32877555ad.190.2024.11.08.09.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 09:11:28 -0800 (PST)
From: Karan Sanghavi <karansanghvi98@gmail.com>
Date: Fri, 08 Nov 2024 17:11:25 +0000
Subject: [PATCH v2] drm:sprd: Correct left shift operator evaluating
 constant expression
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-coverity1511468wrongoperator-v2-1-72bc73d8691f@gmail.com>
X-B4-Tracking: v=1; b=H4sIADxGLmcC/42NQQ6CMBBFr0JmbU2nFDSuvIdhgcMAkwglLakS0
 rtbOYHL9/P/+zsE9sIBbsUOnqMEcXMGcyqAxnYeWEmXGYw2FlFXilzMi3XDCtHW17d38+AW9u3
 qvDIaS/2kzhqrISsWz718Dv2jyTxKyLXteIv4S/8UR1SodE2XCksquaf7MLXyOpOboEkpfQHCz
 lPayAAAAA==
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Karan Sanghavi <karansanghvi98@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731085885; l=1718;
 i=karansanghvi98@gmail.com; s=20241017; h=from:subject:message-id;
 bh=3G6UuML+DndvasPONfiQQ4xb46RlhGddyxDqRIE9TKU=;
 b=Kby/pcYTxftsv3VbDajY2CBoB00Y5NWKrGexQkX2nxR8YjhQO5Ij8h+/H9mDAO4jGppDNjo1s
 GFoMvSsoPfUByMjhWOT2LyQ4Smez6ncwvOBQjujE7Fq2NE7NHLLJ3iZ
X-Developer-Key: i=karansanghvi98@gmail.com; a=ed25519;
 pk=UAcbefT1C06npNVDJHdgpPqTm4WE9IhaA1fmJb3A37Y=

The left shift operation followed by a mask with 0xf will
always result in 0. To correctly evaluate the expression for
the bitwise OR operation, use a right shift instead.

Reported by Coverity Scan CID: 1511468

Fixes: 1c66496b1391 ("drm/sprd: add Unisoc's drm mipi dsi&dphy driver")

Reviewed-by: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---
Coverity Scan Message:
CID 1511468: (#1 of 1): Wrong operator used (CONSTANT_EXPRESSION_RESULT)
operator_confusion: (pll->kint << 4) & 15 is always 0 regardless of the 
values of its operands. This occurs as the bitwise second operand of "|"
---
Changes in v2:
- Added the fixes tag
- Link to v1: https://lore.kernel.org/r/20241105-coverity1511468wrongoperator-v1-1-06c7513c3efc@gmail.com
---
 drivers/gpu/drm/sprd/megacores_pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sprd/megacores_pll.c b/drivers/gpu/drm/sprd/megacores_pll.c
index 3091dfdc11e3..43c10a5fc441 100644
--- a/drivers/gpu/drm/sprd/megacores_pll.c
+++ b/drivers/gpu/drm/sprd/megacores_pll.c
@@ -94,7 +94,7 @@ static void dphy_set_pll_reg(struct dphy_pll *pll, struct regmap *regmap)
 	reg_val[3] = pll->vco_band | (pll->sdm_en << 1) | (pll->refin << 2);
 	reg_val[4] = pll->kint >> 12;
 	reg_val[5] = pll->kint >> 4;
-	reg_val[6] = pll->out_sel | ((pll->kint << 4) & 0xf);
+	reg_val[6] = pll->out_sel | ((pll->kint >> 4) & 0xf);
 	reg_val[7] = 1 << 4;
 	reg_val[8] = pll->det_delay;
 

---
base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
change-id: 20241105-coverity1511468wrongoperator-20130bcd4240

Best regards,
-- 
Karan Sanghavi <karansanghvi98@gmail.com>


