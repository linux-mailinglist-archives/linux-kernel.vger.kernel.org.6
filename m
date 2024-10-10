Return-Path: <linux-kernel+bounces-359616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6A2998E1E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 543E51F2512D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D83819C564;
	Thu, 10 Oct 2024 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GziYm9uT"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8011E19D089;
	Thu, 10 Oct 2024 17:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728580326; cv=none; b=QyFfcABCgFQjr9Y+o/2ao63X976gwHYm473QWpsvJBfgI8cyhftHlcRniYcLrBx/OCu3QKPqpBhO6cF+SFxdDFVP6sewTlNGRwVPc8dRDdijP/1IzCAgQlD74vB8q+W8gq6FDww1n5Jjbsf/8YjsW/HhxPryF56q51lPr/Z/yrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728580326; c=relaxed/simple;
	bh=JETx5J/sKCvPOdMNztGgJW5e9rFQF1hAwJoodVFMVb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aodFBbRTo68KGlJw9rBJbtITn3D2KZxA5j6hzd1EHC/vEP4PFxnhS9eOHonUhZUJ0IcEWwn51c81eXy53xdOMKeOSvfEd9x+ol5KGXEezDQd03IYsGTFvDjR9OmXb3sI6qGiJEUd7zaT8dPpDXyDzzyZGZw24QnEHR/Fse5djEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GziYm9uT; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e0cd1f3b6so935589b3a.0;
        Thu, 10 Oct 2024 10:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728580325; x=1729185125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhYysHcCoTgAnQmQiLxk715z8ONeu/3OrInyTwPTwgI=;
        b=GziYm9uTp4goAMXcf+xkNYD4yrNgSDof++A9P4GJxfnK5UpmAcdoHMBnC4anM1cqan
         TIos46X5P34GmV/SkfS+dcZz48aBj7i21AwV2crhQ6ISOXaCbB4KnLjCdobulQ7SSDlb
         0bGUEHIhabtiTSmPxXiXCJQv0Tw1ZC1gITlmTIdEhm/gwMQY4sMaUjir/OUt9LR05bOp
         RfGTEAtEVVIECTCxQ1rdoZ8bXcQ6H/SoWz/5278cfwZGs0ry7u1PpleWR3t8NPZttfVP
         7PEKAighN1ccYCrBVsKmylvKE4z/HGka9SthS4HEylLYlO3BoJwyTrkSfFhZ/Qt7NqoQ
         /5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728580325; x=1729185125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhYysHcCoTgAnQmQiLxk715z8ONeu/3OrInyTwPTwgI=;
        b=XSr1BIALeXLzJ3ZF8of9dtYib/CNSDrLLelxTUG+sTVBxZ2+K2k28H/QTyBZMduUfG
         evdC9IzgL7vYZEam5U5Nh/AXb5b/pZTehI+G0qjgigZ/COfGVboCFUz010z6LpeSlJFc
         26MYZZ83zeu/JZVA0YHhSXXqKAB1g2Hie3hainWphYn2MsJ5AZ7wzldOvjtCRWWcHnWs
         wJLeIhZJatWjdG+BshWvz/wGnBtl4KnDLWtPPFs+LBw/Xa30HH0FyoG4/KD3GFm16pYP
         ZY+1pz9eQ/sH9JKOVRFY3o9gocFjuFrYVIkuaGZOxwKbSC6GNfdQiysw5Qr/FN5M+8WO
         FlPg==
X-Forwarded-Encrypted: i=1; AJvYcCU8W/7NU9v4Hv3BzQOCCHE6joK5blLweLwBFPWSXYs/9zpur8fnBkvHlx96x4A7I6eOTBs1itnZVoYGWyt+@vger.kernel.org, AJvYcCUaCLKDyWqOUPRSfwvAVEyITauqS8dxw5MRkcKwSR4qg6PHgEoj6WPFfBjafXXmMyZJnvmBzL7ao91k@vger.kernel.org
X-Gm-Message-State: AOJu0YwmxnMFpVHPNapzGhBa9iuZLn+mILudPJTchyTjYnrofiNnuqlc
	/8EKomP1f/evsy2axdajtOo2DTvnCgkzOm3YteQk1k2DJQjkmxL0
X-Google-Smtp-Source: AGHT+IGZGyCCyr54kMNwlY/KxnYBhNiDRLZg7Mrdzaj7i6T146Y18Up7pDtTXvONDGA8HVHSAf2/4Q==
X-Received: by 2002:a05:6a20:c908:b0:1cf:476f:2d10 with SMTP id adf61e73a8af0-1d8a3ce525bmr11403945637.49.1728580324810;
        Thu, 10 Oct 2024 10:12:04 -0700 (PDT)
Received: from hiago-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2ab0b5d3sm1251245b3a.198.2024.10.10.10.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 10:12:04 -0700 (PDT)
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
Subject: [PATCH v2 2/3] ARM: dts: imx6qdl-colibri: Update audio card name
Date: Thu, 10 Oct 2024 14:11:27 -0300
Message-Id: <20241010171128.107819-3-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241010171128.107819-1-hiagofranco@gmail.com>
References: <20241010171128.107819-1-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

Update the audio card name for Colibri iMX6 to match its specific SoM
name, making it less than 15 characters to fix the following warning

fsl-asoc-card sound: ASoC: driver name too long
'imx6dl-colibri-sgtl5000' -> 'imx6dl-colibri-'

making it compliant with the ALSA configuration specification [1].

While this is a breaking change for userspace tooling, it seems
time to implement it since no ALSA UCM or related configuration files
currently exist and we are in the the process of creating them.

[1] Documentation/sound/alsa-configuration.rst

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
index b01670cdd52c..9f33419c260b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
@@ -136,7 +136,7 @@ sound {
 			"LINE_IN", "Line In Jack",
 			"MIC_IN", "Mic Jack",
 			"Mic Jack", "Mic Bias";
-		model = "imx6dl-colibri-sgtl5000";
+		model = "colibri-imx6";
 		mux-int-port = <1>;
 		mux-ext-port = <5>;
 		ssi-controller = <&ssi1>;
-- 
2.39.5


