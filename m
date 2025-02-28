Return-Path: <linux-kernel+bounces-539326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A0EA4A340
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09841189D737
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2577E27CCDA;
	Fri, 28 Feb 2025 19:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FvRbA7w7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1942755F6
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772613; cv=none; b=rsBv32Q+11inDWuvWYgVh7u/k2MKlHnPs1CmGCDRWQOlVSCb/EQ+JXtlaEND6IqFx8Muu0c/SexwTHHSaXv+D/Shx5NJxMdDUOGjtBDumE2TIDFkGU2XejnH5tiOvR+a5H0LaJoUfTSXWF/xVnI4ck7mcYT7keR420OjNyK9C3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772613; c=relaxed/simple;
	bh=bN/2o02x0EaCME+Uhmko1p/92OGOtG/jaYCv6x0kZI0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=o0NHM6tZMSnxdwhZ5ClT4qaBhe+g+lFlOUs8fGkKLp84if0i9oksOUnQ1WAFvGdODTsSebNVxavrdjknYXcFZ1YL7RkkKoWLccZosAkCj+OUUf69xNpajHbfrHp0NVu4vRfP4iGBC7vQc3EKu+ZoJ2IBBmVbkGVeI5MGEX9keFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FvRbA7w7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SAXHLi030927
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FLhrDFLiXAfPmYZ+M1E3Tzf5C/xkASQqa32SzWbQuvk=; b=FvRbA7w7sNyDRhO0
	7mUYDTikpS+u+SGRNckdjLEmPGLTxCtQzAlViVCUMrSpU/VgFXyrvD/X29kL4u0I
	RjdXP9cSYsEzyazamLqG9IXfE7oRHn3L9Ejv5HhAE87lEivc5c1I+hRIYrlAxW9J
	Iubu6aEqu1LX7nSecbh/ESzV13lTfjebZEt+W0oF1TRFLGEDf2gTvXqGqVB2rjAc
	/cVIcXnZUU5dPXpkeIOuBr7pxy+VvkfMQtU4wt+P0J3GCvkJ/CbwkYnLdmflQ+Fo
	PXlo87oJ3XMSuz5iUVgMaH/dlnvZ4Zj36XQg4ZnjJqeb2NGXfmokIdXn//x+tQrv
	s/3w4w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prmteyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:56:50 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22356964533so33392215ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 11:56:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740772608; x=1741377408;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLhrDFLiXAfPmYZ+M1E3Tzf5C/xkASQqa32SzWbQuvk=;
        b=X6Cc5bDUUyebtLzRQ1KohKv1+RPEbXlql+qfANAxh4Km4FyLL3S+vj0EVkJozhOH3/
         T1XFqYkf8RY4GYFQQLdN5AvqN6E2AegeE/vr+i61g9c4zLMDH1LmVzgvJkZSJdE/FkYh
         zvg2GDF695PbTNvVpuLvJS/NFD0Cejnrt3v4Ac0JLgOA26fxH27rjNVHoHmgq4uAGMKK
         uxIiAtKdsenKP8vRySaUSr752jnr+5DgCeh7c3j9E8ivz8DHgwrGYX0rvphy8uJqPqE8
         w4QCXLQRb/RxNSN1tdFDLnHaPdbxFd/PoZ9uoz4OaeMRNPoNFp+qYDKyIDbNB5IuMt47
         syVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsbTvcI60OlByzkENGEG31HCo5TNEy7BzFGWYlbirAzK1rZ1v690jOKAZuFVQfR2OIFUUSq7nvd/soYjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8+D7jEHIAs787PaCz5lAF2BjkfKDoKeo1OGItTbAKOuQvq8lt
	auHkD2M7A0YUFqXqxR+R8BiZr7HbiFWutevVEN7rVVKCLB0I+cL5zRIL+3m3l9KAGzo+Vz8DKce
	63LrhX2rHR9BfGp1iJJSRVD5gPNLtjQEn2JlKzhnKN3LOY0AnwhtWKLFx5rdGnMc=
X-Gm-Gg: ASbGncsLpN6HiWCObCieMqKgffcEdiAWULuAq7qdqG9qFMbiEDZ0lsHvE+gIdY5/99g
	ygWL7jBxDMBe/ejhELOKazPc4DzpogZijfSUlStsSgP+mHDo5pAV6AeRk/MQpuY+sWvAzBqAqLJ
	zREyK+omBQl3amC/61DYT1X8ELE5wdVbwy9ZQDEav+0tdR3k70XypZ2mQd9SMGYWsXxifmu+gU1
	hIAOR5WVyXGFwDvCsQMXLg6068+KStZo8pNI5HKBgnLuwPf9dUohe6X7Kx/X/ZGhqFfKT++OpEZ
	KSrE7kT4GyQOPkCSiaW7p/5yBNLXp/eYTavFF1A2aeXFrgIyBXKP
X-Received: by 2002:a17:902:ea06:b0:21a:8300:b9d5 with SMTP id d9443c01a7336-223690e1355mr73911135ad.23.1740772607650;
        Fri, 28 Feb 2025 11:56:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7N0OvSFFa3UWHRhgJnMWCvMyrdXk76Vy99PtpyeYMuduZgzrvVi7czXX9W/MtAa4KhsBhtg==
X-Received: by 2002:a17:902:ea06:b0:21a:8300:b9d5 with SMTP id d9443c01a7336-223690e1355mr73910685ad.23.1740772607194;
        Fri, 28 Feb 2025 11:56:47 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223505336ecsm37140165ad.244.2025.02.28.11.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 11:56:46 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org
In-Reply-To: <20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89c53@linaro.org>
References: <20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89c53@linaro.org>
Subject: Re: [PATCH 0/5] wifi: ath10k/ath11k/ath12k: Strip device prefix
 from calibration properties
Message-Id: <174077260613.4132177.11023317176929798759.b4-ty@oss.qualcomm.com>
Date: Fri, 28 Feb 2025 11:56:46 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: bN8XPi5Ck2jY5XDP8Mdmm-9DSlf5zsd2
X-Proofpoint-ORIG-GUID: bN8XPi5Ck2jY5XDP8Mdmm-9DSlf5zsd2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_06,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 adultscore=0 spamscore=0 mlxlogscore=764
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502280144


On Tue, 25 Feb 2025 10:05:31 +0100, Krzysztof Kozlowski wrote:
> Devicetree properties describing exactly the same thing should be
> reusable between device bindings.  All Qualcomm Atheros WiFi chips needs
> certain calibration data, so properties should not be prefixed with
> device family (ath10k).
> 
> Deprecate qcom,ath10k-calibration-variant and alike, so we gradually
> switch to a common property.  This will also allow moving these
> properties to common schema, if desired.
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: wireless: ath10k: Strip ath10k prefix from calibration properties
      commit: fcd37e2a33167cf6b507256365e45a43009d74eb
[2/5] dt-bindings: wireless: ath11k: Strip ath11k prefix from calibration property
      commit: 352e8c4379fa540747cbb6c94c4b149c7487feac
[3/5] dt-bindings: wireless: ath12k: Strip ath12k prefix from calibration property
      commit: 64e37c19383f840da534449b88d7adea4c69f52d
[4/5] wifi: ath10k: Deprecate qcom,ath10k-calibration-variant properties
      commit: a97ed4ecb797a69f52f66445ebca538c93462ba4
[5/5] wifi: ath11k: Deprecate qcom,ath11k-calibration-variant properties
      commit: 1bd9ffec4cdb9a1f09bbba16bba538f6c58a397b

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


