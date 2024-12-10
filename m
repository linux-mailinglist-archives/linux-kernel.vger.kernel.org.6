Return-Path: <linux-kernel+bounces-439144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ECD9EAB63
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6314283F65
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA14E233D9C;
	Tue, 10 Dec 2024 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LW2wX2sT"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A78A232798
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733821682; cv=none; b=H2u0Opftk+Nbpq9rovvymcm5a7GY3N7yjmsYJmly6KzEVk2zW6GHjfs0jCw914MBiPKieu9EL6oEGk2kJzBqS79zguz/HU629t3i6/D5Ob7u/l3gkllNayldKxxwd8OXbkynVfZZVovXqOiyFwzA31jdyMP5ENqivLBwg4wMqf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733821682; c=relaxed/simple;
	bh=f8a6YP7898A5nbgRH34nmqHwJxD6DzRItsrYDVftCMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZxCDuV0dGb/OPiDRC1YtogWMawMSl0tuIfJDCj7RcYyhChBeGY0WmgC8ep1z8zpaFDTfNj8cgH6XtA1Dpd3/rSW/miqHsjAJpDm6BpQV5PAfN/NNVewdJ0tS766U8tdk78LH94ZhTBCeD84Mv1vKCh1rgh5Y4/15U/ly7A76zEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LW2wX2sT; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so357751066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733821678; x=1734426478; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JNG5DDWqWbeE9+V4u1rbd2TE5aGpO9MfSKfIBD447mg=;
        b=LW2wX2sTY4Ml9QUrKbt86NG4YytllDhzBBtvpfRiIQlgTSiv1HdEwDG1H9S3zTfhG0
         ZazNjx+4fGPF4toogT8xtSSEdQdUxev1dr5rn+amfbnx/xW4RREn2fQ9g1ZHdjpXGG9z
         JZ/4YlSytyct7XfpjuAu+EZpdPqeuiyp3BdDueL5bi0qjy0bTJe3nuuKCFowPDsedWFP
         YPe+hLnvws1oK8DziplBE8dOg8IetEdJ6bCjrC3aFpNADHY7gk+zCeKHIKZikEY3tGG7
         UPkf1GudYXhbPy3Y7G0jYi9vLgoOJtf9ue2bZmr9HSDryp9Rk3tdgpZXuqynd4S3nRFn
         XovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733821678; x=1734426478;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNG5DDWqWbeE9+V4u1rbd2TE5aGpO9MfSKfIBD447mg=;
        b=rkYlZV/mrMe4faBAez0Ielu+HZAeYuN+p/wIWW/O5zFc+E8T/USKdLc2pjLJVGbcR8
         lQl0sOmyouiPYA7nFoUoD4pdJp2GUrQKPVWCh9Sq23OKjy6KIWiuc3h/uQVGi8w8SYI5
         zwvdYTiPoS5HQVgpl/LUyEm0YmvrQw3TY5k6he+ZRIgutzkaewCYZV56lqQ2phb5S4JR
         sh4bcEMj4gCub1yuQq+FKcGQcPBD6lXwvJaXeIlm2xPBGXf1AOswLSRs1SZzI/l6d/3c
         W1tu9gCALDS8+k6rnziloWBpA1iJej4nbT6sKIPNEzOaz3Er7Rq+J6e3MZ653KhRH7Zy
         HpvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZvCbEf2hxc2q145fq8umuYbTQZ9ewEa//3rSGXftZ7dEYAaKbTG5qbaKW/T5Hl9yVnhvVbGuUoV73eDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZtHXi+MiChJOhNN5nUJ8yxNBm93OJryKi5bYzWSsF1HmA1J4b
	Mg3v48tD+2RWpEYE43I2jYj6YXN7lrcD2aLamkT0hGKsM69mRR7r3+iMi+VbMrQ=
X-Gm-Gg: ASbGncuMUhJBFfB9mcimX4sLjvrnKTbNF3PGAMPJCjsMv+ERkDMXmSC3iOvXUVFQ0mN
	0c3DAXdiCECWXur33KRCD3WoAFODSIlHehKvcp93rh1rNmVHiyiyd6hSp6jewAP3/Mt1/lMQeud
	yi1Gocov0uadj7/GBYt+liVpnHFCD02glaMINKroZVbtQZ7Ar9cujPd2QBwMHB37kjgV4yNUfHW
	p8Gv9/Y2+VADcaOa0ua0aTln145yAK8/3ZGFxjzNqB26irhObyfj/dkRgnCdN/1Vb4=
X-Google-Smtp-Source: AGHT+IGbAoxeXyH/JN+w5ivWcB1+54UQ8q/Xm1kIJhAJoZYBd9IBRl3UElU3sm4HyFFX9AuwoT8RcA==
X-Received: by 2002:a17:907:9145:b0:aa6:8fa5:f3f5 with SMTP id a640c23a62f3a-aa68fa5f902mr550830566b.15.1733821678406;
        Tue, 10 Dec 2024 01:07:58 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef40:6709:8d26:5167:3c1d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa699618041sm173148066b.81.2024.12.10.01.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:07:58 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Tue, 10 Dec 2024 10:07:36 +0100
Subject: [PATCH 5/8] arm64: dts: qcom: x1e80100-dell-xps13-9345: Fix USB
 QMP PHY supplies
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-x1e80100-usb-qmp-supply-fix-v1-5-0adda5d30bbd@linaro.org>
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

Since x1e80100-dell-xps13-9345 mostly just mirrors the power supplies from
the x1e80100-crd device tree, assume that the fix also applies here.

Cc: stable@vger.kernel.org
Fixes: f5b788d0e8cd ("arm64: dts: qcom: Add support for X1-based Dell XPS 13 9345")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
index b112092fbb9fd955adca1ae8a76294c776fa2d1e..1aec536218bc2c9197410a43adec291a31f9beed 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
@@ -1093,7 +1093,7 @@ &usb_1_ss0_hsphy {
 };
 
 &usb_1_ss0_qmpphy {
-	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-phy-supply = <&vreg_l2j_1p2>;
 	vdda-pll-supply = <&vreg_l1j_0p9>;
 
 	status = "okay";
@@ -1125,7 +1125,7 @@ &usb_1_ss1_hsphy {
 };
 
 &usb_1_ss1_qmpphy {
-	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-phy-supply = <&vreg_l2j_1p2>;
 	vdda-pll-supply = <&vreg_l2d_0p9>;
 
 	status = "okay";

-- 
2.47.0


