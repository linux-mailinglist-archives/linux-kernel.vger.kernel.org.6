Return-Path: <linux-kernel+bounces-399685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C36B9C02CC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E905CB22A9E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3191F4260;
	Thu,  7 Nov 2024 10:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ro/B/o9Z"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3161D932F;
	Thu,  7 Nov 2024 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730976402; cv=none; b=leIQv/Mp0wfp2/V1jWgqayBi/l+H2HdY8QQwRghcFu7xgOVV8vb2fdIg68LaJGaMAQ5KI4IxsnqOb5dMZoMj/BmawUwM+q1NTX/9uBNtAZtXnAhanZ+OB7D2Bk1rb5QNZPFHngroeqTwQPtQgkdTIttc0QBeqZucBoFwE3cIs+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730976402; c=relaxed/simple;
	bh=Bwc3bF70oXu40pNfSr8DuD/e4RRbwMW2zsTofu+4WWA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YS+hUQ+7Yti5NaStBOkVwwlqh9w4Cc7uedv0Ba8+RrEYwpEw0SFjW0l6srK7GizZiES+fne9XQ/KEvYoQiqHUs4eSrJWKG+5hdU+vqIfcY5KTD2unPVak9lsNiZho+nv0VKnB/SBGlHljHy/A2NQKQ/6z4A7doKC2kwM1yiEGhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ro/B/o9Z; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A7Ak1Kf039805;
	Thu, 7 Nov 2024 04:46:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730976361;
	bh=aPOy4YYWnfQMbqegU7JnAcEyre8VGwoWzauffPbwmtg=;
	h=From:To:CC:Subject:Date;
	b=ro/B/o9Z1KBnNaQ4hKzM1m5gbjSpRvJuRv+56byEyBrjZm0qYya1bRZ0UPNcBtD9f
	 zOPpD1Xv52rPlzES+xc7DPRffx+9q3oYxPiU1/g9VeT79BfK6qsdLeA5/DSp16muIT
	 /1LVTqAJFCC2lAplit3KwqBMY4LIuNHsNerbV8MU=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A7Ak1wL048767
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 7 Nov 2024 04:46:01 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Nov 2024 04:46:01 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Nov 2024 04:46:01 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A7Ak1KR055338;
	Thu, 7 Nov 2024 04:46:01 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4A7Ak0u1019852;
	Thu, 7 Nov 2024 04:46:01 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
        <ssantosh@kernel.org>, <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-anna@ti.com>, <kristo@kernel.org>,
        <srk@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH 0/2] [PATCH 0/2] Add Clocks to ICSSG
Date: Thu, 7 Nov 2024 16:15:55 +0530
Message-ID: <20241107104557.1442800-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This series adds clocks for ICSSG for AM64x.

PATCH 1/2 Adds the dt binding necessary to add clocks to the device tree.
It adds the `clocks`, `assigned-clocks` and `assigned-clock-parents` in
the dt binding of ICSSG node.

PATCH 2/2 Adds the required clock to the ICSSG nodes. It also changes the
clock used from clock 20 (ICSSG_ICLK) to clock 0 (ICSSG_CORE). This patch
adds the clock-names, assigned-clocks and assigned-clock-parents to icssg nodes.

There is no additonal driver changes needed for this binding change.

MD Danish Anwar (2):
  dt-bindings: soc: ti: pruss: Add clocks for ICSSG
  arm64: dts: ti: k3-am64-main: Switch ICSSG clock to core clock

 .../devicetree/bindings/soc/ti/ti,pruss.yaml         | 11 +++++++++++
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi             | 12 ++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)


base-commit: 5b913f5d7d7fe0f567dea8605f21da6eaa1735fb
-- 
2.34.1


