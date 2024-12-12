Return-Path: <linux-kernel+bounces-443115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710E99EE771
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31640282A35
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821F62153F0;
	Thu, 12 Dec 2024 13:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FBygXNsa"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D312144C6
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734008930; cv=none; b=Hdl/n/U7IVKRNQwSJDepSlnA0jWdRUZLnYl3Kz/o9Zp7KQCx+xhGyH6e+rxBUNkS2aKx3PNzKK2n5LrGbazZdX9g2rh7KRyMrMSBrcnt238VNG8kQeaYpFElZhRkQn4nEDo3Wy5dRBfje/WzfwhmZA+nTl4oL9YpShO2LNj5bzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734008930; c=relaxed/simple;
	bh=uXl2hEmCTQKufHaw3qRwm8b6rrSxvV0DnO8x+QbHetM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oYzLPQE5qxjSHLBBhzv3xOvNe/U5lBeaCpC0Rfe/tCza9seLxB6zXvaahFfpaVrqbiypZ1KVcX0kK4tDblDnMNkiFpfZ/q5v24ko4dC7G9FmSUJWxTnzoyKu9EWzbN5ssaxr/aGf/4uH7yoZSZUmP1BSje1q6S2NuAWukWSa5Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FBygXNsa; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso583630f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 05:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734008927; x=1734613727; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Laarec9Gcg77CSK8knsrpRMAwU44ByomzCcpHvi92jc=;
        b=FBygXNsayRPSRtU8g2upnjxMiyH7vY7IQVm3GFfMVtImtv7do/4mV/DaxwxeGbczid
         BuMVQ2XKVlT6ZRQmb0ED11sQYGt3pi10M26G+RVJpmqX87CGYBIYqGVJSChwVC3MmNX/
         GGh/69V4TduLFfg6AhIcsh33ET+rKS0VqyUJI3ovfv0CJF5HpAq1rmFju12423VQhvBu
         1ERlx9q8k0IjKTr/U327U6BZhXX3Th9HYLaSyy/nYvoY0J3CVGeAjCKDX11QEgnLs3wV
         y6178naeU4eH8gi3ihzRbyWo14xgX72qLF1Dk8E7l6KIdphOUY+csbxCYwRmDoUtlTOp
         GoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734008927; x=1734613727;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Laarec9Gcg77CSK8knsrpRMAwU44ByomzCcpHvi92jc=;
        b=NKwFSS4ooX3i+xtEAirZ/ElrpybY+l9oeMI9Y5pfc7oZRcxSaUClSH0HtyYlS/PS14
         9vG4ADCSPSoZOiwi3c60m2zqYW8wJHQnTCW7O9pe0NitXy/jqu4fmAwDxuhvnQKtDsmW
         OePvRTyU5nlJKptK4RDz0nF2wIOZz2tOHI8/rA/jz++v+dSKCaU3c2Zwx0Z1jH5yNrmr
         Nw/U030oG+5Lleux8J4r2gCLttdRE4zLnyMUgKoEwVc6FAdb85LjsydL6FS2FX8FbXzN
         7RcbQuGh8Kzv/xqsvRlcD5Z2OCaggsZcHSPRo2x/vHUtjx2pKQ/dFRh24R9ssWqbwBmT
         klvg==
X-Forwarded-Encrypted: i=1; AJvYcCXgcs/iZkBlksoXvhDCza6FO2SxFW0roRSnQ4fKaJwfp+uTuOYQJ9LACpj23AHRlGwMbKsmiJeDXOp9/94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/iyTbjv17tWnvb7ZOHkV6ivv3vDAE2EE+UmT1tthaPIOcXuJZ
	H4ABkOJyL8PHbhTvYnPyDIcizQqJh3TnwQxl6tt8+4VpLuCZyy0hdyr5PORpP5Y=
X-Gm-Gg: ASbGncujqL5v/fPoRUKY2jk2m98YeWsku29rUrmII6SqL7I6rWvNc8gDl913gQvIeQ3
	47fMEQBWjlYod142MpKhFagVegiCeXDsUr55IB9Po8ne4emLZ86+RolGaVcD9Z7zF45rHSX1IYU
	xa5XgnRqjWP0SqxfyiRqAioHeGWmSfu/NI6I46JWXwG8tnV/ILDrG7JnmFurPPoH9z2Eqp21ls4
	GHRLBVAhrGpWaJxnG8YE2GBQJEuHTvwq8gR4xFo+bfRBsnNlbY4Y/3OTF5nSPbAuIryBA==
X-Google-Smtp-Source: AGHT+IE278mQiSqfLuj53e2L8BLf2OCaH8QWc+w2KN9nQLaegzE1t3lgp9B26uV3jFUsqIGi89QwRg==
X-Received: by 2002:a5d:59ae:0:b0:385:ee3f:5cbf with SMTP id ffacd0b85a97d-3864ce96d73mr5779300f8f.20.1734008927226;
        Thu, 12 Dec 2024 05:08:47 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef40:3c0e:7a2d:e7e3:9cf8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6845ab4absm605843366b.73.2024.12.12.05.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 05:08:46 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Thu, 12 Dec 2024 14:08:25 +0100
Subject: [PATCH 3/3] arm64: dts: qcom: x1e80100-qcp: Enable external DP
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-x1e80100-qcp-dp-v1-3-37cb362a0dfe@linaro.org>
References: <20241212-x1e80100-qcp-dp-v1-0-37cb362a0dfe@linaro.org>
In-Reply-To: <20241212-x1e80100-qcp-dp-v1-0-37cb362a0dfe@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-usb@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Johan Hovold <johan@kernel.org>
X-Mailer: b4 0.14.2

Now that the FSUSB42 USB switches are described, enable support for DP on
the three USB-C ports of the X1E80100 QCP. It supports up to 4 lanes, but
for now we need to limit this to 2 lanes due to limitations in the USB/DP
combo PHY driver. The same limitation also exists on other boards upstream.

Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
index cc0561debdb0b5c89f5d7f298d34f1feaf183b61..f45df1396eae55896a66e140b7db96c6089fbe38 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
@@ -711,6 +711,30 @@ &mdss {
 	status = "okay";
 };
 
+&mdss_dp0 {
+	status = "okay";
+};
+
+&mdss_dp0_out {
+	data-lanes = <0 1>;
+};
+
+&mdss_dp1 {
+	status = "okay";
+};
+
+&mdss_dp1_out {
+	data-lanes = <0 1>;
+};
+
+&mdss_dp2 {
+	status = "okay";
+};
+
+&mdss_dp2_out {
+	data-lanes = <0 1>;
+};
+
 &mdss_dp3 {
 	compatible = "qcom,x1e80100-dp";
 	/delete-property/ #sound-dai-cells;

-- 
2.47.0


