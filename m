Return-Path: <linux-kernel+bounces-534471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68711A46781
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063BA44153E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40BE22540F;
	Wed, 26 Feb 2025 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Slq/rI3p"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D3C22256E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588874; cv=none; b=lcQExTxPuLgEnFm+fOtWsKMUOh6oplZ3G9vZEiZ2NUrFzYJjGEQwLgs4HHh7hsgqPaRbRGes971Bidf7hS36G13z1S1l+iH10Y/cBhGv8n7OjnLBPCgYN6m4OlRtADScPeaAwT0eFIdy5d0mAdC2XtbNa4X46AhvTv4P3uBwXYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588874; c=relaxed/simple;
	bh=sFeqh9nKZoEYQ+a6IXzXR8geyg5sacchQjdojt4E2As=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eVysNaSLOnn9aG/X5v0zF/Ro2XkicQnvtNoLVnggR43TITm/98Ust/C8Lzb/XIjXb/s9bCM6V1TLjBOTM+A8/JZtuBFWtnGXWbjJdurH++lxNqv4tUsvCvlO5/zANrTN3vovfKLwzGRRyi5GnycZBX+dwPWCuvmFeonAjuyFsgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Slq/rI3p; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-439a2780b44so293245e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740588871; x=1741193671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZpy5GPgAtfFVvCtInpJGMk0J6F8LViPBE4i9el70qY=;
        b=Slq/rI3paciLpqsyLMIMYqrl/29P2NHSuKtfV7j+fEPtbtkkZ3TUe2zurBQHtyV3a+
         RFwZ7jt4sS38IGtfICkV7itaAHAqNiLX9QbS/g+28wCj9o+4i8o+ZV6TuAQEvP2vXxvk
         xyVMiHp4yW93x5ku3StG67/4Si7ByxKP6gIP/12mZp9sDcLRh6LvUsRxCSZpHyYtKP4U
         2s3gtztYVnCrMJ39WytDdDj0TPNaFxEHCTkgyOf/IqYzkGccLcMTkZI7+z6MdeThrgf1
         U7NeGrrAmxZrEAuHPg16ml3PRsfe+DPRBRRFqwtN+UIwW52AXAlkvvBvhL1AVQkEPUVi
         2dBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740588871; x=1741193671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZpy5GPgAtfFVvCtInpJGMk0J6F8LViPBE4i9el70qY=;
        b=pQzez4NR6E5LQ7lrUdDE/xa+yqrO3dOC+aQULyf/dnj++M3g1OuYdgqWZ5mxto+tfq
         5kjRuEkWtmvHQnWrz9Bxh+t2JXutKF2MlDgH7JQxTvwo1qDSbl1rmeOWbVAQsfm1fNpm
         WGq1hVLe8ZjPYif1r7HVLlnKgv0K053ng697/47wq9g0QE+FzOsQYQRtTuVwHG0183/c
         mB7j8Zywm8fZPrh1PTkPBUQlT014D3mKfn2mOilhloToJY8uk8/ZwTcWWsElWS3HEG2j
         zcMGIjFhdybomh2lxzbTyiXt6KE7szq4apOj8Eqj/6HlpzqZ1/6xnpUASMh9LYPQtYYr
         zhOA==
X-Forwarded-Encrypted: i=1; AJvYcCVVrponvPQlQ+GaoLaL2XF3VgHBpiNh1gN+5wXBBDx5f4oAJXgkOWtGYQjltLPruvXV7UoG0SVgrHqT1aI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5DLigIHIEt81MAZH3Y5FyVqkoVdRofSOaY8R2Zr0wEU2npSt9
	7b89PuXgs7RAdv3a2SZHY9QU2jliDMfOBzyz5mcSYuH0qXJVpgGp
X-Gm-Gg: ASbGncsnMbHs9xFrpZvxqqu/JeLQguLjZj5JdU2k+hELNObIO3XkTc+pSztylUvk5OJ
	IG4gcfT318X5Su5Ax9x91k8azRWBoFkKcR5POncuG+/kYEiMHkxH4evSpMLIXkVeWQ9eF6JbYBA
	SPK4azwLtjNPojhrVq+B9ndkjxMkwZV26QT7qTeY6c5IWWxw2/HF3moTRWhsCQllbwUvfWMWtad
	w4VCAyg+LbfK+/NDMneaJCbAdI82+UMTcUjVJ47bDNN+GWBm+HSSk/VdDxX+6ngCyiDBqi1NgG1
	lkevmYPgBvDRUI37iFdLY8sJJZZX8XU9Hg46w61PfLp53f1U8jwu+Yh1oYZCxJiR
X-Google-Smtp-Source: AGHT+IHImZk8rItKoGgyrvgUbtToZbbr8RHyX95hu/4NZrjTjx7+3Bt9rfSiRS3zYUPBD5ly6hBYtg==
X-Received: by 2002:a05:600c:5123:b0:434:fa55:eb56 with SMTP id 5b1f17b1804b1-43ab8fd8ee4mr38322665e9.7.1740588870582;
        Wed, 26 Feb 2025 08:54:30 -0800 (PST)
Received: from playground.localdomain ([188.25.208.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba587163sm27672515e9.36.2025.02.26.08.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 08:54:30 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Frank Li <Frank.li@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] arm64: dts: imx8mp: make 'dsp' node depend on 'aips5'
Date: Wed, 26 Feb 2025 11:53:14 -0500
Message-Id: <20250226165314.34205-6-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226165314.34205-1-laurentiumihalcea111@gmail.com>
References: <20250226165314.34205-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

The DSP needs to access peripherals on AIPSTZ5 (to communicate with
the AP using AUDIOMIX MU, for instance). To do so, the security-related
registers of the bridge have to be configured before the DSP is started.
Enforce a dependency on AIPSTZ5 by adding the 'access-controllers'
property to the 'dsp' node.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 3097acb4bd21..3550e44d00b5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -2423,6 +2423,7 @@ dsp: dsp@3b6e8000 {
 			mboxes = <&mu2 2 0>, <&mu2 2 1>,
 				<&mu2 3 0>, <&mu2 3 1>;
 			memory-region = <&dsp_reserved>;
+			access-controllers = <&aips5>;
 			status = "disabled";
 		};
 	};
-- 
2.34.1


