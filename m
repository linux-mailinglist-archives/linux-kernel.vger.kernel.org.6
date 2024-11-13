Return-Path: <linux-kernel+bounces-408224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 269DC9C7C3E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFEE6281B5F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E89205AD7;
	Wed, 13 Nov 2024 19:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yfo1rOeG"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77952038DD;
	Wed, 13 Nov 2024 19:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731526598; cv=none; b=ZP66hFBEkX/gkF8+Hx832k6L98JRcMRJsTCDfpUiIq9/42JTPVwQtaMc/s9ne4ES55jVsMdRdXzYI43VBFLvj4SKmgfJoo+BlqKDSnNcM9nkhwdBij/0QdMbW2kBjf3TnRpTvAw5L1pa0J/k4IMzQhjGEauUxZwS6R85PlPUKhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731526598; c=relaxed/simple;
	bh=tul411GCQKE41kaGVUPN76Dd9JbE0cKcs195gRd+9xw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cz7h0j85skBTs5H4SGhE+4ONB3fESkUKVyL6UvRGrJoP9xJtwMvPokzs+jWYp/zbpz8FKK/kK9lKhBVQaiyVcn98oul6yIPdxWPdj7uqSils/Smtg7g0wbAh1P/BbF1OYnE82VsGZIwMtKEmNSzI5+OeeAXzZXYg3A0qD5fxWPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yfo1rOeG; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d3e9e56fdfso302766d6.0;
        Wed, 13 Nov 2024 11:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731526596; x=1732131396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yPUIbOva92yuy+QEnGdpUmLYR+csAbyNvcDkxMU7mB8=;
        b=Yfo1rOeG0r+NX0AytXS24qijRz5tCuX86fx2WU3qQBYe0FzQGOP5p9gBUwo2XMm6ML
         lUWgfigAL9B5zsQ8hOM8Va3OzRfnNR66HIiP3dqL7mCtb5Z43jd9pJbmgPMtifVYnP1/
         m/JXUkxktRZ0v4mwSkU/QQNxxRo/a2kQznc/PPYGkpdVHSi+NpWJwtZLnPLnvLLixHXD
         fND53GCu83UAgyB1U0IZ0xmJZkl5RtlHnqRD0Yj0ZKsl4fSIKN9pXC9de3fq0z0kPBSp
         4JK161z0cA00mEKY5MHDy0zV5rKvNwwUDCScrgIPWusIPQC/Jpwl9JXAf0JpbIvnkCUQ
         A72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731526596; x=1732131396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yPUIbOva92yuy+QEnGdpUmLYR+csAbyNvcDkxMU7mB8=;
        b=ZQHx2OSV1bmfYC8d5qy8vsPJkp0W+buToR7Mnhp7J3rnhG4uV3GfdCzi5ZmzZLA4lE
         3JWXqFiKQJN6ePNQLnxUbHBsS35bH2N4B+JOLMQYeQPUxzJijQjsv6EtjG4n0WsHH+f3
         gpv8CXOc5IrG5xgt3vUrZquaE+lY4/rrvwimkSAV5MfXWMdMYA7CORk9pKcRdkumxkQE
         3BfCy2KcQBM/JBhoGuAz5CxyEffHZjD5/g4oNoEtUBn7m6HFUmUDOIW3nBcRs63N6wDn
         PUefPZJVz9IyCIVAh5egCUahVqXwhrqfCVN57AsyErbjXSnq732LLo0IR9FtkCLfF0S9
         OVZA==
X-Forwarded-Encrypted: i=1; AJvYcCXeyv63SUVBt+qDHJPYRbc4UxzCntIDUpg0oYSs5YXqzQ8qSQ2vwsefRr8t+r7IBLdnq6GagxrEfFUQ+uQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE9HQzwZaPmi3baYvjQfMM4TocWJQImeIcxpJWsgI9FJPx4gsA
	6HHvt2uZkPUUZL16mIlk6DkqpGP6keeRVLzO+9Q+YhrXeM4SWhMWYIgnxKNY
X-Google-Smtp-Source: AGHT+IEXIbvpmlTDbC2bSNCbht+Om4jIXJBqxIODGdhf7X9uH4GIqKJbkG4rhCTNXSRhGJ+I2f+eGQ==
X-Received: by 2002:a05:6214:3f84:b0:6d3:4453:6a48 with SMTP id 6a1803df08f44-6d3e90c5620mr10408276d6.13.1731526595643;
        Wed, 13 Nov 2024 11:36:35 -0800 (PST)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961defdasm88421796d6.24.2024.11.13.11.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 11:36:35 -0800 (PST)
From: Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <jesse@rivosinc.com>
To: devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jesse Taube <Mr.Bossman075@gmail.com>
Subject: [PATCH] ARM: dts: imxrt1050: Fix clocks for mmc
Date: Wed, 13 Nov 2024 14:36:34 -0500
Message-ID: <20241113193634.3487554-1-jesse@rivosinc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jesse Taube <Mr.Bossman075@gmail.com>

One of the usdhc1 controller's clocks should be
IMXRT1050_CLK_AHB_PODF not IMXRT1050_CLK_OSC.

Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
 arch/arm/boot/dts/nxp/imx/imxrt1050.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imxrt1050.dtsi b/arch/arm/boot/dts/nxp/imx/imxrt1050.dtsi
index dd714d235d5f..b0bad0d1ba36 100644
--- a/arch/arm/boot/dts/nxp/imx/imxrt1050.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imxrt1050.dtsi
@@ -87,7 +87,7 @@ usdhc1: mmc@402c0000 {
 			reg = <0x402c0000 0x4000>;
 			interrupts = <110>;
 			clocks = <&clks IMXRT1050_CLK_IPG_PDOF>,
-				<&clks IMXRT1050_CLK_OSC>,
+				<&clks IMXRT1050_CLK_AHB_PODF>,
 				<&clks IMXRT1050_CLK_USDHC1>;
 			clock-names = "ipg", "ahb", "per";
 			bus-width = <4>;
-- 
2.45.2


