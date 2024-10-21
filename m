Return-Path: <linux-kernel+bounces-374493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D919A6B14
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE92280C12
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310B91F8EF0;
	Mon, 21 Oct 2024 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Skf956aJ"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAC81DC04C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518765; cv=none; b=mnG+pmYaM5cCOMfnLBTGhEIZEKxwb/NiExc8AuwoulMf37cogWLY8xU4sBAy4w177cuudYJplZpywF+TLv5dkYEqpzPAhptHY9bQihsinN8PEQ60IXbc4hbYG20bmWLSFSxMaE284WPRrvvAb8Gq/l/mn0MBE/urvFXdjab4KTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518765; c=relaxed/simple;
	bh=FHVpt+ijZNTJYfyRYgoyUA9Z0jPkQ0HEGyo08Iag3W8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Myb2TSPFnBAFHYfTaURIXu3Zxg10xwBf01hmoksfwycQAP97j2OiGqCF0cXpVTMnzEvF6mxdVfLyvQywOrMXiWprpjGMOFA2ZSHfuw9m3fGHB8TCip1SYoXddhKSbtY5Il5dA0OSnGHBO8uscBahmUi4RgLv/O1M6ogpaYgTJ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Skf956aJ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a156513a1so623950266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729518762; x=1730123562; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wfmOIjQ0u6s2Z1vVW23+WlBEpCv3VziXznZyhZ4a8IU=;
        b=Skf956aJfiow5JP+3LcUJrkYXKU4oEB2YwtlkFtRr8mP3n1iZ+pi8MqQk+hYWnC77O
         YN0RQV71420zn6EwN02YyWqO7XST0A14oiGZYR8kmlL+emhMlHano1pmVxE4uMWXBzf3
         QubovjkTtKayFbAwDe/QZctnNBm2dgAOd7fKnZlpbuenfgb3gOzCxjQOOzHxV8xUCZbB
         ZxAcxqnbrKsXcFRozzixKNEmPk5o1vnrKgz7TN61pprd6mh8sIP3/OCszh+CFLGamvib
         G3Z+tmyCMu7mx5VmrcbMRO3Ht38d3QoDYZyh2ZvlVkjKxy5zIdOxyLLAmI5qiMr3DYzP
         PLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729518762; x=1730123562;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wfmOIjQ0u6s2Z1vVW23+WlBEpCv3VziXznZyhZ4a8IU=;
        b=jxUyBvWDFaH27YeCIQgE0tWxrWPnQ1aGevmYs54y3BC2tBQHQbnbIqel3i2QDZ8Pi5
         z9n+JVbX+tL2P5d4tYSWcOPVK0wS7Ezl4d9PYB7BYsvBJaVXg13yg8M8Cxq8p1J1WR1V
         QDA+8w/3C7RMM2oTXdzVzioUp/VTWwQAh4y2+meI2uA3SKPVw+bR9EZzfJPMZxvbDgam
         wu8KwwvFziHB5ZL9mPktJpFSItzKhyjftJtD7atpgiR26tRw31bdnwaSH+7248eI8xeQ
         lKCdzldASXqrpli1GPm6Ud5rAkk16PRiEmIjtx1ckr8TXZcBP2xA8mqrmzyEAJzi0Biz
         gS5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqCXOBwgP5di8RZu9xF5L0SQWC8BeKdgY2B1PumuxzJQPpD2Foo4z715MqaYm10YyzTked5Mgte9kEwI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YylcME1sxNG8kzj37vIXApr0y9SJSAz8AQI2j/QIf9ZfmLiAOem
	FpeafklnkQEwSlYzVrERaOZXq15G/3ZitX4pPFJZsb7Tf3TmK1y7
X-Google-Smtp-Source: AGHT+IFWX2pLQIh7KTEsIrHDg1JjXfzvicpXsd1hy2FovsO7HDGrNsIUYVSKlmKmfJMIudRRkgi8QQ==
X-Received: by 2002:a17:907:6d16:b0:a9a:1fd2:f668 with SMTP id a640c23a62f3a-a9a69a680e8mr1237736266b.19.1729518761432;
        Mon, 21 Oct 2024 06:52:41 -0700 (PDT)
Received: from [127.0.1.1] (leased-line-46-53-189-107.telecom.by. [46.53.189.107])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9a9157212csm205320266b.162.2024.10.21.06.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:52:40 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 21 Oct 2024 16:52:36 +0300
Subject: [PATCH] drm/panel: s6e3ha8: add static modifier to supply list
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-starqltechn_upstream_integration_panel_fix-v1-1-81776e89052a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKNcFmcC/x2N0QrCMAxFf2Xk2UKbWSb+ikipM26BWWuSiTD27
 xYfz4VzzwZKwqRw7jYQ+rDyqzQIhw7GOZeJHN8bA3o8Bo/BqWV5L0bjXNJa1YTyM3ExmiRbk1P
 NhZb04K/rEQcfh3iLpx7aYRVq8z92ue77D5TWyE58AAAA
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729518760; l=1238;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=FHVpt+ijZNTJYfyRYgoyUA9Z0jPkQ0HEGyo08Iag3W8=;
 b=UOz0GwPCD9+DajTE3mWxf5jA0/6F0aoy87fTUuM96fBx7TIBiFBDUPCtwgdUny5/WOPCo9Bdf
 /q5rtzMDycnClzFSppmd8HUAXq0Y9HaB9NHzxFIcNdZDA8xsj01tImC
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add 'static' modifier to panel supply list.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410160810.0jaNgxB2-lkp@intel.com/
Fixes: 779679d3c164 ("drm/panel: Add support for S6E3HA8 panel driver")
Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Fix kernel robot static analyzer error.
Rebuild with sparse to be sure.
---
 drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
index 76b5a6ea610d..64c6f7d45bed 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
@@ -24,7 +24,7 @@ struct s6e3ha8 {
 	struct regulator_bulk_data *supplies;
 };
 
-const struct regulator_bulk_data s6e3ha8_supplies[] = {
+static const struct regulator_bulk_data s6e3ha8_supplies[] = {
 	{ .supply = "vdd3" },
 	{ .supply = "vci" },
 	{ .supply = "vddr" },

---
base-commit: 63b3ff03d91ae8f875fe8747c781a521f78cde17
change-id: 20241021-starqltechn_upstream_integration_panel_fix-32270575b583

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


