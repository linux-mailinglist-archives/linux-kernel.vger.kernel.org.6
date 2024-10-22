Return-Path: <linux-kernel+bounces-376877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C999E9AB6FE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3934DB243EF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84AC1CC178;
	Tue, 22 Oct 2024 19:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dT1TEZMW"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E321CC156;
	Tue, 22 Oct 2024 19:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625776; cv=none; b=CQd4+pySLQf9IgD8lwlz0K0vM6r7K7Ri/hoB415M2uXnGR6TaxQ2F88MUeU5sIHV9vcLPIcSU/0w5eCPsdS26g5TA7jTOkCvZQuWmNVVgvtti1EJM2CuwoiKdDF7Y6WviOXdv/nuudGBp30jaNuph+lcDDAqKWrZH1k0zprNGX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625776; c=relaxed/simple;
	bh=vBfFlY56dLd5DNhtfrd3LCrPFDLtQt98Amc00trJrb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QnRZIKiWfV8f0M5GHhxVKLCPqKdkttaAMarGOMa3VWe3A2+RRX+XbvUmS9kp3rtK7Xmcu1KOp4LNaQ1edjwkGjYZeNv2Qewq/Fvv/WPFYoHW2/ogW0sBBxrcsQYqVYX0mCwo9IeV2+8cNH3MY3apKlp/1Z79DgDF4BftZkM6g6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dT1TEZMW; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so4516183a12.2;
        Tue, 22 Oct 2024 12:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729625774; x=1730230574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZATNHLu7ryXLlEMWdw/soQewkOcMuE+6eXALk2zJ/y8=;
        b=dT1TEZMWdnpdDLs3nepNITsOqscDCQHKjLTbLMMBpt2b/Q1Sf2GuD7H/RHw8aBoL6R
         akJ1gNG+NoTJyJjGC4CGJvVbSuF7I1KRunDwf6b17eG+dy6Pk3MkWdWumqdL8dIlTX1H
         pLyKBgaVSn1gZW+nQSLOfVlYRbYXIHqMQCMpgV5ZhIiqcSuS2IY3kr7YYwZv/k0Y83le
         pXPl4GtYFXOOApoFpnu8ATwE3+edLXyNj0HIz6Iw2AK6RvttSSbVgsOnjEMFLCxdsNsR
         u+nZiKErWRGwRUS3hdMnlsGfSx4rh6ldiDwFkDP47MU5JA15k8O+Z/IOAcJJGLYoVplW
         ES8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729625774; x=1730230574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZATNHLu7ryXLlEMWdw/soQewkOcMuE+6eXALk2zJ/y8=;
        b=jYRXXlBjp0j5yHCcWnmpUV09SkjQHM5t+6BhfL89AZzTi2GkRTruR1pKLVorMIbssC
         UFjlim/asWIso8z39kPL5wE0/BVUm41VcmHVYYp62BmPc5L2kQqCxM6KT2LIjz+PUc+s
         sxOPJpYKnMrZr4bCHFws1Su2TeXs/TRuqHdpOsYFnfLBtuzUBs/GQzCVyEgLrcEDUB6S
         Qr/VZODkhIv38s1AiXcwZY6LHARNwmvKxkNxAmm8uAyUPoH1/sdWSMK5siXPodD1PYCG
         2nn0ecguUPiIOxo3HDnlmGxXVRlRNL5wW+9J6on02gQ22JNa1hf3hNxOoZHSBg54XELo
         CasA==
X-Forwarded-Encrypted: i=1; AJvYcCWIMda+KIbrgRUoQpoe4Pp0CA7IVZTxDtjG+BFroWyyi2Gs7sZliw/SDu9/qb8/qESihtKd5KAKh5Izj0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCdV6QvznlIle0AdQiuE4CHURmpx24Yu9hrTIbYk4yR0CXMuCo
	tvTH2KLDbdjq0jHtuDptiiLSvGZAmBDIrrljhOKfvMbO57d+3Pzb5tbA97AHpgk=
X-Google-Smtp-Source: AGHT+IGuEr0jw3gysbwK6xAgXQVAp73Rxim5u5IqSonSQ50FehaQdZxMf9RI5ejAh/MnH32asL036w==
X-Received: by 2002:a05:6a21:168e:b0:1d9:2a0e:971e with SMTP id adf61e73a8af0-1d978bb27c5mr96065637.46.1729625773809;
        Tue, 22 Oct 2024 12:36:13 -0700 (PDT)
Received: from CNSZTL-DEB.lan ([2408:8262:245d:4d65:bc4b:53ff:fead:2725])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeaafb1e0sm5467316a12.3.2024.10.22.12.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 12:36:13 -0700 (PDT)
From: Tianling Shen <cnsztl@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Andy Yan <andyshrk@163.com>,
	Jagan Teki <jagan@edgeble.ai>,
	Tianling Shen <cnsztl@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] arm64: dts: rockchip: sort props in pmu_io_domains node for NanoPi R3S
Date: Wed, 23 Oct 2024 03:35:28 +0800
Message-ID: <20241022193537.1117919-4-cnsztl@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022193537.1117919-1-cnsztl@gmail.com>
References: <20241022193537.1117919-1-cnsztl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The status prop is typically the last prop.

Fixes: 50decd493c83 ("arm64: dts: rockchip: Add FriendlyARM NanoPi R3S board")
Suggested-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts b/arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts
index 66a00cddda0c..243574f8da78 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts
@@ -476,7 +476,6 @@ vcc5v0_usb_host_en: vcc5v0-usb-host-en {
 };
 
 &pmu_io_domains {
-	status = "okay";
 	pmuio1-supply = <&vcc3v3_pmu>;
 	pmuio2-supply = <&vcc3v3_pmu>;
 	vccio1-supply = <&vccio_acodec>;
@@ -486,6 +485,7 @@ &pmu_io_domains {
 	vccio5-supply = <&vcc_1v8>;
 	vccio6-supply = <&vcc_3v3>;
 	vccio7-supply = <&vcc_3v3>;
+	status = "okay";
 };
 
 &sdhci {
-- 
2.47.0


