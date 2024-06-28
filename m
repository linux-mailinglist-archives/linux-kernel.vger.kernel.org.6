Return-Path: <linux-kernel+bounces-233895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD33491BEE9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96821C22683
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB5215CD42;
	Fri, 28 Jun 2024 12:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="DlnXkk9K"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79D915920B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578705; cv=none; b=fy0bQGSUIAE0VOAlvZc3C4I6NpIVssaZ9ilDaFEj1JsF338xSgbuYxeqk97FecaI0dNqCH5pLXwJQuwQXV19fJsZ8ELXrjBukgNEWLkgS0LDpRpe7CzjvngVnCZ2hqs5aQ7Hw33iDo2jHKIpE/xcRM63lZA1pZjhXU07i/AOWR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578705; c=relaxed/simple;
	bh=3Wr3HwAp7vIf3GIE6N56s2VaPqa+C6jocnxeOEJv6eI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U7LQqIHhLupa45gly+wu1utmGE8JCgy1jxE2QfYE3aXp+hVnshsqR+1IYsPEjofYPsM1+u5TgPJRYGputRNinavr5tU6T1T4JJiy0ufN+evr+WzS5dFZjV001+HhDFNJ2VP+8vpWiaslg8KmTWb+Ib5RCnMahwFS06TOSeV3c9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=DlnXkk9K; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f480624d0fso3431295ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 05:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1719578703; x=1720183503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeseQiv7/DSaLni1dvL6OOnrfuUA5o+HEQL8eICjloc=;
        b=DlnXkk9K2hhMBdZmCFcFWn2RieutYAquKdfanhGfH1eWaZokadF+MB1AbncxNCCmMK
         cbZtbjcFxxtj9IRrIqiHa+ok6y0RHQi4KUbeFYwXiXk8KcsSn++6//S+qAx6Jjb6iKaQ
         OBJVIBSgLtX+o7Lr9Aiu2VSFdxK3MACydM6+BLojfAUR9ttDOhfXltB/00I+7LYCeGFy
         Ik9xEI1nSl7ZFVU/Zd3vx8m5NW7jU04ZVjrCfgS+33ENkKoWN7InE9Yxbq2YfxQLBmZn
         6MXP+gMAXJUXCooK/ay8R+8mCb3v6kTmpuVCFuOHHutEuwwRdBuAvfDEuudaAGqS8yOS
         t9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719578703; x=1720183503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OeseQiv7/DSaLni1dvL6OOnrfuUA5o+HEQL8eICjloc=;
        b=TJISPLkz5KQYJzxlzzEFiMslaaoLRHZStKAsKy2ccKCvWsF1DCqW5Ge0AIeApYwhC6
         Uh1N/vaRajbK5mBjIwNXSgjBCOisoua7EiYXTXytpCpe4bNR3WOzIxYZp96b+3YxOSsg
         WQ+lE7mo+kgo2sV/0Nb531rTLmjlKpoxQmh+xSi2wbvIdQtxCCbxLNvLDCkJ9N1SaiUg
         ysIs1bVO6W6MbEcNRSE4kbnneC10d1NHhquKS1tAcxJcmfLJ5kviCs+LSC50cqGJy/1A
         M3Jo3RBZ6WYeBlnkjeZ3QKw74ASFd3hrJpcykhTmKAfPDj7FtF1/w6fWmgAbwpbfiCd3
         FJ0w==
X-Forwarded-Encrypted: i=1; AJvYcCXicqNZTABpEuQoe+FC0ua3o1xNp5tS1DfP/Wu8WLmubBi3OPWgLFiSPNg+mG5ak+MlDhjXO87f13DwDtMhfdBaJPk4OS2H+jyrr/5M
X-Gm-Message-State: AOJu0Yx2ZwJGL2b+cINbbUOtqPMuVlODxRNn2VvMb72OBTRLhmGcjKZJ
	b+vZMy+HYpep3LYX9EPCr79HRMNTafDGCcor2c1H/SD5uDooQiksCA43mctzT3k=
X-Google-Smtp-Source: AGHT+IGWadE2l1MOGIvcH+qhTXfxLERu8D+lorl26DB268SY32VCtG8S/9RsP0BCd2bpECNPNyPGVw==
X-Received: by 2002:a17:902:dac6:b0:1f9:d279:a870 with SMTP id d9443c01a7336-1fa23fb2949mr156225565ad.25.1719578702961;
        Fri, 28 Jun 2024 05:45:02 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15695b4sm14346255ad.225.2024.06.28.05.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 05:45:02 -0700 (PDT)
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
Subject: [PATCH v6 1/5] drm/panel: jd9365da: Modify the method of sending commands
Date: Fri, 28 Jun 2024 20:44:40 +0800
Message-Id: <20240628124444.28152-2-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240628124444.28152-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240628124444.28152-1-lvzhaoxiong@huaqin.corp-partner.google.com>
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
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Changes between V6 and V5:
- 1. No changes.

V5:https://lore.kernel.org/all/20240624141926.5250-2-lvzhaoxiong@huaqin.corp-partner.google.com/

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


