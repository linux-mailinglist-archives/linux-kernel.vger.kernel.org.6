Return-Path: <linux-kernel+bounces-227338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB20914FC1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68E511F22ED8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA8E1474A5;
	Mon, 24 Jun 2024 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="Zfnx6y7a"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5EB145B10
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719238840; cv=none; b=eaaKwzt7jaADIE69Wp66Nur8R6rtdpxvBjAMOaQP3mrDZ1DothWhTrIHpFjxO99uYD794rF3+NCC+5qfvVxtL6xCRH8XQiZvjx5Xsu8WnVhyrHboGsLibz18L3JcrsPjlVJzSrqem9ovTCcMddwjW3Y2hjJ3bwgwLLnsYUVbsmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719238840; c=relaxed/simple;
	bh=xzKc9uBPUMCXymtPKCto6ET6Mb0XmqemZoJS8MNjV1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uzdQTD/iguJImoJnjJoIlxtYfkrPbs20ab9BF69p3+RHjnTpoCXIfdQ+ZZ5g6RQKfHT7OQGiPjXsF+6FtrRX+jq9EPhNDmOBb8J3ihOi1xPONXNb5KYmH6yatBU4fc9nkj3RNmuXKj4kgz0tmQphqhIWqxHSealNV6CrmOorBUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=Zfnx6y7a; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f862f7c7edso32751365ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 07:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1719238839; x=1719843639; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IW9xB7SGLE1u2drt2ajd8WcJZilPv6W7f231Ewn0yIc=;
        b=Zfnx6y7aBhz3lfxPzxHmmlDG+7oeF7LppsiUiMqq42jAe4NAmR+GmntDaSoc/gIyi5
         LlZ4q0J6JK4cwgUjPD+2RflG9o7LonaiQGR21MQdcIk3h2kvku8BldLxChOp3makikSx
         Gxm28bOaFjWRs+LOYm2KvLeGwqJ/t7DP2uwj347FTb7MFABbd7VFK716X3m8kU7FU7mC
         T3nMXenucjrjPmho9MCf59BBpJV7XDnRoFlb5e3ymGJ6e52Vq4P/Q8h6unF+w/Il9Vrh
         0EwMKsdiBZiYp3xrDbbUH+9sMcBsJ7RhPOC3rXy/ZfC9MtvUVm/XcQOoW/WCZwaeXdkd
         iWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719238839; x=1719843639;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IW9xB7SGLE1u2drt2ajd8WcJZilPv6W7f231Ewn0yIc=;
        b=mOgRydT2xx2qSjxUc5ntbdBDAjOR8nayDVOBgWMfVQZgEQFCYmTK0SsF0b519Ns1hu
         9aVx72WfoFI0k9N1XWYABQLlTCa7kkjPjl9OZfmCHw3JkaKl4Llr8tuKXTiG2O7YeCzh
         rKbbmkrVTrKg9iU2TUIeIt9CKx0QnzOs2+G+z+JoVCylSSBOtKOA7hOY86f2Gtj63SHW
         /uIvhYd4ujHV4O7BjdFZvZbzz4dVfCneW4Wis/iFzP6+s8kwO0NJbw6M7OV0LOVh7w78
         qjuzpsRv8mU20XBzP/qBG61M/jt9qmmanpPlg9MUWutvKy64dlregIvPa59jWgSaxv4D
         kitA==
X-Forwarded-Encrypted: i=1; AJvYcCWmIkb03xaR89mE5MQtkwPrhkUzLvoMHpQddlN1Z4fZ01JLIva+2RShHXXLj4TsLdSjj1lnd2K0PeoL6yJKsqQz9KfFcST4mMKP9P9E
X-Gm-Message-State: AOJu0YyM0vYnJJhpAzGaINf6DemVw4nx3C+RyHtiYAHg+W1ltqe4bm+P
	FDl1oXwTvTCdzCbF5GWx2COsnyVtnbsG6f1ANFl4XJde+OSipWYiTi5hZfUYWCQ=
X-Google-Smtp-Source: AGHT+IH0DteN1dbTBG1GBK0A/Io6IUJtHamrxjwv3MOs421ET94+vw2aJrPi6z85bBFLz6x8HGkyWw==
X-Received: by 2002:a17:902:c404:b0:1f4:71ef:98f8 with SMTP id d9443c01a7336-1fa1d3e3b9amr69848235ad.16.1719238838647;
        Mon, 24 Jun 2024 07:20:38 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d5fa9sm63243855ad.206.2024.06.24.07.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 07:20:38 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.co,
	dianders@google.com,
	hsinyi@google.com,
	jagan@edgeble.ai,
	neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	dmitry.baryshkov@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v5 1/5] drm/panel: jd9365da: Modify the method of sending commands
Date: Mon, 24 Jun 2024 22:19:22 +0800
Message-Id: <20240624141926.5250-2-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240624141926.5250-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240624141926.5250-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Currently, the init_code of the jd9365da driver is placed
in the enable() function and sent, but this seems to take
a long time. It takes 17ms to send each instruction (an init
code consists of about 200 instructions), so it takes
about 3.5s to send the init_code. So we moved the sending
of the inti_code to the prepare() function, and each
instruction seemed to take only 25μs.

We checked the DSI host and found that the difference in
command sending time is caused by the different modes of
the DSI host in prepare() and enable() functions.
Our DSI Host only supports sending cmd in LP mode, The
prepare() function can directly send init_code (LP->cmd)
in LP mode, but the enable() function is in HS mode and
needs to switch to LP mode before sending init code
(HS->LP->cmd->HS). Therefore, it takes longer to send
the command.

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---
Changes between V5 and V4:
- 1. No changes.

V4:https://lore.kernel.org/all/20240620080509.18504-2-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V4 and V3:
- 1. Only move mipi_dsi_dcs_write_buffer from enable() function to prepare() function,
-    and no longer use mipi_dsi_dcs_write_seq_multi.

V3:https://lore.kernel.org/all/20240614145510.22965-2-lvzhaoxiong@huaqin.corp-partner.google.com/

---
 .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 24 +++++++++----------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index 4879835fe101..a9c483a7b3fa 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -52,21 +52,9 @@ static int jadard_enable(struct drm_panel *panel)
 {
 	struct device *dev = panel->dev;
 	struct jadard *jadard = panel_to_jadard(panel);
-	const struct jadard_panel_desc *desc = jadard->desc;
 	struct mipi_dsi_device *dsi = jadard->dsi;
-	unsigned int i;
 	int err;
 
-	msleep(10);
-
-	for (i = 0; i < desc->num_init_cmds; i++) {
-		const struct jadard_init_cmd *cmd = &desc->init_cmds[i];
-
-		err = mipi_dsi_dcs_write_buffer(dsi, cmd->data, JD9365DA_INIT_CMD_LEN);
-		if (err < 0)
-			return err;
-	}
-
 	msleep(120);
 
 	err = mipi_dsi_dcs_exit_sleep_mode(dsi);
@@ -100,6 +88,8 @@ static int jadard_disable(struct drm_panel *panel)
 static int jadard_prepare(struct drm_panel *panel)
 {
 	struct jadard *jadard = panel_to_jadard(panel);
+	const struct jadard_panel_desc *desc = jadard->desc;
+	unsigned int i;
 	int ret;
 
 	ret = regulator_enable(jadard->vccio);
@@ -117,7 +107,15 @@ static int jadard_prepare(struct drm_panel *panel)
 	msleep(10);
 
 	gpiod_set_value(jadard->reset, 1);
-	msleep(120);
+	msleep(130);
+
+	for (i = 0; i < desc->num_init_cmds; i++) {
+		const struct jadard_init_cmd *cmd = &desc->init_cmds[i];
+
+		ret = mipi_dsi_dcs_write_buffer(dsi, cmd->data, JD9365DA_INIT_CMD_LEN);
+		if (ret < 0)
+			return ret;
+	}
 
 	return 0;
 }
-- 
2.17.1


