Return-Path: <linux-kernel+bounces-301844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D228995F664
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F77E1C220DA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E155194C61;
	Mon, 26 Aug 2024 16:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ACob5qbh"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C50195390;
	Mon, 26 Aug 2024 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724689381; cv=none; b=QPrSrDCyTTumQ/N2um6PiBrb+SUx3SlcHihQOkEuDF7WMLKUWotf4ujAaiMZFsbgsOBJT8WLdI4ce+ytCWixVDDRk24R7SgjVA7U28aS3sgCFYLJKQCVZ793Lb/5s80+jqmvvcqvT0AV9MS9xdC2PVr5bKWLu7VrpoiEUO3YSQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724689381; c=relaxed/simple;
	bh=FWjimFKnPE49x7sRAndX3Ey/MaahJinRLJmifuFTMPY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n1S7yIeAs7inQLyyu/TW7QTI6qdA/GuNRp4zxFhBh5qdzntBfUBmjo9C4PRfBf1SAdhSzjsQM57PooaOxxE9LEYRkoz18R6WYQcbYR/soORF25rT1O10FWxLLzRB0bSiA4+bLkBEz6HHMMSYRitGqg16uGUdYL582uQ5EFoQP6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ACob5qbh; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QGMpP7025835;
	Mon, 26 Aug 2024 11:22:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724689371;
	bh=9fRONO3q2PiOH6HMDD3rASyvC4hPpHxbSJo0s+2R7JA=;
	h=From:To:CC:Subject:Date;
	b=ACob5qbhgzoSdAMyMAnXGNwkKmIUWldHmyoSGv1Gzb/tLI8vq5FqOBkFBaKfTbyRm
	 g0rovLZIh7180g5KmZCgOXpjqjj0BlkD1xLWmNHcp06ripr8WXIv077RIdVEPYcW9H
	 TdtGKo50YFns6cenca0v3Hj77E/r5my9TWvis9lo=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QGMpQ6019096
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 11:22:51 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 11:22:51 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 11:22:51 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QGMobf058683;
	Mon, 26 Aug 2024 11:22:51 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nm@ti.com>, <vigneshr@ti.com>
CC: <s-jain1@ti.com>, <r-donadkar@ti.com>, <devarsht@ti.com>,
        <praneeth@ti.com>
Subject: [PATCH 0/2] Enable E5010 JPEG encoder
Date: Mon, 26 Aug 2024 21:52:48 +0530
Message-ID: <20240826162250.380005-1-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This series adds support for E5010 JPEG encoder device-tree node for TI's
AM62A SoC and enables it in defconfig.

Devarsh Thakkar (2):
  arm64: dts: ti: k3-am62a : Add E5010 JPEG Encoder
  arm64: defconfig: Enable E5010 JPEG Encoder

 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 10 ++++++++++
 arch/arm64/boot/dts/ti/k3-am62a.dtsi      |  2 ++
 arch/arm64/configs/defconfig              |  1 +
 3 files changed, 13 insertions(+)

-- 
2.39.1


