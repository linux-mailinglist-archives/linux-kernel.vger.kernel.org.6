Return-Path: <linux-kernel+bounces-395721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BBD9BC210
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 01:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529FA1C2166B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 00:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0015E573;
	Tue,  5 Nov 2024 00:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l8i09vbe"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A808195
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 00:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730766984; cv=none; b=n/deT8VKej39pB0XRtbVfNGZhW0+PE8kx7pUosp3AY8c6WvAnxeLHBeDVArbHW3dDP7Xk7+o8PmAGIBx4YGB/rbW7FZkBmMjHf8Yg9VcFOma86rFQ8YvkDwLvgIUNBvjW3QqZm2yEUgOnFu2/IKkl0FbyggtTp3UPI1SuS9qDBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730766984; c=relaxed/simple;
	bh=K14RzaJg8AC9E5a2pulON3//EKXLq48VDXuvyvVNTTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cRo85meWag5MWPPBeBWiR3T1fB9QpgZepw2PGvuq9mrhNGb5gj+PZFyxDbgJJAMbi2Fn//1vQbRkPqwS9xyewO668UyMfbz9u6W3BUv3MvQ2I785soscLAfVZokwe8vvpTmCWukprc7B2nu8wfHBR+su7E1yofry+e4ofaun7Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l8i09vbe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4LIoKv009217;
	Tue, 5 Nov 2024 00:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b3Auwp04dOEVHSooU2i3aQsCGVpTXCoUUCvBQEYUf18=; b=l8i09vbegixJ6k0V
	UkuQq0Gx7YDy5uRusMpSdMfC9wEqOpRhyqW6Fc/fUHc/ioR7dLYxQxk3Ts6rFyhw
	n8W9kKS2hHH0CC2VzeFzfbtMSUK0ydp8aiiLUl4vaJre79UY5Esoe7K+nEU5Yiwf
	j7guVonRSON/ywoaSk6D87EblXCwg30ZSH/fl0Rjo+BooxkExg9/fn1J4qLP+zbQ
	4HcTL44ozF/0QggD0rq034v9NJ+CEOqsySweOk/l/yNBJ8Ee9Zarq/wN8yc3USla
	0mF+l+cZM8fjwMu9Yu/1ZgBHlBjs1F4AvxujULcBh5TDnrLkm4XDkirk9ATUNaiV
	Lt99oQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd4unv50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 00:36:06 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A50a57g017943
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Nov 2024 00:36:05 GMT
Received: from [10.232.65.248] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 4 Nov 2024
 16:36:02 -0800
Message-ID: <58f01375-37db-4720-98bf-eb2d8ed5cc1f@quicinc.com>
Date: Tue, 5 Nov 2024 08:35:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] trace/events/page_ref: add page info to page_ref trace
 event
To: Matthew Wilcox <willy@infradead.org>
CC: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, <akpm@linux-foundation.org>,
        <minchan@kernel.org>, <vbabka@suse.cz>, <iamjoonsoo.kim@lge.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20241031024222.505844-1-quic_yingangl@quicinc.com>
 <8418b91e-04bb-4b74-96dd-a9489fbf9ba6@kernel.org>
 <55f6332d-3b4c-4478-93f9-514a906e348d@quicinc.com>
 <ZyjOkSvYYKdFrRgt@casper.infradead.org>
Content-Language: en-US
From: Kassey Li quic <quic_yingangl@quicinc.com>
In-Reply-To: <ZyjOkSvYYKdFrRgt@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jjRYV1ssAcyIMliQ9v2cTcu4fkgverH4
X-Proofpoint-ORIG-GUID: jjRYV1ssAcyIMliQ9v2cTcu4fkgverH4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=496 impostorscore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411050002



On 2024/11/4 21:39, Matthew Wilcox wrote:
> On Mon, Nov 04, 2024 at 03:35:37PM +0800, Kassey Li quic wrote:
>>>> In many kernel code we are talking with page other than pfn,
>>>> here we added page algin with pfn.
>>> How exactly would this help you, what are you doing with the trace?
>>
>> we met some problem where filesystem held the page.
>>
>> we can show the page pointer other than pfn in filesystem code.
> 
> Don't do that.  Change the filesystem code to show the pfn, and send
> *that* patch instead.

thanks for the suggest from Matthew and Vlastimil.  On 2024/11/4 21:39, 
Matthew Wilcox wrote:


