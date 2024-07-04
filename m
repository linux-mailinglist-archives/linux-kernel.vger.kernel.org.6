Return-Path: <linux-kernel+bounces-240663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 360939270A1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB03288300
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 07:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2C01A38FF;
	Thu,  4 Jul 2024 07:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="PwVme4Ve"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449101A2FCF
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 07:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720078225; cv=none; b=Ik7dFwCPF7FpaRbxgO8lAwjZ1cGWBEYIoQKp9zfPKu7hCi74pEJq9MsBEqRQRIZaaIXeBezyRwbtr1diDph2wXjypY6DSHf/Gih4JHkEaaCwhlQkCv7U8jhU1ekhDR8vZ87H4T79NxcbI0AnAnm3Dpgx7U/gfU7r1e10fKNNJco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720078225; c=relaxed/simple;
	bh=1HtQIw/F554XqyBf3fxv9byew8tC9OUoFF9RTeTPC6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=FSeuYisnWY7VVTesTZpZXH04Y+2ARHtjNIh90Le/UDADPTQuZ/b2V0RY9tiB4q7CMuXTPHbhPWjwZyn7frVUJ2C+ZHdCmosZ+0a2cYN2rnqZO35oqDIDqTHFYh4GK8fVpu41khY4ZVYuePo0TVNMbrEUk2FQnDr7A2YRqJvJmTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=PwVme4Ve; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-375f713a099so1288965ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 00:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1720078222; x=1720683022; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=njjqiW8Ns8mYNrJ80NgEfDcYprJVubWaVkRJskWAXIs=;
        b=PwVme4Ve5yV9ti4U8XiLFeaHS7pE923fpGqFl1e85YWFr4rdw1u0ya1nDBrE+I5q29
         czK5i+fRk2TPA7ixuzHVXV6grEyNAr70hI+D6UjE6pX2v+s8tI2c7JyJzCLOqJtGb0nS
         EkU5sc9MOuepJ+KIi1FOy3LBSJbDAlpXGecyFhonITYC9eVIMu88o7AWbGWxXoOALsCj
         Wfu7FJBe6V/jbAfrBGAmmgNpLbRT6aTKTOQwk+nPQh+UBsEqmu0SV7yi6WlyEVOZ5IE4
         ndS4hS9IQTF3GKKOxeiVTvojKtsYCSODimFNOPMrOc6U8p0phQAjrwTTvugcEwxAxhYn
         Q6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720078222; x=1720683022;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=njjqiW8Ns8mYNrJ80NgEfDcYprJVubWaVkRJskWAXIs=;
        b=ip6EPNFjz/iha6f8VOALRlaz965zQE2K1KzjvzQvsrUQ5FUuNOJU5N+tEiS9S56as7
         aJfwKHT1h0xWP4pPTFVTPHyahWQWdXoTqbdTKZZSHlnYPTHdAnFu3MIwJYUYM5YOng0d
         xkl2i+JrVAxnG23R7vwUNUCsU4d7O7DZqthrHL5J0Uu7aVtV4qrDi2bPxvkzHVtwk5MJ
         XBHbhLh83biQm8AcDVhZOHWs7DD/OtAKEwtjjRhfil8H1XRroQZ82TFhVhRMSlrxi3Qr
         pcTAJfgJVMzJrBfumCkIe9B2i1h7lQ5MliyJatLhcheVOvlv7d+DDu1Nw26saOTXYi//
         8YAA==
X-Forwarded-Encrypted: i=1; AJvYcCXJAEftCOQ4mwA/l1nOumyeQH0dTMsGC+PbBWWRCmAbk6IFYZ/QHruRWWwx2MBOPwpptNgrs3zDE1326yRtA21p1Uuts4Bk/njNI4ck
X-Gm-Message-State: AOJu0YweVP3B5j+AMapheD8nesNgtFBMAyCoEct1W2nA5TTMNhpLwOVH
	rOv4+Y3YCcy3AsVTW1QfVeD3m74WhAViZFFHHqIUnVYh72HZF0dyqpL3g6V/a14=
X-Google-Smtp-Source: AGHT+IHq5LpUPHgza6khej7OkvBbetS3RDUKCfz4i9ClMIDyTpJOLGhpWp+pTp8XNe59IpOUtdzLfg==
X-Received: by 2002:a05:6e02:160d:b0:383:8ec6:6d0d with SMTP id e9e14a558f8ab-383953e2419mr12869495ab.0.1720078222348;
        Thu, 04 Jul 2024 00:30:22 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6a8dbb2fsm7735699a12.31.2024.07.04.00.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 00:30:21 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	airlied@gmail.com,
	daniel@ffwll.ch,
	mripard@kernel.org,
	dianders@google.com,
	hsinyi@google.com,
	awarnecke002@hotmail.com,
	quic_jesszhan@quicinc.com,
	dmitry.baryshkov@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v5 2/5] drm/panel: boe-th101mb31ig002: switch to devm_gpiod_get_optional() for reset_gpio
Date: Thu,  4 Jul 2024 15:29:55 +0800
Message-Id: <20240704072958.27876-3-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240704072958.27876-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240704072958.27876-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Switch the driver to use devm_gpiod_get_optional() on reset_gpio to avoid
driver probe issues when reset line is not specified.

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
index 159e401ad0e6..9f225c15b21c 100644
--- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
+++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
@@ -286,7 +286,7 @@ static int boe_th101mb31ig002_dsi_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->enable),
 				     "Failed to get enable GPIO\n");
 
-	ctx->reset = devm_gpiod_get(&dsi->dev, "reset", GPIOD_OUT_HIGH);
+	ctx->reset = devm_gpiod_get_optional(&dsi->dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(ctx->reset))
 		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->reset),
 				     "Failed to get reset GPIO\n");
-- 
2.17.1


