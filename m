Return-Path: <linux-kernel+bounces-426289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6738A9DF148
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 15:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C095281285
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 14:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC19B19EEBF;
	Sat, 30 Nov 2024 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cPSnlZhO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC2718A6B0
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732978117; cv=none; b=CjWzdx3ivaPTiHZdyS+9BUPeTuBg0t8hgoBa3+rpY+R/uOvSGPC1HnR7dy3dsUzoGmiZB5rsQARsTRwnmgott0r4VEfgXZszsdff/zX5so53enUqLLct8xq2DarGoilA/x9fAVWiN8RC9o0aYIGbi3m3zz33dGUptMCerY4A3/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732978117; c=relaxed/simple;
	bh=SxMKZqWHINuMIWk2ERrR36po+nHqNifEB9pvK/kYI2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lyG8JhgcBTlIxVN1WQTGiAabgk1YwNiB9Uax8tUsVYR5T5LZeLIjUxeh6oRYoYCgEy5W6vOcaAK4Ndq04YTcTiCAQx+OGtA62CJBj8rsk5UG3he6TXOvns9GNL2JJMng9hTBwwIJqcjIV1MsexGjC51c0vxerHLUc58qz0oo41c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cPSnlZhO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AUAuiW8002702
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 14:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7zbg7/a8AqK410FZRMTiXn+gGp6N3/qpdAoKw9aQPDA=; b=cPSnlZhOmCSuNKf8
	MOcZ7IfdAGB8gnU9/BqK03ExM9nLkh3UW2rLySGRgXXjw3C+ry1YJhCeLh9Y5yL3
	K5YJ8reZicLXW3YNLv3i5YyFScbiAvJEWzu4J08VodkendnU58ydgULvg1rjrf9m
	QeVf2JYkhuVt4EduLYMnBBlNrzZnMSZkfEg3rQxFmwV4/SCznoIZcSGT5Uq7Prum
	vDOBYpLRqZv4ledSsI+4fuHsPiEbISXDDYI2Bhq7lWbCZSLg9r3qgboMizbVR1ao
	ZCvoC9BiKCEbBeM135rcMIbaQ+IRSDmgZOFZHCIBQkxMgB6T8pVweUdRpjazLIC7
	BGFqPw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 437ufe0t99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 14:48:34 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d88fe63f21so1597916d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 06:48:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732978113; x=1733582913;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7zbg7/a8AqK410FZRMTiXn+gGp6N3/qpdAoKw9aQPDA=;
        b=LyJa8/9YOZ7xXK0z7Sew486w0cwW8Ha7KUjKWMVBZLfbxFUiN2tFCC5yIj433G1Ka1
         X28LMoO3bPQlD4Reul7N5xYL1xejRzCTiFnUNFQIFJlp4lE/7qwnStdfEi69ARyjFLUA
         B2jEBlw9iVBVbpM1NCRZhfI4tF+O6dI7I9BG5v961zo2UKJfAa02PjosyJEsH777ubC1
         qPBqY1vHhPvEgfw8tOr6SypOTaHj8tyX0IUTywe6qnL8wTTN6KyMY1KtvnTsq7fv6FKU
         FDGdz83sASsgFb7Mn/zYoHDYcJcC6Za3wFc7InEeHpPiWnBORwppTPNkWgkZXB3WjwWa
         4/eA==
X-Forwarded-Encrypted: i=1; AJvYcCWrfczUPpLCj+k4CgbPIugsWvPcfpDCl0SqNDskbE0O8Vcp+/YFgkZOIiNYE8XrXw39L1/0xzlp6MmIghU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeFG2uqDf/eaa94hzeq+YQ4Ln7WtCiDyEtJuvSmIlyEdbS84ZA
	t7BZhMosbOOzkVHIrFrYdRjPymEs5DBntYa+9uUvA6xF/p/L2Zw7GHhbmLGhLTjQ0Ueidwbuxba
	G7+glpK3d19d1kFX3TmQFcJUz7elRTdirW+jjUg0h1Z72oI//y1ga0w1zuvIIxBM=
X-Gm-Gg: ASbGncv3X1t9vSPKDuYZh2ImDZoU/6w5wJvip4H//ZnEnQYyr/3o3pw2lZnN3r4eOOC
	sulGscF5281I8S0CR5PZ6+Fz4LoU6M1Q4om2NaqimJxziSREwkBy0237a+WZBQUPo+AZqXdEtVS
	WFaVFoFRZJgThOIUQ4XehyU3oHgODWMlo+Eo4CuiKw5hdB6QocpQLCoJgesIH5EOvmUXXV8+Dy5
	yQHkDRkphCkw6rYPUyIC1B/C/QyF2WBRt8Z9BQAcrlUpoTiCdxU+PYiaihDmOljemarRLPWhqwJ
	xepB+i+ltoKM1Su7HsV0oBTItrpb8OE=
X-Received: by 2002:a05:620a:400a:b0:7b3:5cd2:783 with SMTP id af79cd13be357-7b67c2ecb97mr812516185a.5.1732978113492;
        Sat, 30 Nov 2024 06:48:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeY8KeawgKDJwviovT2Bn0JoxwOM88gdpGWgJSdYTdl6Hh3GheAU3zBCTDOc9MEO5DqXkVhg==
X-Received: by 2002:a05:620a:400a:b0:7b3:5cd2:783 with SMTP id af79cd13be357-7b67c2ecb97mr812514685a.5.1732978113206;
        Sat, 30 Nov 2024 06:48:33 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0ac78c0f2sm1964681a12.10.2024.11.30.06.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 06:48:32 -0800 (PST)
Message-ID: <a76ef7d1-8407-4ec0-8180-83ff39cc0487@oss.qualcomm.com>
Date: Sat, 30 Nov 2024 15:48:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] arm64: dts: qcom: ipq6018: add 1.5GHz CPU
 Frequency
To: Chukun Pan <amadeus@jmu.edu.cn>, Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20241110140019.3426181-1-amadeus@jmu.edu.cn>
 <20241110140019.3426181-3-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241110140019.3426181-3-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4guiBlLP1-Ad6pN-a7BS3DA_iWpBQnUP
X-Proofpoint-GUID: 4guiBlLP1-Ad6pN-a7BS3DA_iWpBQnUP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=692 clxscore=1015 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411300122

On 10.11.2024 3:00 PM, Chukun Pan wrote:
> The early version of IPQ6000 (SoC id: IPQ6018, SBL version:
> BOOT.XF.0.3-00077-IPQ60xxLZB-2) and IPQ6005 SoCs can reach
> a max frequency of 1.5GHz, so add this CPU frequency.
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---

Similarly, I can't seem to find anything to back this up

Konrad

