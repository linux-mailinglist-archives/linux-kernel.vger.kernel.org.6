Return-Path: <linux-kernel+bounces-566339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DE8A67695
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E0A47A5AEE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5AB14B08E;
	Tue, 18 Mar 2025 14:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EanalfZE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428C320C47B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308663; cv=none; b=ZtfDurUejNGZegq7rSlzqQeAS5/UDNH0PP3wN8/B3pK76hsKv4acAsUEeBRrYH8BbS8TOI+l0nOTLsUaSaTVoHgye/aMGKstEmGZKsYDDWA6VsTxH1pV/jupS3bJhXsmuqw4w1E8QlnOtJ4WOwhs6N1KYdls/NRp6qwhlUT8wrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308663; c=relaxed/simple;
	bh=f3Kb0SD/j7LqGiB2vTof45eXZq5wClA3mytGUkUMKiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWXW8EywOWPglviPQqdJWyLDtEp8J51M5KmT+HAgN88TfCHsLHZbbHLGL09y9k1GANVX3RdvLZt9MrwJ1CU9/DyjuPHpYbFmTRawqhfuB0MqIBAbgB07OSYFFwzS78UDbA/MGAMLO/0WydIJLj0DR4Eb6A3mgXO/GUzghMwKp7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EanalfZE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IB4iqc023271
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GCKrDwqSKjmhyeKOOoVxGn0RwDBU8qLuV9+cCH02kvY=; b=EanalfZEWaMlnULA
	X8r69MwvC9mgLnXuhFIFkf4iM/aiYcUUwNzpWLcGrX//s+p+Z0Flxkm5qxf7711Q
	wMVe5Oh1j3toGMyCZtQeCTnv18Wc+cEbGSNg3w6nsOf3vMVef4UOPJPxqUlE+R+c
	RcpXLTo1GitpFF6ia9HNv+yxGd+okp5OL6zP2oYBSEA67X3m1F4rMIf3iMW2XFbM
	PbNPFqYuuN53AslI+4bPbaXr4thslRD/1lAJ4Oxm5PwyhoOuOuHoHvBYx363ZdqE
	HOIw2G71NnEFwyNybVMzewUP4Oq+iJY+pMpPP6Ls8Hq/H6jrsHW82GVjl439bqhn
	FylJ3g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exwx25e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:37:41 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4766654b0c3so9615181cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742308655; x=1742913455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GCKrDwqSKjmhyeKOOoVxGn0RwDBU8qLuV9+cCH02kvY=;
        b=vA9GLJjXvEt+j1fZ6Iew4tKbY+iq8TJ4PcOQOk12UPdISbSYhXtVnMpg4T7FYwk1c2
         9/pWP+XqEcHU9CyhIoDXUAndxcUVkY/Fz5Y6SLKcjZDT+ZiB1Jm7Qur7m2zsGaGTuNNM
         Jsav/5oNj8az/xG/FoCfhCn9jr90nfChRlXnzeuCjlaYxJKen7qeKydQTfq4uLDX7+oZ
         yZUxu9RBWVWgpFEwgoikMJHaVoMghCASG3EHYYHI0CaPPr902BkawXWGABITACHOqD+h
         DV3j+0JgMB2tqwTAGj/8sIqqNVfIHSMHj3yF2ugYiaSV1F12lzHz46ZY4CBaoOk6p9+G
         AUVw==
X-Forwarded-Encrypted: i=1; AJvYcCWSfNvGRvGR6lLMK9AgA+uc1P3r/Rg+pCDKEUuFqxHhJGixvLv8C6yypdHekig+Np9IV17dkAMSP6SP2RY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy56aWWYT9b41R6rNHBlsE+x8hJPd6cqk51jrwkyDr9JSlgGZOu
	vGFSVTi8gcdPVlaXSYkrJv/XxsI5JCCNoNUZn8/ZIQ3GF1NmxJVmXWY0IcChfLbqL2F5KzD6XQB
	HOHGFGngAcA8k1GKoN57WyyxMHQ8/QaUJEcKpmySwQ/mCft4CPr51+5hYfqliIPA=
X-Gm-Gg: ASbGncvFz+Dxif1zj8CpllTEn9+inzP2YYAaZ654GLlNGDOjluu10UI2Ce4LYqiReky
	34G095FQzHqToqLDS5dmyDsEZ9kWFiYXSsTMOkPoWs9pCWfItcghtczu0fi/QRtYZLMuguhegpP
	pxpBgkkUKyTyMDWOY1iwXLs5EY/bv2t3Ttu/ZRMsGDfb/zaI+HeOBM6DqN4JKjze3JN9/PBCPHN
	g9DP/+Au6h7aUYiL6oJst2fuWNE7NnKc9L9SCdSiLWZZ9uMwco+6ZByaPgNGr7db/C5VtAzlQxR
	akQCtBYvJfuON4FkXV91YLitntZpksddH5Kqnf5+Vy9dNURWKgm0PX3iG2tR3s1UMrUYqw==
X-Received: by 2002:ac8:5a4d:0:b0:474:ee9d:43db with SMTP id d75a77b69052e-476c8195536mr91629641cf.11.1742308655038;
        Tue, 18 Mar 2025 07:37:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9XlW3vxIbChrkNlEMFD1fJVPzEE60tzANRziluVDqnNCVbhsb/A1XFOWf+p/vkEK/1xCqJw==
X-Received: by 2002:ac8:5a4d:0:b0:474:ee9d:43db with SMTP id d75a77b69052e-476c8195536mr91629481cf.11.1742308654623;
        Tue, 18 Mar 2025 07:37:34 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aeb2fsm876771466b.15.2025.03.18.07.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 07:37:34 -0700 (PDT)
Message-ID: <61ed7f53-e7af-43ab-bd92-15317b94b617@oss.qualcomm.com>
Date: Tue, 18 Mar 2025 15:37:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] ARM: dts: qcom: apq8064 merge hw splinlock into
 corresponding syscon device
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Lee Jones <lee@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linux.dev>, David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
References: <20250318-fix-nexus-4-v2-0-bcedd1406790@oss.qualcomm.com>
 <20250318-fix-nexus-4-v2-7-bcedd1406790@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250318-fix-nexus-4-v2-7-bcedd1406790@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: M2N3IBiOKD3ikhv-sv9V9ov7AusoWJ1Z
X-Authority-Analysis: v=2.4 cv=INICChvG c=1 sm=1 tr=0 ts=67d98535 cx=c_pps a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=RnBFEU2T-AcrtaIZjsEA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: M2N3IBiOKD3ikhv-sv9V9ov7AusoWJ1Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=627 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180108

On 3/18/25 2:22 PM, Dmitry Baryshkov wrote:
> Follow up the expected way of describing the SFPB hwspinlock and merge
> hwspinlock node into corresponding syscon node, fixing several dt-schema
> warnings.
> 
> Fixes: 24a9baf933dc ("ARM: dts: qcom: apq8064: Add hwmutex and SMEM nodes")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

