Return-Path: <linux-kernel+bounces-182643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 088778C8DBE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 23:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413CD1C21CD3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B721411C7;
	Fri, 17 May 2024 21:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lMYQKt7j"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4DD5231
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715981857; cv=none; b=ECdKikyyIwXMC0k8jRCDrSe3flHGDy9f+emSAqJN+cblsJw2klL+3o1UAk2zPA5bSWDW3aAFZTOOlmp3Ir2U9nMV67PmZLFQOJw6N9qvEwFgY2C/3/uNWFbNBL1f3tYI1L+giRbMzAR5xtMMji1FwhRIbjPzui0Kpa9KZHWtykE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715981857; c=relaxed/simple;
	bh=0ydemrb0H9QqilRkRIhbSjUUxnDO0ID5Wn3jsidfUrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IJM/GTeP7LOJt0iCqaRpP5WI3zuHem++zG90Ym2+WGgVuqjmBDh9uSgxhh8QLvq97BRnLm6YfMN5VZVAYUPsWZQCM4T2JOW3x6vagGtgiMqjUNimeQ641YHgSVgK8IXRqRdN2fbOWrvxQqsHQubmw7EukzivfiTsKHHh82E191g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lMYQKt7j; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ee42b97b32so22877435ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 14:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715981855; x=1716586655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QQ2PInY+uC/KLW9XRBt6i2mdUuDTT+fEYpnbjgM4Q5k=;
        b=lMYQKt7jQrkN7SqVkbgT+hgDodB6R79KjbA5MzoDPLZc4NVO/RR6ZoDZfStmpGlaAN
         ygkS+MaNwCl87+puTop4vbH9uXO2c+jDIHjedLFGuTeMnAD/QfPy5eolt1KnJubXmt0w
         cZ0pneROWeGJGuGA9RAeFgFc8o6dvScjfUx/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715981855; x=1716586655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQ2PInY+uC/KLW9XRBt6i2mdUuDTT+fEYpnbjgM4Q5k=;
        b=e1dnAXWy+udWrHWSb5+Px2G6lax0utwLNfDsyswriEoBUT6k0+F6gHIzQVToXrVa1S
         wpwobmiYZA4NgCSw1vWpZK7sWu+0byduKdjdf5LHjUBlVb3Iufyu28l4isVTM3mX1TE9
         xocvSjtsn5FiETTKPZD8oW9lOPZeuMgpOBVKG+dxkVFeZ6WJB7D01LcdXHiFyw9HO8eZ
         5OkQOgy2xrTZEjoDm/KkH3gkZ9g9DHn8As5mMpmkt3WIibyb2XQn3IUZRYGdMg3l6+g6
         sIyJ0wF+VwUtS7fmIBJn0q5Bc9HW1ryyGlkmzhZw4CoV2eKhcW7y2KpsgeMlt6PHI++2
         UDHg==
X-Forwarded-Encrypted: i=1; AJvYcCUGXU3PBwSOeqAuBxuw73xCwty70uikLqq+Gl9A42EXPNdwbpfQdBUjAPzC2/MXAWJIfZw/5ZQruhovrm8w2tElDyuaC0gPbYwrFrqC
X-Gm-Message-State: AOJu0Yz7RZV+KmclTq/8ZqA28ZV4+2rJXo1TPFoTmJUk1yOHjtkDSAm2
	N6YcoozWc+JyonwFJukHKUVqSp8VKJtqUxuHpim72VU6EUhvw65rOPOOAeSZjQ==
X-Google-Smtp-Source: AGHT+IE5ukk1eYupJDXgn9GYxBxWGiXIOAifNl3mLurCa9fk2quD0QLQybES+xForsch1qL2iYidFg==
X-Received: by 2002:a05:6a20:5a9d:b0:1af:dbc6:baf9 with SMTP id adf61e73a8af0-1afde0e6310mr20912711637.36.1715981855066;
        Fri, 17 May 2024 14:37:35 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:26de:b1dd:5:771c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b2f8b3sm15168736b3a.211.2024.05.17.14.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 14:37:34 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Jitao Shi <jitao.shi@mediatek.com>,
	=?UTF-8?q?Kamil=20Trzci=C5=84ski?= <ayufan@ayufan.eu>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Ondrej Jirman <megi@xff.cz>,
	Shuijing Li <shuijing.li@mediatek.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Xinlei Lee <xinlei.lee@mediatek.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] drm/panel: Some very minor err handling fixes + more _multi
Date: Fri, 17 May 2024 14:36:35 -0700
Message-ID: <20240517213712.3135166-1-dianders@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


This series is pretty much just addressing a few minor error handling
bugs that I noticed recently while reviewing some panel patches. For
the most part these are all old issues.

This also adjusts the new himax-hx83102 in a similar way that Dmitry
did in his recent series that included commit f79d6d28d8fe
("drm/mipi-dsi: wrap more functions for streamline handling"). His
series handled the panel driver that himax-hx83102 forked from but not
himax-hx83102.


Douglas Anderson (8):
  drm/panel: himax-hx8394: Handle errors from
    mipi_dsi_dcs_set_display_on() better
  drm/panel: boe-tv101wum-nl6: If prepare fails, disable GPIO before
    regulators
  drm/panel: boe-tv101wum-nl6: Check for errors on the NOP in prepare()
  drm/panel: ilitek-ili9882t: If prepare fails, disable GPIO before
    regulators
  drm/panel: ilitek-ili9882t: Check for errors on the NOP in prepare()
  drm/panel: himax-hx83102: If prepare fails, disable GPIO before
    regulators
  drm/panel: himax-hx83102: Check for errors on the NOP in prepare()
  drm/panel: himax-hx83102: use wrapped MIPI DCS functions

 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    |  8 +-
 drivers/gpu/drm/panel/panel-himax-hx83102.c   | 92 ++++++-------------
 drivers/gpu/drm/panel/panel-himax-hx8394.c    |  3 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c |  8 +-
 4 files changed, 43 insertions(+), 68 deletions(-)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


