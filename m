Return-Path: <linux-kernel+bounces-281766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F2E94DB07
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 08:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02521B21CFF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 06:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC6A14A0B5;
	Sat, 10 Aug 2024 06:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="artwTuy9"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607A33BBE2;
	Sat, 10 Aug 2024 06:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723270703; cv=none; b=bAfg8G9wCEoqvLo2T4/hv+46j3u4CO87IiFD/H9ibvCkuSSOgUpp2dv/fx+GNEpY1SNLzcBzbB8dlQa2tI4i0vkL9HB4QFJXUzIKArY5ysIShe1rXAvE7xP4TiV5ldxzVCtvRCMVlpge41vFykcEL/23CIPC4T5eqWYh6nH0K44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723270703; c=relaxed/simple;
	bh=E7fuWS1G+p3cvSQjMO6MQozqHSUTKCILpI5KraJuo2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mRoVzwQ63RqB89AFSPYBGvTDKEGZzsWtxB+EwB4TnOeLs6Tbr4GbBbxpLb8HbidRuw+ni3P1bqWeqsArvtsZrWNYBWrYQ+kRkaHhhtCN7Kbu3Cwx4L374W9J682+EuHiDNlbWpAh41L0bOq8B0JjarqAzFPiddzG2bek3+BQoAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=artwTuy9; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2cf98ba0559so2079976a91.2;
        Fri, 09 Aug 2024 23:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723270701; x=1723875501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8sq4JWpemr6JFiizs+pQ1bnG/BODQqwvnDyMBZjSukE=;
        b=artwTuy94/1z+sos115RjbMRe8m2fNlAf80DGtIofJP1a+q/zfJIMgIB4wWpoYW+k3
         6mcu/qsgyA26rox5e4Z1Y/ulnOlP422ZOIfnVHPEOpUPIfniMgR2gi0SL/aFffC4CDGR
         t4lsuATipOtlhTMpT4OaJ5039dJn+piytiQD8VXVeUzvWBzVHuBpG6BL8Kio1jJBiIOe
         EDpRcrR6QyAwSJccXH7300GFQTXhzOoPFrqUHAA++QR6tGNk2CN+ThQJow2+hkdjtiGU
         vLippPt+KmQ1/ARMP8Y86B0h67ycnCjqmTj2Abd6hk/2Ha4YgPqrybBol+zvfhWNHs7i
         l7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723270701; x=1723875501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8sq4JWpemr6JFiizs+pQ1bnG/BODQqwvnDyMBZjSukE=;
        b=W6HmG42GS0v+BDTcpB3eC0BVVZjgWJDVQLzsG/mzCGIR3KBwat7bP4dHw4T5Ci8gwd
         aeq/cm/Hj5sw6zUdpWOuLdvE5QPm1icvzQa5MhEJH/vkK6ykzYsD8ScW91jLB4dongpy
         A5CLuJYIxzy4rbbV67znDz8ifsF64odH5EPurucRVGzgUdszrU2foTlXJbUqfy6d2yJN
         fWODLvg02Wkc/fpSLBvWmhiA/Zvr0f6LNNwssU7KHWxmm02MyK8Oo85WOqhvv6PB4Hx3
         yBlrSw4A2/Euo3YCOrb7a2UkfrSIe4h+NMBZRLY4S0UFxzKwEyF72l3C+39UtTUg9+Qx
         egbw==
X-Forwarded-Encrypted: i=1; AJvYcCWzQrcASABWbjU/9p3BxG1GxJd70w2UJxtjykwshO/u/atYShFrq+/FwGzE3xasq/mdLNXOK4hstRs8cMBnQxNZgcFcc1Izy5zeq1B0noj0nkbKRPaSeAU/1GRxoLmX8tYDkJM27Q/HFA==
X-Gm-Message-State: AOJu0YzSZZEL6Z4tw808Pw42vQSgjhx/44m07BJLk2vHKRbeYCrRUbMC
	hozw0xQk436iGZggLlf+0vAGexpHVLdHHKwBJ/ZFsKWYutuVRmBS2JZPLz0I
X-Google-Smtp-Source: AGHT+IEZSxHyMu/Nw4TzERiAkLPSnqowQVZSweEvcSVXyW0ndOaygMtsuGHdwXXCqOE0A7afjPxFRw==
X-Received: by 2002:a17:90a:3fca:b0:2c7:22d6:98e with SMTP id 98e67ed59e1d1-2d1e7fe1bd1mr3542665a91.19.1723270701344;
        Fri, 09 Aug 2024 23:18:21 -0700 (PDT)
Received: from fedora.. ([2409:40f4:ad:f161:cdeb:dbe:82d7:bd25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1fcf29eebsm812227a91.33.2024.08.09.23.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 23:18:21 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: Animesh Agarwal <animeshagarwal28@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: layerscape: remove unused num-viewport
Date: Sat, 10 Aug 2024 11:48:06 +0530
Message-ID: <20240810061812.155376-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused property num-viewport to fix dtbs warnings.

arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dtb: pcie@3400000: Unevaluated properties are not allowed ('num-viewport' was unexpected)
    from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dtb: pcie@3400000: Unevaluated properties are not allowed ('num-viewport' was unexpected)
    from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie.yaml#

Cc: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index e61ea7e0737e..4e05af0203f4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -541,7 +541,6 @@ pcie1: pcie@3400000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-			num-viewport = <2>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x40 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-- 
2.45.2


