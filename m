Return-Path: <linux-kernel+bounces-513085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87323A34180
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 507251894311
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074B421D3E2;
	Thu, 13 Feb 2025 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EG8tf6P9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CD3142E77
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455392; cv=none; b=PCGlxoogrjlLVqmlAqLRS4MNqneIP/z78gf+/JNADxU5KGzTlD8O1K0BZm62ac8Y2fdFIYNnOo4rT9y2DeEwQq9ldCYlBLWoUl6oDu9Fyc3HknMiFKD8tdENWHFslQc6QDppsLDKBgj2fIrpojpTfj+ZtXlw2fr9Vx2uqyQ/Mo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455392; c=relaxed/simple;
	bh=vwkpPEmLKeMcnDl78At5FuWa/pfr0trYWV5OyOQucs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C6fp/45v9ChyycehUJFKr9msxgg1+5WPSk2Ld+mlpm4fBKQP4yGEF/naYyKlxcvFRhLLbP/TbaHYRTIcsUh5m4yhudrtUM7PcBG6f9hR9H4z1Uqeo48Y2bL2wxGU0n1lweaUBtpFGLQECNa9P6xhIi511Pf6KJmP8NWapuI9rgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EG8tf6P9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DA7Iu7001322
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/5VpsuLdCAZU3fZXBzng72UGalOx6ElpR1QJjGggFtY=; b=EG8tf6P9m//EdFgr
	f/qOTfQ1kGjAC2FUACXqIFFRgpklnI9Uk6Ac2/Fglgw6v9S2T8ZhdLuqWkRLiIBW
	0zaQNskQ+VsH7+zFZfbC6a0BY7Z4++yHW6cDKJ6g3frKcyLynjLnYwQeZqFLvgi/
	9qiR2npHSocJVAZPQNC/7hUow9p+QF1Aasr0g5nzUr2nAksYHTmRm9mPouxn/5q4
	/gPHMudKHtm5lUs3FKRke9/G3WghBoRCkTaSD37Zw5EvmQ6e+hST9bs5jnoaCzjU
	0Pq2bGcseD9+YtozyVDkBMaQQvVpOqgwswsfOGb0kdYANWDXB6h1mmcuy5JkomaX
	Dzkg+w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44seq00ke4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:03:09 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-471b9ad3f10so1932281cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 06:03:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739455389; x=1740060189;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/5VpsuLdCAZU3fZXBzng72UGalOx6ElpR1QJjGggFtY=;
        b=Qj8chJX6W3ZyPex3Hj0xOMf3wzMFuFLuxgS0U36rSeNALiBYxAoW0Y0zFLY7yfdzho
         pbvP6O1N/lGb4frTjwYJeyiSp+ECAc2GVGv5vDAva/SSJkFdjyVpF9xVoP5jKIGT4LQK
         UJErGYFrcUPlWSBq39+uHpIa+70ZBzPOpBPBC0J45ACUmUroL75kkyudXw9npZYrgzil
         ejZwOwnh9IjV2JNhsXps2AWndJlz8k4hhMeIG555fhRA1RbN8GraJiQtEyKuzZX5vyCK
         Zgy2B6u3as5krdx6BSRoMaSXdLfxRcgSxVS6SiO00sPFB/BHwpFzXSdjWSSeeimueJnV
         dW7g==
X-Forwarded-Encrypted: i=1; AJvYcCXcbHoNX7H4CTD/BCI+4ZciYSDEOe0nQINFlxXX/5z27701n/WkBm0UqUXSgIqAV6FH5h9c8QcQvqZQsyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2FmYhpK+SWfUea6uxqy90r4U1p0yKW2psabmhgpXqml88uPLr
	AtGITLRbj6V9DnGOozAovoa6kyOADlUwx41EChpFyFeD8DqhRhpimCZ7+I/ENf038R0LZKNOl9s
	S0ZYKj07IydnQbnQdOU90WPC6Y4jxtsKf9A4imSd3S8Mib2x37JJdKvGOrVWbljI=
X-Gm-Gg: ASbGncs132RAQsW9p6iL0l2wvtXx1j6udT6dWSkjo0fx4Q+x3goxx5IFS/1Mxd8Sf7C
	mwd1ycMe/wgwRcAHVCioFaTb9BQ9IPLDu7dq/460z87w4H1o4cNjcs6Uw8fvE/Fo0ij9Oe6Ukps
	5UlNc4QAvK2fOcueE1GbtjhHl6NTaOam3iy//L9IVcScCOdGuA21VvPMV3rTbnrgRXKtW/411pB
	V3ZqMuc2ql4Q+YdA55kxjN5mK4LDyESdALztwBbFHJu3Ls3scpAHno2eU3AjLMZdkMuEmyS7PTx
	1EsgAVLJQCCRVtcUR42vyXDN4AQdXJkklpae63q3XJ4l5v+fotOO4qNszO4=
X-Received: by 2002:a05:622a:4292:b0:471:bb0e:8084 with SMTP id d75a77b69052e-471bb0e80e4mr28606921cf.8.1739455388788;
        Thu, 13 Feb 2025 06:03:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF42JZXUGu/JVphxOuwa5AUtM/bnsNKkcUPYqVDmecZDBrVQKesnXrSST6fw5mgPmfKdh/e8Q==
X-Received: by 2002:a05:622a:4292:b0:471:bb0e:8084 with SMTP id d75a77b69052e-471bb0e80e4mr28606761cf.8.1739455388421;
        Thu, 13 Feb 2025 06:03:08 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533bee9dsm136345466b.173.2025.02.13.06.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 06:03:07 -0800 (PST)
Message-ID: <a77fa0a6-c9d7-4454-ad47-d03a3026e104@oss.qualcomm.com>
Date: Thu, 13 Feb 2025 15:03:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] arm64: dts: qcom: ipq5424: Add PCIe PHYs and
 controller nodes
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20250213071912.2930066-1-quic_mmanikan@quicinc.com>
 <20250213071912.2930066-2-quic_mmanikan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250213071912.2930066-2-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GnTnjzrpEko2wUvqhDLVzVSO8SBmtlVz
X-Proofpoint-ORIG-GUID: GnTnjzrpEko2wUvqhDLVzVSO8SBmtlVz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=931 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130106

On 13.02.2025 8:19 AM, Manikanta Mylavarapu wrote:
> Add PCIe0, PCIe1, PCIe2, PCIe3 (and corresponding PHY) devices
> found on IPQ5424 platform. The PCIe0 & PCIe1 are 1-lane Gen3
> host whereas PCIe2 & PCIe3 are 2-lane Gen3 host.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

