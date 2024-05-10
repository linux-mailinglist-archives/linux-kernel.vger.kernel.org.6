Return-Path: <linux-kernel+bounces-175835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6B68C25EE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77ABC2844C1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5EF12C49C;
	Fri, 10 May 2024 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X0f6tCSf"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EAC12C47D
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715348406; cv=none; b=BMtdcUEw7wUEATOXGaQ64+p/EzUMCLzEaPx5V/eq8RZVUHwWhU4O254KkTPmaeE2Clv/SqlGez+Lx0toUf3oquppDV8zVbOb74XlfKDvYm7W1GzLRf+iOIxYXHf8/ZgyilCe9TkrT6gSwdgGO8H3ww2TEoZ/84R6NzqZsArHYz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715348406; c=relaxed/simple;
	bh=G58itSBLMxq7Hnti9OjMcpU4zbraFRoaHyfISMmS3dQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pOrdoZ+Ysifk5IdlFTaoTtnm63ddThr4U/JxoNNMZ+3/4rE6vj3+qZB3sCpMFmotCHG90WxihXKmaLioEvMi52pOLAuE0rSPfHUJFPSeRBjnnC4XahUAyQaxMbQiG3fcKk5Agc5m4zzHmDr0B3u4ULRSAH72YbK63yLWe/lJ40k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X0f6tCSf; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a5a0013d551so234735366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715348402; x=1715953202; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ha8fz4Wr+IwPLlSAFxnrozj260YrkxhYC7xfmynUBWM=;
        b=X0f6tCSfcKBxVAOAq0Qp98kKvEn/7k+bCYBm9fKN8BXzxbqGeD8Fn1kq4ID4iPIRP5
         xWs0Hl+SI1IXwll8JrHLcSdAaMo5xL5Y6Ep1VUmlD5eA3+Xb4dLpASAJhyJe+Tf8FpQY
         6dk9k1vwpff5i2m5/gaoTGAd/MHKEkZZ4QqWj1wKXCgcGcPuXB/ahrImtlwzXgGx81z/
         s5EtRpwcsdaho71vs4NHoHcsb2O9P/B3ZGZAgDAdHpDPa4bI5orbwM6ZCbUqEL9mV87i
         DJzI4eOtGr47gl2Xis5kWSJ6qeaGVWUEmiFRLP03jZGa7RmZB36u8i1DDZeSpCm7yhAD
         iJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715348402; x=1715953202;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ha8fz4Wr+IwPLlSAFxnrozj260YrkxhYC7xfmynUBWM=;
        b=fJqCWSkuhM5g7UV1DAD1fcTGMWRVAzdwwJp66LgCLeyrd2PFRHXA0ulaUnmuFN5bBd
         jHSlTlg7iTCBs4ldwuUdBl2Qp2TYNLy80wndYcLeZbXKpP78x0owVViYFqmaqHX5NX+q
         tf+9hveoeQph7UGVp8DO82DiFx2cIR9Nau1KkAjXACR8KqetedkDjG2fr1W+sxXxQjPA
         Sq/F207bD7d3ZOWlCMrH7XMaLzyuP3OzbYGDzO1E1kpTZjoAIqqiOezrDq2UwlnMsvlB
         58QuhEs5P7nruc76tEeC9qugSucwBAOTVwEtyOxnR50rEcVal9JSwYI0wti7U3tweqnB
         Ixlg==
X-Forwarded-Encrypted: i=1; AJvYcCVWLZeRmjq3/oo+jLO9TEeSsCFI5D46jSOK5k5pFr85zCV1X0JZJCfzhOneTCaiheJVXKx151SQOE5jfpt8A8x1xv2fkDtdNMQpx3V8
X-Gm-Message-State: AOJu0YxQ78qB/OhwYK990k86dkx47dsv2yMbq9vNAYm0GARhXuqJ+fsR
	rGHSCdOR49oXA7mfag0sY31rwG9UXcZqDvb6h3kWRghkcxwlUevaxUAs6pQHjeQ=
X-Google-Smtp-Source: AGHT+IH6BN4juUw4T+/Txsx7VnJHBlBsO2iEOHL3CdD35k1pZqHytie913QnQod0/ipiHQMnPn3xCA==
X-Received: by 2002:a50:9fc9:0:b0:570:5b70:3407 with SMTP id 4fb4d7f45d1cf-5734d5c0c84mr2419289a12.10.1715348401718;
        Fri, 10 May 2024 06:40:01 -0700 (PDT)
Received: from [127.0.1.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d48dsm185200866b.5.2024.05.10.06.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 06:40:01 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 10 May 2024 15:39:59 +0200
Subject: [PATCH] arm64: dts: qcom: sc8280xp: Set status = "reserved" on
 PSHOLD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-topic-8280_off-v1-1-bcc70cda449e@linaro.org>
X-B4-Tracking: v=1; b=H4sIAK4jPmYC/x3MQQqAIBBA0avErBPUkrSrRETYTM0mRSMC6e5Jy
 7f4v0DGxJhhbAokvDlzOCtU24A/1nNHwVs1aKl7aZQUV4jshdVWLoFIKGU6R94M5CzUKCYkfv7
 hNL/vB62AubFgAAAA
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>, 
 Steev Klimaszewski <steev@kali.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14-dev

On most devices, TZ seems to be blocking access to the PSHOLD reboot
register. This seems to be TZ, as even kicking the hypervisor doesn't
seem to make it writable.

Fixes: 865ff2e6f5da ("arm64: dts: qcom: sc8280xp: Add PS_HOLD restart")
Reported-by: Steev Klimaszewski <steev@kali.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 0549ba1fbeea..59f0a850671a 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -4623,6 +4623,8 @@ tsens0: thermal-sensor@c263000 {
 		restart@c264000 {
 			compatible = "qcom,pshold";
 			reg = <0 0x0c264000 0 0x4>;
+			/* TZ seems to block access */
+			status = "reserved";
 		};
 
 		tsens1: thermal-sensor@c265000 {

---
base-commit: 704ba27ac55579704ba1289392448b0c66b56258
change-id: 20240510-topic-8280_off-11539fc57f98

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


