Return-Path: <linux-kernel+bounces-247992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C193092D71D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE06A1F25FA3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F39196D9A;
	Wed, 10 Jul 2024 17:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nkWXSBSj"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A79C195B12
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720631120; cv=none; b=D9cGoZukaLOR/nqKctXqh+5jFQyOZxRsr2tCxQLdeQ/ksZ0x3GgKpxA49fLeVHJAZDPrsn99KX5R/Be7IHGhdK8h/CmLNgeg36qf4WEjzaqpTR1q2URfkicZZKzyAJKBGHLXa04Y7+EXozrMgdGbqNOdBe49RDd86CHPsaCS4Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720631120; c=relaxed/simple;
	bh=OjIv6lSyIoOmyQVHsNTFY8WnoyqlDx5HT8DrVGCLkuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ccDcbQquCHsUGDOatD2OdWNbOvRjFJ34LpJ4OdZ1ZTybmrQAAVm+aqhz1NI+4JaxOGA1aJ6s3yCs/AV8A22Gftdbenkaatalye/dlaWbfPMZHLnl81bRBImNcO2C8PwvmXdtbzmLuWms4eQh5H1SYtSvlMAm56ouLhx84hC2h28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nkWXSBSj; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4255fc43f1cso52605e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720631117; x=1721235917; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S4NkoAIT77VT3upOcUYDgNo3eUGfA37eNUjC42fZIhc=;
        b=nkWXSBSjzqJ1ESlxQPj7Yb/ecY3DMOnq6LU7RR7lE5zaSowR+rJZsGleqCmWnR82/m
         xSvcyDKd0rCCcbwgtSjN/VvUD8DLs9n51/z2hO5pYvLaJXPmXxOfETTRsZJAPyTILpsR
         J+LLS2TVZH9svZZt9XEbzqJ13nLQpKEjOPfCSi0WFXmJBjvOQ+/JZaQE33rtWbmp+ObN
         xJQ2e2x5x8uqmrj9/NCmNnrVP/4zoBpT+bgORSBfTJxLq36kyRe9iFP02KjC89LcYI0T
         Es4PSvBzDNJxu4AmZfxg/Rg23Qi3w6DXkxtE9NfRQVdzjezbRjZ/+Loa9LuolZ+EUEMP
         OOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720631117; x=1721235917;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4NkoAIT77VT3upOcUYDgNo3eUGfA37eNUjC42fZIhc=;
        b=iVVuF7MZr9VPWeX1G/eR2jYg4EUVVZbSUE/kLNm/LrTY4p4itwAVPKSmRtrUEsyuBM
         flCwCL24F+bzVMkqf/Hq/6SsDVVfrFb7VRhxhuXhQvK0QaDFQnhQcyKknYm5MOQ2TY8x
         OAE8f+XuSFpDP6BpePD9ViGrRShb6wuHnpX2Ak1AvcVEXre/xbzTvThnu9GNzbgd1kam
         RrVMvrYUnt2lpVi5OKMeSB/gQc48tVDG66/vhpRvpqvCHjjtLN0FWxXk++IYVLDD93Vy
         4QpiDaXox/It0FKTaqpRbkiwfWXQrIbz5ConJfk7Zc8kyJ3kTWGh/7qiIqk3hrfd9d+T
         +oYA==
X-Forwarded-Encrypted: i=1; AJvYcCUW3YI+v6hKznY9WhoCB94Yvr5yB3Vrrb9TC+R4B02RIWjlBqQAMnhxKqFeHWgJv2Vg6Kr1rRoykGkVqtacFMtVZs9oXOSEQVgnYOT5
X-Gm-Message-State: AOJu0YxCNMyvwVXTlSZtisPCgQEYeqZQ11M8CcMMsu+Gv9ZKowWhUgL1
	pPBfawx84f1CoQ4+Qz5lHdNetWiOm5v3zI6CrCi+Eus7MPcNr17/GJ1SiiPLG74=
X-Google-Smtp-Source: AGHT+IGkLUFSUmZ5ECS3GHwAe+MqsROrwZrfQE/I+tdJdPvxCPyYlWVxShiAik5dzVjABnYcvtZ7ZQ==
X-Received: by 2002:a05:600c:896:b0:426:5216:3254 with SMTP id 5b1f17b1804b1-426708f1eebmr46866985e9.32.1720631117621;
        Wed, 10 Jul 2024 10:05:17 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff1f:b240:65e6:93ca:5f80:ea9b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7dedfsm5838446f8f.24.2024.07.10.10.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 10:05:17 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 10 Jul 2024 19:04:59 +0200
Subject: [PATCH 3/5] Revert "drm/panel-edp: Add SDC ATNA45AF01"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240710-x1e80100-crd-backlight-v1-3-eb242311a23e@linaro.org>
References: <20240710-x1e80100-crd-backlight-v1-0-eb242311a23e@linaro.org>
In-Reply-To: <20240710-x1e80100-crd-backlight-v1-0-eb242311a23e@linaro.org>
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

This reverts commit 8ebb1fc2e69ab8b89a425e402c7bd85e053b7b01.

The panel should be handled through the samsung-atna33xc20 driver for
correct power up timings. Otherwise the backlight does not work correctly.

We have existing users of this panel through the generic "edp-panel"
compatible (e.g. the Qualcomm X1E80100 CRD), but the screen works only
partially in that configuration: It works after boot but once the screen
gets disabled it does not turn on again until after reboot. It behaves the
same way with the default "conservative" timings, so we might as well drop
the configuration from the panel-edp driver. That way, users with old DTBs
will get a warning and can move to the new driver.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/gpu/drm/panel/panel-edp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 3a574a9b46e7..d2d682385e89 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1960,8 +1960,6 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x05af, &delay_200_500_e200_d200, "Unknown"),
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x05f1, &delay_200_500_e200_d200, "Unknown"),
 
-	EDP_PANEL_ENTRY('S', 'D', 'C', 0x416d, &delay_100_500_e200, "ATNA45AF01"),
-
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1511, &delay_200_500_e50, "LQ140M1JW48"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1523, &delay_80_500_e50, "LQ140M1JW46"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x153a, &delay_200_500_e50, "LQ140T1JH01"),

-- 
2.44.1


