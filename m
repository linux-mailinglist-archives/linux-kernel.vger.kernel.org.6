Return-Path: <linux-kernel+bounces-407558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD819C6EE9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56AB51F23D9C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1505200127;
	Wed, 13 Nov 2024 12:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="WgrJD5yG"
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953D11F80D6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 12:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731500401; cv=none; b=Y+AIbnKqGuyKKSACXj15YGyXy6+vOWDWvWs2854DK12Vu6e+NnlYaJcdk1tCqYlP2WRYEd/tT3qJxfPlee/N00U52ryQIvgDfMyBfEFyPACXkt/83Na43GRT74UHXCO4HBL3q1uSnZrsqMxCksLVQczVd/mIkvHHvV+k7zIz3Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731500401; c=relaxed/simple;
	bh=Qw3F13E9EAFFGGRhkrTkBDS3yGwLisp7QRVLkdcyu68=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DY5Gc+528WoHQoChU/TWaJ9aq33W5lUNKIeQSOIY8i3uskY02Dk9xkRlKMHZ6lur2Nx/nX7FeZky2111tX5ioXfMHox+UPiK/ZY/N31zQrjXf9lUmq2RymyinfKEouVL7bibDkCJI3WnPg7h1PnsLK4mOnOYXVmtWiuKaENiQLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=WgrJD5yG; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD6X78V016723;
	Wed, 13 Nov 2024 04:19:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=UNdzAhegTPJ9QJDX2pewUab
	t3JRG3oZxJvqC1a7Y57A=; b=WgrJD5yGu+TzrJbKab8kp3q/nTSzKf+CnrsjSHx
	CABhD0oshDJkO3ATCvU5ELAjA4oge1qp85OrSJqbcqFYBMpeOs0OoterFfyBfWxQ
	9FUdnfmm6ERRej2+RDtfKB1Wf1SSiyBDk3T+NXCt4wRTWVjiC757X+3iUd61WHaa
	WOgJV57HgG4drxukqlWCS40mZtpRezel6zk6gnjzKAdn7kTaH/sn7ltXb87+1Fjn
	Hk7VmHBuqnx3HLClrLYGcDBMLn2ayz2LqNhfll/2CgTmPwtaCHv0kzRUuJ1fZsWC
	swwwMCcjbBOwEjrxhnsUb9qODlpKewRkLku6PNEkyssGh0Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42vpxp0k1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 04:19:48 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 13 Nov 2024 04:19:47 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 13 Nov 2024 04:19:47 -0800
Received: from localhost.localdomain (unknown [10.29.37.241])
	by maili.marvell.com (Postfix) with ESMTP id E04CA3F7040;
	Wed, 13 Nov 2024 04:19:43 -0800 (PST)
From: Anshumali Gaur <agaur@marvell.com>
To: <quic_bjorande@quicinc.com>, <christophe.leroy@csgroup.eu>,
        <angelogioacchino.delregno@collabora.com>, <herve.codina@bootlin.com>,
        <dmitry.baryshkov@linaro.org>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <sgoutham@marvell.com>
CC: Anshumali Gaur <agaur@marvell.com>
Subject: [PATCH v5 0/4] soc: marvell: Add a general purpose RVU physical
Date: Wed, 13 Nov 2024 17:49:37 +0530
Message-ID: <20241113121941.3372131-1-agaur@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: euTSgB0Dp3_v4QCgz80Yzh4_BQ2HzSB0
X-Proofpoint-ORIG-GUID: euTSgB0Dp3_v4QCgz80Yzh4_BQ2HzSB0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

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
v4:
- Just a reminder to review patches, no change from v3 to v4
v5:
- Adding Arnd Bergmann to the mailing list

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


