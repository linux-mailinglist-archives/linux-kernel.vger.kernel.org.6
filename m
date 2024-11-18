Return-Path: <linux-kernel+bounces-413171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE5C9D1490
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B9CE2822D8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837871A9B3D;
	Mon, 18 Nov 2024 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N92Qzi0s"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88720194A70;
	Mon, 18 Nov 2024 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944206; cv=none; b=kxTiODX3ULcB8xeBxYJ3AUQAIAa2Uv+wegh1dq8giFzsq1GRup2hKzplGlP1jJ8qw8m8gQAyBrveQ9x5APCcg2LI+1H+TRCB7vjh3vDUBMD/VPpnay1M1s2r9MrvFQLTEqFe6RrEII2/cTAjui1zgk8orGFgtwhxFRAX+dLTz0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944206; c=relaxed/simple;
	bh=/T1HO0gbxRmQuS/Tf0idE+GqQiO3iy9sEezBwtWSjyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cR4kWwP6Ttd8PkycJDxoBRkIq/Y816RleTplf98pXQXFWzjSJycz0l72wGmYQF0ZmMvIDf8M0KvU8d87K1hospi5AWZgtYVvWSwNuxzipEFd9xRccwGGk9o8WUXEgPJTMZ5ofAFXjyM4AmwwUoBPqIUJgnfamgqOB4UeM/+jlxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N92Qzi0s; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d42518f493so5196406d6.0;
        Mon, 18 Nov 2024 07:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731944203; x=1732549003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rEKo1LnFlWDTdn6dZMAURbf9LKsxfQWrYSaiKgMPlwU=;
        b=N92Qzi0spo2C8TlbvA3MXQJmQ3wK4bKJFRO8SNoqGzbz+2ONnXIxdYJC28Y+eurkwD
         UlJYu/mJ8YcOmrpM139qnCgOzfYZ7yvaFvs0fqHKi8bvJgU928twoUqVWIp0IV0o+iQz
         kXn31kMRFil3ULHUh8pYvnOLzxiYvGkDltA9B8Lf9ZzGS8PFid0+jpmrY+cGv0JN0aqx
         zo9pV3nIq8iRhaIJ5K7ALqlWh+XHSA6b94l0BG1sNahWd7AICYy0uNMd6H23LCxLD2qA
         SH/BsDzzVeERkiTasW5D+XljjRQylHrbbtFQ7fzFpIGRxeDqOQm8ANCa4GXYJAm48Mvm
         h0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731944203; x=1732549003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEKo1LnFlWDTdn6dZMAURbf9LKsxfQWrYSaiKgMPlwU=;
        b=H8P9SrWqDJLM/WvUCYN4pghVcf6Sf+X5n+dAtPLmZaNk3zt8AogRX+l9bNU5crv52R
         7kb8VSJkvq5wN1C0NsK0tMeBr0ceQucvaxP4rxL8wKGqEIPpZScdrRriJ4KwDvRMW3J0
         Mvoc6fZgkAI1ir8BaNsOGVIHtcBsZN9G1II4JLpKvl3nhfIEMdZbspbpE8jteOTkm+Sj
         6GwWoYH6cwS8GT/vuNtZBz/g7jph/Zd7imhYH+PAnUd8pxUi1bgqmXnnu/3cR++XQQSn
         WzKqCVEgYqBj+6HOhswbntTv5eOcjq6B2AayPgXhNOm/SmKUQvzFpBBM1QzR0KnYmUz4
         7OHg==
X-Forwarded-Encrypted: i=1; AJvYcCW9As5nGufyfIf9kKfJRS48RShkUuQi+st2oGMIOrBFtQm5WPf9c4hWtDLWISP+KVO9GuiwylBK79KmOf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvLml8FmjcxxpiRlbD7qn2b8R82juZC9RZxE3l5/2TsTRX6u3S
	E03/pT/kSpiT1xjfDp8cHoVZnlYeJFi7Ib1dE4hv4R2PdjAt8w2lSVQlSg==
X-Google-Smtp-Source: AGHT+IEcd95ubIBL37xxzdGe7timBRl38iQzblD35wsDcgC8b8s1bMJjKf/cNrXEIvob+2HTG/uadQ==
X-Received: by 2002:a05:6214:c68:b0:6d4:10b0:c23a with SMTP id 6a1803df08f44-6d410b0c389mr93755366d6.3.1731944202927;
        Mon, 18 Nov 2024 07:36:42 -0800 (PST)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d40dbffff5sm37044146d6.34.2024.11.18.07.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 07:36:42 -0800 (PST)
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
Subject: [PATCH v2] ARM: dts: imxrt1050: Fix clocks for mmc
Date: Mon, 18 Nov 2024 10:36:41 -0500
Message-ID: <20241118153641.3775085-1-jesse@rivosinc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jesse Taube <Mr.Bossman075@gmail.com>

One of the usdhc1 controller's clocks should be IMXRT1050_CLK_AHB_PODF not
IMXRT1050_CLK_OSC.

Fixes: 1c4f01be3490 ("ARM: dts: imx: Add i.MXRT1050-EVK support")
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


