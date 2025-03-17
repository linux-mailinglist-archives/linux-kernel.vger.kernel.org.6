Return-Path: <linux-kernel+bounces-564769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD455A65A4B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827891648A0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2034C199EBB;
	Mon, 17 Mar 2025 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="dg7AvUsE"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE65E1FC7D4
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231617; cv=none; b=kj+1/T42kEEgaf/ltFZL3lP1s9mlI39MafpFaRf37U2gIiqBt3aHLgfwCj4lqT+Rpylmg7noUCYE7/auRMWHRnM6TFy1oh+SihIkuU3/MfY4n0SaSMkQ3zljorCdZOtbKq2kahPZ9rJAzKRXi+vscXu5kT8hCEBW2vhyA6iBWpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231617; c=relaxed/simple;
	bh=/PhSLHjROc73cBrttIeJVRJfk7frKRuzF6sp6s4Lcj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WzFO1pSVd8n+puTlxIAARa1QKB7V+3EAMiZ3R4BFBwaHvIbi3yGiqZd+qFTuJpMJbHZ3GnwZX+hVFvwtm1qI1OUjBcweL+o4dET6Jxd7+PLqpj3venbo0TwryMEm5CPoDwPqhOatEmel6f4eXrvWMPY+KYnTo5QPiyRfLFfSzIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=dg7AvUsE; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-390e3b3d3f4so2803761f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1742231614; x=1742836414; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7fMIytW0SxfPTGP9LvPWkChZq/hvsCkhhTHxMZ6OSLw=;
        b=dg7AvUsEJ/EVnIymMSypm3edND7apl5j1Y48GAo0U83l41qRZbnylKCtiwbfVdLB3K
         VJ3x0cJxmZ7Y6E3m02AsxgFcEF84tm1mD6AvbMGhyjks4jxxpvCu3yXP9MDPNbZ6XENd
         iNSGHOLuVJ1KzwqIRjHEkhStAtYlu3SJMRTCVy/13KJdbaKFL6TvLfZNdu0AvJllx60m
         WPSthiLLetLjFKpeAV07fguvTMbPEBhQEHPFcsFEDR2FZaqHg5KhwmCL2sR6GLN9QRe+
         YzMkzVxaX0U0V6zFIazXloA0ZnsaszTs4aDF1OzNFJOe8bpjDO1QkQy1ks1cBdj2EZKF
         GftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742231614; x=1742836414;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fMIytW0SxfPTGP9LvPWkChZq/hvsCkhhTHxMZ6OSLw=;
        b=vXFo7qYfONqG9V7v5pmgilg84Mh3qJffD2AMHcP5AHfRYHonnTkT8qKWwuCYuBEVgg
         SFkIYejS4OPlQRmXnXdIwCz0Phpz4bnKyTFW6VA4QQuEZqIXZHKNYl2f7NbzHBWohP9r
         16tvnlEl4ZVf47rax5Wh6OAf+Cj93NFoTHr8hW9gifySgznZpYWcCWpnLrMWqMZ3QqXq
         BNkb+oDHnDGZjlQ3mhlXZfwAai0lT3eg8xeFUj23murN+4bOSUVkQWcBnyw6xiVs9mgc
         OOewWJ4BxLMxtXisgvnkz3ah+j8Ssl9NpyAqIwZ+J5NHuFWlPfU83/Cq7ogh0FzieKVi
         8Azw==
X-Forwarded-Encrypted: i=1; AJvYcCXNY7r4o+FYC5edkth3Q3uFfQAVl/F88Yyh50Udro9BvwkLYH9qkstN5WmG5HGx/anE6xIDsuIEx+joYbc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1H+QjKprSP2mXpHkSfkj/9J7FEHARZfS9g60tr7QAR3HZFE0V
	kfjlLPr/dNw+FBX8hUAi3Wq/zUBm6NmmQIQ+LfLL99IKKQHpadPNtYpNdsZW7AI=
X-Gm-Gg: ASbGncszjoqbkgv7C7mWrPm177Yo3IGAjrfwXc/xCYjiW8IP640Byrb6EHOMaT45rO6
	P3+dMxXxeMa5ebtJ4c1A+HUTamIHSLyl/5vLKvwSD+WnqjWya4eclvzUXQQ/VzjrAZQ4XLzeV7J
	AkiYlyNUilpot5f0KUH8R/MA4WRoSGUwYd1Ojb4LOLl2tcIsBWQnMrQIaYzOPyhpuQWgHqV4DRv
	TK9uAQ4h+xp16US/vw2WBHB6I5cGuprRzVwXHt0z9C4f6YbaXqbT8OHqnSPDq7K7Z34ZLO7HqY3
	kp7+CbB2LGPblGyJtFsD1mtdQXnry5q6TA==
X-Google-Smtp-Source: AGHT+IGkP+dmpLKkzo04mu9JfjO/ZA5KdaifD/QSaC1iHJgfbvWe2OU5XBzjuXxpITQViZF/cOe/8Q==
X-Received: by 2002:adf:9b89:0:b0:391:3fa7:bf66 with SMTP id ffacd0b85a97d-3996b46892bmr399853f8f.31.1742231613968;
        Mon, 17 Mar 2025 10:13:33 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fdda15dsm112003365e9.3.2025.03.17.10.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:13:32 -0700 (PDT)
From: David Turner <david.turner@raspberrypi.com>
Date: Mon, 17 Mar 2025 17:12:23 +0000
Subject: [PATCH v4 2/3] drm/vc4: hdmi: Call HDMI hotplug helper on
 disconnect
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-vc4_hotplug-v4-2-2af625629186@raspberrypi.com>
References: <20250317-vc4_hotplug-v4-0-2af625629186@raspberrypi.com>
In-Reply-To: <20250317-vc4_hotplug-v4-0-2af625629186@raspberrypi.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 David Turner <david.turner@raspberrypi.com>, 
 Stefan Wahren <wahrenst@gmx.net>
X-Mailer: b4 0.14.2

From: Stefan Wahren <wahrenst@gmx.net>

drm_atomic_helper_connector_hdmi_hotplug() must be called
regardless of the connection status, otherwise the HDMI audio
disconnect event won't be notified.

Fixes: 2ea9ec5d2c20 ("drm/vc4: hdmi: use drm_atomic_helper_connector_hdmi_hotplug()")
Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: David Turner <david.turner@raspberrypi.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 37238a12baa58a06a5d6f40d1ab64abc7fac60d7..37a7d45695f236d3ab281d9a8676921fd434955c 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -372,13 +372,13 @@ static void vc4_hdmi_handle_hotplug(struct vc4_hdmi *vc4_hdmi,
 	 * the lock for now.
 	 */
 
+	drm_atomic_helper_connector_hdmi_hotplug(connector, status);
+
 	if (status == connector_status_disconnected) {
 		cec_phys_addr_invalidate(vc4_hdmi->cec_adap);
 		return;
 	}
 
-	drm_atomic_helper_connector_hdmi_hotplug(connector, status);
-
 	cec_s_phys_addr(vc4_hdmi->cec_adap,
 			connector->display_info.source_physical_address, false);
 

-- 
2.34.1


