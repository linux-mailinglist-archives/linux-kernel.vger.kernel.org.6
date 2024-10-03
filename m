Return-Path: <linux-kernel+bounces-348960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDBA98EE7F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75A91F262D9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A081552E7;
	Thu,  3 Oct 2024 11:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Rfk0zXmh"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33DE1474C5
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 11:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956280; cv=none; b=diwcdeTvq0v8BMsR5TZ1MWBLzob8zT8Uagww3pRx26yWSENa2aIyhkhDUdrHzJ8NhA/pJlZvkRjQX6/o8VtYSMIb6yVEfAOIhWNmcBtoSmhyY9U3Qr75PqedakIDc5uAAH2MKTDr6r4d433vBFi2bjyWzkl6RdbtdpjV6enBPcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956280; c=relaxed/simple;
	bh=PaRdb2iEzyxCSDpcWeuVz4pl5j1eYa12ILeTA7JP8fY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SvXjbacrOthIXuP2u0cohfWpiWNlNvajQcSM3D/CaOb2SjjNKtqhMA4k5Sm3mG3crUBQVOc2saZ66Q0uNxNfnc028zDcWSU97QnQ49HL4W3xq3GvlXVXlWizJIel+iTymdEP+w09PtTXeYiLTVsho0fGRpxA4s8c1jZXYkctctQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Rfk0zXmh; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4932xw5a027256;
	Thu, 3 Oct 2024 04:51:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=HEMHbCLtDO5FdVd8hi+P2ef
	AgyTClrmH+wj5OW+P+eQ=; b=Rfk0zXmhZDbmo9rIYanoloytZqSgyOFbb9lefQP
	stzwG31TRcZBjT4dEI09wJ/E0ae0sPsH0Z/6JNjGyiniAIE2aCA4Dg3QI6mpPxU1
	p5SgOwmGZFiB3vi63LUXIe5AaoX5CVqSY2nXkrCVYpiHKH4OMcVhdvzl1flcp2DZ
	U7h1iNaF3XGJS7NwICX3fTlpGS/cg1MCmgvgkOUhaksxrDwjKWkBkDZFcJbJy3Uo
	CGkreE+pS0T9za66QX6nOvNoC2j5Qn4YHYU/PPZej3xqScztTi/mkxPSihfZFjGD
	xXqeH+D2vPTyWzP5MABYvtDbAmNhI1w5I9QFCELgfa1PLkQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 421amr9ppk-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 04:51:04 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 3 Oct 2024 04:51:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 3 Oct 2024 04:51:03 -0700
Received: from localhost.localdomain (unknown [10.29.37.241])
	by maili.marvell.com (Postfix) with ESMTP id D49135B6927;
	Thu,  3 Oct 2024 04:51:00 -0700 (PDT)
From: Anshumali Gaur <agaur@marvell.com>
To: <quic_bjorande@quicinc.com>, <christophe.leroy@csgroup.eu>,
        <angelogioacchino.delregno@collabora.com>, <herve.codina@bootlin.com>,
        <dmitry.baryshkov@linaro.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>
CC: Anshumali Gaur <agaur@marvell.com>
Subject: [PATCH v3 0/4] soc: marvell: Add a general purpose RVU physical
Date: Thu, 3 Oct 2024 17:20:53 +0530
Message-ID: <20241003115057.2810857-1-agaur@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: gvE6Il1eZjC_ZBGpWvF20k7t4lLdxws8
X-Proofpoint-GUID: gvE6Il1eZjC_ZBGpWvF20k7t4lLdxws8
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
v3:
- Patches-1-4: added multiline comments as per coding style, pointed out
  by Krzysztof Kozlowski

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
 drivers/soc/marvell/rvu_gen_pf/gen_pf.c | 1095 +++++++++++++++++++++++
 drivers/soc/marvell/rvu_gen_pf/gen_pf.h |  152 ++++
 7 files changed, 1275 insertions(+)
 create mode 100644 drivers/soc/marvell/Kconfig
 create mode 100644 drivers/soc/marvell/Makefile
 create mode 100644 drivers/soc/marvell/rvu_gen_pf/Makefile
 create mode 100644 drivers/soc/marvell/rvu_gen_pf/gen_pf.c
 create mode 100644 drivers/soc/marvell/rvu_gen_pf/gen_pf.h

-- 
2.25.1


