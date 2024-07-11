Return-Path: <linux-kernel+bounces-249714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C6092EEE0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6349B20AC0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E79416EB55;
	Thu, 11 Jul 2024 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nB/3VHkJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3C916E86B;
	Thu, 11 Jul 2024 18:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720722496; cv=none; b=TlUPt5/xcd1MpmiKw+UxlHcSa0uqXP0MRQ77VDKxSZ4Z5gUCmNrYKVH4CusI0o+ByNcGmAi7SyrSAlYP9YTCL0PTkFKZSvgeyylDrmsuxAwjuMeUfcejbN5Y7dKpm/b6cOTF0xgzwyNtAXGNDFECzoopvKPYO6MAyPDODNg6M14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720722496; c=relaxed/simple;
	bh=V4uJ5ftefSHQJE1Bi4eNjWM4UHnl8Wwh+FKuf9D0HlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AAsC1bqz+vG0lKKtXCaRk1ySQ+OH54q+sJBCeGVCsvKJ3bsVBpcJxnhL+K/+UWRramqppxiWz6+y7YqXfTKCYrq43TSCVXBSrdI45MMpX4Hm7IvRTrl8iy0yiKmTf3eXA8hJIjLo4q0tr8RWoLnGSP2vfRWNeKY+QyLDb+hqUX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nB/3VHkJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BClkhO017597;
	Thu, 11 Jul 2024 18:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YH1b9XduCJJzje2fUhUOedM5+MZSrsyjESG9W325ezw=; b=nB/3VHkJEE/hTDKC
	gv2XVUioZZIbMkeld3W7YWdJnPvW0jgTU2oySz1f3XrXXHEEIbvV9IEpOz/e5zwQ
	jYPsvZdYYxswdHismXaEiOLrPPtZQJhhVClpiLAo2KOvT9GRtJjlOQ9CC9R0e6Ft
	dkBHAL9QVAWblILIeXF9nd6sImvageCdfNAIT5sMso0fEx7hrxAjms4cSC7ZpNje
	msn09cklCtr/f/qacTKzwmykNjz9DgfwDIRZil+Lu8BbY2mJ9DyYTQV9qZsaklQO
	BsTin/P3003vbDIDwm+qjuke68nIMFIQGFppEFXuaCv4nhz+qCPSnaor134moCP0
	ZLsL0A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40a8uht0br-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 18:28:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46BIS5ir027638
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 18:28:05 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Jul
 2024 11:28:04 -0700
Message-ID: <065a5811-f28b-43e4-873f-f3d032fe6615@quicinc.com>
Date: Thu, 11 Jul 2024 11:28:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] locking/ww_mutex/test: add MODULE_DESCRIPTION()
To: Boqun Feng <boqun.feng@gmail.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20240528-md-test-ww_mutex-v2-1-a2a19e920b12@quicinc.com>
 <ZlZFFuo7tmzK7Iy_@boqun-archlinux>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <ZlZFFuo7tmzK7Iy_@boqun-archlinux>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IJm-nEziM5eJSaiFlvqBehqTexsQzOHu
X-Proofpoint-ORIG-GUID: IJm-nEziM5eJSaiFlvqBehqTexsQzOHu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_13,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1011 mlxscore=0 malwarescore=0
 mlxlogscore=694 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110128

On 5/28/24 13:56, Boqun Feng wrote:
> On Tue, May 28, 2024 at 01:16:24PM -0700, Jeff Johnson wrote:
>> Fix the 'make W=1' warning:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/locking/test-ww_mutex.o
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> ---
>> Changes in v2:
>> - Moved the MODULE_DESCRIPTION() after MODULE_AUTHOR()
> 
> Thanks!
> 
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> 
> Regards,
> Boqun

I don't see this in linux-next yet so following up to see if anything 
else is needed to get this merged.

I'm hoping to have these warnings fixed tree-wide in 6.11.

/jeff

