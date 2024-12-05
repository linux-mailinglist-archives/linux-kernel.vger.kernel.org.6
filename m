Return-Path: <linux-kernel+bounces-433953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 726D79E5F45
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 21:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D591884347
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 20:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BA322F38B;
	Thu,  5 Dec 2024 20:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RL2xSyyy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F2222D4F7
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 20:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733429305; cv=none; b=s04E1PPcgL4N4NmuKZvgvSU566lytPQlAEzW5tZrJursC7Z8eRdCAHR0i09mRVTDIW6GhjLS1vnPGrV8GNqxCS2CJu4vLAc1SVT7EOUM0gUY/pakXSjOaG/KLjAu4kGMwr+TwIIV1mbJZxB/FNOo08CH+11uES5rEGRmSbtYIug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733429305; c=relaxed/simple;
	bh=agp221zVqJjKdtxkPvHOngOZkwQqGrt40z+YQf1MlrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tEB2kgQs/CiIqmKsurq7KBTPRTnXBdA4jYq+qIPvzuovobNoRzkssWk2mXeSFzDR78uhtH2MA+fYXp7uZ+HHeuthr3/uUQ2p3qRz3gYmLRNWY39EZsYVhW1mlXabJ74ywQoAxdihYIMXLAXgozr8dcwmSmi5ou62fve0j8S/j5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RL2xSyyy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5HaNix020797
	for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2024 20:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MSWttBsTE57I0dgkpiUfRdyPs2BFjo5vj9pPO5KQXeQ=; b=RL2xSyyyP8YavVOX
	Hsb0OxFlGX4EsgWMPokslN4aQAKToGXTCRDkknbb9XWX5omNa1u5KOvXwG/b8QHv
	GTUZwKV/bMfv088EpKqRgKb6iuVXATLuU/TwScRcGTh7AqC/OgPygJ8FM7atHUfZ
	jJXrDCnv2Y8G6Nv0xentD6wU5ZtRdl7+lh0vwmNXldkPHIHROvKPgnCBK6PfRVcC
	PTdsvQM1nF6uQq4OG64Qn0wFIY3XbgiQ/r39DkxRDb2DsZbflmQxeYlIkTeL2xsB
	8b4VSJi5EK3P1JaUxUYyTIVZ27B3uU+94b0dZCqPXS+hK7xO7PbTZFAOxuzMfkkM
	16uScQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439v800x5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 20:08:22 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-46699075dd4so3276071cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 12:08:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733429302; x=1734034102;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MSWttBsTE57I0dgkpiUfRdyPs2BFjo5vj9pPO5KQXeQ=;
        b=Ts2kLzrRlvWUVL6yh4VwiFym8tIekPSJ1/GUkL/l0wzLJzRMN3Df8geKUPd8YfV3c/
         R7f9UeqgllP4SvcE3kGC1d1Rp+G00E+6bk8rU/jlspjs2Csy2BrW2/OsEMYOyWHMES9g
         q9jWJVErm56BPfidNeMxqryYmIedk0eiARgfWRNHLbsymVvN72sLxvDyTgbS+TLyu6eb
         yAkVdX81+IYNn23eF80qS501wE5zuQm1okjctCmUzPUwLxgPwf0yFHbJDvkYHnLSyYx2
         uBzPCclmdlvrdw1+OnTCVDzfZbTK6vDdH2RVXX+LsfQs90wEACkJWiQvfJIhcv/ylb9C
         u2aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr/mgoXQoJXu1nGG2ivFd9L+s1suTgqfyvrnAG6RitV5NN90HYnh+zYD+HcuyNQgKDSy64CEz8U6nrdB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YziBuufi81zQDE5dmZBWKGZqt4v2Sg1ViVpG6xRw4yoSSdxjt6P
	NPL1B+s23aAXWWEZvBNX58l/C+0WeZsgOSEmG582RzSSPB0c/uCZSWwYqp66PXazhQncrQYnbW1
	/AUGiyP1bqVBJc/r96TaPgSNq9k5VIyofFBd99AKa6p/RgFXK4FLGogUcWeUZgMA=
X-Gm-Gg: ASbGncveJ98MXKtuI+Qq7ptRoTzytcMq1R4BBd8xYPt2ndkEUNagqrOPZSndFwmNHZl
	qQ88LKcerNyeKQxmSLT94idcT9FDsnZLTOnctKDMs1o1gvj4q05bHKs5/fHqKWNYIg5hvUCMU6y
	fkU8wMUJw3lZPKrT7u4GWHYJ3m2Fzo+vm6J+5uCaVPL7V1d1tdsuCZtXJnRkQv8EFvnzzvdqyGK
	AddwnoiUhbWcEAraTqZqtgO+0IqYm9sBpJujIbf1CB0Gsn/DWm05gYr420l7aphKKKPSs8Gc8Q5
	DgZSadRCNSFLSGGiEhgGEpnlzmag7fY=
X-Received: by 2002:ac8:57c5:0:b0:466:85eb:6115 with SMTP id d75a77b69052e-46734cbcebfmr3521811cf.4.1733429301675;
        Thu, 05 Dec 2024 12:08:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENWeLRL82VIYrHXYdiNhw9kTjkxnGvdSXgGJfUUH0aLDplqI+DyD9FADUsRMY+ulGRr3TQoA==
X-Received: by 2002:ac8:57c5:0:b0:466:85eb:6115 with SMTP id d75a77b69052e-46734cbcebfmr3521561cf.4.1733429301249;
        Thu, 05 Dec 2024 12:08:21 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14c798f98sm1180454a12.57.2024.12.05.12.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 12:08:20 -0800 (PST)
Message-ID: <3270d558-df65-431d-a347-e40bf3f3923d@oss.qualcomm.com>
Date: Thu, 5 Dec 2024 21:08:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: arm,psci: Allow S2RAM power_state
 parameter description
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20241028-topic-cpu_suspend_s2ram-v1-0-9fdd9a04b75c@oss.qualcomm.com>
 <20241028-topic-cpu_suspend_s2ram-v1-1-9fdd9a04b75c@oss.qualcomm.com>
 <ZzSe4UAyil8KUm85@lpieralisi>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ZzSe4UAyil8KUm85@lpieralisi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: NvpGEkTgXz6xXLQa7SmWsoB5-JGeCQiX
X-Proofpoint-GUID: NvpGEkTgXz6xXLQa7SmWsoB5-JGeCQiX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050150

On 13.11.2024 1:43 PM, Lorenzo Pieralisi wrote:
> On Mon, Oct 28, 2024 at 03:22:57PM +0100, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> Certain firmware implementations (such as the ones found on Qualcomm
>> SoCs between roughly 2015 and 2023) expose an S3-like S2RAM state
>> through the CPU_SUSPEND call, as opposed to exposing PSCIv1.0's
>> optional PSCI_SYSTEM_SUSPEND.
>>
>> This really doesn't work well with the model where we associate all
>> calls to CPU_SUSPEND with cpuidle. Allow specifying a single special
>> CPU_SUSPEND suspend parameter value that is to be treated just like
>> SYSTEM_SUSPEND from the OS's point of view.
> 
> For the records, the info above is not relevant.
> 
> These are generic firmware bindings for PSCI specifications - how CPUidle
> is implemented in Linux must play no role here.

[...]

>> +  arm,psci-s2ram-param:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      power_state parameter denoting the S2RAM/S3-like system suspend state
>> +    maxItems: 1
> 
> NACK
> 
> This is nothing that has ever been specified in the PSCI specifications,
> see above.

Thankfully, neither do dt-bindings have to be limited by any software
specifications, nor is this a Linux specific problem.

This is simply non-discoverable firmware interface description, and
DT is the expected information provider here.

The TZ exposes a way for the platform to enter S3, through a call
that is usually not used to do this nowadays, but well allowed by
the specification, even after PSCI1.x.
This property lets the OS know what to pass to said firmware to
request S2RAM entry.

Section 6.5. of the PSCI design document recommends that within the
StateID magic value, a section is dedicated to system-wide (not cluster
or core) power states of "retention" or "powerdown". It also makes an
appearance in Section 4.2. in a more general fashion.

Konrad

