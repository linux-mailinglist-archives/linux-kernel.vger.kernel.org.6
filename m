Return-Path: <linux-kernel+bounces-375663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B6B9A98FC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E16D11F235BE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E17813A899;
	Tue, 22 Oct 2024 05:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LXvtcovk"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E1E1E495
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 05:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729576441; cv=none; b=e+EwFUa3ZszSAgmVk6VoF46ppfWr3Z+xqKA0di/u/S9d017qsZbmo2VCqU86TF9v3tXzcWrKCBwSB4Y8hhFp0J3zeXDPJOAv8pVULnwvuCfqOSMIzLT9oEXAbPy0JTfCgjIJG5Vo/N8HpjUj7J64fN+658uNi4kM6z3tS2/IVXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729576441; c=relaxed/simple;
	bh=rDsQm6xDIEc3LJDlQrIxNIBqFGx8InCenTHTK4BoMw4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L40DCs3JdNe/Upu5LjPsK4MDsXlO7hOBCs6z10Wtyg6r53I/cVqQXTBpG8gvIjo/mgP6nDoxQu42+DgdNW/ZKpPHIVnAPFiT4fgQDgjnzeh+1Q8/wGgbZhY8MasoNIYQAY4KCaGvi0ByIvmGZaNqVqHOycBn17MoZLG+zqybs04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LXvtcovk; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M3TNBL004751;
	Mon, 21 Oct 2024 22:53:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=vSY+GShIS2tlzpTnYgkvgw8
	OvpNHWoJqZlq/CWJIjIM=; b=LXvtcovkMfvzRDwk4tLKHzcXbOL+C82C8mHiA4w
	ICc85xVS2egemmfXOeU6+Cu7UHIHmeaGkqFFBv+FBYGm/MzOJMIc8x6RvZaEIhUZ
	wzfBFxbZKdOJw4YcC0FNirEavbDpqKycRqbFQ3mspVXIjTZ3bxd3fNHbMB2opq+3
	TTxGIv6meqyAhkUdpeY3koPbnb7acMkzIfzGUrSbz9TO52RzxG/MLsjX8QBh51x7
	8FMHgbRU13qnupiEsrzatS2m5a67HACmEIMSynH+2jCM/CzcO92oLWAJita5iZcs
	xLOr0ewzd6TvD4MDV5tL+6mjLqiOZy6kkAmXa/DnEUYPSkA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42e1ajrjru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 22:53:51 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 21 Oct 2024 22:53:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 22:53:50 -0700
Received: from localhost.localdomain (unknown [10.29.37.241])
	by maili.marvell.com (Postfix) with ESMTP id EA9C23F7067;
	Mon, 21 Oct 2024 22:53:47 -0700 (PDT)
From: Anshumali Gaur <agaur@marvell.com>
To: <quic_bjorande@quicinc.com>, <christophe.leroy@csgroup.eu>,
        <angelogioacchino.delregno@collabora.com>, <herve.codina@bootlin.com>,
        <dmitry.baryshkov@linaro.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>
CC: Anshumali Gaur <agaur@marvell.com>
Subject: [PATCH v4 0/4] soc: marvell: Add a general purpose RVU physical
Date: Tue, 22 Oct 2024 11:23:41 +0530
Message-ID: <20241022055345.2983365-1-agaur@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: oU9Bbt69xHLuhXROvsChNa_-934G382F
X-Proofpoint-ORIG-GUID: oU9Bbt69xHLuhXROvsChNa_-934G382F
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


