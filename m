Return-Path: <linux-kernel+bounces-193543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8138D2D8F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732E81C2378B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 06:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46CD167DAF;
	Wed, 29 May 2024 06:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KS5OOY2b"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DC816728D;
	Wed, 29 May 2024 06:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716965084; cv=none; b=Dq8+y/oPjZsjWZxGNRRVCqhyzc2rQW+oZShdSSpg9gySSQrNj8H6Dfh8vl6zm3hWHpQyA+CMdpRMWOYAlBMyd6GXAH2wz4bVCFp8iNCDSLy2gBf2+rsxWiYo1vrF5e5A6q9M7QMlk7cC8upZrXsyYrli+iAqZj6TA2gyF+mw3TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716965084; c=relaxed/simple;
	bh=4zrI1rf96008V1DKuR9GTP2JdgIFtWZq5Ig3JKvzHMw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cujBnUu6ayrKbbryFBknRDlWc+hdbp0dbVtF2zIa89+VZyKq4sonksLGxx6usIxmppvAyofywedbggWsjeVUDjclgfVsfnbBL9oS0S6mQg0V+MTTFl8t0EgaPS2uS5+FFuKyyfX1W0lBfZnM2xDjw0IRkB5Nr9NPPazsO6tTGQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KS5OOY2b; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44T6iMTr018720;
	Wed, 29 May 2024 01:44:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716965062;
	bh=HO2HfuxjQKssJUkJizZ3YKh6FvlnbbPK8XB/o0Bnpeg=;
	h=From:To:CC:Subject:Date;
	b=KS5OOY2btsjnObxJSeW0MLL/PGg721ts2BZppk8kw68ZpkQgnd7aCD8BiEiCjSyvw
	 Blk3mrZOpsdjwC+wDi0XMx6RtB/q3UxoLRLS/wvMmhKUU8sZq6C+E9b3H2ldB8Zj3n
	 aVeU9UbAPjyDjeNb+/vBGFfIDHh/cmhdG02y46u4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44T6iM9A011480
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 29 May 2024 01:44:22 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 May 2024 01:44:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 May 2024 01:44:22 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44T6iMbJ053994;
	Wed, 29 May 2024 01:44:22 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 44T6iLkR015791;
	Wed, 29 May 2024 01:44:21 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <srk@ti.com>,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 0/3] Add PRU system events for virtio and MII mode support
Date: Wed, 29 May 2024 12:14:17 +0530
Message-ID: <20240529064420.571615-1-danishanwar@ti.com>
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

Hi All, this series adds PRU system events for virtio for AM64x and AM65x
and MII mode support for ICSSG on AM64x.

These patches were previously posted as individual patches, clubbed them
into one series. No functional changes from previous revisions of all
patches. Rebased all patches on latest linux-next tagged next-20240529.

Patch [1/3]
v1 https://lore.kernel.org/all/20240423100608.1421652-1-danishanwar@ti.com/

Patch [2/3]
v1 https://lore.kernel.org/all/20240423100838.1421845-1-danishanwar@ti.com/

Patch [3/3]
v2 https://lore.kernel.org/all/20240429092919.657629-1-danishanwar@ti.com/

MD Danish Anwar (1):
  arm64: dts: ti: k3-am642-evm-icssg1-dualemac: add overlay for mii mode

Suman Anna (2):
  arm64: dts: ti: k3-am64-main: Add PRU system events for virtio
  arm64: dts: ti: k3-am65-main: Add PRU system events for virtio

 arch/arm64/boot/dts/ti/Makefile               |   4 +
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      |  24 +++++
 .../ti/k3-am642-evm-icssg1-dualemac-mii.dtso  | 101 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  36 +++++++
 4 files changed, 165 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-dualemac-mii.dtso


base-commit: 9d99040b1bc8dbf385a8aa535e9efcdf94466e19
-- 
2.34.1


