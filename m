Return-Path: <linux-kernel+bounces-544213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CD9A4DEE2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AFA77AB2FF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FED12046BD;
	Tue,  4 Mar 2025 13:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tZTujuxP"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8142E20551A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741093643; cv=none; b=on8ZdC13GMAV6qqmVdA1HxeABNtb/g1d3f8eTB7VUTQMmzfMuF/rJJUDndtyza0I9UwLq9+BTQCIko9h1X6IjOpr2wAJ/Nmw7F4eB+et3KkFQwX+3ysiahVU/BCkJbBtU/CN68ODU3e2QmNeA8O8X6B2tjdykzquwLNCzF/4iRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741093643; c=relaxed/simple;
	bh=hbTVezICqr8e2a2ELXb8vmVSM+zmKLpGBJ8kAi4wDWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cyxvKBfejC5zzFG2KwvPTc0gK6aKgmMV9ZLBTYfT7hsr/++SqE0EZ5CB7DBrFA3F89rVqtSDMTOqvDaSUlK6VChTUDnnSurP5v0sZopZD7AhWbOuvnQrUXNlPMmHKZb0chdGJ1f4HUeUokdp4gKJAdgLOkpfjuGG7VjdduPsdj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tZTujuxP; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so36194345e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 05:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741093640; x=1741698440; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0sMLvCT1fnTWe+fQQZYyr06r8CMaLxKRmrVcKoI1NIQ=;
        b=tZTujuxPDg2GNgl1jcs1IhE7wLC4TNKfyI0C5rE9aBY7nF7r23ql5s22CPO2b1GTIY
         1SpJ3jEtI7kG842OfqgYsFZoX6+4hErHw28dw75EtCTH7FfrjPsmqhoU6MsixhW9gcX9
         zhA3bcUHoV1p3EAEaLMMD+V77FHr4k/nTHd4f7CYyLNPoYDWajUQ0JAbjsggkExNVIIF
         tCnO+x+wRgrZOt3QptBx2igALb3RY7wk7LYCTeP9kQle831yO18y7P75VJwP7trH6vZR
         14mqh8e6Jl+b/mH6SItHvuPLT/d9H0Gok+Q7/lozlQGno8IupClXclvlvbRSoNj5k7Q0
         wobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741093640; x=1741698440;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sMLvCT1fnTWe+fQQZYyr06r8CMaLxKRmrVcKoI1NIQ=;
        b=aZRkiQVd3N7yHUcvwMglePCYxEZFKMBo0kWvz5SD6WJLBmySoqIEk9AtOXpbbydwfs
         N6IO0l1EuCtSKZiiDHl/0tQ9jecH1E3CPczDn3Fx+SPXOa5X6GUqg5ADVgkgOEyByPtC
         j3rXZzHOWt1h7Gi8wa3olyfJuO0PTPSEO8RSOOij6haAzNQrL+UYjD4FbDIFcju9wSVB
         QM80DZQGuoyh6LQXmPuCUvv8RSaAbxaL6J4/R5ZGkiLafgYlTpRnXKn4NrudLs6EYEch
         EDu7X01U4WTRc98A3VP2cCqXXUWGICVd+pfI50l/jEWPxJSDfQe8O3Ydjz6jJorNqJYa
         SNNw==
X-Forwarded-Encrypted: i=1; AJvYcCV3l3GFIw8j8zyoahn4RnK0af1zqHm+85MlbS2ZgIupu90i6/lFScQHIJDQIpLd6Elk5AABseGSas3wdu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN2U/OTMQPnVFhpQjZ1IxRTQAEarXXshU8pvKLFxFyZvnn6u6W
	d2l+HecZrbgrqClCKcTsODpg+n+XYv/z1r7qtURLa8QCyBzaTMlqwdxb6+JtK3k=
X-Gm-Gg: ASbGncsHvRRcy3h520RpUAnvZWXMoASGFauEPhlEP8m1oaOIcOlevLRibm/kg4x3psB
	hjr+avURFW3EBpMofqCS5XCQClB6ny/3AiG0ibwwFdFAaG++Iiaub2/zcxYzEefsMQH/FKZp98O
	ve6ZZK/ySk9dLTlOeQ7Lj8nmVEIDpG+gq70KupUccKYb7aTmOsTnLf2gr8LGRPNZ0z/oCFqDAb6
	zxC9pMFPEm2uJWjluHptZqN1tRnvU24uNbKEcaOYWoaFelbze8hXPamhSNqduH/G59JFfxOuy6y
	vK9ups1xaXOTEwqet3Cx3R92IUUSXDanyM8mDjeAk9/+YtIK2mlICkwWnshNX559rlXJbXzsWnR
	EocExNA==
X-Google-Smtp-Source: AGHT+IG7Hqk+59fncwqRhoiQZI0qgVNSHDtmwiVCCcb9ZVYfhmFpPhJTWaXXdGtM/0s4DaDuW44HFQ==
X-Received: by 2002:a05:6000:1789:b0:391:ab2:9e80 with SMTP id ffacd0b85a97d-3910ab2a206mr6605504f8f.24.1741093639862;
        Tue, 04 Mar 2025 05:07:19 -0800 (PST)
Received: from [127.0.1.1] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b6cd8sm17401715f8f.44.2025.03.04.05.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 05:07:19 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Tue, 04 Mar 2025 13:07:14 +0000
Subject: [PATCH 8/8] arm64: dts: qcom: sc8280xp-x13s: Enable Venus
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-b4-linux-media-comitters-sc8280xp-venus-v1-8-279c7ea55493@linaro.org>
References: <20250304-b4-linux-media-comitters-sc8280xp-venus-v1-0-279c7ea55493@linaro.org>
In-Reply-To: <20250304-b4-linux-media-comitters-sc8280xp-venus-v1-0-279c7ea55493@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Johan Hovold <johan+linaro@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.15-dev-33ea6

From: Konrad Dybcio <konradybcio@kernel.org>

Enable Venus and point the driver to the correct firmware file.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index f3190f408f4b2..d4c53845eebb7 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -1477,6 +1477,11 @@ &vamacro {
 	status = "okay";
 };
 
+&venus {
+	firmware-name = "qcom/sc8280xp/LENOVO/21BX/qcvss8280.mbn";
+	status = "okay";
+};
+
 &wsamacro {
 	status = "okay";
 };

-- 
2.47.2


