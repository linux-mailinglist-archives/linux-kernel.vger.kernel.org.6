Return-Path: <linux-kernel+bounces-304035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DAE9618F1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 23:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE297283E8C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 21:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53041D416A;
	Tue, 27 Aug 2024 21:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KL+qv9Ok"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8371B1D3647;
	Tue, 27 Aug 2024 21:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724792489; cv=none; b=Vmez61uH/NcuNTISGYLBexrg3yBE30ZOXAXKZzn+RWp3h1RDjWAPLUtKOIZ16Wg/3bQZCx88r51bzcQ/jGdNc0113WczLp+/BZmOkLJu8T+augMxC5bjZINEl3eyqwTjZhUJhM9OrKWJz4sYj8VSZe+PkKh7klBmujbJk8qp434=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724792489; c=relaxed/simple;
	bh=XSFnSGs2Y7XJ0KFRhE+9wlN4kbPvLA8NqKdHuyx/dH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=faedjtPra8Tc3bNdinesW1YkhfS3AaNjPbocOdyJwx9TiN1JYSJ4feIgua5SkRrv82EAJ3DAzEkNdDDyrT8xOOvLQGBPSy9LfZg0aT20LBlrRDCdiFJHUHhcD+B9WCeiIjDdaHwuw5VGQIHsJHyN4MuOmubVu181Vafy12itvZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KL+qv9Ok; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5bf009cf4c0so6310756a12.1;
        Tue, 27 Aug 2024 14:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724792485; x=1725397285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z4Dk44Jda/PXj+bS5e+iE0HY0KNrSiPasrCnB6X1+Vo=;
        b=KL+qv9OkugbopHi4vJXkZEXFfjVfZSJzNQhPbjQWbnersDHm0Sg4CR7Jehsm7f9BdR
         qiGaXIKBTyqNOr/HSgEn5QrnwMgY4C7VNhRJHJttNyxfeyLjnCP1GqnIhxEt5St+jvN0
         KOST9ROmdlS5v3iOnf7A4p9uU6wNWGCrPMQYarsNWU9G2cfMnnluJThuvNcVTENIpiIN
         agokIqawxQpqA32UfZClvKYVY1YzoQ0rHtHy+vYHBQvdtf4DE/NEt1fLaYd+g50YqKlU
         LcDUJhqTgytGz4KrUg9x2u6GAivTjiOD2UGN3x40xtmkRWNtZTM/OGzteNmuJpAsq09o
         7hcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724792485; x=1725397285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4Dk44Jda/PXj+bS5e+iE0HY0KNrSiPasrCnB6X1+Vo=;
        b=T41pfKoU/TXVYmgOHcOXDPT5m/NcZfF2ha06AtwuFCfKALvym5FG/lzKv3Fw+hfjr1
         vIE+mqeSi3cka76TvBS1lgpq+1Y3UfQvGGCY38Y05LrW6jUVlCEbROUtmG1i+T3yuKl9
         MuvhY0c/14zwc3sZDbnHGX6yuo/vhblaQ+dfbkcNMS+fP/f+IHjvoenGbGhRKtWt5Gaj
         DSD+HeLei6a/Ftw+ZHpp087+oPjGgCUdefGXe4ChZTkxbl6HIXQGsCFewgVSZKv3Hw/4
         ixnYo2MR9ATB4vaTUPRTi+erEmLZrtFJN/Zdtup6XnS85bg3x+gNF0eovb6ZrdnHCr3+
         cFKw==
X-Forwarded-Encrypted: i=1; AJvYcCXkWNPYupMBlg8kw8I7+AjI5a36+Q0ULsXIExAR7I6hhaFqj8Tc/Lh9CL1ycyNOBCmzWrkva/kBNwwDS8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/O6k371zRNe1dgfEJkm3TwYO1aIM+lbSfgNkG1NXBzPHYePE/
	NqOjTq19Rajz3UDJIIEJVQAlCtkCiYnTo9Im52C6NPOHKFJ2iCeP23LQATTgx8o=
X-Google-Smtp-Source: AGHT+IHLSXoIkb1hPxPUG6/bm1IiGleYMQDtLPTORcIZT1/WnSzc+7I51SMbykPJQnhp8GCN7LpC5Q==
X-Received: by 2002:a05:6402:5410:b0:5c2:112f:aa77 with SMTP id 4fb4d7f45d1cf-5c2112fab08mr342140a12.31.1724792484799;
        Tue, 27 Aug 2024 14:01:24 -0700 (PDT)
Received: from cleve-worktop. (85-193-33-82.rib.o2.cz. [85.193.33.82])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb1c3114sm1405835a12.13.2024.08.27.14.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 14:01:24 -0700 (PDT)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Date: Tue, 27 Aug 2024 23:00:45 +0200
Subject: [PATCH v2 3/3] Add vqmmc-supply on NanoPi NEO Plus2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240827-nanopi-neo-plus2-regfix-v2-3-497684ec82c7@gmail.com>
References: <20240827-nanopi-neo-plus2-regfix-v2-0-497684ec82c7@gmail.com>
In-Reply-To: <20240827-nanopi-neo-plus2-regfix-v2-0-497684ec82c7@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724792480; l=754;
 i=cleverline1mc@gmail.com; s=20240824; h=from:subject:message-id;
 bh=XSFnSGs2Y7XJ0KFRhE+9wlN4kbPvLA8NqKdHuyx/dH0=;
 b=V6aFjo7k78vnB1rvzFLyu/fc+8DwPgrvZSZdSawRHt+uKz0/X7RBF7glboSyFAyIoaAa/aaBJ
 017gdp/pMAgDXJIG/DKwjut/nkt99jNprqtx6n2s1lLwuSgPHJQGOlD
X-Developer-Key: i=cleverline1mc@gmail.com; a=ed25519;
 pk=CQifx5FUgTQKAoj5VCYrwYHi235AkXQ5yT1P6gkaBxM=

Adds missing vqmmc-supply for mmc2.

Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
index 526443bb736c..609560a9d6dc 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
@@ -157,6 +157,7 @@ &mmc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_8bit_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
+	vqmmc-supply = <&reg_vcc3v3>;
 	bus-width = <8>;
 	non-removable;
 	cap-mmc-hw-reset;

-- 
2.39.2


