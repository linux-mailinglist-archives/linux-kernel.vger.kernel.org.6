Return-Path: <linux-kernel+bounces-267695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C88D5941474
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829E7283192
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BF51A2C1D;
	Tue, 30 Jul 2024 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fWG/LIxM"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C611A00CB;
	Tue, 30 Jul 2024 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722350043; cv=none; b=onVwEh3AI5W2dPQDyNBGe+WXdU9hsPez9in/+Cjla0TEa3OUHg8EydmtKwshEClygyc8OxSDjbFSqw3CPuKHB3ZjvQYwqrvs3haUFJFzrvaXbi6OcQDzHWD9N7tNN5BVEzwFxYViytROaNvhyArrAs8OIHiI1vOuZ7J1oxrQciM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722350043; c=relaxed/simple;
	bh=x5BAaeHjkk+lKClu962uxrP1nFjlgB9fZzFrGKxn1fQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tzEmbnJL6xiKt3O5a0XkXACbMWpJ2Uaj3c2d2tU1BSE33GOxymV0eDuHWYoluQ5uKeqJRyAhj1MObOMNI9SltiHsIguIePT1U6a0U4zPD2S4QEZcGwIwRgkwvN7Bt2MDrTd/HvRhN2xisXe3m1YeuNOCI8tP6ievaAmTktDP1EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fWG/LIxM; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46UEXsGl064603;
	Tue, 30 Jul 2024 09:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722350034;
	bh=BWF0D90J2h4jZsDlwi8UwuzmBVysVZiKD6+jRBfjcKk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=fWG/LIxM0qQkG7pwC3jJ8SzUDNAicUiSfG6ZhEzHe7SJi082bAvO/6//bvLJ2i0Mi
	 ejnuc3+SvYOAh9q51PZCSJcnpfwDEZ2apy0oDTKVxSnE3vZmzdCAnzGfhE9fMjZGtF
	 9rXjqS/xdieTzapHGdEBqzZz9WEPlTk32+W7zkxg=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46UEXsrR032584
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jul 2024 09:33:54 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jul 2024 09:33:54 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jul 2024 09:33:53 -0500
Received: from localhost (uda0499903.dhcp.ti.com [128.247.81.191])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46UEXrOO047209;
	Tue, 30 Jul 2024 09:33:53 -0500
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
Subject: [PATCH 3/3] arm64: dts: ti: k3-j722s: Fix gpio-range for main_pmx0
Date: Tue, 30 Jul 2024 09:33:24 -0500
Message-ID: <20240730143324.114146-4-j-mcarthur@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730143324.114146-1-j-mcarthur@ti.com>
References: <20240730143324.114146-1-j-mcarthur@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Commit 5e5c50964e2e ("arm64: dts: ti: k3-j722s: Add gpio-ranges
properties") introduced pinmux range definition for gpio-ranges,
however missed a hole within gpio-range for main_pmx0. As a result,
automatic mapping of GPIO to pin control for gpios within the
main_pmx0 domain is broken. Fix this by correcting the gpio-range.

Fixes: 5e5c50964e2e ("arm64: dts: ti: k3-j722s: Add gpio-ranges properties")
Signed-off-by: Jared McArthur <j-mcarthur@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
index c797980528ec..dde4bd5c6645 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -193,7 +193,8 @@ &inta_main_dmss {
 &main_pmx0 {
 	pinctrl-single,gpio-range =
 		<&main_pmx0_range 0 32 PIN_GPIO_RANGE_IOPAD>,
-		<&main_pmx0_range 33 55 PIN_GPIO_RANGE_IOPAD>,
+		<&main_pmx0_range 33 38 PIN_GPIO_RANGE_IOPAD>,
+		<&main_pmx0_range 72 17 PIN_GPIO_RANGE_IOPAD>,
 		<&main_pmx0_range 101 25 PIN_GPIO_RANGE_IOPAD>,
 		<&main_pmx0_range 137 5 PIN_GPIO_RANGE_IOPAD>,
 		<&main_pmx0_range 143 3 PIN_GPIO_RANGE_IOPAD>,
-- 
2.34.1


