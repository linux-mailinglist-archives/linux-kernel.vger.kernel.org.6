Return-Path: <linux-kernel+bounces-230487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35397917D8C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E66742819F2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB92176AD3;
	Wed, 26 Jun 2024 10:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JPuG7WUc"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16319152E0E;
	Wed, 26 Jun 2024 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719396944; cv=none; b=AeZjgoNFqJqEmrGFb8K8GoVZDwCtVbcoxVeWTxK8ExBN9HKpVbOMVjV+y774IOFXXWCZLAtl8BtBj6hkTXG1OZoFnSk5kq6p5vomJrSrnmxlTVEmSJqXWAYNSpWixImfHYVQRkfnH4jPEdyMGtIf6rKvr0m7teS9VYYM1WXQozA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719396944; c=relaxed/simple;
	bh=OXJaVaZHF0d8Tf+9bWnTEW9JWHI0eZhqqqWfgP//kWw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tjFqiO8VUbWxW96XSTqfRYyYWOSp9XAM+OGH33RTP52uVR/qHS7r1qT+vZgmpXxEWXz4jVx5/GQXygPA7Md5rRPQe0/o7254qSEOhWWSad694NqtyxQDDkwaLMy9mEvUJ4nccZFfvxON3MXOQhQFnELCNZB0k8SEW+rNp7nvBno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JPuG7WUc; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45QAFVX4102538;
	Wed, 26 Jun 2024 05:15:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719396931;
	bh=y73BCHLcVKUAveiFTpKEdcNlSIUH8cR4cm7hTf10/a0=;
	h=From:To:CC:Subject:Date;
	b=JPuG7WUcfDD4peSMcsAipXCaEAJDoDSj8N+iOSHAKB/Cot/Iu2ms8OhK1MB+uBUDg
	 vviuJWjZ4JnKmVsuukS/uiU/YmSuKA1qtN4xxzvo2q++iigM/sGm6iEivwlGqNowXa
	 onWSSbNYNqqJnXZFWXmNDJLB3co7PL+lrNAXTuXU=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45QAFVcx127431
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Jun 2024 05:15:31 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Jun 2024 05:15:31 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Jun 2024 05:15:30 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45QAFRVF091997;
	Wed, 26 Jun 2024 05:15:28 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@kernel.org>,
        Andrew
 Davis <afd@ti.com>, Tero Kristo <kristo@kernel.org>,
        Dhruva Gole
	<d-gole@ti.com>
Subject: [RFT][PATCH 0/2] dts: ti: Fix build warns in usb@31000000
Date: Wed, 26 Jun 2024 15:45:18 +0530
Message-ID: <20240626101520.1782320-1-d-gole@ti.com>
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

The series has been marked as RFT because although I was able to boot
test, it needs to be made sure that usb features aren't affected by this
change. Ideally, looking at the driver, I don't think it really is
looking at port@X but incase I missed anything please feel free to point
out.

I'm working on top of tag: next-20240625

Dhruva Gole (2):
  arm64: dts: ti: k3-am62p5-sk: fix graph_child_address warnings
  arm64: dts: ti: k3-am62x-sk-common: Fix graph_child_address warns

 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts        | 16 ++++------------
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 17 ++++-------------
 2 files changed, 8 insertions(+), 25 deletions(-)


base-commit: 0fc4bfab2cd45f9acb86c4f04b5191e114e901ed
-- 
2.34.1


