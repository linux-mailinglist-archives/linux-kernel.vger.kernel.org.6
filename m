Return-Path: <linux-kernel+bounces-442933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2279EE430
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5159818885D6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FD721146D;
	Thu, 12 Dec 2024 10:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f+L55Mk6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0942116E3
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733999586; cv=none; b=AW7T7daFSvUT4WviCpAANiVB4VAlR0g2pavF7W3LVSpr0mgkoH6Ivz1JR/73O4B0wEynMZYe5WbifGRwLzihQVco9EL3bSzuS8q/YtISdbuwweOym4Uvl+ojX4oeR6NA/dJKONSO10GE7MXydrWPEwa+hwuBelpoJrXanSgonnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733999586; c=relaxed/simple;
	bh=QKNNat4Xz6oJczk45zawgjOmWgMt/p7pEWit3Ti1Jhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uUzi6NWlE57PtfoqFQgaTcFN4WI1b7vwAXgW7D8BTBMlsI4Loz2uBXyAD2ONZXyndqr/liOqQVIMCbmQICpH6EHoBkEp5ErlFWeQIw4HwoD+dEmPQqWw8f/a/4O8nHFA3TneVB/ofPRQis3eCj4rAgWM4QpGnfxPp8p7ZC1Zcps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f+L55Mk6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC7u1cq002236
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6f59+Uz0icxznPBKS40QHhxDYGmC2sNYJS/NXuMmpys=; b=f+L55Mk6SHS5KxNy
	KhYZe4o3HbPcEVCGb7g50G8sjUEkOZO1lcQqiulV0zvIs5cUs1AwFSQQWPrfWyF1
	J0VU1J6J35p2pIj5MXgXRabi3Swru0hTL7Ky9BSokf0li8vCPb3VBC7J8S/aJe0Q
	hFjsF6Aak99i2SDWFWOn+gZgHjEkb6xrjEhrp5HA7C7GyuD1yqFoZ9lofW3RcHvG
	iqdrYjJkgi6gs9EL+Bz0vJ/J0quSkKJW3wLy4fq+ddEpuexmJjFWRlKF456OlptF
	nz8JhG9FZlgzl3R1tvEZONbhkuuRbD047fGpa+thpTR4vfFL6u/Aos8VYuiMeMrr
	6U/baw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43eyg653de-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:33:03 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21648ddd461so5565265ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 02:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733999582; x=1734604382;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6f59+Uz0icxznPBKS40QHhxDYGmC2sNYJS/NXuMmpys=;
        b=vuT2hnmlPJNdgQu1rKqgfSqGpQzOb3/4y9wU2+b/UdHpSpF6CXYzTEqMRWyvf75vYt
         98S63AiVouw7GRbJY9JgVaU0M+e7zP8O/8wDvdLg8tvpZCr7qt7CIP+39d0A1aghx/q/
         BGPMnSJ1C3P3pMANsWz2OXx+60tkoGPtNJS40tX3wqC/oId/H+B1GP+iWmv2zxZklZvQ
         6OF/Wn85JkqFjq8Z6qvHGKToe0jG33A40t4V34g42vaIQjmp9maoJpd0hdYL+ozuDJRW
         aIW6r65UWmh+KcDQ/dCr2G1XS5f7dUt+NYGaGtX97saWY7sinwUt5MvnbGt23AiWz3ei
         3QqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLMYwt9MWTnlaNjC6nkafEXn0edNxbxa2n/EZxrRU8oSed2RFZzACqEwulZ4aayOJzQnMUE2tiCoCoaAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDdOT/QgKxR+FWUp8pquX9GGrwW+qt5669HcSy0YjT4LRV6ab+
	HrjGUVNhCvtUvPBRNtv4msIMaTftIWOa1WiNq5y6qajTXiciooCIvKFl0QtqVX6Fzox2WJM3k4C
	Ju2LHBAjDFQvv4U7GUIKEEMBMVXmr3GDteeILlnleIriEa7MYVCePnyB93Vqy8jc=
X-Gm-Gg: ASbGncv2cwNzohGEMqqA3H/jxcbNTt5HERewW8vCFVbY6HiWTYmjRevPNmRab229RAW
	rq7DHdQlRNOKt7E9I0NC7knhhpbfCyD5TmtsRTibl7utsibs6n33XTBCiXe11LNXTaDrkviPCJ0
	S+wppBV9GC81v4cWzXBAzaJSk7cSmuYKlyhjwSsdBfkZIjODk+AZuLEG4zwy3J435Sdug5KTP3E
	xi8fmpaKUC2ti4DMxs3qJX0Z+vxqpp6B4AKyC5rNcV697FlU5TtLqsGuuryXH2tyE1pA3se1a1Y
	A1KgWcvla9duF/zz
X-Received: by 2002:a17:902:f68f:b0:215:2f00:67b1 with SMTP id d9443c01a7336-2177852005amr91703455ad.6.1733999582021;
        Thu, 12 Dec 2024 02:33:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElanJ8KkR3sCWlb0GFEATrawGXJB1omKXePD/LX/rTbd5LgqiTium01uUQCjp1zG2hz9q8YA==
X-Received: by 2002:a17:902:f68f:b0:215:2f00:67b1 with SMTP id d9443c01a7336-2177852005amr91703135ad.6.1733999581629;
        Thu, 12 Dec 2024 02:33:01 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2178db5b42asm11102335ad.244.2024.12.12.02.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 02:33:01 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 16:02:16 +0530
Subject: [PATCH v2 2/4] PCI: of: Add API to retrieve equalization presets
 from device tree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-preset_v2-v2-2-210430fbcd8a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733999565; l=4075;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=BTyoDXzoLq9s40NBa/pshroRWzYAGvXUT/nxju8J8D0=;
 b=nVg9cssNaQJ9+5SJTZAjsoxOtUvy8tYvhLTbHmdNdffFV9SKzEw+2nrOjQ1fRbr950FjIAWhj
 4dQQDRCIdSKAtKZxhXpjwHYT0v12HBhDr+ihQ37E3gwobNfUZwM74jx
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: WiRAEaQvOOX3jRrYj2fBwpXXrd8aG4Ly
X-Proofpoint-ORIG-GUID: WiRAEaQvOOX3jRrYj2fBwpXXrd8aG4Ly
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120074

From: Krishna chaitanya chundru <quic_krichai@quicinc.com>

PCIe equalization presets are predefined settings used to optimize
signal integrity by compensating for signal loss and distortion in
high-speed data transmission.

As per PCIe spec 6.0.1 revision section 8.3.3.3 & 4.2.4 for data rates
of 8.0 GT/s, 16.0 GT/s, 32.0 GT/s, and 64.0 GT/s, there is a way to
configure lane equalization presets for each lane to enhance the PCIe
link reliability. Each preset value represents a different combination
of pre-shoot and de-emphasis values. For each data rate, different
registers are defined: for 8.0 GT/s, registers are defined in section
7.7.3.4; for 16.0 GT/s, in section 7.7.5.9, etc. The 8.0 GT/s rate has
an extra receiver preset hint, requiring 16 bits per lane, while the
remaining data rates use 8 bits per lane.

Based on the number of lanes and the supported data rate, this function
reads the device tree property and stores in the presets structure.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/of.c  | 45 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h | 17 +++++++++++++++--
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index dacea3fc5128..99e0e7ae12e9 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -826,3 +826,48 @@ u32 of_pci_get_slot_power_limit(struct device_node *node,
 	return slot_power_limit_mw;
 }
 EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
+
+int of_pci_get_equalization_presets(struct device *dev,
+				    struct pci_eq_presets *presets,
+				    int num_lanes)
+{
+	char name[20];
+	void **preset;
+	void *temp;
+	int ret;
+
+	if (of_property_present(dev->of_node, "eq-presets-8gts")) {
+		presets->eq_presets_8gts = devm_kzalloc(dev, sizeof(u16) * num_lanes, GFP_KERNEL);
+		if (!presets->eq_presets_8gts)
+			return -ENOMEM;
+
+		ret = of_property_read_u16_array(dev->of_node, "eq-presets-8gts",
+						 presets->eq_presets_8gts, num_lanes);
+		if (ret) {
+			dev_err(dev, "Error reading eq-presets-8gts %d\n", ret);
+			return ret;
+		}
+	}
+
+	for (int i = 1; i < sizeof(struct pci_eq_presets) / sizeof(void *); i++) {
+		snprintf(name, sizeof(name), "eq-presets-%dgts", 8 << i);
+		if (of_property_present(dev->of_node, name)) {
+			temp = devm_kzalloc(dev, sizeof(u8) * num_lanes, GFP_KERNEL);
+			if (!temp)
+				return -ENOMEM;
+
+			ret = of_property_read_u8_array(dev->of_node, name,
+							temp, num_lanes);
+			if (ret) {
+				dev_err(dev, "Error %s %d\n", name, ret);
+				return ret;
+			}
+
+			preset = (void **)((u8 *)presets + i * sizeof(void *));
+			*preset = temp;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 14d00ce45bfa..82362d58bedc 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -731,7 +731,12 @@ static inline u64 pci_rebar_size_to_bytes(int size)
 }
 
 struct device_node;
-
+struct pci_eq_presets {
+	void *eq_presets_8gts;
+	void *eq_presets_16gts;
+	void *eq_presets_32gts;
+	void *eq_presets_64gts;
+};
 #ifdef CONFIG_OF
 int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
 int of_get_pci_domain_nr(struct device_node *node);
@@ -746,7 +751,9 @@ void pci_set_bus_of_node(struct pci_bus *bus);
 void pci_release_bus_of_node(struct pci_bus *bus);
 
 int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge);
-
+int of_pci_get_equalization_presets(struct device *dev,
+				    struct pci_eq_presets *presets,
+				    int num_lanes);
 #else
 static inline int
 of_pci_parse_bus_range(struct device_node *node, struct resource *res)
@@ -793,6 +800,12 @@ static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_br
 	return 0;
 }
 
+static inline int of_pci_get_equalization_presets(struct device *dev,
+						  struct pci_eq_presets *presets,
+						  int num_lanes)
+{
+	return 0;
+}
 #endif /* CONFIG_OF */
 
 struct of_changeset;

-- 
2.34.1


