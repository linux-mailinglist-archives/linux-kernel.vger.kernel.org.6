Return-Path: <linux-kernel+bounces-388217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DA49B5C28
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC7A28428C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 07:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F9D1DE8B8;
	Wed, 30 Oct 2024 07:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UUOhdgZ2"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF761D0BA5
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 07:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730271753; cv=none; b=RYzRsTXf2+pqiD9MVwULV7/2kmPy/FAMJ43wwVxtnmF8uJQ2INpmNlEy4j+Cfr7AxKYPXh68zmj0fxmN4l9GykXgDKgNKQ28yoc/MXZJJexL3W6uPwu9LLTIB9mcNthPZks2ILwthODBHmwMf/ls9Xn3k7WuBnS94Ysu1irKhF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730271753; c=relaxed/simple;
	bh=jwXJO78GesC1vXpD3JCaVF3h4cMBY4hU/BwWhvMga7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PsTCT1xSP/DhMpPrn3XtkJUGbL+iajnp++JH8zzF8ruu6nziwe41mIg3rgF44D4rhXALpeqvIg6QfzoOU6JsklORgPuJ7a2MMVD5PoXwi/Gjv2rgzO6myGunYP7ol7jHJUSMC35PyldMaZa5IX74U/c68TH2+KcYRWt1JZPQVng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UUOhdgZ2; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e5a62031aso4624465b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 00:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730271751; x=1730876551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KknQSR+eKemNJFp2M8/mGkuIkN4Spn04GdvZ2A49qtE=;
        b=UUOhdgZ2zV6ClA8SIRw076AnlZ/dopzZQPOET91C6bvj4wyclE0Hndq5ZUc97f+y8H
         Ih0bNzYgwzQg3UmCoop0yiz+h8AJxphqDeOLRHZ6ExWVSxVr1PBc5QQr/eeDNtHnYDta
         cKWIQCkvAN7JdjGm74pDyHCBJyKacdH+tQo4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730271751; x=1730876551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KknQSR+eKemNJFp2M8/mGkuIkN4Spn04GdvZ2A49qtE=;
        b=MplsbPq1pYlMiQ+Q2d8LOQvdy/tBoo8e/mS2BL8TJ+Ak5ZwxYgo89LA8JG59iZ1SHt
         1G/248Vhm6maL/UIvIB8s6TK4LLxoY2dtxyWBVXpzF1+3P6HU+T6Q8L0rGHQqzhWGEwk
         Z+WWKVZMAiQI4v5xfWUTsZZjUmS4RbMPBHIUPMxOQkUe8xJXE03fsqQr3V/0oiBHqKxy
         UPxdExU0db3LB1g17q9L41Uc1PH1GKnMgGihHcKuP1NkVaCoRFH9l62W25TZOgBwrE5z
         CesU94N0f8yCJb6nUxSOZ3J/VKHFod2N4lUKzJFZAan/Df0hLtL1rPT14bR6brJatEd6
         8R+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvjuqlmbzZmNedXbk2Swq6biL0Wp7wVeJzoV41GIGRkE2aFwwngHWY8L0RVIbyMNF154hG0P4CLkRlhvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM1TEzkroucWvwatzLyn2JdsA8M1nyHuXEcSMAdQKmMvADEMEc
	G9M844vGes6Oa4UWSWl4b1h1z7a+t2A+tFm6YPcbXgWSXvHr01Mnt8Q7XpZoQ3B1Edu61POdVi4
	=
X-Google-Smtp-Source: AGHT+IE542rBFyNruVAgVa8rHIBdj9gp4Qb/CIOnHECLZLKhZmSrZ/HsHZquCKjl9UnkfF9hM4mmVA==
X-Received: by 2002:a05:6a21:1706:b0:1d2:eb91:c0c1 with SMTP id adf61e73a8af0-1d9a851d42cmr19985216637.42.1730271750941;
        Wed, 30 Oct 2024 00:02:30 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:d1f3:aa64:657f:d8a8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057931a94sm8635848b3a.68.2024.10.30.00.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 00:02:30 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] arm64: dts: mediatek: mt8183-kukui-jacuzzi: Drop pp3300_panel voltage settings
Date: Wed, 30 Oct 2024 15:02:20 +0800
Message-ID: <20241030070224.1006331-2-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241030070224.1006331-1-wenst@chromium.org>
References: <20241030070224.1006331-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pp3300_panel fixed regulator is just a load switch. It does not have
any regulating capabilities. Thus having voltage constraints on it is
wrong.

Remove the voltage constraints.

Fixes: cabc71b08eb5 ("arm64: dts: mt8183: Add kukui-jacuzzi-damu board")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
index 783c333107bc..7bbafe926558 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
@@ -35,8 +35,6 @@ pp1800_mipibrdg: pp1800-mipibrdg {
 	pp3300_panel: pp3300-panel {
 		compatible = "regulator-fixed";
 		regulator-name = "pp3300_panel";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pp3300_panel_pins>;
 
-- 
2.47.0.163.g1226f6d8fa-goog


