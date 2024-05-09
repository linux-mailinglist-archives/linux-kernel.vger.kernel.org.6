Return-Path: <linux-kernel+bounces-174031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 233508C095E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD703282B6B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 01:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F2513CAB7;
	Thu,  9 May 2024 01:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="FmmQjiMD"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC3313CA87
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 01:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715219590; cv=none; b=tDSi3XW9ACw2TKkkDHNr/vuWwzYx+z2ngab9p4YWGi9Ohwnbkp+5Sg39vwI6FDeZV7XpGq8gQIFo+2CuMFSK7MgmG8jg3bu6i6OEQ8gjRl47AK5S4AHgtD7E6qxm+399km+M7ETYVkF7074JSjI0Jr8Y5WwOmHz91otJRlsJk2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715219590; c=relaxed/simple;
	bh=4fLHwQPGk0QeNw9l9ZAq3BhROY3TA9pGgOZXf/44uJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ry4r2DBz2pVrsdMB+UvCJAh4kWI1hcTOmUdkD3c8a3nmlNmXVKB4qrT2GuuiEVWiRmg6cDi7aruXn4tgnLEvhSywrQG1IfZTAtaiBLZCQx8Y2fYLQpjkZNXDsRkwnwwUbG3yiWNOn+f4dRlmLDC9iBB698s6qFpWZGunkoV8EuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=FmmQjiMD; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1eeabda8590so2467075ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 18:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1715219588; x=1715824388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdgMcjk2SUhSnewSfUlS0/MTnaKK3tPj0hOvx8EtZQk=;
        b=FmmQjiMDUGgXDBUai4MVzxqDfAKNcT4zER6EIuXhSVbEortFsI1UJiJ/7RLJtyIREO
         jV9eaVjSnrtiCDUMNxj770CpsuGtROhbNuD/vEMJicui/JF8//QOjJDTeZUa3TaYqY1C
         AiJqIv3mTEN5YOFcYB/APJTnwgIRfSJdpG8IbcMNr4Ql9H0UqojqsUkAGox2tpsrpCMk
         H7GZBB0MPaTojlLdwehmPOxLcDyKb+kMZFaT4308RdMn8HzvdW7VS0/cD7eCoaEu+KbX
         gAXqLobgX4bBY9S+McuVWFtyOxKB2WaPXIYBLC20ubXD8oFtxOjtncYo/d6v1XZAqCn8
         ebEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715219588; x=1715824388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdgMcjk2SUhSnewSfUlS0/MTnaKK3tPj0hOvx8EtZQk=;
        b=H2oSaoQiBBUveKsqPqbGbWUs1lGMmditUyRxIxpV4gCLY+JwOE1tgR6buGl4TXXBHQ
         CaARuL9aEqyUYyLvS5QcntQD6unsn71s8ZW3uNfUlM2Q1e0573r6MzPHrBfZtN6linKf
         g2inQarjzycYS3xHKJV2M5hROSppPQtxpFcCtvBfCVYd8EodKrYpemNpbhW5ejO7Mi77
         iUE1URYRTo0qQd1M/E6p5C6vj66s3pkPK+/cCqFB8J7Yn5eFyAUncKHTE2tQZMQ9kBnA
         6J0xw+Lay+9zPrCemtTMKZ4XMVt3WHZHOJ8zj94g1LA5VDtLNNvju+qfoAvQqV+Rzx7G
         YEAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW/72hzbWE7AdjcCxNPnIgharGZabsXgHT+gZOL0lGg8axQM7km9ehOfwzU4jJn38iUufweRd+cA7xbeMmpLZ7HgGP15cD0cM3wgcx
X-Gm-Message-State: AOJu0YzUbUSZLrrSVQtCZb/dUr6JRxiLJpABL8k98TfP6En2xOzmSk94
	kjiJ8sbLa7+uXaitV0XFujukr3Zv2glJp6Yqd8OgPOe1W25QpddDZMBZaNPxZsM=
X-Google-Smtp-Source: AGHT+IFuZ1ciQmQfC4rMtuiuLyVXsr/sSBUXfOirzhQb9N/x2TesGhuSmdYudAFRFjbHiyWukwABIg==
X-Received: by 2002:a17:903:11d1:b0:1e2:9aa7:fd21 with SMTP id d9443c01a7336-1eeb0998c52mr48491225ad.54.1715219588654;
        Wed, 08 May 2024 18:53:08 -0700 (PDT)
Received: from localhost.localdomain ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d15dfsm2117465ad.62.2024.05.08.18.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 18:53:08 -0700 (PDT)
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
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xuxinxiong@huaqin.corp-partner.google.com,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v5 3/7] arm64: defconfig: Enable HIMAX_HX83102 panel
Date: Thu,  9 May 2024 09:52:03 +0800
Message-Id: <20240509015207.3271370-4-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240509015207.3271370-1-yangcong5@huaqin.corp-partner.google.com>
References: <20240509015207.3271370-1-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DRM_PANEL_HIMAX_HX83102 is being split out from DRM_PANEL_BOE_TV101WUM_NL6.
Since the arm64 defconfig had the BOE panel driver enabled, let's also
enable the himax driver.

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2c30d617e180..687c86ddaece 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -864,6 +864,7 @@ CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=m
 CONFIG_DRM_PANEL_LVDS=m
 CONFIG_DRM_PANEL_SIMPLE=m
 CONFIG_DRM_PANEL_EDP=m
+CONFIG_DRM_PANEL_HIMAX_HX83102=m
 CONFIG_DRM_PANEL_ILITEK_ILI9882T=m
 CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
 CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
-- 
2.25.1


