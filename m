Return-Path: <linux-kernel+bounces-435206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D6D9E7462
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1A018881B1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40426211714;
	Fri,  6 Dec 2024 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ri9X6VHM"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D1F2116E3
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499199; cv=none; b=j8lI2RpbyJQlMU9D5ZbF15zgE5pZMq+lJMO8ZkLAYivWAusVtzZDvGCv+j0AhEXIc716SZA3i3UfkwfQzEhaoYMInaZaUtANpglQpC+HoPJ1vrZD2YPcQy/1WNZO9ssmLr2Qsy7Hzyj+ziYFk65Sh2R5+Wwn3x2kPzkIXPjrgvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499199; c=relaxed/simple;
	bh=59+3c8ADDgXHQpxcM1MurA1UnTBLR3Nt2NQKVHksIFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pE4XDKK0xNEbQVzXsiDUfyhjjjeRC8qUkUaSf4F19tgmdj3v+JwGKTXUbvK9c5dcOrwD8fOYxwGMmG1Moo5fqrPoXdzsvdaU6xSZLbJnKYNjD5DpYpANRG6t6vFWtKc7C5iEdxQJl9ZUMFfLrIXDekd6BLkI3sSqIgKOTd6e5tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ri9X6VHM; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3862de51d38so72194f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 07:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733499196; x=1734103996; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UhfBszLGLmYRbjyJH0+N5UbBCo7HBu2QFcO5VUZQNiA=;
        b=Ri9X6VHM8AjbW4Yufq0VJrpj6GNB+qWojuwYs5kGChgtePAXnwEkEsRUY5Mn/SAh7Q
         bZ/ZJvU4mIGTLRRgaHrb1h1pJ2qvHlpxExG6kigpSK5+8CEfsPIL6W0JpDydaWOl44ZM
         EnpnCWkjDiQbz8+Z6BjaCbKDhEkrJkbuoFQrA7KrqBecZxRUbPa9nzusLhi9pNjqE36r
         VzoolEQamNNfpUPpWuLRX36ESwwiujqaHYcf0pCmlgCH8VRXSE+DBusM/j5QS3z6Gs+g
         1cXKGwJxxOwc7l7OXr25ISYb+GE+aTXJJJgI3EfTNRfN1i404Tu2CBN4pH0h8Rb+8g09
         QdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733499196; x=1734103996;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhfBszLGLmYRbjyJH0+N5UbBCo7HBu2QFcO5VUZQNiA=;
        b=LI0pWNvjB6sv1TZEMmJgnXjFLIouuoDAhPGNNwt71/RTQ+2imD/FeO3q1l2KC/O2QU
         tfRTHOsX/di1a3f0NC7DVQU4Z4U0/GAxi6JhSHCnhdZaBz0YechFrxaJTjt7RTL6UWCA
         NCuBW3x8G1sJt0SsiWWXkr8nfweGj9J1P2rZ+dkbVHhOqldZxYTpgaLnmcmHcBDcyeds
         W741DQjel2oEqLB5nrewgH77sDcQd+PHpw3AO1KYSPtravIGyzjHPVUrwT7/7E5vttal
         7RcxN2xLBuVCA6zVLI+KB9kY0boI3AklXhtz5wZF6RqemdRTZdnhBdchO0KBr1ETl/it
         Sh5g==
X-Forwarded-Encrypted: i=1; AJvYcCV7WB91ISdVMSj9zXhvbXL01VXNZp8Vn7zMz7vJV6I6AgDEDqEN06+kLhlKzXg4f59l/gVSDiw8IlWH0YU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEPwQ7OaGngzE44mn60b9SRA6kp2GBBgon9YuhmCwql5Nkz1Bb
	8cqFxkufppFglE5DaBmLdjqLT0zv9kjUR/1I5aw+sF3s1iVmDEG2LX19iPtow88=
X-Gm-Gg: ASbGncvJ2+bs8Iu20O//Mf7NN6zxJAFlXuCdqy0Om8OgRweZMLxGu2rqag40L7if3R9
	ppOYYcnZKlxUFeWuW+TZNauJFd82iTJFYxtC1tKj81hx6qtAUu+kfaWGycFbsevK7tLRx7fZNe2
	PyiHA+I2h4YloRFz6ceQzMXJznV6rlR6a4Qmb/YLPs1+2JoltbWrtJ8usvwMEJQGx9802uBNKMS
	uBMRC7KhJuCvglpmHpi9AQ7MVByAXBgu5NRTWpARd2IE4+tCFgOdOgfb2gEh+2YOg==
X-Google-Smtp-Source: AGHT+IEeeyirbH9lIydzw235ukCxeNUao8uYInLkz6PvOa+u5Yhzkrj8I05V2VGWeIPPxYeyRwCdtw==
X-Received: by 2002:a5d:5f4c:0:b0:385:f79d:21a2 with SMTP id ffacd0b85a97d-3862b3cdb54mr631964f8f.11.1733499196067;
        Fri, 06 Dec 2024 07:33:16 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da113580sm61158035e9.29.2024.12.06.07.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 07:33:15 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 06 Dec 2024 16:32:39 +0100
Subject: [PATCH PATCH RFT 15/19] arm64: dts: qcom: sm6350: Fix ADSP memory
 length
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-dts-qcom-cdsp-mpss-base-address-v1-15-2f349e4d5a63@linaro.org>
References: <20241206-dts-qcom-cdsp-mpss-base-address-v1-0-2f349e4d5a63@linaro.org>
In-Reply-To: <20241206-dts-qcom-cdsp-mpss-base-address-v1-0-2f349e4d5a63@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1166;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=59+3c8ADDgXHQpxcM1MurA1UnTBLR3Nt2NQKVHksIFo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnUxkaVPAaakS0pt9YRlGipjfVTOyTzQU1PehsA
 vv7rXCpCIyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1MZGgAKCRDBN2bmhouD
 13HlD/9M4rz1N4OaB+6w4mLYqYZvJw5YAkbpIXL+vWG0e9oj4Y+r+QqdQYcKaoZxcn7t7aVHBP/
 sJkux/3C1z2UZh1HE+FsE1fkbw0D6kCijMhhXtZvb3kkoiSII31YtO8EQPTzPjRglcrKpKgNmSX
 cUh9okf3SdrjcSyC9Q2WeCs+n5EEYiYvguYntPcSy0BH7e8Zvbd6p5oDhPu8qaE16ArBwtuAVI0
 E2zD72jUKXfh7tXgNJYuVpuSs5oMsFjTWV14BWrM2gUXHMxdf75kLVuVjYa7UFXL2w9jguvXhyo
 YQUNa0OAck9aflROFxjD/X/z9Lm1YYt5ZNvsPIzJmREgjLvNP6A/6pSnqbZi4YNraU90aDqcg6i
 z3NL0c0jiidneruiLwsYMZl96nniSyiis4WYpqf4E5VsHnnJtZaC2O3SF/IQDzItNHIueidCTA2
 /ANLYIMM6xdTjMypsjlJFNH7KcKHpoWF/T4BJwaMl7Vy/DFSFihCYTiY0XXm4PgA7JfLjWBd0xE
 wEO0URCRakOUjyh2AqNyuyGmGogTzGO3DtBiDPoHBLGAhO388tSM9HucorvqV1A8A6BHB88QEMH
 wFTJqMhV2VEchpIT3up2947hjNhWlElMerbJRNCSCh/1CU8SWQwozoEjCEMGuC2inaVSGtWM+ZN
 gkAlDucuyw/K30g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The address space in ADSP (Peripheral Authentication Service) remoteproc
node should point to the QDSP PUB address space (QDSP6...SS_PUB) which
has a length of 0x10000.

This should have no functional impact on Linux users, because PAS loader
does not use this address space at all.

Fixes: efc33c969f23 ("arm64: dts: qcom: sm6350: Add ADSP nodes")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 8d697280249fefcc62ab0848e949b5509deb32a6..3df506c2745ea27f956ef7d7a4b5fbaf6285c428 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1283,7 +1283,7 @@ tcsr_mutex: hwlock@1f40000 {
 
 		adsp: remoteproc@3000000 {
 			compatible = "qcom,sm6350-adsp-pas";
-			reg = <0 0x03000000 0 0x100>;
+			reg = <0x0 0x03000000 0x0 0x10000>;
 
 			interrupts-extended = <&pdc 6 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,

-- 
2.43.0


