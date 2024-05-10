Return-Path: <linux-kernel+bounces-175736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A12028C243D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBD2CB26699
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A212E174EE4;
	Fri, 10 May 2024 11:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="chaiPx2t"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A115172BD1
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342391; cv=none; b=hhSU/HHVKDXfy8ufFeThu/ILGLYlNHmdJUj1Nz2GYC9rKmB0gsAynUBjH4J7N0BxIC60HJNjINbiQ77VZyrcgN5QKL3DC83QRihmQ3IG0iQjYf0NBtnOvnCyu52t71Ic3Ay/kevubEKnWlm3gZML3b6HzpDTO3X9WBbw5eN8hbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342391; c=relaxed/simple;
	bh=KAn+kavu3FsHnvY0/+DTDzbjChWpqLzdK6RSLCjGkL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ho7qloIPRqdSqG8vv8+94ehNLq2zU1NLo3J2khb45JXdT4RFZwuUuHCaarkHLqagoTuhFuJGEEo55k42rybmGsseWUuAYIVIBu+rinhBcV81cISY/0NI2Sr4++9WLpe7IC+PmZDzAlCxYFD29CpVbdI/mLVySS+DMI48Kl1UXug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=chaiPx2t; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a59a5f81af4so475958566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 04:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715342389; x=1715947189; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=upnYxftIQgqA8SAtWvBXJGkDwPY3ijyI82SPZyS/G88=;
        b=chaiPx2tqUs2zKn9q0w5aorbYdl6fVW2gIHZLFj3eu0gzxS8YOpmIYkIn1jft1VWUN
         9ra31Ei923w57Xm5arrqhuwxtbtechvcWMzyhGS/uWThCwOaSlAty+3VVcmk9fdUsHfQ
         Q+vIPYU95XPoBh3zERO0FIgFoXb30URgQNph9qPXT7LepO2iCzeqztssgAPANI35X6Xa
         4Yi14B1qc6kIsZV/AaYnKGycO8vXCyvR7a9kDN3dljmNsbbUYNU1klsD7bzSZZZ7BCOS
         zQsJ6KyB6m7YmjhVFD19I4mSq4Im4CQL9M6NfJxlb6vgn8Jv/frRsdSi/UGdnLpoYnfH
         MT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715342389; x=1715947189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upnYxftIQgqA8SAtWvBXJGkDwPY3ijyI82SPZyS/G88=;
        b=juYobVifXsKHjESkTYpi8AAWfvCGXG2AQ4vh92mpv6P0Ge85TdgjQ/jqVQKYlr2gFx
         zWxCoM6/hKLhyHbcyHuBBMKW3nYYktHvDLCQhcEAP3alIXgGFz2pldVM7RN7oe8fEDDJ
         qybfqJWZfgxjVHU3CPv6KjxM8e4N9Pyk4U0emJlHWaRUpMyvHlmPJ8kiBy5bQMdvIT0j
         V/vU/iFdnVOFyAFlzJI3rXTKFyiIrs84us+x7h4J5vXdYuek9fHUtZoCzpPmejxLOrQM
         xUabuWG7TzGxWtiaEcJdFWuSVfJP3YgZmqe73XOkYxcx9Ux/QBWCBuaoZMe+D+TXsuC+
         T6gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkoYhu61D+ykQQwQBZdhluCWE7Wk0UCkBXVZ4m+CfW0tP0YxgjXMwtLe7oXid7eWPg21y5d20q2e1aWLndpMY9DqSALRf/loRpo8wP
X-Gm-Message-State: AOJu0Yy7maJsQ9kedbNjl+FdWb0sin5MHTV6yjWg0AFN1Og0x8wW24WO
	gm1kLswfFFuk2a7iZsNkopq7D4i+1idkeOfIiKjirbexV17Z74E03Y9QRGBGNYU=
X-Google-Smtp-Source: AGHT+IHY0fWuvCys1QcyAuv+r+TdQfXqlllAZlDO3NVBDN4SQT1xHqodNhNJPz4n3IX1MJ3N5YVL/Q==
X-Received: by 2002:a17:906:6716:b0:a59:9e02:68fc with SMTP id a640c23a62f3a-a5a2d5f193dmr153936666b.44.1715342389104;
        Fri, 10 May 2024 04:59:49 -0700 (PDT)
Received: from [127.0.1.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7df7sm176795666b.111.2024.05.10.04.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 04:59:48 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 10 May 2024 13:59:34 +0200
Subject: [PATCH v2 11/31] arm64: dts: qcom: pms405: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-topic-msm-polling-cleanup-v2-11-436ca4218da2@linaro.org>
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
 arch/arm64/boot/dts/qcom/pms405.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
index 461ad97032f7..3f9100c7eff4 100644
--- a/arch/arm64/boot/dts/qcom/pms405.dtsi
+++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
@@ -12,7 +12,6 @@ / {
 	thermal-zones {
 		pms405-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&pms405_temp>;
 

-- 
2.40.1


