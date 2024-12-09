Return-Path: <linux-kernel+bounces-437297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 937FF9E916B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF34281A2C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BF821CA0C;
	Mon,  9 Dec 2024 11:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MJxEyyLi"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB5B21B1BA
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742167; cv=none; b=QeGxW43KHLo1zVMjDLG3+NWq3kAr8zlAePLq0LxAKO/gMFCh0wzCNJucx1lvB//xEago27pvgcfmuVnXdy4vmsttGUAJ/9uTcFN4YQUzy7POVUnlTHsv9tjpOgvubjwhUWLDEUDhAkRbQB7GVcYVTQws8jH7sJLOKvLjzGZIubI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742167; c=relaxed/simple;
	bh=Grc563omxN4A8+JWY3Ft7oNDXIMFMPfoHnQ4ss/HgL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SMPvMgQgwCaj9QXYcH/cbg4fkdTA14RoG7gTkf+72vyL30ajKiJ4pJnI8skAITQjXaobFxPggFWp/BNpBqYLoxWtVQr2RHj/6t9/yH4IsyC5ufZuHXMDPbRvV5LWct8sGDse7X/KmWufvfBKtSmsGAVxtqtnPSuFpIfC0e61c0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MJxEyyLi; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3da226a2aso144472a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 03:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733742163; x=1734346963; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=97qXLU13jn5QwDEN+dIGTdS1uzbvFCZJW4MAhmLfpaE=;
        b=MJxEyyLi/Dl/6cras1V+iqW8emXcGcTubnpOujP2Ko4TbUStKI4heE1EPXQL89tnmb
         hmSz+tB1fRJ4RQ2YrSiBmbyilFuoHIkkTBvsALlzXZBFaapn7VHbT25fhWsRVhHJ3RUD
         qH+kJhPrAUgUmXnHacKSz6nXChI7UmIKNtFawIGvNU2bWDTpPgQP3vDmm0q0hFmPQCjc
         FoSmnv+awAh0j/gXUS2Ezlwr8RhS4PLkb7cn2d5jdjk17rhdYDjRD7OIIjU1LpfCxFzv
         GLzvWdfEQWOWrlzhA/U7iWCZGsW6ChiaRqSvxbkfKuRilfPBT0MkN0ZU7bYjYF55T23o
         GpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733742163; x=1734346963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97qXLU13jn5QwDEN+dIGTdS1uzbvFCZJW4MAhmLfpaE=;
        b=Dhpw7tEVqDR2Un5ioNUMUM9Wn+lRGMgp+HpJhVP5Rr85+H7U04+OEVpIq7EKpUosKM
         47ODSlLqDzY4/TWEmd+X4OGap/5R/yzUNkpCPGszrKiCeKwaICAZ7WA/mlPT/wR+MgiZ
         vqzBxuctGxjoNzEqv7MNqevVhG+ZW03ijzfQc3hJCJjl93Q3FMp26V6G71K0xM0mtXs4
         xyO1Yi7P8yaG3FMxqDOi69TDhE1QTPaFIqAsAa205uAEW9JkvUnvRSWQiCNAxWjtkDJw
         KHdrppjDa3MxE5Aaag3cRdPkk/tcLk9EGjrEbzszpZziGESv1e/fk77GqFuoOhO1ZyTi
         HMaA==
X-Forwarded-Encrypted: i=1; AJvYcCVwvhWXVlBdX8sMmvRFMO9BvPAShUKWPnjrI5cMEQNQwiIRMqm0ISD7myQbKniHg+7PgwUCXX+tiI0DCrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPsagQ/NGXi3aElUDDP4awK1xjF66dPBIoQN1uIS5GvXytqo4g
	n6O98y4rxz0VXzd0q+Tw8QDM1svvw3jrqnFkV9kS9JFWBABGd/wXpP9uTbBiOUY=
X-Gm-Gg: ASbGncsKxC6WChB25JWqVYQGrYi7jEZytnRKwdZI16bldBRJKXkjd74ygByjYeU4eLx
	N1RAns+/EZTZmPkdDdOsBF0RURiNzWOFqCRJ4JXNBeOfxs2bgjvubDWfleXIu3NpfCKM/HM5Xrl
	Rx8r5ptukRCV8EiJRrazHPGkoeAx1c94PAvqiXWkakbSEPa1bh7FWYwD/d3BIlw1dXPbZzf/l03
	YfZZm8OtCHlnInxyqVPTpXgZgIDUnot5ZwzjbZwl3pJQnTpyosT7wCOtTYrjx/iMQ==
X-Google-Smtp-Source: AGHT+IGprZDNs6jnXCt81jwR6++BFFvZCNI/GnnhJ3LxeLCsf+zIa0QuJpfJ3g1U5aHDkbnQqxLJ/A==
X-Received: by 2002:a05:6402:51cb:b0:5d3:ba42:e9e1 with SMTP id 4fb4d7f45d1cf-5d3be74c1c9mr4549638a12.6.1733742163030;
        Mon, 09 Dec 2024 03:02:43 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3dd4f641bsm3348818a12.51.2024.12.09.03.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:02:42 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 09 Dec 2024 12:02:13 +0100
Subject: [PATCH v2 08/19] arm64: dts: qcom: sm8550: Fix CDSP memory length
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-dts-qcom-cdsp-mpss-base-address-v2-8-d85a3bd5cced@linaro.org>
References: <20241209-dts-qcom-cdsp-mpss-base-address-v2-0-d85a3bd5cced@linaro.org>
In-Reply-To: <20241209-dts-qcom-cdsp-mpss-base-address-v2-0-d85a3bd5cced@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1359;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Grc563omxN4A8+JWY3Ft7oNDXIMFMPfoHnQ4ss/HgL8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnVs43NCAEUcaxQ1YCd1ShrnACwFUmoJUa3LsG0
 Sy/6/OblsWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1bONwAKCRDBN2bmhouD
 1/DdD/9VkHwO33jdyv/F5flNyTpV1gN9I/1JtBRk4T2k7D0TSrIs2UPM+qtD+15C7RY5YM8vKhV
 4sr07NEwjCcq5nrjjtXDrrfhsubqtsyRrFEEBIgt9VUKKSmPK2RAlsWpC4czc1lYeNk44zt3gDo
 Tak9QPPZE0Et9XNrp43OVpy3OgFUyzHS437ppVbaEfjQ7HdfUiUHKV+rzagOW4lJpJXhUKaSXCu
 Y5Bp/heWBsWiR2bWChjuKOOIY+l8ySVnrNnXqDYzT9De6xyoyeZtnQy/Gnl+kX1OiAvC733+91U
 rgzseq2ugvhFd0dM7hHFRy+E3aouyaUaiowCWL5QTP6dIIbzqlnrq/6QcYqfEzOOKsieCAc3A7i
 Is5WqNmwj2DsbmR+CR/0zBAEnljN55iJf+orWhwYaUjl3ccBqZiRYIbDNElnX2eaiIOQ5HEuFU+
 2xMtfkBBfvGkYXko6c8jk57kODKGUhz3s5nZTaZhS4YrtVRKN0RpJAW0n8PxBN9zxj0KbSf1uZG
 7/UnyIqyFWcsH8WIj99Oj0jiw+HNI6BCmW3UXy6l+jVlAuS3UtjA0DsagHnUwznhS/cGY7EOY9J
 KjDIttSSrbKnekU3yssxSWo3Ro5o3iKqZ33aiYev1HVtuGJKbYWPrEUakawwe62A7VPUyPFQe4O
 Wmmh6xOSZjabAyg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The address space in CDSP PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x1400000 was
copied from older DTS, but it does not look accurate at all.

This should have no functional impact on Linux users, because PAS loader
does not use this address space at all.

Fixes: d0c061e366ed ("arm64: dts: qcom: sm8550: add adsp, cdsp & mdss nodes")
Cc: stable@vger.kernel.org
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index f454015c5b90c7d792c01bf85256812857d79c64..541b88eb5f5300ef9e20220305ff638db9b2e46b 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -4716,7 +4716,7 @@ nsp_noc: interconnect@320c0000 {
 
 		remoteproc_cdsp: remoteproc@32300000 {
 			compatible = "qcom,sm8550-cdsp-pas";
-			reg = <0x0 0x32300000 0x0 0x1400000>;
+			reg = <0x0 0x32300000 0x0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,

-- 
2.43.0


