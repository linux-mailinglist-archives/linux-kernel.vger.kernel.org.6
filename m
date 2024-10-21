Return-Path: <linux-kernel+bounces-374096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B68E79A632D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F136B26111
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB511E7C04;
	Mon, 21 Oct 2024 10:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="njaWEZNT"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7857E1E5736
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506652; cv=none; b=PnZ1c3GSij/l3o/rwolNxFlkyYWyp1iCbRTMPBIe/3IM4HlA1M7Lm3Wlh5xuiRPLj/v4bL4btaBSlVA3HqYfHUE51+tiKorSWlky8SY4aU3q//WlTUQG7q0gdP9EakcjS3NdDwjtycNQDifeDxGNUajAR+nQIkDy7gb0ws2xhm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506652; c=relaxed/simple;
	bh=mHXA679fTLSBfLWh8pBmR4AEa9V2nbcklgPIdka6VnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IQbzKBQdEL03oF8/y2JpPtCrHl+nd+aTs/++NVT5TI5/LjbFw+T9Usv6IauWH87YBUEwEiA47tSAA0LTbHOULiBw8JzGM+2ZIDiK1yGPtA0rZ984VcUbxGveXVrVwOMrQsHmk1Qhi1OBn8WzDhri1m3Y7ocldUaeFr2Sw3JfKzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=njaWEZNT; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb501492ccso41559071fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 03:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729506647; x=1730111447; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yljl+967ibX2I7aSbp1Ln8dspkbFoWgzBqO671H8u2g=;
        b=njaWEZNTbIcrhz/OA46aFMMoNFr+IMuEbZy2Eo1lmXtMUeN6GAXf9K9HK7dAUhOV8A
         VkKoKPLNAS9xBmk83JZYAgPWU96crv6Pks8oQJTv/ONS5jbFFR396dqAj4ptKfVnxNRX
         2ZVFQG62ystPVlSmLZtHKnijKpDPIdCgjKpGSrCYpbvLkHw+K9fXZEZCC4RLbhq2Wxso
         5KPcm2iW5k0kSWHLwMJxTumHJal3uhiqZyaIQDm5KR+3wZ7pZwOb0w8M/3z5K726Ck4F
         I7gKjO3BmtzUt/wom2YSsycIK4MR/HWVMF3PpK72a3VWpcffX+Yaj+w9mN1QOv8cXqKF
         dTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729506647; x=1730111447;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yljl+967ibX2I7aSbp1Ln8dspkbFoWgzBqO671H8u2g=;
        b=k60yUcMZRM0RN7I1yQCQ1wjt8xMe30S64NsPelkOBAzaLZVNBPIvvTmb7dDbTfx01L
         Mf3VWOJOhofTQnDykfaMMCpdswfBhFFYSfNpK12O9sp6HfJhEeGUGz6mwsFmmVKSj19n
         5CLm1SkKF1HeBTjTiGBpC7hCzbvuy2MxtfzMQuTTJ6es8WONBCV9MBNpsFkqKMMW6aMm
         npoHMxcjaufdK0vyAnJycm0jH0u3e9Qn8RkXDB8+b49bcFblDx61HdFqzWUN4VKU+2uc
         hBvD2C0lExQE2XXmEZb1mvya8HYHRhFnv0Fw3RCxhOO2ErX7UEUN2l7Z23F9D62PhsQQ
         6VMg==
X-Forwarded-Encrypted: i=1; AJvYcCXecWAKjtWv2HVM5dNnMs1+g/IBAZn46b9+Kd5JxjPWOCTlipbcWzn1K9tltr7JzqTkV8qxURlQ6i4GAto=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj6mSZaHDo8H2vgfPgHHgTKY0Eepfgfb5H5H4cSKbfItJgoc12
	jxt3y/TfvvNH2zH8qNFZLQDV8UiegEymleLon2I2+6MQaO5cxgxHAem9Q+GkvKI=
X-Google-Smtp-Source: AGHT+IFEAf3VsRlUag/HZ2RQfkkbpZqeK0Id0wd97oP1fQ1EGym0ZePONYk2xJyG4yWaKOBBq70Diw==
X-Received: by 2002:a2e:4601:0:b0:2fa:fc3f:d603 with SMTP id 38308e7fff4ca-2fb8320b9a4mr42369251fa.43.1729506647492;
        Mon, 21 Oct 2024 03:30:47 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9ae1217bsm4522711fa.112.2024.10.21.03.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 03:30:46 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 21 Oct 2024 13:30:31 +0300
Subject: [PATCH v2 03/11] dt-bindings: clock: qcom,sm8550-tcsr: Add
 SAR2130P compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-sar2130p-clocks-v2-3-383e5eb123a2@linaro.org>
References: <20241021-sar2130p-clocks-v2-0-383e5eb123a2@linaro.org>
In-Reply-To: <20241021-sar2130p-clocks-v2-0-383e5eb123a2@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=992;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=mHXA679fTLSBfLWh8pBmR4AEa9V2nbcklgPIdka6VnY=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnFi1KzpKNHxm0KklRhMIDLdMwM8nwLkURcyszM
 JWpB4MC48yJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxYtSgAKCRAU23LtvoBl
 uOUYD/0TiKxC7WnLDWWxq/kXnj4XhcUn8cX8UB7h/KNcei4O3u60vBCtey+mOEv12DkguL6FqDE
 g4uqOFyMbBmdliC8Ml11Lh3jnfudWGWLWGg88Vr0QOhHmGwERJR4pOg2b3tNCKJcJGhkLi4hCi3
 jG/zjAkwNodFJmo77JMciY9KAogHsKDrt0Kd+UtJpEzsx1Le//1jITU3B2Vm/q3cvq4LMK+OdLD
 FpUGcAVKFYyEdxSRSGcF5fmAVfiHlo72c0l+CE4n763ZNdM9GRbu9CVTnST2ukCKUcZP3cOYlgf
 aLQkAI5sV5SGI3T9SjTVZiVvZAEUTv1vKoKSf0C6+mrkngESo/tnNbxIaDXqm83r3+zZXOSFf/6
 ZGoSF2juOhU7loiB4djUa2btlAB5oor49nLsC58yemAsGDCBsw+UtEvlrpRdcNb3rKlxaFjN3e/
 TkG/tYQ0lJCRrDb5Q6YOs/YT64beH4eU89cn5FF8e7iaCc/Dm5WBdb8/I3aPkbn2HRwpOLcsems
 BXtx78EfpnwlKuYghGfmBkrtJwv0uWqUQ4v9Ysfe43rkaU757HR3YMVVnOm8TAODdPRTtGz7F9B
 En25yl0mbpMNs8rZUkW+tuL1w2auZ1arvE2hQ9S0hnb0Rr3T9YST/ggkfeBHJncFekCz5sGsEho
 RFLgGAEVqGbEJOQ==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Document compatible for the TCSR Clock Controller on SAR2130P platform.
It is mostly compatible with the SM8550, except that it doesn't provide
UFS clocks.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
index 48fdd562d7439424ebf4cc7ff43cc0c381bde524..3b546deb514af2ffe35d80337335509e8f6a559d 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
@@ -21,6 +21,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,sar2130p-tcsr
           - qcom,sm8550-tcsr
           - qcom,sm8650-tcsr
           - qcom,x1e80100-tcsr

-- 
2.39.5


