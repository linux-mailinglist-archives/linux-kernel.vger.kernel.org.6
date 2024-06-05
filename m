Return-Path: <linux-kernel+bounces-201603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BA78FC096
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1947F1F22824
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A7260DCF;
	Wed,  5 Jun 2024 00:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b/MJQ75S"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F2AB67A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 00:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547098; cv=none; b=C73X/ev8lOKXkZEXK02eaiKZb6C3tQ/vANzD/XscAXWSHDnAQZ3/JL3/0ZWC4J4H7/1KME4tHJ79/JocGn5hLFPJE/dDShA0/xv8AgrBtSEaZ8kywGZ1BpL960T8uBDJW04Z0dWIGXFtKJn0xtx0zeeE7BWZT4KUPFQLWgHEeJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547098; c=relaxed/simple;
	bh=h2Jz/w6quEVWEyDc6TfJnLPX5jBK0VklYYlDpNWdFz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBeslDPN0uKMEYbmDOAstMEQjvb2gJHod/b7Bo/4vR8z9hXEXEcAMHmELoIN/URwQx9+j9DlLVGLQoQnkFUbsdVkfR/47PmW4b2H/Ts0+Zt1cLZcw0qgfZVLS7rLzvkFQOetQZIdAw9rxq8Mxyaj8ZibIPN7vanhUQUvpP5OW+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=b/MJQ75S; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f6342c5faaso14000975ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 17:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717547096; x=1718151896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5c4MKTgrGl4hq+d6zD/HFZfQGneGwPo9D4JV91mhW4=;
        b=b/MJQ75S1ZKibzvqOUbgOHUOt8IfTmhqHg2hSn+EYok3g5msGokpLl3noA0Zc9Up9q
         XQdvT6GE8wchwEt824z1QX7NsTnmlc7MNesrlr7sYAl39PCspVlrZKpMjGo9sFMmP3Ui
         qhlGFteyZhkSru3qx7luGHNcltUo1p0kKgALk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717547096; x=1718151896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5c4MKTgrGl4hq+d6zD/HFZfQGneGwPo9D4JV91mhW4=;
        b=ezyd6eOKoIqb03Pdciw/OBRwSPn5Mzg8KlzR37wPX4GV1LfzyGi6sCezq5DxiRDy+q
         YKi1k8V1TqEDR+cN1Nzt6edhax/oxmEUDs0BjjW+/2lx/GxKox82aEONOUjwKcs21Z9m
         q1wnJvsyEP1qvPmoEqrCR/+yqAvr9KntpHeLTkYZuViJVHsrJuQzoeURhHplit/YPXXX
         KS8VZnZvLxf2XiTx1lZ+lFX96YT5wBqUnzZH/LaKMmGzPMN3qko4JnQua8bpEQewAng1
         qrW63W/4O/gfNZ952clPutSrz2Xomr7/4W+sEJZ3H/wT9dOiKrPsovEf+msB/1i+s8lM
         794A==
X-Forwarded-Encrypted: i=1; AJvYcCUqBf5sl/x9+SlL7/WwxACID49y7KqFo9pk0P1Ch4e/Wc9YpeOEmpHoI6itUTHAcBmOMyUHRM3kXOxIPo/Crv8pRnbgJNRh9/WT7e7D
X-Gm-Message-State: AOJu0Yy+Mk/et/FstcEw0ruvUD9L5nlr5IoX2rSlNS2hF9Ot2i29WPCq
	KfRixLFLezczvz0h27UfYTH6973rnegwE+PfQZiGil17VuQl5fMeRNcOzTsrkg==
X-Google-Smtp-Source: AGHT+IFBh/0CPO5W8OJJIzJ5oQC9KPttYAyT+WTPZMKapzK/LwmKYkDq0q16vzIBdd7d6vPSCvFMWw==
X-Received: by 2002:a17:902:b18c:b0:1f4:867e:1486 with SMTP id d9443c01a7336-1f6a5a26f5amr10618805ad.40.1717547096147;
        Tue, 04 Jun 2024 17:24:56 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd862sm89032025ad.147.2024.06.04.17.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 17:24:55 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Werner Johansson <werner.johansson@sonymobile.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 19/24] drm/panel: sharp-ls043t1le01: Stop tracking prepared
Date: Tue,  4 Jun 2024 17:23:05 -0700
Message-ID: <20240604172305.v3.19.I56849dbe7c906f0cff076dc5286fd05c7e3e9c18@changeid>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240605002401.2848541-1-dianders@chromium.org>
References: <20240605002401.2848541-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As talked about in commit d2aacaf07395 ("drm/panel: Check for already
prepared/enabled in drm_panel"), we want to remove needless code from
panel drivers that was storing and double-checking the
prepared/enabled state. Even if someone was relying on the
double-check before, that double-check is now in the core and not
needed in individual drivers.

Cc: Werner Johansson <werner.johansson@sonymobile.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
index 855e64444daa..c86337954ad7 100644
--- a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
@@ -26,8 +26,6 @@ struct sharp_nt_panel {
 
 	struct regulator *supply;
 	struct gpio_desc *reset_gpio;
-
-	bool prepared;
 };
 
 static inline struct sharp_nt_panel *to_sharp_nt_panel(struct drm_panel *panel)
@@ -99,9 +97,6 @@ static int sharp_nt_panel_unprepare(struct drm_panel *panel)
 	struct sharp_nt_panel *sharp_nt = to_sharp_nt_panel(panel);
 	int ret;
 
-	if (!sharp_nt->prepared)
-		return 0;
-
 	ret = sharp_nt_panel_off(sharp_nt);
 	if (ret < 0) {
 		dev_err(panel->dev, "failed to set panel off: %d\n", ret);
@@ -112,8 +107,6 @@ static int sharp_nt_panel_unprepare(struct drm_panel *panel)
 	if (sharp_nt->reset_gpio)
 		gpiod_set_value(sharp_nt->reset_gpio, 0);
 
-	sharp_nt->prepared = false;
-
 	return 0;
 }
 
@@ -122,9 +115,6 @@ static int sharp_nt_panel_prepare(struct drm_panel *panel)
 	struct sharp_nt_panel *sharp_nt = to_sharp_nt_panel(panel);
 	int ret;
 
-	if (sharp_nt->prepared)
-		return 0;
-
 	ret = regulator_enable(sharp_nt->supply);
 	if (ret < 0)
 		return ret;
@@ -152,8 +142,6 @@ static int sharp_nt_panel_prepare(struct drm_panel *panel)
 		goto poweroff;
 	}
 
-	sharp_nt->prepared = true;
-
 	return 0;
 
 poweroff:
-- 
2.45.1.288.g0e0cd299f1-goog


