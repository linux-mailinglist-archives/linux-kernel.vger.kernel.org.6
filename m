Return-Path: <linux-kernel+bounces-274577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4D7947A46
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1101C21583
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD563155733;
	Mon,  5 Aug 2024 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfIV26AX"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A1E13AD11
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 11:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722856168; cv=none; b=febuK2c9ocqQC8kV1m86R1LCPjbOFPtuNiNas1JFIJBYyfj+WniwLi1QOcAf21OPlf2NSRMnLoKI+BTO4tyXQq3HWiHEcyf3JZsQxSQoqHZBjjwxbqPXRkZYU/7xIGOXzBTmfj2/NbCbXByg688/g4fqEuV/oZu/gDubYqR1cqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722856168; c=relaxed/simple;
	bh=1uUgerSBuSQ+Mu+r2NcdqpwdQkp1kz46nQlE9W1e3Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qJ14+cUfNwSzgXW8M1b0WvSuCD3HRGApGR/pK4gRGY6aspUKd+Uk6FDrU1zYLfVqz3xPRC2cMUy/Nv9Obn6QM/WApiRVirWRkx0X1LPhffypiWelQ2gvFbtlnRj8RrA54hyyvq2oeJh39Kqjgv+CCq1RVGrReK5ilfcUBNfRizQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfIV26AX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so94106245e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 04:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722856165; x=1723460965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=79Xuj9rgFrPC1HSTEfYDoVNpMSfRb2MPhZi+uIGhKp8=;
        b=GfIV26AXuS1RjD4i2+OHmrAxP7QajcZjxF+z2EZVix8A/tF1YhEe5QhMwqkrzb64M4
         hTiWyVIwqKJvTeuARrZOBm/2hLGAj0NrEZCIssz5SHQFkJ38Nn5UXiubfRi5nt0+B4o0
         N1lb9uSFDxx7CYcL1r9psSoixd0jCCPtGtpdt+i2DRzSiWItcHTeaovfJCVCrXjkIF+f
         cnmYyDaPz1Ky9c7BxeOqszrHxl+Nfe7ZrwmBrBY6lRh4UDD21BdERKbSeDqz3cXGk2/2
         QQh/SyWYGU8tLhjPnnRfQuVuq4yZ1bPRCNu19MXd54dnDywysYRINuZ7C1on1jeQvRHU
         LYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722856165; x=1723460965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=79Xuj9rgFrPC1HSTEfYDoVNpMSfRb2MPhZi+uIGhKp8=;
        b=xMP/9KXX0jJyXptFW73NRaEBOdbfAEmoAUmfqCgzUrLkC4hqAoIQ4zjeRIt8EhFt8v
         7GQj6cyup1KnFeoNxkktY2hjP9sXH42FOm9NNAmsF1leIoVCRgnElbA2BP/0Q1VgjvPM
         NC4ewrgS1F4PrKv+/GVh+/Ch6jxyYu2OuQvxDLMJlCHPurvNUxYJoOxPyZUs2V88po3l
         Va789ej6uimVQ5qJysBlJbO0T2MAp9Haepi3Q8e0qOUGkGReODXSiSoy8VYlVM8NcDlt
         sHrBlrfyTi9XjvfXRkIntQ96g3sdc7jSZoFS/tueKqyNEINC3oUEAmEFca+Nj40q/wa4
         wFpg==
X-Forwarded-Encrypted: i=1; AJvYcCX5ttMtgNOR4A9y0Dsrix+c3tmvGR1No7o0dimhRavVT5dPeqYUiSbVHc6VYD34cBfMzgfyDXKYpop4+2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs7Tps9br4iGxsv490l96+eNlkfOXlzTUAU1N7JnaATR+tU6Vz
	m+4CVKisF5wfWgg/0AZF62aiFAuus+X5W3Syba9G2pddlaDRA9Y=
X-Google-Smtp-Source: AGHT+IF+enJmt09S/10X5NmbZmmJNuA9POvDDdzkcGMSH1Tm7mGKoejjHFjJOqEc4a0d6wLh557zUA==
X-Received: by 2002:a05:600c:3504:b0:427:f196:c549 with SMTP id 5b1f17b1804b1-428e6b7e954mr106869695e9.23.1722856164258;
        Mon, 05 Aug 2024 04:09:24 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:2127:8412:5ec0:5b4d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e8d6555fsm131275485e9.26.2024.08.05.04.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 04:09:23 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH] drm/rockchip: inno-hdmi: Fix infoframe upload
Date: Mon,  5 Aug 2024 13:08:56 +0200
Message-ID: <20240805110855.274140-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HDMI analyser shows that the AVI infoframe is no being longer send.

The switch to the HDMI connector api should have used the frame content
which is now given in the buffer parameter, but instead still uses the
(now) empty and superfluous packed_frame variable.

Fix it.

Fixes: 65548c8ff0ab ("drm/rockchip: inno_hdmi: Switch to HDMI connector")
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 drivers/gpu/drm/rockchip/inno_hdmi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 2241e53a2946..dec6913cec5b 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -279,7 +279,6 @@ static int inno_hdmi_upload_frame(struct drm_connector *connector,
 				  const u8 *buffer, size_t len)
 {
 	struct inno_hdmi *hdmi = connector_to_inno_hdmi(connector);
-	u8 packed_frame[HDMI_MAXIMUM_INFO_FRAME_SIZE];
 	ssize_t i;
 
 	if (type != HDMI_INFOFRAME_TYPE_AVI) {
@@ -291,8 +290,7 @@ static int inno_hdmi_upload_frame(struct drm_connector *connector,
 	inno_hdmi_disable_frame(connector, type);
 
 	for (i = 0; i < len; i++)
-		hdmi_writeb(hdmi, HDMI_CONTROL_PACKET_ADDR + i,
-			    packed_frame[i]);
+		hdmi_writeb(hdmi, HDMI_CONTROL_PACKET_ADDR + i, buffer[i]);
 
 	return 0;
 }
-- 
2.45.2


