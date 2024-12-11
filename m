Return-Path: <linux-kernel+bounces-440788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F3C9EC43E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 06:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E1D285856
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 05:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB051C5CBC;
	Wed, 11 Dec 2024 05:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sty0aD9s"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2929C1C549A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 05:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733894689; cv=none; b=M+m8YAD/0OK1/S5WRH1NaIuoUwcvNK4A2vljWfq+V8gWjxHu8M5T7x4R7rycLYrpNRv1690naN+qek4ydqPLlhypM4LWZV6ZhX0McDIIcbgtrMJ6UF0Vq4uJwy3Buv/phIXFHES2xwwEwRd5RDGuvi/aMQlZJQzOcSHdDFcmhVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733894689; c=relaxed/simple;
	bh=bzA0tsgUBJTNJPvzbR8N6/Oiyp4w69Y5EsNtOEj+tV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqWxlg6wZ7hCRcz7YG/xZk8fKE+JMyQgCUJIg0q/rjxYOXcTieNqLmsGrCf/hIk3U3R7oXhFBzp/nl1Pt1bLSEcsEoe9y1TssDx7LLgnYVzXHmaHCfcv/201dkvSIv525FIlD+8yNqxnij5ggwInl0wXgMcbQQHpp4SkJKmJ2Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Sty0aD9s; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7fcfb7db9bfso4883057a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733894687; x=1734499487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+37Ej0Mm9yXagdLEw7xP+d3kLglfqR3xptBmnje5WIo=;
        b=Sty0aD9sISMsEJSH/fhTn3AeEIrjCyJdNq4LJhoIfsSQndkISeKXHqH0Ui4T7QCg0p
         9Wb54FS6r6n5Gl+lieMwNvhXhkr6o7vN5OJzMf3c2Fu1Gl0sqw+cERF0iRWZ+9BrlYzM
         Dl/kZMFFkQaNDOXkBRVdn5lrmMxOyocAU/GNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733894687; x=1734499487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+37Ej0Mm9yXagdLEw7xP+d3kLglfqR3xptBmnje5WIo=;
        b=eVSotalaBBhjU6Nln7uy3shU8IDKzIwEIkAZt/ECsehekiBdf5WyENtDh6K0GCbr6w
         T5JcMSTYj1K0mM5dbGXbbV7og9vUVdZhb7l8X9yuPwwQHT68E+6omjniBbkHPk1YgEuj
         Le44b1HSgZPRzjZgWkLmmqznN+cHf7DYqn9FuDWrSCOlo7UbcceTYGBK5QtGpJS+XoPR
         dlidL3dGv2U2FDELTN1s6O+JMzONf1nOb6//0deGjAV0ybTc/l//62/K2lrr1k+RG3b1
         8XgM35+aZabmOtvf2PejZylZuAsFph7OLzovGsIxm+K6hsQnbuup1AenJPk5WtRM0i1Y
         T0Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUhYSg/PaTEXkW39ilr/OjCARDTD0mzArR+Ch/KXzqZEuK/rusuOIca6AYBkWQhCT7yRbC+lGx5c5iV85E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+CpGxx2HSLlQN4MTmsuFyZlWIScnk94JHBRBPlXIO2goxdNxq
	ZX0lh7/v8eNoOdm3Zft07De0n8Zot3F8Lbjxbkbch+IwWJmYP6r5N6OCbY0crw==
X-Gm-Gg: ASbGnct5xFqfnE7hvW2qX4G/hSJfB8j/MmO+3dG19UHtbNi3IfppF/slyk1TxypxbeL
	7nN93rXC7b2fheM0prkDYxdQ/WPvM29sAeaq7CKqkYcH7lvRBD59m5i/JZsHYixA/eWv65U1exr
	ASbE93nNdTBXrgUkTNKULMjTNldUWB67vVcUuni+1qTP+arbAdY2Y8DQfrN6dEyjm+rX61H56wD
	V11qQlkCMnEWMRKXo0leePhjg9pCgYO4YVJvEeSns2iarsmQcsm0hkHZG3jscDTi+Pi0plg
X-Google-Smtp-Source: AGHT+IEnDOL+LPNNcjtycQIWGHlAJTgKm/mNrg0sjuKMLfoIK4R2jRd0ukkjYLye/s1Gfn5Kr4iv/A==
X-Received: by 2002:a05:6a20:3d96:b0:1e1:b062:f403 with SMTP id adf61e73a8af0-1e1c1337146mr3393676637.34.1733894687682;
        Tue, 10 Dec 2024 21:24:47 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:4dfb:c0ae:6c93:d01e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e66801e2sm5397702b3a.160.2024.12.10.21.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 21:24:47 -0800 (PST)
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
Subject: [PATCH 5/8] arm64: dts: mediatek: mt8195-cherry: Drop regulator-compatible property
Date: Wed, 11 Dec 2024 13:24:23 +0800
Message-ID: <20241211052427.4178367-6-wenst@chromium.org>
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

Fixes: 260c04d425eb ("arm64: dts: mediatek: cherry: Enable MT6315 regulators on SPMI bus")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 2c7b2223ee76..5056e07399e2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -1285,7 +1285,6 @@ mt6315@6 {
 
 		regulators {
 			mt6315_6_vbuck1: vbuck1 {
-				regulator-compatible = "vbuck1";
 				regulator-name = "Vbcpu";
 				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <1193750>;
@@ -1303,7 +1302,6 @@ mt6315@7 {
 
 		regulators {
 			mt6315_7_vbuck1: vbuck1 {
-				regulator-compatible = "vbuck1";
 				regulator-name = "Vgpu";
 				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <1193750>;
-- 
2.47.0.338.g60cca15819-goog


