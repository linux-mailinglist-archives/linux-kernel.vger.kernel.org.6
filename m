Return-Path: <linux-kernel+bounces-175735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE65C8C2439
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918FA28BAED
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD3F173338;
	Fri, 10 May 2024 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hoIFCxP2"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302D11708B9
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342390; cv=none; b=iDiUHgUSJDfKT7+G5y2+gZ5nKEG/lWLhlC3kX+72xqkLMcB3jZcJYET4J9NS/mjr/wuJt6w9ShJdRyvibOz6oXkYRDQpsXQyT6t4jz1iYJGWsgJ3L1SBz2o/Gckij0PLS/cIXUOgtBZqrfuqQBJcGQ24Ui0v/6DW/m7jzggPIss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342390; c=relaxed/simple;
	bh=F6LVDFMYAmM7JcjujCIXWZBP4TC8w8mBfjUWcwOJmNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s1nf3lV5jv3nphN/b7EXx5y3FfcVc44pMEdkwVbRvLnd7exKP6g/jy0E4w+6bVTrsrak+5rGXtrlqUt4bruqUSXyI1tTngwEzpFE2LX04+1zXnMYVHlqR/bXYZFXx6J35RGvM/ig11Ynkme+GPEWcqLAhP9/Nx1Bgs4CLJTJpmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hoIFCxP2; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59e4136010so478046466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 04:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715342387; x=1715947187; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1YCAIvPNRaWCiuoixyBepvQGa1SGEK7bmvVw2e9ptmQ=;
        b=hoIFCxP2mwmnZNeX8Rr/24MBC3D0tr2YbnomDy/iO+qPaFb78U0cSpgc24VRABU/vv
         pTdyUv7cxczi8yamc0uNH+e8yTX7w7xHrvs/ixy/EgfUqsUdki/u7mfIW4O0L1bI5L3g
         jJJFnFP60mrZkKyXpSfSKbO+4kJRs5Nts85j1lFA6Hydw7hCrwn3o/0pwle296HqnSEn
         QLFjOgLvPzqnrkmp+aqUIKhB6AS8uzpbqyp8eWmZ+6OF/BiyX+7rnwrv9UX9wZeTxxZW
         0riFdfmZsTGiEJUi2CrHUTU8xAkXVK1qV/LvZWndVelll6N8soRqug12qRL5b0A2fAw9
         svng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715342387; x=1715947187;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YCAIvPNRaWCiuoixyBepvQGa1SGEK7bmvVw2e9ptmQ=;
        b=V5BNWi6YlscP3AE4HtJAoxSYFSh/Vw8PKhPB4mVZYDLNvbXHjhwLYmVUVhAAkE5DdT
         CyJpOca6OpOVyreWAiwrRpfEoPuOQv1ZJ5TbsfZKtIRXBpjdTzP+kXJnfoM2L5Bi4Eg0
         wGa5c2uU8dSvz2s4nOeylyzoKrRTFV0QqyEwvbFp6Kv63WCMLTLb7CllO8crUsZPFxc5
         gYUVtd5utfaaCij2kTN0Z8f+Inf5l6N4kQEilGV6oAOXxC/+aLQywK3ZXujsKtJWiaEA
         NFtEwyg6QJaU3hjDayZySxlSOcyJwnWqLxwqcr4J/IlHxnhM6wi4iH0/eFSVKb8wZT4b
         vY5g==
X-Forwarded-Encrypted: i=1; AJvYcCXPcRbU+a9FtKDZHnnKuRJfqzmQaqgmflFDhlzqycAmExzlDvZyrMa93G5LMY5Nj6NGPV+lnFkJ1pXzmlMqxlRmDzGUq9dnRJPht5Aj
X-Gm-Message-State: AOJu0YywGFnJfsUEnaMlUjnZ4mx6rq2bmCSpQj3EnkfwsLXaRc2cs+3w
	Lbh9oBCIzVn4tkgbd7hyG4AaCbPOfEdqYO7E5fT5ACJNGCTk7+LvCZ53PH8uUPE=
X-Google-Smtp-Source: AGHT+IG1bLjKOe41AMRsBmA5uo/6L3/L2uOpaPU9NQ+8MTiil1v575HvVjy/jkMYVI19AfvIYu4f7w==
X-Received: by 2002:a17:907:78cf:b0:a5a:1b60:7cf8 with SMTP id a640c23a62f3a-a5a2d53af8dmr143767966b.15.1715342387555;
        Fri, 10 May 2024 04:59:47 -0700 (PDT)
Received: from [127.0.1.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7df7sm176795666b.111.2024.05.10.04.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 04:59:47 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 10 May 2024 13:59:33 +0200
Subject: [PATCH v2 10/31] arm64: dts: qcom: pm7550ba: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-topic-msm-polling-cleanup-v2-10-436ca4218da2@linaro.org>
References: <20240510-topic-msm-polling-cleanup-v2-0-436ca4218da2@linaro.org>
In-Reply-To: <20240510-topic-msm-polling-cleanup-v2-0-436ca4218da2@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14-dev

All of the thermal zone suppliers are interrupt-driven, remove the
bogus and unnecessary polling that only wastes CPU time.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm7550ba.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pm7550ba.dtsi b/arch/arm64/boot/dts/qcom/pm7550ba.dtsi
index 8b00ece987d1..853a1d83a7f0 100644
--- a/arch/arm64/boot/dts/qcom/pm7550ba.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm7550ba.dtsi
@@ -10,7 +10,6 @@ / {
 	thermal-zones {
 		pm7550ba-thermal {
 			polling-delay-passive = <100>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&pm7550ba_temp_alarm>;
 

-- 
2.40.1


