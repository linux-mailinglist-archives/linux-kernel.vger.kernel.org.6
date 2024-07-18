Return-Path: <linux-kernel+bounces-256045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A73934828
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D665282F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 06:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAA06A022;
	Thu, 18 Jul 2024 06:37:58 +0000 (UTC)
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B1B273FD
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 06:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721284678; cv=none; b=goYSamrlo8ipmwUG+IuGr9KhcJYBf67UhWMo4SVPvpGp8MVoq9GyNLwJ4BAEd+nitGWQ+DbsSIMQG3nnMhgL/FSG/aV80WxCuj0ifbY9bd6JUCSZJlLn09e5IlqLmdEaH2u0rcmdWktxebZEMUD6qBUB1swPGrlah6LCoQGy/GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721284678; c=relaxed/simple;
	bh=ZGMAaa3hz4DkXQmXeLg0cxOwAuuJE5uqmlYG/Vh/z8Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V1LxgmbwT6oOUuhFUBDqermROhd7dJg7HykmvL8tKUiBjhKKPGkNAYZDUH+X1GbbS7fWFXEA5Le/pVuAXwmt96fIBIiow8fT+dMJYhRxWencqn5Kf8DRVy3BrsTtCNWsbzHtv8LXj0JiezBCpJGske1jRDEbWtH2UNCs6BlBXKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1721283848-1eb14e2e5f151040001-xx1T2L
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx2.zhaoxin.com with ESMTP id c4cjHLpIiBIaD9bC (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 18 Jul 2024 14:24:08 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Jul
 2024 14:24:08 +0800
Received: from xin.lan (10.32.64.1) by ZXBJMBX03.zhaoxin.com (10.29.252.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 14:24:06 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
From: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
To: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <bhelgaas@google.com>,
	<robert.moore@intel.com>, <yazen.ghannam@amd.com>, <avadhut.naik@amd.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <acpica-devel@lists.linux.dev>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <TonyWWang-oc@zhaoxin.com>,
	<leoliu-oc@zhaoxin.com>, LeoLiuoc <LeoLiu-oc@zhaoxin.com>
Subject: [PATCH v3 0/3] Parse the HEST PCIe AER and set to relevant registers
Date: Thu, 18 Jul 2024 14:24:02 +0800
X-ASG-Orig-Subj: [PATCH v3 0/3] Parse the HEST PCIe AER and set to relevant registers
Message-ID: <20240718062405.30571-1-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b99685d9-9f3a-4c21-8d33-2eaa5de8be54@zhaoxin.com>
References: <b99685d9-9f3a-4c21-8d33-2eaa5de8be54@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1721283848
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1611
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.127785
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>

According to the Section 18.3.2.4, 18.3.2.5 and 18.3.2.6 in ACPI SPEC
r6.5, the register value form HEST PCI Express AER Structure should be
written to relevant PCIe Device's AER Capabilities. So the purpose of the
patch set is to extract register value from HEST PCI Express AER
structures and program them into PCIe Device's AER registers.
Refer to the ACPI SPEC r6.5 for the more detailed description. This patch
is an effective supplement to _HPP/_HPX method when the Firmware does not
support the _HPP/_HPX method and can be specially configured for the AER
register of the specific device.

v1->v2:
- Move the definition of structure "hest_parse_aer_info" to file apei.h.

v2->v3:
- The applicable hardware for this patch is added to the commit
  information.
- Change the function name "program_hest_aer_endpoint" to
  "program_hest_aer_common".
- Add the comment to function "program_hest_aer_common".
- Remove the "PCI_EXP_TYPE_PCIE_BRIDGE" branch handling in function
  "program_hest_aer_params".

LeoLiuoc (3):
  ACPI/APEI: Add hest_parse_pcie_aer()
  PCI: Add AER bits #defines for PCIe to PCI/PCI-X Bridge
  PCI/ACPI: Add pci_acpi_program_hest_aer_params()

 drivers/acpi/apei/hest.c      |  66 +++++++++++++++++++++-
 drivers/pci/pci-acpi.c        | 101 ++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h             |   9 +++
 drivers/pci/probe.c           |   1 +
 include/acpi/apei.h           |  17 ++++++
 include/uapi/linux/pci_regs.h |   3 +
 6 files changed, 195 insertions(+), 2 deletions(-)

-- 
2.34.1


