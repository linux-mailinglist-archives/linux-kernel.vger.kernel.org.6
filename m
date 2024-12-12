Return-Path: <linux-kernel+bounces-442935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 372E89EE43C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62D81889688
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B44E211268;
	Thu, 12 Dec 2024 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gYcEND1q"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD2320E705
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733999597; cv=none; b=oXtRD4Ci1Am0QlwgZSpS65uxlMaw0/BD5S7EyYgQlrqOZZI7AG5Takwo0pLyJHPvcd45ljaO6mEnNPZNqA8WfDRJB0Hichyd6lVJ8ob7kEZVn0pgq7QTK2IFFLsBiUe38ACNCw3xqdeOfTFQ3EZygm2bAjJrsqjLeDlgV3Wh5zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733999597; c=relaxed/simple;
	bh=qILE2MwnvWLTTp/FHW54YyhNKkXwUyxZSZEtY+vSDf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LOYpnZtXVJ/15Qf1D+u+KYPpEAKwyiQFbaVNMp1jCZLFcxbXlledx7/Cwzn7GUUe799hc7JERPpp99GZyZw06EH/nnrvju/Ino5hmuGpD03bybTy+c8aOtZyQysY77cQSIBZGYQbHwEssOBnS4fJqcUwLJKhydJ86fiEZcjgXaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gYcEND1q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC2radG000539
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6DzLT8XtApn5HmF8cK1fM4LQEaxlwdnk14GwV5KnT9A=; b=gYcEND1qb8s6Qbeg
	idIfo7Y2QesDdo17Cnfe9RlN/nYlRGamCcHMM2J4g2sf7iCl69lxWgs8bpkgjY/K
	lPLCakima6ZIO8HVra05Xg3ZW8il68rvgUcSOw4oOS+HC9WA2aPScdYJzgr/h49u
	d42LTVomy5fjbjbQmqlh3MvfAPbwrbXAM5nRn1bm4pXho2zJHL6Q9OGRT0Q68kY3
	t1PbBKxNogEBmfTaxXNuz8Xqjh4ZyMkF+TcUxaAxSdsJPKSZorYvgVFl5cFJUZpH
	p6y46FS31IBAN+XgecYodsNy2Ql7ZNOGGzCNhXKrFosGas4xoVVIUDQA+a7XJIsG
	rVMqbQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fqes11xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:33:15 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2163d9a730aso4649575ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 02:33:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733999594; x=1734604394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DzLT8XtApn5HmF8cK1fM4LQEaxlwdnk14GwV5KnT9A=;
        b=tR5VQunUpYA4aZ4xPc3BuepCdGkllDcmeUl7ntPw+jsuzzgHttDacxgP/Z0U1NFU7b
         Qth4U7eusPyugBTDOIFP+KnNMG+vDUKksHbTosJC4vIqbdlupkXYA5aETkHpztMr9pzt
         f0dXzYybkVDabAt6D7hlNQOEwpHEoExawhxvy9wuo/vmFd0CpJlt5ZoMUCg0I2lf0E1g
         xD0U3CqKa5pP/SToD9M8O6i7ocxOFcZctvzrfh6uG/vO+jahC5WD3apXyYadZH2qREpE
         d8an0nJ/MNn2wYymy6D6+fDO4OXAWZO0QVhinM4qQgkYzgg2OEvOwo436e+SoShq+C7h
         fOAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbdLHTm1rl/KF/AxxEOqkorngZD7XO8O2oMIfLJzeaBejre4ooXpUmT366+eYsdIu8WMjluqnShuzFFfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyecHeCO+vX7BRSQmwcZE996MKNR5hnGA+CZa3QcpB7KlB3fDEn
	4RnM6zFQMnmge5lzFZQdciVPNMOoOngkd1tlOntGrURji7bAuPC2Q1CKReuX5ZQjQKl1vNibT75
	50lM4noyLvSLgRYNX7qUdCNTBxK9JcD1LFtPeA9ZqCRyEniIOLAOD+9LLpszHhjc=
X-Gm-Gg: ASbGncvkNcbL5n5+DeJTRGxaqO8YXSsNweFUSt5D+yBHaBulRfCPOwvs9e3+L+R4pQj
	OOcGXjQ8A75Bsr6BlIL0Hnvnez568Xxf9iTSxbuu6mTFDMvbo+KJNGIoGqM//8uUIswfpTn8X2P
	azZ5l+k0YXSUqC1cw7QEhmNAkYM+X0hizq5u6nax0JinlSkVMivqZSqv59NHR36CHrkAxOHTBZm
	WamhzaV2NyPfIIqJmIjjlNGc8nWDLxH5Jx9MS8bFU4BLOgFfbnb7F+SzTybW9e6nno9gp2KQ67Z
	kbKrNZw/SbmVwudj
X-Received: by 2002:a17:902:ce8d:b0:215:a2f4:d4ab with SMTP id d9443c01a7336-2178c830379mr36932175ad.7.1733999592697;
        Thu, 12 Dec 2024 02:33:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPuZmJVKvHCw+BNqGloDAUOaLcCy8jfzRck/CYjpB4SB+sb34PdsMiJMPNS5MD+Am5CTu0dw==
X-Received: by 2002:a17:902:ce8d:b0:215:a2f4:d4ab with SMTP id d9443c01a7336-2178c830379mr36931845ad.7.1733999592320;
        Thu, 12 Dec 2024 02:33:12 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2178db5b42asm11102335ad.244.2024.12.12.02.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 02:33:11 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 16:02:18 +0530
Subject: [PATCH v2 4/4] PCI: dwc: Add support for new pci function op
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-preset_v2-v2-4-210430fbcd8a@oss.qualcomm.com>
References: <20241212-preset_v2-v2-0-210430fbcd8a@oss.qualcomm.com>
In-Reply-To: <20241212-preset_v2-v2-0-210430fbcd8a@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        konrad.dybcio@oss.qualcomm.com, quic_mrana@quicinc.com,
        quic_vbadigan@quicinc.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733999565; l=1378;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=QUbB/2D6eOehtGMpEcAKcKS9W+U5FvUncY+bTnczvqs=;
 b=dwQ9PTO2Bv5z/S/aCvfgxVoeCrgNK6mnv0Jy5dawXlny01Mm/B7PVNX3KXk2+UTwPUUkFBXwS
 9NUkkj79tS8Bl9pr9Pe8Qw45Ly8gvMVvTGFPIW60WcJ0AQPicvOMchv
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: mPxo7h7JCWjfgGJuOMUZ2QHul51NkubB
X-Proofpoint-ORIG-GUID: mPxo7h7JCWjfgGJuOMUZ2QHul51NkubB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=914 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120074

From: Krishna chaitanya chundru <quic_krichai@quicinc.com>

Add the support for stop_link() & start_link() function op.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 2cd0acbf9e18..5f017b7ab932 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -694,10 +694,28 @@ void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
 }
 EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
 
+static int dw_pcie_host_start_link(struct pci_bus *bus)
+{
+	struct dw_pcie_rp *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	return dw_pcie_start_link(pci);
+}
+
+static void dw_pcie_host_stop_link(struct pci_bus *bus)
+{
+	struct dw_pcie_rp *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	dw_pcie_stop_link(pci);
+}
+
 static struct pci_ops dw_pcie_ops = {
 	.map_bus = dw_pcie_own_conf_map_bus,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
+	.start_link = dw_pcie_host_start_link,
+	.stop_link = dw_pcie_host_stop_link,
 };
 
 static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)

-- 
2.34.1


