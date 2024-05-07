Return-Path: <linux-kernel+bounces-171476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0E88BE4DB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5731F23B1B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8337815F3F7;
	Tue,  7 May 2024 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="lrKeTC/d"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97EE15F3FA
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715089989; cv=none; b=H6+bgtbGiYgYeiF8wMCE3eEq/73mg01AQDtE+IAgiinXyLiLGCcQX4/odi5XXO4mtYjkAYNDCJPxWPiEWE2O8mkfdghlizuRlZ8khZW3KWb2e7nH1YGNZoByIGOAASst6D2bScnk893MEbE6Ix7QFXNlj5kYkFi9mVU7IHdxcGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715089989; c=relaxed/simple;
	bh=4fLHwQPGk0QeNw9l9ZAq3BhROY3TA9pGgOZXf/44uJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WHVvF1qetJf7/VVBWYkr+5P9OlfHXVDkuFpodfaXEeLt5V8GNIK3v73Eapm3/H+oXjjAoFpWq2IYYFyx3dhwscLfYyK8yMgK93wHzi6NcfESh2MKy8m5NUbTt2sECK2vTaRtZAE6/+lyUQ2geQPuEKtmsZ/d9ay+Bi5ByM5Zp2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=lrKeTC/d; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5af03aa8814so2181208eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 06:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1715089987; x=1715694787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdgMcjk2SUhSnewSfUlS0/MTnaKK3tPj0hOvx8EtZQk=;
        b=lrKeTC/dr3jUb+YFo4QnSV1YNkEUGo76YV6guUnBqQ3zWF6m/Mk6UdPRskABvKPZO/
         AWFloNzXKb1PSCI3yzclahq8GoqtbQmjvHY2RHLEm1TiVOz+Ivq+QaFIPZtcxv/ictPV
         s3i8kwwxgolI80B+TQfTsgH6RBq5ujLUy6weopl2MpvdNAUPONqPkzNK1U65UVBOYzG2
         blFi1Q4RNnY7y2Qewgj+5b0+dhgLaGOzKLgrr7W+Gu6qHq4qRXr+qYMJ9kB0MPgwTrF1
         CZlpHrXe7CqA4S16CQ/wSb8SscjKuEOwmjU0n8FIBZZIF7B+BYl5Pj+pUAcJppb2zlat
         TXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715089987; x=1715694787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdgMcjk2SUhSnewSfUlS0/MTnaKK3tPj0hOvx8EtZQk=;
        b=K3ppD4IwwuGhvYHv9N4Qr1OVG9NF0haefXb2+LJZo2rgX93zhrmo2KI+NgwXX7mpdQ
         coJfOX9upY9aVtEZMM3VBVcHSljJJxDBgb6+nWM53TeePlOnFbhf3pkbpdp0YEVYIs/C
         QPAWeVL6uaqBXiV8c9Jt81EAyX2IgXo+okkVXtgFNJY5+mKbGSd709u+pDfU1GDmTMb/
         gy/mId21rojQa6YUS86TzffezXw2wKdV4l/WQZt1sWkCLvi4DO4yEnxTLg1UWyF042L4
         B1O384+Dg9hRFyZWE/4tTmDAEjgPASX5/46veD3s4UTfjHDry49V5oq5sCDubMh6u6Au
         qDWw==
X-Forwarded-Encrypted: i=1; AJvYcCV5VMEg5yd/ceOgYWKvdokpeyX7/UexnB0Zr7VEo7x1MuMPvO8Z0yStONPFktMmkVkjpfYdXS5gswAFWE9OZolcVQSKDAjCEbIu8Wk4
X-Gm-Message-State: AOJu0YxdhoJW0rVC9mD5tfyW4BQjcix/+X3fDCMsjRWfjlEX/tnY05Ja
	1J2o+TQ5ZKpD5bYQ5XsEBz+dt2M9Jdrm6aDnNcFXeU9SBurIyHaYFIii7y8J/DA=
X-Google-Smtp-Source: AGHT+IE9obv3BpQSyoBColioAcwozW3A062gFLNakZyDyk37X93rIIhLS1HS1uSg/WopCyDk2ODppQ==
X-Received: by 2002:a05:6358:2616:b0:192:4bf2:a397 with SMTP id l22-20020a056358261600b001924bf2a397mr3260074rwc.17.1715089987051;
        Tue, 07 May 2024 06:53:07 -0700 (PDT)
Received: from localhost.localdomain ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id e7-20020a63e007000000b005dc8702f0a9sm9850542pgh.1.2024.05.07.06.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 06:53:06 -0700 (PDT)
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
Subject: [PATCH v4 3/7] arm64: defconfig: Enable HIMAX_HX83102 panel
Date: Tue,  7 May 2024 21:52:30 +0800
Message-Id: <20240507135234.1356855-4-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507135234.1356855-1-yangcong5@huaqin.corp-partner.google.com>
References: <20240507135234.1356855-1-yangcong5@huaqin.corp-partner.google.com>
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


