Return-Path: <linux-kernel+bounces-267693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1593494146F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C58C6282FC0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B591A2554;
	Tue, 30 Jul 2024 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qb+ydHEt"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A740C18FC75;
	Tue, 30 Jul 2024 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722350042; cv=none; b=QgDeP7JO6+RQTeBbeUskE7cwyUanzc9/jNgSphdnU/fnubq3QMiNtlDf5CW9MT0/DcyaLAZYH0IN69Bg1+AKSXkH9KEkMokBSJAolg7/rhNrfVpD+GkQpGn9Cb4mu7cJOTq1v/OXdBwwTo6wW3LX6IYqSPPRm4DK93o4klbSNdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722350042; c=relaxed/simple;
	bh=xjYdydy+I+q7N/NmOI7Afr7ky1JfKBzSWSYB1cD23zk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dLmWOTT2bJVgSnru6D80mIHeH9Otu2ZM9+XughL707SgX7gV9EAhow75eFMwco0esYxRWFkSFf270kRJnxSuTegg3iOnRbmWKGX7EIlXB05tfuoDMkfSV4ll+tPMp3+YQZoBVT4eQ+1LCKjBT1bdwwVUXbLIlIqKVXGjUoWQcEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qb+ydHEt; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46UEXsjf064599;
	Tue, 30 Jul 2024 09:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722350034;
	bh=3AsvoSAbdSx9y6CX72wda/8Cj8bIhTNZEropQoEgvas=;
	h=From:To:CC:Subject:Date;
	b=qb+ydHEtbD2vYg/hWmIPL22qTb/qHxcEZ3dve/z85wg8BY/wRCGBZOc5WHWcHUR5y
	 o0T0HqNRVosLYO1z5ZsiO7wGCv+H2ee659SfUYyLDlvX6zEYonZ7KEc0mrVn7g3r4P
	 6nmoNePX0eO7UaB+ov5yqkBcYldhXdThHYlkAtik=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46UEXsBB089670
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jul 2024 09:33:54 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jul 2024 09:33:53 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jul 2024 09:33:53 -0500
Received: from localhost (uda0499903.dhcp.ti.com [128.247.81.191])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46UEXrYu113104;
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
Subject: [PATCH 0/3] arm64: dts: ti: k3-am62p/j722s: Fix gpio-ranges 
Date: Tue, 30 Jul 2024 09:33:21 -0500
Message-ID: <20240730143324.114146-1-j-mcarthur@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

Fixes the issues within the the am62p and j722s gpio-ranges. The
original values were missing some of the holes within the ranges. The
am62p was also missing the gpio-ranges property within the mcu_gpio0
node.

Jared McArthur (3):
  arm64: dts: ti: k3-am62p: Add gpio-ranges for mcu_gpio0
  arm64: dts: ti: k3-am62p: Fix gpio-range for main_pmx0
  arm64: dts: ti: k3-j722s: Fix gpio-range for main_pmx0

 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi | 3 +++
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi             | 3 ++-
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi             | 3 ++-
 3 files changed, 7 insertions(+), 2 deletions(-)

Best,
Jared McArthur

-- 
2.34.1


