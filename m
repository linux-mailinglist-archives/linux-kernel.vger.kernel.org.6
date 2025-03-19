Return-Path: <linux-kernel+bounces-568149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1199A68ED8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888824615D5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C4D1B6CE4;
	Wed, 19 Mar 2025 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WPR/bXOA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960F41B4140
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393689; cv=none; b=UBt3r4FzmE5AJySwxnqKMXqn1KpvajcDbeaOVGf7QhzqNCgm5us1HEdDXhwfEaARXCPYWlANQFsx3SQOrw0FKL6/K6sCvR6GiAM1Aq76zPE/U3NtBbkkm9G7c56KgiqqbFQ0kbeSBbg2F4x0Fx4fQzWrKoZeyKhqXDVUkIschQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393689; c=relaxed/simple;
	bh=2MCKn9csCxsdPtacIyBliI1wK0R5CgpFopj3E5+OV/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ninp/0TVolZ8PZNXvqh6LhR5OE5NhikPrE23357a9e9+rwluM7gpyd/1JXNTkcrQlmGMmKZKhvwJCbNisCbVnxwtFseWrs9WrAiNpz/pEXW86s+3qPADon34yZ7iqJh5Zr1Ar/rRdYxpjZ5v6gFhSlCCPUpTjLEWatcfjpyRQL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WPR/bXOA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JDtaLO001980
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R9lm9ioOTOSwgPJPMJw9RqcbC+GqKLGC7kuCAnVvxm4=; b=WPR/bXOATCo1vEnm
	svUjeRGpp0weEY9S3o7XktquGwjDsCrnkfPATD1OWioYzj0BilZw+/Geq5imvcM+
	6OvGOsO3wMP62WmuROfjwh4FvxO+i42PFFN0+PWXCv/moF890wRSMGCkhQZzj940
	CDC0H56h232yiFhEQtc+x/9u4jfhh6YTYnENiEPIUITb9IUe5AIpEjR7jgzvLh5u
	AWxgg2w6vYmzo6AFJyWqPeT2Cd4IbIe1uSlrQnocETU+q9hi7L9q7Lj+16fb5jF/
	HvfDaTBu72jXnrRm1lV99xYDCwevKVI6dqtBAqJ3HspERcPJuIgQVAgiUIDEmJM1
	5/1xaA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45etmbx8mw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:14:46 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6eae5e6f05bso18564976d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 07:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742393685; x=1742998485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R9lm9ioOTOSwgPJPMJw9RqcbC+GqKLGC7kuCAnVvxm4=;
        b=QJb/FktjzRgO2lKgtRzOMFwju91sntK9zL9wfdIWsGt14ruTOMjtr1r3lOggO3rXoa
         ivqOtnVqZWF4NQZUkwe1thId6UPTBjt2tyKK39jDjo9Tz+K1o6ZAIm7rcs8f9SYn7xz5
         2b8fo7/a5eOqWo6+ixSd+BgFWo74Lxc9lafgizNcRr5PohP4mdQ5q6MVJuIOLdI+Pitl
         KwD4pmxubrSgCfNwrLB+mkT/7zGTbK4y5zY6sbBU3CzxnmQbSjFfqDMJJxAunAIAs2ri
         z6lBIwY+EapD3BR17UIlqLeY+mNCs9CiYfxNJkEr8YNWlFK4WLcfRkhslXV3jCMGahuq
         ABkA==
X-Forwarded-Encrypted: i=1; AJvYcCVMhheWfxYrLt+VUw2eYfgWyrlHOOpyEM3X+8g9U9iR2+MmQS+7GGRi/Fb24hSh/heNXlKErqD4GsVF+M8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbTHMp1IfEke7Kq4Y7Atf+OBIrhB5/i+20zwbMAx8N7wJUkWzV
	vGyZa9EWO/8UMUAijQePPsXErH2zsuA/VFlx6sUfI1pG8E6B//uYFh4xGoP/Wwdcm8s9qbZPRSC
	JeOR6D0c7Ogzv7m7Q3xSr6emICMWja0dtSpXfSWsYg5f3kmU3Diy5K2nekoJvLkM=
X-Gm-Gg: ASbGncs/Wml2Xut6ryfXp4H13/ATLiFHDO7GSwtuLWWynWkypi0C8ok+91+7+LFbz8R
	7fQWwCR1BNkcXsATFcDygr9JhzjJPCrZ+3flK2X30O0a3gqdDyBMN5FiQjyMRC8IQUHnu8LozJ7
	p5351io/wALtTc/koHFtPe/q+1Cja5GUA8PIiqP9leHLXAXO4qE/AJLNNptV/OECGXTQclBONju
	He/dIRlBpwymod/qu9m+SbymgmO1a95bZwLkfrUtCAnrcWlSDEdmPKfppBms/4wktHm9XDHt8/b
	mXNGg2sFPmUrqbQCCEOvF7Gblel1WXXY2rtSLucRLUgPJz/baHzpIpOJ4JYhPPBL+oXXww==
X-Received: by 2002:a05:620a:bc9:b0:7c3:d1b9:e667 with SMTP id af79cd13be357-7c5a83da7d6mr168225285a.5.1742393685100;
        Wed, 19 Mar 2025 07:14:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVwXMvt9Q5i8OuLf6HEko618Bxam7kur4WA83u4zm5HOoMhJsZeVA1tQ2ngU8rvFZ6xvwI9g==
X-Received: by 2002:a05:620a:bc9:b0:7c3:d1b9:e667 with SMTP id af79cd13be357-7c5a83da7d6mr168223785a.5.1742393684662;
        Wed, 19 Mar 2025 07:14:44 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e8169b160dsm9310113a12.41.2025.03.19.07.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 07:14:44 -0700 (PDT)
Message-ID: <881655b5-30c0-42f3-863f-5b6606a3e2cd@oss.qualcomm.com>
Date: Wed, 19 Mar 2025 15:14:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] arm64: dts: qcom: sc7180: Add specific APPS RSC
 compatible
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Marc Gonzalez <mgonzalez@freebox.fr>,
        Dmitry Baryshkov <lumag@kernel.org>, Arnaud Vrac <avrac@freebox.fr>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250318-topic-more_dt_bindings_fixes-v1-0-cb36882ea9cc@oss.qualcomm.com>
 <20250318-topic-more_dt_bindings_fixes-v1-2-cb36882ea9cc@oss.qualcomm.com>
 <l4vd2xmrowmmtefieb4cbirq6ntkvnwbhtpxcyzwdeok2vgtt7@zqgqndumgecv>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <l4vd2xmrowmmtefieb4cbirq6ntkvnwbhtpxcyzwdeok2vgtt7@zqgqndumgecv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: fWaZLou6f0pBUwAv5_XT28PE65KZDviL
X-Proofpoint-GUID: fWaZLou6f0pBUwAv5_XT28PE65KZDviL
X-Authority-Analysis: v=2.4 cv=aMLwqa9m c=1 sm=1 tr=0 ts=67dad156 cx=c_pps a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=yNzLgEpsGgLzqTARhdQA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_05,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=884 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190096

On 3/18/25 10:30 PM, Dmitry Baryshkov wrote:
> On Tue, Mar 18, 2025 at 07:35:15PM +0100, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> SC7180 comes in a couple firmware flavors, some of which don't support
>> PSCI in OSI mode. That prevents the power domain exepcted by the RSC
>> node from providing useful information on system power collapse.
> 
> Is this behaviour specific to SC7180 or only to ChromeBooks? For example
> TCL Book 14 Go or ECS Liva QC710, would they also use this compat?

The hardware and firmware representation of the RSC is identical, but
I wanted to alter the bindings required properties based on the specific
possibly-chrome platforms.

Konrad

