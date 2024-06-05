Return-Path: <linux-kernel+bounces-202877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D51BE8FD242
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B3E282B8E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE5314D2BA;
	Wed,  5 Jun 2024 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R4+8aFlk"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A51014D70C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717603239; cv=none; b=Ut3LmvrXcG0O2RhbDOpVcCiL1i9VFwuU+jd0UH8lYnouT3iRYuX9wa7nu+ymliVswe2t2/T0FKOTY7/diBehbbK+oh6cuOI7xFMOUXOlMTp5qe/h9N4RKpvAydxCIsnpdQceL+Oqn9Mg+TNP4CLFv+c8T8v5mB7uo4NXm7Zr4wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717603239; c=relaxed/simple;
	bh=12bFuyfQmZkG2+ABZgn1M3sWSqD4zUCpfiSL6irZiP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqoKkJjI/xBg07p/qlTw8nxyMIlCrHuHZTFresdnycsbfnxl8D9qVJqN8TySlrAdExSIE4VCquZgrWKhS+C8Jm3N5dKCohXTiddXkFN14vw/2gNr0WLWtBMBMsfBSgR7gGDFrcn2LvXl8PG5lAI80TeAe8mgGpRjXIxbkE7MNXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R4+8aFlk; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eacd7e7ad7so8603991fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 09:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717603236; x=1718208036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YltyCfpqGq9K4vgpOoXiIRu9gocX/A/8INFDzAUTBvE=;
        b=R4+8aFlkmcotYa6C50IGVR1B/Qc/nedDya31sneKaKzlmPR63CCez9QkXlKThrP4qG
         S5bgBUBR3VthQfEDvMLeFxWQOuAEx0EdJ9I+5dSEkzxlQJAV2GO7unpAKA3b1vjf5MZW
         GmPqMxjmCZm1SRnl00vujiRNnHgSUgxS3fsuOnN2bRCxrc8rFTmPXg98DnW/j857+peG
         ZEtcpWTL3Ei7L7WBt6uWQEnahe5Kopp5VHRlyvlt1hRjGBWBrb1EOTXq8aYRVVcsjBOX
         rf6f9fwwXt43UmHUYx7rWBWx3XewYx6p85V9aijXc/DXyKHP3/RKnZxKaFVfPrLSdcS3
         i/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717603236; x=1718208036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YltyCfpqGq9K4vgpOoXiIRu9gocX/A/8INFDzAUTBvE=;
        b=XckHZa4oGAAM7Ueghw/ajhuHlvui234Wfk5MF5boJpEuZWm6Tuw/eixEEkue7sWmk3
         5TD+PUffvfDXeF8OakjBSxd5cATWvDzoLPCToP8sDFLWmvGyWKpc0xNSkT6ltqcJ10ND
         i2xA8LPlysuDjiJzAhq5X1AtrEWW0/+Kcg09hOlx8DfS9A2VkEGv7DtI6GlR3R8gDoks
         yYg6LcysQCz0nVEV34IgkOwnZXToFz+NwdWBXVIgd6tG+qcpVYoiseJ42acLS8pFzzGg
         EGlgP0pUOdPXcbVWX5OyYqO8uUtHLs0gskNYXH+gyDPXcJdXHjO3fkj/8xMBQIkijwhO
         xxjg==
X-Forwarded-Encrypted: i=1; AJvYcCWyqL1Y9BQMrL4JgrHc3od1PU7e7TKGhq3e2m73YT/Ae3qexQ//o6XsRwMBFMcH8+2XB0+UVwdhq1b87w5n57GaJQ5QZ2qGVAhAsBXB
X-Gm-Message-State: AOJu0YyXzyBAiw7nldvM0RG/JAW0uMDWtDsMLKbbJEIleJt+xIIhyU/k
	qhu8bKrqfu5ZSMwsVG1f4u+EbwfIOOtt6gKhFUOwEtdKlW9ttaAhhR5ARGs6rMwu1YrFkTGtBNY
	yFeg=
X-Google-Smtp-Source: AGHT+IG5Lq9r/oAx2U0p6tuN3FiovhSi08tfRV/kQ2k0CM090ddtl0UB3GCSew47eTZVVo9U0UHFQg==
X-Received: by 2002:a2e:9ac6:0:b0:2de:74b1:6007 with SMTP id 38308e7fff4ca-2eac7a72de1mr19292741fa.36.1717603236164;
        Wed, 05 Jun 2024 09:00:36 -0700 (PDT)
Received: from krzk-bin.. ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158149008sm26288975e9.29.2024.06.05.09.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 09:00:35 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RFT 2/4] arm64: dts: qcom: sm6375-pdx225: correct touchscreen interrupt flags
Date: Wed,  5 Jun 2024 18:00:30 +0200
Message-ID: <20240605160032.150587-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605160032.150587-1-krzysztof.kozlowski@linaro.org>
References: <20240605160032.150587-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Interrupt flags 0x2008 looks like some downstream copy-paste, because
generic GPIOLIB code, used by Qualcomm pin controller drivers, ignores
flags outside of IRQ_TYPE_SENSE_MASK.  Probably the intention was to
pass just 0x8, so IRQ_TYPE_LEVEL_LOW.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
index cca2c2eb88ad..e04a3b8f81c5 100644
--- a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
+++ b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
@@ -142,7 +142,7 @@ touchscreen@48 {
 		compatible = "samsung,s6sy761";
 		reg = <0x48>;
 		interrupt-parent = <&tlmm>;
-		interrupts = <22 0x2008>;
+		interrupts = <22 IRQ_TYPE_LEVEL_LOW>;
 
 		vdd-supply = <&pm6125_l13>;
 		avdd-supply = <&touch_avdd>;
-- 
2.43.0


