Return-Path: <linux-kernel+bounces-295292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A71E295995F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B891F23166
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4B3208625;
	Wed, 21 Aug 2024 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rDmPKCfN"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4524208601;
	Wed, 21 Aug 2024 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233945; cv=none; b=ZJsy4nDAYN76IJ2iKIFn5UF7OMv4UtK2GHXDmD7SuUwT8Bmo9pdrIingz7Bsx19wy+hWJ5kn592yFlNywTWMsYpfoKn3sp8gtibKzpu5UfchaRrdmBhS5XU/zA/SkposL8vyXpUk49T78OTQeif6lbofHq0rPU1yBtf4YAZuttA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233945; c=relaxed/simple;
	bh=aOJqVYjkCKjRN34E4uVrEGNLyEKvzWTf55aGKfxUUP0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=utGA2mlmsFDG57NaPyfBoODaD/pHEi7PKKIKRec1ijUKwWtBizf6qb00t1Q53J0GlIBUZcJDayN436LPyTnlfHPAzYXXLoHJZuJdpmKZy4LGoC8BEmzrnm5hBmYAV6M5zuOBocFc7ffrpZ3cM+bGrCDX3QUVZLaDsgfpSFI6bio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rDmPKCfN; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47L9q50m073168;
	Wed, 21 Aug 2024 04:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724233925;
	bh=+xz2gjid/ZvjoH/nwyiFc7wovd/k1oNrxXbVXPwqf4A=;
	h=From:To:CC:Subject:Date;
	b=rDmPKCfNWV95SgjAjRAtTBDRRELISdzkmTS5RH5A57x2v8WqBGYr4yjNgJQVNv2Vm
	 8vXKkjkRg7zpOxBEA0UhEx1m0t4dIJxMWS8GNeuCwRjdOKBWDADF4ikdNhF9CFu6oT
	 V5Bw2yVx92yfi2Jbsb/O8ppv66i8204UUylXput0=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47L9q5Af023453
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 21 Aug 2024 04:52:05 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Aug 2024 04:52:04 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Aug 2024 04:52:04 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47L9q1n1066254;
	Wed, 21 Aug 2024 04:52:01 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <s-anna@ti.com>, <hnagalla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/4] Switch MAIN R5F clusters to Split-mode for TI SoCs
Date: Wed, 21 Aug 2024 15:21:56 +0530
Message-ID: <20240821095200.3050878-1-b-padhi@ti.com>
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

TI SoCs (J7200, J721E, J721S2 & J784S4) have multiple R5F clusters in
the MAIN domain. All of these clusters are configured for LockStep mode
at the moment. Switch all of these R5F clusters to Split mode by default
to maximize the number of R5F cores.

v2: Changelog:
1) Update commit messages to drop "Lockstep-mode" as default mode for early booted remoteprocs.

Link to v1:
https://lore.kernel.org/all/20240503062414.804209-1-b-padhi@ti.com/

Apurva Nandan (1):
  arm64: dts: ti: k3-j784s4-main: Switch MAIN R5F clusters to Split-mode

Beleswar Padhi (1):
  arm64: dts: ti: k3-j721s2-main: Switch MAIN R5F clusters to Split-mode

Suman Anna (2):
  arm64: dts: ti: k3-j7200-main: Switch MAIN R5F cluster to Split-mode
  arm64: dts: ti: k3-j721e-main: Switch MAIN R5F clusters to Split-mode

 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi  | 2 +-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi  | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 4 ++--
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.34.1


