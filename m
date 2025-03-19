Return-Path: <linux-kernel+bounces-568204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63361A691D8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8200B16FFEC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1637211A06;
	Wed, 19 Mar 2025 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UoNjbZBq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAAB1D5AB8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395412; cv=none; b=Krp8XFZEKe9WapRfrWZ/MzOXmWNFzAOFzG2jc/3NQtWi+LNsbpT8a1f9TdNBKt2eUejjujFNyfBvkfupBZU3NjQ8QTJOX89BFo+0Ef8Qa7xiE5+UZtb3XpeUquKxRuXDLv5bZY4d27vjOW/odRe7LMQOdfDESI1WqDx7oRQAKac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395412; c=relaxed/simple;
	bh=AanE0vCV38O/FAuVLfDGbo+3+cOqv7QLM9XwLXPBASk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f+7EvZUkVrZM/kgtYfWiX7K18Ao7O8EmZIKEfYb7iJSD8d3zIZH4CpZzFPakxBzUzEyKT2D5m20vWbo4aesMcv0kZZGRevz7Nm1znt4K+ua01bt6VD7ervVbGnW8tygGlpSiHK70rPYkzQipSTk8KLBmo2KU0JoP1oWKsgiFSsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UoNjbZBq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JD3JQY011973
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=fDks5bNiL4TTAIcOPwADQX
	cQw6NbYQj8DQwp8LVt+vk=; b=UoNjbZBqA4OhTgbOjOojqE2me6qvca7X9xX89V
	pDmymhE2M0tYQ6r98OGHX7KLJzIpcLBweA71BhSt6VA5/GtQCjQACQZ786bVyMo/
	p/RF1QAGV6rfd8CAk2gNk9VE4nbI7dv7wWN2yFeviOPENE7t9Pfj3Fjr2lxJQCKQ
	k548ORLFbFvYle7Othd4v4U6Ytj3h4dtTjyjUMVQzyScb1KM13w2QK6bR6QZHUIW
	z4cw7AHPR2KV8INiFKxwxriD7RaOYQB193vzjKi5XyKhsKrA9oJ/L+rziZ5S8I8U
	Osq9SqZtZ7r0wlKj+5XEh/EjLBcxj8OKZ7IEQOHNXLMP+ixg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45f010njx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:43:29 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff605a7a43so12044054a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 07:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742395408; x=1743000208;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDks5bNiL4TTAIcOPwADQXcQw6NbYQj8DQwp8LVt+vk=;
        b=OTMpMRFTQmD2QOxhv8jJFjy9SdUHO4AVqQyLezKsKmvanb7AM+0aagzS5la09UCxRL
         gLSuVUMNYgvr3dmUUN/JxrLFaLpufcXVZcMDGwr8JCl2ZHTI1V2FYqsnV6Cqf5YFMYQB
         UKtO4KxcQPnrsxAdRjAWvDNqVU+bQq91Yyu5yQdaC/UG/gi6h01fypw+m41gZ13SaMOd
         kYhUreMuz79j39PXHsNT6vrLzvY6jO9JqA3gzDlfaK+0Eeop91xt8k1aejJ/JJTeSzYT
         X8ndx1B/prBXfQvoDBKNGfaXcNeN9IsqjqVwlZO472IF52oQqgAAwcfqe1t58eIh+pD2
         p0BA==
X-Forwarded-Encrypted: i=1; AJvYcCVOywtbgFiERdJEPU23s4d64SgscItSRviVbSX4Ob/viE0wyNTNfpcCq7NS+r3QTfxUBIlSRlnpLGzQPBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBIcCktWHrEgvsKcrq9/paH83NRuv9RnV0C8nKyVVKeaMurDud
	hFdvwO4pjNrkrBzDYM+GrxtnvI+yIHnk9Y4vVFuTyvVITVSOVcoHf/v5ixiVh2FyfufLad8H1Jr
	HPdzqVwrSLLxNT9ttloa7bnu7nMUz8r0mMF4HPSwNTO9eHnoPtSBOs8ScpMwaU/s+A/X5wwI=
X-Gm-Gg: ASbGncuI0uyP+JHmlIMV1kFR7T500WFYgvMcAxdZITg5mOPUBjTU8taHG7tL7O3X4KG
	x/cv2GQB0UC49yiB4IvaSGI91r+ERFgR5n9JFQ3LLAPF0ZHLG39OqM3fW3TVlFGtqs4gVgckWQW
	H9ukoNhr5afd2bOK39K5r86FG3hh+y2+pAXK86+19URZcLKp+S8B7q8umAPJCqe6CHu4a1hle0T
	nzezX8y+qW0ARQKRobvGAci18lvefS7g9Q3DcA5KNJDe9/cpwsNaF6hcXksDw5FMGinO2D5YXNO
	5AKpuy370ZxUB43iDwFVwmrnAKWcmy3DQhZgDR5zAXjgwAx/a60D
X-Received: by 2002:a17:90b:180f:b0:2fe:ba82:ca5 with SMTP id 98e67ed59e1d1-301bde6cf2amr4834257a91.11.1742395408454;
        Wed, 19 Mar 2025 07:43:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg3Q75Qci5DvweZ40CsDBT7ekjQ3khqPBr2grYqgGrv6LYAsW+kKMMcACW6fjXgPFyqBx8Bg==
X-Received: by 2002:a17:90b:180f:b0:2fe:ba82:ca5 with SMTP id 98e67ed59e1d1-301bde6cf2amr4834215a91.11.1742395407906;
        Wed, 19 Mar 2025 07:43:27 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf576acasm1659988a91.2.2025.03.19.07.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 07:43:27 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Wed, 19 Mar 2025 07:37:37 -0700
Subject: [PATCH] wifi: iwlwifi: Add short description to enum
 iwl_power_scheme
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-iwl_power_scheme-kdoc-v1-1-2033ae38b178@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALDW2mcC/x3MQQqDMBBA0avIrDtgIgXtVUqRmIzNUE1kpjSCe
 PemXb7F/wcoCZPCrTlA6MPKOVWYSwM+uvQk5FANtrXXtjMDclnGLReSUX2klfAVssd+8HPfTcF
 Y46C2m9DM+/97f1RPTgknccnH362w0EKqmGh/4+o4wXl+AZ+BOFyMAAAA
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: 3FPGC7-PomblMzcGMah8FrltfLmYsUSD
X-Proofpoint-GUID: 3FPGC7-PomblMzcGMah8FrltfLmYsUSD
X-Authority-Analysis: v=2.4 cv=G50cE8k5 c=1 sm=1 tr=0 ts=67dad811 cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=mtRy20iSeC98bK40_qsA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_05,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=895 phishscore=0 adultscore=0
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503190100

The kernel-doc script flagged the following:

drivers/net/wireless/intel/iwlwifi/mvm/mvm.h:130: warning: missing initial short description on line:
 * enum iwl_power_scheme
1 warnings as Errors

Add a short description to address this warning.

Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index f6391c7a3e29..59483fbaaab0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -126,7 +126,7 @@ struct iwl_mvm_time_event_data {
  /* Power management */
 
 /**
- * enum iwl_power_scheme
+ * enum iwl_power_scheme - iwl power schemes
  * @IWL_POWER_SCHEME_CAM: Continuously Active Mode
  * @IWL_POWER_SCHEME_BPS: Balanced Power Save (default)
  * @IWL_POWER_SCHEME_LP: Low Power

---
base-commit: 3fd552b2658eb6bf2a3b531553fe563340d37fdf
change-id: 20250319-iwl_power_scheme-kdoc-89cf83bd121a


