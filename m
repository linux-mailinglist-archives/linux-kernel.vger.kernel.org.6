Return-Path: <linux-kernel+bounces-368260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 518809A0D63
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E612A1F2650A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9EF20FA95;
	Wed, 16 Oct 2024 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4qWeRVJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BC720E026;
	Wed, 16 Oct 2024 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090362; cv=none; b=DWJOSSGpuoCXsX8pqpifV/Xoo8yuqF27YEBLMs5STIZaTUOyXtx+5EyV1Wbf08Hg0jiDQBElftqdWpvW5xu/v28eBt2rRBtUvE261cN5LAGyIdBUa5v4dLSmIyTXTQcmsco7VVaYuSHNAK5OK42trgae10yHYb5MhwyV3U7kPbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090362; c=relaxed/simple;
	bh=uOKZTNjoVoEZ5mi1zcfRv63ZIG/We62Qju3QzFVGI9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HgD2hOdVSF+vlIdvy5OCHjwoEJJpXaY63go66f1eueefn0+E+jSB3ZhK0RByNMqU1FAZ2OYu6lI1Nao01f6TN/clP2FJU2xWLVr6V0it2dpWyc57xe5mfCSCEXhXCIpLghgp6ZwSzrbin+z9IzeSGL0tOEzLkdRuoAfKZObcQ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4qWeRVJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33377C4CECF;
	Wed, 16 Oct 2024 14:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729090362;
	bh=uOKZTNjoVoEZ5mi1zcfRv63ZIG/We62Qju3QzFVGI9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u4qWeRVJz8yYD5FmdhXTPDTwSKq4/zV24HFOswpP/Dar6+uTcFzeAk9EOfjVdvtf1
	 OFuoYigtr0YQXzrZA4epvkTfgZdSpr6o0SYpHrvo7q8QfHHouveceQIb6D9SWeLdAx
	 Kai77FQ4ROPswkjnY1O8ZOW3dFCpyjsZ6sAPmSncb3tpaDbt/uc2f9JZv8NQoLDVkY
	 tuowyxuqdUokzWnRTAEjXAC/JRjtxK0MT2OhZZuT2auC+eOR+boeJpHGLIwXNBhLZj
	 oGep56l6fumUjO6oM901DZpiVlw7+NJdUUY7QIo1XJHD8bs444JJzoO8H+lsluNwUK
	 Pu/LwKg7i4IHQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1t15OM-000000006UR-01rK;
	Wed, 16 Oct 2024 16:52:50 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	Konrad Dybcio <quic_kdybcio@quicinc.com>
Subject: [PATCH 5/6] arm64: dts: qcom: x1e80100-microsoft-romulus: fix nvme regulator boot glitch
Date: Wed, 16 Oct 2024 16:51:11 +0200
Message-ID: <20241016145112.24785-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241016145112.24785-1-johan+linaro@kernel.org>
References: <20241016145112.24785-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NVMe regulator has been left enabled by the boot firmware. Mark it
as such to avoid disabling the regulator temporarily during boot.

Fixes: 09d77be56093 ("arm64: dts: qcom: Add support for X1-based Surface Laptop 7 devices")
Cc: Konrad Dybcio <quic_kdybcio@quicinc.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
index 42e02ad6a9c3..cdb401767c42 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
@@ -164,6 +164,8 @@ vreg_nvme: regulator-nvme {
 
 		pinctrl-0 = <&nvme_reg_en>;
 		pinctrl-names = "default";
+
+		regulator-boot-on;
 	};
 };
 
-- 
2.45.2


