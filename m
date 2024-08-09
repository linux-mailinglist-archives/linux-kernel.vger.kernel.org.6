Return-Path: <linux-kernel+bounces-281238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE4794D4B7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1D4281CEB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C211870;
	Fri,  9 Aug 2024 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vz9jJYcB"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE8318C08;
	Fri,  9 Aug 2024 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723220919; cv=none; b=a018rL8fydNwrsZz/NYYHOvF/WRv4us9tBPWj9dPB4JyNsTnY6iKcOP2prSUxB5Bwbbh8UZzL6UXdARNq2pzk6DtsGmmGXftPuF48E2lkCNXMou9XIFBr9arJjyEHOEya7x6vw8m3yP4spYOOC8P1tpyCyxmNtxitK1XxqpSm3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723220919; c=relaxed/simple;
	bh=FyQpl3llzqBuGssaW60gmLWr9FenjyFVL9pbgJKfTv0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mFwk+hy/2zLsLc0yAr1BdE3gK8NR2adc2Zl1nOTXT0asSK4DBdRHbwPiaWHoPWslFEftQGGwOJzOBReEpSDizNPTruuv/IwziUPScUBwFY8DdKvMmeyujw0m2L0biEI7jBbh1iJcnd7zQxAgYpcj5ClRnfVd85kE0hSR2gliWTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vz9jJYcB; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 479GSUC8017022;
	Fri, 9 Aug 2024 11:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723220910;
	bh=Stjc9pEOHDzRXfFji3xn4TMgnmocpeMMpD0DkLTI+Hs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=vz9jJYcB5DZZZ+bJ6b/JpMFhQVy7f690C17zyOiH8Rq6MbrvNubxi0ga/8SDdGrLR
	 Mx5KRACAN+o05n0LdjpJ1e++2HHN9bscc0c3f2uICejbwevajiPs2ftMGW+MvvWk4N
	 qr3cp+xztdgd4aBwEMwA4+LPDLmjTh0uWyEhcEsw=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 479GSUGH026888
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 Aug 2024 11:28:30 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 9
 Aug 2024 11:28:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 9 Aug 2024 11:28:29 -0500
Received: from localhost (uda0499903.dhcp.ti.com [128.247.81.191])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 479GSTiZ030778;
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
Subject: [PATCH 2/2] arm64: dts: ti: k3-j722s: Add gpio-reserved-ranges for main_gpio1
Date: Fri, 9 Aug 2024 11:28:28 -0500
Message-ID: <20240809162828.1945821-3-j-mcarthur@ti.com>
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

Commit ed07d82f9e3e8 ("arm64: dts: ti: k3-am62p-j722s: Move
SoC-specific node properties") introduced the main_gpio1 node
and included the ti,ngpio property, but did not include the
gpio-reserved-ranges property. As a result, the user could try
to access gpios that do not exist. Fix this by introducing the
gpio-reserved-ranges property.

The non-existent gpios are found in the am67x datasheet [1] in Table
5-27.

Depends on patch: dt-bindings: gpio: gpio-davinci: Add the
gpio-reserved-ranges property [2]

[1] https://www.ti.com/lit/ds/symlink/am67.pdf
[2] https://lore.kernel.org/all/20240809154638.394091-2-j-mcarthur@ti.com/

Signed-off-by: Jared McArthur <j-mcarthur@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
index dde4bd5c6645..cadb4f7c2ea9 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -214,5 +214,6 @@ &main_gpio0 {
 &main_gpio1 {
 	gpio-ranges = <&main_pmx0 7 101 25>, <&main_pmx0 42 137 5>,
 			<&main_pmx0 47 143 3>, <&main_pmx0 50 149 2>;
+	gpio-reserved-ranges = <0 7>, <32 10>;
 	ti,ngpio = <73>;
 };
-- 
2.34.1


