Return-Path: <linux-kernel+bounces-511577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0D3A32CE9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D61616945C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F072F262170;
	Wed, 12 Feb 2025 17:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AK/CMOyD"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38749256C99
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379867; cv=none; b=jsPOedaQebrZjkK0qheNCjT5hFH39J+MdrvegM1H75YfIcj2eExSj0GwRl9KLsr6Zp3FtHkkmcVstB+XDn6g3UfVOE07cG5WaX1AbCbKgbDurE89RTP4koKJ+sZYhQ6FVKtt9pSqmeSN5gPgYQ6VQ6AAukriahWf3QuwP8goVfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379867; c=relaxed/simple;
	bh=75avUCDFzU7VeEjRm5mXzklFEoM13F5FbLiujKtYn8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WPwZJpe/ymSj4/p2+dwEvk8w7yFMOPYossZN9+IbxUJVLoH7Ze2EdIj5b7uY07ehPd1zYSne3Uza7VWubHvJMPty+i1z2BK8nhxMG1mXdYnsU7wE/8HN426ZjHPIqPkvJnPZSBUIOG9sii04pw6CT1QXwLW/XfWa8HqI8RscWaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AK/CMOyD; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5de5a8a96abso7708301a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739379863; x=1739984663; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EdKs3PqjzG7VzXlZTliJiBHpYVpLmHoLigdOAH1jHUA=;
        b=AK/CMOyDspRGKpErBhsx0x9jrTAGA3yTTLt7nv3f+Fx2CyIPJ8DHxEoqmLc5K1hGKZ
         7xM5cV+T1dpMq+lEh3xbbIJDdeBsBw98IBI7YElHf08W/M/gTDDBcZwPRZfCGPMqgwKS
         5RWMre8Xn6+4kv6HflxGMaHOzPQAZdr+ZFOjVIarO1+dsjl2eT/KrMBwUfvNbXM8bhYp
         f5532u0xDJZrRL2tFFzo0qaTgT4tn381+/zK3aBfc1QTsRJzfxK6uhQLiTFZ9TRHV4Ge
         UTRpH41YuCwEiFoaHMdB3Hao8rfmhuzp7697rEOeP8LuVkiX0Q/6gC7DItrxry0BAnV1
         QLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739379863; x=1739984663;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdKs3PqjzG7VzXlZTliJiBHpYVpLmHoLigdOAH1jHUA=;
        b=kfvlwnukoXbEler+EOUzGapsk9UmIn5cp4Q148vzkopo/f7SBoRGraEFwu/6mfYU3m
         gombXglI+Vq0XTKC0Q9+G3PWcQ80eRv8V9ARs7gJVKcDit4pp7Cjj02LTww+GC7RdChp
         fGv2/hypkcy/CzVoJtGU9f7rtGdaFcNa/opASDVMbyYu7j4pVVnFmIa0QsHH/TXsdwg+
         fyy9GzqbwUw7GHnsz76yE7T67qJyOw6dkI8dTjjKMjmYIqEEiZDya5O25jcKYtWfTdg6
         CcbIGvLrqoP04QOgxc/ylJMKb0X/gr5HiltGW7XhKhDG6Tnfseu2VDTMjsg3qLtH4Zf5
         tYvw==
X-Forwarded-Encrypted: i=1; AJvYcCUcoH5TrsxoFlyL4vOKJpIbckUFDQ7TJj8KpxxQKm/kyB2eARKKGHTVRl7BxBfpnKW/+uPMmJow/N/ggpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNP3advraxTQaoQRiljZwAgo+vROd2VEoYlAwI/vMtUEiMyR58
	3FmG64trt82rTAMDaBrBp1yKGKwnXsxiZkAfgmWh9kOY6JSzR+oBldBYLw2MMpU=
X-Gm-Gg: ASbGncv9Bs5iRd2DA+0DqUh6xn4Z2/IAHznuxNXvDz7we/TldKclO04AKD8cRYIwJi0
	PyvUkEewQ5/Fa2Xjr9Sq+lpevhXNqKj1E1wjlIm1q1dWZs9pq8XSoGATTTKPD93sd1uqpMLzUVb
	xYZ0T8dMjY+ntCnINus3S72V5caCOqInehBoDwt/ZiE8Qau9Y2l8qJrGsuBL1ygPNo3PB2Poe7V
	N9/NZbVe1ai6NRVgeOJLVukW+un+KxtJ3zPhMWq1AU3YczdRW/Oi2z9dvc/qcMvYvyqkmh95wYe
	Z89UkWd5UsNthHxqPOKblJyAcypD
X-Google-Smtp-Source: AGHT+IEbKqXhYNAGULvZAeRYgXuqy5Tc0W6a9RU0CYtO1rrnjvygarfucO6BvycCtWQunp05lZe0WQ==
X-Received: by 2002:a05:6402:518c:b0:5dc:d8d2:e38f with SMTP id 4fb4d7f45d1cf-5deadde71e1mr9275663a12.31.1739379863190;
        Wed, 12 Feb 2025 09:04:23 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:52e8:f77:3aca:520e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5deb9f6e46bsm819230a12.71.2025.02.12.09.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:04:22 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 12 Feb 2025 18:03:52 +0100
Subject: [PATCH 6/8] arm64: dts: qcom: ipq9574: Add missing properties for
 cryptobam
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-bam-dma-fixes-v1-6-f560889e65d8@linaro.org>
References: <20250212-bam-dma-fixes-v1-0-f560889e65d8@linaro.org>
In-Reply-To: <20250212-bam-dma-fixes-v1-0-f560889e65d8@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Yuvaraj Ranganathan <quic_yrangana@quicinc.com>, 
 Anusha Rao <quic_anusha@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2

num-channels and qcom,num-ees are required for BAM nodes without clock,
because the driver cannot ensure the hardware is powered on when trying to
obtain the information from the hardware registers. Specifying the node
without these properties is unsafe and has caused early boot crashes for
other SoCs before [1, 2].

Add the missing information from the hardware registers to ensure the
driver can probe successfully without causing crashes.

[1]: https://lore.kernel.org/r/CY01EKQVWE36.B9X5TDXAREPF@fairphone.com/
[2]: https://lore.kernel.org/r/20230626145959.646747-1-krzysztof.kozlowski@linaro.org/

Cc: stable@vger.kernel.org
Tested-by: Md Sadre Alam <quic_mdalam@quicinc.com>
Fixes: ffadc79ed99f ("arm64: dts: qcom: ipq9574: Enable crypto nodes")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 9422900289725774da8cfea9848529891038e57a..3c02351fbb156a314b7911def3caeff0c14b92e4 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -378,6 +378,8 @@ cryptobam: dma-controller@704000 {
 			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
 			qcom,ee = <1>;
+			qcom,num-ees = <4>;
+			num-channels = <16>;
 			qcom,controlled-remotely;
 		};
 

-- 
2.47.2


