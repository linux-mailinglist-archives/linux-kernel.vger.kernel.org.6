Return-Path: <linux-kernel+bounces-541574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AE2A4BEC3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A8683B8681
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED331F1818;
	Mon,  3 Mar 2025 11:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cqNVWfqW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F6E1EF090
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001134; cv=none; b=NIkHWb73c7mJ11mjOglnpczFPtBcxrAING8HeELAJ6cNZJUoHB41UFhb9lxGMGO06C6E57CLj9n/tUtNuth9wiedn1QdrlGxODcIdCBvbaRSbDRpWPpdJaJajLKTsyxbKn5ZySWmDXNEsxrdSIaqjgbjSnxhZ/GvcGhhJB7SyGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001134; c=relaxed/simple;
	bh=s7TP/FzJWfKstxT0hUGGaWQSdZ1LzPZlLHTDu0qdbH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gyRhIIcpC4P2DD9qs9/SW2z8VXsU1vkhHxvigMszAvqtbCWavKNMIXjn1smRItLyQpI9OLq2jlh1Q0ZcQlbJcvGRAuCMUDTrun74/+no12+VoitLrJejKzrkji+6EDbTnazl1vmKWhLfvgWH2I8AkUp18auB87fjrdFJndZJ6zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cqNVWfqW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523AVrrq028549
	for <linux-kernel@vger.kernel.org>; Mon, 3 Mar 2025 11:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vOGZxOSrxs8VMcmN2ikZaI
	gy1dKM4CQ94o3hcdk3AIM=; b=cqNVWfqWd3AMg3sz6+/ShUtCaJKHhS22Bk74ql
	xcBxTX6E24Kbbqse+CF/cy9/HAi2zs+goS5On9C+S9qQ7uC/xLvtEs7M0u3wY/NS
	NSU5ZGofp1B+avi90Uc6LXtSQnGMnWLKM8pg5VioRB+sBkF7jt1/vW5JWKApgypM
	h7Tz8G9bVz4CvW6UMJGxHSz10i9DytpD7w86gFgPt5yrBqYExBBVHFGiR3VOf2mM
	Upc4Qo3praAWssApB0aYf/MLyODiPWQHcOrKIek50D1WIJjlO1GPJHU1GyYywtAL
	mXc5IVHgsY5TFsXavA/SAytpTDGt/zzfjlBrMay/AssoyvjQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453tf0mjby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 11:25:31 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fee7f85d03so4855379a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 03:25:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741001131; x=1741605931;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vOGZxOSrxs8VMcmN2ikZaIgy1dKM4CQ94o3hcdk3AIM=;
        b=FOVZNb5JSkYIobGHfeedFwitOjdniZkFDqlhha/ErhO16uW2fWaM1eC0OtZIL3sYZ2
         BPd/9WqjBpLd4LfhnEwc94o4HwAJNOZ7m29KvqsLP/zLswzWpNmsVy/ztq6Q6F1U/9e3
         PnPRRxU5t3o27TXj9Efo8CxI0csyZ+hLOkFf691yhXGtBUy4xBy5iy58eVY6sjtkQqZC
         McpUy2xfzC152kWMRnxwQARuBugXEcCnM2qbT/UPcthIccMMOF3xeR/sy0XWaWMeMu3S
         1nt/5goLx6989T7DCriCbXY/G+E8QTfBva361ZCG6/gGsiV2A0XCOe4ngCA7SyLNOtnN
         JVRQ==
X-Gm-Message-State: AOJu0YyPoI0JCmXP77VHeQ+IKeksjjd1ENRHOZTTFqLXWyfW/gDePofi
	j3Lzut2+47UfZoV4STVIpZKsfhYtSo18vZq1bFNIsdLjz/yAwWLLcRIWjPCfjdEwyMn2UOd8jfn
	ZVEy4I08pNULcorozJU+RbRCtV8m/zb0JpGwijGkZRHkm1COdDoCUn99noWVyQ+7MtUo3UHY=
X-Gm-Gg: ASbGncsTem0wr3XRFfx4Bz/Erf/zEi6bsyDGQDZvWMPsLMjN8rDtYmU9UKO8jusZBxh
	dxO6RqV8IdPyuIM9ie8zkiAR4bA47L/udkhWaEKGy2eu8ZdGoBFrGPoia7l0mk/dnqeSZnGVKOV
	EL/79/8fCSk2Fi4epualqh2yBc1N6gE5WREnOyX2QK/rvPxXCkEk+PGyMXKhFhdsabfuMjEQ/89
	MHFEcMIZafb3cQ+IVlUsWWM/D/mpXY576yTzAbzu0bavmxEAfDRyL9lbyipTx2HTjSC7+IX+URJ
	VMPH78IuS/ddQgqDNEc1OEHuruXj1z+I8xYK7ZeldYxF2/UHl9omwaR3XX2FRinxBYDTeJ3tJK7
	UMDS/QgB26qQu05YLmv3EyQ/Q4DLZsKsaQO71dmNaKl5Ip2V5Sqw=
X-Received: by 2002:a05:6300:6141:b0:1ee:cf13:d4b5 with SMTP id adf61e73a8af0-1f2f4e4c90amr20143417637.39.1741001130692;
        Mon, 03 Mar 2025 03:25:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzrMtiI8Apbzm6lsWZBzoPWMAgZNVketxNkbg1SfmzVsSn6ZnbqDv6+blwiAC4HbLQAL4kfQ==
X-Received: by 2002:a05:6300:6141:b0:1ee:cf13:d4b5 with SMTP id adf61e73a8af0-1f2f4e4c90amr20143392637.39.1741001130342;
        Mon, 03 Mar 2025 03:25:30 -0800 (PST)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7dedd22esm6765819a12.63.2025.03.03.03.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:25:29 -0800 (PST)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Mon, 03 Mar 2025 16:55:25 +0530
Subject: [PATCH] mailmap: update my email address
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-mailmap-v1-1-74823fdc80cb@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKSRxWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYwNj3dzEzJzcxAJdY8sk82RDM0NzE8NEJaDqgqLUtMwKsEnRsbW1ACR
 erSZZAAAA
X-Change-ID: 20250303-mailmap-39b7c161741a
To: linux-kernel@vger.kernel.org
Cc: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741001128; l=1444;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=s7TP/FzJWfKstxT0hUGGaWQSdZ1LzPZlLHTDu0qdbH8=;
 b=50i9VRXJeGNvSCYIQbuMaHkjjk8+VszEbkZRbFNJey18BBR4bVNNMMlOjeTnBafMrXHHK6/mm
 pBK6DAziGVxBijTynQZp7mWnQ1EEhC5oMuQQ06r2ObgiUFzClaNb7Ap
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Proofpoint-GUID: jIml0J1RINArWVmBpWc2ISvexa-a2GQg
X-Proofpoint-ORIG-GUID: jIml0J1RINArWVmBpWc2ISvexa-a2GQg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=795
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030088

Qualcomm is migrating away from quicinc.com email addresses towards ones
with *.qualcomm.com. Incorporate the same.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
Qualcomm is migrating away from quicinc.com email addresses towards ones
with *.qualcomm.com. Incorporate the same.
---
 .mailmap | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 01145c078838bf9348e8d0e5e48b7b0954248dc5..928bcf4e45bcd0f6f8d275b59ef876fb3581a108 100644
--- a/.mailmap
+++ b/.mailmap
@@ -381,7 +381,8 @@ Kalle Valo <kvalo@kernel.org> <kvalo@codeaurora.org>
 Kalle Valo <kvalo@kernel.org> <quic_kvalo@quicinc.com>
 Kalyan Thota <quic_kalyant@quicinc.com> <kalyan_t@codeaurora.org>
 Karthikeyan Periyasamy <quic_periyasa@quicinc.com> <periyasa@codeaurora.org>
-Kathiravan T <quic_kathirav@quicinc.com> <kathirav@codeaurora.org>
+Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com> <kathirav@codeaurora.org>
+Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com> <quic_kathirav@quicinc.com>
 Kay Sievers <kay.sievers@vrfy.org>
 Kees Cook <kees@kernel.org> <kees.cook@canonical.com>
 Kees Cook <kees@kernel.org> <keescook@chromium.org>

---
base-commit: cd3215bbcb9d4321def93fea6cfad4d5b42b9d1d
change-id: 20250303-mailmap-39b7c161741a

Best regards,
-- 
Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>


