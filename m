Return-Path: <linux-kernel+bounces-559371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 070FEA5F2DA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3443B44A8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E583268C5E;
	Thu, 13 Mar 2025 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cDV3EEl6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F022686A5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866095; cv=none; b=Kdiouew6JSKOfavm+gG/R1/SFs3KepUSpHQuTSl2fpvzHLtYClpudgfMxdAxCWolFigPxBr7QqGGiOBshKCYZBMwMjbHr1akxoZakr4J5Yfg9isO5LdrV6lOkirJz0Qsf9AVY+gg923YuXtO6rcMDjxoaRRv75G695biyHzK5kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866095; c=relaxed/simple;
	bh=3/AZwolXIW5cKbAxXRHbs5DefoIovq9yHb7EehF+eNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=akhSu78spt9MEzSE+4Ww41MIjyg5f2DAneJtA7sfmzFI/JQgWHxIDDTvwHvKe+iJ6X15t4mMMb55lYjTlJpQqaDQLTlaJXZV1bBBgJUSl4QHulmnhVZmuBhojdY3jbzQH3gI3C2c76YeiodNcm14EjXWOfWj2NE9iSjhMdyBbiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cDV3EEl6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D5cPqx020990
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v3zJCrBTVQCy9dIu5GFnMtWwOClfbTclT70zN522sBM=; b=cDV3EEl6LHcI+tEE
	nYMOuLEt4GrTFu9SKJ1fzC8b3NXiINfTHNbTONXbp9y59vpYsMvHiORnw/t43dUZ
	IMTqFbtxNqZ16inMGFgUWUkxTXOcphj8l/G5Up4ymI8oxBs0SLht0rCNTINqNcz4
	5EvsiCJnt7lGciLVGAYLro0IunvqiaLhgZB3awsjWbe5ecIkia2EUM60mQFwA5ef
	9dgoq7yz2Nef+7VopwENJvkebQDOAvLSyzwTuWWLjiLl5OcvPU3ltsa0VesyD0k7
	M6d6OAH0mtjCWxZcpi5pAheV7crU7/uYKyncmMG00NWW2GY4cpKaoT6WOVa1lb/q
	OQniLA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2pwphu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:41:32 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff82dd6de0so1609694a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 04:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866091; x=1742470891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3zJCrBTVQCy9dIu5GFnMtWwOClfbTclT70zN522sBM=;
        b=NjtjyKkkVkUmgDtfMGjQBCMscobsrFO7bbyQMTO7wE3nXaIAJBMTMdiEhSZ1Ko6aGc
         kutbwegTII7RWrTUeGt4QmFwvfUDmHe8BJYRVkEuf3V+7C7L+opgwTNlQBBBVaWhccuP
         6gBqqndBbzNE6boXRSeXH6qvSlYSfuwjVAqv+dou9EkFIbsAz+iHoYvk0HFFv4W4y3rB
         5WGV96Y0sRonyijQSqZjwMpO7CnTd8fys4/e3eiw2N7XvLLEs8auqMAtueKnUbPDGs6X
         MbU83mn1SkFUs3vjH7RqoYfznaHOeKeEJUxYJKgQPfJ8cZOvOapjsQ6fU722Q6PT841j
         kOvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcfmEMcCI2yLYxMGWgunnU+8cCa/NgkpcQHKUOFRvsK4X0QGMEzIGVFMgiTM0+CXt0XD2x6ijJ0VrN0Vs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9uvcR6g31cWzmDaIxeAdRuE2mk10D0vkugiABwR+lloBsBWfp
	apnr8z9EnmpMDLj9jJiIKjCAmL+jLMBwlMm7OvXf7zvp3+2UZVoaNGd6nYOJZQxwFGvzV/GD4Bd
	4SBvuMTCKLbuoczFq9bi3U57jXL/7N4m/DKSyxriA6uEuPdVvEppYPqNQi+FiNK8=
X-Gm-Gg: ASbGncs7qY6zWjBU81SrS6iAyp9EBz7LcYvxxs6Q0dzEafvRd+4qk0UDlD+7tAKwhZS
	xH6v/cgvHLo539Wou5KYoik79DvksdQ+SCZuioaNjuR5yTjv6vcrL1OKkOstCNGll0KtOiBZcQN
	ZpMCSn2UZ2PbOBs3zeIu62eXGah8QXZHkOImocNi8Fpa5gK8/zZkmAzaWczwT1SoZaHTQCiX7Aj
	gVvIf9/8zDti68eySD224FqVpOEFQOJWm86yR3qS1+RIRwLXHJVyb8Lr2T1NMR5QplM5MjoMCE2
	mIpGMMO1065XJGt18LdzbX7PA9ETiMJKbJN0U4v+5cet+oqP09g=
X-Received: by 2002:a05:6a20:ac43:b0:1f5:63f9:9ea1 with SMTP id adf61e73a8af0-1f563f9a1a8mr30614389637.13.1741866091330;
        Thu, 13 Mar 2025 04:41:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwj3JmLyPQkLsfI6gJoP4XbctAwSqw8uIKw7LM/Ne531+FcfnFHjbrNVL/Xv6msV1+SwyuBQ==
X-Received: by 2002:a05:6a20:ac43:b0:1f5:63f9:9ea1 with SMTP id adf61e73a8af0-1f563f9a1a8mr30614356637.13.1741866091000;
        Thu, 13 Mar 2025 04:41:31 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea964e3sm1063219a12.76.2025.03.13.04.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:41:30 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 13 Mar 2025 17:10:15 +0530
Subject: [PATCH v2 08/10] PCI: Export pci_set_target_speed()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-mhi_bw_up-v2-8-869ca32170bf@oss.qualcomm.com>
References: <20250313-mhi_bw_up-v2-0-869ca32170bf@oss.qualcomm.com>
In-Reply-To: <20250313-mhi_bw_up-v2-0-869ca32170bf@oss.qualcomm.com>
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
        quic_pyarlaga@quicinc.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741866038; l=676;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=3/AZwolXIW5cKbAxXRHbs5DefoIovq9yHb7EehF+eNw=;
 b=zKJq5M4CXyOL37AZbNCDJW0CpM7sEda2QrAhkTjI4dHnWBawjVpXTxfF1TYNjl2s8xVzpobQE
 r29Hg6xPtj8CEjejYXzE5f7H2PNfaT2RgMtYA/DAZvsKxlIqSBZXku3
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=P506hjAu c=1 sm=1 tr=0 ts=67d2c46c cx=c_pps a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=JOcJ30pghDwnvxMqNTgA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: uOGg3298B1aTsV5V06rayZydTd2hN1BN
X-Proofpoint-ORIG-GUID: uOGg3298B1aTsV5V06rayZydTd2hN1BN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=942 lowpriorityscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130092

Export pci_set_target_speed() so that other kernel drivers can use it
to change the PCIe data rate.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/pcie/bwctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index b1d660359553..0f4f68c170cd 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -214,6 +214,7 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(pcie_set_target_speed);
 
 static void pcie_bwnotif_enable(struct pcie_device *srv)
 {

-- 
2.34.1


