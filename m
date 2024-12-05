Return-Path: <linux-kernel+bounces-434162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4E79E626E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EB481882FB2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E8242069;
	Fri,  6 Dec 2024 00:48:55 +0000 (UTC)
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6C622083
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446134; cv=none; b=eDXz/mGMRqvB2Jd8KQFlhC5KR91eKJbdr1Ea/GIYHQIxU5rZ0LR0bsqZ1L63e8Y8C+5r0CrQDJt0DC/Mn3EviiJ9RFowqilmVwxciaQHy+MO4Ks2EWmr4vCdM/Hajx0+QxqNeBvlAzZFZjr6GWgX60Cszz5pEQ2Jb5Tn6ajJi+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446134; c=relaxed/simple;
	bh=RDfVKyiGPkxjQWiZXYTMz5EOd1dIdsbHDvSH0iNDcAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sapTzkTVmpAf82xZ2LZL4C3sxqTv0s/2G3YSF4YPzD0dYOpHcZ5ni8LGlKbUKzzfxxw1/Xrq2tA5gt2QMYRI6Y5gDPFz4cSaqoIQaZR7K/R/fiBdHwM7YLAowyP0iH/elZ9EPLjEhXM8KXyxg3hti8uoo1ml7077BoSwHgWh9Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1733446126-086e2312d5235b0001-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx1.zhaoxin.com with ESMTP id IQ6SxxUcIQQpJ0vr (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Fri, 06 Dec 2024 08:48:46 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 6 Dec
 2024 08:48:45 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::3066:e339:e3d6:5264]) by
 ZXSHMBX1.zhaoxin.com ([fe80::3066:e339:e3d6:5264%7]) with mapi id
 15.01.2507.039; Fri, 6 Dec 2024 08:48:45 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from xin.lan (10.32.64.1) by ZXBJMBX03.zhaoxin.com (10.29.252.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 19:40:53 +0800
From: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <bhelgaas@google.com>,
	<robert.moore@intel.com>, <avadhut.naik@amd.com>, <yazen.ghannam@amd.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <acpica-devel@lists.linux.dev>
CC: <CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>, <ErosZhang@zhaoxin.com>,
	<LeoLiu-oc@zhaoxin.com>
Subject: [PATCH v4 3/3] PCI/ACPI: Add pci_acpi_program_hest_aer_params()
Date: Thu, 5 Dec 2024 19:40:48 +0800
X-ASG-Orig-Subj: [PATCH v4 3/3] PCI/ACPI: Add pci_acpi_program_hest_aer_params()
Message-ID: <20241205114048.60291-4-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205114048.60291-1-LeoLiu-oc@zhaoxin.com>
References: <20241205114048.60291-1-LeoLiu-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 12/6/2024 8:48:45 AM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1733446126
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 5221
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.134151
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>

Call the func pci_acpi_program_hest_aer_params() for every PCIe device,
the purpose of this function is to extract register value from HEST PCIe
AER structures and program them into AER Capabilities. This function
applies to all hardware platforms that has a PCI Express AER structure
in HEST.

Signed-off-by: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
---
 drivers/pci/pci-acpi.c | 103 +++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h      |   9 ++++
 drivers/pci/probe.c    |   1 +
 3 files changed, 113 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index af370628e583..6e29af8e6cc4 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -19,6 +19,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
 #include <linux/rwsem.h>
+#include <acpi/apei.h>
 #include "pci.h"
=20
 /*
@@ -806,6 +807,108 @@ int pci_acpi_program_hp_params(struct pci_dev *dev)
 	return -ENODEV;
 }
=20
+#ifdef CONFIG_ACPI_APEI
+/*
+ * program_hest_aer_common() - configure AER common registers for Root Por=
ts,
+ * Endpoints and PCIe to PCI/PCI-X bridges
+ */
+static void program_hest_aer_common(struct acpi_hest_aer_common aer_common=
,
+				    struct pci_dev *dev, int pos)
+{
+	u32 uncor_mask;
+	u32 uncor_severity;
+	u32 cor_mask;
+	u32 adv_cap;
+
+	uncor_mask =3D aer_common.uncorrectable_mask;
+	uncor_severity =3D aer_common.uncorrectable_severity;
+	cor_mask =3D aer_common.correctable_mask;
+	adv_cap =3D aer_common.advanced_capabilities;
+
+	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, uncor_mask);
+	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, uncor_severity);
+	pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, cor_mask);
+	pci_write_config_dword(dev, pos + PCI_ERR_CAP, adv_cap);
+}
+
+static void program_hest_aer_root(struct acpi_hest_aer_root *aer_root,
+				  struct pci_dev *dev, int pos)
+{
+	u32 root_err_cmd;
+
+	root_err_cmd =3D aer_root->root_error_command;
+
+	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, root_err_cmd);
+}
+
+static void program_hest_aer_bridge(struct acpi_hest_aer_bridge *hest_aer_=
bridge,
+				    struct pci_dev *dev, int pos)
+{
+	u32 uncor_mask2;
+	u32 uncor_severity2;
+	u32 adv_cap2;
+
+	uncor_mask2 =3D hest_aer_bridge->uncorrectable_mask2;
+	uncor_severity2 =3D hest_aer_bridge->uncorrectable_severity2;
+	adv_cap2 =3D hest_aer_bridge->advanced_capabilities2;
+
+	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK2, uncor_mask2);
+	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER2, uncor_severity2);
+	pci_write_config_dword(dev, pos + PCI_ERR_CAP2, adv_cap2);
+}
+
+static void program_hest_aer_params(struct hest_parse_aer_info info)
+{
+	struct pci_dev *dev;
+	int port_type;
+	int pos;
+	struct acpi_hest_aer_root *hest_aer_root;
+	struct acpi_hest_aer *hest_aer_endpoint;
+	struct acpi_hest_aer_bridge *hest_aer_bridge;
+
+	dev =3D info.pci_dev;
+	port_type =3D pci_pcie_type(dev);
+	pos =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+	if (!pos)
+		return;
+
+	switch (port_type) {
+	case PCI_EXP_TYPE_ROOT_PORT:
+		hest_aer_root =3D info.hest_aer_root_port;
+		program_hest_aer_common(hest_aer_root->aer, dev, pos);
+		program_hest_aer_root(hest_aer_root, dev, pos);
+	break;
+	case PCI_EXP_TYPE_ENDPOINT:
+		hest_aer_endpoint =3D info.hest_aer_endpoint;
+		program_hest_aer_common(hest_aer_endpoint->aer, dev, pos);
+	break;
+	case PCI_EXP_TYPE_PCI_BRIDGE:
+		hest_aer_bridge =3D info.hest_aer_bridge;
+		program_hest_aer_common(hest_aer_bridge->aer, dev, pos);
+		program_hest_aer_bridge(hest_aer_bridge, dev, pos);
+	break;
+	default:
+		return;
+	break;
+	}
+}
+
+int pci_acpi_program_hest_aer_params(struct pci_dev *dev)
+{
+	struct hest_parse_aer_info info =3D {
+		.pci_dev =3D dev
+	};
+
+	if (!pci_is_pcie(dev))
+		return -ENODEV;
+
+	if (apei_hest_parse(hest_parse_pcie_aer, &info) =3D=3D 1)
+		program_hest_aer_params(info);
+
+	return 0;
+}
+#endif
+
 /**
  * pciehp_is_native - Check whether a hotplug port is handled by the OS
  * @bridge: Hotplug port to check
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2e40fc63ba31..78bdc121c905 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -897,6 +897,15 @@ static inline void pci_save_aer_state(struct pci_dev *=
dev) { }
 static inline void pci_restore_aer_state(struct pci_dev *dev) { }
 #endif
=20
+#ifdef CONFIG_ACPI_APEI
+int pci_acpi_program_hest_aer_params(struct pci_dev *dev);
+#else
+static inline int pci_acpi_program_hest_aer_params(struct pci_dev *dev)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_ACPI
 bool pci_acpi_preserve_config(struct pci_host_bridge *bridge);
 int pci_acpi_program_hp_params(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2e81ab0f5a25..33b8b46ca554 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2304,6 +2304,7 @@ static void pci_configure_device(struct pci_dev *dev)
 	pci_configure_serr(dev);
=20
 	pci_acpi_program_hp_params(dev);
+	pci_acpi_program_hest_aer_params(dev);
 }
=20
 static void pci_release_capabilities(struct pci_dev *dev)
--=20
2.34.1


