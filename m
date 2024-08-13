Return-Path: <linux-kernel+bounces-284541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3630095021F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9035C1C225E3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C84717E47A;
	Tue, 13 Aug 2024 10:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Zybzl2QQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4126433B9
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543879; cv=none; b=YHz8Hh6fK4BDnw1jgMjJxpXNpejYKPBCzqlavW9dsKczce9mzLQbPDcKZ686sSejTvXdF0tGxYC7Mtaak5gxVebrttP0dmkXJil+uzTYks+nR9vtzyBSfBnO5ajuG92QBlnWqOfxXokCNFLZGlpu3ZvYeU1HtSMYpu+0T0HkycQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543879; c=relaxed/simple;
	bh=YgsqE4jqSP3LSPgXcoi07/moE3pW7xzzpVSsdJ70T7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iWvXwKsaiHrMmZYQ2hJwCgwUlRVC7DyduwlAMjJaALYFQA9D7CBbxTUIaqxWTk9MO5qqIkU17vC4NGomcOwPn8X+D3zGtVDlfurMuQBdJz9ipRMm0uCwKj3JYmS1/Uny73Krr4Lfq/V2cPm1UgxeYPDeqtHzmEzMKZlrJvXxJ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Zybzl2QQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D8MQU5004638;
	Tue, 13 Aug 2024 10:11:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fcBUowm3gQLBM7qVOmKcrlqavRJVA2yVQJ7kyFSGZ9s=; b=Zybzl2QQ3Q/ECHEo
	OCMPty2/BnoQLe1CBQxO0c5d8YRo3Mnq2tFwveHrUn4zt4uMv6DnxUWRSjdVNc8y
	cCQmnCH2OhSoeaBRE8EgyA6xFMkYV0cITlUI3cvSRXl6u5SNIpfXsUZHMJcYfTMa
	8NXp7+RIdZvjZI3AcN8uUjhr0QJOhoJSt6l1hk0Lwzo99LolAngG9VzPE3vsstOP
	qTfdiKGHNJgdzaqedb/uSK0AcMOSi4yEI8TtP9Wmk0jyFBrZnL25uOXu62OijsCG
	Q7CH0c16U3cN1Yb4aCfs9OOqpdW2SD70TtjKLGCPGrVg/fazSsaV+GmbBr+3uPFd
	O2104A==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4103ws0aea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 10:11:09 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47DAB8sc021433
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 10:11:08 GMT
Received: from [10.253.34.30] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 13 Aug
 2024 03:11:07 -0700
Message-ID: <5b971dcd-da54-45c4-854e-280417a6be2d@quicinc.com>
Date: Tue, 13 Aug 2024 18:11:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] driver core: Simplify driver API
 device_find_child_by_name() implementation
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zijun Hu
	<zijun_hu@icloud.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240811-simply_api_dfcbn-v2-1-d0398acdc366@quicinc.com>
 <2024081330-posting-tapestry-9372@gregkh>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <2024081330-posting-tapestry-9372@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8FYXJoI3M5NIxeTyIli6E0LwnEXX4Kmg
X-Proofpoint-ORIG-GUID: 8FYXJoI3M5NIxeTyIli6E0LwnEXX4Kmg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_02,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130073

On 8/13/2024 5:41 PM, Greg Kroah-Hartman wrote:
> On Sun, Aug 11, 2024 at 01:49:58PM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> Simplify device_find_child_by_name() implementation by using existing
>> driver APIs device_find_child() and device_match_name().
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>> Changes in v2:
>> - Correct commit message and remove all unnecessary comments and codes
>> - Link to v1: https://lore.kernel.org/lkml/20240720-simplify_drv_api-v1-1-07c5e028cccf@quicinc.com
>> ---
>>  drivers/base/core.c | 13 +------------
>>  1 file changed, 1 insertion(+), 12 deletions(-)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index f152e0f8fb03..8ed593d7e0be 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -4093,18 +4093,7 @@ EXPORT_SYMBOL_GPL(device_find_child);
>>  struct device *device_find_child_by_name(struct device *parent,
>>  					 const char *name)
>>  {
>> -	struct klist_iter i;
>> -	struct device *child;
>> -
>> -	if (!parent)
>> -		return NULL;
>> -
>> -	klist_iter_init(&parent->p->klist_children, &i);
>> -	while ((child = next_device(&i)))
>> -		if (sysfs_streq(dev_name(child), name) && get_device(child))
>> -			break;
>> -	klist_iter_exit(&i);
>> -	return child;
>> +	return device_find_child(parent, name, device_match_name);
>>  }
>>  EXPORT_SYMBOL_GPL(device_find_child_by_name);
>>  
>>
>> ---
>> base-commit: bfa54a793ba77ef696755b66f3ac4ed00c7d1248
>> change-id: 20240811-simply_api_dfcbn-eebeb153bec7
>> prerequisite-change-id: 20240811-const_dfc_done-c5c206675c6b:v1
>> prerequisite-patch-id: 475b810c1ccacab955c654c223d5214f70c4f6c8
>> prerequisite-patch-id: 81a5ccaa144a7732cae29fc5ea1a13426becee5b
>> prerequisite-patch-id: 9b77254186b7366809f949f5643f9437fa2528a0
>> prerequisite-patch-id: 95308bb3eedcf8c4a5e30aa3071116148495329e
>> prerequisite-patch-id: ee643a52674e2aead02f7be3d011d88507970436
>> prerequisite-patch-id: 0625de1f03ef4350b1828f0faff7a9d9bdebae94
>> prerequisite-patch-id: 6e671f2891f6ed906a35e0a90b5d8cd71c382b9c
>> prerequisite-patch-id: 8859b6fa330c363ef37567fc0a5421c0b9ecd8dc
>> prerequisite-patch-id: fe9aa57807bbb8b98dba32abd614d8f2e27565cd
>> prerequisite-patch-id: d03febd9c0afd5d21a2f664d748da7d7811a8e84
>> prerequisite-patch-id: c7425de06cf7032d54ff72f610d7632941be976e
>> prerequisite-patch-id: 54c942a1a492ba04480337f99dc901a8d4def782
>> prerequisite-patch-id: 7e8f4a3e378d5329b886a9a3719add3cbb10e3e3
>> prerequisite-patch-id: 34ff831994ac7bc265f567bacefff8ae687ccd40
>> prerequisite-patch-id: 66d46c755c25065e9d440a4137e1e8ccc245e0be
>> prerequisite-patch-id: 15bc81129ee07324b5a8faa39a5e6aea59952573
>> prerequisite-patch-id: fe9ca6ae244761b48469f375fe1fc8c9c7b24204
>> prerequisite-patch-id: a6fd24b37269a06a91fd926fa5111a19cdec7551
>> prerequisite-patch-id: 2f584b03145bc7d01e3ea632c6abb89d3b543d93
>> prerequisite-patch-id: 10e0d06e0340ce5028cd109fffa7f0720c70d242
>> prerequisite-patch-id: 0f9ea4a7c63d15c5c1324c5666901f0704c129ca
>> prerequisite-patch-id: 4f56ebd28ae00a50130f58409d934ca79ccec6a9
>> prerequisite-patch-id: 70e7432951b43a67204bb7eb6c437ba135def0f1
>> prerequisite-patch-id: 1718891e69e1d2031336b4a6e7f251c50619f336
>> prerequisite-patch-id: 5f838fb00256dbadfd36735ef3a1b1e43ec20549
>> prerequisite-patch-id: f4b36e4136d462c8ba9f94f777a6fa1a054b8809
>> prerequisite-patch-id: 56c12ce5dc6bfb090fa7801fa3f31c4e52b50775
>> prerequisite-patch-id: 2b23c8c2ae90030a59d267297b478584447b78ac
>> prerequisite-patch-id: 294c325d517e318063c61af218607d9721f1cc5f
>> prerequisite-patch-id: 38fb282ac119a88af58a88b38c9cdc74372df404
>> prerequisite-patch-id: d3ab2693194b77403d6ce20edf25ee3896d0260b
>> prerequisite-patch-id: 19b69184800129923777ee2acd2629565c69291b
>> prerequisite-patch-id: f58374cebf0ada070fc0825736424dd177e49676
> 
> As those ids are not going to be in my tree (or anyone else's), how are
> we supposed to apply this?
> 
> confused,
> 

Hi Greg,

ALL these patches are based on your driver-core tree with branch
driver-core-next.

these ids are patches which are not merged yet and this change depends
on, they are automatically generated by tool b4.

the following command will apply ALL:
b4 shazam -C --check
20240811-simply_api_dfcbn-v2-1-d0398acdc366@quicinc.com
> greg k-h


