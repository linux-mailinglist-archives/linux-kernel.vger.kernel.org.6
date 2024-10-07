Return-Path: <linux-kernel+bounces-353646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2372A9930BF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA608B24CD7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024511D90BE;
	Mon,  7 Oct 2024 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DL6TvRqT"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158011D4152
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313759; cv=none; b=kTse2kxl2QY+5nHS/Zo3mp6PfnfmrmGpcSO474pVgquOWulTK2MNYOKAnZsbbMOtm6LqMlVaDkBjYWNSgPosDklgFOWXPq8pgvgPDNWiaXbBWeWhgF9Ia+9fCNJNymNfWsHyLKpBa59IHz+JJHuigSw5n4gdL+E+7UzTPrzJyGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313759; c=relaxed/simple;
	bh=ZkPECxgEeA2guXCbGft7A0EbWEevf+c0gjJj9QsLsfY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cz+rJYP529dtXanzwQQceoEIVBWJwtgh9VP1LVoh1vh3T0xJ+aqmHapTb3r+qEgpqn+OVWJklrFm/tMT5xTc3Dnu4oGeMVl5EFdM0zSq4S0nUxMEjQPjCEfO7b+ZqJLa/1/+6iPgp5bW0990lHjk4Ju71axvG0UHIqxBVDOnd/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DL6TvRqT; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71dec1cf48fso2506737b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 08:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728313757; x=1728918557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U/+GSwCeOWRm/l1+CfEkkyplSY7a0N5EITYY7LFjoig=;
        b=DL6TvRqTaz0Jx0h89wqItnb4iMzDudSJhNKOifEuEmTooJJUjt7SDOxE3W1jM7u17v
         VchIf3/R+l5+Tp8epzf0bc7mYnZgz1ZZcCYGfG/rlpbB1xMqyz3B0zcj4m+PmFt0KRQx
         NCcp6FQLeSN/BdOJ81sOlawSDtwaD8ZDTl9aYDw6ryoa3s7ediDq8YxO4muXXA6xrRzq
         BYYcsjan8S5sPDK751WusZbvaujSIqqbkFEuLfo3LIomank1jzG+eGYeMUeLCxxkhTJ5
         kEAgO8VhOp8i94h4s/6ALG3Irtj9CaB1pqjMjU8wTUtlFkmrMgx64jgfRkqlPoHlXu6W
         QFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728313757; x=1728918557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/+GSwCeOWRm/l1+CfEkkyplSY7a0N5EITYY7LFjoig=;
        b=iBGsrLzrGoaw4mJVfgW0NmHVURBjkZrqVP7asMCoxBxjdf5Wi93J+e1dnuSxtFSCey
         EbzAoSYb0lZ688XQogiltpPNrhSGB288gDRwIDh/Ll6TKAz9F7JC9pR5nXtN1lnVnPsp
         ypY9UvlggKr6XVrxBmuJa1lSvBsVG+4SoMNpNYqyS6XI9EcnmHf1SOAZcLKabMX0MuH5
         jEV4IF5SvtSfR2z/3LBXt32Ti+uok1Ncmo2uEMwjv5dNyhm64RDHrDF2gmCAdeU9pozC
         KjCCSkobIRotfbcuOnBY1x3D6RVIVELzvjTPPRqRqKnFCbTFt1h6RHXSrX84+fzNjrJR
         QTkA==
X-Forwarded-Encrypted: i=1; AJvYcCVuSxfN9X38mYynsWc/aJkG/sjfzRVr0kY0VTPzEPi2+StAX02tc0Mx7Zc80H8dNidBPAXwO/6XuSNasUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbvsh9FOObza65pbCVk66GiyhfqgkrD1tA+AMc+a76kbUpeBEu
	zQZhfyn0JPvswdntGuvrROfLGdm0QUZYKV09z5d6fkQEl5c7TK18
X-Google-Smtp-Source: AGHT+IFyaIcmre3vkQABIM8yyNZlEuDS9Fnfn9Gk+ufQWVciOVuxyxkAe1vCDGKPdT/UvjtIoXMFog==
X-Received: by 2002:a05:6a20:6f07:b0:1d3:2976:144 with SMTP id adf61e73a8af0-1d6dfafc08cmr16632114637.44.1728313757227;
        Mon, 07 Oct 2024 08:09:17 -0700 (PDT)
Received: from advait-kdeneon.. ([2405:201:1e:f1d5:ffb9:ea:f539:1909])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c3411asm5011809a12.68.2024.10.07.08.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:09:16 -0700 (PDT)
From: Advait Dhamorikar <advaitdhamorikar@gmail.com>
To: Sam Ravnborg <sam@ravnborg.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com,
	Advait Dhamorikar <advaitdhamorikar@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH v2] drm/atmel_hlcdc: Fix uninitialized variable
Date: Mon,  7 Oct 2024 20:39:04 +0530
Message-Id: <20241007150904.9840-1-advaitdhamorikar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

atmel_hlcdc_plane_update_buffers: may use an uninitialized
sr variable when the if condition remains unsatisfied.
The variable may contain an arbitrary value left from earlier computations.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202409240320.MZPgi3Up-lkp@intel.com/
Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
---
v1->v2: add reported by and closes labels

 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index 4a7ba0918eca..4150c4d0b4f2 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -559,7 +559,7 @@ static void atmel_hlcdc_plane_update_buffers(struct atmel_hlcdc_plane *plane,
 	const struct atmel_hlcdc_layer_desc *desc = plane->layer.desc;
 	struct atmel_hlcdc_dc *dc = plane->base.dev->dev_private;
 	struct drm_framebuffer *fb = state->base.fb;
-	u32 sr;
+	u32 sr = 0;
 	int i;
 
 	if (!dc->desc->is_xlcdc)
-- 
2.34.1


