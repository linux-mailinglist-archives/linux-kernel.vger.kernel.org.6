Return-Path: <linux-kernel+bounces-171259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C908BE1F2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1105287E08
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D64315D5BE;
	Tue,  7 May 2024 12:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XEYY1UF0"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF14315B153;
	Tue,  7 May 2024 12:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084547; cv=none; b=Slm3vobD9yuGNLFqcP8ol0dMEy8aEsmVoJi8O2PRRQPEMd0T7o0KFxIBsciXgg2LMYOVant3nsRuPhYSHOY4OsycYNrgydMQVKUVCbw9QV1eQiPmDttUId7aa8DD3Pow9zBrNFsb3Kjkau30SMw11RPW+P0WdK5NIlIc34Dut9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084547; c=relaxed/simple;
	bh=oeMrBKuDgHqrwSGXoJz3vqRIgZgm8z04pAJTFR28RCw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iansNCD2pVIzUx4YfWRUDdnq9S/PaTiPJ+1bmWwm8BGVQSu+hKFoMf29QuQMs5iH7A85cL0co8Mi/9jzUmqGMmp81cMT6M4RrNvwp8PVkvo0h/kxL1+B+kGG5wLMFZxRr/LtwcWSVXwKqEZ7IWMqG5CUHLsEvxQA62ihL8ZPlBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XEYY1UF0; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 447CM3o5047595;
	Tue, 7 May 2024 07:22:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715084523;
	bh=13XDjECo3o9dcQc+3q2Ty+J8LvNEN05S/B+l10NtHLQ=;
	h=From:To:CC:Subject:Date;
	b=XEYY1UF0WFLQXJwTRANaN0bhpaW20g4oVBqrewWDcayF9N1JkE7qVDknrxuEqD+xS
	 +/Mw9rB4b8g6Ps/jw74/Ha76+MxftMuNJUthwPX3mIUSycMGoIdYNWhiS7OLnGUu9N
	 IzuziESg0MwB7YHUQ/OYd03Bvmas5H6zFJ2Oe0AA=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 447CM3il049889
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 May 2024 07:22:03 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 May 2024 07:22:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 May 2024 07:22:03 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 447CLwDN038074;
	Tue, 7 May 2024 07:21:59 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <marten.lindahl@axis.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH 0/5] arm64: ti: Add TPS6287 nodes
Date: Tue, 7 May 2024 17:51:53 +0530
Message-ID: <20240507122158.3739291-1-n-francis@ti.com>
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

Add nodes for TPS6287x present in AM68 SK, AM69 SK and J784S4 EVM. They
are a family of synchronous step-down DC/DC converters. These converters
are used to enable AVS (Adaptive Voltage Scaling) for these devices.

Also since AM68 SK lacks DT node of it's PMIC, LP8733; make use of this
series to add that in as well.

Data sheet: https://www.ti.com/lit/ds/slvsgc5a/slvsgc5a.pdf
Boot logs: https://gist.github.com/nehamalcom/1a288f534d730e8af43c48a175919b19

Neha Malcom Francis (5):
  regulator: dt-bindings: Unify compatible
  drivers: regulator: tps6287x: Unify compatible
  arm64: boot: dts: ti: k3-am68-sk-base-board: Add LP8733 and TPS6287
    nodes
  arm64: boot: dts: ti: k3-am69-sk: Add TPS62873 node
  arm64: boot: dts: ti: k3-j784s4-evm: Add TPS62873 node

 .../bindings/regulator/ti,tps62870.yaml       |  7 +-
 .../boot/dts/ti/k3-am68-sk-base-board.dts     | 78 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am69-sk.dts         | 22 ++++++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      | 22 ++++++
 drivers/regulator/tps6287x-regulator.c        | 10 +--
 5 files changed, 126 insertions(+), 13 deletions(-)

-- 
2.34.1


