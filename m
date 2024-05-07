Return-Path: <linux-kernel+bounces-171477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 858818BE4DE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8C461C22EB8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767AA15FA76;
	Tue,  7 May 2024 13:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="Fkv96wlu"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0546B15F417
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715089995; cv=none; b=mtMJwbOdLbrnuklrzD4Aj4Gd2z401ZIocUnylQRz+rTODhpA/VZn89XhLGSlC/QIqpabl6R6Gce4GoaI/iCY410re5iDj08Y4cHVMrlexnXxuEiT6fWaucxBrcUjibcJDyA3hPpcuSw0R4xZe8N3kjeL0u8/FOuQhh5lwHX/gss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715089995; c=relaxed/simple;
	bh=q3tqFDR4pjUUTBbPe7r8ZO7nppYj3nB0VDvd35nuIEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gIOY+6782i/cegAXF5s4mDwH0plynn/8wCUOaZYfQXFzDvbm16MSTDcw/Sf9N6teiGbj82cfcAqbmE8MHjuSwNZMLNBrqeROcWqP7mKmvyoolFAH3JwHAjN03wpJxnakIYCQVFWBpH3TTcVNpWADcR2bJ2GR5byLUIQhSP71Vp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=Fkv96wlu; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ef98eee195so753133a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 06:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1715089990; x=1715694790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2z1QkSBs0nA42hb74SyIgvtKZtxxal/ZiPAbUcGcnI=;
        b=Fkv96wluhxIe3dnHKmgaUn33HInWUO2LyatBEfMBqY/8i4nbG+Pj0n4WCTYDTxFZay
         h2t3oO4lOYDqH5qjPwc1UyXJMwqIrGwQHEXjrMU3yc5HIchaYfshsm0hnuNTB3QENz++
         oHF8wOIYinvtO7sgrnv57Gm/E0gJI92YLbmj+hk+yGvdQoJVtYzbgnXgNCXV1zn7qG1t
         7w5Idg9dvdoAAnSRk+9f1Ippc15ZcB2iuegA6VMmqunbs/BYO7gs/V/apuhiCQFPTzH6
         D3/tAt7PaqFw2/YGFYEA4BCcgqUGPUowEqGH/KoKhoxFeYrusum2bKu1HCyBrP7v+7An
         c5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715089990; x=1715694790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2z1QkSBs0nA42hb74SyIgvtKZtxxal/ZiPAbUcGcnI=;
        b=v+bXdCIHSv08T1c22nLAwLwB+GWLmOywjS2VKHfmzK8pNemGG3i4XtvL8zcEhx/zOu
         bI69XoV3heeSI0riZgkfboeTqKsabmpNAqnUkWc0vMiE2mYNnjo08jZo4K4Mu+YzsxOZ
         yYwTVoF+Fy/5HPtVDC5MxNqL4bLQxnPGA1Kf9yorw5+DK0/Z/x6pobvQKy1xW7vy5rhK
         A0GA4SWqzcIjd5qGzLZ5Vk3MiucCiiJwWQfqXHDCBsE24igK0KcSIiJKrD6oh1qNVu6B
         4yFq99r3Bry5IHiul+4Q9FhPIZreBhqOOQgsMzMTONEBXTxPGY0kD1EC57bmIn1BUarq
         0wWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR6RhCeU54LTja7QhavTf96bc0VJYp++AKtiaJiiFPVKHCdcFXRCWXLCS+nPP3XtiZ8wtX3x/fyQhgDa+syLrr5FH1FmcZDGblCMza
X-Gm-Message-State: AOJu0YwE76TbgRVALMaSOjxLCOTpqveoZGCn9Cz33XFhOEup5RtaaUuu
	PU0fanwdf1Rr0LMmYflW/uwCQ8NYdZeuco/tGDwGGK/mvN5EV7xKZNrZvRayRpg=
X-Google-Smtp-Source: AGHT+IFXxq05MR6gPOSKc/twlPaMrS5Vu0444OOxUsgUZHAMSCm2oDtimDy7edXRikytf3AAui17FQ==
X-Received: by 2002:a05:6359:a381:b0:183:f62e:5d21 with SMTP id ky1-20020a056359a38100b00183f62e5d21mr15961201rwc.7.1715089989991;
        Tue, 07 May 2024 06:53:09 -0700 (PDT)
Received: from localhost.localdomain ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id e7-20020a63e007000000b005dc8702f0a9sm9850542pgh.1.2024.05.07.06.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 06:53:09 -0700 (PDT)
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
Subject: [PATCH v4 4/7] dt-bindings: display: panel: Add compatible for BOE nv110wum-l60
Date: Tue,  7 May 2024 21:52:31 +0800
Message-Id: <20240507135234.1356855-5-yangcong5@huaqin.corp-partner.google.com>
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

The BOE nv110wum-l60 is a 11.0" WUXGA TFT LCD panel with himax-hx83102
controller. Hence, we add a new compatible with panel specific config.

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
Chage since V4:

- No change.

V3: https://lore.kernel.org/all/20240424023010.2099949-5-yangcong5@huaqin.corp-partner.google.com

Chage since V3:

- Update commit message.

V2: https://lore.kernel.org/all/20240422090310.3311429-5-yangcong5@huaqin.corp-partner.google.com

---
 .../devicetree/bindings/display/panel/himax,hx83102.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
index 7cd720eb4981..53a6ace75ada 100644
--- a/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
@@ -16,6 +16,8 @@ properties:
   compatible:
     items:
       - enum:
+          # Boe nv110wum-l60 11.0" WUXGA TFT LCD panel
+          - boe,nv110wum-l60
           # STARRY himax83102-j02 10.51" WUXGA TFT LCD panel
           - starry,himax83102-j02
       - const: himax,hx83102
-- 
2.25.1


