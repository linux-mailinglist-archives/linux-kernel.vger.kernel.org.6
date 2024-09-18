Return-Path: <linux-kernel+bounces-332872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4195A97C014
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 20:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7561C1C20FD8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698701CA6A9;
	Wed, 18 Sep 2024 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnXdEKwE"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB521CA6B5;
	Wed, 18 Sep 2024 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726683745; cv=none; b=q8mqRMV1pAGZgJAkYNOY6529HN1kvmstjf5uHVR6TXlDjMl01L+v3ocMEcuCEesQQkoHJ4Xye1uU0UqfleyM3hHabHTx3jrFtOS3E7rxMpC+FKNURwC/zFVsb/GE3gYEB2YUdY/UcJxujbIGcdnXpwZX2gmsK2k/tOwhU/pVjSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726683745; c=relaxed/simple;
	bh=8YM19QzFCM8eGgz8EZ2bT7GjdvGuC+VGDNjHEuN4oag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QVg/qLyOJlgswG7XMNuroNvgCuwrIcVud6UfrPiKgTOxFONMc09kMPaYXa3yJQXH+9vImRGCS4nBf4LEJIP869xlHzFvWvsL6RUfOcHHYU1I64v6I/XRSnfb6hKz5470pYAs3rW1XPVTWXp8s4kZspv/pT0OA5eMEZncczjC3gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnXdEKwE; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53655b9bbcdso8590509e87.2;
        Wed, 18 Sep 2024 11:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726683741; x=1727288541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DCE4EQe3FTB3Zd1ByKm20TKFtEumk9lprGlloVoGEA=;
        b=mnXdEKwECcTLJcD3v1DkOKic0J1iO8Mpior35JfYgBuqtQ+4izc0OSICPQOSHDacff
         bbGcDLikR6XI4itP/xvoAqFWzROEWtEbysvvtb1CLLl+HkyPuU5nQxiJKq7tt0ZEnNJe
         3cOyjxPmSkqr5XRwMtRDFMD7ZSO4URDzmtLffJgO5lMvHjZnQs4VBe2RTkMzf0zrYsD2
         717IOwA2CiK+xG9iVoQeCKT7R0n7KKpKTMVFG4EVPPMpsIGfNUViRKLlwEFFsNISkTf1
         2MWCxrh0nyrTVwS545J9lsIeu7heZBL9P1KZRX4Z3y00DJIyEm6f1mIz6lLqwK/XBtqk
         H3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726683741; x=1727288541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DCE4EQe3FTB3Zd1ByKm20TKFtEumk9lprGlloVoGEA=;
        b=Epx7ZWip642KKABW47TEHnxRM29aPdAm6qXfUdQH2+hSFPj4bkExn+LZ5iCCfevUEs
         l5AWqEIaLpMhIbA1x5Q8peNsBqVJAItJvf7XVi0zfBs2VaEblrggjHGQO4sFMQ98PyO6
         5MEYYghCkPbraN7hc3e4bnTTMuryUQJmb3hfB3PAxevGKNibdTq8Pze5KQPGWBNKgBMX
         EHmtTsXbmtVPKqfppnFM1u9WLWjU80aQR8v2zlDctv+z6j4mfBfHP0hPjiEkauEVvM6Y
         pt2YA35ifaztSXj4t31DyMZOjX+bikF5bREtAt0R5Va7kD113REvaaWT0/rxrkeft7Xx
         3W+A==
X-Forwarded-Encrypted: i=1; AJvYcCUB4Qyb573VFG9xUnmhiZDm0JezZbKRTaQYjBr/5l3YTSHHio52ivUqUWk3IpzRP5SAIsjYpqcrUit29XI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2RozSRAt061yX1QmHYFSMTkyLscIjAki2vZMZJ7di34VmPJKO
	Sl/kVbdSGNyd9I9tmm5QAoFLmtleNdmWvanpyVuHXeEjpNRvayE0cfNPekeD
X-Google-Smtp-Source: AGHT+IGEFT10GNPLQpnYd/skpk/L7HV79dsRiA8pFMtfFOceX/X7PZQXcIB8iPGV2an/mF5hnF4DUQ==
X-Received: by 2002:a05:6512:3512:b0:536:a4d8:916d with SMTP id 2adb3069b0e04-536a4d89286mr532824e87.34.1726683741352;
        Wed, 18 Sep 2024 11:22:21 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb5312dsm5200146a12.23.2024.09.18.11.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 11:22:20 -0700 (PDT)
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
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] arm64: dts: imx8qm: drop dsp node from audio_subsys bus
Date: Wed, 18 Sep 2024 14:21:15 -0400
Message-Id: <20240918182117.86221-4-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240918182117.86221-1-laurentiumihalcea111@gmail.com>
References: <20240918182117.86221-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

On i.MX8QM, the DSP is in the VPU subsystem, which
means that using the dsp node from 'imx8-ss-audio.dtsi'
is wrong as it's placed under the wrong bus. Luckily,
there's no users for the dsp node so drop it.

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


