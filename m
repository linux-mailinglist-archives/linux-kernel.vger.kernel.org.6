Return-Path: <linux-kernel+bounces-526184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585C9A3FB54
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9BEC3B819E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7941EE028;
	Fri, 21 Feb 2025 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BmPgyQ3u"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221201E7C2F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155042; cv=none; b=Nx45xHqZIGIWLGuahgwwYagDS721hw5ZftGhi8rWnOpoSxAHPLz1ZtY6x4DFZpubKnY+pDLjwMloyPkcImv5qTe9+6I58ZacBHDT1uHS5WYufapA3DO1VxAKfmBo0BwIxBTYp286ZEAFJHyBmLTAvFCBYVPxMxS0Rhyxn9iFaG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155042; c=relaxed/simple;
	bh=lR6PjoPFKVsHG2J5Mucpa/CnvA+OdHPQdfRh6cSHZ2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MFh3E6UYguO7EeqaI6Dr+W8BvtoRTZJIuW2W1AcGwdhvjT86o48lUL3FUAzISleBg8lE8mMQPOsLxTjCHZ8EVBjIke30rFi4mKR6MEf3h/6OeLK3BxrdUlXvsrIvZUjovvYL8ZbUyAK/QtT4FumR26xXLYenn5n/DXqYwl6LrhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BmPgyQ3u; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dc191ca8baso466731a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740155037; x=1740759837; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XK+UGaMVwf9jHj43qw1MVxGsWYAAC0YY/TWDG0GH+T0=;
        b=BmPgyQ3u3dOvGygxtmHi+uh7Qko1g/MNJ6IbpfbjveYleSUV7ssq7ruWY7xnaeAp+a
         XgpVL5885S3MWik2c9kxAm9B1irAxxsBNVyS+99CjepZZ1gKqlM4tISYfmyykVEVapzw
         iN+QrTlPsRiMxk+VKNpzckaJkm5kPrq0pdKTtIcbHHqkGDsFGArs5mIH5kM2BKQ2+RT2
         9+pDXHUuC6b1lC/7ZI1s1fvmJqhtaR0tKbqpJzzRHn2C2cdeOR3Rbq78fEW4cDeGJmDV
         g06/ZPhy1MNG359gA1SMswUJIVWvC/H45wuE4uxue6v3lVibKFFGR5Jn1kRLhtBIZP1K
         cNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740155037; x=1740759837;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XK+UGaMVwf9jHj43qw1MVxGsWYAAC0YY/TWDG0GH+T0=;
        b=Tvkbs402dCjrrFRVRbawhhQXYRUYSCgiQF2wb+LaXVd/kt5w068s8QuFUGDo0SvClq
         HsIuYW3S6SDrSRiUuFfTqg/x8oIpr8VO1Hu6oWFgWSv8imE2vVdoJ23JCtTfFwRrdx9B
         lnRtP9JLKPGS0T0fn6v9RSPueMbLDUmOeS+baLxMSkR0Ro+9Q8RXF6K1b/qsifBgCWOq
         nPn9cS8POaEmuRR5KYhK3BPjPhr0xI4wY12yBq54EzYQutqlbqxtLZ/dw6UFBaucl+cL
         6nsFEzdzTwB2vEk/i9xd6xbl4LULJa2RIN1DEe2wNOkwXFu3mVwq+mkfM+fjn8NBRvOs
         WOOg==
X-Forwarded-Encrypted: i=1; AJvYcCXDToSxNozSC2wXtS3R2UOw9omGAbb/a8K4qZ0mocAkknbWnczDuLmFrvFe+ApdYoz49S6G0KYrbMGzd7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLgI9OqfMAVX++MUHbjxSA1e/XmjKsZrGNrohBcx6HafyLyQPM
	TwxckMBnXGNJxZ12WpGa8dxGQVPDn/x+y5b7VVJRy2I4AQTqmcZyI3kxzosI8sk=
X-Gm-Gg: ASbGncsiLn3TVXVMhVFNqkHRZ+mgEC5f1Lpb5DzpAt2WDPcaF0v05YL+/gDX1ZR/P5u
	2KVXefnlkNBX0tE81rlOTY0DzkPiXGbPzzqAoV6Ft9jyvMw+nQPmRdSEDfMRRIwXE32TYzkjTe9
	7try9RyRLM2H7JBOlwfGWOjOyPqSS0ALYJXuFxM+B2ms9CSPloXQBf0Zjz9LG2RTcjtEbZ70Td6
	7SOMiue6vLk9XWvc92Mz6qruoWdsdpyMYQNAeHsBCwwghV4xuIU4fXbM9jNlNPOIjtI0pXIIg4H
	6Ew5XmGl0QaW3errEymk/LE8hMBowtCoUEK7GxJ+U8Sns3tjy+rworJsCTH5hxSqh3dmV22Jv6i
	K
X-Google-Smtp-Source: AGHT+IGQ+rAbSozgRpZ+wRUAQKnKAFtQDyoOgn4zw1NGcBOvfIlN7bnUvJppMq61ZA5CTfKx07XLtg==
X-Received: by 2002:a17:906:4fd5:b0:ab7:82a7:bb1f with SMTP id a640c23a62f3a-abc09bed0bbmr162400866b.10.1740155037326;
        Fri, 21 Feb 2025 08:23:57 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9723a559sm1050545366b.96.2025.02.21.08.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 08:23:56 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 21 Feb 2025 17:23:50 +0100
Subject: [PATCH v3 2/3] arm64: dts: qcom: sm8750-mtp: Enable CDSP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-b4-sm8750-cdsp-v3-2-fe2891beeef7@linaro.org>
References: <20250221-b4-sm8750-cdsp-v3-0-fe2891beeef7@linaro.org>
In-Reply-To: <20250221-b4-sm8750-cdsp-v3-0-fe2891beeef7@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=848;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=lR6PjoPFKVsHG2J5Mucpa/CnvA+OdHPQdfRh6cSHZ2Y=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnuKiX6zmspgLfQEa9yQXLuTIJ/7IFH1XCEFnne
 /GcOhbKtxmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7iolwAKCRDBN2bmhouD
 16r0D/47ZGJeEzfqW5UMPrJaqTikLortSUuoqsmjK83OlbwW/37QqEcxcykllzFO+Ul/SbmH2gu
 Z0n2oALEOH17tCF+g+rgnwBW51ayVKpTOZ4bMf/asplS2vGXc1fTFb4nVB1Ek3dQ+WiQDeD9WIe
 /FAomUWnPhdo5g0ov1E4wTHXBvLUmU5wqbayQegK1qjtn65q80skpYUd84etVW2QhC9KXfPy8Et
 54sJpdCFW+QzC9OJf1romQTKaWHOUf5LQNIDuOFiMyroZSU3oDeqcZFrFuv7VrinUNZNRv86Ymu
 nL4d4BxHhyux+yWcCDNkFoR3BLaWsS0zVTK9I31e0rmsPIzM4f1YU2ClI18KB0SP2QJwfslsfZR
 9M7pkNnbC2atkyYxg7h6Eo+BnvuZ6C4/mh4A4z+zKeOX/oSbfpXRFltWxUeF81jac376xu0ETnX
 tH/KuqDY1rAnNAdqyC+ge3BTMDVU7jF+v3kp8sYMBuMAChjzgU4bBARsn9N+EW7HY3oZDoiPZ+X
 wbkV9IPahZyjO89KYGW8AHfQDdVj5zHU0mzO/kMZbC36WFkqUYyz97QK/CIA5RsgwSEKfVh8RJk
 /woTBfr+MUZOw++aM7tAGp0OOANarhQfG4drdzJdqfqiYHC9zVvIGOHPHhJcGLUPkCdSeounYL8
 rTXhUFDi9YMd8UA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Enable the CDSP on MPT8750 board.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
index 8eeed7f2f7766326cfc7830002768087e9783b9b..5d0decd2aa2d0e0849414534cdd504714402458e 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
@@ -791,6 +791,13 @@ &remoteproc_adsp {
 	status = "okay";
 };
 
+&remoteproc_cdsp {
+	firmware-name = "qcom/sm8750/cdsp.mbn",
+			"qcom/sm8750/cdsp_dtb.mbn";
+
+	status = "okay";
+};
+
 &tlmm {
 	/* reserved for secure world */
 	gpio-reserved-ranges = <36 4>, <74 1>;

-- 
2.43.0


