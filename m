Return-Path: <linux-kernel+bounces-439143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 947F69EAB5F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 550E1283792
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888A1233D6A;
	Tue, 10 Dec 2024 09:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rkMVD7IU"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF6E231CB1
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733821680; cv=none; b=hdlLOeQcJ8lU3ZEeF7ZX1qrxix/NyTYd4aDqQorSj6/VrjfKz3OlY1wsIpxPu62cPHpf+S1Ro6QC7WxcDaB7uRZHHHZgVk8WQ/iI87bQaU/68ptR+ztpKBIcyto+68356zLcXWj++m1pBBXjW+939nh8eMd1IR8LWZORaDXIXyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733821680; c=relaxed/simple;
	bh=+FZI7p90x8pKuXu4wG+Lh/pKwT4cM9Ld+dZ7EPC/XaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CraJQszIiOyG9yWpp9w88sp4MBNeae4vwZceLnqGGPiTe3LLmx3GDsEhtCrT+0TUb42L0QeFBxg1QVt9BQY3vr0AHRnh9GxCg3GfbA7a7k9BFGsrxn5pNSwfRNKkG3vXRr+oZ46OghgJ47QSLhfeJ4Cn9WlR/G06tPWXpp41o1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rkMVD7IU; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so782936166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733821677; x=1734426477; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=efJ++Y02aMYEZf39htR14MgkTrlByWoeM1Gi0XFn3zk=;
        b=rkMVD7IUX3julo9hyuCB0d6T0Ixb6nwXDmiZJ3Ar3j4msLKcYfFs3PyPvZGhHjQ1mA
         zHFgsPkaII0dr2sKqKGcOf3cPkV55DQ5VgByhB+hJXD3a7iCUotfzuhihEfFeoArpkEc
         sPDuiaQ82bI3cyRYPXdCHIUCtVNuWMM8GVIbqcQG1EF2Eio4QDKFvjBonpalTKOMCo4o
         VJDKuqwCUuc2PmB11Ny5SEykCKW9CA98gGgjgsqAUoaH3sd0HKCRRWkJWS6fekNK8jRV
         C5Pch4BcANdTL8Z1gQz17GpcFlDYrWSjtYvEHtKHjjvyZ1y0qeyJwXLwVtw6iHZ0//ky
         CEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733821677; x=1734426477;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efJ++Y02aMYEZf39htR14MgkTrlByWoeM1Gi0XFn3zk=;
        b=YglhNexL+sxExmW2UbJhZ2DOYLy6G5PyYVdu4kna5D5Cw/oujTA7Vx73XHzc4ILpz/
         LCwB676VDQzHd+J+dA4+/KRc5cvmOJ2J/9/mfXfQT+znOPQMZCTKwrQfMUMjurPyVNvY
         09QgmwvsUh/2X9CVxRv6/qR/lrDPjdTw/HTQG5DKLN5qfaz9Y2k85EN59mdX2JOXyusA
         sJKii3ZF3uKzGKyuvG6TVJ7aAYfGFhhYqft4ApaDzpERoQgd7/FCSibjrXnoqjZcJEih
         bdpIlPfBnrrUnMlbMa6hdJQDHDGcMe4TCJ9PRW+VLrYp4ILCn2El1IxsMqfGuCGhcmE7
         SuIw==
X-Forwarded-Encrypted: i=1; AJvYcCWFpfKh9/BNZKzK0N8SJSRLsI6lWgOVjQw83iSOLvTRKqjXvWpIaTwIolm0UxR5YPVb/ZeC3BhGeYl2flk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/jpb4cSIL+R/fjLf7wlcYPj9IX9aa+2APpEXuCvRXfJ1N90UC
	h3i05uJyjuqWf3zAJhyBRAkRifhRhiao9tCTMAWZnyIXXPmwJ9UN4dkAbftXd0U=
X-Gm-Gg: ASbGncv23qKPk9RDLg2BoZv/BVOk4e5ncpqJyng6bQT7VKFZKte46prpc5Ua80MALxF
	E19GSVR12Nm6YFKXHg0PVE2Nw0QM++uzZ/V9pOWAigInNP9hv9N7miKlqhDO1CB3OefVVq6y6+3
	dgxdWQXXIICZMaPq9Zwz3kQv4mGzTH+/rB5u/MOEswHRbHaE3Oo/qCehx8bSFQNGSXNZIbICj9l
	yALgvQS8ui/XetrkM7fX6UjV81NT587dmjmTktacy8UIW8nOY4qfRCEpdd2P6gtMNc=
X-Google-Smtp-Source: AGHT+IHOSLN91GRMFwbfXF4p+jpX74rYIBidttA0YEKYP9pNN983icoBOo6bymBwpvzHTUdD2SCK/A==
X-Received: by 2002:a05:6402:274d:b0:5d0:9054:b119 with SMTP id 4fb4d7f45d1cf-5d4185d5fb5mr8775267a12.21.1733821677437;
        Tue, 10 Dec 2024 01:07:57 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef40:6709:8d26:5167:3c1d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa699618041sm173148066b.81.2024.12.10.01.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:07:57 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Tue, 10 Dec 2024 10:07:35 +0100
Subject: [PATCH 4/8] arm64: dts: qcom: x1e80100-crd: Fix USB QMP PHY
 supplies
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-x1e80100-usb-qmp-supply-fix-v1-4-0adda5d30bbd@linaro.org>
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

Cc: stable@vger.kernel.org
Fixes: ae5cee8e7349 ("arm64: dts: qcom: x1e80100-crd: Fix USB PHYs regulators")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index 39f9d9cdc10d8e79824b72288e2529536144fa9e..401326123db6619552b9ff2b90aa16dbb6649b92 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -1187,7 +1187,7 @@ &usb_1_ss0_hsphy {
 };
 
 &usb_1_ss0_qmpphy {
-	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-phy-supply = <&vreg_l2j_1p2>;
 	vdda-pll-supply = <&vreg_l1j_0p8>;
 
 	status = "okay";
@@ -1215,7 +1215,7 @@ &usb_1_ss1_hsphy {
 };
 
 &usb_1_ss1_qmpphy {
-	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-phy-supply = <&vreg_l2j_1p2>;
 	vdda-pll-supply = <&vreg_l2d_0p9>;
 
 	status = "okay";
@@ -1243,7 +1243,7 @@ &usb_1_ss2_hsphy {
 };
 
 &usb_1_ss2_qmpphy {
-	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-phy-supply = <&vreg_l2j_1p2>;
 	vdda-pll-supply = <&vreg_l2d_0p9>;
 
 	status = "okay";

-- 
2.47.0


