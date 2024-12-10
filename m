Return-Path: <linux-kernel+bounces-439463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B01D99EAFB2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C1C188B4B7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158592253F8;
	Tue, 10 Dec 2024 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsTkJWQF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B89C19DF47;
	Tue, 10 Dec 2024 11:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829333; cv=none; b=OPf93M6D10kmWUUvH0PUkWEHZ6Z7ecnccTwbiHYrw/XECvqAp7yLxU0UBn4yM7WyTK1QEegZOAEYeawoBJKWpYNYNbI957b9wlKToN+harab1h63cS2Z4fPrvh3QjFFnbHjaTlMY5mIu6xPPf14Q7jZ1dILdBa6ut76GuzRyaOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829333; c=relaxed/simple;
	bh=jdcd1UtGAai1fWkfFvIjFbaFosjgIwsdkMA1Odz4TBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BjWjdBkMRftLVSlfD5M+VrhvW2EpUNX9KokVVIHbRczb9FINWGwtexVi003eAEtVzAkUxYuhPf1PRby5rWrqdzI9cO/LIBOZg/WdKHSqsUueGg7Ib9W61l/V3roCMhAyDLenROoTefiCUdmIG44IznJC8V0mAaxZBA0xiEuiRxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsTkJWQF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E923BC4CEDE;
	Tue, 10 Dec 2024 11:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733829333;
	bh=jdcd1UtGAai1fWkfFvIjFbaFosjgIwsdkMA1Odz4TBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GsTkJWQFLMDh8XT2TNa5sRDHFrEk7swEAJNd1uWiqBm15nzHa4xdoe0RcG+aky1LD
	 6oEq07JV/XA/37WYHwsL72a66D9qaeoOnOdx6wun0CtT4kd1WebewtGU6EJPNEHPKb
	 nGJNGxodstAW93jUftu5ogS0S36EZuAoiBgrI6HH61QdtnynUcKbB9Te0m7KhqOsUC
	 AAs4RkQjPZqb/lywENU68w1dLXSKVXAVJr1hBmF49ImQhnz2YkCBoHE/LKwA3L1EGX
	 u1UfocytMG3ezmLtu2K1OjPWDI676DYsbO53R+kqI1OnnlonyLofy2L1DOZ34zJbbM
	 bfWE5k/Pg0Q3g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1tKyDH-000000006qo-1i6i;
	Tue, 10 Dec 2024 12:15:35 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jonathan Marek <jonathan@marek.ca>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 2/3] Revert "arm64: dts: qcom: x1e80100-crd: enable otg on usb ports"
Date: Tue, 10 Dec 2024 12:14:43 +0100
Message-ID: <20241210111444.26240-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241210111444.26240-1-johan+linaro@kernel.org>
References: <20241210111444.26240-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 2dd3250191bcfe93b0c9da46624af830310400a7.

A recent change enabling OTG mode on the x1e81000 CRD breaks suspend.
Specifically, the device hard resets during resume if suspended with all
controllers in device mode (i.e. no USB device connected).

The corresponding change on the T14s also led to SuperSpeed hotplugs not
being detected.

With retimer (and orientation detection) support not even merged yet,
let's revert at least until we have stable host mode in mainline.

Fixes: 2dd3250191bc ("arm64: dts: qcom: x1e80100-crd: enable otg on usb ports")
Reported-by: Abel Vesa <abel.vesa@linaro.org>
Cc: Jonathan Marek <jonathan@marek.ca>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index 199f6b42aa11..66360390ae7d 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -1840,6 +1840,10 @@ &usb_1_ss0 {
 	status = "okay";
 };
 
+&usb_1_ss0_dwc3 {
+	dr_mode = "host";
+};
+
 &usb_1_ss0_dwc3_hs {
 	remote-endpoint = <&pmic_glink_ss0_hs_in>;
 };
@@ -1868,6 +1872,10 @@ &usb_1_ss1 {
 	status = "okay";
 };
 
+&usb_1_ss1_dwc3 {
+	dr_mode = "host";
+};
+
 &usb_1_ss1_dwc3_hs {
 	remote-endpoint = <&pmic_glink_ss1_hs_in>;
 };
@@ -1896,6 +1904,10 @@ &usb_1_ss2 {
 	status = "okay";
 };
 
+&usb_1_ss2_dwc3 {
+	dr_mode = "host";
+};
+
 &usb_1_ss2_dwc3_hs {
 	remote-endpoint = <&pmic_glink_ss2_hs_in>;
 };
-- 
2.45.2


