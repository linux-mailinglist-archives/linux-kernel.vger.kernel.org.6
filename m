Return-Path: <linux-kernel+bounces-440787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAF19EC43C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 06:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D01285750
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 05:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC3A1C5492;
	Wed, 11 Dec 2024 05:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mF7xvjDU"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C801E1C4A1B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 05:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733894687; cv=none; b=DjRoWlhazgxRW1CdTkqQIbpXYUQqMoZPJtP+R3SxebjkUGkQg+8r4D+CXbNU+NTHaHLmoVYHkOX5Tk3MbP94/jSqe5bSTqdQP1QiGMHbSf30WgfD3R6oEx6MF0ewsNCRYknoq9RjnUfoG/llExU4RQJhXe7j8gBsg1j5abTdTNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733894687; c=relaxed/simple;
	bh=ma6H2iGhdXvq7DvBYNbKjSI6vfExx+HzX5G1hbSkTcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcI13I9v5gygQQFZxbvowN8D6nS6kCOzqgKb0SCHYJPtd3Wp5SQfyzEAe3UL2too1yTAUVMEJ++r6aX62GsfT4zJZRTrMG9XjSD4+6no9tz2CZEgLhQsZa/+Jj7Al1wg/XT1FjYzbD02h5lxszGski6fXrVNVJhnK0ErxJKQPHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mF7xvjDU; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-728e78c4d7bso271485b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733894685; x=1734499485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsRd6GbIRJnWNHqT+PNa/aW5xM64tEdGNTQseKpNp3U=;
        b=mF7xvjDUctCwvujKPSUzRGtggUp35zX2Lj9MpfTNsEb39xaNsQNCwcwtPwzdD85qDx
         YapIHrR6aWFPLSxws6Jh/CUmBLPCQyIAzC1dXCrqPf0F89GXXJYXK74pOL6EJeYZ86d7
         obUBt09AX+TK0ehLY7WmxeKI91wW2QoKGMi6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733894685; x=1734499485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsRd6GbIRJnWNHqT+PNa/aW5xM64tEdGNTQseKpNp3U=;
        b=nF5idxi/Xr+FxWVDh8Ae8iNvSdkbbw/7CoWYdX7JssQPzTDbUiUetok9UHWH9YzcwX
         r7EQ/0Xjn7VuhxKksdvWbYwB7LS9kHlKt4ZlzMP2v7hTZf6r3A2MjmzZiHorim0/Hvgf
         Fo9nYTTCLwUmhrQse3RWuslpLbFegjQF8ozTUa2owGrHYMl82DDReelqnjHTShnZjW1b
         QB2CSJcZ6FDTvOvzKL8Sgq0hT5GUNv9ZK195zNj/XXR4VGqGHR7hR/g5V+8bTrwkGuWL
         tK2UvCzSh/0R00mEe4cneVFfYtuNKjKpXxNftfHM3YEW5BqQLZ2xP1rhnMUyRm1QsBDz
         3LsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsw3rFbIlACJ5+ZeooX/RjX/FwFKyu9iVhV08YcZr5EaM0EncOpxnyu2kwb7PFAdvlk4G8NmIX/ziRJ7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT8/khfSvJipK6bD9+82oR367SmzgOg2tu+WtYX/x02oVk7m3Z
	Hc6/L61LDar2rqxdDr24at0uHR65k8gSZtkBvU/P80u8DjlGLgHOTuRAyVRPaw==
X-Gm-Gg: ASbGnctptbyyPx29+XBNOFDPLI6cnyf/sVCesaYCIm0nG7h2CszDi64z18k7yCnnO9t
	U18QAJNwpOEecUVy0uvGpih49VIp6fQxbOkBMk9fpAVL5RHS/uaSGvgycs4Q6hhAKCNbCap/tKZ
	OuLkIdZjs/aLnrIeGBbva0hEkrMQMxI83sOX0LxjdK2GoNc9SbZLty3BMtbEcUraJa9DclmAq5C
	HAjp2vgoYN8KCEF9Z81o/0TXozmrU4nvS1/rK8A2T/m47MsRo0/zNYZpATWYELVOftSTcug
X-Google-Smtp-Source: AGHT+IFFxMXga6SeAVOQ7rY1CRuplpzUNVLLhXZiU0yZmrw4h4sktygVKCOPI2atcjtR3UsWVfl7nw==
X-Received: by 2002:a05:6a00:c92:b0:725:e3e5:624f with SMTP id d2e1a72fcca58-728eda6a3fbmr2265644b3a.0.1733894685041;
        Tue, 10 Dec 2024 21:24:45 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:4dfb:c0ae:6c93:d01e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e66801e2sm5397702b3a.160.2024.12.10.21.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 21:24:44 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] arm64: dts: mediatek: mt8192-asurada: Drop regulator-compatible property
Date: Wed, 11 Dec 2024 13:24:22 +0800
Message-ID: <20241211052427.4178367-5-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241211052427.4178367-1-wenst@chromium.org>
References: <20241211052427.4178367-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "regulator-compatible" property has been deprecated since 2012 in
commit 13511def87b9 ("regulator: deprecate regulator-compatible DT
property"), which is so old it's not even mentioned in the converted
regulator bindings YAML file. It should not have been used for new
submissions such as the MT6315.

Drop the "regulator-compatible" property from the board dts. The
property values are the same as the node name, so everything should
continue to work.

Fixes: 3183cb62b033 ("arm64: dts: mediatek: asurada: Add SPMI regulators")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index 741af6a7f197..516fba9b3c6d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -1580,7 +1580,6 @@ mt6315_6: pmic@6 {
 
 		regulators {
 			mt6315_6_vbuck1: vbuck1 {
-				regulator-compatible = "vbuck1";
 				regulator-name = "Vbcpu";
 				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <1193750>;
@@ -1590,7 +1589,6 @@ mt6315_6_vbuck1: vbuck1 {
 			};
 
 			mt6315_6_vbuck3: vbuck3 {
-				regulator-compatible = "vbuck3";
 				regulator-name = "Vlcpu";
 				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <1193750>;
@@ -1607,7 +1605,6 @@ mt6315_7: pmic@7 {
 
 		regulators {
 			mt6315_7_vbuck1: vbuck1 {
-				regulator-compatible = "vbuck1";
 				regulator-name = "Vgpu";
 				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <800000>;
-- 
2.47.0.338.g60cca15819-goog


