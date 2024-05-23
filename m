Return-Path: <linux-kernel+bounces-187143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 414E28CCDB5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF22F283478
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA5E13D2B1;
	Thu, 23 May 2024 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="N2sVzYyv"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E91A13D272
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 08:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451360; cv=none; b=DF+ICiPtTeROFJ4AkjNc3IoZjIQVAyBBOuTR4bofluXdi44apvgaeFgSJE1IXsgMwme9dc23EJ/GsSUDrfz0Ppei8em1RyTKtR+7i+vrT2hvr3Avcv5NottnVca0oUSwb83q80K0iuSd/0W74/S/isMGIa2VBmY59AjtqRsHdco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451360; c=relaxed/simple;
	bh=F3HLan+EFrrhgGJOCJBcZod3FUMJQinkw6hx3P+yk+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnFtHwpL/ugB6PsapgOJojAg1qT8GwKa3WmKDweizQSQW0rfjZ8frsXAoDHR2Y5xuM16a2Ra+8J35p1KgZPnfi92DkvEqjwKgtoLxy86l/eRbI1pIeAhMhkK6CZRw84/u8p3ae8cPwQUrTYBOgrKlp85gnNCTL4imAQQotOGEjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=N2sVzYyv; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-354be94c874so1308149f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 01:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716451357; x=1717056157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWlrESD1hPbK1jELiQUm0maGQhBf2warBvSE6Jg46pY=;
        b=N2sVzYyvzRTKT2HH8IlxaYswHGz/4nEStmu5iWFGFoJXOKWDLzk6kSymRIX5T3SEI4
         ZP1SCwUWEVvVS62YVvHZ8ErtvmAzoZBJCNbsJAYjatyvbkeoAbum4UYO1U1GZv2NEbhw
         JzxBvnjCFPiWYPe9IS7ofvmKHKt7ROEyi8+D5T+vTrHOXIBfkuVEKsW7q+u0x4oroesP
         w8cYycmgYdeUxm2Mlxgvi/lTlJFRC39AzMOicDCkX/U8bPXEWUT2kFptcGaEfDi0i+sC
         iC/GhYVOMrm5S4t9H0th08kHlQ7ImlKZRsr+kj/JSNUPl2A01WEP+OQuidPn8183BW16
         Fafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716451357; x=1717056157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWlrESD1hPbK1jELiQUm0maGQhBf2warBvSE6Jg46pY=;
        b=EFc+BgTW4DSyh3XYRAXQ5pvf2NKm9ydeJS5nMCItKupae+BjpbQjMOUgHLYMPSrFBM
         K07xMGfRbV+ZTup6Z3oRDw9GAYwgpsNcdjy+tB9wOSwjdPHVNxdui5ugVcBBV/kVSb5J
         hOblH4Cg2Nohpgt4ZhnRh9w8wEy1Wx2Elblq7XQNyj+8X1IzL9I9WOpawuGxTgeXRiJu
         Jr2W7cVQIgcthz+tIUTnF6Gn1twgNBAsj+LepkYFP+LRrw3BCByYZQMdls9+HYsszkhc
         i5TaOWDxtgpudDSOY93qCAgSAxPXRpdh+V/LZyX3IfOU2xe4ORBih8iWWOVpv+iI6ZNt
         PxOA==
X-Forwarded-Encrypted: i=1; AJvYcCXDqs8eqYW3xq6mwRdxU5Arg2VlGeAEgDQ08B5QB2Gtlq+jFiqPgUFOUKsTsF8M4ZvpryH0EkJcQTxMgJf9ailslAA7AM5Crs9WByyL
X-Gm-Message-State: AOJu0YxjUwqtDkiUVsKztG/ZCfeFIlPw7zRdZVKhiLBPnxb8YcUJOKjT
	HQUFn1XcfL6m0Fm0KPcDtOMtOKUvXr1YTSix2XkfZgoS4Et/VWZO8NH4CZ+3SY8=
X-Google-Smtp-Source: AGHT+IF1GFP+Prk8Sx8nfsKKmPVEsEvOgzLyVffBGqv+aRehf2+t9mnt83aCEYUlD2pGPfUSBjfp1Q==
X-Received: by 2002:a5d:66cb:0:b0:354:f308:7cf2 with SMTP id ffacd0b85a97d-354f3087ee9mr2824214f8f.50.1716451357249;
        Thu, 23 May 2024 01:02:37 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35501abfdddsm93637f8f.110.2024.05.23.01.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 01:02:36 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 5/6] arm64: dts: ti: k3-am62a: Add partial-io wakeup sources
Date: Thu, 23 May 2024 10:02:24 +0200
Message-ID: <20240523080225.1288617-6-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523080225.1288617-1-msp@baylibre.com>
References: <20240523080225.1288617-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In Partial-IO mode there are a number of possible wakeup sources. Add
the list of phandles to these wakeup sources.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62a.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a.dtsi b/arch/arm64/boot/dts/ti/k3-am62a.dtsi
index b1b884600293..5c13851c29ec 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a.dtsi
@@ -123,3 +123,7 @@ cbass_wakeup: bus@b00000 {
 #include "k3-am62a-main.dtsi"
 #include "k3-am62a-mcu.dtsi"
 #include "k3-am62a-wakeup.dtsi"
+
+&dmsc {
+	ti,partial-io-wakeup-sources = <&mcu_mcan0>, <&mcu_mcan1>, <&mcu_uart0>, <&wkup_uart0>;
+};
-- 
2.43.0


