Return-Path: <linux-kernel+bounces-237270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0420C91EE5E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 07:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8274F1F22A93
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 05:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E420F35280;
	Tue,  2 Jul 2024 05:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a3yd34JE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8048329CFE
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 05:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719898592; cv=none; b=RaLMuuDT14794X/NiAiQ7JJ8Qn1uPkGXtskxsIGzUgRVXIJXgmGHKeAe2ZAYtFB5bfmPd+9p3XOUDqfxeeGDGpxgLyr79p8GHYfORHsQw+WA6fEOZV7lABUmt/mC5kxEt2Lkc6aAkorXGtjpKRD+zTokg/tVufkJuH04OEcOpZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719898592; c=relaxed/simple;
	bh=sL5nzFeaxwlUGFSlwQnB4VkaZsUf0L92v3A8Fkt7R5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kUtNA+e29ruWN7MmtAR30q0dVllBzODKrhrsW73aeabual4RllhDjdOatz/nODSoF9EDzznJgZeWjT8vmtv8skY2GNjp9EF0ZbQEdLaPsRLEjzEN1zrV6kTSLduJrrZ/Lm91PrmOLXiRRsdsJ7R4JSc6K1zm4ELFRgo/DC0iYBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a3yd34JE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461KuP4d002759;
	Tue, 2 Jul 2024 05:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LSixqxhbZGIwo80cuabU965GEJrQdlG8pqBF8SD3JEw=; b=a3yd34JEosgTBsPS
	tT15XW997sCFbwp6pxhDa00e0CPMrrVitcAzafZRJeaYbnOl9X/6BpykT51XVgeQ
	JZdCUx36fNsjztPZnHsifXFfrq93Ig7Tw3O6xplaEOy1gkpn64j8pGxtY+VfEbP2
	SUdXA8t+VUmCBpiR4qE385UbYD3mk8g11N/964k5RHH1DduhtrIAH+fJCDpGUY9D
	ZRb6/6aqp+rCVQpf1HmI9d0f0RjXoLRloXmi/Q+wIeYkp0Ph4X1oq5mDYOO49Zmx
	cxYzV0FUtdpx17hM2+hpfNgJeIuV+Pz0p62G2EPba6RahQSk5BvkefNINikLSLO6
	OddMmg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4027yf6dsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 05:36:26 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4625aQnC015632
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Jul 2024 05:36:26 GMT
Received: from [10.253.33.75] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 1 Jul 2024
 22:36:25 -0700
Message-ID: <0c0a3ccf-82d0-4690-9a64-1bd26a69196e@quicinc.com>
Date: Tue, 2 Jul 2024 13:36:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Summarize my recent devres changes for code review and merging
To: Greg KH <gregkh@linuxfoundation.org>
CC: LKML <linux-kernel@vger.kernel.org>, <rafael@kernel.org>
References: <d2a150dc-1bac-4be2-a19a-d9dc6296e810@quicinc.com>
 <2024070248-those-rearview-ac34@gregkh>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <2024070248-those-rearview-ac34@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZthW61HIkMLAk3Bwye4l_u7gv098NS0u
X-Proofpoint-ORIG-GUID: ZthW61HIkMLAk3Bwye4l_u7gv098NS0u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_02,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407020040

On 7/2/2024 1:33 PM, Greg KH wrote:
> On Tue, Jul 02, 2024 at 06:48:04AM +0800, quic_zijuhu wrote:
>> I would like to summarize my recent patches for devres as following:
>>
>> [PATCH v2] devres: Fix devm_krealloc() allocating memory with wrong size
>> https://lore.kernel.org/lkml/1718537455-20208-1-git-send-email-quic_zijuhu@quicinc.com/
>>
>> [PATCH v1] devres: Fix memory leakage due to driver API devm_free_percpu()
>> https://lore.kernel.org/lkml/1718804281-1796-1-git-send-email-quic_zijuhu@quicinc.com/
>>
>> [PATCH v1] devres: Correct code style for functions that return a
>> pointer type
>> https://lore.kernel.org/lkml/1718631689-11929-1-git-send-email-quic_zijuhu@quicinc.com/
>>
>> [PATCH v3] devres: Initialize a uninitialized struct member
>> https://lore.kernel.org/lkml/1719871765-14774-1-git-send-email-quic_zijuhu@quicinc.com/
>>
>> [PATCH v2] devres: Simplify devm_percpu_match() implementation
>> https://lore.kernel.org/lkml/1719871779-14818-1-git-send-email-quic_zijuhu@quicinc.com/
> 
> Please submit a patch series for all of these, that would make managing
> them much easier, don't you think?
> 
good suggestion, will do it, thank you.
> thanks,
> 
> greg k-h


