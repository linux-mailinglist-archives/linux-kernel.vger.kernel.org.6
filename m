Return-Path: <linux-kernel+bounces-552558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D876BA57B42
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 15:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E193A2C16
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 14:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A61B1DC9A3;
	Sat,  8 Mar 2025 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XdlAcI8m"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E6C1FC8
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741445501; cv=none; b=GrZD5WboWg6lZ9bDvW47Fqjbt7B7PJC8g7wKBV0JoWiot2f87Rm4uSIEcmfz96EyfNAGWf/z6IgQUFEBMbN+v0d8UjcpQKq2ynnp/jb+OSF4NhBEsCNh1grsjDL0JKWZeJ10gH8Ps/OIRky6Oh/lBAjNvx05ATa3iUxYp+lppSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741445501; c=relaxed/simple;
	bh=p8FE6Yce4UFFPFp8RPlL6Zq6MyjvmqNXaWFwHY6Xcwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hQImND01DKf9e3/GWpfHSKzYjhN+a4GlmAJ4+anKiKroV11E9RH/RhXF0T+UYA9Ey9z7COB1+/zXcPSYrbzsYf7M63DFB3QOBq/7bAVmPbfv60yL8M5FJ2aNd9JOO9clf+JE7q3QPcmqUTA0GGB1M1hAB0OAPEBBTv0ofGuSP2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XdlAcI8m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5289GdGI014230
	for <linux-kernel@vger.kernel.org>; Sat, 8 Mar 2025 14:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ajkDcMXkTChhLB9nQXqXX4w1XlD/zn/bmx5ISWyGiDE=; b=XdlAcI8mJvT5ZzSC
	BYdYS14qi2YMrDMG0SARJc7twAMD4ylW/xAiRf7VdzLeQ0p2B88dgMBNI3Vd9/lB
	yg5bLTeegaMxv8TOxoKsro/HOMyWUoyS4XxoEWam/FQftEmPaY8gg+TpfSGOCd41
	5agraq4czLhmGRvhKscIk7UyEvzH1gk2B+vpDRV31EbIc+BIR50KmaoqruxUT+LY
	LueVsidQh+p4yB6nHt5hsOnSE2AGC9vMWSo2R7P+0YGy2exaMsVMwEaqrIepPj5F
	wUgZQnRQ2/y2AM5ss+YTNtGIe4uENpkPfwtM6bdha7fBjl3T7QTn8eZ/p/5Bbl94
	vYh30w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458f0prny2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 14:25:10 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-474f467e613so7926751cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 06:25:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741443910; x=1742048710;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ajkDcMXkTChhLB9nQXqXX4w1XlD/zn/bmx5ISWyGiDE=;
        b=AVw60g9VHJzRLyqwPxLC5ewebLOwchdenQU2+0N8jAiqlENm2cDpczsyNyGCwbalVL
         UTtjPLAfe4ad9To3tpBwd4KhRpVA5w26ohxQ6qpsOsvUJZdpHYrAdo8QIb+fulROa6TQ
         8uTykMrv/05bLa3neMKD8nibPsmKmVySPIceVevswEMtl2t6QdRSiD8e4qiO42mUvCiq
         1wty/eZlPsCq8OvNM0vQT2aUE/crfB/qBmzIlEOCAntk97kCb/cIUKc/lR/QNA6QN2qo
         LblJZ1+JBzQ/T851DTd4FYH9edHgL64aNeb8CexfNYJtMrDWBnHAr5UxWPFuUHQZBrnA
         SU7A==
X-Forwarded-Encrypted: i=1; AJvYcCV+U+u+CeoLfp/VJ6psggljklyfxCp7ufyO05ZE0y5yYmaWz3KqQJjpDbj5EHL3rh5dkrGb0DYoecZjV70=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtJhW2DEgjbu+3/S2Yoa6FXMp+3FH+5SMive9yO7RPO07aOBX4
	v19RnqRw/L+1n+Wm92hHp5F1whVX8ig6WmJ/TJ2Yq+xaVjiHjuNxxjCSr32PlJSZLIe2gfARJKl
	o9Ds3eXUeHLBhaZsNBarN2a/REREY2Yg4trXRWMczwlgvFzUOMsANIKyqGdhrFFY=
X-Gm-Gg: ASbGncupMF0rU72OreZr3K6MZCxkrpFkHILS0lyZLQJ541fqGYiRzgBX3bV6h5r30kg
	IGApwmpiyVC2V3NFkJjrcyr5+X3gNst80ldiAxA16rBFTVgZrQiCZBaV8u9aHWm1K9izNRoqFN9
	AFq0z0S/ElQ3KHQp9L55ouX1hCTjwbKWZ5SNihYv2sGWo3ZfcYTNdshCClY/b00E20qi4r35VXO
	Iz8Ov0Xc9gBjHxxQgiqBxSqF38M6ZyvPHmMbLdTsj42WB9K1Pj6Varma+zx0sZtqGgCVJcAucYS
	VtgXYGKnXZtvcJR5cQ7FX05YVxsyky74P7dO/YPLuLMvsgOti6p3SuSMrKBiuQNNQY5Stg==
X-Received: by 2002:a05:6214:d6b:b0:6e6:60f6:56db with SMTP id 6a1803df08f44-6e908d8568cmr15818206d6.6.1741443909813;
        Sat, 08 Mar 2025 06:25:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGf5Bpdb+EwGJ+DUwof9ezxDFy4IdGxQr6SUgAcI78hiBLBYecPa0sQ6yprSMZOTAU4uNWqGA==
X-Received: by 2002:a05:6214:d6b:b0:6e6:60f6:56db with SMTP id 6a1803df08f44-6e908d8568cmr15818006d6.6.1741443909472;
        Sat, 08 Mar 2025 06:25:09 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23973b09asm438894266b.119.2025.03.08.06.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Mar 2025 06:25:08 -0800 (PST)
Message-ID: <e2d84147-c061-4f12-a44b-f60919625f77@oss.qualcomm.com>
Date: Sat, 8 Mar 2025 15:25:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] phy: qualcomm: qcom-uniphy-pcie 28LP add support
 for IPQ5018
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        George Moussalem <george.moussalem@outlook.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        andersson@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, kishon@kernel.org, konradybcio@kernel.org,
        krzk+dt@kernel.org, kw@linux.com, lpieralisi@kernel.org,
        manivannan.sadhasivam@linaro.org, p.zabel@pengutronix.de,
        quic_nsekar@quicinc.com, robh@kernel.org, robimarko@gmail.com,
        vkoul@kernel.org, quic_srichara@quicinc.com
References: <20250305134239.2236590-1-george.moussalem@outlook.com>
 <DS7PR19MB8883A6C7E8FA6810089453149DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>
 <oeu6wkfhx2masvendoweoufzit6dcwwer5bakzvg75dz3uc4bj@bwuj4slnb24e>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <oeu6wkfhx2masvendoweoufzit6dcwwer5bakzvg75dz3uc4bj@bwuj4slnb24e>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: B35En5fFlXaXPilHb02j4l9nIDCfiRN1
X-Authority-Analysis: v=2.4 cv=KK2gDEFo c=1 sm=1 tr=0 ts=67cc5346 cx=c_pps a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=Bxonh79IiWxE7T-ZNUwA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: B35En5fFlXaXPilHb02j4l9nIDCfiRN1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_05,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=834
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503080108

On 5.03.2025 9:39 PM, Dmitry Baryshkov wrote:
> On Wed, Mar 05, 2025 at 05:41:27PM +0400, George Moussalem wrote:
>> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>
>> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> Something is wrong here. There can't be two authors for the patch.

It may be that Nitheesh was the original author, whose patch was then
picked up by Sricharan for sending (no additional notices of
co-development), but George later did the same, forgetting to remove
Sricharan from the chain.

Konrad

