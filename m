Return-Path: <linux-kernel+bounces-317469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632B696DEC2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81C1EB2595C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8821219EEBF;
	Thu,  5 Sep 2024 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NpKJDR3l"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286C219AA63
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725551228; cv=none; b=oJksXbXMsCl5R7rfD7XT+OXgIxozdZ2NRS/ot1ocghyovVkwpQPNasaZGe/zH0hEFupeU8W0zVDqIyDVGBqNgt1We/LCgwYJdBZomogcUFGKtloJ2z9/OZpynmm8hvdsAgvpN3CPdd9fRmvnHYNNnSKZSBIYqJlAsBcjoqClB1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725551228; c=relaxed/simple;
	bh=0yO7hbb3dayID3ZlF0cQWEqp3ZqJ85XSbRDs2pkrO9g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hdiAuIEulLsZ8eQ3nTGz8eNKD2+E5dBuLGYrQvVheu2Bauk4lMmBfvGE+oYZtSqEehDHFXT4YZdOtEE+QH/KJYpNRMtK3qvQuTd4VSO8q8lY9tu+XjkBkvrZPJHUpd4HjblwXz+BhKpt1Rqg4WCYTyk17k55txgSGhhB1k6vf7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NpKJDR3l; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f3f99ccb76so1357231fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 08:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725551225; x=1726156025; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SJTyaRgrMOl8PbZguL4qj4EQ2c2AczsnGuogcfl9yLs=;
        b=NpKJDR3lvHUvrTVPSRPTZgkXVQOFowOnnv3ksg9P16fE9+m0UmwmS6zit93y1o3L8G
         cNGR+X2bMeDxTVE7G0TiWOsNQdyQUnRv6jc1gUTkt4Ol43nc10WzMx63VBfp2gHWNnAq
         KXi+jt3vB9+0NDZXvGu6Ps+nP2ULVw+ZmjbwIOw2Rksb7fYlZXr6y+kg0olyFaLqA2lX
         rFzdjZCTSlj+Fthz4O0tCu563U25LtZ8nm0zGa8yYIzrs8PU/5e/KNPIjeaMwaA64Y0M
         a6m8i9ulZyLVHOIgc0yKTznMd8SRsaOqhVaeHDq1ASGIGEMXO7zVFLc5DSze0wu/wBoi
         zV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725551225; x=1726156025;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJTyaRgrMOl8PbZguL4qj4EQ2c2AczsnGuogcfl9yLs=;
        b=qyPmEBOWF6dKHdoKdqkewpaBD2vhuwVKQzy/vq/Dqu0c4CYYJPGgIKFJeh5iz6F+FA
         VKMlTaWZo2etqWZ4ZxLus6e4hpuOjRbZEbaZ/y8oSX455txXjkvVNCo2tAED+2K6HF50
         axsilJjmOKCHCQq83XahQv48/Ij0CdEd913aRodqKWI5lbPouILKQrv3gB2U3JSeSjn+
         ocCpCabZBpNzp/Er3v2APdV17gnAhrR+hYrXAoARglvba7h29L0Hq+phDpw82Ut+2G51
         Ff2YM36dx9kN8Iktd7y91nzj2ghZ1tGf9VnCPTFFzYA6CG5EbvsoQYZ7wtZCdDJu1UJI
         e3KQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL6/h1MtD7XvipSh/sTufSIH0cApGzL4DfTJb8es79Qosjey+J6eGtEMw72nhyzVYLVp+yQlUMD9csu5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzflNm2xzIrnV7R8GEd+EWDzz+XVIFjaMbWCfQtRPvb6F17mdA2
	i4kXzgJrl1rAKsPtAX6RJH/iO05ODE33+T4zEknrtp62aZaY5k0JeCmDDd75wyQ=
X-Google-Smtp-Source: AGHT+IFdtZvCon6h3HYrziEIBTmekeLoaO+ib8NybkTTFSO+Jamkk4hvFr5Yoj0zlZ5pBLAzaZWArg==
X-Received: by 2002:a05:651c:b28:b0:2ee:e196:1486 with SMTP id 38308e7fff4ca-2f61e08ba57mr82075191fa.4.1725551225147;
        Thu, 05 Sep 2024 08:47:05 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc6a5a94sm1416858a12.90.2024.09.05.08.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 08:47:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/4] arm64/ARM: dts: qcom: minor cleanups
Date: Thu, 05 Sep 2024 17:46:52 +0200
Message-Id: <20240905-dts-cleanup-v1-0-f4c5f7b2c8c2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGzS2WYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSwNT3ZSSYt3knNTEvNICXdNUE+NkwzSLxETLRCWgjoKi1LTMCrBp0bG
 1tQDddZNEXQAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1608;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=0yO7hbb3dayID3ZlF0cQWEqp3ZqJ85XSbRDs2pkrO9g=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBm2dJwW0ghfVrz6hxtHQiVy7nUVue6ntWSNfeul
 ee+aIfAKweJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZtnScAAKCRDBN2bmhouD
 15ovD/9L3RHkekgPsch26mgqTqttCsL09W4tZFPhDzFK56eTfwgooiD9NtF1thN/rWoOyqc4ZxG
 YeR17+VAIT3h6VXTEVPHp4I4+6vGPzml9a1ghEKF60uM/I6fLeh3d/WxAVi5TjvF+T9yO7zfDCC
 XhpGgab3I8HIThSi/YhG5RunBcf27akti0rFgiWCQXJtDDo9LI7Z1C0ba1AxAZiVV7tuPBHzigA
 0EkTVy1RR0a/XytF/6PHNkWfI1SW6cLQeTpghXWTh2qUcxJScXJUSaQxvk8CGfWjosYbt+bOO0I
 VUe7Y+srCz3dYh/tRXKxVW3133o/zzpFUOj8DkiKf1LuU+nNt3WoWktSf+2h46FBBSiaFv+uzvP
 kOm42DQ2raeAP+NtPihcFO6nKlWuA9RthSCGGyh6cl8gr29b9KgUBtVsMqpjuHX+nmInZWL3H1o
 QyBHU/pfae448zrAmMHslsfh8u8BW09a8StNiwOkCgWi0BXIJYZagD6tAm6aYqiILVfo8SYW3WH
 7kQ1pZstKMOwlRvOR3whA68bTFNKLCAKR6X/SXpRV15SZBOFsYXEg/bqBbPv6icGdgmJY6Bhoks
 eaJD0TYLjLoM2nMzQ2HYsSWrYF7G0sFJ+JmYq5+QxdMqQZew4/t1W9yKOVL1S1waa7WX31tpZS3
 UWOP5AQCrpxpZow==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

No functional change expected, verified with fdtdump
and/or dtx_diff.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (4):
      ARM: dts: qcom: drop underscore in node names
      ARM: dts: qcom: minor whitespace cleanup
      arm64: dts: qcom: drop underscore in node names
      arm64: dts: qcom: minor whitespace cleanup

 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi           |  2 +-
 arch/arm/boot/dts/qcom/qcom-apq8084.dtsi           | 58 +++++++++----------
 arch/arm/boot/dts/qcom/qcom-ipq4018-jalapeno.dts   |  2 +-
 arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi           |  2 +-
 .../qcom/qcom-msm8974-lge-nexus5-hammerhead.dts    |  2 +-
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi           | 56 +++++++++---------
 arch/arm/boot/dts/qcom/qcom-sdx65.dtsi             | 66 +++++++++++-----------
 arch/arm64/boot/dts/qcom/ipq9574.dtsi              |  2 +-
 .../boot/dts/qcom/msm8916-wingtech-wt86518.dts     |  2 +-
 arch/arm64/boot/dts/qcom/msm8976.dtsi              |  2 +-
 arch/arm64/boot/dts/qcom/qcs8550.dtsi              |  2 +-
 arch/arm64/boot/dts/qcom/qdu1000.dtsi              |  2 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |  2 +-
 arch/arm64/boot/dts/qcom/sdm450-lenovo-tbx605f.dts |  2 +-
 arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts    |  2 +-
 arch/arm64/boot/dts/qcom/x1e80100.dtsi             |  2 +-
 16 files changed, 103 insertions(+), 103 deletions(-)
---
base-commit: f0c8434c3ddfa4645abd2d2e703193392ec2e8f9
change-id: 20240905-dts-cleanup-5e43c1f8aa9a

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


