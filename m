Return-Path: <linux-kernel+bounces-247739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0A992D3D1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA991C23419
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91190193467;
	Wed, 10 Jul 2024 14:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RwjItfZm"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8A219007E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720620454; cv=none; b=kPMM36sDJhoyfzUXgeWtQC0gz4+EvqjCAYUiOeED0yYQQZaq0jjv2stXRUt8JjCO5GNep8c3/vH+pmawA0ACGR0Up5zkfpRw56SCzegGCFidjNOz91ICt7ChSGJ6eAGB0zV6hzCAATidZrDVpAgb3lIZFZ1jg0QMRMoj4O0onlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720620454; c=relaxed/simple;
	bh=cc9CIi6FXqHyC+RzNiFyiXUQnHUWe7bMpSfnjFA8YDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R7Pi0By/Q/RQWlotjYWsxZpYAuS/2OLvXlRWr7zFZtaBiFaCeSXVUo1inLtQDtw2CoVFAiTGAxi89N9xIKFKtJQwbwjURtiGpRr7KMUCWgo2WW6CHwlC6vCheGN5YP4H8V8uiVS9q3Lai9R6gtrcFuc/o+vHrg6JZ35BNC7eT7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RwjItfZm; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-58be2b8b6b2so8074620a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720620451; x=1721225251; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OrPbTUJ3Ty6Uw7Wpl3J3nMIjvJ0SNXzbgRdLrpj8Nn0=;
        b=RwjItfZmR8T2nX40cB1ewVEL0owyYuzEscXkP207Zi3dio2FCJCmRxr/D4kkvOivLK
         iYzAP39OxnolB26LqU29W8Rdr+0a2ewvdWs1BlhWjSADsH7smb2g/+m9/62iwzolVGjH
         imXGo4vAOlDhJvD2uhe+RFJ+BosEH49JHHdPWp+RYLlGXPNAouzKCPSalntmftYcZn6+
         W2CESmprLiTCVRlqZze7IvCwJk05C6dBGKLChrmBW81iiV8m0iev0JX45u+ZsCl4246N
         kCowxETeCpFPXCGKxQPhe4HZnYNvdSZq6kKX5kgDT0bYe5h8pYbepeG10WBPIb4ZcwVh
         FrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720620451; x=1721225251;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OrPbTUJ3Ty6Uw7Wpl3J3nMIjvJ0SNXzbgRdLrpj8Nn0=;
        b=sFwcMTblVJv9Ds8SnHZNjh9UeH0d1VIbzd6nkJRL0oyXw8PD2Dpt0Dp/PRzTSDqAUo
         JMdi/jJUFt/O+2QYqjZvrAWWYapFuT8RYigjrAu8v20VuoyjFGyJIjkGNPEmaAYTOA44
         +fse/27+qT1mFmqcja+7A5GF8GFh9t1beTopolqoYk3vH/vj0vnUWB+4kw6lrAtm0BXl
         eF7Z6hTNjTYEAj7DElTWeGMcv6nRmzqCvkq1fz3N7gPPch3yAsWCngp1imwz+2LyjOyU
         j+6h8KwtRldVixUDLX//Dhf/Og4UzN4hsmgI4y64lWyg12I3v8CWBdAHUj4rFp7ptc54
         ZIbg==
X-Forwarded-Encrypted: i=1; AJvYcCXCtu52IceXg4p3LYw5BreWGGbcgWfyhVKhBn3t0W9ZsfsGQJiONAH98kF6/4G0G0zkjj21xo0ZnjX+0N13MgMPF4I6/VHU3pW5Y1BW
X-Gm-Message-State: AOJu0YwDdU1tXXlNGwyX+yn4Zh7UJ5bX1pEtROx7a9nxHSmhGnR8n5pC
	hm/ii9/bwrMCHnL4nXcxvjfN6408zcCYhtU7NpSytKEiQ8FeomSgCBFpwNdehPU=
X-Google-Smtp-Source: AGHT+IHurdb6yUA+njBCJHvTGjZgbz0YaqcO15oMamk2z/YBtajmPDVIJgwUgYr/Buvf0dALlsiHgQ==
X-Received: by 2002:a17:907:7f12:b0:a77:de2a:aef8 with SMTP id a640c23a62f3a-a780b8848f2mr489159466b.58.1720620450533;
        Wed, 10 Jul 2024 07:07:30 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6e380asm164919466b.90.2024.07.10.07.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 07:07:29 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 10 Jul 2024 16:07:23 +0200
Subject: [PATCH] arm64: dts: qcom: x1e80100: Fix up BAR spaces
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240710-topic-barman-v1-1-5f63fca8d0fc@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJqVjmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0MD3ZL8gsxk3aTEotzEPF1T80RTozTzlFRDA2MloJaCotS0zAqwcdG
 xtbUA1YTriV4AAAA=
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Abel Vesa <abel.vesa@linaro.org>, Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720620448; l=1670;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=cc9CIi6FXqHyC+RzNiFyiXUQnHUWe7bMpSfnjFA8YDQ=;
 b=FB7jlFH8cVFiVYY2u5QGIChbNO6811dlOa65eIlzsuHli/YWU7ZRgTWY59tnrEiCZ8Y4ETQck
 KNTG4R1PR0kCp1NQGNLNPHEVrduQOM/S/jTZYlcgZf22JiE5hVC/j+S
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The 32-bit BAR spaces are reaching outside their assigned register
regions. Shrink them to match their actual sizes.
While at it, unify the style.

Fixes: 5eb83fc10289 ("arm64: dts: qcom: x1e80100: Add PCIe nodes")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 7bca5fcd7d52..bc5b4f5ea127 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -2895,9 +2895,9 @@ pcie6a: pci@1bf8000 {
 				    "mhi";
 			#address-cells = <3>;
 			#size-cells = <2>;
-			ranges = <0x01000000 0 0x00000000 0 0x70200000 0 0x100000>,
-				 <0x02000000 0 0x70300000 0 0x70300000 0 0x3d00000>;
-			bus-range = <0 0xff>;
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x70200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x70300000 0x0 0x70300000 0x0 0x1d00000>;
+			bus-range = <0x00 0xff>;
 
 			dma-coherent;
 
@@ -3016,8 +3016,8 @@ pcie4: pci@1c08000 {
 				    "mhi";
 			#address-cells = <3>;
 			#size-cells = <2>;
-			ranges = <0x01000000 0 0x00000000 0 0x7c200000 0 0x100000>,
-				 <0x02000000 0 0x7c300000 0 0x7c300000 0 0x3d00000>;
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x7c200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x7c300000 0x0 0x7c300000 0x0 0x1d00000>;
 			bus-range = <0x00 0xff>;
 
 			dma-coherent;

---
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20240710-topic-barman-57a52f7de103

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


