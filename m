Return-Path: <linux-kernel+bounces-180622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E034C8C70EC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 06:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B08F5B22FB7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 04:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948B629CE4;
	Thu, 16 May 2024 04:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sBWJp3lj"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59059C122;
	Thu, 16 May 2024 04:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715833738; cv=none; b=ovbtwkTE0jQWZ2XWvuq11NDdVvtcAGB0i2mryEaOqNk0lQDkvprBB6Joc+4dA7U8/+//KCx8VzqFBHW7ria3R8EHH6KW/pP7bfXa5Xl5DSRTfij1oxSepUGcGvKKGZjLSCIM05XcZ304doeVQSwyVY5dpdqaItyZtYidCaAJSH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715833738; c=relaxed/simple;
	bh=sRgVPKYSI4Wha9IK+Z5Ny/B3dWS5I+4Qy1/fC9gF4H8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OOggpM00Gyj17CTHlHQkxsSDCChZCmE2hVHWwosGzyS2W1HyChaEDrQUJFis1yfSe5jpu4GKUo+Dl20xUOT9cN/i6EH6NXYxR0J9Ps9RADZMP3GZ7c0mCNLrmHf9/7MoshP7eL7ou0sRrz3SpyglY0Z8qOK1O2CE9uRTC3SYRkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sBWJp3lj; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44G4SnSV114226;
	Wed, 15 May 2024 23:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715833729;
	bh=w/D3GBIX3YEvmPeY+U4E3OsVqhG/LJmuFTFGyANLWSE=;
	h=From:To:CC:Subject:Date;
	b=sBWJp3lj4HN98QXAJwvA7XWddm+JhEVrD/0xZHzl1knutJPOQIDVJmIdogIcdpHfK
	 KgxwJsE66ENLFTxLloMs8AanGc3/1QteP2vKZKV0HpnOyKiu0dFyIM8Z7c43hJ/1lv
	 u1HEPSlvjaoQpbz1FyrDWT5LT05eh9rl3j3PrHzM=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44G4Sntb078400
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 May 2024 23:28:49 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 15
 May 2024 23:28:49 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 15 May 2024 23:28:49 -0500
Received: from uda0500640.dal.design.ti.com (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44G4Skhi089022;
	Wed, 15 May 2024 23:28:47 -0500
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <peter.chen@kernel.org>, <pawell@cadence.com>, <rogerq@kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [PATCH v2 0/2] TI AM64/J7: USB Errata i2409 workaround
Date: Thu, 16 May 2024 09:58:43 +0530
Message-ID: <20240516042845.31211-1-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This series adds workaround for all TI platforms using
cdns3,usb IP. i.e. AM64/J7x

Change log:
----------
Changes since v1:
----------------
* Grouped the susp_ctrl register update along with
  existing CDNS3 snippet as suggested by Peter Chen

v1: https://lore.kernel.org/all/20240514092421.20897-1-r-gunasekaran@ti.com/#t

Roger Quadros (2):
  usb: cdns3: Add quirk flag to enable suspend residency
  usb: cdns3-ti: Add workaround for Errata i2409

 drivers/usb/cdns3/cdns3-ti.c | 15 ++++++++++++++-
 drivers/usb/cdns3/core.h     |  1 +
 drivers/usb/cdns3/drd.c      | 11 ++++++++++-
 drivers/usb/cdns3/drd.h      |  3 +++
 4 files changed, 28 insertions(+), 2 deletions(-)

-- 
2.17.1


