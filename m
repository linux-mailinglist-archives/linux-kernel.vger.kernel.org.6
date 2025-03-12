Return-Path: <linux-kernel+bounces-557783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AF3A5DDB6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81D093BB791
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B5024A047;
	Wed, 12 Mar 2025 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L3ttqbjH"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1844424A04B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785272; cv=none; b=pur/cL2tot1olWW2Rwc3R6NdW8QNSjeFDKiUz9F1BkI1MN8pz9H2o4MG1nlVGfS5YlO/x7AhVUHT4lStMrl5gx7sNxGwGkOnPtbekVDKvfbDTLwMuKCJXEfq+yjOiKF4mSzVeT9s7ZzvQ5jNKgtOiHug0PL42eo0dQBdeIbpSNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785272; c=relaxed/simple;
	bh=lR6PjoPFKVsHG2J5Mucpa/CnvA+OdHPQdfRh6cSHZ2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YoN45trsaS8uCsev71A73a4wzIbumgYv4z+Ygz2qaZJ1F0yssvxJbGtYBDCH9rFvdSs2WPxrfpF8nzP7HhIU8hVEEYJOkyOx5AirVLWG6dGEQPGiRTtPNX1UjfoLv+kbAvJIDTTeOGHlP0vf+cBLrZ19HX/wwkG0Wga4oYqy9no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L3ttqbjH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43938828d02so8369475e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 06:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741785269; x=1742390069; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XK+UGaMVwf9jHj43qw1MVxGsWYAAC0YY/TWDG0GH+T0=;
        b=L3ttqbjHI9Y1mRKi7gIR3Q98GU/f6HerfDDg8JrwXybtqQ3U2vZ1RGR6skFjkil51q
         qkIC9FJOlEB2UuQwckDWrMHaQVncFtvohkvR9hWmxuOdepaqB+S+bd+9OdxfKSILQkWC
         Xd82SUCk4fJowLI3f5dfF+XDHex2ouCjPxQcLa66P+yWEfD/o4/x9zzEkXapzBIg9KKX
         seY88mKI3FMgOgm2S80YmA3aVn6vSgR5ToGKntop5Hm81pCkE52ndmPbFMjnp7Co5CJ8
         CvWtkJTO6NDAgkAWxGwJJ1WKQ/23qBqEhLf++e+kjlRrGAdfo7E/ecvbvKnfHRplcuis
         iDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741785269; x=1742390069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XK+UGaMVwf9jHj43qw1MVxGsWYAAC0YY/TWDG0GH+T0=;
        b=lltFZ9PdYLx2PbEvemtnHNxKPyDv+5Wr5rrl0BR0AkgEdIX91IJFcDWgz4thT3spWL
         6FW1FgtYHAU1Ybm+2Q5hnpMuWonIWLsa3blcLRp6SuL6Rom+oOkyxpo+aAnwhnYFByR1
         sFZF3NP+htcLcjWsB4HfwsJo/NR5Qunh5SJ0rQzS0TjzRISRuJzoBlkLxS+S07TX2F5g
         uYPF6GLwkvoSa2Oi9BWZV3TKISwEZPYHFAQ+eTMNMiGeGXGbRDhWJQP1TdWzQwsyS99X
         rX4AHaqFYUfAwjqZ4Dnr1HLzv8I9mcP5vwYkS0cK9HfjtTA92f3VA4jQ6Lzgmu3/ZyYx
         9y3w==
X-Forwarded-Encrypted: i=1; AJvYcCWKUXiNi1Wmh01RT3mgVJ0FJP6HTwmVnUzZz8niWep14OygT77ibbZidCDKh0+bVluYR7pyboqt6GPVphc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuqnie0nn2bQXl05Fn2ZGHceELdRk3v8U1XYi6m0CkyDLhXAIZ
	niedHvowIhZsMvtTJsTkQ/noN39NU0LRirUYQ7euktSVLztlV0d8bu1K5zcJOFU=
X-Gm-Gg: ASbGncvOmHnhz8fQiKfa4SCvoaVexUebx5goV00lgB/ndzZtLMqBTHFoHtgDTOWZrRP
	1vGjuD6Lx3MpUwotFgvLJsZGGaUFYM7MLfSd/PH6v3yG4XnkOHXTEi2iGPDZZNAf9rgJVgM2aOu
	vFcgK8UYziUorNMUGKA4bLX679fnG/wsFC72n0L0OuaBf2fuXBz/U8Y5VehD7OXCiEktrzA7wk8
	Ps8GHL3aYihf2klvcCnngetffDKWWymiW2ekmZ5OYK2CD5b/XI0kClA7OYMhkOX3eSNjRWfPNnT
	D9l3XlpxGUQqmVEbBQq3ZWBNMbDPDSVMLgMaSVGFy3uLi8g9q45wr99q9qE=
X-Google-Smtp-Source: AGHT+IFXxegfmgQM5h+h3H6IEhCsssC0UnFb5yxq2rS2ER8UYMHh3dfRMTJTzORYWe0axLgbEZSsig==
X-Received: by 2002:a05:600c:5107:b0:43b:c844:a4ba with SMTP id 5b1f17b1804b1-43d01c12945mr32907775e9.3.1741785269320;
        Wed, 12 Mar 2025 06:14:29 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a8c5cb4sm20966745e9.25.2025.03.12.06.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:14:28 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Mar 2025 14:13:58 +0100
Subject: [PATCH v4 2/3] arm64: dts: qcom: sm8750-mtp: Enable CDSP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-sm8750-cdsp-v4-2-4925d607cea6@linaro.org>
References: <20250312-b4-sm8750-cdsp-v4-0-4925d607cea6@linaro.org>
In-Reply-To: <20250312-b4-sm8750-cdsp-v4-0-4925d607cea6@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=848;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=lR6PjoPFKVsHG2J5Mucpa/CnvA+OdHPQdfRh6cSHZ2Y=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBn0YikXG84GYnmOWpnaAFgNMm4qTMRZq+93nStP
 4JPUnW3x0aJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ9GIpAAKCRDBN2bmhouD
 13wwD/9c+P+vkuq58tSq5wtvVVR/bzLWwcw9QndgJkiARmh+9lQ4uj8qikAIl4F4PyaOjYPv9fd
 pAoJXWLfCj2pplZWw8yfWpLGy+GRGShkehlu0HJLzqzdWZamMPQRSKX5eclCeBXhWRDSitX16S9
 W8OrKrDVTdOhTUwK8mYwUMzQjeCp+3S+sx30/XBvYnZx9GNYub5Lpp1E8g5eRoDeD/tA+R8du5E
 NTTkZPuriTwoO6ZR1pEOf0H9ON9bxrizmJyQseaYNUZ8fv148GYqT0BQqFXzwGQrxy5WDviMnmL
 BPG+qGgy61RVhn4hqztzE/4frx2Mb+YVqIOI4DSp0XhpZtbvlyQUWSigIAihwzDKATpgu7oStOb
 qU+k8zVlVQce8wpTqOqMJk5HAn0Ospb17mHNBg8i7Azg84BfBWD88Fd5Cw604jFuEL8NnYYuZ2v
 byhIeANLy7BaObXIPjIP5fjYHvGeydSKC5WKTmoYT+ngLi7fxkQRpmTsC48bCEdeYnadNLi7JnP
 A1Xdeo62nsoYyos7anjWmRf53vSUwDubUCHcCaATN9z7US0u733R+WIchc7Z5qwASQ0gBT4RKuU
 WHdom4aDfSieXHYDIpriIwx3/OiOVe+WzQN+ZfhikR216XUH4DBP0aQ2RNKuQYiUwkp+LGXT281
 wiVg/TuJ4mJIv5w==
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


