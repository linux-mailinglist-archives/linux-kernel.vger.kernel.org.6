Return-Path: <linux-kernel+bounces-173932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9E58C07AC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 01:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCBF8283288
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6F4133983;
	Wed,  8 May 2024 23:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UdVmYjMt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC7912DD8A;
	Wed,  8 May 2024 23:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715211186; cv=none; b=p8MUKfNOn6Jq+oZaxDBO9FuCqRSTetx/uMFlG8FPrH9nyKWfzWgjGPTJ6uSBSiUFSUlv8yP29ZyIXqBEXSvd9xTRP/Dvg2wsu8ifZhUFXBo17FX4dM+ksNlUNjwHnDchd/P0UnIOe96Ohop4JuP9L4K68monUm+yj05aVE+IyqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715211186; c=relaxed/simple;
	bh=GEAIMwFtyg+vAQGXluqnLDgeV0lbUGMAcGTBXuU4E98=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DvjqB6ntT0z9oZgAF/oa5FGs4hd+4gI8hA3fwXQPpEmwM6FhiUW1yuahVeUdF/Z842U+1xN3GZHj+ZeHs2B9H64KHMVuxvt44eo2+FE2BOxhTLnsOxmRRQdwStaAZoclEAcT6xNkxe8EGQEnUs0B14Hy3tekHRqh6Ld58ss5iWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UdVmYjMt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 448C4Y75027303;
	Wed, 8 May 2024 23:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1iu0bePOw83173L41461NVMwojOBNpiVdvT7Bl2/o+o=; b=Ud
	VmYjMtdvKcish+QgW9GTSAL4/oRSgvsTNSOi1FMnbLRQZYO9g+I7aqwkcsmvwBok
	wP8QqoTdXqDqYXDNqUEud88wkGgwZnbC3wPIRlGjEFaXOg5GO/CRCJrdqcYmhRKV
	XvcfYu2ddXjuo2/8ekSnk4M9pfYtROjbV0IjPEWAkocIrVof/refApVuQs1LdwiZ
	hQuTZRysiXuGdjjNJCsg9cdxDRQM7Tnq+15vAxNkgy5BBcxILF/B20AgkOvMLfHE
	BlVUl56Q5Xi/Kj114Juzz8zJNHCq/ZK0OhS5r6HkJ2p+Bbm9r+U7Jy4MecSjZn7I
	bZtCC2koss502AfVwDkQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y0930scy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 23:32:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 448NWd75032048
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 May 2024 23:32:39 GMT
Received: from [10.71.109.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 8 May 2024
 16:32:39 -0700
Message-ID: <a0868c79-f93e-36f1-e1c1-7a069222ebc7@quicinc.com>
Date: Wed, 8 May 2024 16:32:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] drm/msm/gen_header: allow skipping the validation
Content-Language: en-US
To: Doug Anderson <dianders@chromium.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn
 Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Helen Koike <helen.koike@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Stephen
 Rothwell <sfr@canb.auug.org.au>
References: <20240503-fd-fix-lxml-v2-0-f80a60ce21a1@linaro.org>
 <20240503-fd-fix-lxml-v2-1-f80a60ce21a1@linaro.org>
 <CAD=FV=XnpS-=CookKxzFM8og9WCSEMxfESmfTYH811438qg4ng@mail.gmail.com>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAD=FV=XnpS-=CookKxzFM8og9WCSEMxfESmfTYH811438qg4ng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MtBzCmbgcpFFUcFdwHfSfdimmt5lYR-Q
X-Proofpoint-ORIG-GUID: MtBzCmbgcpFFUcFdwHfSfdimmt5lYR-Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=981 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405080176



On 5/8/2024 3:41 PM, Doug Anderson wrote:
> Hi,
> 
> On Fri, May 3, 2024 at 11:15 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
>>
>> @@ -941,6 +948,7 @@ def main():
>>          parser = argparse.ArgumentParser()
>>          parser.add_argument('--rnn', type=str, required=True)
>>          parser.add_argument('--xml', type=str, required=True)
>> +       parser.add_argument('--validate', action=argparse.BooleanOptionalAction)
> 
> FWIW, the above (argparse.BooleanOptionalAction) appears to be a
> python 3.9 thing. My own build environment happens to have python3
> default to python 3.8 and thus I get a build error related to this. I
> have no idea what the kernel usually assumes for a baseline, but
> others might get build errors too. I don't even see python listed in:
> 
> https://docs.kernel.org/process/changes.html
> 
> ...in any case, if it's easy to change this to not require python3.9
> that would at least help for my build environment. :-P
> 

Yes, I had posted this y'day as I also ran into this

https://patchwork.freedesktop.org/patch/593057/


> -Doug

