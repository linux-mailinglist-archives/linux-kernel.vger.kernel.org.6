Return-Path: <linux-kernel+bounces-227807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 315AF9156BC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE947B22CAC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E311A01B4;
	Mon, 24 Jun 2024 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="GNID9K56"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205CE19EECD
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255234; cv=none; b=CQdTcmBsWxeIzPIXlzPnqYI416Y18RvZDf4do7wkmN+KT3g+yqSmLxpU3+gd1jTsJwFw6FPS/30EvBh4fMhmV+PNV9yDtFBHsgkncl518esar7XZkubmtTwUzgVdkLxXXkrn9FwQ71SU8EAv+JHEjFwF3cu4Rt8eRSYT9kT1MqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255234; c=relaxed/simple;
	bh=6mPIBGH0BuWIonCA3g3TnIok4tTYM+2USw4BuvaFXsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yg8qCjPCCmnfN7jyEFTUoYUdyh+SFweKOLuvJLpOULkNP6wAZsaXwj5CnXupD3PKAM0zfb28nbE07p2bU+AHjxmyD3BNe604oDkDvHN0s19Q2FCFNJetJjKAmqcK8B5gxedKkn6wwZTfu4D/9RoxtKBHjGzSGVw9Qynt3RwYo9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=GNID9K56; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3629c517da9so4725583f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1719255231; x=1719860031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NUZJiG9Gjv4OA9J67oLpsMQlxEBxrT6DttNu0ncoRGM=;
        b=GNID9K56+3f3AF337xXdFawYAwPENwrdWtglwWYkkUhPBZbIyi8CifLuCodpzd+TLr
         YeJr7KxvGMjMj1pm2TRtL1p2FMLMvnyJnx99J4iFIMrngA2O4kpsTZZItbus2WGdxMPo
         UK6TXJjBoaW4w/Ii8wxuyxC09QLjJXnZXztzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719255231; x=1719860031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NUZJiG9Gjv4OA9J67oLpsMQlxEBxrT6DttNu0ncoRGM=;
        b=fJuwvI52aTXJ8GxpK0iX3lfKpHAjUDcNWBC7YBTXBGWF4v2xcYKn8Ci2bLD9ZhfSKj
         uLee2HnaM4RW6HJDn2oG6mr5A4M2z/wLweKMPuMCggwRQq0un4M3ngWgms61lHyOxaVT
         uMAFDcx32L1jbjYm74ypy5o3zPbICqqAehcq/sZZ2qBLuxfGYt5P1nsg1D8v0x88rk2J
         CQ4Os5JymtIlkXMMdmDv3dSnJNnpigRL55EcGHoxZhg7PxpYpEY3W4vu7kPBDtlFPX2U
         Q+yGlXyEYXPYZIOPjEXCUIpgsTlK8mw8KEkKROEzuK9gwg3qwAnTL9+pI4URkYJGmoWQ
         5waw==
X-Forwarded-Encrypted: i=1; AJvYcCVZxjJbkwLGVoyAGl3//TMsOiuDmTxhiasZC7y7/Ku6giUDyh5P6/GA7PF3anogGYEJSVjIXX55nK2Fa1PxuSx5Q+EW5xXFQRA2NVeZ
X-Gm-Message-State: AOJu0YyHtlKEbQf/f4wn8ydesrLr9gD9smCqO22EUjkeFspFvIJceatz
	obsdGP8YEZNLMoitajgd2qhHbzAB6rMA6OBzBJLDkhsWaWGatkv6JIyvFAPkJfU=
X-Google-Smtp-Source: AGHT+IFK8T+LlQMe+robPQRvr5T+YJtnbTOBRh3Mq0ksGTgPBWQRmT8UV0AJJEaqrqSnYPlc2/2i6w==
X-Received: by 2002:adf:fe06:0:b0:35f:1d5e:e2ca with SMTP id ffacd0b85a97d-366e94d9737mr4031115f8f.39.1719255231301;
        Mon, 24 Jun 2024 11:53:51 -0700 (PDT)
Received: from panicking.home ([158.47.231.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366eef51a14sm4489496f8f.83.2024.06.24.11.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 11:53:50 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: neil.armstrong@linaro.org
Cc: quic_jesszhan@quicinc.com,
	sam@ravnborg.org,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Michael Trimarchi <michael@amarulasolutions.com>
Subject: [RFC PATCH] drm/panel: synaptics-r63353: Fix regulator unbalance
Date: Mon, 24 Jun 2024 20:53:45 +0200
Message-ID: <20240624185345.11113-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The shutdown function can be called when the display is already
unprepared. For example during reboot this trigger a kernel
backlog. Calling the drm_panel_unprepare, allow us to avoid
to trigger the kernel warning

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---

It's not obviovus if shutdown can be dropped or this problem depends
on the display stack as it is implmented. More feedback is required
here

---
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


