Return-Path: <linux-kernel+bounces-372059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A419A43EA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3AF91F24725
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BAE204011;
	Fri, 18 Oct 2024 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u0DJGgcU"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9C820370D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 16:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729269172; cv=none; b=PvArVYwUcTQWAUMRDG4X0WmngJHRP3a8vuN0TpATkcEMv0r7yspOdxzj7KM06Ka/qHvwioUxEq4/p0oSbV3+MlCrhI9et6hiFrILfkGkz6DAiZOjj/v7kwMEJuZj2O4NMHUjdPZDGZt0ELzN0uvwkvAVVApMqtSe1sMrA4SPGWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729269172; c=relaxed/simple;
	bh=PM71LwpkitHpyjAVpmoIp4LheC4HG7kkWYdqCdHMd4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OWxrsHPxywBHA9f0tNBmGTFO4C/Ew4ga+f7mYOeYPWy8c/Qqv3lE6muXqlUJYjkGD+LyPpmKkNuPIdv4AxlWFf4GUDLApSNZBMHtnj8DiSgy5bTHJP1NcFXb+urTzLNhDM9EiaNrI23+jjQjgdGn2sjtM5QNNgOBOY+NNt5gDhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u0DJGgcU; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53a007743e7so2971176e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729269168; x=1729873968; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RfzKhuTiKp9pZjSgZdxNSFehbqgfWGOXbTqsUd0B2/8=;
        b=u0DJGgcUnEZE28jukfqlySZhUJaw1pu7v4a9MmUS0c5JoA21ERVa8+WmlBxNuE7091
         jufBQZnfAUCJapM+5sB6jJiE6Ml2H7mlZH22tszsj848Kxu5zlYi3UyGhCy2bYmy+m2M
         sLe+pQ4OdVcZfe7bSb5B5XUGibsbUWsTXFch1thN8QOHVbKlLvIXMaE9pYfeBoPZa+fe
         3ZRFnzq1uLTUQNa8uw8/zsdpy2aufA9D3+cDaTfjnv/m3AqWIPlIZDYc5hoowNLwm0GH
         fzg6GQuqF6rlMMsWUXfWvDR6Fk35xk8YsBKneOPzm/SB6hK0Y2Oh3ARAh84E6/U9rh7f
         xhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729269168; x=1729873968;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfzKhuTiKp9pZjSgZdxNSFehbqgfWGOXbTqsUd0B2/8=;
        b=qg4T1eKRrh72bjfjSvuh7pNSmzbVtYFojJ+WRiQ9KzkUJTb1+JlUiVTe5rMAA9HZqj
         IEvDSdhhf5zpDzEynSBP3WC4tX4+z+X80PTmmombZKuu77SgJ61NLmi6t0VQr5Hf0oyW
         H4bXC35YCnT6fi3ihtFScUvbdSoUcrOveRARZHPGT9BEroIf8qNMgIrX13bTtrddT1h5
         CcaRx8zscRZRKNxP7woqEYVkFijttzPCnTMGJ1+kLg6GQwycBbQg/LgbmYybyZ/L7Gf8
         xQO3sX/7aR6H40yjWNCboh0ngdeg+/7DYhan2eUjniveRHKENjCCIHrxtL0lxIRxCmkT
         Y2mw==
X-Forwarded-Encrypted: i=1; AJvYcCXO/LWvGp6CJuT3P4SYE/AVcunpYg6q2iY9niJkGePi5EL8yZLG5L6XmyM6Lsx7Npg+WUaepJcEI+r33iU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlfo/Xnz8K/E38oytJWque2SAaZTMn+B+8DZ/2meRwQj2Dz2rH
	OpOlhLE/niLkl1ORWdzSpp+Ot5fgHg7XNOp6N77TUaDuqpsYD+kcjZDo1Wrt6n4=
X-Google-Smtp-Source: AGHT+IFi8QRylLpnzrJYHT3b0IDEkd/M7Jz6Pssf1yCivyQDMb9wu7GkC2wGtwbLT1IS3qXwHGBopw==
X-Received: by 2002:a05:6512:4017:b0:539:f6c4:c29d with SMTP id 2adb3069b0e04-53a1550bbc1mr1982662e87.54.1729269168504;
        Fri, 18 Oct 2024 09:32:48 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151f0b67sm259486e87.126.2024.10.18.09.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 09:32:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 18 Oct 2024 19:32:37 +0300
Subject: [PATCH 2/2] soc: qcom: socinfo: add SoC IDs for SAR1130P and
 SAR2130P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-sar2130p-socinfo-v1-2-b1e97ea963fe@linaro.org>
References: <20241018-sar2130p-socinfo-v1-0-b1e97ea963fe@linaro.org>
In-Reply-To: <20241018-sar2130p-socinfo-v1-0-b1e97ea963fe@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1007;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=PM71LwpkitHpyjAVpmoIp4LheC4HG7kkWYdqCdHMd4U=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnEo2rk8zifH/0OLbmAWpSbnpZZgz3CDk++F9xX
 ems0gpMHhWJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxKNqwAKCRAU23LtvoBl
 uJBPD/kB4Qzmnm34PYL+oWVfmkbNMYukDEKSx/8ITdvomK+vOiJ98qOsZn7ii1aSF5yQKYEIV9j
 upeFaws0F7JuL9MCO8vwl8dt5UMM6M1bmYnBxPKlNnFfjWWk9eOyl7jXiwbqSCC3Cvrfjkb4qCj
 x+CT+cpb+idA2nI1MITaJCTj9W1mtIeKUf5KmDePH8ah3OVt2wtV+IP9gCeIWjVOl7W/xUpnprp
 2ZuH0H44fK7uyiIMAxukh7sj8XYUUrXg2s96nhBbP17H160OWyCbRBjJGhHerZrcYEt3eCvsFrj
 57C9RbOWhMh2o0qBeUhdW3zNxhSvV1FUqr0QapvNiNZys2rStf60prf50wrws/UI5d/te/jnISY
 sPe1odGFSxnh2TUhpkjzTw4+FYDvZekaQ7u9iHSig1QF9HkwgEsyujnOXi2VNZUmTnJ32NnAYqa
 kHL9z1FaO6gvGgrMF71DROaBrVlL5iyU4T7zRwA5EipER9fWhLTzLiHgMasIWGMjiSvIFgIX0mf
 MuH7PxhltohC2JjxW76FnX9wzTL/2Us9qpUnpjb32SgO88KeYjVGk0quxDx1ZxIL3M5o1OZJ6iR
 B897FM7iRpc9Bm1vknHql/w0wrfFche5y7TYLrUFTAdhXsihxw9gZNbmX8fPycnvJmzNTCiKCq1
 0lJYPUiJpXlkM1Q==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add SoC IDs for Qualcomm SAR1130P and SAR2130P platforms.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/soc/qcom/socinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 3c14df7a382cfc67d43c8f096ecf7416de129e4f..396511a13deda80701c95ed43770bfc1273673fc 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -422,6 +422,7 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(IPQ9510) },
 	{ qcom_board_id(QRB4210) },
 	{ qcom_board_id(QRB2210) },
+	{ qcom_board_id(SAR2130P) },
 	{ qcom_board_id(SM8475) },
 	{ qcom_board_id(SM8475P) },
 	{ qcom_board_id(SA8775P) },
@@ -431,6 +432,7 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(X1E80100) },
 	{ qcom_board_id(SM8650) },
 	{ qcom_board_id(SM4450) },
+	{ qcom_board_id(SAR1130P) },
 	{ qcom_board_id(QDU1010) },
 	{ qcom_board_id(QRU1032) },
 	{ qcom_board_id(QRU1052) },

-- 
2.39.5


