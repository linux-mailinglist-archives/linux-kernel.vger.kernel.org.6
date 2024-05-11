Return-Path: <linux-kernel+bounces-176755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 703FD8C3475
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 00:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34B5281415
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 22:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFC160269;
	Sat, 11 May 2024 22:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KMyAb/Rk"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6263358AA3
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 22:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715465061; cv=none; b=CbQL7Lj6dln4YOmXkv97by4bcakNe5hKQTt6A6cTFN4avJuLQi/iXE+9rHxw7snNbgk1hGQy4HRzXAVO1EtQa2nUPWac/Z0bz4LKZwm4uOqMte2C0I1yxKBLLuMMleWWgYAzFISH2gvDSecxSEbh75yKIje2HL+IGv6/2n1MQME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715465061; c=relaxed/simple;
	bh=2X9TSF9mpPgpbniBtbr3RQy14gET4Nt7uQSs8F1H82k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nwo1RMUUA1aIkj6vRt+B53JE8CavjAlXmmVrNczlrOEvof932mpvwLXC//YiyYMRnfZ9N70YpsVUb9A0Mko07upNNouaiWpjjI0TEydkRr+b00ti3EXiDWgAp5T7oEBfSoYSk20O982jee9xJ91WRSQ7QNed5XyuJ8hXkpkNDyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KMyAb/Rk; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51f17ac14daso3688466e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 15:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715465058; x=1716069858; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=etPGlhDWRxy2MUXfAs4NBOjvIGN4vsVr90R24B7wpPM=;
        b=KMyAb/Rk548umUTkhXlOMk9BG78XQCAxKV0ddXiPE13EOX+EtSyPs1w3TI13c9qMzo
         +rbhooUOlu2c0B4+g6B+U1wUD1++U3RLPGP2Iz7eGAhLWrIgmDDTL7756SXtLkj6CN4Q
         RCEE4dQIll8+4BRYR7T6/HJCY0KskO7ZpZU7C8/IrN5hztPLANUQf86RPL1bKHvpJjwX
         raUPOLnp8mg6b2+KxuMnifEYmiKGmEueRUMpDyM/MZ+VxBzJoo5EkzoNUHdGD7s6SH9l
         +ozB/qxPw2XZNFcRYSovKbsK4T2dAW5QIhB/TVd/skOIm8mm5vuKRl/BmARaDdnDEDN1
         hY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715465058; x=1716069858;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etPGlhDWRxy2MUXfAs4NBOjvIGN4vsVr90R24B7wpPM=;
        b=cY2naSixi4szU2RdXcR0GiKcFz4josmJMck0SLs+BdkjSo2JIiswvr99crSKNF8cAg
         8DX3lAkVWl9UAbQmU8NQ/BqW5tWJSQdVS/kY1p8gGVe/K2JqLOP9OpGm18RzXpbwaEU6
         EgfSvhtSSbtevg/GJSuURPo0MyPzFAgQFmLVAoiZ7qBzdWY297w+YohL+jeaAbrR/+hO
         Fj9lNXaEZBFzSnm6BzOTftXfGi6YRUPw75DIPkEY1Oe6+zdGOcc+xD/saBj6A1gvWlCo
         ov+536HZ9sG1+Nxxn53ziUyC+EeZDNm10Em1wC2pUvuklp9dC2QWfVOoUJlpb08QMM5N
         sKPw==
X-Forwarded-Encrypted: i=1; AJvYcCV1vwSRq4q6/4Zl5rZrrsHdVjPOxmw0xWwqsNuqIq2wFYmUavlRUzHAuotNdmqrWfDjxfOPHO9UxfTnTRHQFivfW6wGqPof6m30XOF7
X-Gm-Message-State: AOJu0YzRAZEZflMAcVDnzaQCfwEROFmUXZjmz7kg7AesuZACgwbezkJU
	U7t74faVnUXxy7ZkJz13v7kunK3UNX5VEHjDJ/Fm+K5/mv1FaajPA35x0vzFagw=
X-Google-Smtp-Source: AGHT+IG2XsjgS4cbuPJ5ppeA0B7bDqDs6E/McKESaridVAwjhdDKZYdJpZJGBOy7q71GzuMotnquEA==
X-Received: by 2002:ac2:4309:0:b0:518:bc7c:413a with SMTP id 2adb3069b0e04-52210276505mr3128424e87.69.1715465057806;
        Sat, 11 May 2024 15:04:17 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d878fsm1123875e87.206.2024.05.11.15.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 15:04:17 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 12 May 2024 01:04:15 +0300
Subject: [PATCH v4 9/9] arm64: dts: qcom: sm8150-hdk: rename Type-C HS
 endpoints
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240512-typec-fix-sm8250-v4-9-ad153c747a97@linaro.org>
References: <20240512-typec-fix-sm8250-v4-0-ad153c747a97@linaro.org>
In-Reply-To: <20240512-typec-fix-sm8250-v4-0-ad153c747a97@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=948;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=2X9TSF9mpPgpbniBtbr3RQy14gET4Nt7uQSs8F1H82k=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmP+tYCqjWTMqYT9C9MzILCW2xppEsFrszHxcGD
 9qoZpVEtyCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZj/rWAAKCRCLPIo+Aiko
 1bJeB/9dYlm2ImAAYIpoDO3azYyYwVLOLaqOX/SDTnE4+gwhzOpuEqtbY5JiqriY60KKW9ij7/a
 1mxB0aOSWJt2Ky3k53n27tKZ1Crys9glIyen8SE0QNwxhf6Brl7GbxNgW7kMi+i4J93b36eps5J
 FZ8qFpj1BwynxQCkhoU4rbQvJ1TXWGhDTbjRX1+nBhENSy5lY2j5dbgawc74H0qAG6RbUzUM3MJ
 h5enTm7NSR+G40BziJa9JNIQXfPsqwoWX28LRRn5PDx8auXoNhHOtJIhVkykOAdnFv7nCCEvxXs
 Y/fuJLyIAIIueu01Gxgaojt3fl34BbpnN6ohh32m2RW9ZVe3
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Follow other Qualcomm platforms and rename pm8150b_role_switch_in to
pm8150_hs_in. Corresponding port is described as HS port rather than
role switching.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150-hdk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
index 6cb6f503fdac..e9b9abc18746 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
@@ -556,7 +556,7 @@ ports {
 
 			port@0 {
 				reg = <0>;
-				pm8150b_role_switch_in: endpoint {
+				pm8150b_hs_in: endpoint {
 					remote-endpoint = <&usb_1_dwc3_hs>;
 				};
 			};
@@ -708,7 +708,7 @@ &usb_1_dwc3 {
 };
 
 &usb_1_dwc3_hs {
-	remote-endpoint = <&pm8150b_role_switch_in>;
+	remote-endpoint = <&pm8150b_hs_in>;
 };
 
 &usb_1_dwc3_ss {

-- 
2.39.2


