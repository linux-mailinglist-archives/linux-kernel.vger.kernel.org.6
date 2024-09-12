Return-Path: <linux-kernel+bounces-327170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F5297716C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38457B22018
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A4D1BF7FC;
	Thu, 12 Sep 2024 19:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TLVq78Dz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803571878;
	Thu, 12 Sep 2024 19:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168995; cv=none; b=dGjn7EhvuyKGTdJL10LIIKB/7qHXBdH81TeidQlar8kltNWew21Wn8eR6AIdCr6eV9XjnDsYHZO8AN9wkcDsJNdvWUsSdBEOvnVh5+ax1znga83RaEatF9E/zPuKQgHv/i4iN3rT1Ts+1USlGl8p1A2sygmx8mnsMk5ATye0SJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168995; c=relaxed/simple;
	bh=tgujS4rmwqdy3do3y2Pffg/1QLwIkivAaetVNF/eREQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HDPZcL4irfxUeqxrYIwaHvEWSDqgr26lgbNwqc5NGFsVXwcTxGatwCbBbsrrFsicn8ogDA9H6sGfmPlv7oUhOduICM5638onZo7RW9vnWteXpjxinyFlBbT3/y2mDOXinuq0l1epJdq97+bs4h85/5UliMu8C154CfM2vS34MKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TLVq78Dz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CHt047003026;
	Thu, 12 Sep 2024 19:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tgujS4rmwqdy3do3y2Pffg/1QLwIkivAaetVNF/eREQ=; b=TLVq78DzHnDsWNxj
	bb5pZy3VR2lJbXba8J8A70vLGEo+JS2/roNYrGXdLi8EztGLBMjmyG5AOSCt/o3b
	q5qn7bPm/Hd0o+j1gzoRaC7HLdm5TzBKw4JiWfLRmm7mHGA+gHhpTlJ6HAE+/nx7
	Z3b0+SQkX0zoazq8G/9+ZbQ1ta3sXoImGgg0x1AkAVAyTz+z43LdPSqLQyHkSQH6
	qhI2eoWvaR96atNPN1v2dAYxNv2hrfBziODbWin7BUyf9psukvXCjVg8phX/3sb6
	cTGUIBlnmZhZvtx4yOmNAdtf4uO6bHxQqYYK6LlRV3c9oEDBmFOkpA8a0a0pbjTa
	jU4/qA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy5nxjju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 19:22:55 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48CJMri2022913
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 19:22:53 GMT
Received: from [10.110.64.127] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 12 Sep
 2024 12:22:53 -0700
Message-ID: <34d1783c-8b0d-4337-8169-1c41cd02a6e3@quicinc.com>
Date: Thu, 12 Sep 2024 12:22:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/6] firmware: arm_scmi: Use max_msg and max_msg_size
 from devicetree
To: Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi
	<cristian.marussi@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <arm-scmi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <james.quinlan@broadcom.com>, <f.fainelli@gmail.com>,
        <vincent.guittot@linaro.org>, <etienne.carriere@st.com>,
        <peng.fan@oss.nxp.com>, <michal.simek@amd.com>,
        <quic_sibis@quicinc.com>, <dan.carpenter@linaro.org>,
        <souvik.chakravarty@arm.com>, <robh@kernel.org>, <krzk+dt@kernel.org>
References: <20240730144707.1647025-1-cristian.marussi@arm.com>
 <20240730144707.1647025-6-cristian.marussi@arm.com> <ZsSsq_Do-KEyy7vU@bogus>
Content-Language: en-US
From: Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <ZsSsq_Do-KEyy7vU@bogus>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Vm8uMzkUOhfSHJKQ3-GhWSvloF7CN9SW
X-Proofpoint-ORIG-GUID: Vm8uMzkUOhfSHJKQ3-GhWSvloF7CN9SW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1011 impostorscore=0 phishscore=0
 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409120142


On 8/20/2024 7:48 AM, Sudeep Holla wrote:
> On Tue, Jul 30, 2024 at 03:47:06PM +0100, Cristian Marussi wrote:
>> Override max_msg and max_msg_size transport properties when corresponding
>> devicetree properties are available.
>>
> I am holding off on these changes to think how these max_msg and max_msg_size
> can be used without breaking any platforms allowing space for the header
> and the message itself which is around 28 bytes. The binding itself looks
> good. We may have to adjust the value passed to the core driver taking
> the above into consideration.
>
> --
> Regards,
> Sudeep

Hi Sudeep,

Qualcomm is interested in these parameters being configurable. Just
wanted to make sure you are aware.

Thanks,

-Nikunj


