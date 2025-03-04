Return-Path: <linux-kernel+bounces-545760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF93A4F11D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E05673AD85A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9CB261586;
	Tue,  4 Mar 2025 23:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZER8gjj3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E027A27935B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 23:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741129508; cv=none; b=DS7M+2DZsoFdq9q+0nRoZfwUJMg3AZFxKnuyQfGFnfwcAsI7J26/pr9FFFlZQGC4zXnwyMhaZmBOKLxrVAH4CZfXQx+vtNA9Rfi2LtXAzkcQoNvWU18vDg4a/YQEl0LTlFd4riysqmAZ8Mo3YGCCjGlkjqQ0RoZTsRMiezKkmpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741129508; c=relaxed/simple;
	bh=JQep0ZQ8KR7wNqUuL8Umc/S8sL+su7GsAMhW1J6fjnY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R8yFslePD2X6rB9d3MrGDNGOBbkggtatDjwiFzf7Tii9MYVyw/QUQG1exQ1FbqAJ49gfuinm3EwG5HD2VY4VJuHZBtn92FhM4EmMTaJqZGBGwT/7TQiPVKKodqw8B4x2nbQE7lQvOCaLIcNdFgPc9B0T1vKNqWRRcKFC/2eMCxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZER8gjj3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524MgR1U021617
	for <linux-kernel@vger.kernel.org>; Tue, 4 Mar 2025 23:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=+k0/7n0ayENZ3P/X9hSe8bRKUyB6TgoFwbi
	S2F0zQa0=; b=ZER8gjj3fegQ5557Mwhd/DZXTAYmWRcKH27hvsirMInc+l1YhcY
	b6mHAHKpWNti76lytRLtG7wlMPgEsvymFab9trVlo/K/3fYRez8tFjkKF2+xnG/n
	eLbgvKEPyv4a5EKUS9uaEKSxNk1/MI/2YBb+x3QQl16GxqDi0M8isP2e4/fMIQU9
	qF7X1HJXXhR1D82beZ5CDWDT/uHsIu2vp6+4MHVfe/Ycs+T90upZJFn8hqJvGRgv
	1xJnPUHBRR9akOYfL7KcTYo1L+dBqrP8L+NV7CpIkEIlsZwu8SOWGl4Obo00ap6P
	S/8GuyMpXjZ+zkjYpel5228Vy7ZfuJueSMw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6t3fbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 23:05:05 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22334230880so83400195ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 15:05:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741129504; x=1741734304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+k0/7n0ayENZ3P/X9hSe8bRKUyB6TgoFwbiS2F0zQa0=;
        b=w5kvhoh+j7ce4e1NYVTvus7QpWJbKnJ0+30M2ZeV28AMhkE8E85GLRzgXp6VI8A0XI
         vxs/DSG0CHVajc4RCEbq1hPoQLlVOzcVJPj9sO8kPpNWh+cPbozqbbb6CUpeBcav0QWV
         9qGS4l6nsuBOUKzmHcEHD2K6fAGjdn9PQvW6LLTIBiz32RK//wf8HhwbKM3MSj4t49ms
         SnlhgsW72BoRVSOahG6rgu5nFvWDh0uuypK93mBL1dRYThhQpuqHWPWPLVTSU5FeIvp+
         /IKIcdcFDEBJeW5X1pwRgCyuTghNC/hZGsM+Zckt3M3y7ARq2DSURjIfIJEHALO+AWvS
         0ukw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ049nNmYANFuNSm9eaTNTmF4FBrkMYl0df3XnLkjG9RnBuB1gXcPNqotYoQgr7nZyIzQn4Rzls8KGHio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3db1DHjhCmQlNCY8EZvXpKLSAbEb3FJA7WRPJ2vfjt6uWOG0a
	ponyI5cVRbFimbTb4vukRymYnTFTLH2jKkHvlWXL88rKoZKjmxvQwqrSRNLlm1BGC5ZTzpLExM0
	uBo+V1qkhPQBMWE4oM6f+wWK7agB4bPn2KITWj2hTZq+yoeS6zywsBMaVrLVP/DM=
X-Gm-Gg: ASbGncvvAAf7r8j1ny+qwilOCCRGRkPgLhlaS+Gp1J0nQ/vksv7pylHyuyOyV/Qa3Rc
	xTl1MolRSqAvvoZ2RXVks9NY4gDlokqoVs2gMFKJEIIsQfWhsG6VNh/yNGXoKA9s4KSLtDG143C
	vbaDBI7VPWxfY5uw1pm37k3D91PAkvG5DupaVUYqXBMleE9C7WuL1ORffEYPxXPTrJYgqe2TNiZ
	2BS7jftl+M2HaWyW+VOd770x4zx/sV5ez8OK4K4qSRjH8UKE3160YxsUABA1wdOacCizKlNWoc0
	yKFnyKR/P7CTha99MIAoyRyzl504byvvO6UlKxVW/Ql+YlAbm6a/p3K1W7pDShgDo4SyoUW6XiI
	ja1U=
X-Received: by 2002:a17:902:ea06:b0:21f:4b01:b985 with SMTP id d9443c01a7336-223f1d3a25dmr15090595ad.45.1741129504155;
        Tue, 04 Mar 2025 15:05:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnGhUpQy825/DMxvlXW2Ue+mmydLdhow3pf6c4GZU71xZ3fvsbSsXGKnIpJE8MZcF6q6FiqA==
X-Received: by 2002:a17:902:ea06:b0:21f:4b01:b985 with SMTP id d9443c01a7336-223f1d3a25dmr15090185ad.45.1741129503766;
        Tue, 04 Mar 2025 15:05:03 -0800 (PST)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe6cfd9sm11492793b3a.76.2025.03.04.15.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 15:05:03 -0800 (PST)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Subject: [PATCH v3 0/5] thermal: qcom-spmi-temp-alarm: Add support for new TEMP_ALARM subtypes
Date: Tue,  4 Mar 2025 15:04:57 -0800
Message-Id: <20250304230502.1470523-1-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=I/ufRMgg c=1 sm=1 tr=0 ts=67c78721 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=p-nOP-kxAAAA:8 a=Ke_cMI1aEn6YhuwJoicA:9 a=324X-CrmTo6CU4MGRt3R:22
 a=TjNXssC_j7lpFel5tvFf:22 a=XN2wCei03jY4uMu7D0Wg:22
X-Proofpoint-GUID: vhpkULFk6R5AYIZYVMEeWOXcZOqLc1SH
X-Proofpoint-ORIG-GUID: vhpkULFk6R5AYIZYVMEeWOXcZOqLc1SH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_09,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040183

Add support in the qcom-spmi-temp-alarm driver for the new PMIC
TEMP_ALARM peripheral subtypes: GEN2 rev 2 and LITE. The GEN2 rev 2
subtype provides greater flexibility in temperature threshold
specification by using an independent register value to configure
each of the three thresholds. The LITE subtype utilizes a simplified
set of control registers to configure two thresholds: warning and
shutdown. While at it refactor the qcom-spmi-temp-alarm driver to limit
code reuse and if/else statements when deciphering between TEMP_ALARM 
peripheral subtypes. 

Also add support to avoid a potential issue on certain versions of
the TEMP_ALARM GEN2 subtype when automatic stage 2 partial shutdown
is disabled.

This patch series is a continuation of older series from 7/2024
(https://lore.kernel.org/all/20240729231259.2122976-1-quic_amelende@quicinc.com/)
but current series has been reworked to address the change in thermal framework to
update .set_trip_temp() callback function variables
(https://lore.kernel.org/all/8392906.T7Z3S40VBb@rjwysocki.net/)

Changes since v2:
  - Updated function name to include "gen1" in patch 2/5
  - Added Dmitry's reviewed-by tag in patch 2/5
Changes since v1:
  - Remove unnecessary moving of code
  - Added new v2 patch 3/5 add a preparation patch to v1 patch 2/5
  - Updated temp alarm data function names to be consistently named

Anjelique Melendez (4):
  thermal: qcom-spmi-temp-alarm: Add temp alarm data struct based on HW
    subtype
  thermal: qcom-spmi-temp-alarm: Prepare to support additional Temp
    Alarm subtypes
  thermal: qcom-spmi-temp-alarm: add support for GEN2 rev 2 PMIC
    peripherals
  thermal: qcom-spmi-temp-alarm: add support for LITE PMIC peripherals

David Collins (1):
  thermal: qcom-spmi-temp-alarm: enable stage 2 shutdown when required

 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 515 ++++++++++++++++++--
 1 file changed, 464 insertions(+), 51 deletions(-)

-- 
2.34.1


