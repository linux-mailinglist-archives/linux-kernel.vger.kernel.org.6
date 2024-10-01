Return-Path: <linux-kernel+bounces-345890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8630C98BC8E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B849A1C2324A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F9F1C32EF;
	Tue,  1 Oct 2024 12:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSskmGGw"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70B319C55F;
	Tue,  1 Oct 2024 12:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727786742; cv=none; b=c7kdt8veqoJeVoWRyq08Q2a3r1jIfNUiYNjUUU40kLHrPCp/XgaQj0g9H9gaCKowHqD3ZIL+v43CcIysBHLSz7er0auPFVQriiXmYRiynp2AJ+8GTrj351Si0zjbaIaOx9I9ZitAdTO9y8mfLPSZKkYPecJA+eG0VTeMCtj5aZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727786742; c=relaxed/simple;
	bh=vnIjzu3vAzCdCo844dtM4r6u/3MWehbPx+m6h+TFQ+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ls3vyi2YGLqtFVjP23z4UtFbL8cwbTu3muKPokS0Smoj+3m4eq2xoY4xz/OolJE9m6Jezntj2vmQtLddQelugb/FGvOf4nPoZVoj/5KHaofwYlBFmCwoDT3JciAX4w/wSScOUmB9sLopXYUOOAe+B4Cv5Q94jLKC+bdB1BY7Qzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSskmGGw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20ba6b39a78so10183535ad.3;
        Tue, 01 Oct 2024 05:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727786740; x=1728391540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8wlAFhzxdTYEQzjtgnSwbzACavm6jOlYsQFniq7mmU=;
        b=DSskmGGwanjkAHGZFTj4VJlz7TbzgKkxwaIrZqG5ACrizlE7Auuko4dWwp8KR4++J/
         zyxukC8/zmeqY1FQKyQnO8YC2ZMO+Pj0g0eZ7C281ZnyQwxdvsRCXPwIyqXCJb1gIGiO
         eNd91Y7ctJraQdv5ZbmYPeMh+IZJWex9l8sVTD5nxbActTDm0W2KoK/EGle/L6LN59w/
         zX2cpxPpgYZv0KCj+/uCpyrEGhxlTwaiuetD2AHG2H9QpkNrfXj52c/2zCfbb6stGRf7
         slmt5pg8IKSRfz2PeXvMvjtnGVk6aKlGPrTMVxn2yITKnKNNVjBm4lX9fAl3b47zo/IO
         EJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727786740; x=1728391540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8wlAFhzxdTYEQzjtgnSwbzACavm6jOlYsQFniq7mmU=;
        b=KfqH+K9uZpeBAdyI9hNRB9PrWjfDXB/PmgO4lqanW8oXkZHFToSw7aJrxTiK3+KWja
         29L4zVIx7Ayh+7gOmcLph2XD5JMzl52in5s00h3Ckp/0Lvg9WT79xHgG/g0i20QQyzrp
         Wqpgv8DrTlf1D8x0Xje7SQ6mo9Uqlkgb7CxOHOOLW6SAUZVIi8o1yZmBn0cLYjvUQ5xS
         WdUkiK9YRd09aZL+MiXlGQXdA0+uhDT1XGfsx06KVYArsOHUSi0H9Hfdr7WTN4ie01X2
         FXr39E78ACqOatFLYLjVWhYFy136PE9XfvYT+GQULkbIirX5w0TXpqhlHiJpjp3x/rnn
         0yyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5Wfb0C0UhUEvLRW0j333Mfr/7iVX/fcBJ6F00ps5TyXLOVLxA/JDH5DLVtD4UrUZ2jHZQ+7+WSOO0LYiz@vger.kernel.org, AJvYcCW0sGqQ6mIzs9fr/xYWXYc7nJS6wSlhDDEdFOKlXKyclsiaxsBBVEQa7jav9rMJXFKa9G/XCkiOREX8@vger.kernel.org
X-Gm-Message-State: AOJu0YySu8i1OKcXODAfHWx6CyLLAmagcWs1XZby8+BHu/RBoDBYl++R
	olIvVRg4OjCq5BZlDLDOiBHf/ZkhaYmmEQlacLsl4XV/vMQcSvpP
X-Google-Smtp-Source: AGHT+IGq5rqNyL03YVDgSvUuIMn2ZcUhfKCHvcVRRWmSSPeVDHl44rYiJKc7riRgJVSVOLTwjCvt5w==
X-Received: by 2002:a17:90a:66c8:b0:2e0:a0ab:7fd0 with SMTP id 98e67ed59e1d1-2e0b89eb8f5mr15842411a91.16.1727786740274;
        Tue, 01 Oct 2024 05:45:40 -0700 (PDT)
Received: from joaog-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1704bdsm13629171a91.5.2024.10.01.05.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 05:45:39 -0700 (PDT)
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] arm64: dts: imx8mp-verdin: Update tla2024 adc compatible
Date: Tue,  1 Oct 2024 09:45:03 -0300
Message-Id: <20241001124505.73857-2-jpaulo.silvagoncalves@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001124505.73857-1-jpaulo.silvagoncalves@gmail.com>
References: <20241001124505.73857-1-jpaulo.silvagoncalves@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

From: João Paulo Gonçalves <joao.goncalves@toradex.com>

With commit f1c9ce0ced2d ("iio: adc: ti-ads1015: Add TLA2024 support") a
new compatible was introduced for TLA2024 ADC. Update the device tree to
use the correct compatible for the Verdin-iMX8MP hardware.

Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index a19ad5ee7f79..db46763d3751 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -592,7 +592,7 @@ hwmon_temp_module: sensor@48 {
 	};

 	adc@49 {
-		compatible = "ti,ads1015";
+		compatible = "ti,tla2024";
 		reg = <0x49>;
 		#address-cells = <1>;
 		#size-cells = <0>;
--
2.34.1

