Return-Path: <linux-kernel+bounces-286900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D924E952028
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8467C1F221DA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6974F1BB68F;
	Wed, 14 Aug 2024 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Z0l8CPeQ"
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64561B9B50
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723653451; cv=none; b=QuqJA26NR/dMLA+BarvVyHZBGi71VfVyK8wGXCvY4F07ZMG1I0S9x7NxU3tZ6sRG6YffEhVhzmcFlVjrUBk/1+l8CRs+mGCtEy03VR3Q8LoHHUDsQYByLAMBrA5dV/WqdFXNnvihwSOpGiHl6ws9kIN+ioKAf+BlDFXE+0y6gCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723653451; c=relaxed/simple;
	bh=WcfJ7WTdADIYYkRPneqkHpbRz7chEfpxWxFcF+Q7f1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YsqJBDgTlSzBnupIWE30LjGH4neSWG/wJDOUwfL9/7Lm9A907vtCxdYrD12THFM6HvC8Nx7EuTHx2a0iJMj+dwsU6hafzQxL9vwIBkcjvCczXMKztWFe3+Ah2dFaoIhtoS+shKU4n68UerIxu2SeZZn+FqPpk4dv8SLNbIvn4yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=Z0l8CPeQ; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240814163721538bf6f4234f7eb202
        for <linux-kernel@vger.kernel.org>;
        Wed, 14 Aug 2024 18:37:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Pv6R5qO6OHa9npCqyOnvNhJtNg3sOz/iholMJCquoQM=;
 b=Z0l8CPeQrOjlcr8qsS/eeP5WPK+o470b9HDnCa63Yio78q+fEXuZSl3j7BStspKtB+yshn
 QLTD0GymGotrNlowfuXfxSF5q7aZP6oBRsmisb5RvYUEfX+h3JeNTsHOmy9MjUNSW+AzximR
 FeHMVlEJRnXwM/humc/MdfF/c1JEbgyh+R3niXZWs3v20NqYvcBJvDp/RVZ1kVfZDTab0wZI
 xvyTO3nf6COxzHIcP4Ucd5zucjOOzkMCtRUSY9iaAR78jJMe4dsZytrrrTj95JsPgssz8kfP
 +0/+U8c+B42I1gWO5dNgXyu1c4v5is0OvkRdz+rZGdcOeLk/Iq2FNHUg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>
Subject: [PATCH v4 3/3] arm64: dts: ti: k3-am65-main: add system controller compatible
Date: Wed, 14 Aug 2024 18:37:19 +0200
Message-ID: <6bc56e6394f52f90413000496096cd10bcdfca5a.1723653439.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1723653439.git.jan.kiszka@siemens.com>
References: <cover.1723653439.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

Now that the TI K3 AM654 system controller bindings also cover the usage
in the main domain, add its compatible to address dtbs_check complaints:

  k3-am654-base-board.dtb: scm-conf@100000: compatible: ['syscon', 'simple-mfd'] is too short

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 06ed74197f89..a8664b246795 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -471,7 +471,7 @@ sdhci1: mmc@4fa0000 {
 	};
 
 	scm_conf: scm-conf@100000 {
-		compatible = "syscon", "simple-mfd";
+		compatible = "ti,am654-system-controller", "syscon", "simple-mfd";
 		reg = <0 0x00100000 0 0x1c000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.43.0


