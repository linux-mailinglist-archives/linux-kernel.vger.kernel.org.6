Return-Path: <linux-kernel+bounces-434008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B80AF9E6017
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 22:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488DB18855A5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 21:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC941CBE8C;
	Thu,  5 Dec 2024 21:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l1Y1fJOH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B30D1B6D02
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 21:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733434088; cv=none; b=KkMHAhE/dEV/RZ8UGF2KUUv+Up41XpMg362AeQf2Fm6vsifFYC4lQkVN7XLYJIXDpvdW4bhaJImw3cdt76S55iDqg2ett+vHcHajWVoD8+zQSezbXA3NoyNMOL83PyoYv2ut5F/Ad5ZP+uiChJnvdKbwR3DZ9uK2pktX9ej8tgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733434088; c=relaxed/simple;
	bh=jQcNUuUDxCn3dN0kQAY4LIdcEjNmByuC06S984SDtlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FLh5UCahksQsgytfAR31RgDfoHuaGnUZDck1SPhJWuRHtfOos4POkNj/LZQzyXFh/cvZ35Q27gtC2QSMJYGirpwurs4r3+IM73tT7hkM2tDsgYBMQNczpCqEn8FckXTtkPnRa6nsvrL555jUAd7HQfuUWAdnvqlmPTZhBPnoVeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l1Y1fJOH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5HaNmb020797
	for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2024 21:28:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SAMrcNiwBXMAFwkjSpLCHgcVnjsjGKFzPzk9JPy3DCY=; b=l1Y1fJOHswNxv8JD
	muhtpEZMM0z7L6nEtIDBxs0W6GANAemK1CnYItVuX9fowxzxP2XMfbM+Ce/0ydnf
	B4tzyp60PfLeBICuZX3tdFeoCMOZ41SUbqNWDvXDFTNYZ+0xKRq8IojupAk47Yni
	kr7P9oBI5WrNch9ss3I5w030LABixogDuON4vmTakz+WNBRvggVjORG2N+MSBL63
	LqzwugBdfz9sz8f+mACnWSQv3Apm0QfQI9osXnvND17GIeXeiHy6dfdoW1CfejMK
	ZBgre3srn/AMQlNtnFhg4sa3qUnf4kihNfJ2VqvRqOX4ySZ+AI77S69Fll+0VoMX
	2SNZlA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439v801310-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 21:28:05 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-46680667b3aso3270051cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 13:28:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733434083; x=1734038883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAMrcNiwBXMAFwkjSpLCHgcVnjsjGKFzPzk9JPy3DCY=;
        b=eZoDY0n3acFbpjGqlDxQeg6Mf79zEVkF59S+bvbCM+c5H54ZLQn2/Ae2IOPIxSMsRD
         UsdhwhUHEQMPKZb9oZVP1274TDZ+WUlKMPN5CgpTmxGrSWPIFXIg6IRS+n1GSsSA3gdM
         U1wJUGvkVDtRf1HOJpQyUFr29W1DdYwAY4vlwsvYW9kkEs5FTtcOWA8L3aqikpFAZMPe
         gdAq6ujqkQKZ6+dYHHKzsq6hiawavRq4v0tgbWYedlhus9ADFNKYDQyRVNWf+46hVLRL
         kiuSQV2Fyryy+lNNJNuca7h7ku8sJBx9iJGiMQyYsnTkYFqJaQKG716K1uJlSWwRkmCz
         8ffw==
X-Forwarded-Encrypted: i=1; AJvYcCWF9oV2suFrkGvEZIs5gRTsDj2EYLnMbYP33NqFTS+Zf+PtF/IOt5rSkkrfH4ccRz+32Qjj5iDzAER6OXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYprh0xsw6puYZjQguV5imMlcFEkBxkw52od3hzReLZBtW0AD6
	c2+loyxMJK084cxmYHM+VP5rdMScYRtD3XN4yfV+hfDj0+792YKysc8SX5p5b9i81e8p5uYI823
	6YIJxwzdVfeBAQ2/RKn7TFS+Qddu8XT8d71Je9Q8pt/0fQDF5Mmua03YIyGd+fgk=
X-Gm-Gg: ASbGncvrLmKUXyX9Uv21LgJXHdnpJrhKVzK3qHQ9NDdiFh/Vl7KH12d0mPvdfarCCu4
	aVNAxb+ETU4QW819lBWxA6NKvJpU4NaarP/8VN41c+/lPUiiRY3xN4FvnbaLmX0pXmJvI34Pc9y
	AElo0sZdQ6l8QdVTEnnYGorWtkof+ivDAvfz2/nVGGZTxp0Yg/n+gc6Sypgt3p3UN6DHxPqnFXR
	hAnCjD2DqO0miUo9RFgXTRB15k0tQnDvWulnrqTLMNVsxh/b3d9NCN3AYAqx/p8uCg130iyKuSb
	ZppcTuiQ3kKeJDZtQDtYGGOFWllOjcA=
X-Received: by 2002:a05:622a:3d2:b0:460:8f9e:c48e with SMTP id d75a77b69052e-46734cbe7f9mr3792331cf.5.1733434083519;
        Thu, 05 Dec 2024 13:28:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEuK/EmDSiLXXkdFaVlsi2dj9nhG3m2IJIOMHn991R1aD2KvBq1gXiZLcNPGieuEMpGNWFTg==
X-Received: by 2002:a05:622a:3d2:b0:460:8f9e:c48e with SMTP id d75a77b69052e-46734cbe7f9mr3792191cf.5.1733434083174;
        Thu, 05 Dec 2024 13:28:03 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260ec5f2sm140940366b.195.2024.12.05.13.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 13:28:02 -0800 (PST)
Message-ID: <b4a2665a-894b-4324-a3db-5bc9de591276@oss.qualcomm.com>
Date: Thu, 5 Dec 2024 22:28:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: qcs8300-ride: Enable PMIC
 peripherals
To: Tingguo Cheng <quic_tingguoc@quicinc.com>, quic_fenglinw@quicinc.com,
        quic_tingweiz@quicinc.com, kernel@quicinc.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241128-adds-spmi-pmic-peripherals-for-qcs8300-v2-0-001c0bed7c67@quicinc.com>
 <20241128-adds-spmi-pmic-peripherals-for-qcs8300-v2-2-001c0bed7c67@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241128-adds-spmi-pmic-peripherals-for-qcs8300-v2-2-001c0bed7c67@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: IGOHwAU2CEDCzG82czcF18wfV3rcOiH8
X-Proofpoint-GUID: IGOHwAU2CEDCzG82czcF18wfV3rcOiH8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050159

On 28.11.2024 10:40 AM, Tingguo Cheng wrote:
> Enable PMIC and PMIC peripherals for qcs8300-ride board. The qcs8
> 300-ride uses 2 pmics(pmm8620au:0,pmm8650au:1) on the board, which
> are variants of pmm8654au used on sa8775p/qcs9100 -ride(4x pmics).
> 
> Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> index 7eed19a694c39dbe791afb6a991db65acb37e597..56e7194521834a7a6f5c5597e0f28a27a18d90d3 100644
> --- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  
>  #include "qcs8300.dtsi"
> +#include "sa8775p-pmics.dtsi"

I don't like this reuse.. and quite frankly I don't think this is
going to scale well, especially if we keep adding more qcs8300-based
boards and will have to weed out 2pmic vs 4pmic specifics

Please create qcs8300-pmics.dtsi

Konrad

