Return-Path: <linux-kernel+bounces-558234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF97A5E329
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBCFB7A5AE6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F631D5165;
	Wed, 12 Mar 2025 17:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nTIRyDbH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB91C1D5176
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741802106; cv=none; b=PBR9gAKzWHduJdEUc5cp2xGNVf8BB7Yfh0rAQmS4oqxYlU1zNwvTDHk1t5X1LatgaPjldhoLRIQO9uoZ0L4e5hUi5yULSiZZ0ucvWkYJcM7UT2pAJWpPg2nQhI1FTAI2zyjO3INwqtTBE6OxJfZV6Fm0bq6tJ+9qkqiCB3RYEIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741802106; c=relaxed/simple;
	bh=mkDA2+1e0z3rEsBuN7c1JZwPqxU43lSVif9j2BTiYFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c6vQLTli8DOMxjPgK9w0y5tHk1UMQ2u0iyMdDfW4mp5XFL3FgSwvfi5Mi7y3Up/5SXNjsO+8mwJEr5/6gppgcY6rQRtVScqL3I+zxY6kuqyHMqZNlHvBSNHKq/VqM6Vre9jQgfB9oOjyKEl+fsJ5LSGIO4KMAzW022hpF1H6KCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nTIRyDbH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C9pXG0027330
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 17:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lBkVaExMPrn68EJRBjzAC4jF7pKiemSgXk2IYD/dEzo=; b=nTIRyDbHcnO3kLlB
	Ig2R6/HdpLDeph0qV7A2nsCLApxIWUJ+D7tAijPnnSBRnlzx3SmNR5w4p2tB2skZ
	QFgxC+e7IfAT7RrQ8eNjjVzh3OTopCds1gw+AfgLHxXjWRziJHxfsDV7CeNzayfd
	Q1hKw/Ueytk//kmPLuErOgA2gL3Oata/8kdX2nrkIQo9f/jthVDWIwp7pTlPgVZQ
	QH3baTa8lGuTJis/H7uPu6mCMHEGTG0plye802hhz5cHHyTX3ey0Z2rxuN3QmBBn
	LqcV00BbnKhxUgpooK3gvuYjnrnsNiCJcucwyqeLeLXpw10fd/0GyGEwxo1EXN4G
	U5triw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2pu7yf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 17:55:03 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-476783cbdb8so91111cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741802102; x=1742406902;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lBkVaExMPrn68EJRBjzAC4jF7pKiemSgXk2IYD/dEzo=;
        b=nfiuuNmM00cUqFDLqvIhpIqv/iSiN8FZW23qKXEOF7jBKL7hO3kYfCmmOdCT+gpkVA
         G4ryy/zDMkZvBSRbS5yT6XobpKPnvoLx1yX36vqr+kvElIHn2UwV43c5eofY57KADp4Q
         Dg7c8Fu4OUNnQd+fc+3n7SYBrXgvhX5f8SowSd0gfLxH1yyHtAdaVXsWHJVrsS6PVfWf
         V/lK2K7Izbw5q186bHs7HQ3j4aX4NiSM/ISWNjH5Jx1LiT/T+bOMCOO5mHliNz6eY1e1
         4eJBYrpYG5t9+2OnMoEbcueMT0fONTsJUI0Cr07zpDRoj3hP3bZ2JJsnjARrXXP/3olL
         YtNA==
X-Forwarded-Encrypted: i=1; AJvYcCXIbe0TQltJjlZ01yToqPJUP99cOrtY/idWubezbzapuQ1o+2Jv49I01FzMscWe4EQgB1CBuKt7IjVlAYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywogj5ArIu9PYgEhWxD2wjwVmehg2qEGsc4Cu4KfnsfWpKyUZoL
	nTCpGv6YC81I5N9NjqXyY4cykD16TCtr/l7WDy3XI79zA6O2CXPmYHshu+0vEcSOErtAp2cvUAm
	0pu3cMwllXaOXwMhrr0mTyeBboHEC+GhKOpU7HctiLbfuNqK9/Tbhxn+awCJ2oMA=
X-Gm-Gg: ASbGncuw99hTzWc/rcJQmkQcrwy3GVwfzla+YSDK40kSs39NWiJ25QGMxDaHnnTKzwC
	9XS1uPvctMVl3htcIvlWVqrBUTHRysPRbJlw15pMrUcrUgPWLJGiV2l19NBYAE+uFqyLlnuA3Rj
	XkUs5151+1Hsmr7zGtF1ZO8TgGe9/ydai3/doifpz0LoUZLse4vflJY0k5qdaFS7yOXG0k4KwqV
	rwB7YHErULHGp6/bNzwvefX6c/EV8dHS0U8hBFfI96jFnvICnHMXzCDiXX1Z/ONOE37NL9eGD3C
	wbDO8zgKovJfv1RQAA3viBdgdv3kscEYW+mLszl6W+QRbjD25N1p67UpcpBbFd8oQFAvLw==
X-Received: by 2002:ac8:5e08:0:b0:476:add4:d2b6 with SMTP id d75a77b69052e-476add4d465mr20620941cf.1.1741802102707;
        Wed, 12 Mar 2025 10:55:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxdJxEHAYDAUUpTEgpUkJImDAE1G1PR32J2juv0XMrPXNxVjPJyfy7b+xFibALk8EVmNh3pw==
X-Received: by 2002:ac8:5e08:0:b0:476:add4:d2b6 with SMTP id d75a77b69052e-476add4d465mr20620721cf.1.1741802102331;
        Wed, 12 Mar 2025 10:55:02 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c74aa96bsm10115064a12.48.2025.03.12.10.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 10:55:01 -0700 (PDT)
Message-ID: <bb9875c9-42ec-4089-98a7-0b7de1c82b51@oss.qualcomm.com>
Date: Wed, 12 Mar 2025 18:54:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: qcom: sm8750: Correct clocks property for
 uart14 node
To: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_msavaliy@quicinc.com,
        quic_vtanuku@quicinc.com
References: <20250312104358.2558-1-quic_jseerapu@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250312104358.2558-1-quic_jseerapu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=P506hjAu c=1 sm=1 tr=0 ts=67d1ca78 cx=c_pps a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=xkG_gMnDietyO8DCwaMA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: WLCLU9_CfqG-EhVtkcPpKctgw1YHUHdB
X-Proofpoint-ORIG-GUID: WLCLU9_CfqG-EhVtkcPpKctgw1YHUHdB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=903 lowpriorityscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120124

On 3/12/25 11:43 AM, Jyothi Kumar Seerapu wrote:
> Correct the clocks property for the uart14 node to fix UART functionality
> on QUP2_SE6. The current failure is due to an incorrect clocks assignment.
> 
> Change the clocks property to GCC_QUPV3_WRAP2_S6_CLK to resolve the issue.
> 
> Signed-off-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
> ---

Fixes: 068c3d3c83be ("arm64: dts: qcom: Add base SM8750 dtsi")

Konrad

