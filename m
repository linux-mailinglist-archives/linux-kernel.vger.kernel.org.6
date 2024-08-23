Return-Path: <linux-kernel+bounces-298855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 187CB95CC3B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C458B1F25CD0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401CC18455D;
	Fri, 23 Aug 2024 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SQ4BQYna"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8276358A7
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 12:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724415416; cv=none; b=VUME9xKhNROc0DMfqfqGbzYp28YQlAljOofVDk0lmsz3S+dvdC3OxAG1vAgIYsEP8FxdZ9yuDOHvyQ7XlD7KjfnAbc0ntsr8lhr7quPTPC9WG4sYffh82K97N52STMX2SaU2rSil1wHpOVKF5D0n09q7w/2nte4v1RXnstjLFnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724415416; c=relaxed/simple;
	bh=4DC97yxJeXEdzHMLZMXkYAU0ZNbEVEeDGKGhuV0RtgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=a++KTM4V6JfJLZvMt8+2xgb2fCjk4JaiTyvgL9cZOfh/TZ72rhLM/OtD9Cgysp7EXk17jqGkx2AwQW7Rl1/dPMWQNrJqoQOR6Fzr2bTAvWAg/mlxSo20kvrZbALS1geCE1jUEo4bGmk/pEO0pknLa5eZQkiSVg0B7bvDVSqQuHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SQ4BQYna; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bef295a2b4so3131674a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 05:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724415413; x=1725020213; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k4jqcyPYPviNvzc22wHcy+G7CO3Izw5qaIhoXnNG/Do=;
        b=SQ4BQYna+VjIFEjOz1SuG7klXn+9Sbz5SnE0c2CXEdFAY4Q1ILUuhnebhlMsCHE1O1
         5gdEDbk1Ove0w0thPLYQ1JWcqE1jNekRmsVGxUK5RuKBzOb3P670JVT9jDJYbartUfUr
         tUSD3z0cjt267X8eM34ZgkYf/IsKe47DtxGWo2QnZz0pR6HweDV/nHSLiZS6kcEQPZtd
         h6vOJb4COkbSya/cHWnGThVohY/robkJmijhiomc+tVtR2exQNsp5HUpU+tDVMZv5wdF
         5Mfr7nKD2iN2PfEGowFVBuffOrn03Dh8ftSt7oveGU4qi1KlRmX/2M/Y15iEvYRiqQFx
         uHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724415413; x=1725020213;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k4jqcyPYPviNvzc22wHcy+G7CO3Izw5qaIhoXnNG/Do=;
        b=sh5pHWMCcr1fta90gN8zT6dw3toNPY3jwBrCDxLd3OFm/y5fUV8nLMjOKKW3htIt1W
         iV/EFu/jT9KefzChE91XRkLe8RMybT+DdPbRIlUzxneIwNZEnxG3w9dq9vdZzxTQ5hIR
         gUtDk7jr9vu1f1JQImSvYEoqh3up7i4WVAZZI5lpNIYO2KUA4QIYYjgnaxcxSfRH2BhI
         1g3FBgkCj2JCAXwdRlTf6fkZ/BF4f9VG8rDCu806Zr3kCFTKyipYnSu7RhOtmJhiC2aI
         tuVtbi8N5pDTAh4UFWPIpvm+ksL9vwP8B8LViPpyBLG+pLYu92rH96L/YxjAnf9S4HTD
         bv6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVknMhw5DQWNDwl4sIvqZIEQcP8LEK7iR9jZ61VliT/YQSk13WOb213Di4iZMIo6h8dqzTZcZ8YEOhWoxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIMd1g4O6OU30Vx7fiouq1ajV1L/owt5tIwj0A2/r+UDRq/rxV
	G/MMyoYJHBr9U8oY82ZSruNY74L5j+njvs2GI6yADOfQgkyU/Qw2GY0ceO4IjKY6J130cv3y2eu
	F
X-Google-Smtp-Source: AGHT+IG92QLTsCPe+kjIiyPB4rgSuURcZx+5MoV2DAob+IU0NbCTX+8Mz4OYOAHiDABjZnejlhmBTQ==
X-Received: by 2002:a05:6402:4022:b0:5c0:8ea7:3971 with SMTP id 4fb4d7f45d1cf-5c08ea73a22mr986178a12.18.1724415412747;
        Fri, 23 Aug 2024 05:16:52 -0700 (PDT)
Received: from [127.0.1.1] ([82.79.186.176])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c044ddc6afsm1993346a12.14.2024.08.23.05.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 05:16:52 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 23 Aug 2024 15:16:46 +0300
Subject: [PATCH] drm/panel-edp: add BOE NE140WUM-N6G panel entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-drm-panel-edp-add-boe-ne140wum-n6g-v1-1-7bdd3c003514@linaro.org>
X-B4-Tracking: v=1; b=H4sIAK19yGYC/x3NywrCMBBG4Vcps3YgjWmpvoq4GJ0/dcCmIcELl
 L67weW3OWejimKodO42KnhbtTU19IeO7g9JM9i0mbzzwU3+yFoWzpLwZGhmUeXbCk7og/u8Fk7
 jzBhiHMMwyUmFWigXRPv+J5frvv8A5pjWkHQAAAA=
To: Douglas Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1309; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=4DC97yxJeXEdzHMLZMXkYAU0ZNbEVEeDGKGhuV0RtgM=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmyH2vnRgfiMfes4bKqmJ6e6TiZhJL98fXzERjX
 CZ/gJuW0dWJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZsh9rwAKCRAbX0TJAJUV
 Vun7EACiWpqGOOnI1lmm2WvxDcohOKf67CM5K6lRzUpHawdGBVSaQV/QOgFO05xyoEBsBbWenE4
 Co1OCcUflDJ14EzhqRG0pnkmVnRUfCr4skiGbtSVXsag5AluGkER+TpZpWNlBFkTH5K+n8Cpves
 vPzGfEjZGfX/QZbo3NsSBq1NBsAWpG2BZJIfJVDDw+gIPVW2FMtyl1mKr/ysyDBAKjVkipFxLy6
 JpwsgiyA3TK9Pqpk9z1mzqtCidpEHx5lDFZERUBOMc1twUrgPsO1zGhywBSp72nBbvdkb6nv3bt
 XLCF+jawU/3n6oHaJWocc1Rq6sRQTsE1GdYeOXymvtQKO0ZlvKMb8KxRAu3Imo2730/oK1fIdqi
 9MI31AzDNZ58OWQgoHLpQp6HYqRWxlhP2xhv54I2G1Z7wVlxuawebo5tuqQnlW5dzuQ2o5RYyV0
 FdoKPoldPIrDOcU5KsxWYgFjxdyZ1oIb10jpFwoslUX6La0E2IRmdrb43lRL86W4W4iK8ZiCfh2
 eT0jUgrUuwgcPd4YWj1jlGNTQ1grQMQ+qx89Mp5FjA7wnPvV+NTdzlHgKAU5RohIl4bvnbfxtME
 IiLqyxoscRcJNhVa/syUuuQYwkNr0I1KwzdSn1kn9TOaRfNlZ/Q9b2DkzePF6bHknj1kO788lqb
 gxrlNYNN4YwrLDA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add an eDP panel entry for BOE NE140WUM-N6G.

Due to lack of documentation, use the delay_200_500_e80 timings like
some other BOE entries for now.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 7183df267777..f6102ceaf0a7 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1911,6 +1911,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b34, &delay_200_500_e80, "NV122WUM-N41"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b43, &delay_200_500_e200, "NV140FHM-T09"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b56, &delay_200_500_e80, "NT140FHM-N47"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b66, &delay_200_500_e80, "NE140WUM-N6G"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c20, &delay_200_500_e80, "NT140FHM-N47"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cb6, &delay_200_500_e200, "NT116WHM-N44"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cfa, &delay_200_500_e50, "NV116WHM-A4D"),

---
base-commit: 6a7917c89f219f09b1d88d09f376000914a52763
change-id: 20240823-drm-panel-edp-add-boe-ne140wum-n6g-e5ff6458a9da

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


