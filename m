Return-Path: <linux-kernel+bounces-320235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B579707D9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 15:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE0122848C8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 13:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B69616BE02;
	Sun,  8 Sep 2024 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBNFUwX4"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D53416B72E
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 13:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725802561; cv=none; b=i7+VQvfn0VzdtQcOcNU9Ffx4D1NJ/Rlb3YmSmPy9M3bvzvN9vaMbx/cTRuDcajVlXr7vSOqt+kLK9va4p3ThJXzCmgCRSFE6SObKYxQlCiGiP0NOKyMgeV4QP28DJwk9Xxll9hd7e7Pia1gvzrqETZQZlyynDA6WyS/eyxSJnVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725802561; c=relaxed/simple;
	bh=N5LW/RAGRPj0VbgePXAEoL6fQfvxApXRJahOawIovgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JV1Y0GquV+ptBYlEvmKLgGw4uORRF5U+x/0dW43tuMCCxutlsNn9H2HgVhDukiLhEn11bDSVvOGMVdtvIUVV+HttxPHnqh2S5IPaPUau8HxoNcX97tKGptL457MYpGHrSydy3vt6+Mw5oe4fFnCFqtMY0cjAQ+8fkONFccEcKWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBNFUwX4; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718e1ce7e71so1077824b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 06:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725802560; x=1726407360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lrHW/WPW/tmB8xlxZt2U0QdmJv6UcMCpbqutQiX5JMA=;
        b=nBNFUwX4qiIgP1nHhBAyzFosAIGAaITitVOlqCQ6BMmpi9w5fEzMx9w8y7En1grXpR
         FdCTjEZYFseHpZSEuFsZDAW7Jt5aWqJYcPuG68BSG0GOAdFaZKsRYoZUzaonccZsHLr3
         IOMepUAAjlFadC+iS0n2YN75/FI0aDojojjMZ5uEgstCqUHOmiAH60O9htd1eXrUTnGA
         4+N00PRrz/n8ZefOHdDypHje3f5XAl219NwU9tr3X40xmNT+mFwOtV15ag+KocBITw5U
         fVXVV6lCFL+loY8npqYuR104QvqhnRPEM+tFwTlvHNCMUa5OfzIbPINgPWzGq1s+3dcv
         JGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725802560; x=1726407360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lrHW/WPW/tmB8xlxZt2U0QdmJv6UcMCpbqutQiX5JMA=;
        b=WFTXvx5ekcgPYIqqyjSyySqjAdPbi6PsB/5uDyJbIJgO+wg7EUfcpBGr2qvSNel+wi
         JK+5RhF8btzDHqOgbOyXhETe8LfPrMWrjcpye/owNGrseEIXq+umbrELfVWOMQyXSBLx
         T/17RpPaTP2TrgCV9V96l0V9d8DdAx+wU2kpHU0AEvkwSONYf6ZkVMBpM2uOx0js7lOU
         Hy9/InYUMcJBcCdPH2BPfOWI1iCLa4YRnmyQMkI8I2VZVYVP07Q8jXwnfNeM4UoTGve0
         TBLp4rO1TwCoXAXDeo/ICgtG1MLAJwpekvhxPsj9PWt+pjFbi6RiXlVExfUe7N0VUmzb
         6S7g==
X-Forwarded-Encrypted: i=1; AJvYcCXeVYLcfH55h0KlHuzZ5ryn8ldbzt25xU2rKiHsn8cFUNBImHu82BGU9BkhZ2PsT/7S/7ZFihgi7zpXG28=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAk9B1c0sM/JPXigCxmNyrVj9yndDmToBmnfEqS8tlkJ2TA5rR
	ABSeySr1vYfvnQTmAuzBcRhy4GpZjy417naoJJuIFkAyCUdLi3K2
X-Google-Smtp-Source: AGHT+IH+8craLoHGDf/GOz6Ze01xi4LSwURhatcmaHJgRbnYVbRO7h42x0b+cwcUiDAEeUnHkCRS7A==
X-Received: by 2002:a05:6a20:2d14:b0:1c6:ba9c:5d7b with SMTP id adf61e73a8af0-1cf1d0f98b5mr7076007637.23.1725802559695;
        Sun, 08 Sep 2024 06:35:59 -0700 (PDT)
Received: from localhost.localdomain (111-240-109-89.dynamic-ip.hinet.net. [111.240.109.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710eeaf29sm20131935ad.143.2024.09.08.06.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 06:35:59 -0700 (PDT)
From: Min-Hua Chen <minhuadotchen@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Min-Hua Chen <minhuadotchen@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel: khadas-ts050: make ts050[v2]_panel_data static
Date: Sun,  8 Sep 2024 21:35:30 +0800
Message-ID: <20240908133533.112894-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

make ts050_panel_data and ts050v2_panel_data static because they
are only used in drivers/gpu/drm/panel/panel-khadas-ts050.c,
and fix the following sparse warnings:

drivers/gpu/drm/panel/panel-khadas-ts050.c:620:32:
sparse: warning: symbol 'ts050_panel_data' was not declared. Should it be static?
drivers/gpu/drm/panel/panel-khadas-ts050.c:625:32:
sparse: warning: symbol 'ts050v2_panel_data' was not declared. Should it be static?

No functional changes intended.

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 drivers/gpu/drm/panel/panel-khadas-ts050.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-khadas-ts050.c b/drivers/gpu/drm/panel/panel-khadas-ts050.c
index 14932cb3defc..0e5e8e57bd1e 100644
--- a/drivers/gpu/drm/panel/panel-khadas-ts050.c
+++ b/drivers/gpu/drm/panel/panel-khadas-ts050.c
@@ -617,12 +617,12 @@ static const struct khadas_ts050_panel_cmd ts050_init_code[] = {
 	{0xd4, {0x04}, 0x01}, /* RGBMIPICTRL: VSYNC front porch = 4 */
 };
 
-struct khadas_ts050_panel_data ts050_panel_data = {
+static struct khadas_ts050_panel_data ts050_panel_data = {
 	.init_code = (struct khadas_ts050_panel_cmd *)ts050_init_code,
 	.len = ARRAY_SIZE(ts050_init_code)
 };
 
-struct khadas_ts050_panel_data ts050v2_panel_data = {
+static struct khadas_ts050_panel_data ts050v2_panel_data = {
 	.init_code = (struct khadas_ts050_panel_cmd *)ts050v2_init_code,
 	.len = ARRAY_SIZE(ts050v2_init_code)
 };
-- 
2.43.0


