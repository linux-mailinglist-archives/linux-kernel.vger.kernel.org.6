Return-Path: <linux-kernel+bounces-575553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40009A70405
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B901892DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B216025A34E;
	Tue, 25 Mar 2025 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M9BrBb3r"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C351891AA
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913715; cv=none; b=kiTJnS5ln+0M+bZP++e3zPegSt/Tr56rQPHi+lexIip2eI9YbZtFekMX6K3YG5tlITwAIgadNXgf+3mHkh9jIiySyKYAfFjzkG20ZistG4ebkgF9Db7SKGo2V4Vf/t8hZqNn45DNKVltMPV4vY3086Jrq+lrOO1501nN4Z2Y37g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913715; c=relaxed/simple;
	bh=2f4ro3GZ++Q7Zec6pZNdUDsAEaH0Uur1K/JUTnjFnCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dPSPn0hwY6RZ+UPgPU3yPymONrIY4jqRiR4YkJl1SqHFFpuZGnNCZOiSfOtDGC/KBKzYcfJs/biXDP3GZ2ksL7XIin8fd5ylL6jrJQcG8ROPXFlT9tRA+npMgAXFY6ErUhtdGzZXuuw0Gegh3Ty2UHIK/Kp9VgCrB3+XrzRv9DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M9BrBb3r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PDfXcJ031130
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ew60TyXQdh4DHZ+Yc2NouknLu2P9TPtXk2XEkLEC8Cs=; b=M9BrBb3rNk/hnG4/
	HQ7HyGxv7wgKBAAiqryEgLWL8lyPcOJ8hJANVgf/fh+if1c7QJ5tFnRM3ZHV7YQs
	SWY5hwg70OPI192WZAC+OsAfZHCkin+Zf0p5kLHJ6qYmMjW4/d2fQgaQ9G2qDBzn
	kCLrq5/RXTVzYqmKzlr6R6hrUiTpLcI4GjIWUFyPKFEAa/2d5RDY6x/XLOg0jfoA
	/fC8k7K6hmwP+rkne/8HcHCHp6vHR0wTIWPfWFfy+8SEkryU3A51TUlwn5fd1/KW
	pXDOR8Rd0apZu94lX8IXngK5B8yC1ykJSnF56H0l/p5uLPBiDeurdBiZ4YoFr0C3
	3+e62w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hm79r860-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:41:52 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e8f3c21043so11911786d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742913711; x=1743518511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ew60TyXQdh4DHZ+Yc2NouknLu2P9TPtXk2XEkLEC8Cs=;
        b=sAF8WdcQEDybs0iAiF4OHzw1tgCT//LGZS1jAQDUO87Ynta10MDiQa4kF2nSjbpOgT
         aLDBHDe2VRwyWWwkQRDU4Fd7bXuEUchbNRD3cS3TDp6djDE3JYkAW1S+VJc/sS7qoBes
         p2Cjga84qFToCSIC612o59I2jyU7GviOR61suK5jLjH+a5U24YBn+vXUlj8Tmsk/biT+
         4uJi0s0hZUeKZqxWncli92hYkhgvZ6S09f/vgbO5llp8w+CXTjJgP+1W7LWrOcJazs2e
         7+fzJen1hMWSnGBU8Ju+pSaBIGj4gOK25n/mqBwSodyeqofn4DnTG8+vm2DZbQrxG/pm
         DdvA==
X-Forwarded-Encrypted: i=1; AJvYcCW2jOQc0ZPxxOqt99pMo5EJKW3oemiWYOcHFMyZ3MqsokkAHrsP1kWVPppgWC1YJXlKh4YtFSV71v20IwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdsPymWXBxq/gHFPlUll/3iKZwa90eH/TfUcEA3x+ssZrKnCOm
	VpiG38PGpLbf4W61Z6biHvfZ8WVFUmPSAZQodigdljzGOC7iQctmJo1Y+/5y4CYu/zHh5K2lcAS
	SI0uUXvFGiVKqV0GnKDQ3N63iGNsOOjW+/qOzRBsgupAOYxWX8AFpZpk5CfEEA5gyLYPYzZE=
X-Gm-Gg: ASbGncs6hKlAAW2AaTiR/EwnjbJIdbGuw07bDD1i6s7Csi1oYviBlAKot78eRrHqqUQ
	aQM1tdsSiNQ3bx0lF98gSI5gT4C8uSiFb8z5ggYe/XCeTln7nN+QaxvUEE1do+yWxjoR2Qtx7Hc
	nA3aE7Al4EUZxEJgX8HqhmpTtEkvLxYEuGGgUfM/QSs/tgceuwi2uEcjjN5n4GG7mlRfPkNVz4X
	5SzfqinXrp0cwIBFVJPcbC32DFeiCvc1dG3ry7fELdMLmMNCuHt+uonEdEMlc09Ra0FVZdbmSWw
	7cuEuWkAKE2R33P33AErlxYvGm2ENBVUTzlD5uYdslQJSRfJ43ya3tLowuTzZpeA7NVxQg==
X-Received: by 2002:a05:620a:4051:b0:7c0:b018:5941 with SMTP id af79cd13be357-7c5ba1807c4mr909797985a.7.1742913711263;
        Tue, 25 Mar 2025 07:41:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsfgq/Tn5WCGypWfv9KcLl0QC5q6oicbG/Q1ZRYPNw4LHjtBxlo7pAAmaAld+huPsudZZdQA==
X-Received: by 2002:a05:620a:4051:b0:7c0:b018:5941 with SMTP id af79cd13be357-7c5ba1807c4mr909796585a.7.1742913710665;
        Tue, 25 Mar 2025 07:41:50 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8d3ee9sm880947766b.67.2025.03.25.07.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 07:41:50 -0700 (PDT)
Message-ID: <ee0848ea-7a06-4f4e-9115-5e3c0ab8bf95@oss.qualcomm.com>
Date: Tue, 25 Mar 2025 15:41:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] Add snps,dis_u3_susphy_quirk for some QC targets
To: Prashanth K <prashanth.k@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250325123019.597976-1-prashanth.k@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250325123019.597976-1-prashanth.k@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JKyHoIDfORawgdSjtaHojb3B6cx4p--o
X-Proofpoint-ORIG-GUID: JKyHoIDfORawgdSjtaHojb3B6cx4p--o
X-Authority-Analysis: v=2.4 cv=IKYCChvG c=1 sm=1 tr=0 ts=67e2c0b0 cx=c_pps a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=-hWUoSwDaZ0JBn50UMYA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_06,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 mlxlogscore=883 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250103

On 3/25/25 1:30 PM, Prashanth K wrote:
> During device mode initialization on certain QC targets, before the
> runstop bit is set, sometimes it's observed that the GEVNTADR{LO/HI}
> register write fails. As a result, GEVTADDR registers are still 0x0.
> Upon setting runstop bit, DWC3 controller attempts to write the new
> events to address 0x0, causing an SMMU fault and system crash. More
> info about the crash at [1].
> 
> This was initially observed on SM8450 and later reported on few
> other targets as well. As suggested by Qualcomm HW team, clearing
> the GUSB3PIPECTL.SUSPHY bit resolves the issue by preventing register
> write failures. Address this by setting the snps,dis_u3_susphy_quirk
> to keep the GUSB3PIPECTL.SUSPHY bit cleared. This change was tested
> on multiple targets (SM8350, SM8450 QCS615 etc.) for over an year
> and hasn't exhibited any side effects.
> 
> [1]: https://lore.kernel.org/all/fa94cbc9-e637-ba9b-8ec8-67c6955eca98@quicinc.com/
> 
> Prashanth K (3):
>   arm64: dts: qcom: sm8150: Add snps,dis_u3_susphy_quirk
>   arm64: dts: qcom: sm8350: Add snps,dis_u3_susphy_quirk
>   arm64: dts: qcom: sm8450: Add snps,dis_u3_susphy_quirk
> 
> Pratham Pratap (2):
>   arm64: dts: qcom: qcs615: Add snps,dis_u3_susphy_quirk
>   arm64: dts: qcom: qdu1000: Add snps,dis_u3_susphy_quirk

Are there more targets affected, from the list of the ones currently
supported upstream?

Konrad

