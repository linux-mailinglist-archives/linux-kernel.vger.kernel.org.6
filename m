Return-Path: <linux-kernel+bounces-353108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 518399928BB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA971F24B72
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C941B4F34;
	Mon,  7 Oct 2024 10:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Yc58izfB"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104DB1ABED4
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728295391; cv=none; b=Qm5o5zVQH3Bo14he0JqHYyZ/WFxH6pLB5o2M+E5lwW19yT8xbJ3J/Oavd888B+b+tciaPLCQhDGYrfRIrt/YnRD0AdAXQgeXnmzRc94vdCRpOBzrkRTWE0vfRiGf8vLbxvgQFR9Jp8FmL1xMLveEO6fasC5O7pFPK366o4Kql6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728295391; c=relaxed/simple;
	bh=5QDnuhEw4mW+OI1kQ7qjaB1jISNlciqkoUc2FiwXfzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bSgIjOYi5Ntd0xOHgnr+WA81GTRID+wjanftHUMENG+VEb20VBgw4KZnYT7pnc6pyEw9hsBzvcgDmN9Ex1l8QPYyA/cr1j3aIJhOLRKEqVjIM6vF6zxuzRgOjOckZH2BXc81GceBZxe4nU+veblFpr2P6yFZLH7+tkuZZGzRCFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Yc58izfB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so56334785e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 03:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728295388; x=1728900188; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LaZFWW0OoOiIglE0lnSpnNdDT/Xg3HIMsZqicqNIzTE=;
        b=Yc58izfBzszMZLXXX8+ynehNeSlTK4xq7m+PLn7+4sNtYA3WmR4Wk6Su2AcNdZ31E0
         L1RV/sr7g0y91EmRBM2FJs+HGcP9zut1MEHKWmUH2psZP64okxw8QcDgF21Ap9B3C4yh
         L5a4wk/4eKpjc1FIYbk5gcEtjX3XP4pOo+qFpxpugscgb/v/R7Z7PnH6+m3cYPodZyV4
         TDMKbRVU/DEwzPQYEjXY3uGjnl5KhHkYwZAj9HtvweAqhmocjcet7k+fCJRzQFJ98xlN
         McLnQ5RR1fXYhd6cbp22UEw6ErOMfS2cDgYysi65C9bjPpJxhJFj8y1k12PouxMCA5Vs
         pMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728295388; x=1728900188;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LaZFWW0OoOiIglE0lnSpnNdDT/Xg3HIMsZqicqNIzTE=;
        b=u746CIlVmA2bF7fgvwnMi+othy4NdQhq1FSLFlwABtq8uImR7MFvAUl8cU+PAXCVhQ
         NfH6+343mXjbLMT+Kgdv/5U7jhfYvuB0uXwrjTddmXKxn+fzPpbPqX4QobHAzCqVd2XU
         OISH6cqxR1RVsobcqGKjuuIBKJiYsQcM9l9TaNuNEj85nQ0LohoBRxm4JHuqwdw6Nw6E
         lhT+LuPRvpHd2XFiCbu4g99mwi7J1Pt8jDdqfB6hX8GboTezrQiZGZxRNY0xOi0wAhzP
         6N6vlLg5uTGk9d7tfb/xUzVxuUkaYWGK/0kPRfCmO0hCGxLPmJklyOIAQDKU4NuTU6YV
         VynQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu09z6oxmXlGIZ62UzmpK1+K3iBMMVBGdXNychZuaLMm/8o3UeNCCzC0BZLkBCQhCDSSOHrZx1g1F0bv0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/oxijAbAhXYZaLe/BWGfVA6K90Q5WTCDu5e4uhHf00eoxut7L
	L87WGMHJDaF/QEuymAilgsTFb6Ipzq9+1AOsHgpdDDIYZkbOs1mE+uQUIb+neYk=
X-Google-Smtp-Source: AGHT+IEJUV67aulGBDc+6TMvB86ylnoZPv3EIQz34ZCQXnwR63W97ABjqQmZxMdNVTwAILofWV3mBQ==
X-Received: by 2002:a7b:ce05:0:b0:42c:bd5a:9455 with SMTP id 5b1f17b1804b1-42f8ddadbbfmr62355935e9.18.1728295388133;
        Mon, 07 Oct 2024 03:03:08 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:6100:637:cbe9:f3bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f9384f648sm8498695e9.20.2024.10.07.03.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 03:03:07 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 07 Oct 2024 12:02:56 +0200
Subject: [PATCH v8 2/3] arm64: dts: qcom: sm8550: extend the register range
 for UFS ICE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-wrapped-keys-dts-v8-2-05ee041f2fc1@linaro.org>
References: <20241007-wrapped-keys-dts-v8-0-05ee041f2fc1@linaro.org>
In-Reply-To: <20241007-wrapped-keys-dts-v8-0-05ee041f2fc1@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Gaurav Kashyap <quic_gaurkash@quicinc.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1020;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=Fjh7PKlQ1aZcNz3qZ5ykyKmWcSwbuikpY6HH27gWxI0=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnA7HXObkV2OKTXDd/iSIoZv49eVrhRZBFT75Zr
 Nrd667c+7GJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZwOx1wAKCRARpy6gFHHX
 clzcD/4tp+PlpSKwtr0Nro0jTof3XK6+XT/NWNC/Tf8fZ+CDHOti++zwuoI6UyaO/UvVNiJhALn
 tQT3Lt4UIYRv+BAy2dJtY/OyTH0zHAQq8sr+fPmfWnf7nkoRuGqtWK5JMHF0/VKQET4y4MwCYPZ
 7bbPFRtW6qkQT9MzIzSqFB+Ux+bq9NU36ZaRuSwoYi6BQDXg8KjQpK5N2Tjl24c5IYx4yzx4XtW
 3c4gk85wbE/AxX2sQJO5WMRCDoJlY1/hp2FjtwBlN/uaJyCrL9qafxsAn27RtIBJSnIu/IgHt/b
 C/obAXMa71C0VMmMYuOZgcU8rmCsYt1VBQbVIkJLVF9uluYDBTyQ0DB4jhfG8njbU7EVukV9cvF
 gup09d7XlLdRxb0tClBwU8/qgTFjtMpdQB9yStiIgqsxMUScS0qqzUqveQ2Jq0tXHJhSRU02ejB
 8jZVZFr4HPQc/Ro+4cIbj9ax47F2dcPg+23XBgI14fngHoniQoULD91Az2iohHA33rMSUQSqRd1
 Qa7mO3UWtvWYspd8TTI6xMyJztKnHfU5+ZPc/SjhUPCRtLPRRuQiNyRmRwNjejSZliEAcVocJ2l
 1wMeVRvawu/unG97/ERVmL8nagV8LV8L5su1XJKo88rwA3f2RQj5GfukCVcDzR4Gj5WJCOJk59q
 DGWjyYsW1DTtkog==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The full register range for ICE on sm8550 is 0x18000 so update the
crypto node.

Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Co-developed-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 9dc0ee3eb98f..93c8aa32e411 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2076,7 +2076,8 @@ opp-300000000 {
 		ice: crypto@1d88000 {
 			compatible = "qcom,sm8550-inline-crypto-engine",
 				     "qcom,inline-crypto-engine";
-			reg = <0 0x01d88000 0 0x8000>;
+			reg = <0 0x01d88000 0 0x18000>;
+
 			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
 		};
 

-- 
2.43.0


