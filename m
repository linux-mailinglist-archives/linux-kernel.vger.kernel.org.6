Return-Path: <linux-kernel+bounces-562592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 422F0A62D8A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 14:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606D63BAB89
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 13:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F73E1FBC99;
	Sat, 15 Mar 2025 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uy1WMNjH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816D01FAC58
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 13:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742045731; cv=none; b=Bj4iOnwLtL+gXriaTD870GVBzS+WVYGK8vUgeZCImMerAUv9bXvHNrDO7GkCibL83eQasajrxVQnztm+xtcq1iaD68tjnziTAJaONnckIkbM9RKGDCaBddcw678FQbWN3Ootm766ClTEbe5uqfaF0ttHKLz/HtRxpT4AW07SVVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742045731; c=relaxed/simple;
	bh=4nGul00PFPYuxPFc8NzuD8+xTAp0O0vvI3/6uULZ+aE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tioaEVdaP+xeg48CS8HhKF046jbJKy5xxmkKetxvUzjtXgqHuQjwdCXKz3QRy0J6VegKgj5ILFriRoeSfxx0GFKthzVBTVRO/HKtoe1nKH6Z5dbPYxJTUhRo5CCjD3KB0Pp21d4ytTUlVfkmrSucxErRpFLglePF5kV197M9U1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uy1WMNjH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52F9ObkQ004572
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 13:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ELoMXopsFlC91W0vkPYgZ5nldR/fx2jN7YEqrQPh+58=; b=Uy1WMNjH2n2elD0y
	AhAMnFl3UA+e5f1ndWrLt4VRgegxxxKQP6o/0QW76sSPtHw1T2alguaK1AhaP/ca
	jBGElgMy57WDfzQh2rt7/4BHi385J7BzBQ9xRdcRE8ShmF1Wh+qFumBZS/HP+xI+
	TIxBuhtZZaNEmM4/OpL7UR6xN+NgvmOsK9FaBq4+t3Z3NWGUngs+YFLS5looYnAU
	fNGhP2RKJ8V6dpg9V7wqltt1yJR6GUlX6S+9ZbCG7ZxgKlOPgtcCFoWIsN/j9q3C
	MQmhGdk/IFjFVTv5Zd+56nu7cYTPROaEb8xi+tYRNSJZ+ehcKRPMPdb6Q7l0yXlJ
	XYE6tw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d2u9rnqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 13:35:24 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c552802e9fso35651285a.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 06:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742045723; x=1742650523;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ELoMXopsFlC91W0vkPYgZ5nldR/fx2jN7YEqrQPh+58=;
        b=ZXYS5yn6R/abnRjyE0IGfrUUlx+exXY/8E6CeU4PpNeVNu0cDrZs0HtRbWx+KZW5op
         p2Zwwf4SiAT1U9E0BuEEq7I/v68gBuYrnX0Gu4oxOXQhx91O6dnAgFI9Tmg/IbrvIcPp
         UMCAczLrn5LdAh7teq/gRImsEDF/S+z/V0AGj6ezl7TWIE537+sZX/BGlrImS1W+BUfW
         ghbW7faPGe8s1qHyOJMAzxpevDG+j6u+ARrk7tOJAwA+p2MdhahJ7w0ZXhE88UFcaExI
         JDQsw3o3iIqlt0+0TjuIePsHszPM/26ufJnYtE8Zz7BB4bBYgBBBwj1bnt9kW1CK05NF
         Ky5w==
X-Forwarded-Encrypted: i=1; AJvYcCVtvg0lSiJbksT/osowoJyBU3bv9ZYgDCtYVoRgwjq3ApDZ0KlLyNCUmzEvSNdZJpsakizNeajeuYDoDQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwSRpgm1iguiUFX+xG30UCF4YnuNfzRwBZqZ1xy6rhGZ1VpQK1
	i3ovZDWasN2tXusvU1oKCqhR7N9daioFzjDjUXMUVnUAj+fnweBbY9HwuSJDRoUW30q6ccibbTZ
	8dxMguXx8YJQLNF89gr3hnVpztu9Nkko3+JHTbucsSWEL9i2UEaUnhCjCCyJmXkU=
X-Gm-Gg: ASbGnct2e0mWsAcmk+1idEFj9tJcoFvhCGjvFBFDZYB3rvXp0+33//ip4HfuqLGFLH5
	ymst8lPS0YcaOviXC2RsgW282EupZgTqpnunyUfb+kbAY43DAI7qJnxi6AJN7TZqwIPp23fHm4u
	QkPtWyMM2OklJ5mqMF2eXXML01i9HK7GH7lpusVPYF937Ut23I5fiPsyTg20yiap6BASUF0DLkb
	Vkj5h3JkCM1jOijsxZdhzXDbmjed5sZf/VXw7XhZGzvv44sbEdenVIsJL50qxpgeh5qaTslVOpV
	Z2rDdkA2G+tpQEhq58H1w8hoGqphEKe1v9W8hwycduDe1PKZ6HC2tqW6hxOg8/0szG5kfg==
X-Received: by 2002:a05:622a:4e8a:b0:472:7a2:c3ca with SMTP id d75a77b69052e-476c81963ffmr34953701cf.7.1742045723090;
        Sat, 15 Mar 2025 06:35:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUt8dFc6yPLQJViuCPwIfOTQX3Mc3p85ry4mkaqwHjoZSmg4ktb3m5OS0Fe+df4/y+GbHwlw==
X-Received: by 2002:a05:622a:4e8a:b0:472:7a2:c3ca with SMTP id d75a77b69052e-476c81963ffmr34953521cf.7.1742045722700;
        Sat, 15 Mar 2025 06:35:22 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a9db94sm379385766b.171.2025.03.15.06.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Mar 2025 06:35:22 -0700 (PDT)
Message-ID: <b1dc178b-73d1-4fe4-852b-0a1f5bec2b63@oss.qualcomm.com>
Date: Sat, 15 Mar 2025 14:35:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remoteproc: qcom: pas: add minidump_id to SC7280 WPSS
To: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250314-sc7280-wpss-minidump-v1-1-d869d53fd432@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250314-sc7280-wpss-minidump-v1-1-d869d53fd432@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JsfxrN4C c=1 sm=1 tr=0 ts=67d5821c cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=WWQFUNGd85j635JlVwcA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: A7JEP6Gitz7cHtOmC8Gqc9pA3J2xZWAn
X-Proofpoint-ORIG-GUID: A7JEP6Gitz7cHtOmC8Gqc9pA3J2xZWAn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-15_05,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=882 impostorscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503150096

On 3/14/25 9:24 AM, Luca Weiss wrote:
> Add the minidump ID to the wpss resources, based on msm-5.4 devicetree.
> 
> Fixes: 300ed425dfa9 ("remoteproc: qcom_q6v5_pas: Add SC7280 ADSP, CDSP & WPSS")
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

