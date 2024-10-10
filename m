Return-Path: <linux-kernel+bounces-359690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7D7998F1C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4E91F25DC4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A7219D89E;
	Thu, 10 Oct 2024 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="ERm50CdY"
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D070719D078
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583158; cv=none; b=ZhrhBEzgte31P9+Yjoit9qtigKhD18+TwCQkEA0JXU68hPWCHIvAtOQfGGIM7t3Wr/sNvNLpcU9LRztB7yh80DB8L2AXZ0RN/stvS/3puWAmrYU0oAxa2wcSMbg/OB3UBIU7bb+J0QCMtFbxTREy2fYHOEX1Mk8M2nD1Wgdfj4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583158; c=relaxed/simple;
	bh=fQf8rDamxaGPyGkfmavM2UK7fMIs3l4Vh8H8pV+bPYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wd3Xd4x8o5R8k0Sfog+qQdnf5RBm4kvWA9TKwELpR3B3hBd+OyKGPTNotqg5ZiB1bXdRA2jpWFiERSFp2AYogD1zyiMgKCJUzocVFUau+GlwTlJ6ZDMUtt8Hg0nVv88LTGStrkwGTyePvgZ2NF0IAvJHEsVFRuUNkHUkAPqOYIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=ERm50CdY; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-71def715ebdso860172b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 10:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1728583156; x=1729187956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HohBv7NFxbfPo+te4ViULrLYUWFva2jqhykRRUV9zQQ=;
        b=ERm50CdYKiEroC4Ro5klAJwqL9fCqIsbOWlWQmHevnGW+E2xk+3HjxeMDY/CQDqDGa
         yWZWWpMnZZzUDv1w/e4YwKI4AB6Tyb8D2JaPVq4dQ+LxqL+lMOVceAP2XfkwMdSlVgYh
         A42qqRBzXypteo36GDPSSX1XfPoGGwlgbl1Xf1x2vXle6n0eEkxDEKLPuq6Pb3BjuJgE
         MdYCcSlCZ/Cqmy+G1WRmGk7CWvzc3kLQD0La5hdk9Mjx8nxZWkHSA0LNt7vmqMVTtBJC
         rLqEnI2mEDxAJsntFT5MGtOFQBav7GstjfQgPbvzAPU/JP/h4nJcdqpV/jdf+5DfahKb
         Yw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728583156; x=1729187956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HohBv7NFxbfPo+te4ViULrLYUWFva2jqhykRRUV9zQQ=;
        b=MgZMdxzclQhKcYRiyZXwo/ZEYGSJIvkx5upsMU7t7DDRV74Oyv4XoE9/CK8Wg1O1+F
         nS0QmOky3+uxjGtj2OgPN3sIOc2wINqlRwL4Ry8z9lot7KH57aB9NXu5Qdptdqj9AL3H
         c4Z0k58IXLAukmq1DlG6vSAQQi5bGxeVoIj93K6sVfE7HMQzJyVMeyLePgI7UpkA5tKx
         oDUouqP256HUvv02vfLTbRQFeKYQcAaWSHCepq9nDYLfPfVg2zZgaphrEaYT+8yKp6/c
         VeY4gC6xNxNsk07VIfmcgmVy7YB5YdXt7D5J6q2wVn+L1dkikEu9ZTmboEgHbwPQRnMk
         8mtA==
X-Forwarded-Encrypted: i=1; AJvYcCXvC/EYR5GTduf7oiwctXKvTUo/wu4qQd0INoAYVnngFTh9BDSVNoXmwd9y5D38xt0/sPN7Ue+Aes9GnQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUzT/YxQ0kDQzjxPXaGYdr6tUH99n1oOWeWWsiP8gvVAyvVynC
	+GPOH5Smga+9BR5cN8gyKhM5e/1e7hL5LXBLU1qqtabR8qh9SBfoQWD6XtCZkxk=
X-Google-Smtp-Source: AGHT+IHM8zD6LfSp91c2FugBqOiUX9ORN2SdkTlo+3lW83mX/4B9uJAJGZVK0v6/Q0bh2QZsNZMzcQ==
X-Received: by 2002:a05:6a00:9294:b0:71e:3b8:666f with SMTP id d2e1a72fcca58-71e1db74ed4mr11768482b3a.11.1728583155956;
        Thu, 10 Oct 2024 10:59:15 -0700 (PDT)
Received: from localhost.localdomain ([81.17.122.16])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71e2a9e953fsm1302945b3a.8.2024.10.10.10.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 10:59:15 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: oder_chiou@realtek.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	skhan@linuxfoundation.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2][next] ASoC: rt722-sdca: Remove logically deadcode in rt722-sdca.c
Date: Thu, 10 Oct 2024 11:57:54 -0600
Message-ID: <20241010175755.5278-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the same condition was checked in inner and outer if statements.
The code never reaches the inner else statement.
Fix this by removing the logically dead inner else statement.

Fixes: 7f5d6036ca00 ("ASoC: rt722-sdca: Add RT722 SDCA driver")
Reported-by: Shuah Khan <skhan@linuxfoundation.org>
Closes: https://lore.kernel.org/all/e44527e8-b7c6-4712-97a6-d54f02ad2dc9@linuxfoundation.org/
Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
V1 -> V2: Added [next] tag

 sound/soc/codecs/rt722-sdca.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt722-sdca.c b/sound/soc/codecs/rt722-sdca.c
index e5bd9ef812de..f9f7512ca360 100644
--- a/sound/soc/codecs/rt722-sdca.c
+++ b/sound/soc/codecs/rt722-sdca.c
@@ -607,12 +607,8 @@ static int rt722_sdca_dmic_set_gain_get(struct snd_kcontrol *kcontrol,
 
 		if (!adc_vol_flag) /* boost gain */
 			ctl = regvalue / boost_step;
-		else { /* ADC gain */
-			if (adc_vol_flag)
-				ctl = p->max - (((vol_max - regvalue) & 0xffff) / interval_offset);
-			else
-				ctl = p->max - (((0 - regvalue) & 0xffff) / interval_offset);
-		}
+		else /* ADC gain */
+			ctl = p->max - (((vol_max - regvalue) & 0xffff) / interval_offset);
 
 		ucontrol->value.integer.value[i] = ctl;
 	}
-- 
2.43.0


