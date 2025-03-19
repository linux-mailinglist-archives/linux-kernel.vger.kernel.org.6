Return-Path: <linux-kernel+bounces-568179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1517EA69168
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B73441B6523F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9226E185935;
	Wed, 19 Mar 2025 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jidskT9G"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE5B1A4F0A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394552; cv=none; b=cmnpmIWJlQwnHJzVh0pKocGzZtIhvZSe3i5ziln1dVh0Ps9izXWlUq+ncwmR9hm33FrO2jTzgMzN/UpPzrEFpgGkp2112VlefSbBejmqxYIHojFhaNK8Shgvvx+MgTNLtuNjkz2eWFDNI1qkQOyJQ5M8HexWzooRDczeJZd7vJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394552; c=relaxed/simple;
	bh=PPZLdfO+H8+51WB+h2FEysHxkXIQ9ncokH62QnpvIBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fWnnbVDFBbVkgBJXBD02XjFwFfIaMeClfvekMHDd1Sx8n1XzWGu4Oq1WeG85rL19a9dXTR2yPRmqJkzsybtH4E+qKRhNxMOvDVV6DOGWlbhzGLDpJ3zMndi+rEaCPLC8gPwlTrgSNsaa9TTjBymRrGJhCdGTq6BBhhwaw+pWRjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jidskT9G; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JDkcaV019759
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l63o9PxYJ7IYk7anlY9p2pUAHNfwefM8iz2O0O0wiAQ=; b=jidskT9GjqqBWQzR
	+Lzssy5tHVmKp3lR/+6CvYSfjam87BvNUP9aw23Fr5zExKzdkBG00y0noPFOyC+m
	og+gmXYakVUHreNTIWlsk0qXV1j+LqHVqXy6tqC4kn//H5KT0K3pfKPBq8Qa5Myu
	udzmvrHvnAJOgRk3Xbyt3JB7X+cre5UzyLi2biuDjyYhtk60qs8RvGJZ1cpWqboH
	0hZyccZ1QMT/UfJ0yM06mNiAdbBRR8KktbvQrOfa4l0sJbyuZJ5/Lm7aOHJN6Rlo
	EFlKh8KR7QRxIrEfdBHJDnw/zDcZ8smU2Z36n8pMCmS1+uRRDIFyBwQzY3qM4jnp
	vlo32Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1uu3xkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:29:09 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c53d5f85c9so116149285a.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 07:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742394548; x=1742999348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l63o9PxYJ7IYk7anlY9p2pUAHNfwefM8iz2O0O0wiAQ=;
        b=gU7Kkgy7g6c237fXYPLCoZfgcVzKnU+9eNKZqGwdfxmWC+yKTBnoradgPrfuWVkDIV
         1D4EkRZcU4FY+aT0+8symmeRWuLGFQRo9qIcoSW0QaLSor0Mf0SIuwLXX9uD9gJDl7ZR
         A7i7u7oIIvCnwNqmMmAYCE1WPQFhtiVD4LuzC6XeM13k0nDnLBs00pavIGCyE5Owtz2l
         /LVHo6KojgIBBtt3FTiKpzioj8NDJWy8lBk3TAbV2wpJR94Z+vflBa7Uqzchn7nlo0eZ
         yyddk7uwauAykgyt/HklTcjTqkOi53y/jaINNae42qvKQJk4kBkL1kf9KCRdEZfXFhLL
         QCGw==
X-Forwarded-Encrypted: i=1; AJvYcCW6ZZpOFCBwEq82I+59I0yt4vTT9cikhFCPLxFKbXcCsdSgM+eQVJK0k0f59zxq6klxktDzfBIja0ekwVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxooL2Mv730wW11UZBux/vf1mzSXyt/UITyFwzDCHyH6QiSdmuR
	XELx038sjN8GRaFTZmKsJZfT+YqaMReqeM/qGwPjhORIgCDJlb4JW8SXt9u3AdWiSTaA9lRVR9h
	2tedsvf0uaNHkYjyaPufBh2CQsX9mIk1QxRtAV10kl2RXIyOrsXMroQiXS/SkQvc=
X-Gm-Gg: ASbGncs1WVbDnHtCm3XblZD0IXH/GAr4kCW0spAv2inzo0x2gbiumocpdXuTv1x80Ra
	9EnzVWMcqPL6zoVOSfGskKdhAVorZCjmh2U7So7qsgxysRnwcF4nwhgMnWOP+fV2ev1ZPnzW3hI
	OD+ExhwSpaPlH/d6lU2omIy1nDqQbSwBRo+gLe3Hki1vl5JLGSV0Jo8rqRLXuKA7BzQDsdezCDd
	B8pfJdzW5ZzRAJf+pxoGXqLUjv57CEmDb14RLb53esM73cnhHcQfEv0kyOlojXGHeCRyTz3LYg7
	mnE/1yIaqIUFUNnfkCTmKzJyz2DfjOazyHq0VkDcu2UHdig6qcM9mRcNdkwlSs6qcbn5hA==
X-Received: by 2002:a05:620a:2a16:b0:7c3:c9d4:95e3 with SMTP id af79cd13be357-7c5a845daaamr149572785a.10.1742394548478;
        Wed, 19 Mar 2025 07:29:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVewRW74gtZU1oD2rXTbBPlZetJJMVDf3b6nZ6/HNqN2o/B9AHtzPooKP8wbpbPMg5EGv5VQ==
X-Received: by 2002:a05:620a:2a16:b0:7c3:c9d4:95e3 with SMTP id af79cd13be357-7c5a845daaamr149570785a.10.1742394548002;
        Wed, 19 Mar 2025 07:29:08 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac31484bf27sm1002942766b.79.2025.03.19.07.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 07:29:07 -0700 (PDT)
Message-ID: <a710034f-1c49-4d9a-b39b-d08f6c7c947a@oss.qualcomm.com>
Date: Wed, 19 Mar 2025 15:29:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: x1e80100-dell-xps13-9345: Enable
 fingerprint sensor
To: bjorn.andersson@oss.qualcomm.com, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250318-xps13-fingerprint-v1-0-fbb02d5a34a7@oss.qualcomm.com>
 <20250318-xps13-fingerprint-v1-2-fbb02d5a34a7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250318-xps13-fingerprint-v1-2-fbb02d5a34a7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H8Pbw/Yi c=1 sm=1 tr=0 ts=67dad4b5 cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=N1jLX2bt0puczyyA89AA:9 a=QEXdDO2ut3YA:10
 a=0t72Ts4ygAavhsGdmO0z:22 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: hhMv8AxSE7xAcpWp1fZ_rlSmGzEPWRYB
X-Proofpoint-ORIG-GUID: hhMv8AxSE7xAcpWp1fZ_rlSmGzEPWRYB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_05,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=694
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190098

On 3/19/25 4:22 AM, Bjorn Andersson via B4 Relay wrote:
> From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> 
> The fingerprint sensor, hidden in the power button, is connected to one
> of the USB multiport ports; while the other port is unused.
> 
> Describe the USB controller, the four phys and the repeater involved to
> make the fingerprint sensor operational.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

