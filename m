Return-Path: <linux-kernel+bounces-556271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1319FA5C376
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C3003B463E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7745425BABA;
	Tue, 11 Mar 2025 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6e4tPG2"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8623125BAAC;
	Tue, 11 Mar 2025 14:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702405; cv=none; b=ROneduDXKHqssIDqvXMHahYuRLliIk7AXNDb2b0eD5q80dBbSBvaHo6rPE7MIQWU/4k+uWY8kR95zRH5AD8vkQFXeOOWWgAMx2ib85gN67oYe+Q6taQdfCfC+LjRUpZqBjRes03mfv2/tFsB3MRh3iRm8xGcxJW7jmKMmQf2pTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702405; c=relaxed/simple;
	bh=YrUQq3EgWI9ojUp8z5yjj68FWJDOMNllETewQ04KCAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VLcZJCvoTa9nnoB7L4JW5BjVqIqDRlhct/zAiIHHik7ZkhS6Mo6Pizk3n3rOC1P06pe6U15qUlDbABoxh/hlMBBQT/C8M3bT7tN8AizXUPFuFuUeXB0n+gGZa5JiJJTozW0p65tCRALJW8vAg0YcSpxkjZVeCWx0DuMx0V/mXbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6e4tPG2; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ff611f2ed1so1450970a91.0;
        Tue, 11 Mar 2025 07:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741702404; x=1742307204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sfx/0w7tHML6j3jIZPou4W5Z11/9NxaRP60Pu8EnFQo=;
        b=W6e4tPG290rANxtEISiO9Ph+Kc/krq92R43mySOtViGHxpsjpyvAp4a3ESv9vi9xv0
         AiGh+eDvFOvBYTS2MwMqSYSmjrevRWznaZbj1RVZCMs+lh407xafvjADWVsoHCLT5Emw
         A1QGYxq9WBmvYgnGNgb5vGUI969pUFG7kh/a3eQUNV3ojHVsZrIQpgBFQs67yXm0cdXQ
         MuVxpri8W539NwdU37GxQPmajVkhpTQcpKuW7m/TjJbM/aE9O6nK8kruAzOdoH+eNc7I
         Vg8RE1sYQpO0mpUveq1DXqLmabez/+rKveI+913hU3xDxyG5qE3ZKIR2gwhCVoavX4tn
         x5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741702404; x=1742307204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sfx/0w7tHML6j3jIZPou4W5Z11/9NxaRP60Pu8EnFQo=;
        b=fHCEUGvl3OZ6xdrjfn8jfUVQJ6m5XlUVbXJsw8xjYjnmTZEzypgLPfgnnGQXq9pzVV
         LcqFDImFPB2TFit2WQ5Xsv7LQJKxQzw3Kkoa6X3iyCGAf6FK1TaBFJHb5SJkFe7F+fzw
         8ONwPM0Anmamu0B85lpxByypQ+az1we59ghTGhu3iiIDdJWTtpn1nQ3Y6WzDAtxGBx52
         WeSaQFS8eGRtsU4B1f5EbHoW0pVIzcRA9OfUxUckjOJG8PKu27+uKaRMn2omJvCpGIad
         guilou/s4RDFpBuNYZJfaCU4oWuVWtOeFC98gEwP2MTMLl+O/uuHpqVlkBxLdETGvUsM
         YHzA==
X-Forwarded-Encrypted: i=1; AJvYcCVMIZHGsO95YljSj1ArpvPhGudCwfuEVQo/jByCWT+/+fRUz84/r4lvMkk+0tj7JvBx66HLafVj89wP@vger.kernel.org, AJvYcCXxMEdMVfKkLjKvB25v2W9tW+pmvog8DUd7bshxBBRYMbkL9jMhjEow+HwyO3Gcf37HtFadrGx1B5n25cuw@vger.kernel.org
X-Gm-Message-State: AOJu0YyvUBHY1xqOIdHSCsrGBByk3XdAceE2bxJ3a/NfbbCmY7DaYy1l
	AHF33Fc7Zo6ty27oF+MK8gav4AnjhUx6aOqNCH1RGpEIo4vJ352nQkUEU8UJ
X-Gm-Gg: ASbGncvbbFcjgRJRPPUjmDLQzdsmHIOi3gs8Ad23I+zi4sstwobMsltPZt+mO1nlOc9
	p+XHyWeIJSbjC5fwp0VhzVVHzQ4PSlmEl5lHJTO46uOp2JBVwYwdbCxg4U7xWnPUwbaXTNZC+97
	crfTnm0RlG9rsj1/V7CENn29m8nTQuErOVieFAkxIIiGIDooDkFWvHi/KyW3cBGVNIJUf9BuVun
	jsU4fr7M5aQCFv5HEcfnWgARCRZNg5JnzF8GknSHNVG8XsF9LWlH5ZpO2tBuviaXQ8egangrW4S
	oabY8fRSZ1pTOCUgzUwqeAco11ZFtux6eAiTPHrlUNsqYw==
X-Google-Smtp-Source: AGHT+IE7O4OIqI5Hjq/tsry6aj7lx93QdJ7EXMkPekETaZ95tGM87nsuJvUD/hTrx6nTT6gvYxlT2g==
X-Received: by 2002:a17:90b:1808:b0:2ff:6941:9b6a with SMTP id 98e67ed59e1d1-300a575a5camr7228931a91.3.1741702403671;
        Tue, 11 Mar 2025 07:13:23 -0700 (PDT)
Received: from rock-5b.. ([45.32.55.39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7ff96esm11875300a91.35.2025.03.11.07.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 07:13:22 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Jimmy Hon <honyuenkwun@gmail.com>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Fix pcie reset gpio on Orange Pi 5 Max
Date: Tue, 11 Mar 2025 22:12:39 +0800
Message-ID: <20250311141245.2719796-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the schematic, pcie reset gpio is GPIO3_D4,
not GPIO4_D4.

Fixes: c600d252dc52 ("arm64: dts: rockchip: Add Orange Pi 5 Max board")
Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---

 arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-compact.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-compact.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-compact.dtsi
index 6e4dcd8fff26..f748c6f760d8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-compact.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-compact.dtsi
@@ -64,7 +64,7 @@ &led_blue_pwm {
 
 /* phy2 */
 &pcie2x1l1 {
-	reset-gpios = <&gpio4 RK_PD4 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&gpio3 RK_PD4 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_pcie_eth>;
 	status = "okay";
 };
-- 
2.43.0


