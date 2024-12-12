Return-Path: <linux-kernel+bounces-442931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF999EE428
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2691888CA1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4938B17F4F2;
	Thu, 12 Dec 2024 10:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m6y+Hs1K"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0540520B1F7
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733999575; cv=none; b=lyx0fPFoPV4fazY4T2FQ2NqmNGIx0v/F3oTWZ9tnfDX5BmsQtFOfsPNZuv+5uMp8J3qfteP3Gi/DJdaeRXE7/C6xNsaaFauoOLFZzFTnvg/I7p+94fPbwhEYI27rYShhsVWggTYOr6jg3VKwgzekO5NoypmX9YXV9bou7X+46MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733999575; c=relaxed/simple;
	bh=bxd2KxdukoFBLKHWSR4dEbD3FlpHwRsSJWIrFzkd7Aw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MJ7Fx6ybMlPsN8GN1EQk40wqoiZzZpe/wjn+lOr0Uh8QSw1w6YI+kBMlXVPqR7ZDyREMPVa6tE7x1aloNOYvBNuZuJy2wKlp3ipoJMMMe5enc3Uw5rHA5I8LMsCcNLpDAlojjp/eNhdfHLgEkaNxF5mgBsC/GSL8XC5OH4isd/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m6y+Hs1K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC7FAKq002866
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kssPaDPxup65Dty2dKSXA+
	jcEELLywxLYi1f+671RSg=; b=m6y+Hs1KR4Q0NEMez5Fi6c0CdG9prgxWYT9D44
	GautF2jzEAhX7uVPfNUgnQNYEFt50SluD51n5W+YMjCuUyU9SvntS83vDYwxobSB
	NTXGjYg0iNbOP4vjhROxU37hBgorASECs3oy8tEEpfFrKojsJg++bEHFkX1e4Je6
	9naMJtVPL6A9aidWgKnUN19ZNoO4QDthOoCr3n42Lqs9gKItedAWgo3mYUWzAizJ
	t7kUnxmfGaWQDh03WCABq6mQJmq/5PC9grQkIFeQF8Z80kmUyZLcLeUSZauGzkGb
	R5rBraAR5SVf278KzveWV8BhsANYDMOZiwgzBNq32srrPxhQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43f0r9w03h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:32:52 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-216750b679eso4526285ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 02:32:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733999571; x=1734604371;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kssPaDPxup65Dty2dKSXA+jcEELLywxLYi1f+671RSg=;
        b=tfUuhG8EbQPCska9+H9jsX23uE4pDy4XyTs8VmeFWmbw08NEIEBaCOG1T/0QQIemKa
         SNWh28tTx1bW5o8ZlBqBSFPcn4fFtRgApk9zT9Rug00Hti8hZ4RTYShKX2/JmorELqzn
         6Cz8W8pLGtttbmee8XDfaOTe1XdXJNgq7rJKvIQl/q3yK0WBZ0P9DXQQl6rEmoMMsHfn
         GAGaP1Mjwnw5v4dT0B5NmLU37lBlusrcq+uwMGpcgJF6z+lUI9ZBKES8h61FllYTtOWy
         SqxE7H9BU1QS5yVSBm5c4DSFRgDr7+zN0yIx8/XtyFT5tlgonp029ZSWJ/mZVYyLIXVa
         N3Dw==
X-Forwarded-Encrypted: i=1; AJvYcCX8Wp0KVezMV1Ovwbtrj559RLpygudxhNQYPzJvxYCfnOokLjMiOiiRNQ8Vxrf6lHy2L+1ekSZoA265oOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPNYWnB+0lFTT+dXgqo9DDHiAbFpNhzOoYgxUsE2PoX+YyEpEg
	j+Vw0CYyo70zHjX3HwySfPR/wY0PqjGtYqSMs9CIFZw+JK6sI1NVdZp3yXP2qOd7Qrcw9Auyq/6
	ZLkLHIolWqy97ri3rH/qNjS4nPnrfo7qtLqtKJK93PRDrK4Dn3+RmkQ0lbDjd0YM=
X-Gm-Gg: ASbGnct4qnHvcsO1LeStJOiJoJ5fihXxyOSK+2pTFNEFwDxBwMPRympj5Bywq/RTH+K
	+aaMR/ZbH4Ms5iUJhuvgT7+G3TZy7LJlDBvo2Hip+In7BK1shpmvFhJ1R1rlXC3RybbMdMu6mS2
	rIo4qA94cFFwEknjGxbsf6qwTKaRIY9dzsVlbWXUB5M/1zj3iJliOX9uaLB1LU69z7Ji3PU1+eu
	COPrD25gytpEyVdRjIReDiGBKcKC52q6G5oGvaxayhTDtnVfgjIOiGDgR4icK8DwJh5Z2shCXe7
	JoQCkeMdd8lYTsFU
X-Received: by 2002:a17:902:cecc:b0:215:a3e4:d251 with SMTP id d9443c01a7336-21778395944mr107145955ad.6.1733999571157;
        Thu, 12 Dec 2024 02:32:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYe777zzUhTHTuqNo5FOPq34CzI9d/38zQqThsmvTBvj9oBnfzkvHRdu1IFQisMei1L+OcTg==
X-Received: by 2002:a17:902:cecc:b0:215:a3e4:d251 with SMTP id d9443c01a7336-21778395944mr107145585ad.6.1733999570764;
        Thu, 12 Dec 2024 02:32:50 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2178db5b42asm11102335ad.244.2024.12.12.02.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 02:32:50 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v2 0/4] PCI: dwc: Add support for configuring lane
 equalization presets
Date: Thu, 12 Dec 2024 16:02:14 +0530
Message-Id: <20241212-preset_v2-v2-0-210430fbcd8a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK67WmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIxNDI0Mj3YKi1OLUkvgyI11TE8sk88TklEQgpQRUD5RJy6wAmxUdW1sLAAB
 PgsxbAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733999565; l=2373;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=bxd2KxdukoFBLKHWSR4dEbD3FlpHwRsSJWIrFzkd7Aw=;
 b=DS3iYf3bome2HEuPcLoShlifxY9EyuIqIt6CCIxnuV6YhKtpdI2UDLVPPd//UbAY3ahz4aSGy
 OU70Bfc0teGBz1gwKR8IZuS/zGEbcE/XzgfqMvBQRWkC7nxD/j1OwX0
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: QrqIIL06v6B8aTn_naNCAhyRm_p3zfHo
X-Proofpoint-GUID: QrqIIL06v6B8aTn_naNCAhyRm_p3zfHo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1011 mlxlogscore=980
 malwarescore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120073

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

Based on the number of lanes and the supported data rate, read the
device tree property and stores in the presets structure.

Based upon the lane width and supported data rate update lane
equalization registers.

This patch depends on the this dt binding pull request: https://github.com/devicetree-org/dt-schema/pull/146

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v2:
    - Fix the kernel test robot error
    - As suggested by konrad use for loop and read "eq-presets-%ugts", (8 << i)
    - Link to v1: https://lore.kernel.org/r/20241116-presets-v1-0-878a837a4fee@quicinc.com

---
Krishna chaitanya chundru (4):
      arm64: dts: qcom: x1e80100: Add PCIe lane equalization preset properties
      PCI: of: Add API to retrieve equalization presets from device tree
      PCI: dwc: Improve handling of PCIe lane configuration
      PCI: dwc: Add support for new pci function op

 arch/arm64/boot/dts/qcom/x1e80100.dtsi            |  8 ++++
 drivers/pci/controller/dwc/pcie-designware-host.c | 21 +++++++++++
 drivers/pci/controller/dwc/pcie-designware.c      | 14 ++++++-
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 drivers/pci/of.c                                  | 45 +++++++++++++++++++++++
 drivers/pci/pci.h                                 | 17 ++++++++-
 6 files changed, 103 insertions(+), 3 deletions(-)
---
base-commit: 87d6aab2389e5ce0197d8257d5f8ee965a67c4cd
change-id: 20241212-preset_v2-549b7acda9b7

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


