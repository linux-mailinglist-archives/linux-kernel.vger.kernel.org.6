Return-Path: <linux-kernel+bounces-517062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29487A37B83
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D076168F81
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 06:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A18B1A3152;
	Mon, 17 Feb 2025 06:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lpgZ3EW0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2419519D8A4
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739774076; cv=none; b=c4mJs6KjAIxN7iF/6j0+6GrHTXfMTTdr6WHOokzmL9gXUWZm44J7KzBnHouyluA61hCYvb/+2XeILNvmTvtvsYg0+DB09Jklbwi/Rjxf2JeQ1/uGXdhqeT69LIT9mXadLwWEN9DV4BNuQquPmLYK84tOVBTxGR8/uDJu5N2lc3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739774076; c=relaxed/simple;
	bh=PmKuDjh7TYnL36BsL4uFK3e2cvQCdB+O1CmCQrAD7C4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XKawL8fuJpiSWN9clevYu4mlZKkOQUT0tmQZSfAzgZ5N+zVteo4amic2leXb4twMxshR172DU1TGXSMQkYO8kJkHK8JmM6iAE7qc2pM8rN5cNC1305dXogU27+Bb0kra1xYD5kJcG5fAkz5CEOq3F5EkdpcytG4Vd1jhMuyNmrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lpgZ3EW0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51H0m2Wp015302
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9igTd27vOSt75Vx+/a3cETdMPX96Kxrxr1+ntLhQKa0=; b=lpgZ3EW0mpxwv0E+
	gOQua5pAEUvV8uXKt1DFU5yZi9T70izQxPhRTgxYwuaykNzHK7K+x9p+kp6RGPG6
	vGAH78mWGghvsA37SywtIrcO9orkbPba3eY/r+lkUeOI3bt4ha+6lewAp5FoT9+w
	mIg8ZK3Xoz+3cKR58j8ELCl81IHXBbC6tnbi9TV8rle4eUdH6R4gkwzAfcKWKV4R
	hX96s/lVoNo/uAGaeH4QzeTAU3UpqlEr9RuHuamen/XcSwNrVXmLgqhmoBxgKjQf
	wVY8Zfr3X/HamYup4fC/pDhTYeiPOE+mxhoVoTxjJY4vIiqCFXru98FFpwaD96iu
	v0pr/g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ut7s0pjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:34:34 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc0bc05bb5so8335138a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 22:34:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739774074; x=1740378874;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9igTd27vOSt75Vx+/a3cETdMPX96Kxrxr1+ntLhQKa0=;
        b=ktJcx5wtQyiu9YqNr+U/T6lMGMJDJDVr40BVI93Xuo/Opdc4l2nYTV1cq/44WEoFKy
         7Q2LeII4/R2eGMXsZgj9N5ap8VXmgCpTripURH63RzsrHu67yJzF+9htTbIc3wba4npf
         uSOqXW/tf0eWrrUjLqlK75jpbMs473QUP3HKdABLRedSgzO4j2xrPu6IehYYTdnxIaqP
         FDjIKPgEI2TdVbFGQdGdYQtruKDoqseyQmckX7sEyj/x4nSHiDM7lUcbaSeku5q36+EJ
         q5US77zGf79T6ZlKWI6IRzK89oW/JBcA8zWroekxcylplYK920vwqv9b0bTo8KmuedEO
         n0jw==
X-Forwarded-Encrypted: i=1; AJvYcCUcdzN8U9NL5QNPs/F0RbSKjKKYDmswCj+uI4uTNXz2CFRgxynorc5RDWjUGsnUJJEoFhPdlkxONUihPzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKJ56Qdu3pQa9zXvUqxmnfl3wwtahbgJtZ1mhUBa5R/Ss3wzlb
	zQX81UYKNZSTaiae9ErC/sxIEuh5f0m2d1tka9qe0+F7raKeWuDCVTTySX6fa3FtAOUF3EW/zSm
	HJxosC53LMca4Shht3zUOf9ufC0Wu33qhBSlOLfPl4ub/6wUdEjfNI3Vxo9ZZHHc=
X-Gm-Gg: ASbGncs+APk92CxjwEMN923jzRncXikKgrWDnsQjHqP+FFRFnV7PxvjEuTO6DTcxsgW
	T/zYYqhQQd5qBKkt0iI0VPMUNp68DPzIbwcFWFg+5BMbkxhtb5b0PR7D1KojrtYfmKJ0sJ/JV/F
	RAeeJqOqaIZC7kOWclJ+3yidZ6ZEIohEuvSWOk18empkDW6jGCvl+Wy2t1q/uLCA9wuOaODFh3x
	ST0IexNegWRJqvfvFZ8uqBcCmZstuLNoJqrvV0spQkj4G77EkOuqYeYnhZYrFVvFXIMBd8zfGp3
	TMRDZtG0C2IrKPPi0dgcQzk3aIAtJbCu1xDMMTBO
X-Received: by 2002:a05:6a00:3e0c:b0:730:75b1:7218 with SMTP id d2e1a72fcca58-732618c1ec6mr14974770b3a.16.1739774073592;
        Sun, 16 Feb 2025 22:34:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHafDTAFp1GvU3CHv9ZBptsIxiiNWeH9I/2oU2Kp5bCj1qR25DKxmHgRfZiANV5piuH5zfVkA==
X-Received: by 2002:a05:6a00:3e0c:b0:730:75b1:7218 with SMTP id d2e1a72fcca58-732618c1ec6mr14974721b3a.16.1739774073159;
        Sun, 16 Feb 2025 22:34:33 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73263b79287sm3771800b3a.29.2025.02.16.22.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 22:34:32 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 17 Feb 2025 12:04:10 +0530
Subject: [PATCH 3/8] PCI: dwc: Implement .pre_scale_bus_bw() &
 .post_scale_bus_bw hook
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-mhi_bw_up-v1-3-9bad1e42bdb1@oss.qualcomm.com>
References: <20250217-mhi_bw_up-v1-0-9bad1e42bdb1@oss.qualcomm.com>
In-Reply-To: <20250217-mhi_bw_up-v1-0-9bad1e42bdb1@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        quic_jjohnson@quicinc.com, quic_pyarlaga@quicinc.com,
        quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com,
        quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739774050; l=2235;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=PmKuDjh7TYnL36BsL4uFK3e2cvQCdB+O1CmCQrAD7C4=;
 b=klwj+7NCfeWvDoVYvXPeVg69yujP2GAfYPvAEuiF+KnPezPhilQ8VrheQA2mmkJNa+z/rwiGr
 7Ap/JoRXXsNBio5kxhs4s02TShlZdF+K/JhEklaBhvKYW0tWNirUE6I
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: a6wB7YY7Wpi7_oHaQtholvObxttMX12Z
X-Proofpoint-ORIG-GUID: a6wB7YY7Wpi7_oHaQtholvObxttMX12Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502170056

Add support for pre_scale_bus_bw() & post_scale_bus_bw() function op's.
Add support for DWC glue drivers to register for these ops.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 21 +++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h      |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index ffaded8f2df7..4da4df62c3f8 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -697,10 +697,31 @@ void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
 }
 EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
 
+static int dw_pcie_pre_scale_bus_bw(struct pci_bus *bus, int target_speed)
+{
+	struct dw_pcie_rp *pp = bus->sysdata;
+	int ret = 0;
+
+	if (pp->ops->pre_scale_bus_bw)
+		ret = pp->ops->pre_scale_bus_bw(pp, target_speed);
+
+	return ret;
+}
+
+static void dw_pcie_post_scale_bus_bw(struct pci_bus *bus, int current_speed)
+{
+	struct dw_pcie_rp *pp = bus->sysdata;
+
+	if (pp->ops->pre_scale_bus_bw)
+		pp->ops->post_scale_bus_bw(pp, current_speed);
+}
+
 static struct pci_ops dw_pcie_ops = {
 	.map_bus = dw_pcie_own_conf_map_bus,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
+	.pre_scale_bus_bw = dw_pcie_pre_scale_bus_bw,
+	.post_scale_bus_bw = dw_pcie_post_scale_bus_bw,
 };
 
 static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 501d9ddfea16..16e02646a8b4 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -354,6 +354,8 @@ struct dw_pcie_host_ops {
 	void (*post_init)(struct dw_pcie_rp *pp);
 	int (*msi_init)(struct dw_pcie_rp *pp);
 	void (*pme_turn_off)(struct dw_pcie_rp *pp);
+	int (*pre_scale_bus_bw)(struct dw_pcie_rp *pp, int target_speed);
+	void (*post_scale_bus_bw)(struct dw_pcie_rp *pp, int current_speed);
 };
 
 struct dw_pcie_rp {

-- 
2.34.1


