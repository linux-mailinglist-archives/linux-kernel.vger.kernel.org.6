Return-Path: <linux-kernel+bounces-180630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BECD98C70FE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 06:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1A41F23F8B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 04:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA2C12B83;
	Thu, 16 May 2024 04:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gvwCTeys"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1A5F9CF;
	Thu, 16 May 2024 04:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715834747; cv=none; b=jmrVXdW9XPV1CDp3SD3HxGNMZHVoFF8HHRMVGUceQ3zwsC7conh3cO4p/tf3qf0NmHRgfr2dsalAudeLZsY1aDrPhNYPt1llSKNF1i/i9qn23yAeCRzn2lZc3kip0ydk0rbQR4ag7KxMk7WC+mpM02JTMwtJYOYAQxR5cghJN2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715834747; c=relaxed/simple;
	bh=oFWWKvtwjHZRoweFB+JQytbWiBKNoJP7dsCctd8ydFY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sp08/4YI3wpwd/QBEr3ih+tVP5EqBgYyjJVA9aLBqMVm59kl4wdqLRRPuIT4F6TK0hq0peoqk44z3iqdoueUktU284VQD9covjZlZhTRn7uQ+9mrnSZkaFus7XGCs33dXeP2rV3W2GlZOvOYM2BuNATsXuZORNn/7z8LmScVx0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gvwCTeys; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44G4je3a058280;
	Wed, 15 May 2024 23:45:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715834740;
	bh=1m8xKRXMnQwnX4UKCNVZnFffYpvFvEeKbW6bh7P1XQI=;
	h=From:To:CC:Subject:Date;
	b=gvwCTeysU+7e7DFTEyX4JO9DW2f4jaAEgeVR4FkqKEv16wT0p9Pytv5ABZd5whu61
	 IHdN2o8qGHU5qPSIU9maw8CRw9g0Lc0UEisjybkryt0gHqq0eEqEAMny39dlnKP3UN
	 q8EA8/YH7S/NMq/4lvP1iFZQYlhWQDGUVE1jLWfA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44G4jeOE053410
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 May 2024 23:45:40 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 15
 May 2024 23:45:40 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 15 May 2024 23:45:40 -0500
Received: from uda0500640.dal.design.ti.com (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44G4jbxo115324;
	Wed, 15 May 2024 23:45:38 -0500
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <peter.chen@kernel.org>, <pawell@cadence.com>, <rogerq@kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [PATCH v3 0/2] TI AM64/J7: USB Errata i2409 workaround
Date: Thu, 16 May 2024 10:15:35 +0530
Message-ID: <20240516044537.16801-1-r-gunasekaran@ti.com>
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
Changes since v2:
----------------
* Fixed the redundant blank line added in v2

Changes since v1:
----------------
* Grouped the susp_ctrl register update along with
  existing CDNS3 snippet as suggested by Peter Chen

v2: https://lore.kernel.org/all/20240516042845.31211-1-r-gunasekaran@ti.com/
v1: https://lore.kernel.org/all/20240514092421.20897-1-r-gunasekaran@ti.com/#t

Roger Quadros (2):
  usb: cdns3: Add quirk flag to enable suspend residency
  usb: cdns3-ti: Add workaround for Errata i2409

 drivers/usb/cdns3/cdns3-ti.c | 15 ++++++++++++++-
 drivers/usb/cdns3/core.h     |  1 +
 drivers/usb/cdns3/drd.c      | 10 +++++++++-
 drivers/usb/cdns3/drd.h      |  3 +++
 4 files changed, 27 insertions(+), 2 deletions(-)


base-commit: 82d92a9a1b9ea0ea52aff27cddd05009b4edad49
-- 
2.17.1


