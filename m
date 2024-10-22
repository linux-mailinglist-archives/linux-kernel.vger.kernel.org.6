Return-Path: <linux-kernel+bounces-375583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C73B9A97C3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 06:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A601C2317C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 04:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28B584DF8;
	Tue, 22 Oct 2024 04:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BTT3ehnV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D247E59A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 04:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729570869; cv=none; b=Q0tMqhyL2iU8GCUTHzInEacJklYncaryvstMk7rQkW5/GZMaLJDhvSQiwY/GZh31lirPYK7f96C0f/4n/rFKOk3uiAgKyuyqoj5xSFSqwHjX6BZt7uW/RVfdYBUg2UfW2/BUtV4yxmBbgnGnWTe0Db0pBuh092CrKiU+2Fy4n1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729570869; c=relaxed/simple;
	bh=ZZx94kuPsJBqKhSDlU3Qol1h7nTVfSUnlGS8qd2Tcgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R0CuoJiZe7+by6A5pexR8TTZYE4jxcHJPtS9D/7dGm7wKyGd/FStEG9jmBne4LvfzcfswkhLfU3qmJYIOYtxAoAf2YWWja3yZvKtYaiYpoXK5Cid9BEoFYkfU0qGiksCdeekL3oUqwLLyTbT9xb+dbYYeHHDMRCQ4dYiM7RVOgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BTT3ehnV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LL0XiZ029714
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 04:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=HENcSFiPTx5iVYi4wXblKs
	xcwftxsbQ86miIac1Sdxc=; b=BTT3ehnV1z6yapmJZZBY1Nzam93UHephGLtGny
	DoGRjfnhRqo9SWxlSb5l2e7tYRpfBXmzTCrSgJmPntN9N78UrBW9J9kukcI76u+w
	8ffswpuqWJqidUbojE6BQbap1oMcKX3JgpqA1VheieHhG2orN2gJcTeh29zrd+Fu
	SWcOiNwutJ1m5n5Fba0vhBNasSjqF+CjF++0BcSUjiSNT6iurKMYH38KlPRYHY8a
	9XrVxm6+7Spq/dZT50G2Zo+ISZa38oHUvRP8NKNA5nNf5gWDFMx/Dsnq4ckjHCVZ
	0+N8BJ74LvbV4DegHy3GBsdaqZPK10sB8KPDn+vmJK12mEPg==
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6vuxuu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 04:21:06 +0000 (GMT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3c70e58bfso42899595ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 21:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729570865; x=1730175665;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HENcSFiPTx5iVYi4wXblKsxcwftxsbQ86miIac1Sdxc=;
        b=hvz6iphcNwf0oFpeR8fuu0gj4fKFXbSuEkcQ/uq6FSQydZjoGIQZcYGavSCbqyc8JI
         AUOr4HOrixygU4CcNrKny6yJxCCufIPWBQWaY8/MzXxTN2yc0pfhXuBgjTY3D0MxjrZq
         I9dAhb+FtT3F4SAj+Y4ryWgy/IXzLlh1UxRLUlDxW1Mn2SpJ/LElfK481rLnBJs2r8t5
         sX0shqJUEXRrE2eVaBgm7Iat5+JEhz0udBNRTK2htKU+iWfhG0VcwfBey+FoA0ttqyhq
         1DqX1nhxOr8dy4ZqAvLFptmuNMdrBTUDq55RaFV4+vfLjStohin78t+HwdDQqYw/SFld
         yKMw==
X-Forwarded-Encrypted: i=1; AJvYcCVHxR8VlNtS3qGku82Ba4P6XJfj7UCI3NDNLbmYNADh/iiwavR39ABHFxw+BBItGdocCduqnxUP1W+YE58=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGOHSSDillPcXcRnOlJsoQhjPH3H8qJRLJIpgQL1w0qVbM1jvV
	U4DjkXSgN7rzFBYW01iCddEeDb7LJEAZmuGebYQBX0Cx0YQisLyERMFBNiSdVSHPBRE8gX0ol33
	unniwJ9v7saOfLefmnQIZ/6fFrAc+JgstMcu/FO4OCYmxrTHwWaDXOu6JDcxugxk=
X-Received: by 2002:a05:6e02:2169:b0:3a3:b527:e809 with SMTP id e9e14a558f8ab-3a3f406326amr131195955ab.14.1729570865029;
        Mon, 21 Oct 2024 21:21:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5uiaNduHPg+WyNp76ip1D4UiD9rzbbavv5abdTKo3logKNRs+dpMem9fvb6tI30AudDIw1w==
X-Received: by 2002:a05:6e02:2169:b0:3a3:b527:e809 with SMTP id e9e14a558f8ab-3a3f406326amr131195825ab.14.1729570864690;
        Mon, 21 Oct 2024 21:21:04 -0700 (PDT)
Received: from ip-172-31-25-79.us-west-2.compute.internal (ec2-35-81-238-112.us-west-2.compute.amazonaws.com. [35.81.238.112])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeaafd36esm4062644a12.6.2024.10.21.21.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 21:21:04 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Tue, 22 Oct 2024 04:21:03 +0000
Subject: [PATCH] remoteproc: qcom: pas: Make remoteproc name human friendly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-rproc-friendly-name-v1-1-350c82b075cb@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAC4oF2cC/x2MQQqAMAzAviI9W3BDUfyKeBiz04JO6UCUsb9bP
 IaQZEgkTAnGKoPQzYnPqGDqCvzm4krIizLYxramsRblktNj0Cgu+4vRHYRqvOvN0HkyoOUlFPj
 5r9NcygeSUIgEZQAAAA==
X-Change-ID: 20241022-rproc-friendly-name-410ca7185ce1
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Chris Lew <quic_clew@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729570864; l=1350;
 i=bjorn.andersson@oss.qualcomm.com; s=20241022; h=from:subject:message-id;
 bh=ZZx94kuPsJBqKhSDlU3Qol1h7nTVfSUnlGS8qd2Tcgg=;
 b=AkHzqQQIe6kZ4eRZ0l4KUW7cv10TNSmawOi7RRnmXynFRX22M+BSpmS2uWx8Kb1Ypsz3TUjSg
 F4W2Rk/T1IVDiwS5VnznSrF7j7c63ihq7clGki3AgOAJi70XlVD8Hno
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=ed25519;
 pk=SAhIzN2NcG7kdNPq3QMED+Agjgc2IyfGAldevLwbJnU=
X-Proofpoint-ORIG-GUID: j1Ao_qnECvepey2hkR9apoOBSYHq4RNO
X-Proofpoint-GUID: j1Ao_qnECvepey2hkR9apoOBSYHq4RNO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=965 bulkscore=0 spamscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220027

The remoteproc "name" property is supposed to present the "human
readable" name of the remoteproc, while using the device name is
readable, it's not "friendly".

Instead, use the "sysmon_name" as the identifier for the remoteproc
instance. It matches the typical names used when we speak about each
instance, while still being unique.

Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index ef82835e98a4efd4bc603cff604d531a51fe9f9c..b2108c3036a33f7e9a63380be3a6e319e76503cc 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -716,7 +716,7 @@ static int adsp_probe(struct platform_device *pdev)
 	if (desc->minidump_id)
 		ops = &adsp_minidump_ops;
 
-	rproc = devm_rproc_alloc(&pdev->dev, pdev->name, ops, fw_name, sizeof(*adsp));
+	rproc = devm_rproc_alloc(&pdev->dev, desc->sysmon_name, ops, fw_name, sizeof(*adsp));
 
 	if (!rproc) {
 		dev_err(&pdev->dev, "unable to allocate remoteproc\n");

---
base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
change-id: 20241022-rproc-friendly-name-410ca7185ce1

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>


