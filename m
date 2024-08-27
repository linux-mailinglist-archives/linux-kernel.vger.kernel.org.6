Return-Path: <linux-kernel+bounces-303142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4BD9607FC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9BE8283927
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2786519EEA2;
	Tue, 27 Aug 2024 10:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MwIIb6fI"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17D44C634;
	Tue, 27 Aug 2024 10:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724756214; cv=none; b=F/xiFuPUUAQ7nOEpXv8H7z0dQ3X+iCpBbfplsgS6crplez/l648i6cYquv30maUIl2RGDBtohHiRPQL0tgqcD+ntOLOS4NGg2/Eu3qwpl2HXESDHYBnI4MXO5rF1lQgNGqkpO4sjpgLc0mOh3VKQVp5zL9dZok5O/9MfmKER03Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724756214; c=relaxed/simple;
	bh=kmByGUxRLjtDmL6ii3M4Lc4Jsk9eCJRrJIEKQ7ZxJG0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VB1OJDpE+zOD4o3kopzTLj4rTLj/gky1gTplV+M/e8ORVlS7NrcSCV1AAqg9IT5zba8R+ojPhizs1tk3m3zgyrktrdV6NraQGAj/Iq02HTOkVYr44PUUNwu8Vj74vdNT6+yMsgJvFEUeJLkkUy5pzqCrVxWVP95BPeoA8p5t2oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MwIIb6fI; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47RAukLa116282;
	Tue, 27 Aug 2024 05:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724756206;
	bh=u810Jo3KAM2PYpKB1sOJ4JvATsEjVyj69RK1x8nzlfw=;
	h=From:To:CC:Subject:Date;
	b=MwIIb6fI7FAj1QCp5rCb8BTmXfIZho7xLDmtEdFKdBMyQNvAvqfw+RdicDoiEOZd6
	 CuQZDj406wel/Wh1bfC8i9pfYuAUTK9GUr2xC/Qb0Oww4fQzoPWREAV8FHrV9Z17Ot
	 8nsin8eih3+KPE67ejLC4pEl2W6Qk5bKUXLtQldg=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47RAukDF006731
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Aug 2024 05:56:46 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Aug 2024 05:56:45 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 Aug 2024 05:56:45 -0500
Received: from localhost (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47RAujYi051303;
	Tue, 27 Aug 2024 05:56:45 -0500
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <b-kapoor@ti.com>, <jm@ti.com>, <vigneshr@ti.com>, <nm@ti.com>
Subject: [PATCH v2 0/2] Add support for multiple can instances as well as describe main_uart5
Date: Tue, 27 Aug 2024 16:26:42 +0530
Message-ID: <20240827105644.575862-1-b-kapoor@ti.com>
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

This series adds support for multiple can instances present on J722S
EVM as well as describe the main_uart5 for J722S EVM.

CAN instances 0 and 1 in the mcu domain and 0 in the main domain are
brought on the evm through headers J5, J8 and J10 respectively. Thus,
add their respective transceiver's 0, 1 and 2 dt nodes as well as
add the required pinmux to add support for these CAN instances.

Describe main_uart5 in device tree for completeness, adding the pinmux
and mark it as reserved since system firmware uses it in J722S EVM for
trace data.

Rebased to : next-20240827

Bhavya Kapoor (2):
  arm64: dts: ti: k3-j722s-evm: Add support for multiple CAN instances
  arm64: dts: ti: k3-j722s-evm: Describe main_uart5

 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 89 +++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

-- 
2.34.1


