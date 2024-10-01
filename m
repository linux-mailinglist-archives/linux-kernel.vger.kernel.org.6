Return-Path: <linux-kernel+bounces-346012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 647E298BE4B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E938B23C8B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D001C5793;
	Tue,  1 Oct 2024 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="XHiNB8aS"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C0017FD
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790476; cv=none; b=jRssB09Oabq/ToVfR80/o/scVzDOff2OdzpQQUMFkwtfDgfIk4XX2iO0gDYNij/9sYXTUYbjGvkfYnJL03ZYtuuWSNHfxA/ANLyX1sbg7d9G80KkY9Q2nktmqkMf+tT0K8Kv6sGWDN2lyoFMEp/V8s4jvwpeAvpf0Q5iiJ5aKzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790476; c=relaxed/simple;
	bh=qOzQIwljOONypuMEX8hp+9/f5NISrwNwKg4Ugwl6HXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jlgSWAJqbWygM7El4Hzj2GQ9X2lQj5V5JFjgGECI206F8L9738oSu9ECyJfbFTLkRS09a3qJnyVLmpTQVB4sejEXMGGSurl9Wardwbpw/yqSNjZIMHi2CRzlBmsiFgAmmtKndG/hmVD9gY6oLKr4RIyZuVveq3dEdH4FnqcgnZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com; spf=pass smtp.mailfrom=thaumatec.com; dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b=XHiNB8aS; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thaumatec.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8a6d1766a7so19703266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 06:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1727790473; x=1728395273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tAj/ZcJsteYyfCk2vYENrMCwftIRTgZfWUbq7u955gU=;
        b=XHiNB8aSgjYXoBeIYaUwqYah1YL1YU5lcwokyIUD1rvMfBP10xyTOrFbb6IwshiKEE
         FwKcTIRmqh5MBCf/2RI1dRWSoUJbx4TfN3v7K02YQ3PN0GifwHZiDdWwxcrM4eewedDl
         LBodl89p55oHLY3nLvxsbN1s6Nddo8zXb5Lbib2Zw+Tpe0dq5UcEL9Dq1Ez1USpf9qGo
         syylljQ8f2yZkYd1QnkFhbVxOxnqYv9X0oRFwNhqZBGXrLwJ0ajgWW9iaZ8eHXINqysZ
         G6hxdjaFIGM0bC0K7dQNaKWLpULIvoQjzv96s6QEh86fO0sN8J/FFJ/IheAhRdwHfgQK
         LD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727790473; x=1728395273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tAj/ZcJsteYyfCk2vYENrMCwftIRTgZfWUbq7u955gU=;
        b=TTDYRhkH8UpF5v5U7+VvIhKPKMAe7OYiQzwRGjxix77RdxnUX+wKIm7g9Du7zkfzgp
         omZRNdwSQ8HhZwVmxwj5BWw47KRyAggbEO4N59uN1NnK01sVfizMZ7+suUiTwJoTm3CA
         JkfDgVT57dGBfYULbhjy2Wh3+cOMBgZtXS3afT7KdOox/soZ10VVl8lF0DQ5KcCBxS11
         LHIH2CUBVwLHVu9zBB3TJs0+DKJQp1g7s/uzBtYc2OyN1rndo/YOD14bpI6aqWXB+X6p
         Y8F7HH/mGcZR4sy9fZfEQdW7G5vuzSbMEQMjzEg/m6z0FH30X1MKomiOc/aHzVbfK5NZ
         ME+A==
X-Forwarded-Encrypted: i=1; AJvYcCWQr5UMQFmUB3+uESr/mS1lci11X4LFQ4qIWQt6ARsiWaunhpH+RcOkzgicZfL1h7wdW7t3RNNV6fwUgHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymbvk+Lt7yjuUE2sCJTHEZ1YBCRR8vb7THzZOgeBd/wnFRJ9fg
	+9TTrEmbPgwX1aCa4iIQrLg6sQdnogMTV42vxBidf/Cj+KvHqnC8Np0agPqUty0=
X-Google-Smtp-Source: AGHT+IH+MuAg6zAQWZk+ikg3Qoz0ip32Sj7sS0ZDEO60KFiCvlYuo67UTzu/A1PJsNONwI6GY//WlA==
X-Received: by 2002:a17:907:6d20:b0:a8a:8c92:1c9c with SMTP id a640c23a62f3a-a93c4967869mr1500151266b.29.1727790473172;
        Tue, 01 Oct 2024 06:47:53 -0700 (PDT)
Received: from localhost.localdomain ([91.90.172.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27cafc8sm715413666b.84.2024.10.01.06.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 06:47:52 -0700 (PDT)
From: Daniel Semkowicz <dse@thaumatec.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Daniel Semkowicz <dse@thaumatec.com>,
	Farouk Bouabid <farouk.bouabid@theobroma-systems.com>,
	Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	Vahe Grigoryan <vahe.grigoryan@theobroma-systems.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v2] arm64: dts: rockchip: Add power button for puma-haikou
Date: Tue,  1 Oct 2024 15:46:32 +0200
Message-ID: <20241001134741.210979-1-dse@thaumatec.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a PWRBTN# input pin exposed on a Q7 connector. The pin
is routed to a GPIO0_A1 through a diode. Q7 specification describes
the PWRBTN# pin as a Power Button signal.
Configure the pin as KEY_POWER, so it can function as power button and
trigger device shutdown.

Signed-off-by: Daniel Semkowicz <dse@thaumatec.com>
---

Changes in v2:
- Move button definition from puma to puma-haikou dts

 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
index f6f15946579e..c04bb98a45e5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
@@ -30,6 +30,12 @@ button-batlow-n {
 			linux,code = <KEY_BATTERY>;
 		};
 
+		button-pwrbtn-n {
+			gpios = <&gpio0 RK_PA1 GPIO_ACTIVE_LOW>;
+			label = "PWRBTN#";
+			linux,code = <KEY_POWER>;
+		};
+
 		button-slp-btn-n {
 			gpios = <&gpio0 RK_PB3 GPIO_ACTIVE_LOW>;
 			label = "SLP_BTN#";
@@ -203,6 +209,8 @@ &pinctrl {
 	buttons {
 		haikou_keys_pin: haikou-keys-pin {
 			rockchip,pins =
+			  /* PWRBTN# */
+			  <0 RK_PA1 RK_FUNC_GPIO &pcfg_pull_up>,
 			  /* LID_BTN */
 			  <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>,
 			  /* BATLOW# */
-- 
2.46.2



