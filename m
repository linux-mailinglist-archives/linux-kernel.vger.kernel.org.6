Return-Path: <linux-kernel+bounces-318992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B42096F646
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490B4281696
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B541CEEA3;
	Fri,  6 Sep 2024 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YWv/zv3M"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5257F1CF5FF;
	Fri,  6 Sep 2024 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631602; cv=none; b=oIVwF5rhu2nqLF0OGfBfYQeu/kZsBhV/r21jEkHSVMbB5B4gnTkVbuuaLo3I+5VWdi4eoyw7uPjK6ry+ZSlRupkLjhqeju3J5dO5111zA5m2mL+kb8h1AgJ1ETmsFl1kb6YX9Lc3qLqBtWOUNnR4v5x4PFQlXI0j6xE2KP5NifU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631602; c=relaxed/simple;
	bh=7BY0KsRzbfrQl2HXhQScIpRDlVROHVq+3QPlEz808xE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hNvr0u0xgl4LNh0KYbZpIyVeI3wAA7vtpDsEyLqfqAULTyweVn5H5qgL+Y8FQkIndaBDzNYyPoQTqQMF2eqAt52ZiYuIAUXFBydFBBW1gUVnQnPAB6VrKTb76cMQcy8CvFZxxtCakI9L2TUV4ajYLsOILsVA7qcK6sEckVlK34w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YWv/zv3M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4868MZjP001273;
	Fri, 6 Sep 2024 14:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7BY0KsRzbfrQl2HXhQScIpRDlVROHVq+3QPlEz808xE=; b=YWv/zv3MQx5VwaWr
	C5s/bR6GbUZednTceb0NAEHsGpV1GvfrBUhTnWd7osIBvI6MZhwYbnJ3qujgNFKd
	XdVrEOqfu/TWebzlTlyheK0ESGtmzi8QAcRjklZTZZB7v44BD0cncRUhXe5krV6m
	1HLozO9CxO43QI0w7PT7RUUmWlEdP9YMd7gb9NlbCvAuVcbd1tYwcm1cy8cAZEgb
	1NII8iBHvzPsAbbrQWv9lHhrb9w0XM5XQB4nGHASWj4WOUP56kFloNMuzugGj2wI
	yM+U/VnOAdUGaKrCWWg2Pbz2KhSB2zhYq95kLhV2G6Z/BqBQQJcocn7pQj7W4YxY
	N+Qtdw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fhwtah36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 14:06:27 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 486E6QiY027660
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Sep 2024 14:06:26 GMT
Received: from [10.110.102.234] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 6 Sep 2024
 07:06:23 -0700
Message-ID: <e01d2a02-8985-4fd8-90c2-87a31e800698@quicinc.com>
Date: Fri, 6 Sep 2024 07:06:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: firmware: arm,scmi: allow multiple
 virtual instances
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Peng Fan <peng.fan@nxp.com>,
        "sudeep.holla@arm.com"
	<sudeep.holla@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "kernel@quicinc.com" <kernel@quicinc.com>,
        "quic_psodagud@quicinc.com" <quic_psodagud@quicinc.com>
References: <20240905201217.3815113-1-quic_nkela@quicinc.com>
 <PAXPR04MB84593380F220DEC7974058D9889E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <9930c7b8-cddb-4c70-a283-8f0a09d6c30d@quicinc.com>
 <4p6rknakoojsjunwbakwzsyyymufhvim2kctdkexcrqfcphe2a@k7epaxvxmgn3>
Content-Language: en-US
From: Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <4p6rknakoojsjunwbakwzsyyymufhvim2kctdkexcrqfcphe2a@k7epaxvxmgn3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: obrfNXiNwfgTpT8TEcvamr_P3lhBgYG4
X-Proofpoint-ORIG-GUID: obrfNXiNwfgTpT8TEcvamr_P3lhBgYG4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_03,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=601
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409060103


On 9/6/2024 12:32 AM, Krzysztof Kozlowski wrote:
> On Thu, Sep 05, 2024 at 05:33:04PM -0700, Nikunj Kela wrote:
>> On 9/5/2024 5:25 PM, Peng Fan wrote:
>>>> Subject: [PATCH v3] dt-bindings: firmware: arm,scmi: allow multiple
>>>> virtual instances
>>> Just wonder, what do you mean virtual?
>> Just a term to indicate that these are different SCMI instances within
>> the same OS. In one of the series from Cristian, he used the term
>> 'virtual SCMI instances' so I used the same term here.
> That's indeed confusing. Virtual means not a real thing...

IIUC, SCMI instance mean single instance within an OS however we are
using multiple instances within single OS. That being said, happy to
drop virtual if people find it confusing. I tried to use the same term
which SCMI reviewer's patch series used.


>
> Best regards,
> Krzysztof
>

