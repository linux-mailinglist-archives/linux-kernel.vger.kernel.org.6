Return-Path: <linux-kernel+bounces-321313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614BD97189E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4F93B25B43
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F32F1B81A4;
	Mon,  9 Sep 2024 11:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2OqJB4V"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F39C1B7917;
	Mon,  9 Sep 2024 11:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882587; cv=none; b=EZzT+FpDiN46Jku9b9fjczzS8LlH00k+2Gp4qiSE+0YZ6ng3AOXitozGSj5xgQhLPnNmLR3jgvqxAP6hpXWiRFzZ+4JC3rtGXN1x7c84ZkkIa5jYCO4Sie3Ipq0NslwLsZTQlOf5Oe2O0hE5uWzsXVbhakz+MeuNHIn3/eJIQfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882587; c=relaxed/simple;
	bh=QgtHIMpjtn3bGDdEa6ryJ9WyaUPfJvtSFw3QZhNj3SQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jAmaxE9LQL27VhEvEJsgOmu0t1lueEtFyf/ktKJAZC5FbsIJ3CagOocOCppf5DIUrijAjcUcrjduRMJGUOJgQnClNz7teK5wFuYGcDqJu5GmuQbd3Gv/hESK7s4GhRpefMFznOY55VnU+rPpYl6Wcv36qJwyhEA42QStjkes7k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2OqJB4V; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5365aa568ceso3566615e87.0;
        Mon, 09 Sep 2024 04:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725882584; x=1726487384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SrH5fJX/lD1lScDa7P0w2wLCrh1QxPnu0aKdVtdlvA=;
        b=Z2OqJB4VTPfLtmP0HYLOrxe1piKRJAaOIysQKRHmq49iKlgeOZiHvCVtQq6qOGFBhO
         P3M2S3eY0/pGBMAGr5xfSm1LeELKLg0aq6X2wwoRvB0MAmv8lOcpxpz620CWnzF8ulTv
         e8G9EJmoAR+j7oaaRI9ZhCnKyZw43/SqZYN7wudFE9rNHykEO5yHPh66lJXAOINkGzFQ
         V5DFw3zz6Y7ngHVOBI9IeQQX11RdjbKJp1aMZUB1mLxs1taf6zv+u2G65QnSR0V+z5nL
         zrl1jq6MuwdbPE6snnhyCJjt91FfK22bBDrfXx3Ig/6zrWbvNaHNIrQyteWK+ox8DyX3
         PrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725882584; x=1726487384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SrH5fJX/lD1lScDa7P0w2wLCrh1QxPnu0aKdVtdlvA=;
        b=A9EWNIyme/i8FNtMNZsUzEM1Iu01W0J+SFMwgmRom/4/qWyC9jvgKcQpmEwCyNlWLD
         9wc/B28UCEhoEpo0kZtQ8vFlt7bIXOAVxZ7Sb7KgPlDElVKp8TQ5wLfWLHC9T1eQq2aP
         nOU40dOXPDBUM+CZ7PVM2Bq1529HxGF9gfyu42gqs+ZFqHHGFpc9bz+lWov4MxisBVC+
         QTxE4G4YWc9VdG+Ibfj02oJVs1KxvVph18D9+Kj+2I9BNs6eetkMnHIVftxV/aXf+Imh
         NkGIkioF4T4O8ac0byXGd+OB1cC/bbAAjb4Z3URTOJYKR1HLyU9QbKGkWz+CX/6u8Anx
         nnKA==
X-Forwarded-Encrypted: i=1; AJvYcCU/GjTE9rbd8nByISK7fJZRt4bN6E2MuxpGPNtgHPdvss6KAhbwPi3N+1gvL/6Ke+bzAcZIDQQSGQ2X@vger.kernel.org, AJvYcCUZEJ2m3qRQKLkdiwZ8c3P9PI9j0pqu79TxwBUNL93IJM+RUa92klGVsNLQoLjubv/WDf8uqtx1hqTAN6he@vger.kernel.org
X-Gm-Message-State: AOJu0YzeSH2dfP1wuYmx+ePZosGHiFrqX2oFK4qzvXT1ZRVuuBMLxR41
	sMFEv535yhLosRp82Pr28vk/EBvB/0GBB+CI1SKmOfhxeOIpOBtHf8XMet2DT5g=
X-Google-Smtp-Source: AGHT+IEFlBY64a4PNwKClA+dB/6i9d7wohMcmhw2O+Ea8FAfmTqfSbsQcuFCHgj6kSiZsUrDTBHILA==
X-Received: by 2002:a05:6512:33c8:b0:535:6aa8:dc49 with SMTP id 2adb3069b0e04-536587a672emr8694852e87.9.1725882583246;
        Mon, 09 Sep 2024 04:49:43 -0700 (PDT)
Received: from hiago-nb.corp.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25835697sm333258566b.16.2024.09.09.04.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 04:49:42 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: [PATCH 3/3] ARM: dts: imx7-colibri: Update audio card name
Date: Mon,  9 Sep 2024 13:49:02 +0200
Message-Id: <20240909114902.82380-4-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240909114902.82380-1-hiagofranco@gmail.com>
References: <20240909114902.82380-1-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

Update the audio card name for Colibri iMX7 to match its specific SoM
name, making it compliant with the other names for Colibri iMX6 and
Apalis iMX6.

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
 arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi b/arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi
index 62e41edcaf1d..8666dcd7fe97 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi
@@ -120,7 +120,7 @@ sound {
 		simple-audio-card,bitclock-master = <&dailink_master>;
 		simple-audio-card,format = "i2s";
 		simple-audio-card,frame-master = <&dailink_master>;
-		simple-audio-card,name = "imx7-sgtl5000";
+		simple-audio-card,name = "colibri-imx7";
 
 		simple-audio-card,cpu {
 			sound-dai = <&sai1>;
-- 
2.39.2


