Return-Path: <linux-kernel+bounces-339717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60370986970
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 01:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2463C284CC2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 23:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C541A4ADB;
	Wed, 25 Sep 2024 23:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4SdDcNf"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8BA1A42D6;
	Wed, 25 Sep 2024 23:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727306474; cv=none; b=rAarcwQPqeF4KqDmPQ8v/FQHX/QvNkGmyEkJ+rbpP9w4Uwur0UNbklJpS9PvWGlId8jyjojhvVycJr8g2Xj77R4TeuRWoMA5QCRo+H7seN+PbdtyRHEO91Knpnw0VvjMa919Cfq9Won6O0bFROPwuyq2goL9qjbGTGuwA63UvAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727306474; c=relaxed/simple;
	bh=c2sS4xoizsm3otwYaedSca7IFiwsMvhp6CH09ev/rfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V1JKfeBsaqEBFCfdeJx5E6s4PfeVD7CLmoId58Xpy455Bm8DxAbUmx8YjNvQfT4KBjhXXzoMbCiZqqjdGj16sVFA53muV4KbRKX9VbCpvUjKlxmeVjei0RIv+TsnqGFxB66YD3s+rFkKGC5As3SnJRHvBXzhvE1bdkTjuvpj928=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4SdDcNf; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8d3e662791so25728866b.1;
        Wed, 25 Sep 2024 16:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727306471; x=1727911271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXmHQiif1/lZ9e9bTSFxlQYjcfk8NDtEcw/e34eAG2I=;
        b=V4SdDcNfc2eCcfRyeGB9tt2NqctRdZZpns6xfEcuNcs+1HuwG1wkTh3oZSj8MdPWV5
         YEp0VEba3epiKrEC4TSqQ6j8b9HzIt5boLKHzB4XnsGcdoMwZ5pMpnWb3YsAKxDjXI5Z
         3nZ1NLxXqNzMwky2/JRvhmyDOqLyPN/kfZWwsZPM2EWpNO1cao1M6AYDYIDf32GSw0GD
         cH0M95AZt+TL58lx146uMw8Quqks3/UeNnvJYlA6SJNqhwuL8tBfFzUfak/Tb10lMrnP
         gO3Ownmnc4rDwnWBjeJTACI4zUM8V2BC/A7umLh8gImUcpss6fB7sWlinhKKucsMKf7D
         fuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727306471; x=1727911271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXmHQiif1/lZ9e9bTSFxlQYjcfk8NDtEcw/e34eAG2I=;
        b=dBbhBkAGaJRKCKAn2HUe+qh+zozO1i62tE8i8DzHZidMyWGx50UkwJ9gLGMSg6UoRM
         p15X9DpCApU5AZYpjjaOStNZkjkFWVMkxRsHZVNdtBgPR4Ckgmn9l1UX6XTvj7aSfjNS
         F+oKvYZD6IM7GIYODMBoOWOvTOFcmDJP2CZrtLVKZ7XBrT2zxYgiiG6sNKS+06VE6/RY
         VHGPiBfGbT0SLvo+Zs0zDHTaO6iLffMYkI0CBf46YRka4UYlCMPMAeenWcsxiHxQfcxC
         h5Fuh7To7nkt1Db7pDZ8eYh/HGBgG7Xkmos6YaF/hc94pc3jDaNjh/56e02JuKBLQcQS
         z66g==
X-Forwarded-Encrypted: i=1; AJvYcCXpoPCJboVlXUjZX8Q//QfFyowJIV/bYxK1U8eeikTAOxO1Q9FsiLGbp0aQxKxQUs5in+erq/aXvTFjH7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ7LyaUCZlLN3SHe0BHX6iXqsPV3ouHPiVUWRHiGdP0Kp4HjM+
	/fKpS/aw9oTCCdR3vRnMdZk60LBQlj03ZYcMpTltWR+kVjsDo87zAcrACBn1
X-Google-Smtp-Source: AGHT+IFurIPGcn3OINfKpRW1ac8UmQhuz6IAdsY7IhLNLaWRW5DT3OY7ioHFhjittAMJtgpcbCsGUQ==
X-Received: by 2002:a05:6402:4409:b0:5c7:1ed9:aab7 with SMTP id 4fb4d7f45d1cf-5c7206120c4mr4095600a12.7.1727306470374;
        Wed, 25 Sep 2024 16:21:10 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf48c315sm2481026a12.15.2024.09.25.16.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 16:21:09 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/6] arm64: dts: imx8qm: drop dsp node from audio_subsys bus
Date: Wed, 25 Sep 2024 19:20:06 -0400
Message-Id: <20240925232008.205802-5-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240925232008.205802-1-laurentiumihalcea111@gmail.com>
References: <20240925232008.205802-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

On i.MX8QM, the DSP is in the VPU subsystem, which means that using the
'dsp' node from 'imx8-ss-audio.dtsi' is wrong as it's placed under the
wrong bus. As such, drop it.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 3ee6e2869e3c..f8b577ebdbef 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -603,3 +603,5 @@ mipi_pll_div2_clk: clock-controller-mipi-div2-pll {
 #include "imx8qm-ss-audio.dtsi"
 #include "imx8qm-ss-lvds.dtsi"
 #include "imx8qm-ss-mipi.dtsi"
+
+/delete-node/ &dsp;
-- 
2.34.1


