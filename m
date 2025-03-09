Return-Path: <linux-kernel+bounces-552899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF95AA580BB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 06:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6409E18906D6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 05:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635C352F88;
	Sun,  9 Mar 2025 05:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CWxto7e8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D514A3E
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 05:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741499170; cv=none; b=CpYF7d8wOc9fAEs1/LkKWtOfAnxFMS1Wwt6ziIBxXk6n9Lfxm1wDJ4IAx2vZvecOFmVtv2aH44QzXD9GeBgEhLDk6Zm5imGiUNO7pJsTkSZWJrGud4QNvz91VggFFtinKVkbPq6QJC5lvbBWwIC7HbCn6L2WFOnRPuuozSlepm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741499170; c=relaxed/simple;
	bh=qy3a3LhatXmhBiVGfseaHNNeFmAru0icw6KGdow2L6U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sQDpx3+CYcBkxC+TLJSCwJ3FCDrUQumYbEYgO6/oQoK8BMTxh7KWefTckME4ydurbJl+KMTuUL1yqW0387p9J4042r791g7hnR/PpFcUI9Hssto4SWTPx91gwLLW3tdOeAEhudjHEEKs+W36PJ2Xovp46BAliCGUxinWTs/NHqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CWxto7e8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5294oAof021846
	for <linux-kernel@vger.kernel.org>; Sun, 9 Mar 2025 05:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=7rDxeiLzUOR4yzkct3q3Hx
	wISzKuzG++MdmkzWiLy2Y=; b=CWxto7e81Agw7mn27Y2/iNbyFUBQ2vliwXLKJ0
	0S4AMwDt/eTVb+QfwwzDxAGZXgvsA0Pe/1caB3ozEs5QaPmpOAGN3y4wSKo1XfHg
	CNAcUC8Xq3sD3aU0mE6BfcUt2hsoijMwU8rqoWZPyBXsHe8oKulP7lXn/9mAtZUf
	h/Cw6dE4cCcdH8JqA1J3HqPmC/bXcpeT1VDFFEoUiOzHACH0eSGaa7g6hWZXDAfu
	g4ggq8V3TxZvw/CVwCfb/gHaMWik4DrtJue3EUp8iY8ldUzbspgZFHwvtyA5t42j
	sLY1HiWupdlomavOxDdCmuaoKK14hr+d3J/CT342iO+EthuA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458f0psp1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 05:46:07 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-225429696a9so27411055ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 21:46:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741499166; x=1742103966;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7rDxeiLzUOR4yzkct3q3HxwISzKuzG++MdmkzWiLy2Y=;
        b=tBcP75sfvez3Hvv4ngcMj/nprVVbVm1loJrupQZi6nh97A3HYKJkpNRkPqgdk0zoJh
         8b4lcW/mkuQcPP9G4hq8+Qulw7IxHhSxeiXYA2WwhN3pYkEmymRsqxEX/b7C4fnRaPVZ
         mgUw6FH9NQOpt+Vjx3bWasdNPQcyAzCS3JRaf0qA4UOjVofgkiZEHAERmmYGNdRUrGIU
         kSSdiridVR/6GNPggWAz3BZ19aTZ2i2VwaB/XWidNpk/ktxVFMLDLL3X54dPHXstK0Qw
         CgcLVNEYTmnLLKkAg+paS1khiqqFaiJL5rySbGGZS/YJUJrQhyNUnnwLDbjV7vS/F/7q
         Dq7g==
X-Forwarded-Encrypted: i=1; AJvYcCX5Jb/AFuZynA9t0BHqtQ1mxgoqDzxxoDkoXHorMmK/6FCaNXAgCWG4Fpvikr1Uo4OsAKlnpYlSY9/4wEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrXNoNCrCndmwFHxI7c4MpgP+pu2ibIZCKr5nO/xi+vn5ZH4bH
	42OEK+kIajsrz2ns/P4Avl1mLUmBrBNwhKQP42KGOb9dHsKcmAjrBCZC+bibmhahbw1mX6SH6Df
	4g8CV1rfYYQ0/KBKdojyoc4YPY43C0UBtlDwNHqf+QypnWC9/rsnyJ5voFC0OLRg=
X-Gm-Gg: ASbGncvuObuV9FT3c5mTldvkdrs/GDjy8U2lu2RQpdSvf1QZrMho5l9cKcxpsRYOoWD
	LwKl4jjDH9h5m7qygF8Ppqk+blW4FXqshid3Ayid2bc6AZF4SdCyJ3/xOe0FnE7yCozxvtc2rYQ
	E4dQYutlNow+HIQNr0kUHjnGfiUjYHy6rc15K1Z8mG/b7QrGs3DA3p6n53qlYeUPvqDQ2044IAS
	saLj8GeVDihKXGVOrtma92zU7YOEpzNaxiORltr1mjR6NTy672ET4UFoYLwcBEcyWEiMhfEtmUJ
	+udVZzEU8Rx3s1WCOV0l0Tr2Z8zM8GybNbsIFPfteQPgsG2EtN0=
X-Received: by 2002:a17:903:22c8:b0:220:cb6c:2e30 with SMTP id d9443c01a7336-22428ad565bmr149146785ad.49.1741499165970;
        Sat, 08 Mar 2025 21:46:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDZximE4vMb6xW2gdzO5/opmMvmOC9BaBFAwRe/SdmWmKoB3irb2IryAb3yHX/w3gKQ4AXkA==
X-Received: by 2002:a17:903:22c8:b0:220:cb6c:2e30 with SMTP id d9443c01a7336-22428ad565bmr149146425ad.49.1741499165519;
        Sat, 08 Mar 2025 21:46:05 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ddbe7sm54887145ad.32.2025.03.08.21.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 21:46:04 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v5 0/7] PCI: dwc: Add ECAM support with iATU configuration
Date: Sun, 09 Mar 2025 11:15:22 +0530
Message-Id: <20250309-ecam_v4-v5-0-8eff4b59790d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPIqzWcC/2WM0QrCIBiFX2X81znMlGVXvUeMUPev/ZBzaUkxf
 Pdst8HhwHc4fCskjIQJTs0KETMlCnMFtWvATWa+IaOhMgguFBe8Y+iMv2bJRolW26M+IFqo7yX
 iSO/NdOkrT5SeIX42cZa/9d9Rw5mWVg0KneL77hxSah8vc3fB+7YW9KWUL/bhhHKlAAAA
To: cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741499159; l=4752;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=qy3a3LhatXmhBiVGfseaHNNeFmAru0icw6KGdow2L6U=;
 b=iRvbxORLMVOnGBDgjBm5+tfGCMfr1FOcAA/1PUf3cXc4AiiAZZ0V7476WKFR0syX5KCtnkMGc
 VgMIfrmuQo/C/k8c694pqvgtsmTRDhEIW+nx+rF8o38Afk9R8ObL7WM
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: LxDPzNJXN7KhFKlAIdTWsDT-cNGoao6b
X-Authority-Analysis: v=2.4 cv=KK2gDEFo c=1 sm=1 tr=0 ts=67cd2b1f cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=7ZRfWG0Ds4o22ekFdNEA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: LxDPzNJXN7KhFKlAIdTWsDT-cNGoao6b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-09_02,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503090043

The current implementation requires iATU for every configuration
space access which increases latency & cpu utilization.

Designware databook 5.20a, section 3.10.10.3 says about CFG Shift Feature,
which shifts/maps the BDF (bits [31:16] of the third header DWORD, which
would be matched against the Base and Limit addresses) of the incoming
CfgRd0/CfgWr0 down to bits[27:12]of the translated address.

Configuring iATU in config shift mode enables ECAM feature to access the
config space, which avoids iATU configuration for every config access.

Add cfg_shft_mode into struct dw_pcie_ob_atu_cfg to enable config shift mode.

As DBI comes under config space, this avoids remapping of DBI space
separately. Instead, it uses the mapped config space address returned from
ECAM initialization. Change the order of dw_pcie_get_resources() execution
to acheive this.

Enable the ECAM feature if the config space size is equal to size required
to represent number of buses in the bus range property.

ELBI registers are optional registers which are part of dwc. So move
ELBI resource mapping to dwc. Also change the dtbinding and devicetree
to make the elbi registers as optional one. Having ELBI as the required
one is making the ecam feature complicated.

The ELBI registers falls after the DBI space, PARF_SLV_DBI_ELBI register
gives us the offset from which ELBI starts. so use this offset and cfg
win to map these regions instead of doing the ioremap again.

On root bus, we have only the root port. Any access other than that
should not go out of the link and should return all F's. Since the iATU
is configured for the buses which starts after root bus, block the
transactions starting from function 1 of the root bus to the end of
the root bus (i.e from dbi_base + 4kb to dbi_base + 1MB) from going
outside the link through ECAM blocker through PARF registers.

Increase the configuration size to 256MB as required by the ECAM feature
and also move config space, DBI, iATU to upper space and use lower space
entirely for BAR region.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v5:
- Make elbi as optional and move resource mapping to the dwc (Mani)
- Make the changes in the code as we made elbi as optional.
- Link to v4: https://lore.kernel.org/r/20250207-ecam_v4-v4-0-94b5d5ec5017@oss.qualcomm.com

Changes in v4:
- Update the commit messgaes and do minor code changes like adding
  export for the api, adding error message( mani)
- Link to v3: https://lore.kernel.org/all/20250121-enable_ecam-v3-0-cd84d3b2a7ba@oss.qualcomm.com/
Changes in v3:
- if bus range is less than 2 return with out configuring iATU for next
  bus & update the logic of ecam_supported() as suggested ( Konrad)
- updated commit text and update S-o-b (Bjorn Andresson)
- Link to v2: https://lore.kernel.org/r/20241224-enable_ecam-v2-0-43daef68a901@oss.qualcomm.com

changes in v2:
- rename enable_ecam to ecam_mode as suggested by mani.
- refactor changes as suggested by bjorn
- remove ecam_init() function op as we have removed ELBI virtual address
update from the ecam_init and moved to host init as we need the clocks
to be enabled to read the ELBI offset from the PARF registers.
- Update comments and commit message as suggested by bjorn.
- Allocate host bridge in the DWC glue drivers as suggested by bjorn
- move qcom_pcie_ecam_supported to dwc as suggested by mani.
Link to v1: https://lore.kernel.org/r/linux-devicetree/20241117-ecam-v1-1-6059faf38d07@quicinc.com/T/

---
Krishna Chaitanya Chundru (7):
      arm64: dts: qcom: sc7280: Increase config size to 256MB for ECAM feature
      dt-bindings: PCI: qcom,pcie-sc7280: Make elbi register as an optional
      arch: arm64: qcom: sc7280: Remove optional elbi register
      PCI: dwc: Add support for ELBI resource mapping
      PCI: dwc: qcom: Switch to dwc ELBI resource mapping
      PCI: dwc: Add ECAM support with iATU configuration
      PCI: qcom: Add support for ECAM feature

 .../devicetree/bindings/pci/qcom,pcie-sc7280.yaml  |   9 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |  13 +-
 drivers/pci/controller/dwc/Kconfig                 |   1 +
 drivers/pci/controller/dwc/pcie-designware-host.c  | 134 ++++++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.c       |  11 +-
 drivers/pci/controller/dwc/pcie-designware.h       |   6 +
 drivers/pci/controller/dwc/pcie-qcom.c             |  76 ++++++++++--
 7 files changed, 211 insertions(+), 39 deletions(-)
---
base-commit: 0f52fd4f67c67f7f2ea3063c627e466255f027fd
change-id: 20250207-ecam_v4-f4eb9b893eeb

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


