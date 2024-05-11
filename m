Return-Path: <linux-kernel+bounces-176377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 068838C2EDE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 04:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 813FD1F234A7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEDD1643D;
	Sat, 11 May 2024 02:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="Mg/NjLVK"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525FC134C6
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 02:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715393619; cv=none; b=gXOwjY2UsnlLIDqpb8X4U6wjpVp4WRfBjlsAa6nkJ3d+L4qhck9k5sLfgXtYizLHKA7+Cg5Qu6Rn4GWlPo1s8uDKKC2EisHs0R2BnhkJMudgzkU1plmt9WvOlPlI/wL2et4b4pr5sBpPP5+Wuv0bfyeDousTAjKSk4KlhTBQ/Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715393619; c=relaxed/simple;
	bh=qBAOC4KkqVTsAshuHxipdIkwbOHhvzUMvDxIuuHoKsA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XIM7rvB1/MRoBR86VZ34gNRwJNBbUaNUNI6Bp6KwoPJmtKRCF7FuUTBTYFezwDWaNfUqICMCVWAKqEtbdsMb2MPwrkUb+a8v/sL0by6eDdJ18kb8T2SD++yhZVb7PEPPfzgAJyjFL9Dquwtg6HS6VFvYf6Ww7edsAkXAmF0xuyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=Mg/NjLVK; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f4302187c0so2610446b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 19:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1715393617; x=1715998417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ro9Gj4s2KJidLF5j2cDQmmJU7+8x9Tzsgj7WCx41KcY=;
        b=Mg/NjLVKb0t6qnO3BmZc+9mjeN0KlEMZD+1PF97oyD7d+7dZFQTpk0WVfxaF+6kNLQ
         oBVSoAXPdh+y0Ls6w2DlzrP6bU8CVe4rIjK0crWGlYwI/z6QrGBt/URbj2Dsth1rBAi2
         m9Oeq9P3uw+eo9zRJzEfarAZ/ga52A4KH+harCgxkLPO07GNVgX01sN3gZSCuclND6Qb
         m3vo0Nhezybc6UlHms5ATgtbUT4UCWZ9Qi6kvxwS6/QNW2sM7skHu+q9/cSPCqNEp9Jd
         qQUWhj+XK5BjWBJUfSBJlaJkOpEc4T8wdF5fSzMQH3sN6ZjiJ4vqoDqtnlYHBacbPb2y
         loRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715393617; x=1715998417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ro9Gj4s2KJidLF5j2cDQmmJU7+8x9Tzsgj7WCx41KcY=;
        b=N3qEoinR04IThbga/7Ppux9Mlkpo3jpErFyHzdlCUxl2sE+NdaOzohSPWwG132YNiz
         RQDFX4HgpoMrOyIvoPOcmvuvKHpDK0/x2deeRvHh7byQxq6DQ/2GoF7XWEcXVQIDeTSN
         +jcwpayfbOx0BM7b8IIHFwiar7zK4xLw//Q19HNttx1PMHMr5rFBMQoFx0807yfm3AkD
         ab+FoiUgE9c+RAOAZDzSBH3e8bmKAUGK78twtcm9Hg2JyrqysrCSyj50QpfKxKLjApta
         AeP3THn6mU/BDS6o+ywwcoJXFatShHdlFZvsFUiqacXATXxLlx1yH/f/GEBwbqWe22ta
         oClg==
X-Forwarded-Encrypted: i=1; AJvYcCVEV6aH6CJnmV2H7pfPt9ZsOEAUESwvHQhERiluH3k8k6/3yjsBDD4FVZB5eNXb6kM4qohTQDOTSR4FlgkEUWwBuSUlCmk6Pvi5/2SS
X-Gm-Message-State: AOJu0YyYI1nN7f/oDkE9xbjwhkTpQL+shDvmR/tiyyKL7AomP/edQNN0
	x/upp44zUdRfzc8p1DWfVj7/YTYp9XHxnozL1PUHTvIzMZsC7z9uzWYjtWkUBRM=
X-Google-Smtp-Source: AGHT+IH5UAoi6zEEiaiBde4SESiUMnjHXNGfQ6nAR1zwD1VkVFreQrCHTiNI4cjlIrD40CMt7gWQbg==
X-Received: by 2002:a05:6a21:c91:b0:1a7:590e:279e with SMTP id adf61e73a8af0-1afde07d798mr6686077637.5.1715393617402;
        Fri, 10 May 2024 19:13:37 -0700 (PDT)
Received: from localhost.localdomain ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a9d9acsm3680340b3a.90.2024.05.10.19.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 19:13:36 -0700 (PDT)
From: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To: sam@ravnborg.org,
	neil.armstrong@linaro.org,
	daniel@ffwll.ch,
	dianders@chromium.org,
	linus.walleij@linaro.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	airlied@gmail.com
Cc: dmitry.baryshkov@linaro.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xuxinxiong@huaqin.corp-partner.google.com,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v6 0/7] Break out as separate driver and add BOE nv110wum-l60 IVO t109nw41 MIPI-DSI panel
Date: Sat, 11 May 2024 10:13:19 +0800
Message-Id: <20240511021326.288728-1-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Discussion with Doug and Linus in V1, we need a
separate driver to enable the hx83102 controller.

So this series this series mainly Break out as separate driver
for Starry-himax83102-j02 panels from boe tv101wum driver.

Then add BOE nv110wum-l60 and IVO t109nw41 in himax-hx83102 driver.

Add compatible for BOE nv110wum-l60 and IVO t109nw41
in dt-bindings

Note:this series depend Dous'series [1]
[1]: https://lore.kernel.org/all/20240501154251.3302887-1-dianders@chromium.org/

Changes in v5:
- PATCH 1/7: Modify compatible format.
- PATCH 2/7: Modify hx83102_enable_extended_cmds function and adjust inital cmds indentation.update commit message.
- PATCH 3/7: No change.
- PATCH 4/7: No change.
- PATCH 5/7: Adjust inital cmds indentation and check accum_err before calling mdelay in init().
- PATCH 6/7: No change.
- PATCH 7/7: Adjust inital cmds indentation and check accum_err before calling mdelay in init().
- Link to v4:https://lore.kernel.org/all/20240507135234.1356855-1-yangcong5@huaqin.corp-partner.google.com

Changes in v4:
- PATCH 1/7: Update commit message and add fallback compatible.
- PATCH 2/7: Add hx83102_enable_extended_cmds function, rename UNKNOWN CMDS and depend Dous'series [1].
- PATCH 3/7: No change.
- PATCH 4/7: No change.
- PATCH 5/7: Depend Dous'series [1].
- PATCH 6/7: No change.
- PATCH 7/7: Depend Dous'series [1].
- Link to v3:https://lore.kernel.org/all/20240424023010.2099949-1-yangcong5@huaqin.corp-partner.google.com/

Changes in v3:
- PATCH 1/7: Update commit message.
- PATCH 2/7: Drop excess flags and function, inital cmds use lowercasehex.
- PATCH 4/7: Update commit message.
- PATCH 5/7: inital cmds use lowercasehex.
- PATCH 6/7: Update commit message.
- PATCH 7/7: inital cmds use lowercasehex..
- Link to v2: https://lore.kernel.org/all/20240422090310.3311429-1-yangcong5@huaqin.corp-partner.google.com/

Changes in v2:
- PATCH 1/7: Delete Starry-himax83102-j02 from boe,tv101wum-nl6.yaml, add a new bindings file.
- PATCH 2/7: Break out as separate driver with Starry-himax83102-j02 panels.
- PATCH 3/7: Enable HIMAX_HX83102 panel.
- PATCH 4/7: Add compatible for BOE nv110wum-l60 in dt-bindings.
- PATCH 5/7: Support for BOE nv110wum-l60 MIPI-DSI panel.
- PATCH 6/7: Add compatible for IVO t109nw41 in dt-bindings..
- PATCH 7/7: Support for IVO t109nw41 MIPI-DSI panel.
- Link to v1: https://lore.kernel.org/all/20240410071439.2152588-1-yangcong5@huaqin.corp-partner.google.com/

Cong Yang (7):
  dt-bindings: display: panel: Add himax hx83102 panel bindings
  drm/panel: himax-hx83102: Break out as separate driver
  arm64: defconfig: Enable HIMAX_HX83102 panel
  dt-bindings: display: panel: Add compatible for BOE nv110wum-l60
  drm/panel: himax-hx83102: Support for BOE nv110wum-l60 MIPI-DSI panel
  dt-bindings: display: panel: Add compatible for IVO t109nw41
  drm/panel: himax-hx83102: Support for IVO t109nw41 MIPI-DSI panel

 .../display/panel/boe,tv101wum-nl6.yaml       |   2 -
 .../bindings/display/panel/himax,hx83102.yaml |  77 ++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 133 ----
 drivers/gpu/drm/panel/panel-himax-hx83102.c   | 738 ++++++++++++++++++
 7 files changed, 826 insertions(+), 135 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-himax-hx83102.c

-- 
2.25.1


