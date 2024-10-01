Return-Path: <linux-kernel+bounces-345707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5170B98BA11
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA93FB222EC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081341A0B02;
	Tue,  1 Oct 2024 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="OOGjxaKV"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC79118859F
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727779820; cv=none; b=EUwoHVi2C8dIJbD1dQjvRJ2lCoiWeWC1NiDqtiAAAuARJLIdkNiRyoY4W+2A9d+JuI5DoUX4JETRKMCnWeXFME6S4AD3/JRf/qU8ZYqecZaLfSu3DMK1dUkz7uqOBFOdLGUtcaQJDDN97yb1Bl5Jo/A85vBY+/id23E/u1FLEiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727779820; c=relaxed/simple;
	bh=U74TjXNWrry0F+RN91AQhn00vz4QuY2tYPnmNZdL0n8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DxS+OLfWnwgpJnqhc40SNWVgdOR6iuXA97CFVecCVu0QEHXc3IYosmaKWi+UawPdNGs/pNkNPHdcYIRde180b17TeMflmoNgqhSeJpFVY1tzj9xwpIg97Ike/YVYnOQ0kZPBYVPmS8fGefXXoo8XEyJAVOEsGuiFTMPpgGF3G34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=OOGjxaKV; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49108BAW022491;
	Tue, 1 Oct 2024 03:49:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=MgiVxm/ED4FHyt1qwoCEINV
	cNzcuOW1pPBGNSSxsBZY=; b=OOGjxaKVThVrfRvZL+5AJG8QkSWBmhFR8efdG+s
	lWHAovrLd7PQdEvvl3oWEbP/1oc+xytVV4NHzNNSB05pmrzNn6oUil7Xgn1JaC1H
	waDuwopp+CidanISO/RgM/YwALgujpXEO+h20u2XHEvpygTIEiPvPyvFkfDx+awI
	1MeHHy+CtYCbxFRwWqOytpS1w9loqtTf5BY6j4GLd4GLgZyjCmshwhuKUP9BNyj0
	sHT/ScaNfA3dTSd8Oq4pTEwksZpDP34CdCAHCjoB+NRR+TdnBoX2mjQVVGI/UHfj
	fYJVy2pnwetoxyrg/Kqx8M9hHPpgOqTUZvFqr9CUC0EJa0A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41yt6gd2u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 03:49:57 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 1 Oct 2024 03:49:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 1 Oct 2024 03:49:55 -0700
Received: from localhost.localdomain (unknown [10.29.37.241])
	by maili.marvell.com (Postfix) with ESMTP id AF29F5C68E5;
	Tue,  1 Oct 2024 03:49:51 -0700 (PDT)
From: Anshumali Gaur <agaur@marvell.com>
To: <conor.dooley@microchip.com>, <ulf.hansson@linaro.org>, <arnd@arndb.de>,
        <linus.walleij@linaro.org>, <nikita.shubin@maquefel.me>,
        <alexander.sverdlin@gmail.com>, <vkoul@kernel.org>, <cyy@cyyself.name>,
        <krzysztof.kozlowski@linaro.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>
CC: Anshumali Gaur <agaur@marvell.com>
Subject: [PATCH v2 0/4] soc: marvell: Add a general purpose RVU physical
Date: Tue, 1 Oct 2024 16:19:44 +0530
Message-ID: <20241001104948.2779665-1-agaur@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: AePcgkRhVX9jbnW6B0Ggp1UcRsMWXg1R
X-Proofpoint-ORIG-GUID: AePcgkRhVX9jbnW6B0Ggp1UcRsMWXg1R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Resource virtualization unit (RVU) on Marvell's Octeon series of
silicons maps HW resources from the network, crypto and other functional
blocks into PCI-compatible physical and virtual functions. Each
functional block again has multiple local functions (LFs) for
provisioning to PCI devices. RVU supports multiple PCIe SRIOV physical
functions (PFs) and virtual functions (VFs). And RVU admin function (AF)
is the one which manages all the resources (local functions etc) in the
system.

Functionality of these PFs and VFs depends on which block LFs are
attached to them. Depending on usecase some PFs might support IO (ie LFs
attached) and some may not. For the usecases where PF doesn't (need to)
support IO, PF's driver will be limited to below functionality.

1. Creating and destroying of PCIe SRIOV VFs
2. Support mailbox communication between VFs and admin function
(RVU AF)
3. PCIe Function level reset (FLR) for VFs

For such PFs, this patch series adds a general purpose driver which
supports above functionality.  This will avoid duplicating same
functionality for different RVU PFs.

Next generation of Octeon silicon will have many new RVU blocks added.
Eg: ML, Octeon (connected as an EP card) to host network packet path etc
For such functionality there could be only userspace VF drivers hence
a generic PF driver in Kernel is needed to support these VF drivers.

For reference
RVU AF driver is at drivers/net/ethernet/marvell/octeontx2/af/

Example RVU PF drivers
drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c

Example RVU VF drivers
drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c

Patch-1: This patch adds a generic PF driver with probe() and sriov()
capabilities.
Patch-2: This patch adds PF-AF mailbox support to the generic PF driver.
Patch-3: This patch adds PF-VF mailbox support to the generic PF driver.
Patch-4: This patch adds FLR handler to the generic PF driver.

Changes:
v2:
- Patch-1: Fixed indentation issues pointed out by Alexander Sverdlin
- Patch-4: In function rvu_gen_pf_flr_handler, added ~RVU_PFVF_FUNC_MASK 
  pointed out by Alexander Sverdlin

Anshumali Gaur (4):
  soc: marvell: Add a general purpose RVU PF driver
  soc: marvell: rvu-pf: Add PF to AF mailbox communication support.
  soc: marvell: rvu-pf: Add mailbox communication btw RVU VFs and PF.
  soc: marvell: rvu-pf: Handle function level reset (FLR) IRQs for VFs

 drivers/soc/Kconfig                     |    1 +
 drivers/soc/Makefile                    |    1 +
 drivers/soc/marvell/Kconfig             |   19 +
 drivers/soc/marvell/Makefile            |    2 +
 drivers/soc/marvell/rvu_gen_pf/Makefile |    5 +
 drivers/soc/marvell/rvu_gen_pf/gen_pf.c | 1087 +++++++++++++++++++++++
 drivers/soc/marvell/rvu_gen_pf/gen_pf.h |  152 ++++
 7 files changed, 1267 insertions(+)
 create mode 100644 drivers/soc/marvell/Kconfig
 create mode 100644 drivers/soc/marvell/Makefile
 create mode 100644 drivers/soc/marvell/rvu_gen_pf/Makefile
 create mode 100644 drivers/soc/marvell/rvu_gen_pf/gen_pf.c
 create mode 100644 drivers/soc/marvell/rvu_gen_pf/gen_pf.h

-- 
2.25.1


