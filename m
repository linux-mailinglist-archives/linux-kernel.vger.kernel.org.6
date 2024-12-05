Return-Path: <linux-kernel+bounces-433669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5B69E5B6E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D8F2818DF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F261222587;
	Thu,  5 Dec 2024 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="L8RhMPTp"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A50221453
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733416210; cv=none; b=mY51lxEJXTJb7tGuvQ1kF1PKyKGr6np6SHYKRJhtziZDIoGU3Wy0UxeHIkL+fKyHO9sQOGiUjy4sxR8mMtSxIsYg9ISZeJJotSALHUihBMsaLNVYFetGNe3mLS7Ph/LRRk7f7HFS0oBf/SI1VtEcm0MlgFvuJdRgHCIsWWrQync=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733416210; c=relaxed/simple;
	bh=z7WweRdQheGI3pzAwFkk9rNTL8TZfEB+/oDFKzELXm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tv3NIip6/Nb1xxL9MUqZZPOnXo3vY6zPKmbrp/HB+wbIUfJTLKqZaTvXlmbCK8SrFDMwxQRuJjIrgqYcMItdsGNJyQZ14+15cWnwI5E1B+QgfATzh7VAJmvnQoScLnVvKwx2cKtxDb3b98jL1IHxwU+k34M0XB7BCyL89G2wB9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=L8RhMPTp; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ffc86948dcso11347671fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 08:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1733416207; x=1734021007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMjnh9e7Jw2TD0W4BB+OtBZvaU7qr6SdoxJVRCE4W9g=;
        b=L8RhMPTpQUqfKc6ho0rzMLP1NVxa08lqVzHxFV7A8gtS7rBfhyRH/dqzweDFlw4iUd
         tPmPhtUk/nS5BbNZA6ec9jEq8jS656lW6RvSwd6+lp+XKPxgbZHaYEe5jnRGxP1LwK3T
         Kmw0gHRzbp2WBwya03sspWACdixf7HueCGkc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733416207; x=1734021007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMjnh9e7Jw2TD0W4BB+OtBZvaU7qr6SdoxJVRCE4W9g=;
        b=uCONnh4H5rZRHDU9mmZXno38QVt92WEY84UpyGMKXInlSJNy7mkcxRldqc8eqEjhAz
         3lx/UU2ziq6pZhFLCjoi9iUoTCIkCpJpYKNOvpXR3gYLYbctQdCvNiqybQn+nAehI7tB
         gp7hyedKYF/tUjyic7LAvbTtYUCu2VqisETYPTaWdxU3JJeS33oftSOT9sR1C5mEQBUN
         sJSPZfy/0mbjiFyDPDpf8zDv8ZC+uLeP9hHCyGvPrls2N2teV9Zc/VCN1BsvyoMmkNbG
         bGElCLvPJFXaT5v2V3/l2XpVpUXIPde9uBnM7LqH8uV0WWl01AeE088U4FmBpwPCRKmc
         LcaA==
X-Gm-Message-State: AOJu0YwVKf1xyIh4GqR4RBGdXyC7uF++a95S9f4a1BxeYg5Bu92QviHH
	s9KhQUPJ15k1erVcF0eUPJQEqdr0x9o38gSYm6p45jKvsrJiXpjSR7qmMrJyREO+NPV+GY0x1Kl
	g
X-Gm-Gg: ASbGncvuZPrDtdI/SnkDhhqrxgGQN91ZjJiBU284N8hydnOT/RlKxi/CZZh4NkkLF2i
	45dQiJ11kDTjiwGGwkbRvDBnB+2X3ZHCG/pMSGeQgRucaMomZbYDh+Q2nFjs5c9swdvMTD/0WTh
	Izo9s7fh3plMXUBB9VhzcBqV+cH6UIP5EDkeyEN2dtMdOu1eXNM3SIxXTvgIUJy1xgpfqEk0VLZ
	oTc71j5ITvF3g1LLBOInkR4pe5dSyYkULjucAeCMncfyEtno8l2UyM1ZdastxQ83TAlC4bUtS0n
	yqAlKJwP4u7beOEXSJlJ2emPFrxHseC45XHIOhA/4h0+fQ==
X-Google-Smtp-Source: AGHT+IFJFphPXj4RdWmYd4xFSWADfTEFl4LH/PWBW33N9COMCHipijXzOhDtWi1Bbu0TITxO8K7CKg==
X-Received: by 2002:a2e:a907:0:b0:300:8ff:d93f with SMTP id 38308e7fff4ca-30009c50cb0mr67442741fa.22.1733416206629;
        Thu, 05 Dec 2024 08:30:06 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2001:b07:6474:ebbf:61a1:9bc8:52c6:3c2d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14c799219sm984973a12.55.2024.12.05.08.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 08:30:05 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Subject: [RESEND PATCH v2] drm/panel: synaptics-r63353: Fix regulator unbalance
Date: Thu,  5 Dec 2024 17:29:58 +0100
Message-ID: <20241205163002.1804784-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Trimarchi <michael@amarulasolutions.com>

The shutdown function can be called when the display is already
unprepared. For example during reboot this trigger a kernel
backlog. Calling the drm_panel_unprepare, allow us to avoid
to trigger the kernel warning.

Fixes: 2e87bad7cd33 ("drm/panel: Add Synaptics R63353 panel driver")
Tested-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

---

Changes in v2:
- Add 'Fixes' tag.
- Add 'Reviewed-by' tag of Neil Armstrong.

 drivers/gpu/drm/panel/panel-synaptics-r63353.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-synaptics-r63353.c b/drivers/gpu/drm/panel/panel-synaptics-r63353.c
index 169c629746c7..17349825543f 100644
--- a/drivers/gpu/drm/panel/panel-synaptics-r63353.c
+++ b/drivers/gpu/drm/panel/panel-synaptics-r63353.c
@@ -325,7 +325,7 @@ static void r63353_panel_shutdown(struct mipi_dsi_device *dsi)
 {
 	struct r63353_panel *rpanel = mipi_dsi_get_drvdata(dsi);
 
-	r63353_panel_unprepare(&rpanel->base);
+	drm_panel_unprepare(&rpanel->base);
 }
 
 static const struct r63353_desc sharp_ls068b3sx02_data = {
-- 
2.43.0


