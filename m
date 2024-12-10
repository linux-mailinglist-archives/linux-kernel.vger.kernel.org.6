Return-Path: <linux-kernel+bounces-438691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E37B29EA46A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470AE161769
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515F01A0716;
	Tue, 10 Dec 2024 01:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnlUz32d"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F861A01C6;
	Tue, 10 Dec 2024 01:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733794240; cv=none; b=b8VBjW70Hq78XhpHuOh/exqxHkL7uz6fyfVSV2wRyU7IzKVNSCo+EgssuPYeEuoCrU/8WVHcX6YCa9HYDalxU5Ner3YDbtRHrvkH7auwh9xYQz8fUK4THKfrxeAxHKZhzP9X1Y3gypGcjcOgChfDyWDUi/uhcZ4b9V0GNJq3gwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733794240; c=relaxed/simple;
	bh=BZYDFRTpTR3NtC0vC92IDRbXApKJBbwtNKxfulbPgWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WJG/9NkHlCdhDy/LexrTpJxE6rCjjKSeOLekIyla3tHG579ebDdNy4XYA1PPfqP8qvEwyFplw9fvbHcBbnxrUOk7F4SpBdaK5xJBTkILb3vZ4Z9OBj5BoXzR2TKlx4VE6X9GTevEnNtGoRT+o5M4Hj5u0kWz0WaF0+R29Nao4Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnlUz32d; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-467777d7c83so1666101cf.3;
        Mon, 09 Dec 2024 17:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733794238; x=1734399038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jqw9ssvr+RamFhuTkFddw4DLtLM/EJe/MJOiR1nlAKE=;
        b=OnlUz32d8X/zRJo4HX4SXTwRWw++VVCWHpD583OC2wOZakMw7MaALrYws/3W9oC5xq
         xUIBJBjGqE9E83PuF3ecIEILspaQFgtIS99vHiGvy+KYILjp7bkvtNClrOPNeyb/M5s3
         C7+HpFaZlMdBDPs/hDSM0yoLbYRy8hTbP7eQQkkjzPMKtWu5mSqNAtbDevhBknb0Q4m/
         kWMRvnjX+AvhKI0wHey2gmsHx5zZv/8Sb/x3Il62wSyBnwfBBq3oQ2tojxi7aFlNn4m8
         UukkORXXC0rOyF6/gwZRDbXavgFbxz5xVXcmsIwiiTAChvi0tf1W4i7Tyw2SGz8eq2MO
         mjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733794238; x=1734399038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jqw9ssvr+RamFhuTkFddw4DLtLM/EJe/MJOiR1nlAKE=;
        b=MOOjadri7kjZ3KuIXztTNJoXX29QTP1BD7Hm8UfjaIp6eAj0Lc38Irw4V+qI2BwN2T
         pg96qhIStQtgPUq1zv3MuQPxrp3hnVm6/9JpAU04vgrKHceeLl0xz40EV8VEWNzkVNCK
         oEMpU24UMMUJQWFqN7uXS93URfuPkPVcdk9gKJRrBFVHLmmvwfNcm43enfxxKJOTzrHH
         Q2D0FDAgH36ba1eDP1RFHN7YxJGIJ/VgKlq8M/hG2AJJj4geNoNBo2QjjOpi21z7Gq1z
         e2UoZfykQEm5koDCXStDCUsYb7sgfvdcJpk+hpfafcOeG+blIv9XRrH6gNfhczvrfhE9
         OT7A==
X-Forwarded-Encrypted: i=1; AJvYcCWfnANBIw/2y5QY/J7s3omOQPv7QVbWHcqFm+xpPbpfbM7vSU6v1OK/j7TqNe89F149pJMMmqunvYhS@vger.kernel.org, AJvYcCXbyAhMa/hymT+v9SXLwB9t8ctE+u9IfEDKY5RchqUOMqmNpN8DgaIWSSkTgKqj4UwP/7emrHIVOW34NNbS@vger.kernel.org
X-Gm-Message-State: AOJu0YwOTevSI9/3Yo9LGZT2VDcmFvLmtJX3SKuecAdQ/a/DmiI0utB0
	JEceBp4yEiYSxvP9r3lnU6/PxM1frXA2IfRm0oXNNlRcnS0q3TRK
X-Gm-Gg: ASbGncuxQrciZbuIis0Dyk1WDjAjKCmWYf5EVkb50/fVAV1qrxJwPQqpZNr/5qUb7u+
	RNhG705f2v7cpXqZoYk9IyaUbfqn4PoOtiuZMJBHtpdrVA965zlHcC3W3Zto8AD+ytIeMkIsOeX
	u3jAVRxRSie/zJ3J9dz8ASsVWmERGmBaoxvN9CuDkbCyEQmaUknE34pfVcfAeI6m2eS/MWwmL+g
	6xTbE0kMWjH16Y7GATsDKlG8L1tsE/FY1saTeuc6jHZKWAERX7bkjT+ddTNcr7lpw==
X-Google-Smtp-Source: AGHT+IH6JIbgEEMAy3xvXZsAPmdWHrEPx5XojlgCSN0/zSm0Ou9M/ynX9WkvMGNi2Bhw9DACvmHMFw==
X-Received: by 2002:a05:6214:226a:b0:6d8:86c8:c2a9 with SMTP id 6a1803df08f44-6d8e73bf6b0mr241598566d6.31.1733794238061;
        Mon, 09 Dec 2024 17:30:38 -0800 (PST)
Received: from master-x64.sparksnet ([204.111.53.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8f429a79csm36834346d6.72.2024.12.09.17.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 17:30:36 -0800 (PST)
From: Peter Geis <pgwipeout@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Peter Geis <pgwipeout@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Diederik de Haas <didi.debian@cknow.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 6/6] arm64: dts: rockchip: Remove address aligned beats from rk3328-roc
Date: Tue, 10 Dec 2024 01:30:10 +0000
Message-Id: <20241210013010.81257-7-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210013010.81257-1-pgwipeout@gmail.com>
References: <20241210013010.81257-1-pgwipeout@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 8a469ee35606 ("arm64: dts: rockchip: Add txpbl node for
RK3399/RK3328"), the snps,aal, snps,txpbl, and snps,rxpbl nodes have
been unnecessary in the separate device trees. There is also a
performance loss to using snps,aal. Remove these from the rk3328-roc
device tree.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>

---

 arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
index 6984387ff8b3..0d476cc2144d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
@@ -155,12 +155,9 @@ &gmac2io {
 	phy-mode = "rgmii";
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmiim1_pins>;
-	snps,aal;
 	snps,reset-gpio = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 50000>;
-	snps,rxpbl = <0x4>;
-	snps,txpbl = <0x4>;
 	tx_delay = <0x24>;
 	rx_delay = <0x18>;
 	status = "okay";
-- 
2.39.5


