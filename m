Return-Path: <linux-kernel+bounces-174036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D841B8C096A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A97AB2247A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 01:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C48913CAAA;
	Thu,  9 May 2024 01:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="OENnU9yB"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994BC13DDA1
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 01:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715219631; cv=none; b=cJoMVjfn9X0USNqdabPQkpI9SAy7ZqHPpdzGZ5cKfCQbyB36AlvcPWB8qJaNGdqTnDKIM9DNVLq+bxnTXspps4cm6CMBjLxbG8HvFcns/9r4BbMO3VO/yNDa6/0DhifekjAsrZyJZ+oCkd4Z9bD/6OVMKumkC1buzub1ogPtk0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715219631; c=relaxed/simple;
	bh=3nwo/SInj4wmrovcKTFziVm6y4+hsi02LkwMFGRy6YY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AVNniZKERxMbYti+KzsJiH69fAhzi9NTWWOON/t311NkQUrcE1WU6IUWhrwYq1BN2QaJgpCVALRPlP1afHZEil4k/ENpyo/8LetOvl1p3hINnhKUFmUg9Ee1czkGMOlALYh5X4iSc3sjew0GPzTRUX9exNx8YrhpoO2AHaYam4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=OENnU9yB; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-23f29434da2so262515fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 18:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1715219612; x=1715824412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lx35MtfPKU1z5v4/AzGpN1bIj57li6ybeEXD3S52BqY=;
        b=OENnU9yBZcAsi7VhEe7M5EPPHmVTro86HGYGNUElyw086eNcX+bFxOgZp2lIDiWMB9
         WAaEqwFyaFagWWbXHG2hFTk5yQeGD1nI112FFNIty8VRbAi2a79bYk9uX2IIhi2s95oK
         VmYoI68G0h3n+m5TdIxDANjyo/rAiEXEaxicNhJUZZbr/wJ7QaQBGRtInGlnWxibuLBL
         L19Di6vV1gAEfrl5/GVk97W4erhgSbTnAzkRByWKd8psK4B+dne3q7o4+eg/grU8blGw
         HBxiARvUxqPQWLOSOc+P31WooZKFcWII7dCbXV+msCuJskFF7tzOP/E1sjENSlugnLqY
         /SXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715219612; x=1715824412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lx35MtfPKU1z5v4/AzGpN1bIj57li6ybeEXD3S52BqY=;
        b=KCOR7mz0pIwLsyZHuDp6lSRGhZkPWI0kBXx9mDagdtwTZbrfuOLbkVaYPCv+HiJo3h
         KMYBO7ygnuUvweLvnpAHdP1BasDefazeUSmm2L4NFhZigDROEzUxVf3jK7NXHa2Nryun
         groZd6j794nm+qVobxjXS1TBbbhla27JtJiqbpVbhoa7ZQbbw/Fi2xtKJr1AdZiXCyre
         YSZPnyUp4BWxaepF/MNnrOuzIZbzfN03kN1/k10yPwIZA9ls3X2FEpq8ZqTpcFb+4Cpq
         otQDviQej9rh/stIVZwF8LPPIt3vKxAWi5hLWfZCeW7xycxGH9z/EtKPJOK8sgtTA6rT
         PRwg==
X-Forwarded-Encrypted: i=1; AJvYcCXkU8tvngInWzs45XuzgfKPyO+CKBbNDF59r2e3+/KCeQ6oGSAPIFjXbcs6i9ApdbzZW+0v5olkSm4rfp8EJfPH4UVviBUmdQl7lhNa
X-Gm-Message-State: AOJu0Ywzb/Hcwu0w4iH502r3tt7uGW0uqCr0J1plYtJN0LBtqZldR7LQ
	ZId//vqGwhhcP6CK26DLzP3ofulVhEYKqx06uwPwcbYW+bRqNCg1j6lIS7PdlXQk3qvYxaxz6bM
	w
X-Google-Smtp-Source: AGHT+IHJSZFIfS5xEh0VYynEI+hNT8DbM98p64k5a8t/tHhPiGVa1E/Bp9MzbasyxjF78NI1dQYQSQ==
X-Received: by 2002:a17:903:1212:b0:1eb:5344:6a01 with SMTP id d9443c01a7336-1eeb09ae715mr55580745ad.44.1715219591726;
        Wed, 08 May 2024 18:53:11 -0700 (PDT)
Received: from localhost.localdomain ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d15dfsm2117465ad.62.2024.05.08.18.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 18:53:11 -0700 (PDT)
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
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 4/7] dt-bindings: display: panel: Add compatible for BOE nv110wum-l60
Date: Thu,  9 May 2024 09:52:04 +0800
Message-Id: <20240509015207.3271370-5-yangcong5@huaqin.corp-partner.google.com>
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

The BOE nv110wum-l60 is a 11.0" WUXGA TFT LCD panel with himax-hx83102
controller. Hence, we add a new compatible with panel specific config.

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Chage since V5:

- No change.

V4: https://lore.kernel.org/all/20240507135234.1356855-5-yangcong5@huaqin.corp-partner.google.com

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
index fc584b5088ff..baf8b053e375 100644
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


