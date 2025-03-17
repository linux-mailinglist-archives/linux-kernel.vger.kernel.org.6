Return-Path: <linux-kernel+bounces-564831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620B8A65B8A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6AFC17CE74
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4D11AE01C;
	Mon, 17 Mar 2025 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N2GX2AuS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEBF191F6A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233956; cv=none; b=LkiWtWAJvlcrINAVkKhuMW+VmB7JIdP+ucyzUWIL2+1whH8Vsn40EBYdk9gMIGSnUlz9ZyDMzP2YL1QZ+Nxq0W4rCTdJ+GYGmRgrEUMLFUYdT4Frum1P3c/SqfcmKKrD7LiY/yLKx1j04iSlgY5WlEa22hCUARLy5C6pej9l+tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233956; c=relaxed/simple;
	bh=f62ojl+o4A2l90TEjbig1mzXjGY+K9lbk5ckJztb9fI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Lw/NlvVenOiBPPV1Xx2M+l57ZCIi+tsVmD7276F/E/7T0kdZsEYCvlvxnJnhhKUezKcX67Kt7CerqYSA0l4ERcRRTrwscwI7uf/b5qkLyBYXd+rlxC+lAIik3rvfKyKj27bTmJVrrNF3SXogKiLtf3qSsv1ahJk2ZWDW23hyYt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N2GX2AuS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H9vpXo004602
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W48kH/S0HGkEFujKBeAyySxmQc5Opn4Q4HURKwAUaJE=; b=N2GX2AuS7C7jtsmU
	utzBsgrhMK8REKcFP5qyJPfU6W0xRQVGyB7jErhersrg7uIA6emij9BKup7Fi/GV
	SV2G9K8a7KWDg/s4Fpl0Znty7O52uIp+KFrbpNUQfYdGLq6X+WiWuoKIyFEM7oTG
	CTpfv3hqXHPtE4W75+SRRAj8bkcSpHQx35FdXl+56M5dWJEzmrIOkFOnlq6KJEUw
	scw19AdC2K1nUu9TSGDl88efrTXo1AgPdMQs+tTKTvR/pzSshUXtzJKRNButHGVY
	eZVxQnqGg2L8Xn15dM0RyZjjTv4P2E83wb/02nCsfKpqV8JEFpwJmagKJCKEV3mZ
	hV/dRg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1u8dkgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:52:34 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2254e500a73so60552175ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742233945; x=1742838745;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W48kH/S0HGkEFujKBeAyySxmQc5Opn4Q4HURKwAUaJE=;
        b=O3Fw6YdYU/bSFaM9TqybjO0C5F1lKxt06Xi/g++llsVZpw1FwPp7cH1YNV4uqnbAie
         5Y6VfmJqKfVb7POTq42waTuDLBbqYyfbWdwW2sqsyHd4oA32tR8MYkkOYzbGglWCXbf/
         ffEDGNBEVI4yWew5w1oDtMhz2fUM1mE7e08aBSUs18RgpBPswKvKgqoqlGfxyuHyO/nI
         +eVr4St6C9DNAbtHB56VutHc3HNbuSUJHqok1jrOqvVDMlNzhuHexVpQK+NzrCddEPIq
         hzRmKiMfwo3MTb8SYthSX8pcHFutjdAhgzBpURcq91yQ/RfuFLXu82doU74/jOpE6kwG
         sAAw==
X-Forwarded-Encrypted: i=1; AJvYcCXivB3Nbsxbi9Qepl9qL/f+eu2+Jn296rqqT6sS8OdoR/BGhlUxfDex5CAAJdsdZfKHBJecVceo7u7M9Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp6oFLtlUwV7VDusPrl9txfZoOZj6Q4Npg87xEq3k2+0bmH2Qt
	9yMrifImYIFBeTRPQmaARwUOAkCmKUnYpq2B4XJps1bXRzg2WL7lIuMdjc4rNO4n0OC/TSoOLJK
	DHmjhljQn4KHKEO9z0+kIAiJlgd1YOdXii2boU+OtSlgD/O/tjAPYQIY15+yURy0Fxzq/AJE=
X-Gm-Gg: ASbGncuHLJVq3GMWcCpprvAND1W00+jrp8jQtFHnUQUktKh4uVsC79KMshQbpoSypzF
	2joDmrDZajbt/T9onjX3g5Epx/czCwdCpkX6bKPC9zp8tN4QlZwZBQqlkDAh3EOeOO6UiDUPfsw
	h5rRtsX1QN63hkHUH89BQnmyjdQRn3R6wSW96EBvuRNWmuKzCeCses3lzVF/2jzZgWeV0snf6tc
	qJLAu5kvDspmclGEClHkmBKzc2k8MJYVP8HDOg43R9UmdAVSdX9+LGwyaexbpVpSkj2Mxie5LSn
	BRbXKL/oIwS3yqwNb36BR8VOSJ8d72fCoTHKfb3xAlZAqTBYisKV
X-Received: by 2002:a17:903:22c8:b0:21f:136a:a374 with SMTP id d9443c01a7336-225e0b098a2mr184232345ad.43.1742233945098;
        Mon, 17 Mar 2025 10:52:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoIwZ/XaW2xB5u/EDFQEQhDMqg39v0rU7Oq0/roBytKAynLPkZcvcV3MFWkdWN+E2yf8FxAg==
X-Received: by 2002:a17:903:22c8:b0:21f:136a:a374 with SMTP id d9443c01a7336-225e0b098a2mr184231995ad.43.1742233944697;
        Mon, 17 Mar 2025 10:52:24 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd5ce5sm78291485ad.252.2025.03.17.10.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:52:24 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Christian Lamparter <chunkeey@googlemail.com>, Kees Cook <kees@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20250310222339.work.654-kees@kernel.org>
References: <20250310222339.work.654-kees@kernel.org>
Subject: Re: [PATCH] wifi: carl9170: Add __nonstring annotations for
 unterminated strings
Message-Id: <174223394380.578193.6449253449477522706.b4-ty@oss.qualcomm.com>
Date: Mon, 17 Mar 2025 10:52:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: T_V6-mr9wwbAMio4J3f2O2WPvmArlnY6
X-Authority-Analysis: v=2.4 cv=c42rQQ9l c=1 sm=1 tr=0 ts=67d86162 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=a8UXU1FYSwnUjzW3zpYA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: T_V6-mr9wwbAMio4J3f2O2WPvmArlnY6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=620 priorityscore=1501 suspectscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170129


On Mon, 10 Mar 2025 15:23:40 -0700, Kees Cook wrote:
> When a character array without a terminating NUL character has a static
> initializer, GCC 15's -Wunterminated-string-initialization will only
> warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
> with __nonstring to and correctly identify the char array as "not a C
> string" and thereby eliminate the warning.
> 
> 
> [...]

Applied, thanks!

[1/1] wifi: carl9170: Add __nonstring annotations for unterminated strings
      commit: 9a1cf85c9c7cca15bfc452f207818977621dedf8

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


