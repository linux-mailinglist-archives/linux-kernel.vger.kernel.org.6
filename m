Return-Path: <linux-kernel+bounces-281239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D881194D4B9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72C29B23D0F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2741D1990A3;
	Fri,  9 Aug 2024 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lUQfsgl2"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ECF17ADE8;
	Fri,  9 Aug 2024 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723220929; cv=none; b=CfFpyFjJYoIinM/v44nTli0wloVU4a7zQIm0dDNk10RK39A/AUDGHEJxGiArjh0MkRPbkelT4sUYK5J0QkVqZ8SbhnpgRD1FZwZxlCKOl3NqaIt4gijbPf6lT/3fOGAnPwSdgRutjX2YMqfBzx9XIsXpMSHtn53/ax6qscKEQF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723220929; c=relaxed/simple;
	bh=DldFXu2cbD9iBo5Zp27eMugGNZQm31/8wF9PKxaOF1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=diby3M6/RejTvAknSNGebJ6LBMDYcFjl1swh6Nn9vcnGxocMSsG1XzVxtURzRe+E8G8rf06qp+hFjFQsfi4+SuDgh40C7cVcuyFH+CTJKhmkmOf0Pw8eW6x8mveFilwbw/w/ARX5WEatrMytcYyPbwU2ptRhW5JKM48dkvT2xvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lUQfsgl2; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 479GSUiO081019;
	Fri, 9 Aug 2024 11:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723220910;
	bh=ZNm7VzblJEVzWmyiGoAJ4ArM5EDzo0ZNStb1hl38Tug=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=lUQfsgl2ZTBzebKcEUDWb5lGZd/NrmMU+abcWSzkJtlVxYhm1fz6IpXk5kWI1r1CC
	 UnH+p1J8NhPw11xagnXulhqnaW2d9+DFrYM+av1CRBarRQpvc8Azqm3qGGnnq71jBz
	 gZ8YCNQfn/AGhdmSv/OSMbcYD4XbxnF4T2d/M83Q=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 479GSTnR003679
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 Aug 2024 11:28:29 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 9
 Aug 2024 11:28:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 9 Aug 2024 11:28:29 -0500
Received: from localhost (uda0499903.dhcp.ti.com [128.247.81.191])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 479GSTIf030775;
	Fri, 9 Aug 2024 11:28:29 -0500
From: Jared McArthur <j-mcarthur@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Jared
 McArthur <j-mcarthur@ti.com>
Subject: [PATCH 1/2] arm64: dts: ti: k3-am62p: Add gpio-reserved-ranges for main_gpio1
Date: Fri, 9 Aug 2024 11:28:27 -0500
Message-ID: <20240809162828.1945821-2-j-mcarthur@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809162828.1945821-1-j-mcarthur@ti.com>
References: <20240809162828.1945821-1-j-mcarthur@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Commit 29075cc09f43 ("arm64: dts: ti: Introduce AM62P5 family of
SoCs") introduced the main_gpio1 node and included the ti,ngpio
property, but did not include the gpio-reserved-ranges property. As a
result, the user could try to access gpios that do not exist. Fix this
by introducing the gpio-reserved-ranges property.

The non-existent gpios are found in the am62p datasheet [1] in Table
5-24.

Depends on patch: dt-bindings: gpio: gpio-davinci: Add the
gpio-reserved-ranges property [2]

[1] https://www.ti.com/lit/ds/symlink/am62p.pdf
[2] https://lore.kernel.org/all/20240809154638.394091-2-j-mcarthur@ti.com/

Signed-off-by: Jared McArthur <j-mcarthur@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index 0ce9721b4176..420c77c8e9e5 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -65,5 +65,6 @@ &main_gpio0 {
 &main_gpio1 {
 	gpio-ranges = <&main_pmx0 0 94 32>, <&main_pmx0 42 137 5>,
 			<&main_pmx0 47 143 3>, <&main_pmx0 50 149 2>;
+	gpio-reserved-ranges = <32 10>;
 	ti,ngpio = <52>;
 };
-- 
2.34.1


