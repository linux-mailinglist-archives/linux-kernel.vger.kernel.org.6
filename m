Return-Path: <linux-kernel+bounces-382073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7396B9B08B2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39412282AB3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CC7185B4C;
	Fri, 25 Oct 2024 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vPArYkF+"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DCB21A4AD
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729871012; cv=none; b=Mui38gRH4mp/FrJTDjP9EAVRGIk35UYvRpoCS/AVzdle5d8kW2IWIxTrupqtuaNdxwGHsgoq4fC7ZazhC4vx31lRi9DL6Bt5d2H0CQhmCBahTtCJeGq13mtHmFMZhhNZkp0nowr5wwn38dNYayIObtoB1shqF1JNEmUF3vpNOzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729871012; c=relaxed/simple;
	bh=0OGkSu9fVMeO/ggQr8GmRV/6Fq7P4yGca3PaDQMq+zo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PR9vXd41TbpLWWn3Oass0wm0xtRXjcCTgLLPFsnzIUB8e3YkyXhGialgUYiWC4Lk1CCULcJ3WsVazFGfGeq4awwc89oQuUJFowselRSr3utRW3SMlhtVgvlKP4F15KU55CoO7Iyh9Y1F/Hhhocij3FlHHmrrRHW05gTgY/JUbuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vPArYkF+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43152b79d25so20050425e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729871008; x=1730475808; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BAvhKRhyCVaJwnIkEFPjzzUhPMWhbjYeJwcT/tBQFU0=;
        b=vPArYkF+CvO0rNs+zRNY4x6QDh7gf3/K3/swMd9Be+gcs8htzuk1U7sKu88F4XiVKb
         vbWikqwTVm/AGwQHgzKg9oXdnoxturmrbFIfnXNV90DM+YfKwLR00pR2ftFH8IrL8BKv
         UbIarwLe9ngX8feoRzdk/ALjurL8OFToaDM2yjXzt8VkXfZPnlqYJP1Qp2yhQe2aYIlz
         XgzqJ+i14vDNDvWO87xQdIZHjex5uYd9kwY3D2NPYtbvTu9RHvtfBtfVAeUR1BHFWCpp
         I5nL6cBFLs7gXYShv/S7JYLdwYGUDJSHi1N3Oeg4UI9+aaUtZTGH22AxQf4qeo/1d3Yb
         tj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729871008; x=1730475808;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAvhKRhyCVaJwnIkEFPjzzUhPMWhbjYeJwcT/tBQFU0=;
        b=PkgEcXf4pYVEwhHYh5npnZwCk3UhiXxcY44gbPvDceZahxEdt2LeWgNYwUmJsoL3kn
         lnPeEsqErOkgdSE2FmtmJ98hhHkVQyDiKZ7qR/No64gLvOHaCmOhvbt/yqRRYsnlDi0j
         Z/urUyRGgjMGm4FRnheIti/IwkpjZrknTBFHnvnd+7kmRlZ7V+nfUBNvGM/qVWT5LY2y
         TOywTik700HrSxyLCsm7QF4YOyWwRL+u36zgoXahlTlcydA4g03QeFgU+mBKulfTDGIx
         pJgaqtODQitZhwz8a6/h6NaNjOWwPS1wrwWDiwKUam1uuDBwIqpi0ORG4h6D/0jaaVrd
         z5qw==
X-Forwarded-Encrypted: i=1; AJvYcCUcwoLTXm5rhBjOQre0OAs/nqDRRa9gPqfFjioOMA2nCQjBhEtZOFees1JNhPfF0HkFtT4OUUl3nalCG8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy4rTHWfjkI4JxGbm84ZvduT2RBFb8oZG1G1wpwojwFl9xwkWx
	q7KPIcxmDZFdmOkMkns4Eo8hA4hTxIRFS1DBgXxsnWEiYOFlostPJpn/BjQZD5g=
X-Google-Smtp-Source: AGHT+IGGijeTxGoA0dzwySSV7QmfufUp5vZNtDNrB7BBd9vPRhaNWh32zcGrgD8Yu6ae8r2kP/f0iw==
X-Received: by 2002:a05:600c:3b1b:b0:431:594b:8e2b with SMTP id 5b1f17b1804b1-4318413ee73mr88288655e9.12.1729871008199;
        Fri, 25 Oct 2024 08:43:28 -0700 (PDT)
Received: from [127.0.0.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b479ffsm1829092f8f.49.2024.10.25.08.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 08:43:27 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Fri, 25 Oct 2024 16:43:25 +0100
Subject: [PATCH 3/6] arm64: dts: qcom: sc8280xp-x13s: Drop redundant
 clock-lanes from camera@10
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-b4-linux-next-24-10-25-camss-dts-fixups-v1-3-cdff2f1a5792@linaro.org>
References: <20241025-b4-linux-next-24-10-25-camss-dts-fixups-v1-0-cdff2f1a5792@linaro.org>
In-Reply-To: <20241025-b4-linux-next-24-10-25-camss-dts-fixups-v1-0-cdff2f1a5792@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Depeng Shao <quic_depengs@quicinc.com>, 
 Vikram Sharma <quic_vikramsa@quicinc.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.15-dev-dedf8

clock-lanes does nothing here - the sensor doesn't care about this
property, remove it.

Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org> # x13s
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 83208b10f994b282ed50c3ba8a82298b6fc50deb..15f59b622bcd4250f43d329fd9a371ae4d0a73c6 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -633,7 +633,6 @@ camera@10 {
 
 		port {
 			ov5675_ep: endpoint {
-				clock-lanes = <0>;
 				data-lanes = <1 2>;
 				link-frequencies = /bits/ 64 <450000000>;
 				remote-endpoint = <&csiphy0_lanes01_ep>;

-- 
2.47.0


