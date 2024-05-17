Return-Path: <linux-kernel+bounces-182645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 876728C8DC8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 23:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B284EB2340B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA0F1420C4;
	Fri, 17 May 2024 21:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eiyZ9J5U"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6366A1411FE
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 21:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715981860; cv=none; b=KaYtdPoEqn/1d4IkVEPnUT+SEk9CqjdzRBrfXvg2ACEn49C0tovfWRfDevJItASDbAUadyIFE27+yWCA9ozE+unvpDUdzmPHwbqREpMVADwHn9qSGn3zHAx++/+/ZtRt/vhhzFbMRuey2SlXYdnhIJeT954E/eA7WmsuND3A1Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715981860; c=relaxed/simple;
	bh=aVpIH2UqSqo9VK8FTySoOzXmbprOkeQDUcwtLW84ErY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRUIqyS5NkL6aU9kmuYVaZ6bOwn/hSX8ZyMH66vyzjqy+rGb1sf00UsaDt5jYDVCJf5EtrlbRJ2PY0pdm2YxWc+H5z7uc6RaZevyn+N0GbDOmO0PHHjdxxxXQ8shG91QnWLxpiMtio/jdo31LOo/X2vrRhWGa1r/EM8JtRN1gvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eiyZ9J5U; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1edfc57ac0cso21853035ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 14:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715981859; x=1716586659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otBGDKVA9IXvnt4HBmF8aixiY7lsB5c27hifCvrdcgw=;
        b=eiyZ9J5UfV5CGo2CWc0DjXlttxnuSWZLKob53LoPoynb1dRCUHN9s/47dZrC/CHCr5
         e5laxk8piybK8CEK7lc43MCML9Xfj8iQETPyAIv5ul17JL2yjMhLI1VX16IRe+l/745S
         Rx2YZ5GtY0Gludni/JyvVDUcgjhmb5VrgGFh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715981859; x=1716586659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otBGDKVA9IXvnt4HBmF8aixiY7lsB5c27hifCvrdcgw=;
        b=LxAAYNkDCIMixjh3vx6znfDv1xTRpNBwd56Hcol9kKG1b5OyGm0fvRNb0vgYxUcJKy
         SzLDt1P679PysG27HLo4+LIdjenZ1xt+daMkF7dG0lkdNtGzhbxnX8CWekaxayQe8JbZ
         VkR0z9OfLu2TpL8SMArlxzUv8291phPFy+glzBchq7CFh1b/OoDDw3sDqK2O1z+zWjJ1
         iTCfvCmevlfoF1SG12H5j/K8CMB24URU7E5wtOPZqaMD8LgFD7gBgp+rDYXrPzHldqw8
         CzA4H9heu/fXqXPCVuOKxHPuZNZUHz9n+QHrGdCJpLSFs+Ao+05zy4qIsAM54p7wuRs9
         zGUw==
X-Forwarded-Encrypted: i=1; AJvYcCWHFe5S9nmqtLxjdQaoUGDN6yamgPXBvJcY/J8CurP4YA2VXoj+jw4Dwl0gsOea/2axX9p68cfZ5m7yi5BOsqTz6VOFLWw/WFLV76lt
X-Gm-Message-State: AOJu0YyuGMOlNtZnUG0uoaHp8zPuNxSW6PbB66sopp3Ui94ColBa4dcl
	C+6/e1pNiO8aIGc1wmLhtrywEdvU6gESftxV9p2z9t2wXfXblWE+r8kB2/7l3w==
X-Google-Smtp-Source: AGHT+IG9oTcMCg7rkDReYhIwGehOkT+PViM2X4yuDk+pejmeAywc0nLdIrwyw2PSTgQN8mmuXIRQ6g==
X-Received: by 2002:a05:6a00:1953:b0:6e7:32a0:806a with SMTP id d2e1a72fcca58-6f4e039bc12mr23778076b3a.28.1715981858605;
        Fri, 17 May 2024 14:37:38 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:26de:b1dd:5:771c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b2f8b3sm15168736b3a.211.2024.05.17.14.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 14:37:38 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jitao Shi <jitao.shi@mediatek.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] drm/panel: boe-tv101wum-nl6: If prepare fails, disable GPIO before regulators
Date: Fri, 17 May 2024 14:36:37 -0700
Message-ID: <20240517143643.2.Ieac346cd0f1606948ba39ceea06b55359fe972b6@changeid>
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

The enable GPIO should clearly be set low before turning off
regulators. That matches both the inverse order that things were
enabled and also the order in unprepare().

Fixes: a869b9db7adf ("drm/panel: support for boe tv101wum-nl6 wuxga dsi video mode panel")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index 8e839a1749e4..028625d2d37d 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1475,13 +1475,13 @@ static int boe_panel_prepare(struct drm_panel *panel)
 	return 0;
 
 poweroff:
+	gpiod_set_value(boe->enable_gpio, 0);
 	regulator_disable(boe->avee);
 poweroffavdd:
 	regulator_disable(boe->avdd);
 poweroff1v8:
 	usleep_range(5000, 7000);
 	regulator_disable(boe->pp1800);
-	gpiod_set_value(boe->enable_gpio, 0);
 
 	return ret;
 }
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


