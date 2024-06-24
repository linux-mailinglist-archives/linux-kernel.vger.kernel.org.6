Return-Path: <linux-kernel+bounces-227337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500CA914FBD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C40DC2824E6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401DF142E86;
	Mon, 24 Jun 2024 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="D9Jcr7Hb"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D265C20330
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719238833; cv=none; b=s4feUo6ryNHuiSNRJzAgueHNe0YGhwHz9LI+c2P+fy9KJNPLnV/YjMLLpGmG9t5miikDijrDUWvvmTNi/bugvlJJ5TnXvC+v6pknlOoNvfLi+1jc4ueIVqU68W8kt5LddgsYR6kGY/E6N/jJ/vW1JdxeKNRWRmD9AZpNM96kR8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719238833; c=relaxed/simple;
	bh=ViCa6clrizT6IwjuLrwfAkPPKfhrDVUfDjWsR1f0Xus=;
	h=From:To:Cc:Subject:Date:Message-Id; b=egc9yLaF47kLElhRMVaxDrsUSR9qew6TbdkxwSuc26vafPlIGGWnd1CSlfcC/4v9Es6WZUWk/UIj6Fb7E9eQF7e3cY9KPhKj65Y2LnXp2ByZRWfBpFC3PV4HKPkh40j3k/lDzqrp28DHSf2HycCKWdmTm+8qV+N0JMwFaxuYXtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=D9Jcr7Hb; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f4c7b022f8so38270285ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 07:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1719238831; x=1719843631; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwg4BQF2dSjJe6bI8pPiDT6kPYePsjlkVpxfKFjF+5g=;
        b=D9Jcr7Hba2n1C2ahmUhW3MENw+VpCyLf8ydUXLZTbF9wMskbbLNgw+BaWQNZR9IANg
         kDjDmrOOJGqgvECywDANidwDy2jmNG+RCtRqqCVfnpMlB0Iy/LdXVzj3xcr/s9oRmbnR
         3c16VD4u+WzYpVUqsjA3SFpJbq3GKlhzUUyhp2mcWhhW0Nt57sSoKAXz4KYFWt24XHfJ
         xI4iRoG5S9N4GOeWKEmmmRicOYUM0YsaT7GrPiO1jf+oA98Zeb6osIiXdK713f4bJ1m8
         hMJ6YLdnZWkLh9FSHp+5fsiUSs6XqtNJFr72dfA/dyMPPgbe9vfU4Nw3LUaow4vzWSNr
         I52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719238831; x=1719843631;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwg4BQF2dSjJe6bI8pPiDT6kPYePsjlkVpxfKFjF+5g=;
        b=FElNtHAjy3tI4LGV/iX+8UF6TMDU4Qdh2SQkRpKhzf4XLZSZQGmeHoEx4j6+p7rpHj
         u0pndjd+7VM3LobEWbJ81z2J4+pd0i7KgNThw7FsaDmMgXIQvsVCO0pM7lcrGnHL3GC6
         k7Y/yd5J9NZN3j85EJw55DCoK8hx7es7VmhO7L/oatKX/j2xJbY09irTlEL4N9+b1vPC
         tNeuwVztAPwn002wL04WakddwGDlsH1Pm5LNbMrNO1NuicLK3JnKpH06MxZSLs2cPBlD
         gzX3LzW/spSQpgs5IoVEbYqlnSHxFvYhJdIAFfNt0XDj463ODM+9FG3OCjxwxJfTAqvG
         tB9A==
X-Forwarded-Encrypted: i=1; AJvYcCWqcC/exLk+PvJDXrNytncCc1pTe77Ls/EvudOfkeDLc9aqRYtRBxkcnYKt1XSrIX4mG0v19EofGJx4jVF1/TTXiRSv8pOjLYTJpkt1
X-Gm-Message-State: AOJu0YwxsrEdF36tblImqRzwiV5GckwulCaxPyACuvXzhS5Myv1WFI+L
	rMXGNcfizGYJY9ouGo4YimkUQh6i0jG3wTDKCxIWUqQlg9jiZrAZFJ3STkCfKhU=
X-Google-Smtp-Source: AGHT+IGYlIr+em1HKoMDj2T2Wg7YebKnOS+eaCeriqn/VjnyS7h0Ony6B1U/lGY6dS+giJ8U7cEDnw==
X-Received: by 2002:a17:902:ce82:b0:1f6:81f9:cf34 with SMTP id d9443c01a7336-1fa23ecccebmr55180605ad.34.1719238831057;
        Mon, 24 Jun 2024 07:20:31 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d5fa9sm63243855ad.206.2024.06.24.07.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 07:20:30 -0700 (PDT)
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
Subject: [PATCH v5 0/5] Add kd101ne3-40ti configuration in driver jd9365da
Date: Mon, 24 Jun 2024 22:19:21 +0800
Message-Id: <20240624141926.5250-1-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This kingdisplay panel uses the jd9365da controller, so add it to 
panel-jadard-jd9365da-h3.c driver, but because the init_code and timing 
are different, some variables are added in struct jadard_panel_des to 
control it.

In addition, since sending init_code in the enable() function takes a long time, 
it is moved to the prepare() function.

Changes between V5 and V4:
- PATCH 1/5: No changes.
- PATCH 2/5: No changes.
- PATCH 3/5: New Patch, Switch jd9365da to use mipi_dsi_dcs_write_seq_multi() but no
-            functional changes.
- PATCH 4/5: Add a "_ms" suffix to the variables.
-            Use more "_multi" in the enable/disable function
-            Use mipi_dsi_dcs_write_seq_multi() in the init() function.
- PATCH 5/5: Use dev_err_probe().
- Link to v4: https://lore.kernel.org/all/20240620080509.18504-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V4 and V3:
- PATCH 1/4: Only move mipi_dsi_dcs_write_buffer from enable() function to prepare() function,
-            and no longer use mipi_dsi_dcs_write_seq_multi.
- PATCH 2/4: Move positions to keep the list sorted.
- PATCH 3/4: Use mipi_dsi_msleep.
-            Adjust the ".clock" assignment format.
-            Adjust "compatible" positions to keep the list sorted.
- PATCH 4/4: No changes.
- Link to v3: https://lore.kernel.org/all/20240614145510.22965-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V3 and V2:
- PATCH 1/4: Modify the init_code sending method
- PATCH 2/4: Add binding for kingdisplay-kd101ne3 in jadard,jd9365da-h3.yaml
- PATCH 3/4: Add compatibility for kingdisplay-kd101ne3 in panel-jadard-jd9365da-h3.c driver,
-            and add some variables to control timing.
- PATCH 4/4: Add the function of adjusting orientation.
- Link to v2: https://lore.kernel.org/all/20240601084528.22502-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V2 and V1:
- PATCH 1/4: Delete some unnecessary information.
- PATCH 2/4: Use the new mipi_dsi_dcs_write_seq_multi() function, deleted some unnecessary functions.
- PATCH 3/4: Add compatible for Starry-er88577.
- PATCH 4/4: Add starry panel configuration in panel-kingdisplay-kd101ne3 driver.
- Link to v1: https://lore.kernel.org/all/20240418081548.12160-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Zhaoxiong Lv (5):
  drm/panel: jd9365da: Modify the method of sending commands
  dt-bindings: display: panel: Add compatible for kingdisplay-kd101ne3
  drm/panel: panel-jadard-jd9365da-h3: use wrapped MIPI DCS functions
  drm/panel: jd9365da: Support for kd101ne3-40ti MIPI-DSI panel
  drm/panel: jd9365da: Add the function of adjusting orientation

 .../display/panel/jadard,jd9365da-h3.yaml     |    1 +
 .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 1088 +++++++++++------
 2 files changed, 682 insertions(+), 407 deletions(-)

-- 
2.17.1


