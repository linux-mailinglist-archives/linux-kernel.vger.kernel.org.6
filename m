Return-Path: <linux-kernel+bounces-427125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B459DFCFA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA000B21724
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768091FA16A;
	Mon,  2 Dec 2024 09:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GOMeniLB"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086421FA154
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733131410; cv=none; b=JVEkcFcO4il9t69RT0vBbYV7jFpjEpiaPFJafFnNRnKkfXeBkUfzyTT9RAOB93bLed8bYiCn8OWWkL+a4Y8AH+uQviXJYPvWvjV46YeUx1G16jEA1HavAayjd/qcAHVrOLr07jKRhg6dKf1xAhVMyUyNzbcpnJqeQaT1G6wuhJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733131410; c=relaxed/simple;
	bh=A3r+QOe6Np4QfCUQPaZfHssorye0JJK4Sy3TkMzCgqY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SR40ZPRapgTYQhLBIGbFP3cbePlFw1wXV1uxsNpmIKuDC7fGur3Fq58THK++zhPUZIu8ohRzQQg21kfWUfNKlM2bB10yvEkm+Jh3TNIEezB+jp5rS+qAzQRDJnQAsMBOCUKTY75FfHSQn62fB0r8CgoesITf9vBBMTyzYHDBrI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GOMeniLB; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53dde4f0f23so3853972e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 01:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733131407; x=1733736207; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QwFuu4fYjZZJNMv4MxzvoaazN1Cffk/HJgugwqmFgW8=;
        b=GOMeniLBWg5nodExGYAL/IphWz3dzc3rTh9eM43OynxOGydMie1EBhCTtFs23z+f6b
         Plp4Foy0kww0VXCpNRXcSbtG2ixse30o7tJiKtRQEpalGjtSgqEjR4BDu41bQSDsEZ7y
         YS0ZCfdGV/Ws2CQ8h9sOsKRNclV6nIDfUGHPjvX7DKMj1UXlmwXsDqkO5+2whR4IC+rs
         9WwNw4DA/n+Sh/bgppEjTRoIGDz9FbT+JQ2bLabcnjKF7WBq6TX0IWt4vb5X2Well26k
         VWATlsniCMWGd6mp4beHb1y3WoImQVDFxONHHiKfMwB0/hycEwNyF/gi0PeaSCV/bsCW
         sO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733131407; x=1733736207;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QwFuu4fYjZZJNMv4MxzvoaazN1Cffk/HJgugwqmFgW8=;
        b=gVvmLbRjFlHItE/0OeGQ9kupJRhZq+USgR0W5xJy2+uD7+FAdwzBhGoweBAcNgTP6+
         vYpM3JpPj1uKP43P9WgPafK3P/UEUBSUjwdkGwtqodkryeeUeUfagn/CLFlS+cMSEcNV
         8rvfUbubCFWQvAOB/j5YNq5ugksin/SsYBGwLeN+iVH9g1xet9r7Q+NNh5Tmuc+pz4Ky
         qrprlcyzlFX/T7/THuKtxtOCxC4VnTMCbp467D8fxMdtDn/R0RDYG+YYSlE2c1In7+1w
         hiiNH2OQNYee4GLti5/6q2eugnXcnDpbRx5wCntFb7jSk/8kl+o18agSb8Ib45evteht
         zxeA==
X-Forwarded-Encrypted: i=1; AJvYcCW/8M5wlMZBTOxvZ68GSsjxtBPeFNRa5mnTzXyPoJhIm95dG9LiQ03eWd0nXMrDovqYooiXvqCMoeTFyAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWFCOoEo5VGkGBvUvlCaA9mGsivgVkvsX8flN6UyunjrKfRdOt
	O3n/hnaLFBd5KjUM4NsiYQieqw6Z2Q/3GrvkJBVoVbVOWCwl9HCQI1NnD1ByYPV/3uehP233xSn
	u
X-Gm-Gg: ASbGnctuyx0rrsiRKJlLywCT06AIqd1yn1QTo+ZWweZrT3zk8ptGK4vERtf+zHeIDTm
	xHRDkJqwvbcBlB/tzsz8uGrkc6HJK2K/6yCJI2HLSswNS3Wc3IDIo2x24AeKwyO2kJeQ7qLc2uD
	Y/S+pDdbsAqtkrqQ8gp2W/MB3LtPJvMVZ/tW4gzw4v8wDu4NZqumMa36S3ceziojpHG5yP+park
	KiS1y5rf1xspNLOyDkzCWb9abzCnG70f97iuSHiHIFKpo95Jw==
X-Google-Smtp-Source: AGHT+IGQUKasx5DVEulQmB48IgfBZD18etF9SKhktXSn1/vLHY3A2CfDRwa9VxuQ8IxHa+Sfcm9Ftg==
X-Received: by 2002:a05:6512:1115:b0:539:918c:5124 with SMTP id 2adb3069b0e04-53df00dce95mr11697944e87.31.1733131407212;
        Mon, 02 Dec 2024 01:23:27 -0800 (PST)
Received: from [127.0.1.1] ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385d7264f27sm11014744f8f.80.2024.12.02.01.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 01:23:26 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v2 0/2] arm64: dts: qcom: x1e80100: qcp/t14s: Enable USB
 multi-port controller related ports
Date: Mon, 02 Dec 2024 11:23:16 +0200
Message-Id: <20241202-x1e80100-qcp-t14-enable-usb-type-a-ports-v2-0-7360ed65c769@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIR8TWcC/53NQQ6DIBCF4asY1p2GQWxsV71H4wJkVBIDFKjRG
 O9e6hG6/N/ifTtLFC0l9qh2FmmxyXpXQlwq1k/KjQTWlGaCC4nIG1iRWo6cw7sPkFECOaVngk/
 SkLdAoCD4mBM0jejJ1FrKmrNyFyINdj2pV1d6sin7uJ3ygr/1D2RB4KBl3d4MDXc07XO2TkV/9
 XFk3XEcX60fU5/hAAAA
X-Change-ID: 20241105-x1e80100-qcp-t14-enable-usb-type-a-ports-552ced3b4430
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1336; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=A3r+QOe6Np4QfCUQPaZfHssorye0JJK4Sy3TkMzCgqY=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnTXyH8O+JENQg+ADzguGlqw15V6h2aBa82XZ8T
 ENBUVtvgUmJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ018hwAKCRAbX0TJAJUV
 VmEwD/4s3GECGL49agL3ystNcSB8bWifU6JcscHVeFU/X9J/bgfrBOKSujfLzUZbo+rqY3P2qwY
 A1nl/IkyqLMOAuT2+Lq2ck5U31Anid+r7MGig1RMf9GbhR1iDIz2tVH+BIyhvHKQd6+8pV0MVk7
 9m0/nemh1/VhvKyycC7pZkJ2xS854G8j89zVeC/bAuN+ks7ZEfuOmstJxEJosUskM6xKbwstOJ8
 lVnVzVnG3Rzt2s93HgWl+R0VCnUULkJta9ZEw8G3nvA5WkDkH56XaU2whfENuTjhGJbzSRn9RhC
 8qwoJzp51KpXLJo5XnmqSLtY3cgAxsKRLMzEDtDfY/vEMtRF194v7cofWyMWeFYJiqoJKMApW1D
 Txne7wQVYZMlYkStEZb6zQ19FJEthGitZP8YoIpnr/szxVio6GEnATHmPbJ/T0sFDu/qYTq8DwF
 cfcQjzuCKrfWHO4b6GcV/p1BjzX9jJuOR5Tvvq2tBvSfRiS3+t/WHWihRqhOQWrDQnGyv7YTy8a
 OggqCpvm+16BHKKQ9W3lt46d+TX+MJYfvXHfVZNL07C0SsZJEaleUPU0h4n4tP0iAFaN6UMF4H+
 SFwFspZ5358iAdzUuXwJwDgf6i4QCFnLcmU9eJF10fjJl3tLzhbXn5TzxBbhjz5bVysg0S7h/ku
 K8bn22lLhU3uDlg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Both QCP and T14s have 2 NXP PTN3222 eUSB-to-USB2 redrivers used to level-shift
between the USB multi-port controller High-Speed PHY eUSB2 and the USB
Type-A ports connected to it. The QCP has a 3rd instance of this
redriver but is connected to the USB2S controller.

Describe the redrivers used for the USB multi-port and enable each pair
of PHYS and controller in order to enable USB support on those 2 Type-A ports
on each board.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v2:
- Reordered alphabetically the HS PHYs and QMP PHYs in each dtsi, as per
  Konrad's request.
- Picked up Konrad's R-b tags
- Link to v1: https://lore.kernel.org/r/20241105-x1e80100-qcp-t14-enable-usb-type-a-ports-v1-0-b4386def91d8@linaro.org

---
Abel Vesa (2):
      arm64: dts: qcom: x1e78100-t14s: Enable support for both Type-A USB ports
      arm64: dts: qcom: x1e78100-qcp: Enable Type-A USB ports labeled 3 and 4/6

 .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts     | 86 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts          | 86 ++++++++++++++++++++++
 2 files changed, 172 insertions(+)
---
base-commit: f486c8aa16b8172f63bddc70116a0c897a7f3f02
change-id: 20241105-x1e80100-qcp-t14-enable-usb-type-a-ports-552ced3b4430

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


