Return-Path: <linux-kernel+bounces-418241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D53A69D5F32
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C0828219C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A38E1DF73A;
	Fri, 22 Nov 2024 12:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bbOvkUt5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B771DE2B8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732279611; cv=none; b=bPS/9YxNWMBG/z8TpDjyQRVWh7ryMvY7YYTCcYqkkT9pSBMb8L8vyarMWHTU4hqlongFsedCcVAoP5K3jnV0pN83zYNghpzs+bqclFEzYZjcvPWDlu4ZXq0iSRl9XZ+UgvaDfRVkyqArd2B6W8bnIUy+JLiHOZhlQap+3IiriYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732279611; c=relaxed/simple;
	bh=PGxmlMvM42jCb09Sw5Nk0aJULQXXd1s94DyQ/r3iWC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qAyWEYYH4EkNoELKVdENuFnqJqYkzA0ZnydqRzT25kfUK1em8uGqfDZMvOo2HKqEnZsrjw+UOEqAjqEH8eyNl5VjOFEroAGGGgRJsEZ9mYh4ITOLjSI8FcwqvzEwaipvH+qtLiILveMvz7XAcva+BDSbKsq/IkGjHfB1rKwz1EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bbOvkUt5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM4r2fT019750
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ia4UrDs3vd2kvaJNQHWGjnWaoKrlYpuMSlA2+3djwo8=; b=bbOvkUt5luCh54dG
	6s6J41ui/OjrMkR01OslBwvPoELphPzxgFJcqdGuOmWWipw7bgcOAfnx/X7D7z49
	u4Z3z9JbU5+UE73bDuOatMJ+u9X4olz25Ub9sEFIC/pP1GxrVPkCfSUn+xNaXuuX
	mL5ap7bzR4b7AZlskokOLZ6+QLANTKZnIlTaacUs1RWlFnJXeDF04uWtCRozuypj
	cANqfRv2oT6k6HlrniH6R+vjoJObu+TU9jVW1EQ4kgtdPi0YUWQ+XGIHsBTT2ebR
	7RQaVm2l3Iipw5roctjVEX66YYAT9SOyW0+fMCkjKSgHDXlssmUYrVI8fGgSgJBJ
	IsB0LA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4326atb3ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:46:49 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d40a926b91so5256156d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 04:46:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732279608; x=1732884408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ia4UrDs3vd2kvaJNQHWGjnWaoKrlYpuMSlA2+3djwo8=;
        b=suAIB7Ju2Lov0TZ+mpAH/DNBVp+4sMVhJMv02EbGNAu8jkt9uJygxv60neD1gvnRAL
         eYGNbA3knAug++LqHMQL91YhyGayxLpjuklZoqWpKJFc4p9bTRMwklOHajVXI51T+Xuc
         xojdF/8XeP+RMnYSEJUeJ3BeyqavXW/ts4mmydQmbptWE75Tp2xA8r4zjUpqpDKQNteJ
         CpYwlqdwFZjJDONnKhf4zxpSB8pfoo0kFUJlBbEaacKn0ys5+t8luUM2CzeyqL2BCWjW
         SuWCKT0E22JgoJH2gSgzGxBKE5oIjNvZGAfMZOs9a0i8EqC4+JN7f5pceEpJWjkfTCMn
         Gi2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXyHuOes69wilgO7wuxKoE39QKzM9vKLjYGFBx6QbChJUnbLAe86nnUv1r0em+7c8aEsQ7IhrUcTSIFX2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY+Cx3I5iyvYTEz+hCR7DmGFlkolGXgoWozFAy2Cmm6v+B8Cws
	+VcfNl774JavWbhZbNls/aODJ3INtia8EIlThgBoiyS+jL5ZDiiTv7yivoJB0uJ9I4AC4uahUDS
	C8UVJKBTpKtDrnW2yJnmTS5JMa59xOO8U6AI3TdyxkxfNZYdWg9d+KSOSum0amFU=
X-Gm-Gg: ASbGncvvObwwu8zsMMnWpYWt/4s89iT0wRnp9C+hol86IcBZtztoalzQsUq9QPx/SPY
	lV1DBMvZqBaxOaxHDZUsdOZPpd4jZxRq9U4YejXL0QGrMb/vGVkNS6S8MvO3pIwoSeWzXUQjArW
	NP0cx3FPVN1GlTZF2TIYLv98RMGEnoWVzfengzH7SGzWZgi6IDUVO1F1MvyqzCFC2ALjaVqTCqV
	1q3E0bcbHwA2x9Y4qGjpHTBEUmIlC2hHeUgXK8MRF+fk59lJAotiMGA1IlHj1frrs3UiMp1pmz3
	sosdnb378EULGb/WQJISnCWb1XFHIsM=
X-Received: by 2002:a05:620a:1713:b0:7af:cb6b:b506 with SMTP id af79cd13be357-7b51451a046mr183921385a.10.1732279607960;
        Fri, 22 Nov 2024 04:46:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmIPXE7w7yZ0oy7BimtfW3pz/4db5Uchdbm73yDFjLne3ud5VpvKRTqnMiznhLBMrqXFvxsg==
X-Received: by 2002:a05:620a:1713:b0:7af:cb6b:b506 with SMTP id af79cd13be357-7b51451a046mr183919485a.10.1732279607627;
        Fri, 22 Nov 2024 04:46:47 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b28dd8fsm95930466b.39.2024.11.22.04.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 04:46:47 -0800 (PST)
Message-ID: <b4716d0d-fcae-4d64-832a-96ecb0a233a7@oss.qualcomm.com>
Date: Fri, 22 Nov 2024 13:46:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 3/4] interconnect: qcom: Add EPSS L3 support on SA8775P
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Sibi Sankar
 <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241121113006.28520-1-quic_rlaggysh@quicinc.com>
 <20241121113006.28520-4-quic_rlaggysh@quicinc.com>
 <bc926d6d-e3d1-4fbf-9b6a-bbd3816a766d@kernel.org>
 <b2a05dfb-a820-4450-a156-8d6b4bd59be3@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <b2a05dfb-a820-4450-a156-8d6b4bd59be3@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: R5l809QUQGIEd6PNMs9KJSJfQbyRMWih
X-Proofpoint-GUID: R5l809QUQGIEd6PNMs9KJSJfQbyRMWih
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220109

On 21.11.2024 7:03 PM, Raviteja Laggyshetty wrote:
> 
> 
> On 11/21/2024 5:28 PM, Krzysztof Kozlowski wrote:
>> On 21/11/2024 12:30, Raviteja Laggyshetty wrote:
>>> Add Epoch Subsystem (EPSS) L3 interconnect provider on
>>> SA8775P SoCs with multiple device support.
>>>
>>
>>
>> ...
>>
>>> -DEFINE_QNODE(osm_l3_master, OSM_L3_MASTER_NODE, 16, OSM_L3_SLAVE_NODE);
>>> -DEFINE_QNODE(osm_l3_slave, OSM_L3_SLAVE_NODE, 16);
>>> +DEFINE_QNODE(osm_l3_master, 16, osm_l3_slave);
>>> +DEFINE_QNODE(osm_l3_slave, 16);
>>>  
>>> -static const struct qcom_osm_l3_node * const osm_l3_nodes[] = {
>>> +static struct qcom_osm_l3_node * const osm_l3_nodes[] = {
>>>  	[MASTER_OSM_L3_APPS] = &osm_l3_master,
>>>  	[SLAVE_OSM_L3] = &osm_l3_slave,
>>>  };
>>>  
>>> -DEFINE_QNODE(epss_l3_master, OSM_L3_MASTER_NODE, 32, OSM_L3_SLAVE_NODE);
>>> -DEFINE_QNODE(epss_l3_slave, OSM_L3_SLAVE_NODE, 32);
>>> +DEFINE_QNODE(epss_l3_master, 32, epss_l3_slave);
>>> +DEFINE_QNODE(epss_l3_slave, 32);
>>>  
>>> -static const struct qcom_osm_l3_node * const epss_l3_nodes[] = {
>>> +static struct qcom_osm_l3_node * const epss_l3_nodes[] = {
>>
>>
>> I think dropping const makes the code worse, not better. Commit msg does
>> not explain all these changes and I could not figure out the intention
>> (except modifying but that's just obvious).
> 
> EPSS L3 on SA8775P has two instances and this requires creation of two device nodes in devicetree.
> As Interconnect framework requires a unique node id, each device node needs to have different compatible and data.
> To overcome the need of having two different compatibles and data, driver code has been modified to acquire unique node id from IDA 
> and the node name is made dynamic (nodename@address).
> Updating node id and node name is not possible with const.

I think it would be better to just fix the interconnect API to do it
internally

Konrad

