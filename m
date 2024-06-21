Return-Path: <linux-kernel+bounces-224784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B55C9126D6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34110282B72
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5402420335;
	Fri, 21 Jun 2024 13:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYTGK47L"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AB9B651;
	Fri, 21 Jun 2024 13:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718977238; cv=none; b=WoULyE5k/l6XYLfMtiEcgwHHQcXvh0kjMGw65nFkm/Zf2keFF8pDZC/VbXVsauzJ03DMHMSQ2LwikpyoR3klDluf4Wtkr55Dwm8UKNU/F5dK1ssrO2ND4hXFn9YoHkvIrd7yxDt/iuf4FzbxvGndRYSGNn/KaPrEjy/JAVFyKK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718977238; c=relaxed/simple;
	bh=pioqKyt4NxsI2AItWz1FsdmVjP4k428sGQvSTxTZh0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f057EnOjGx3erOBLx7+YbgJ9ZZsE/jf8EpvCpr2aOUhF3BdPa3g9gay7lHKiGSC4sbtnQxfaeAd7xbXOEAPoi3gCsAfdpcvJ5e4TGEjsggBRFd1ALlkxgmTtvrLl7VUbZYoHTMOBX+4LynmXDSc/bBbfVETuXUbZlTiwzM/C4H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYTGK47L; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57d1679ee83so2153002a12.2;
        Fri, 21 Jun 2024 06:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718977235; x=1719582035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFkUozk7tb7flvFcyJ5JsIPbVaD8NWPVa3/c5jb4Wl0=;
        b=eYTGK47Lj2uyIkI+UmaSR/1wdL3LPdX31yiam3J7oQErQXV+MYoMvUatO4ugz+1rvU
         OHjOLoVXwpBnyFZShHMviTL6Bez5CGYgwjm+cPWGZJKcu+6mWRR+5AJdxIammt3qxrPJ
         x119n7gvveVMBSR5pnkjA7sO5c5X3Ax9R+CPlF6fT0uQQQTE0LZsDz+8h3Oam0BOb20d
         uQbz0vqBE+peCr0w+m4DCddkDUiA/k3FkXsliUGZWAu3JlfDovpYrG+Kh8g1epixRaof
         ssG+U9fnzAExNIo7HwA6Ds7YujMF5PcIhvBAMv2TYepKe82Ywuxc8OadKe4CWJrUnweA
         REMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718977235; x=1719582035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFkUozk7tb7flvFcyJ5JsIPbVaD8NWPVa3/c5jb4Wl0=;
        b=lQZuGjahF52wUCpSlc+po1wLJWmyGmqAuLh5OwCfnmBazwOa+cZuleWUqsSTxMAZWD
         RS8b0Ae2KMC7X7jHsVNqffCPydUp/RiFCatqOM0YfeVTI54z3/if26Qfk75mk4hlFP4R
         olNuiQjUUqf4wkkLShjqd4Ttz3TI+FuJFLv9M/a3I9WbjaRVLfCTgko35F4QRyM/JpxM
         nF0MbW8LTHjHx+6YegNy17jdqcPzk7xAiDH5FOydbJSwZnMQxctnZiwRSZqRucr8ki55
         abUqYSov3PFyXsqjUWvqs8tJ5QmhaoJrmlLsK9jIZGS3w7wXoQdXQy5vTgkpUHcrorVK
         ZQGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsstOG8uXhreg8o5OhnLoifPF19DX9yx/xsm5d0Nne+GDDpvPQv0s3T0MKCZ2XzeLdDKCgUs6BANo1LdH0WVhyB1B47LO1iGhCOrVe
X-Gm-Message-State: AOJu0YyRxZQHveRBr/P6d7LRfwtS/dsnaNyvO3uP69TldBmS9fEvoL7i
	m9gZ2DnedzNEzPwRt4LUAGX+oqD/fr2Y0RYe/kUYpcArLCailWA=
X-Google-Smtp-Source: AGHT+IH+aNN8muxQBOlF2geszNuOMMwlp1muSzceOddFFHXJA2gZbdkBNxw9WjwtratXSkeYf0JVZg==
X-Received: by 2002:a05:6402:14cf:b0:57c:d4e9:4a03 with SMTP id 4fb4d7f45d1cf-57d07edd5f8mr4634436a12.41.1718977234727;
        Fri, 21 Jun 2024 06:40:34 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:1b6a:5399:9a4f:7217])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30562cb6sm962059a12.83.2024.06.21.06.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 06:40:34 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 3/4] arm64: dts: rockchip: Add sound-dai-cells for RK3368
Date: Fri, 21 Jun 2024 15:40:29 +0200
Message-ID: <20240621134030.243646-4-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621134030.243646-1-knaerzche@gmail.com>
References: <20240621134030.243646-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing #sound-dai-cells for RK3368's I2S and S/PDIF controllers.

Fixes: f7d89dfe1e31 ("arm64: dts: rockchip: add i2s nodes support for RK3368 SoCs")
Fixes: 0328d68ea76d ("arm64: dts: rockchip: add rk3368 spdif node")
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 734f87db4d11..73618df7a889 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -793,6 +793,7 @@ spdif: spdif@ff880000 {
 		dma-names = "tx";
 		pinctrl-names = "default";
 		pinctrl-0 = <&spdif_tx>;
+		#sound-dai-cells = <0>;
 		status = "disabled";
 	};
 
@@ -804,6 +805,7 @@ i2s_2ch: i2s-2ch@ff890000 {
 		clocks = <&cru SCLK_I2S_2CH>, <&cru HCLK_I2S_2CH>;
 		dmas = <&dmac_bus 6>, <&dmac_bus 7>;
 		dma-names = "tx", "rx";
+		#sound-dai-cells = <0>;
 		status = "disabled";
 	};
 
@@ -817,6 +819,7 @@ i2s_8ch: i2s-8ch@ff898000 {
 		dma-names = "tx", "rx";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s_8ch_bus>;
+		#sound-dai-cells = <0>;
 		status = "disabled";
 	};
 
-- 
2.45.2


