Return-Path: <linux-kernel+bounces-182648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 479E78C8DCB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 23:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE1CC1F225BC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948711411E0;
	Fri, 17 May 2024 21:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mi7xV7Sd"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896511422C9
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715981865; cv=none; b=FMATqh6065+Up1UAaDdkhcYUy1oTVcBWlNatnp7Ng76Ipiy0RyvyOXPARcDHdcxVDeCN/hfgsaTV1pUMLZTzUI0d1DcRk/7RvcvmjO2chI5KGHOnDDTZg2iIjiZySIwCDUHj1KcYdr0AexGX3p8kF8Uea+e+2oXKe7d4dSIk9bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715981865; c=relaxed/simple;
	bh=K70MRhubaL7E70O+JgiR7Yf5st7HgO2JT92PC9Ya7Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNHJesSh62x0MNkzDh+89b8ZJ7TTncqpcw39VdpoAt5bx2G9b1EM8Jk5XnScjWGpWEHcn0Yr3u4wfYn5xGPSZUTtH3LDwAnLyyn9BazLZuLKPeNLVcDXH+7xc5PtRxxzGXE4i+wfWMNTjy0xb7W1db4ak/p/dXqXrtCJpCMnpwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mi7xV7Sd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1edf506b216so22082845ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 14:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715981864; x=1716586664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOCpqzi3HqgLjpNBxA0mBkV791uaa9LyaeXWVqamirw=;
        b=mi7xV7SdU0Vbr7A1Nj1ysyC7NOh08wna9siJ7wD/jdJ/XrJUuheQStOR4iw+TEWI2z
         w09dZCcpa9KZDqwMQJ+wbAWAtzPslBLUL5YuylAeGWCsv+fn6QRJAhd6XUUDIftvvqiN
         hh2zn9cTSxxNLQ3Jz0UVf7dauHsPa/FzlEMo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715981864; x=1716586664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOCpqzi3HqgLjpNBxA0mBkV791uaa9LyaeXWVqamirw=;
        b=r4CgTdpKOuAdpCvglVIpAOjDpbpn4a+wYyogJrwcOIh2ih5ktdO8S5SzgXi9Dhfuf2
         ddgMtvGDwwmviRI5t9XnfET7LUy/hOX9EOUKaeb5M2M3b/gXUyRKienEwYJ+NNx4/rTP
         0S1qHqjtB4my3F7iMcq/sPgn2q/43ActyhAHWnDhHbCxgGuGOKqiVxxAGycErUjJ8MXm
         PH23ZKlsyrGsACC/Hdmf21QUthPS273smEVrmYi07NDl9U6ZeCqmu8ztvCh5UDKWvppf
         OJXO18LLQ+nFbFiArTksZ1a9AT5z6thTOZQnrrKn/6avpsk4fp6SI5xfn2bk4+V5LHHC
         lfkw==
X-Forwarded-Encrypted: i=1; AJvYcCVoJrYj0tvVlIXUFLHECt5fwmMEpy0UL+vJbKUjSSHxbRrJ7Cq2cYu4Qs10+CvRmE3qQ+pB0hg17lHeQ2eAc03kG3CHpcOCjvkTFtVX
X-Gm-Message-State: AOJu0YxOSaI36Zu8nGpY1P56YrRqVG9nPzv5RwB298TJ38HGxINhEQc4
	M8FvEwrz4m1ceuHCNDZ+K0ZPZbsXxLh6ytjUC6124K71v2gkR3ybAAC5q9JJcQ==
X-Google-Smtp-Source: AGHT+IHQeVpOpHuWwPDHwj5Y2EyRQy9AOFOGAMnBVeq9k04cNJAbxX1fcU7hJFn6i0+Z3n4aXjp8KA==
X-Received: by 2002:a05:6a00:1ad0:b0:6e6:9f47:c18c with SMTP id d2e1a72fcca58-6f4e03858b3mr27717561b3a.33.1715981863806;
        Fri, 17 May 2024 14:37:43 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:26de:b1dd:5:771c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b2f8b3sm15168736b3a.211.2024.05.17.14.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 14:37:43 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] drm/panel: ilitek-ili9882t: Check for errors on the NOP in prepare()
Date: Fri, 17 May 2024 14:36:40 -0700
Message-ID: <20240517143643.5.I323476ba9fa8cc7a5adee4c1ec95202785cc5686@changeid>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240517213712.3135166-1-dianders@chromium.org>
References: <20240517213712.3135166-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mipi_dsi_dcs_nop() function returns an error but we weren't
checking it in ili9882t_prepare(). Add a check. This is highly
unlikely to matter in practice. If the NOP failed then likely later
MIPI commands would fail too.

Found by code inspection.

Fixes: e2450d32e5fb ("drm/panel: ili9882t: Break out as separate driver")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
index a2ea25bb6624..266a087fe14c 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
@@ -478,7 +478,11 @@ static int ili9882t_prepare(struct drm_panel *panel)
 	usleep_range(10000, 11000);
 
 	// MIPI needs to keep the LP11 state before the lcm_reset pin is pulled high
-	mipi_dsi_dcs_nop(ili->dsi);
+	ret = mipi_dsi_dcs_nop(ili->dsi);
+	if (ret < 0) {
+		dev_err(&ili->dsi->dev, "Failed to send NOP: %d\n", ret);
+		goto poweroff;
+	}
 	usleep_range(1000, 2000);
 
 	gpiod_set_value(ili->enable_gpio, 1);
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


