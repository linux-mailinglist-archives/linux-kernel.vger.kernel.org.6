Return-Path: <linux-kernel+bounces-530878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ED8A439C2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A67189A00A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139FE2641D4;
	Tue, 25 Feb 2025 09:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KVpJPcpr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAABF263F2F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476091; cv=none; b=bELhxx6bbbDiP7T7MUKs+Ldsyj+bPB9/sVCcPP919coF/rI2VmXAfwc7mvDtSj2uhupcYgv0PhAYIPquN3aWN/EIaP1Jm9MTYTyoBFptfLYv9313ImCg8qtHwRsTyvpkmkJl13fqA0n8hAdpOiFH1+4c2gttKrRjp3sx1yrErdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476091; c=relaxed/simple;
	bh=oouLjGtH233lwoGhCTipl0h9nbjcJt//bXzApe/ONc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gauy+ZIDF1XJQ907qG1OM1m6VkH4MOQ62bz3r+AfZj0V2E1ntn8h4RhWR/uzxtC1IWGldqCXXq2W4y4vBSJy4ZBcN1MQpocoVE1mvS9XsLhehQrDBtI56hhJkKJDuKyOJZfG/NHIqwW8EF15pxoZyXJTBx9fI+H+zVsOrIAUNv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KVpJPcpr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P8KmVL013877
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HSIJQ7jaFX6kCm1/h4SN9ZCiGBfl+wZu7rF9036LeAg=; b=KVpJPcprwsBl1cuT
	vVLv9LNMlBonLDMlxDG6pufWB/Mwmv9ZgSqH5dPojbcgYbMmWTMHe9IFd8h/eDuH
	IKeNKY56GCt18LglvLoJsoy/GdvQQJa3yl8soECWBnGrPxfCgbnT5ndfDF9sqkXl
	/10l1bqKgwGdyAzSZSqD0DOjBfedlDsegJwDIk4CCDohZsUPXI/0H278p8EfVRRz
	Egth2GqCWEngInIkaKOdHWW6Q2DMBOAAH69sC8EL7YLMu9IZOWwLyHZ+8/EQVXg1
	Zf3GQwjmqXcNtWrPoBm3g2kXbKjJBAE7HDwfni1a+vutafq+gvKfnNPopB5JP+KQ
	HgQUeA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y65y0b0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:34:48 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fbff6426f5so11399152a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:34:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740476087; x=1741080887;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSIJQ7jaFX6kCm1/h4SN9ZCiGBfl+wZu7rF9036LeAg=;
        b=n3iRzaR6j39bDly1LjfKYyoTVrq5EVzZGRelht/iZFHmm5B/pM7ruqzmLBH6DnUiKV
         gGgD4EwhpahvEGfZ9yaglMgYcMU0Mq1wX6ip177VYOTAocn8dA7Ea3+HzKQbTRHs0r1p
         Deq7C7w8QJDrB5xj/m36RTJWVAhHQjmBSbHoDwuR0LdegdS6QrOQz5henNg5eIk+YiTv
         EeG8aOCq5CmLm7qbUKIdNOUIwsNWpHc8mjLLwvSmR0wHK61jyH5FRi5voL1kVQxo5GeF
         adyMHBDP81P3/T9yjypupxJAGqy7maUoGr6MTRuiWqoxsx3+oQgfD9ufkMRs9f1+7aYd
         N+pA==
X-Forwarded-Encrypted: i=1; AJvYcCXpt3Xm246bWQWoZEnFyv9EYh/Y7doYzqjAn4WqCxR/DLblk+fOlxdqv/dX4Dt/86G+KAOsBk9P+jqRTsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLmxQYWHY/OzDVvzmjuVW4LiFQPqaCBntNNSDmnQBvMDhPvYYO
	m264dgVds2qPZsa68szBXgYbb+2eSEkJPYR9BEQwtCD0lks2h8mX8kRq1ku8EXBR5tZyoSEPynx
	9JAo6KdM7HcqpMJEXD2FdflJRF2VCARHkVyWtoTPJ7xkw3N+DWa4obuMeWqFa6JY=
X-Gm-Gg: ASbGncvIhFeD2cQdymEAv0mxz7/q0PSR9XiCmVw11cogAdPPwXo7xnZGuiYkCippEwq
	2LC+RlKuY4s89BdbDVx387plrDBamcP3eeok1/YPsZ7PTGD3r76p3yUFKRUl8GBCDk1Hp0MaCiI
	MHOg19T1cYmheoHbcQYvTSVmBGqOvEXNt6XGyMnM0uU6ZwCTTyIfgsoqeuscn534z0jc8VbHn9j
	nEjyguPUp7zhOd7wE77ET250rzQTj1OsMsnKVRLYV0PKZUOXFIlfoVeGauKwyG9Vchgo/q504H+
	ZQX92gQSRiNfu0P8vhQcFFzXUsPvhqSqa3AMvqUJg8Dm8iTWKAw=
X-Received: by 2002:a17:90b:2dc6:b0:2fa:1e3e:9be5 with SMTP id 98e67ed59e1d1-2fe68a2df32mr5100172a91.0.1740476087344;
        Tue, 25 Feb 2025 01:34:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkTr/zaRhtjk7yZHJlTH42C0GF7O7ieoM0aPS51ydoOaKSFln0kJiX7IFN15MoAYzjjQgltA==
X-Received: by 2002:a17:90b:2dc6:b0:2fa:1e3e:9be5 with SMTP id 98e67ed59e1d1-2fe68a2df32mr5100129a91.0.1740476086972;
        Tue, 25 Feb 2025 01:34:46 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe6a3dec52sm1080770a91.20.2025.02.25.01.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:34:46 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 25 Feb 2025 15:04:00 +0530
Subject: [PATCH v4 03/10] PCI: Add new start_link() & stop_link function
 ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-qps615_v4_1-v4-3-e08633a7bdf8@oss.qualcomm.com>
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
In-Reply-To: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: quic_vbadigan@quicnic.com, amitk@kernel.org, dmitry.baryshkov@linaro.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        jorge.ramirez@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740476062; l=1500;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=oouLjGtH233lwoGhCTipl0h9nbjcJt//bXzApe/ONc8=;
 b=kKjEu1/eTiO/TVWz/OWc6m/yes9WPtkprKc9GkeIFwLfQFox/fnc7PZfPFwrmMqjVb+6o+fPF
 eWQ/SqN4b4hD9Kho7mMMbYbKHrs88VQru2moChKL1jQ8lcE+QFhHp9M
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: ab_zaakpoubqhavWXYkbdiRVa48gTKAU
X-Proofpoint-ORIG-GUID: ab_zaakpoubqhavWXYkbdiRVa48gTKAU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxlogscore=834 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250066

First controller driver probes, enables link training and scans the
bus. When the PCI bridge is found, its child DT nodes will be scanned
and pwrctrl devices will be created if needed. By the time pwrctrl
driver probe gets called link training is already enabled by controller
driver.

Certain devices like TC956x which uses PCI pwrctl framework needs to
configure the device before PCI link is up.

As the controller driver already enables link training as part of
its probe, the moment device is powered on, controller and device
participates in the link training and link can come up immediately
and maynot have time to configure the device.

So we need to stop the link training by using stop_link() and enable
them back after device is configured by using start_link().

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 include/linux/pci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 47b31ad724fa..bbec32be668b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -804,6 +804,8 @@ struct pci_ops {
 	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
 	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
 	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
+	int (*start_link)(struct pci_bus *bus);
+	void (*stop_link)(struct pci_bus *bus);
 };
 
 /*

-- 
2.34.1


