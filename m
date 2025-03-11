Return-Path: <linux-kernel+bounces-556932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E024A5D0E0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7039189DA99
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03637264A70;
	Tue, 11 Mar 2025 20:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cC2SurdN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1F4262818
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 20:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741725684; cv=none; b=kOdXqFWJV1PFevEd8OJ+CChWmmdx7rquurC+hLLqvNug9kzQBxY0gh+K3y47CwoatG2rcTPeT3xj01ZkB0yR1/2ixS77jw5tjD5/Aq6vMn7SkTl/CBcF3U2EP6GrJKSME6+uOBmzmc49PHdajbZFTWTo89vUiBve/gZVrIBPlPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741725684; c=relaxed/simple;
	bh=kIM2V8biAiLutpx9KlmobEvLwTNDg1O18hgC/BvRD0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QvjJNyAWhkoCSsj9nEOo1KdEhH208GnQZIb/cSq3ydADHP50tLm8lsUkws6+M0tq1JY92BY5HN0kJAUf/Cye03wJrjz/xYGUHTc/WtDdjEXAdHsiYJiIbAynNyAMsjW8EWy/1OyEybhAXV5aN9hLUlMldKAzAFHQnDM8PSLfCAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cC2SurdN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BJ8Cck010882
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 20:41:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sLQ0KfkPCjPMLHw7BAltp915xh5O2lt5LV3V2oD6d0M=; b=cC2SurdNVwUQoYPo
	XNVWb7PcK08yQ1KGspkyZOFlwCHI9Q3KPQgKnnG80HuIlAOHDP1N9AgkY6ffD+NU
	ZUTZSgKMci/LHohJ14A4M/rms8CiwOCB7oBZ3FSreIzRLTmUnP7ZngkBeXhvC8ce
	6IjP5+WW2/xfMV1t4e67sRMLKmw/IGjXkq5AENHB+LBffdL3Y1nDzz/dJzHZkV9K
	jHlkmrfcDE2LNvb7cSQ+HpakGSoflGKyhWlQGX4NKgyPnysQkMl1GwqHBWpt0+p1
	Kc3BxiYxFoWO4vsOht4JYGTZA0VbTxTFqnNOm6/+1a6k95J4Zkb7Dzf559Knhgdo
	ZcSwJg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2ng6er-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 20:41:21 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c547ab8273so50551185a.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 13:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741725681; x=1742330481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sLQ0KfkPCjPMLHw7BAltp915xh5O2lt5LV3V2oD6d0M=;
        b=NS3tN7Kl9hnPgZhJXHvoWW/XVCDVjIbSOa7FODulvZhkxPOuA/pKgBZh2GK3IRcvKN
         UnAasj/lKIwdCXsTMqPoEBj4bgZlzX+wLj8zIRaEHOvG4zCOh90GUX3LKClyrH2q/Nhn
         HbCGhX5/1QhiNga3gKR6ZZDY1r2rxzJbz707OjFzavdDAKDRO02+fyNuZhkocOivWJBB
         6g5+JzNcfTBHGnMvNIpHR8yvz8IzoNNvOHN+AW2wSfYudPVVXeIqdCEYsw6Rq/b62hXQ
         Z+pJVH0DykAdZlznKKLAaTnFdgZzqvH93CtljF/f041S+G8p9RYiT3OOtughxrtEJULD
         cWIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv0FDcS8Q1NhyFXDXCfbJQHN/M+0j4XNPStRKMzBsbtYp8/EJD8TROCvSFcMLIjHjJJ3Ui/vrND4Ep2OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhXhmjlt6MpKO/GUUAEw95R8indUNxpus0MfAU9H0UiEPv4wrb
	NDZEP8dOOoRAgENOCfI32KsIFDKfl5VF/lpziW5XeTsVf7GRi9QdkfzcV9nHV3Sc2mySWx3p5P6
	MyTSYSIwFg1HVIqPdTtbrCSncBCCZ8VTCNPIU6zxgWSinm4w7P0jN+VxtGsgl4Gb1ySo7Smw=
X-Gm-Gg: ASbGnct3mmrMk5k9fyN2J3lEGhjz8mdv7BIRvDPdTy4TI/X4J/icUTjl46Hb0Rya5yM
	jr1LARoJ4XLzSJFyYjPTom79E/T/yuK5rx3S14kua0dOaMy/7/rs4U/1AnsLNeGtH3Pkpd0oFs/
	j8NtBtiEW74uX7mL9sa09DRwPy6WSmlaTxs5O7AsR/BoyMMLJwuD7kgK0MW2tVHtZRLuK8p1LFp
	IM9rwggoj9N8g9sseb+4vJW+SBY8fVT9WylrrCxRZLKY3nr+57wbFdLIk02keREt9i/TvWxBWj/
	WTEI3ME+iGppx3IcD4Lvw700o8rolLIy672IyrbFIuHJviEJkQalVvl1aKwINP3Defu5FA==
X-Received: by 2002:ac8:5744:0:b0:471:f08e:d65d with SMTP id d75a77b69052e-476994ee814mr19232961cf.6.1741725680679;
        Tue, 11 Mar 2025 13:41:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLjlOtUEUcX0M4fUSeDJ1nrMjWHMrBRLf1b3J3Ujb+qGO/6L9yMLIkc4n/AftEhJfu3e6x2A==
X-Received: by 2002:ac8:5744:0:b0:471:f08e:d65d with SMTP id d75a77b69052e-476994ee814mr19232841cf.6.1741725680327;
        Tue, 11 Mar 2025 13:41:20 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac27af7fcf5sm609665966b.180.2025.03.11.13.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 13:41:19 -0700 (PDT)
Message-ID: <827ca00b-a895-4aab-bd1e-7866df730fef@oss.qualcomm.com>
Date: Tue, 11 Mar 2025 21:41:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: Enable Qualcomm interconnects as
 built-in
To: Dmitry Baryshkov <lumag@kernel.org>,
        Christopher Obbard <christopher.obbard@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250311-wip-obbardc-qcom-defconfig-interconnects-builtin-v1-1-675b6bc57176@linaro.org>
 <vjkdwjudqsgcq2leabscnb2r5dbtztgfq3jlkfowcauslaymkp@qsxnpis3ksp6>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <vjkdwjudqsgcq2leabscnb2r5dbtztgfq3jlkfowcauslaymkp@qsxnpis3ksp6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=M6hNKzws c=1 sm=1 tr=0 ts=67d09ff1 cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=R3joX-Mc2FtLiZgaDpIA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: EMNzKif16lgmjqbg1YOQEO8ACYhA01O_
X-Proofpoint-GUID: EMNzKif16lgmjqbg1YOQEO8ACYhA01O_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503110134

On 3/11/25 7:52 PM, Dmitry Baryshkov wrote:
> On Tue, Mar 11, 2025 at 07:02:56PM +0100, Christopher Obbard wrote:
>> Currently some Qualcomm interconnect drivers are enabled
>> as modules which isn't overly useful since the interconnects
>> are required to be loaded during early boot.
>>
>> Loading the interconnects late (e.g. in initrd or as module)
>> can cause boot issues, such as slowdown or even not booting
>> at all (since the interconnect would be required for storage
>> devices).
> 
> This is not a good justification. It should be perfectly fine to load
> block drivers (including their dependencies) from the initramfs.
> 
> Up to now we have been enabling only those interconnect (and pinctrl,
> btw) drivers, which are required to be able to open the consoe (thanks,
> systemd).

(non-earlycon) console is a better argument here, though

Konrad

