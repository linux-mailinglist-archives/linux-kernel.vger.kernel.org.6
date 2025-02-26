Return-Path: <linux-kernel+bounces-535231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA531A4705D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFF3188D784
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A882F18AFC;
	Thu, 27 Feb 2025 00:37:56 +0000 (UTC)
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EB0482EF
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616676; cv=none; b=Z4dPbk4p/tDW3wgEadmNN81uHk8m0KM5ZrGNOCVm3n6QLq0C37ASAWsZU8dzgKsmx0Ta+7eEs+OAQpy1xZCtHgILaRxNxJKSURZ8is4mbPGCqK8niycrZfTW0kbxP04CxdRt9q5QDIQ1VmcNWyW/X7oC3xctOvAlK2HMAPpsifs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616676; c=relaxed/simple;
	bh=xf6aa909pkiri3/XbRp02yuy6janMrg6fh9L8J/CqZg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XllkLgZmZw3YmFwvwjzuthEN91HImYzCmFvV5cpnDeNHNfzHIqJQpx81yGue9E9A2yp/hOvzjy0+yETmrr3L4Ffp/M6KxO3Ip2u/T1QEjqbjLu/YPlLIpVZ1kuOxFDi8L15ED9/UktrMQXRwskXnKTvrd1E/R+z/QlTha5RGV1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1740616661-1eb14e79ff31220001-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id eI7UeMFzGx2DDqYp (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 27 Feb 2025 08:37:41 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Thu, 27 Feb
 2025 08:37:41 +0800
Received: from ZXSHMBX2.zhaoxin.com ([fe80::4dfc:4f6a:c0cf:4298]) by
 ZXSHMBX2.zhaoxin.com ([fe80::4dfc:4f6a:c0cf:4298%4]) with mapi id
 15.01.2507.044; Thu, 27 Feb 2025 08:37:41 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from xin.lan (10.32.64.1) by ZXBJMBX03.zhaoxin.com (10.29.252.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 26 Feb
 2025 20:18:54 +0800
From: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <bhelgaas@google.com>,
	<robert.moore@intel.com>, <yazen.ghannam@amd.com>, <avadhut.naik@amd.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <acpica-devel@lists.linux.dev>
CC: <CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>, <ErosZhang@zhaoxin.com>,
	<leoliu@zhaoxin.com>, LeoLiuoc <LeoLiu-oc@zhaoxin.com>
Subject: [PATCH v5 2/4] ACPI: APEI: Add new hest_parse_pcie_aer()
Date: Wed, 26 Feb 2025 20:18:36 +0800
X-ASG-Orig-Subj: [PATCH v5 2/4] ACPI: APEI: Add new hest_parse_pcie_aer()
Message-ID: <20250226121838.364533-3-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226121838.364533-1-LeoLiu-oc@zhaoxin.com>
References: <20250226121838.364533-1-LeoLiu-oc@zhaoxin.com>
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
X-Moderation-Data: 2/27/2025 8:37:40 AM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1740616661
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 3598
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.137756
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>

The purpose of the function apei_hest_parse_aer() is used to parse and
extract register value from HEST PCIe AER structures. This applies to
all hardware platforms that has a PCI Express AER structure in HEST.

Signed-off-by: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
---
 drivers/acpi/apei/hest.c | 52 +++++++++++++++++++++++++++++++++++++++-
 include/acpi/apei.h      | 11 +++++++++
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 35d08f4e50e6..e7a15d60ecc1 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -22,6 +22,7 @@
 #include <linux/kdebug.h>
 #include <linux/highmem.h>
 #include <linux/io.h>
+#include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <acpi/apei.h>
 #include <acpi/ghes.h>
@@ -132,7 +133,56 @@ static bool is_ghes_assist_struct(struct acpi_hest_hea=
der *hest_hdr)
 	return false;
 }
=20
-typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *d=
ata);
+static bool hest_match_pci_devfn(struct acpi_hest_aer_common *p, struct pc=
i_dev *dev)
+{
+	return ACPI_HEST_SEGMENT(p->bus) =3D=3D pci_domain_nr(dev->bus) &&
+	       ACPI_HEST_BUS(p->bus)     =3D=3D dev->bus->number &&
+	       p->device                 =3D=3D PCI_SLOT(dev->devfn) &&
+	       p->function               =3D=3D PCI_FUNC(dev->devfn);
+}
+
+static bool hest_source_is_pcie_aer(struct acpi_hest_header *hest_hdr, str=
uct pci_dev *dev)
+{
+	u16 hest_type =3D hest_hdr->type;
+	u8 pcie_type =3D pci_pcie_type(dev);
+	struct acpi_hest_aer_common *common =3D (struct acpi_hest_aer_common *)(h=
est_hdr + 1);
+
+	switch (hest_type) {
+	case ACPI_HEST_TYPE_AER_ROOT_PORT:
+		if (pcie_type !=3D PCI_EXP_TYPE_ROOT_PORT)
+			return false;
+		break;
+	case ACPI_HEST_TYPE_AER_ENDPOINT:
+		if (pcie_type !=3D PCI_EXP_TYPE_ENDPOINT)
+			return false;
+		break;
+	case ACPI_HEST_TYPE_AER_BRIDGE:
+		if (pcie_type !=3D PCI_EXP_TYPE_PCI_BRIDGE && pcie_type !=3D PCI_EXP_TYP=
E_PCIE_BRIDGE)
+			return false;
+		break;
+	default:
+		return false;
+	}
+
+	if (common->flags & ACPI_HEST_GLOBAL)
+		return true;
+
+	if (hest_match_pci_devfn(common, dev))
+		return true;
+
+	return false;
+}
+
+int hest_parse_pcie_aer(struct acpi_hest_header *hest_hdr, void *data)
+{
+	struct hest_parse_aer_info *info =3D data;
+
+	info->data =3D (void *)hest_hdr;
+	if (!hest_source_is_pcie_aer(hest_hdr, info->pci_dev))
+		return 0;
+	else
+		return 1;
+}
=20
 int apei_hest_parse(apei_hest_func_t func, void *data)
 {
diff --git a/include/acpi/apei.h b/include/acpi/apei.h
index b79976daa4bb..047e0469927c 100644
--- a/include/acpi/apei.h
+++ b/include/acpi/apei.h
@@ -23,6 +23,11 @@ enum hest_status {
 	HEST_NOT_FOUND,
 };
=20
+struct hest_parse_aer_info {
+	struct pci_dev *pci_dev;
+	void *data;
+};
+
 extern int hest_disable;
 extern int erst_disable;
 #ifdef CONFIG_ACPI_APEI_GHES
@@ -33,12 +38,18 @@ void __init acpi_ghes_init(void);
 static inline void acpi_ghes_init(void) { }
 #endif
=20
+typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *d=
ata);
 int apei_hest_parse(apei_hest_func_t func, void *data);
=20
 #ifdef CONFIG_ACPI_APEI
 void __init acpi_hest_init(void);
+int hest_parse_pcie_aer(struct acpi_hest_header *hest_hdr, void *data);
 #else
 static inline void acpi_hest_init(void) { }
+static inline int hest_parse_pcie_aer(struct acpi_hest_header *hest_hdr, v=
oid *data)
+{
+	return 0;
+}
 #endif
=20
 int erst_write(const struct cper_record_header *record);
--=20
2.34.1


