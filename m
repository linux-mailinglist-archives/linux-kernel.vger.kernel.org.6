Return-Path: <linux-kernel+bounces-253640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E222932430
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ED041C22D1B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE9E1991BA;
	Tue, 16 Jul 2024 10:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wE+uL62m"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19191990AA
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 10:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721126112; cv=none; b=JHoApJMQpaDbtYSaqY2mhbbkVFJ+olTyDvWcoxfY7MKlBSXcUL4UhYlkq7JUMAUPcwPScIWToaWb8A9cWMIJ84Hc1/wUUpcM03KVcz/MwLYaqk4tl5bBqC1Gu1BapdzqzVEsPZdSIsb3wp5hm08KHBG4YN54+kEItUFSrV8cr6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721126112; c=relaxed/simple;
	bh=7vQTQQyuhmt2Fsu/yP4JUKcaZHU+0sTpZG4M5OjD6oo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s7QfEe6Gh+FCXbwzYaLxrILZOYU1eeWk9LNNXjfzzahWR45HIftAIn2VCvcORAKT2iMcyWighKhYaHahIpK1Ot6gpT2w7HzKMm8POIz9V+NiDrm755lPnYoF5+D3kdzgWvruEvoCfHI7h5XKsq4e3RB/C19rF3el/hx1s4Ac6QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wE+uL62m; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eecd2c6432so74928531fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 03:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721126109; x=1721730909; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UgsflY1C9wxQUVHsZuow/H3LY52gGTetIqxZfdh+XAg=;
        b=wE+uL62mUE6OarJ7PP+2ZPiVBVEKwBNYDaDeY289s15JKo8jJl7/ROd0xkicvAJFIJ
         07RDHRx+rM7kzzbNZkjRSyzNHMPIPR5PGovwXYSRuDA7BRCx0YckftC4VRi1XUL9SQEz
         Gu5gRC1KUX3ip2R8nbkPcNB7EzMe/mrUZgRT7XflDalp3tWr89RM+3/sVTvXocBlOHOd
         IsR+doZ1t4OdXJIX+aQvolV0SJychU4OarGhHNWBIddUgMNNXTsoHil1zEK1oN4lvY/4
         LBj3kGNzzjGijVKfw8/Sv1zF99HtwrRuVfpBEmLgGMURnwLl8VF1zPpXgK7cnyvLlj+d
         dsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721126109; x=1721730909;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgsflY1C9wxQUVHsZuow/H3LY52gGTetIqxZfdh+XAg=;
        b=HdACrbko82lGuGZwkul73MrLoJt9IIVDFHRouNWSATGGsfeDxAw6zlW/8ACRzvgBHH
         Lmf6Eewuj8R8KYpc9hfKsP77vV3HvPe0CtYfYEnG0qWukO3kxcRWTnvuHM4L8ot7y9I2
         tqxpd+3oXYqIFZbPv0xO/cw4SXnwSKqfc5DfvzCnP/5GL0cAwfDyWod+4tSWU3J0K+fq
         bAlU4lryC7p+zMGCaQcUCAI7ggZ0Sn4tSKg2ivlSMlh0pfiVZ+PIv/B6W/P8VLnwuX73
         Boqvei+Srmq41vRKn4PcaCk7Ifgd/6ROZpnYbSiN6wSgzC4q6MkKM7ozrKvPAr/rH+5F
         pBdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsxes8tBcPDIz9ej1zdNa31h+8rsxOU5tR6lJfOtc7d7GChlQ7J3LcTxdTfF+TaZrG/WPcmzeUdYIwUNfvw7tccE4ih7t7oh9ctGow
X-Gm-Message-State: AOJu0Ywu7kEdd+GnTfIFDhxtfaww9u68mmYilYQBrPFySw8mqh0ad07v
	Co4PNIdGXnxYPEs969xYaplMKrRv59CZ8FfjjqFLXQelYg+UPcEVB8xEhdl881Y=
X-Google-Smtp-Source: AGHT+IFb+DSR8Ihb6G6BTOMgTWpx5HQyDkYY6kNBsMWa/Jp2/+iSpUU9UaoLtBQhwOAJobfMjm5xxA==
X-Received: by 2002:a2e:9dd0:0:b0:2ee:9446:9f58 with SMTP id 38308e7fff4ca-2eef4156dd2mr14132801fa.10.1721126108567;
        Tue, 16 Jul 2024 03:35:08 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5b7eb4sm294039766b.60.2024.07.16.03.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 03:35:08 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 16 Jul 2024 12:35:03 +0200
Subject: [PATCH 1/2] arm64: dts: qcom: x1e80100: Fix Adreno SMMU global
 interrupt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-topic-h_bits-v1-1-f6c5d3ff982c@linaro.org>
References: <20240716-topic-h_bits-v1-0-f6c5d3ff982c@linaro.org>
In-Reply-To: <20240716-topic-h_bits-v1-0-f6c5d3ff982c@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Akhil P Oommen <quic_akhilpo@quicinc.com>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721126104; l=899;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=7vQTQQyuhmt2Fsu/yP4JUKcaZHU+0sTpZG4M5OjD6oo=;
 b=xsFusYWRiBUxGBk2/itp+19srhpG5PVgylg/VcbU4n4ejR+EMHAmFa1W0fG/tzuuKki9TMzKg
 +WfU/yCIeh2D6LD9ow7z9KV/rQlE7NuD0bvfOt/l2frmuPZkLKfiQN6
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Fix the unfortunate off-by-one.

Fixes: 721e38301b79 ("arm64: dts: qcom: x1e80100: Add gpu support")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 7bca5fcd7d52..47bb26a66b2e 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -3288,7 +3288,7 @@ adreno_smmu: iommu@3da0000 {
 			reg = <0x0 0x03da0000 0x0 0x40000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <1>;
-			interrupts = <GIC_SPI 673 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts = <GIC_SPI 674 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 678 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 679 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 680 IRQ_TYPE_LEVEL_HIGH>,

-- 
2.45.2


