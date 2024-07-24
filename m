Return-Path: <linux-kernel+bounces-260972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EEE93B11A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9A59B21E41
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 12:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A0E158A35;
	Wed, 24 Jul 2024 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ByeUTa3r"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D550F158A27
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721825794; cv=none; b=ebKzSXIF9F/zOP/G4BRf+CxYVRoKXCCQ3FJbfL7eXmfmkj/J8nTPv8KzbtkiHE26xx0emMKx8dt9nKRtDDwS7FJcnHJkYY7i4A3fI86dF7ez6DVJ33EY4cphL5gXWczWO2lljn9QJuLpPX8ziFcdjnfwI7rm0EsaINijLuIMZ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721825794; c=relaxed/simple;
	bh=9CMrk9WO6hcSMNQudzMliwsWe/Yv8TIs8Y3AWlxjyRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=byYeaTi3HW0O9ZzkOAGvgRCohq/Bxqlil+zGhNq0NyT7mI5IyiffjY73L/S+cdgGUkZBpU8UUpi5HNRf/WVorD66K7vOwgjAzW4MobGrQKwvF2nKf/Bvl0oPYYrU9KIaePWzfWhbc9d5P85Lq6Yk7nl+oLfPhYir4Mq/6WdIvnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ByeUTa3r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46O8tMi3019730;
	Wed, 24 Jul 2024 12:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9oAWqPozsMFEBYCa1l4YKSTSe2k1klg0+jmdNaqfwG0=; b=ByeUTa3rtn4pBBmF
	v9bE5FQfiiHpuAT8RlltOv+3lrlYPZw0NV7sXybESFpb2YDmjfnidpvCiyPR2Ov4
	RO6+8tm6qHZH96j3PO5CogEvUnIWzCfEOgTrb7f0MX2SAAHQQJetV14r0ysOLBKG
	SR6hwKvl/6NuKsJ+S3+2sXIQDp/jCxiDJO75t3JoNtugjcwmKdhFl+vrm/RXIUI0
	FEw6P8OHiNHJaslXtxTLClFUkY2TEFNmwswW9R9AYEx0Npr9/sFgHGbQbBrhnomM
	HoDaglrGRy1RxmQmzdftn/gp3hXLv3AZP18bmMvZisIw16IwmKwmexLiQ6Br203V
	xKrEoA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g5m7271t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 12:56:23 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46OCuMSL016260
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 12:56:22 GMT
Received: from [10.253.11.54] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Jul
 2024 05:56:20 -0700
Message-ID: <70ec36ff-1be9-4fc3-9792-4950a483b272@quicinc.com>
Date: Wed, 24 Jul 2024 20:56:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: bus: Return -EIO instead of 0 when
 show/store invalid bus attribute
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zijun Hu
	<zijun_hu@icloud.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240723-bus_fix-v1-1-175f926805dc@quicinc.com>
 <2024072316-yeah-snide-ca28@gregkh>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <2024072316-yeah-snide-ca28@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9VgdI22_qpwlQpvNez-ZV1dtc28NWKOB
X-Proofpoint-ORIG-GUID: 9VgdI22_qpwlQpvNez-ZV1dtc28NWKOB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_10,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407240095

On 7/24/2024 1:31 AM, Greg Kroah-Hartman wrote:
> On Tue, Jul 23, 2024 at 10:55:43PM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> Return -EIO instead of 0 when show/store invalid bus attribute as
>> class/device/driver/kobject attribute.
> 
> Why?  What is this now going to break?  You are changing a user-visable
> api that has been this way for 20+ years, how was this tested?
> 
this change should break nothing.

tested by wc a writing only bus attribute, for example

root@kvm-Q35:/sys/bus/gpio# ls -l
--w------- 1 root root 4096  7月 24 20:20 drivers_probe
root@kvm-Q35:/sys/bus/gpio# chmod u+r drivers_probe
root@kvm-Q35:/sys/bus/gpio# wc -c drivers_probe
0 drivers_probe                  // for current design

root@zijun-kvm-Q35:/sys/bus/gpio# wc -c drivers_probe
wc: drivers_probe: Input/output error  // for this change

>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>  drivers/base/bus.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
>> index ffea0728b8b2..e84522a90102 100644
>> --- a/drivers/base/bus.c
>> +++ b/drivers/base/bus.c
>> @@ -152,7 +152,7 @@ static ssize_t bus_attr_show(struct kobject *kobj, struct attribute *attr,
>>  {
>>  	struct bus_attribute *bus_attr = to_bus_attr(attr);
>>  	struct subsys_private *subsys_priv = to_subsys_private(kobj);
>> -	ssize_t ret = 0;
>> +	ssize_t ret = -EIO;
>>  
>>  	if (bus_attr->show)
>>  		ret = bus_attr->show(subsys_priv->bus, buf);
>> @@ -164,7 +164,7 @@ static ssize_t bus_attr_store(struct kobject *kobj, struct attribute *attr,
>>  {
>>  	struct bus_attribute *bus_attr = to_bus_attr(attr);
>>  	struct subsys_private *subsys_priv = to_subsys_private(kobj);
>> -	ssize_t ret = 0;
>> +	ssize_t ret = -EIO;
> 
> Why -EIO?  What is wrong with returning an empty string?
>

for this error case, all class/device/driver/kobject attributes return
-EIO, i just follow them for bus attribute.

for empty string, the value returned by attribute store() is returned.

> I think I know why you picked this but you better document the heck out
> of it AND test it very very well first.
> 
sure.
> thanks,
> 
> greg k-h


