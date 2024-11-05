Return-Path: <linux-kernel+bounces-396925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7B09BD46A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADDC41C222AC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0481E7661;
	Tue,  5 Nov 2024 18:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyf52Bv5"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2009213D51E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 18:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730830742; cv=none; b=HJXooZmyo3CxgVn4gQ50dPPBt6eUu+O1mxSc6e9EbQ8P1VkECv2G7wexoEyK+0aVfx84BwGBRHLSjVrXq2noOHUpmagt/IX4ziwJWUmNEZZ2P4pwPuUGndlK/GASKuGS6gAcVep3bqiYOO6iGr6Dnng4+2Ve4vF5+NAiP7eUCck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730830742; c=relaxed/simple;
	bh=wvRSAYs3rsDyEyx2uErygYM6LqQrDkxqRE+1X+C/K8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=c+xgqQtDxn5fvn8J6+2uoD/omuBiXQSmz4s5Ay1E6CgIXIY/Yab0DWihOvVN3Vspj31D6/X4YZ0y425DVneCE8aPHn/LKIAc0v9IC63oZnyZSF378KyoQ9TIGRccvzHf5Yj0RRGB5pkze4V/Dt4F4CyT8ZScc6rYpg0BsE3OlR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyf52Bv5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c9978a221so59377525ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 10:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730830740; x=1731435540; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gFcn89fIoB6eD8igdjIgNFL2KkUGAKDd0Xov8oHjAXc=;
        b=fyf52Bv52SNQYKC2si2T2AMNA+rh+Q83gu5URDoa9JrjyDK14p6pMr+HUzzoXfC0J1
         vmPMJDFB8SeoxQZB64bdJAtR5LOK6Px9R8JBGIIeY2oDFY62XVIzl7nk7u4MF60unxkU
         hTaUd2rQ+okrC0GENcmcL8JneKlw0Oz+hBC2dLfD/9cyPfv50DZbfnGfysKwIkdZgrsL
         Chs8dtTFTUJVyzv0wb4NacOFQtPo0nYvBIkT4lZhTCFBppx/Lz1uvsJImJHeqO0NI1aJ
         8mem99fGSGwhL7Y7qru5IB838GEYRogeKGCnmK64gANtZJPoQnZ+iZKXC6lbG+y4iND/
         lAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730830740; x=1731435540;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gFcn89fIoB6eD8igdjIgNFL2KkUGAKDd0Xov8oHjAXc=;
        b=fbptLSCacfLRuzMG2tXyACQqAwxB1z9ufpRT3NPSfbp5cQfo5JjdzoVfsN7w/lNqGE
         a1vRx+d1LIW4qY9nj/o4vjhJ4C9wwd/KgjoS+kQQs0KSQEepdL7foKN1hKbN33rj1kU5
         mihEBRJ6TV1cUakaE0oWy8XVxjZvj/EW0CHtMWapg1WFy9UXgAnzk/z/rkkSkZsY0AMH
         RpFelt8mbY6zhO1vheCjMWNMnZSrRBaDUpgAHNzpr/zMuXx8iv8lts0miYHrAljCOPWV
         OL1aS/EqilrEMbTW4pYZTzZS5Swi51XQ0NGEKlLKVUl7UT8JsPC/4MCryVr1uXGMba2S
         +SuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwwhHexZYvM1HTBcmWpil09ggFvfblciqzO5yq7oFyCEINqEKIKxKiPizEiS0frgY9ywqtC0wUvaLC+Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWsFCmaA1Y4aT3PFw2ygFrIRnb1NpwQ+7sUUYhX4xT9X+isUuX
	/cLh4v0u5eJGrnMHv76aKWGPmWMLmvN/HSP+MhtCfEadTC0CrYj4
X-Google-Smtp-Source: AGHT+IEdjJFisK8cPYnddVc07XFagAr0tosxVTWcS5kPRCLoXBKMcfxPfCn7QDkgIIIcEpVfjlfxlA==
X-Received: by 2002:a17:903:1c2:b0:20c:a175:1943 with SMTP id d9443c01a7336-210c6c6d9a5mr505410645ad.40.1730830740228;
        Tue, 05 Nov 2024 10:19:00 -0800 (PST)
Received: from Emma ([2401:4900:1c97:5a7:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a2eaasm81208945ad.159.2024.11.05.10.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 10:18:59 -0800 (PST)
From: Karan Sanghavi <karansanghvi98@gmail.com>
Date: Tue, 05 Nov 2024 18:18:42 +0000
Subject: [PATCH] drm:sprd: Correct left shift operator evaluating constant
 expression
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-coverity1511468wrongoperator-v1-1-06c7513c3efc@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIFhKmcC/x3MPQ6DMAxA4asgz41kpwEhroI6pMGlXmLkIH6Eu
 Hujjt/w3gWFTbjA0FxgvEkRzRX0aCB9Y57ZyVQNHn0gwtYl3WqxntQSha7fTfOsC1tc1ZxHeuI
 7TcEHhLpYjD9y/Pfj675/980BHW4AAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730830736; l=1441;
 i=karansanghvi98@gmail.com; s=20241017; h=from:subject:message-id;
 bh=wvRSAYs3rsDyEyx2uErygYM6LqQrDkxqRE+1X+C/K8A=;
 b=CgjOZ0VtIDWUoRD0Yf5FbUnA+DHoIVLNVlo427a5rDs+icdBvp3hgYaZkHdPJhljSvJ4rbQVc
 f3sn+bRSmulBmqq40nd9nHxjZxNGqTJ+DM2dz1H46kWlCI69d0HdsoT
X-Developer-Key: i=karansanghvi98@gmail.com; a=ed25519;
 pk=UAcbefT1C06npNVDJHdgpPqTm4WE9IhaA1fmJb3A37Y=

The left shift operation followed by a mask with 0xf will
always result in 0. To correctly evaluate the expression for
the bitwise OR operation, use a right shift instead.

Reported by Coverity Scan CID: 1511468

Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---
Coverity Scan Message:
CID 1511468: (#1 of 1): Wrong operator used (CONSTANT_EXPRESSION_RESULT)
operator_confusion: (pll->kint << 4) & 15 is always 0 regardless of the 
values of its operands. This occurs as the bitwise second operand of "|"
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


