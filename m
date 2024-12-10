Return-Path: <linux-kernel+bounces-439142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2F29EAB5E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE612188150E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7B4231C99;
	Tue, 10 Dec 2024 09:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wjyn51r9"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D50231C97
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733821680; cv=none; b=gxu4bEb0+R+PY5U4qvqMeoLcVU5mib+ygJiBkcFfb3eIINiXEB8ImL+GlM8XKnnoa7WqBKdZJ/2ZroVVwTLWK2PGty1xCCSh3UiUf+D3fJNV8M0vwxB8cjfTyPUuHdrKIx9LyGW59U3C+d0JR8uuVyd/dCG7lB/8ILXudeBWMXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733821680; c=relaxed/simple;
	bh=G62QDR9KzGAuOEXgvjGcNdCa05MWSfkst/s7DaSFLxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CECDubXWcvsyaf08crjdCMr7MoUtTmXquQiV7b2sz89wKbo3ujzdgrA6v3OeeBn+qLOwqGj0dj/kT7ycEaNlp/McsZD9eLJwUgHLmvTHEl29ADaU5VuGDBtrMDHdD2RyAQiFhYwGLY3QgiVCNHkDr9AdDLXcs1GxUwbKCNGAAro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wjyn51r9; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3f249f3b2so3024976a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733821676; x=1734426476; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=spfdeCDp4ZwiXNukmisW5nOmm3Xu2k+GZv9IXO8bo4c=;
        b=wjyn51r9C+OuGy4RoyTA9Piof1S1gPG2IKUQgqSWi+k8M0tO/F/D24ap6XrzRpWLCq
         hqNbd6ONnsbVNL28cbiJmgoTJkjaxzYQQZ1+bN2yMHiZC3X1bfmYrPsX+dazbVi/t67R
         9kbRtrVrYTghpaIMSZTXpSd3RGU6YyCAgsNCrlcH38cTuyEWUqCHHndmDO2pLa2fNW4l
         xINN12gE6ETfYqmSAFtHA0RtuTQk5ZZW3GtsufAYnF2wHklTWsvLSpM6lIDCKTI/Ap5N
         pxoyx454Vvf7G7fGhQcPdCLlhvJRI44mMfKdDwEWtM1u7XRGm+Ny3h5Tpe5TcS1S8vbc
         R7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733821676; x=1734426476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spfdeCDp4ZwiXNukmisW5nOmm3Xu2k+GZv9IXO8bo4c=;
        b=iJNvzefzwqgKjyaCm1G8oVeQD/MQfyM2nwzwyX2VSff7cl4e0SJJCg37Y1QpDUIot7
         4zacuRnD8CMS8oyAt0W4BpIxG7n7obccZIUxd45pBUM5II2VvCeJ/fR34Ts4NqmL5+zY
         ECMgYfknyBrLLat8qOM8ZqCF9+TKtSUX6Oie+j3TB0XgYcYiO4k6h2ZYdbJ0NRrdMBfM
         dnDndeZP9TK8w7emMR0L0VVMjlhDFNFZr/aH5zgOPxViSOwiumSfoXkwtkZGcUZ2J3bq
         epEDp73NO/qnDKHOouGuVtm2rim2n3aDO65XfPjZBPBLvwNTHmLz3iSd7Rqr0FgMOWdH
         StWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJxPuBCph98C7XdNtYEQrgRVsC4E0IsFlZAIyYZVpI/SDpm6ym5taHiLagTmcX9llKA403bP3RQC93KW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZXpL2tjnUnfWJiaxCFJrdcATcSqjlvshRb3kaMKAOvy/7YiIQ
	+Os+To5gHfq4sKohC/1urZBMv56UA620ES0awO4nxzpSgYYjF/UznNrV+MyxTVlp3ykVawYFOl7
	F0lA=
X-Gm-Gg: ASbGncucWiRyv66p3uLiTXrX6+XivAEr/UT1fiFxk+9DJgsZKI11FJ95wRQ8lgSHYPK
	Ol7hkI53j4dcf0eUfI1SSt/RAm1N7CzVOyN4WpqSquG5/iv3WYQuz02iURZ0sNCk9FmjtjtzkP1
	RkURpvXIGRNaXlrHzID/rSvRGsium844ThKtnCFeY6WupmWQExai5Do5wDsAvQag0H/Ur3Mvs+7
	JzjGR31Jk1S8q6eXBzD0nm44qxgTE60kge8cj89RqhVmTOCPZKrVreibLfgREC8VI4=
X-Google-Smtp-Source: AGHT+IH7bYRBDYrJ7HrKSF7yLAUmxKHJQ8udj3GCZqmJfB19omJ47klADUOW0EXIJovlwM0emjdl1g==
X-Received: by 2002:a05:6402:50cd:b0:5d0:fb56:3f with SMTP id 4fb4d7f45d1cf-5d4185073d1mr8704901a12.12.1733821676417;
        Tue, 10 Dec 2024 01:07:56 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef40:6709:8d26:5167:3c1d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa699618041sm173148066b.81.2024.12.10.01.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:07:56 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Tue, 10 Dec 2024 10:07:34 +0100
Subject: [PATCH 3/8] arm64: dts: qcom: x1e80100-asus-vivobook-s15: Fix USB
 QMP PHY supplies
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-x1e80100-usb-qmp-supply-fix-v1-3-0adda5d30bbd@linaro.org>
References: <20241210-x1e80100-usb-qmp-supply-fix-v1-0-0adda5d30bbd@linaro.org>
In-Reply-To: <20241210-x1e80100-usb-qmp-supply-fix-v1-0-0adda5d30bbd@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Marc Zyngier <maz@kernel.org>, Xilin Wu <wuxilin123@gmail.com>, 
 Abel Vesa <abel.vesa@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Aleksandrs Vinarskis <alex.vinarskis@gmail.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
X-Mailer: b4 0.14.2

On the X1E80100 CRD, &vreg_l3e_1p2 only powers &usb_mp_qmpphy0/1
(i.e. USBSS_3 and USBSS_4). The QMP PHYs for USB_0, USB_1 and USB_2
are actually powered by &vreg_l2j_1p2.

Since x1e80100-asus-vivobook-s15 mostly just mirrors the power supplies
from the x1e80100-crd device tree, assume that the fix also applies here.

Cc: stable@vger.kernel.org
Fixes: d0e2f8f62dff ("arm64: dts: qcom: Add device tree for ASUS Vivobook S 15")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
index f25991b887de3fca0092c5f81c881c5d8bd71aac..bcb25782d541f43166229695ea1b83ee7b94a6c8 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
@@ -599,7 +599,7 @@ &usb_1_ss0_hsphy {
 };
 
 &usb_1_ss0_qmpphy {
-	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-phy-supply = <&vreg_l2j_1p2>;
 	vdda-pll-supply = <&vreg_l1j_0p8>;
 
 	status = "okay";
@@ -631,7 +631,7 @@ &usb_1_ss1_hsphy {
 };
 
 &usb_1_ss1_qmpphy {
-	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-phy-supply = <&vreg_l2j_1p2>;
 	vdda-pll-supply = <&vreg_l2d_0p9>;
 
 	status = "okay";

-- 
2.47.0


