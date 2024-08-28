Return-Path: <linux-kernel+bounces-305436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE91962E91
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87FD01F23A34
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C492C1A76A0;
	Wed, 28 Aug 2024 17:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HGGRjOdp"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3A61AB503;
	Wed, 28 Aug 2024 17:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866214; cv=none; b=s4bCY/EfU6k/3dD/YZPwQu7ig/SwBP9qUNchafB/sjB4hgjzm1d6hCiCW2pC9QkbaRZayX6jlIUkP6bUDM+n5UR7zZCpHw1WndfWWuAALR5yfN+Xt0kbzKnA2Byd62RaR9UPZ1dQzz8SLpYvff5PR7dmEwlEKSWbr1tbFJjKtic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866214; c=relaxed/simple;
	bh=EBaCQmh5MfWBsO874KpZ7AaWZHGXyWMtl0w72UD3h7Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mh5QJSqMNDiYIDHJo9X1MRGyu8cc13JOlbEBgPIIOjhtqcMGWuJUQFbf71fg7lpOd8IFCRWwQU1mmJNWW9ClTQ8T0NcSaoR8liWFSWKl3l1O61JeATLKUMMFn0NENViRaHeXTZoYPrKo1OVEpDQKexH3+IPiratfkaiwZdRz3B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HGGRjOdp; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47SHTvnP072770;
	Wed, 28 Aug 2024 12:29:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724866197;
	bh=2cHV4TFNufvzQ7CN52WS3VIYiP0IE3H1Vqo6YyZ9V58=;
	h=From:To:CC:Subject:Date;
	b=HGGRjOdpMJOrVN6Nous/2p/L9gN9oYnUjm693Thp2ajXlVVEiEv5I0MoaEz3+JhoS
	 g2EicxyYGstRaWK47gzpNdoQtyidWULfvnlEsT4Nk/gD8jLoIKvdXsg15ud+42/VgX
	 3bSU57eFuU6kg3zW04bPX3H2HWSOtGEyXNJNGn38=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47SHTv52026888
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 12:29:57 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 12:29:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 12:29:57 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47SHTug9073490;
	Wed, 28 Aug 2024 12:29:57 -0500
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Santhosh Kumar K <s-k6@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v2 0/4] K3 include entire FSS region in ranges
Date: Wed, 28 Aug 2024 12:29:52 -0500
Message-ID: <20240828172956.26630-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello all,

These add the full FSS region to the ranges properties. For Linux
currently this should cause no changes, but testing very welcome.
Software running on the R5 such as U-Boot makes more complete use
of the lower FSS data regions and needs these ranges.

Thanks,
Andrew

Changes for v2:
 - Make range merging consistent across cbass and fss nodes
 - Add tags

Andrew Davis (4):
  arm64: dts: ti: k3-am65: Include entire FSS region in ranges
  arm64: dts: ti: k3-j721e: Include entire FSS region in ranges
  arm64: dts: ti: k3-j721s2: Include entire FSS region in ranges
  arm64: dts: ti: k3-j784s4: Include entire FSS region in ranges

 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi          |  8 ++++----
 arch/arm64/boot/dts/ti/k3-am65.dtsi              | 12 +++++-------
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi  | 10 +++++-----
 arch/arm64/boot/dts/ti/k3-j721e.dtsi             |  8 +++-----
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi |  4 ++--
 arch/arm64/boot/dts/ti/k3-j721s2.dtsi            |  8 +++-----
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 14 +++++++-------
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi            |  8 +++-----
 8 files changed, 32 insertions(+), 40 deletions(-)

-- 
2.39.2


