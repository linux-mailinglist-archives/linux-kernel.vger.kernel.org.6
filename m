Return-Path: <linux-kernel+bounces-191725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4968D1327
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D5831C20837
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 04:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A6331A89;
	Tue, 28 May 2024 04:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uK2DVuGm"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C323311CB8;
	Tue, 28 May 2024 04:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716868950; cv=none; b=TejucEux2POXWcT+BG1b9B7O/aXU+EaAE7V9hDPRyBCa54yhG/QSM99uPaKcOA1SeMd1lJIHOhM0vu0zTbbVtYUouY9LYEJZ32ZWaawvoNU9vKEXQqfx2VqioGwfkTxtP00cIqQfbGKeiW4XyyWHbThJP4aGnJAvN+m/T0kqGHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716868950; c=relaxed/simple;
	bh=RkyzJwALhBYm7jbYo/1FMaotEaFywVBZ2f1aO0c2YCU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PwwYgIL6zlxFQ600uxGa2V72gIXjsqzveFPHCjIWOT7F2VSc4rDSrEpIVElgpowzPC2NBK46qL1hgrOdeOx9nalgc98PgCYQyjqUgYL0eb6UTFyyRHHox+y6To88hoRuyzJyVFTf54iLdHhPO15mCm6LBllIh/PftqR7wZECMto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uK2DVuGm; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44S425u8055371;
	Mon, 27 May 2024 23:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716868925;
	bh=1R6SAPxsYM/7puz0eluIm4xcL2IBinsyRIHhoBFXMrE=;
	h=From:To:CC:Subject:Date;
	b=uK2DVuGmjhX//PIMFHuwJg3QnidGPdyHr849yJgnH/1fEFkMVS+MCZd9E7MP8RhyO
	 1/nkox4mTXzv1KKAPJpMqmvuMkQgD80ZQv/G0JumpvOs0YjGs8bBnFPTgTG2zH2XrN
	 8BtUrV4+0p7HaWlUuRRC2IPKL7BWH0q5FkBuhkiA=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44S4258t093018
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 May 2024 23:02:05 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 May 2024 23:02:05 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 May 2024 23:02:05 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44S420Ox028431;
	Mon, 27 May 2024 23:02:00 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <marten.lindahl@axis.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH v3 0/3] arm64: ti: Add TPS6287 nodes
Date: Tue, 28 May 2024 09:31:56 +0530
Message-ID: <20240528040159.3919652-1-n-francis@ti.com>
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
Boot logs (v2): https://gist.github.com/nehamalcom/1a288f534d730e8af43c48a175919b19 

Changes since v2:
https://lore.kernel.org/all/20240527124422.3553828-1-n-francis@ti.com/
- modified subject prefixes, order of properties and node names to
  adhere to the DTS coding style (Krzysztof)
- no change to boot logs (not affected)

Changes since v1:
https://lore.kernel.org/all/20240507122158.3739291-1-n-francis@ti.com/
- remove changing the compatibility of the existing driver (Rob and
  Mark)
- remove unnecessary bootph-pre-ram, have them only for VDD_CPU_AVS
  (Udit)

Neha Malcom Francis (3):
  arm64: dts: ti: k3-am68-sk-base-board: Add LP8733 and TPS6287 nodes
  arm64: dts: ti: k3-am69-sk: Add TPS62873 node
  arm64: dts: ti: k3-j784s4-evm: Add TPS62873 node

 .../boot/dts/ti/k3-am68-sk-base-board.dts     | 76 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am69-sk.dts         | 21 +++++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      | 21 +++++
 3 files changed, 118 insertions(+)

-- 
2.34.1


