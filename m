Return-Path: <linux-kernel+bounces-252497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 135B99313EA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442E91C2173A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D1318D4B6;
	Mon, 15 Jul 2024 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wfoDu2s4"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFD718C186
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 12:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721045771; cv=none; b=jbPBkiwFtWm01fIggF7WYwQze+qiI7hWGT8n71//C9jQUM+A9p3IUMc6vv4xQBVVd6PHvcyTh3hw4esiqxXGf4aLPKyp5hsUR/Jbf04jcpfr17xGAaaXVQIWDY/joYON4G40yvLaU2WZ3iCR0rZkqwgJ13EuEMGH0YVicfLf+xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721045771; c=relaxed/simple;
	bh=ensaB3Sd9xExyqosO4x4Zulfh8zxqrHJ2g7V01Sv1AA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zsmm2I7fbW21y001GUo8GMpWjbk4GrBWKxDSGsOQPOiYVzH0pmhxixk62jYYm0PxCT50SpiaSKPZkjX/P1vn/FawAUE+4wFvpPS57Cht9aWaD441T7xJRweRUCIU4IcPN6CJkv9mkoI+5EQaOHYF/11VdRJqJT9P43hjEYKvj3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wfoDu2s4; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-367b6e5ffbfso2354107f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 05:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721045768; x=1721650568; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kTq2r+cTBBf6PJ97371cfxGvOYB5A8cmvVmwB9VmmPg=;
        b=wfoDu2s4Hi+kMtiB4X5oD6fBKi62FoHAU6/B/6ZSXxoXvgtA2IQstHH0VYFU26VMh5
         /T6RdWHd4Il0t3FTX4ItgatvMogsni+hF0+QGaDUWuCUkNgSFSQvBH3msxJEFrK/GlyN
         MiReNX6uSFsE4erBLEajrdZLW+XhqLfggLwOg1H/2BmZzd9QUexzpEr2BKXIn2VZqIWd
         pNSgI6lpP5rItElsrttHCzFEiyWFAiJYLcOkEnLBSPm8B5PAl8banRh4NVjB9+o6hUWe
         us3pUAKRUXoo2BVPySQtwIhV3+ea295DLFp81C82SHvfjBYCFgon9cqdgy+HdIHygkLN
         ufmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721045768; x=1721650568;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTq2r+cTBBf6PJ97371cfxGvOYB5A8cmvVmwB9VmmPg=;
        b=Mz9FlWZKbnzmcIQ/upgLDzXFFo3SVjPMGbbY02Iz3Efg2I0TCUzCox6zq0yiT6yTEv
         cL9uiWy5ywFSNhUbbrVvbUjL4Y2LzHuxW6syS1ZknRFAB4qST1FqTNMH8gT+F79tduiA
         iy85eHW8+WhZDdELqf88dp+KYAnv2v/F4RlBOYkEC/Vvnlse3vPKUYHlNutTSfPJo00W
         wQ0QEIwJVV44dC4q0S+sIp4RCrIyLsZp87siWWyAfKarlAjhR7SHwABRGzw9d3YMtyqw
         yILXZYCLSoybtJne7PaJU/y1Bh+OdZLlZRzUOOQW5J8W7KBMWWk0OZBLZHlArFCX/tnx
         Pqag==
X-Forwarded-Encrypted: i=1; AJvYcCUS8ZlsC+60rXVO+0O/2zx3dy5xy+oqoWP+9btqYWXHQM/L7i9gMY7GEqNx2FaSK56eot6ac4bdMcMqWmWIMnzj7hMTxCiz6uM3Q4lz
X-Gm-Message-State: AOJu0YzvYpIqcjz5VY3AwKEZ5iLNag+Vv6I0AESVizAKWCN1X/Ogb6eL
	2OkBtVIf+Gl+nl1rK/l/t8DXfcA+q8wYGxD6KrZkzLdSq9MQ5ctH9HrSdAJolvU=
X-Google-Smtp-Source: AGHT+IFs1erFYCijcBGp0SVQyMBvfH9pHBYbLhKOfck+AMcQPdS3cmXHK20l4yRwr/hKh+tKqHhBsQ==
X-Received: by 2002:a5d:480c:0:b0:364:6c08:b9b2 with SMTP id ffacd0b85a97d-367cead1d1amr10964785f8f.45.1721045767976;
        Mon, 15 Jul 2024 05:16:07 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff1f:b240:886b:1a3a:7569:3d95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680d9771aasm6369201f8f.0.2024.07.15.05.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 05:16:07 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 15 Jul 2024 14:15:40 +0200
Subject: [PATCH v2 4/4] arm64: defconfig: Add
 CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-x1e80100-crd-backlight-v2-4-31b7f2f658a3@linaro.org>
References: <20240715-x1e80100-crd-backlight-v2-0-31b7f2f658a3@linaro.org>
In-Reply-To: <20240715-x1e80100-crd-backlight-v2-0-31b7f2f658a3@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Johan Hovold <johan@kernel.org>
X-Mailer: b4 0.13.0

This is needed for the display panel to work on the Qualcomm
sc7180-trogdor-homestar and x1e80100-crd.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7d32fca64996..362df9390263 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -887,6 +887,7 @@ CONFIG_DRM_PANEL_KHADAS_TS050=m
 CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
 CONFIG_DRM_PANEL_NOVATEK_NT36672E=m
 CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
+CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20=m
 CONFIG_DRM_PANEL_SITRONIX_ST7703=m
 CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
 CONFIG_DRM_PANEL_VISIONOX_VTDR6130=m

-- 
2.44.1


