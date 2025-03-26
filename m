Return-Path: <linux-kernel+bounces-576983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D377CA716FC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E260C189C328
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3C01A83E6;
	Wed, 26 Mar 2025 12:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l/ebEhV7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120D71DDC12
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742993752; cv=none; b=G38LR/okpL1oAiG2EobGCUW1oqrg380nns/hhu19vRbh1v/AtRZB5SG6sfJ1JZ3eLiouWEPmS3pavvFjVdY6SMZGauAza3kVmkuUjnZR5rhlqIKXtAwBJBUiajC4NLM9nn8cPj5k7bUrsMwB8m4OpZedFUk0pl5tAS+4gA7kWy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742993752; c=relaxed/simple;
	bh=Hlpcqk5lqaENv3KqC4F73OEnJFQv5GOY/52c173rl4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFn0QCyduiTGuFHzp/JN3Wl/ZWp1DZaWtjHDGijKjBUx8ud7kqKIoQz8gpCUO0oOl4eMM0eC5f2LVaQkkgkh1qcQuhd+3ymkCEngWsKWkAyjfmy+hOTCMw1s8jogWpW6SvovX/yXMryf0GQnPDFKh8PBjmYWXTEj/Jj9PkFwKQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l/ebEhV7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q73DJK029695
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:55:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hlpcqk5lqaENv3KqC4F73OEnJFQv5GOY/52c173rl4w=; b=l/ebEhV76SQj544f
	+Y9r1ooTACuPTCY63Yqe56Nqli39mCMsLBfhIwNpvnuSkj3yOVipyx0k8/Bd2GUA
	odTtkngLscm0xc5KyIbSwBzZ03m/9Oe0UyQF9sWlt8QNqmMbWi9L3Hc5Qo2twtjp
	qZuEPh/13Z9ajYyXJNLsbjABFpEEA0SSW2kShMdzSdQUq9IHSBylS1ieI3jB938k
	0dPGaPBj7tQCeUQrRAKCnkMhUXm1tPK3crHcfynVoflTZswRKFa9IWO7Al28g+nE
	DKJeuDjYII7JnYL7mcz94MJyWKQPnquiXS0XJiqT+RcoFcUdqqoOSJyKN9tQD44n
	xovTvw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ktenbupc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:55:49 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c53d5f85c9so183236985a.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 05:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742993730; x=1743598530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hlpcqk5lqaENv3KqC4F73OEnJFQv5GOY/52c173rl4w=;
        b=WcflSwxXW27g7fS4orSKTeFgDjPXVN9+p2cg1Lh1yIUVRYO3VHFjfF8bOXBVLrFqEc
         2pH49H9DuQe54Z8ad7nCO09N7BejAC/dHGrLWxg1rjU7aJGtWoAe0ALyjZkGX9pXnyfl
         jU9ewIqF2kE5TTu4XxPIPmP58QUJnRSgaPIT23YoYSVzxsfb1uLKYtM+brBQLQ8ZiBZc
         lLFxB792yPf//HbqnqNYuNCeXFJ54KsgEqgFdGi7vkg6ktQZnhxwaO5nCvyjeNCLVgsx
         OHZsJ0vblXxHkIRXsHihYE75aki7NFYZRlpvbrvmGNqbsMncDMkPqtE4Rd+YlGUArYdI
         9zAw==
X-Forwarded-Encrypted: i=1; AJvYcCU7fYL3mUlj6sHvM+TQCCNuOfXaOt8KWuY/orNLeOgOH4pTrCWTt1jSGvFpOUHejqE1wDOYwLvaprMIqWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzezoAVojGhA8LBIiNwJThvb9Adc9gsoAlD5GpM1IKQPVLakOIe
	f38t89nY2nF+0ADyiJHl3r+KxO6eqpnNG+spvramzU3fTtL3bRjkAi/2U5gvHYJQMXj1WtooDRN
	X6mv0Rz5FSWG9uGKb6EHwbc5olN1p4r4dyjmEB5IEv5rbstSRlE43jqe3THfedBs=
X-Gm-Gg: ASbGncvKeKPhl7dTj9R6ELVZPMsFuvytY+louTCkGTi1+FpF7Mqrv3DMRvF7RpSUYXa
	FR6w6kiZr9I3zoexDmQRiZBEkUrqhkWZf10bm9nEbSb4tf2qUD5liMJctAfuwCY/PEr4kh3vGJh
	Ov3HbL30fZDlXrEeyDrNfg6sisU0tSftdu6kNdWBmrKcUPKKmNZMyBSIRdjBE0Y4FSJ4i/3P3lO
	DhrqspBHD41hn1BDCB7dEEK4DkwhumTsJLh6TgL5qYa9oh4okMsQKnW7QOV0EJajAFJMPrINxi5
	yHGVRqGP8PX38PR6M1ZCJXa7OdCGKg0B5HQ4or2Sn1qzgQhPdxABsxQKvH4c8Gka12VXEQ==
X-Received: by 2002:a05:620a:bcd:b0:7c3:c814:591d with SMTP id af79cd13be357-7c5ba12db8fmr1183627885a.1.1742993730497;
        Wed, 26 Mar 2025 05:55:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWjYJmUaR2pS0MBM+C9tZ4PgAEjRTIBh+2Os/3Hu9gB8kQ2ZslbY19JmbOXtqnWcm0svpCcw==
X-Received: by 2002:a05:620a:bcd:b0:7c3:c814:591d with SMTP id af79cd13be357-7c5ba12db8fmr1183626085a.1.1742993729994;
        Wed, 26 Mar 2025 05:55:29 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac6f0b99fc4sm51757966b.85.2025.03.26.05.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 05:55:29 -0700 (PDT)
Message-ID: <b1f16d67-b61c-44ef-9e96-869aad0e17c8@oss.qualcomm.com>
Date: Wed, 26 Mar 2025 13:55:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] spi: Add support for Double Transfer Rate (DTR) mode
To: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
        Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org
References: <20250326083954.3338597-1-quic_msavaliy@quicinc.com>
 <d6210c5e-339e-4feb-ad4b-fad456ec5710@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <d6210c5e-339e-4feb-ad4b-fad456ec5710@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TuvmhCXh c=1 sm=1 tr=0 ts=67e3f955 cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=qToX29ahzgIKO7lzqbIA:9 a=QEXdDO2ut3YA:10 a=ibwWHe-yqzEA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: gX191oBjiOrAIZFgfLiySdDC2qGr5kry
X-Proofpoint-ORIG-GUID: gX191oBjiOrAIZFgfLiySdDC2qGr5kry
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_06,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=823
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260079

On 3/26/25 10:21 AM, Jyothi Kumar Seerapu wrote:
> Tested-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>

It doesn't look like there's much to test here, you may want to
leave an a-b or r-b instead

Konrad

