Return-Path: <linux-kernel+bounces-219953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B26090DAAE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61901F232FF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2BE145A1F;
	Tue, 18 Jun 2024 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Twf3G+aU"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D779C50246;
	Tue, 18 Jun 2024 17:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718731894; cv=none; b=ajSxKKPKRON4VWRUDa2dgSGIznSPvSUlZwGg4b1m2cT39Iv3FpldHM+hjEdiQfYkVEZe8YGVUH3+cAr8HSpHfPZ+k9zjrcWW7f42G6IhUhGirxt/TQu85Yj7IIFhBXvnWQCNh+S9ONbfE3Cqt6Jn6QJW/BQK80GfYEACGY6oBYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718731894; c=relaxed/simple;
	bh=hXpkdavMPX9dV2I4u82huap8lNsxumpPrpigp2HtMGg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mt78VdLwtUSR2BJ6L/qdlCBqxdicadLIA7r5+6gvcusoaRx6i9oDm4yccrMciWa1ztiVMeow1MWQrJ5Rmdx2j0SI6wfqW0NZgd3EqbTomo0hlyfWIhLSeCwA3eAntCQWMWc+huaMOlCCGhpCZCd1Kij0eRQ9Zv9Nn2uwsOzF844=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Twf3G+aU; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45IHVQtt048616;
	Tue, 18 Jun 2024 12:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718731886;
	bh=qTzzrQAtlIWmn+nMM750AlJyr53fZqmeInvHLmBDgns=;
	h=From:To:CC:Subject:Date;
	b=Twf3G+aUiPAZjhrp7hMJA1fB3xLtcNokH5+sWEMFpPVGJFoDLPB/hDXmbJQWMqS99
	 xmCL2VpEhQBE8KSVobQMORWO78b3m/stkH1RmJQM/EJ0cj7PIHGDt5EzegBTdCHiyh
	 SgB9PiRZ0sJ2n3P45zuR5AGsVydOuP+Z62/Y/dRU=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45IHVQgw026410
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Jun 2024 12:31:26 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Jun 2024 12:31:25 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Jun 2024 12:31:25 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45IHVPqP043305;
	Tue, 18 Jun 2024 12:31:25 -0500
From: Nishanth Menon <nm@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Vaishnav
 Achath <vaishnav.a@ti.com>,
        Jared McArthur <j-mcarthur@ti.com>, Bryan
 Brattlof <bb@ti.com>,
        Dhruva Gole <d-gole@ti.com>
Subject: [PATCH 0/3] arm64: dts: ti: k3-am62p/j722s: Add gpio-ranges properties
Date: Tue, 18 Jun 2024 12:31:20 -0500
Message-ID: <20240618173123.2592074-1-nm@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Texas Instruments, Inc.
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

This series was tested on BeagleY-AI[1] using the script[2].

This allows gpiod to request for a gpio that is not in the default GPIO
mux mode and the framework controls the mux over to required GPIO mode.

The series is based off next-20240617.

NOTE: there is also a dtb_warning that is added, which as far as I can
see is either a dtschema bug or a pinctrl-single binding error. more
information in [3]

Jared McArthur (1):
  arm64: dts: ti: k3-j722s: Add gpio-ranges properties

Nishanth Menon (2):
  arm64: dts: ti: k3-pinctrl: Define a generic GPIO MUX Mode
  arm64: dts: ti: k3-am62p: Add gpio-ranges properties

 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 14 ++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi  | 10 ++++++++++
 arch/arm64/boot/dts/ti/k3-j722s.dtsi      | 17 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-pinctrl.h       |  2 ++
 4 files changed, 43 insertions(+)


base-commit: 76db4c64526c5e8ba0f56ad3d890dce8f9b00bbc
[1] https://www.beagleboard.org/boards/beagley-ai
[2] https://gist.github.com/nmenon/4973770cf0df3f02c2e4f7f3d048d80d
[3] https://lore.kernel.org/r/20240618165102.2380159-1-nm@ti.com
-- 
2.43.0


