Return-Path: <linux-kernel+bounces-382120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFDB9B09B6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB1F1C24AAA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F2314A0A7;
	Fri, 25 Oct 2024 16:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="rPpP+ONl"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7273B18595F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729873285; cv=none; b=EAF4tDJK08PbtW0sywm1Fuq8LflLPslpK1et4Z1trDR+sM//vOhkovgJUN57V7BJY42w8pxGfc8Njjg2JzGEG7kS0TMutcj1B/Qns2WuNWwUKpKOnd3wHEvO0Abeidn+JZCdgbBoPBUSGjSecbPC4Jou1VQi70wsmhObD2LlJc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729873285; c=relaxed/simple;
	bh=z7WweRdQheGI3pzAwFkk9rNTL8TZfEB+/oDFKzELXm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IkHa/a9MCWoueu0HTaps7jvsGJR3I9a+6Zb5tUQ7nLfrXzksjBujccwWxfRoP3f50T/BdsL15c7WpX8d5YJEullA7xHlvuJA27SRyLvSTJObB+3x07zlW4VrtycX4OAUySc6trFUH5+Tex2ddYwzFo0f/cqQph3dMJmn1tzbmZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=rPpP+ONl; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539fe76e802so2867602e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1729873281; x=1730478081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMjnh9e7Jw2TD0W4BB+OtBZvaU7qr6SdoxJVRCE4W9g=;
        b=rPpP+ONlW+d7kZ4j+aknyglECG8xu33sKDlU7MJJKUf1WQeyyN9HV5QSUACaHk8od7
         JFCulwRkM/XtYQg0icic2CxKqXoEqrqv1gx+OPRwYBaU2NjRzLhQo6L1FaOvk1+W8cTF
         q9iVgaUoW5yYgiq+o/hinDye5fMdvuT4kz5Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729873281; x=1730478081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMjnh9e7Jw2TD0W4BB+OtBZvaU7qr6SdoxJVRCE4W9g=;
        b=i76ifBx/chIfkIy+kRZNgjxbcku5EuqT6VLQELBjxjTS2pIW2bpMywFw4Cx5e1JfVi
         t0U2NUyPdOXSJNMhDdKwQObPGQmXTSgn9YqpEQCP5HY1fbq8osNDVftrRrmR+HeBVsZ6
         ELtBz9TPTaqWLMNs1MGVhcqy701ZXGM3JMyvPxsfiBVeL5HjwTYa8j8SKmlUpfxPlHzQ
         hmvXkMWSgZt8wib6pXx/yhkqm7yl5FaAjWaGkxIFdez4/idRSmuA+iBWlv34VCH0whyf
         Rdh3KcwrHNcbE9M3oadDqjsQ31dgCWcHZcmibl66lj/ebMwgeZrFzoMxkmhtPpFLkzXI
         5yAA==
X-Gm-Message-State: AOJu0YxNpLgVHWXBhZ+ycuWwOAGodru0EFnQmQsYjMCUEvEtmd0EsgDG
	ud7unGNACYFZGAtJ6dumjUwEjrNtXebg+sVgXwwAxmqXgg31sM9dYfsG+7pRtk37Gfw5Xk+/ODF
	+M7Y=
X-Google-Smtp-Source: AGHT+IHpRXVcg9COz+CBZOVkqqUYia7I4b+x2BPKv04aHOjbK1ZReF3rzypWbORxTuCO5E/o/yIaGQ==
X-Received: by 2002:a05:6512:acc:b0:533:43e2:6ac4 with SMTP id 2adb3069b0e04-53b1a37540fmr5770667e87.49.1729873281276;
        Fri, 25 Oct 2024 09:21:21 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.43.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3af02sm1906019f8f.25.2024.10.25.09.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 09:21:20 -0700 (PDT)
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
Subject: [PATCH v2] drm/panel: synaptics-r63353: Fix regulator unbalance
Date: Fri, 25 Oct 2024 18:20:49 +0200
Message-ID: <20241025162115.4115352-1-dario.binacchi@amarulasolutions.com>
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


