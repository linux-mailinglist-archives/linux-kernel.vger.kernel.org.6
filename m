Return-Path: <linux-kernel+bounces-315741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F3D96C661
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC261C24E8B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D171E502F;
	Wed,  4 Sep 2024 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VyjnTvYV"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764E81E5021
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725474426; cv=none; b=m/g6tqBnWNg2SEvVKDL96yszovm9kFGvnu86U+Gjv8f+UECKuXnVsXA9Y+6uKKvcWGUWTdUPM1Gdp4cj52+Pt3jNTvVPDRlQjE3Z2NDsjAck1Pp2EqH7sc4s6SDhVn6pBj7MGXVffMcPMKWFq0g3VCelw5wcB/W66yjw0XEct1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725474426; c=relaxed/simple;
	bh=4i4pYCDdnuvoC9I5jRbdWBqJ+VIMP5XqmpcmNhFgHRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GbFxiavcx2cyy84xmy4pBi/0gL+p7pOemQ6FjWQMgaeELFqZnhB2rlsV46J18y/Fl2RvRf7phH5JQYx3DQgzobYb9R31saHkT70t4N+tadztVjxqiFtkE0sBou4SKUMmlY20S5ykoK++JdRZzmfX12cvNWZDW360ellbpblMoPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VyjnTvYV; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7143ae1b48fso4160895b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 11:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725474423; x=1726079223; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kGkCTIAzVa1IW+ahJzXvZODyf0r3VDtzuI/PWkUEWZA=;
        b=VyjnTvYVmP/wbN/+1NWzA2NyA11hUPf8A5FqRdCuYoFtVloe8b9cIuWLpFEvyA4ImT
         aN9FTwzNd9XfwFNV23kp6C+cdrirELO4GCHqJDxVdwZ1TD9/81jTI8fb6QTw7CTKy58v
         Au0DqGwD03RPWQeQiib/4OCrt/k/C0ZraI2UwYDabbVDn14SA8H94S6WdzMwujndz14B
         ch7I5ehVcbkAaXDvRrWAwQ1IWRMT1+3wUnpSgKLp06HQwXJyf30beyr5EMZFXpcdszSU
         u3FmBCNcinReBCdnpkRM1LPk5TUJDGF3aIT5pzy+j1MhwOnHvdLSbofzADVGQk+Eobe8
         OSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725474423; x=1726079223;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kGkCTIAzVa1IW+ahJzXvZODyf0r3VDtzuI/PWkUEWZA=;
        b=Leofz+OBItRbhwdBo+0eIA2lp7O2VPsUyoAu4cx+qJ3rEhxW0hvXRXpv9k9RCB88fj
         mXg1Yb9YaEBEs6Whkyrmo/SkDFBPP+al7jThw5+iXbXA2HVhJB+EvCJNtd5zN+XaKOWS
         QwSWjsOMaGP4N4C0uTfb+XFrUVXsMaBS0bZb3iKf171aBC/lrVxsaMqR26ltgWUVU+aw
         CZr+hACRkHz3WyfpogWxifLN9zl87oI3+U4rzR/kCbgacPpB3YKJwR4uBgMQuoA46buf
         ifE1sbQDF92SFsTBLNsiyVp6+AZy7Jq7nctoTrTl3SC6t+O1V83xWrP2YN6Lx/6KvmXK
         i3cw==
X-Forwarded-Encrypted: i=1; AJvYcCVIuRhWLGaWhtxgykb8HQbObiqfFRaGmTAB1tT1B6aMaVf/9DNH6SJi02lwlKYJHESJAtbupTSXWnUvdLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2irPBgMMdQye7dqYShwrnPgThXqyX+HYCUIp1LX/UX7o6nIq7
	O0U3j5XVoRq4Y+C8nb/DHAJQX700ZNhEeHuBpH8hH08eiQ0/jMHS7j1wUbsEyFI=
X-Google-Smtp-Source: AGHT+IG52B8BQjRrNv57uHEeOO2MVWNcL/3nwz38Ns+yt3hYyX35+L9xCIH8/3nref0E0a8VrRTDRA==
X-Received: by 2002:a05:6a00:ccb:b0:70d:3337:7820 with SMTP id d2e1a72fcca58-7173fa40a69mr15553646b3a.8.1725474422642;
        Wed, 04 Sep 2024 11:27:02 -0700 (PDT)
Received: from [127.0.1.1] ([2001:569:fb4d:1a00:31ea:aefe:856f:94e1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71778534921sm1919787b3a.76.2024.09.04.11.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 11:27:02 -0700 (PDT)
From: Fabien Parent <fabien.parent@linaro.org>
Date: Wed, 04 Sep 2024 11:26:55 -0700
Subject: [PATCH] arm64: dts: qcom: msm8939: revert use of APCS mbox for RPM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-msm8939-rpm-apcs-fix-v1-1-b608e7e48fe1@linaro.org>
X-B4-Tracking: v=1; b=H4sIAG+m2GYC/x2MSQqAMAwAvyI5G6itYuNXxINL1ByqpQERxL9bP
 M7AzAPKSVihKx5IfInKeWSoygLmfTw2RlkygzW2NmQcBg2eHGGKAcc4K65yoydbT35q14Yc5DQ
 mzvrf9sP7flW610ZmAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca@lucaweiss.eu>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Fabien Parent <fabien.parent@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1424;
 i=fabien.parent@linaro.org; h=from:subject:message-id;
 bh=4i4pYCDdnuvoC9I5jRbdWBqJ+VIMP5XqmpcmNhFgHRw=;
 b=owJ4nAFtApL9kA0DAAoBZODx/PMGSbYByyZiAGbYpnTqIesh9v/HtU5PVilt98a0lO6fsZmLU
 Mnd6de0p7L4DYkCMwQAAQoAHRYhBP2jn9nT5J9GAA1rNWTg8fzzBkm2BQJm2KZ0AAoJEGTg8fzz
 Bkm2vkgP/j6e8BszZSdMLWgtVN/lpEWATxCgv+jCPkifvn/53kOBGW/dfF+le+fFGHjn1gc+UQ9
 NR30DoP97WRCuq348fvJ2maE1/kGJl6PumwjoTXB47jIx6QLBXKPzEHocsOuSd0m5oYTfy04U5s
 r7ZrOgoIF93sFr1QZv259aIAyT2D9SQEneWgICyR0mwq0ySAMO6vQs/QmXeObCLEqEM/z/DxIdQ
 hokL6/7PjR7YrrPaqXjqUa+OYGxfPV1VzLulqRfwIwIydaACfIVrGUuofMbUSAnnXmw8LPPZbW2
 tMHJO7qNIZ+Idqny91vDh/O4Xh7gz2u8mOKTdDniwyXSrIVx63PhG7NYblxJC0wcDRGRJzb00Px
 kf7eqfHPSz+grkI9svXltQor6kK0E5KSiqEGlPVO02H2ojtL/OuivvLQ0UBsFDaIkUMtHW/F2Ai
 Y8jayM0ZAmclpUzteoJxuNqE9WTJPaGYQS3FYE9SaX6HPdYYaBi3XveWkO3xxNCOK99Yu0pb2Uy
 Vs4BQKlPEgwrZSklu0G8/TtYqtWPmfR3IomT76FLVzvw5j8Lh/5lq/gOmpJuDBuwd06aY4BSxaJ
 RGGVDyV6VFsIlGznNP0MBU3nDW74jv00EqOi/5a9Ao/gH783LJfT8XH0LNbC1Z5mjtVlcVyRoNs
 H+yzl+Q/rbMR+nZmJPJI4dA==
X-Developer-Key: i=fabien.parent@linaro.org; a=openpgp;
 fpr=11A9B68923ED03CF691FD70BD87F4F8165D79CD7

Commit 22e4e43484c4 ("arm64: dts: qcom: msm8939: Use mboxes
properties for APCS") broke the boot on msm8939 platforms.

The issue comes from the SMD driver failing to request the mbox
channel because of circular dependencies:
	1. rpm -> apcs1_mbox -> rpmcc (RPM_SMD_XO_CLK_SRC) -> rpm.
	2. rpm -> apcs1_mbox -> gcc -> rpmcc (RPM_SMD_XO_CLK_SRC) -> rpm
	3. rpm -> apcs1_mbox -> apcs2 -> gcc -> rpmcc (RPM_SMD_XO_CLK_SRC) -> rpm

To fix this issue let's switch back to using the deprecated
qcom,ipc property for the RPM node.

Fixes: 22e4e43484c4 ("arm64: dts: qcom: msm8939: Use mboxes properties for APCS")
Signed-off-by: Fabien Parent <fabien.parent@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8939.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index 46d9480cd464..39405713329b 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -248,7 +248,7 @@ rpm: remoteproc {
 
 		smd-edge {
 			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
-			mboxes = <&apcs1_mbox 0>;
+			qcom,ipc = <&apcs1_mbox 8 0>;
 			qcom,smd-edge = <15>;
 
 			rpm_requests: rpm-requests {

---
base-commit: d8abb73f584772eaafa95a447c90f1c02dba0dec
change-id: 20240903-msm8939-rpm-apcs-fix-8924b8b7f593

Best regards,
-- 
Fabien Parent <fabien.parent@linaro.org>


