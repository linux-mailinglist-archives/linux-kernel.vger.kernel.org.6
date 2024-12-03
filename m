Return-Path: <linux-kernel+bounces-429454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EF99E1E4C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 831A3B342E1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624C91E7677;
	Tue,  3 Dec 2024 12:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ADFBl/vv"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C5C1E767F
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229630; cv=none; b=eP7+rP3E5jaSU1WYoD2TNaGZSSQ2edJ+sTpBC+qPU2/PuXzyTMb3fLqJV53Kw5HMul5ZfI5MQS9b5SsAji6fz/dU6VTCtQ+cV+9hsiSI+bJqbD1Gv5aty1KxUDDnQmDCBOUlp+vR7VWsCtueueU85PzJz4IAZZy3PGX92Two6rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229630; c=relaxed/simple;
	bh=ErHr+ubnC2nccg316Z42nK3s1bkSHAlf8m9iyKpuF2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uAhLTs6IMXO6un1/vicYxJo8DDHkrDKqp4RK6SD0nZ0ELoASRtzilDDFMta8SMoJ6+bVN8NiTWBuj5QO9EpQ8rJE48MNjpG7qoroCKpx5ojfhsPDfbNF3dUovO2jJjPlVqsT4hGFXLqPZPqd/N0sVrxClm3/KRa7jBDBl1DhwdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ADFBl/vv; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa51bf95ce1so266697166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 04:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733229627; x=1733834427; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSM9DgJ8s8ciANY65GvKwivzFuJwV1VAivJ5cEw7IQQ=;
        b=ADFBl/vv/P9Oyj3DQxcRpL61ZPtzDcfin/WZvXA2NG6ptuiYCkOmuHLe8T0c9huOov
         jCXwhMpRkTaA/Isuh4gOr38yyXMb7Kpvc/LMRCqx8AlrcBF1eDWZ5G+0yhq0WHzBwSlM
         sNPA+o0q3MucMgplUWmBvlvwJQbi7d1IQrvAYoOQWB7K0+bnKNGxGoZqb5f+a6Dos6TK
         w9qW/0aqr1azCYaX3xjZdmEjr7Y8xf50WeKNujYXcFZ/7o//Y2m3racKlYa788hNl5SD
         CPSfew7wCFgeKifYsH33HSYRUs2Hvbmitx0sk37y7FseWYRMQnGv5zYivzaW4QsuY3OD
         s1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733229627; x=1733834427;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSM9DgJ8s8ciANY65GvKwivzFuJwV1VAivJ5cEw7IQQ=;
        b=EyRV8oESma4037jv+nOsbX7lVCdn22W/VOYzCZD2NHvH5/H+u3A5QJMMpXAbw72LUz
         7msf1qkJ6S8jAbDnyA1IMU1W10dRJ6l5wKBF/cZCQ30uXGSeU1J7akA2hKL143usOeYk
         oqj2v3fbyYjWr35hDbsvv/O2WGNu7dkMIdkTa5LTdg7ED276Slp/Odfq3Lahl3N+BdnC
         dbB7gSan6sVcRgjaN9foXWiCd59P+kX5pCUASO9gWRXcDLvRfNz9E8DfRrgUNinUFM/s
         TgRXKwWpBKolymqaU0q55IVWIQQWk+ZpKeboxNC1P9K5OVj8xHC5AoHgXEro8tprgq1p
         NR4w==
X-Forwarded-Encrypted: i=1; AJvYcCX8yXrORzFtgXfArTMS+lR5Oag6GG6U5gUHahiqB8CtPFufhBFV6kNNr3mIPwnEP6NIon3vZiD1IUrivns=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLqOvEhyXwYCo3UTm2dNXWWX8B8QLlHDPbbMpMPFBCglvDKsbT
	oHbp6msmarkj9xpZxfwpuSK5+cE7VR+HvrepR7Buj0uZzOYctQAgze9ESoKI4DY=
X-Gm-Gg: ASbGncssm9qllNA68M4gHd45LavZ7K6VGTcthUGma0MHdeSwpOx/d0y1QXcgytO4N3E
	rXaxVHtVZI992TBg1KITqrb/mpEJ98WO0Xw/HtLLmRsDclZUfEdW9JGD6ZrCdahofAnunk+2upi
	B3QyepXWrlEx1fhHgGNyW5/4yPMkHtcqINKrhWtJ8On5KL8Qv2TiUY4qfs4CVmPeyqqwgFIQ+lx
	w6HB7mVYv+x/HDK2fW5P3ZmUAegkdhbZZXVoRYvSaZE/I/aWZ9SHIRmdCGc7KLwLMdb4vLkjf1B
	9Ttdwne+vSK2WAkwSZhT6eX95fuLrGsT+g==
X-Google-Smtp-Source: AGHT+IHow5Ax9TALz74PlLZBVVpeQZfnTQ4QfucP7E9gMwHlWhWcBplvAxbKn5vgo6QeTg9aVvDQPw==
X-Received: by 2002:a17:906:1ba9:b0:a99:4162:4e42 with SMTP id a640c23a62f3a-aa5f7eef4demr200217966b.37.1733229627078;
        Tue, 03 Dec 2024 04:40:27 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5998e6a4csm616809466b.106.2024.12.03.04.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 04:40:26 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 03 Dec 2024 12:40:26 +0000
Subject: [PATCH v2 3/5] arm64: dts: exynos: gs101: allow stable USB phy
 Vbus detection
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241203-gs101-phy-lanes-orientation-dts-v2-3-1412783a6b01@linaro.org>
References: <20241203-gs101-phy-lanes-orientation-dts-v2-0-1412783a6b01@linaro.org>
In-Reply-To: <20241203-gs101-phy-lanes-orientation-dts-v2-0-1412783a6b01@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, 
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

For the DWC3 core to reliably detect the connected phy's Vbus state, we
need to disable phy suspend.

Add
    snps,dis_u2_susphy_quirk
    snps,dis_u3_susphy_quirk
to do that.

While at it, also add
    snps,has-lpm-erratum
as this is set downstream which implies that the core was configured
with LPM Erratum. We should do the same here.

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v2:
- drop snps,dis_rxdet_inp3_quirk and instead use the mentioned
  properties. The former alone wasn't reliable enough in all
  situations, e.g. when attached to certain USB hubs.
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 18d4e7852a1a..c5335dd59dfe 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -1302,6 +1302,9 @@ usbdrd31_dwc3: usb@0 {
 				interrupts = <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH 0>;
 				phys = <&usbdrd31_phy 0>, <&usbdrd31_phy 1>;
 				phy-names = "usb2-phy", "usb3-phy";
+				snps,has-lpm-erratum;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_u3_susphy_quirk;
 				status = "disabled";
 			};
 		};

-- 
2.47.0.338.g60cca15819-goog


