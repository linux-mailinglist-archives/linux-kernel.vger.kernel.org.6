Return-Path: <linux-kernel+bounces-222209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7313F90FE43
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 000741F24574
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C781015383B;
	Thu, 20 Jun 2024 08:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="Ttx9WabZ"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270256FE16
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718870731; cv=none; b=X6L5ZSM11vvwWzehvUyG8qxoL1HJj7CYGUyUqNDO54rTTwqvSzsCbklzu5BuHCvY3Tgf6yEk3S4bT5LUsKC7JnSfl3NtYVNszs6F1MIBiiA8Fa+NNSmfmLaKZdIJ+FWkKQt8FF6pHMbID+Figr4vRbKr/XT1IXeQbzSiFgFsHzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718870731; c=relaxed/simple;
	bh=XOul/qD5sSGRcDGWiYqw0qFkSHBwCbp5w5yT0BnOEjw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FL/ICFFHqf4oREc4m2JU06UxaFLgjEWpBU4yYk6uxqn/j7Vc4ZZMcD4VaKdBj+NzzUJ57gUGhNj6YB1wyV31qzMcMQzPICJXjr/qBsLX4dEM4SbTYQ59+VT1oEdVHVG5quZN7pAUu8OqrJEKymoifhYdegyg4z1ouHtYcSxFuTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=Ttx9WabZ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70623ec42c2so509169b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 01:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1718870726; x=1719475526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dakUGhqrnLzB9mnNo0IKnWBzyZqbbKSfGuNLa4v3K1U=;
        b=Ttx9WabZlCxTRTHDCb9sW3oAWiOrjvxFdJDU0t2VL9x8sdozoisWxk78QBdIIHsfuX
         +SHRC74F1T4Tk49c3hVQ9VpTFimSl0waXNBGqJtx6wp/YHJW6jgOFaoGsIGa4NoGO8cC
         O3QoRVNpooxTCyXJuOZ3Id1Ey1vmJEormce/rQwbpqUGqndZH0v5vhspZ5SmvH06AuMj
         6ZvOVPAFe7pBWVWGeNQ90a/6o0GhxmsoD1QretiU5sLH8c4uHJ/Y2m4VHx2P8KujeJK0
         UVMwq9wpHTqMAOxmedBXnQQPEJ777IGjSqIZom1AlU4sR5C4pL1remYh051ObnqGuhHv
         KEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718870726; x=1719475526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dakUGhqrnLzB9mnNo0IKnWBzyZqbbKSfGuNLa4v3K1U=;
        b=NtY56Eyt9KiwWW0kYiMLPKbfnRu698u7MDSQfh7Aj7yauNFsTKYzqujq0wL7BFcrmk
         tQNf2N3xp8YdqbIemZSTjstz4PU4niqhJVli//hot7H+fzfbuUzajuzD+IkKcSx5wD9L
         3xt1Vzi0qgw+Lu5kcrjTcyNLxalAD+ooT3ZnWbDlh0V8BlMOVCQ6H6PnRgThUPbbfjaA
         ZxOxe+gZx6o/ov30w6FkgEINq3/nWe3+oYQRX0UQmG2AH6QzUa+6SSgMDFvnhb+Rp0VD
         rhe+2pOUpmRihCH7pas4gPAu7U73qucHF49vjwa93iTF8tiBrg8aQKtQad0wiR+syMRR
         TJcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8h7bJKqX5yRer4/w96IY1lcvaGWm9HXcbJ4iJ+TGEQ5R2VmnixAdIPdZF3u0rePApdHrzfpAHV13L5InnwD+faUS4g32VOTYBNG0j
X-Gm-Message-State: AOJu0YzMHcKVfzQQ76YLe+lqzvvp3+k83wjyj0xaS+xNWyGTtpN42/Bz
	Y7KKTchArQDvt7/ZvC/+LjPSM2ycDtXrcZJqrOKPtfXpJPpPKAxS9bPy/KgThpc=
X-Google-Smtp-Source: AGHT+IGIgwZB7KgN6IuNTo5vHCsjNBlcvHNhq8+jPn9RYvIJI4rtbggqu0AMU3iWTk7RGtK7PqiiHQ==
X-Received: by 2002:a05:6a00:8993:b0:6ed:825b:30c0 with SMTP id d2e1a72fcca58-7061ac2e955mr9532567b3a.15.1718870726368;
        Thu, 20 Jun 2024 01:05:26 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc96c8c5sm11805889b3a.58.2024.06.20.01.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 01:05:25 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.co,
	dianders@google.com,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v4 1/4] drm/panel: jd9365da: Modify the method of sending commands
Date: Thu, 20 Jun 2024 16:05:06 +0800
Message-Id: <20240620080509.18504-2-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240620080509.18504-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240620080509.18504-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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


