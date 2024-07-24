Return-Path: <linux-kernel+bounces-261088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6158293B2B5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923101C210AC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4031F15957E;
	Wed, 24 Jul 2024 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ax5eqo9D"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81D34C6D;
	Wed, 24 Jul 2024 14:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831536; cv=none; b=FTQIYumiamiPVLrfwlm39m9LnLhjcNO3uUjcweleMAxx5dxpeSXtNy7+/jnTdeb5XNBVz1haG5X5t3HhIhEM2i+KfH3f/rd6swHphOyRMKapPNvMw7xolNWSKBGWTtQG1soUBhpB93aOjKzc6PCkxiPoEXnphHJWazgB21pWV5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831536; c=relaxed/simple;
	bh=cVNdD1dtVQcawxs7xGcmE7j5UxisdjRC0FPgxYvcz0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tmZFf36JF9nfF2Dx4zytP9ezAWRXR6Hm/Tm+hcA8+tfLdeAG7TpmEV+CYj3tEbbQJbANRXxQBdkP44fGeTAVjbKCebGRa4xSgpQ015WlAskESRznhlgfpSBFYn1vDd5hLsBdJDb+KFZyvgrXCZfMMHLtp9tHm+A3+33AeWoPKfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ax5eqo9D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OA0n6U024250;
	Wed, 24 Jul 2024 14:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hCPhb2UixjZg1/8LztOdhqgtq8hNvIQBdrT9HHUc3+Q=; b=ax5eqo9DXQ4Bwe3/
	xCKmsZxkSKtocOWUE5rzLAnnA3SlZ8VGCTy1hImcbIoYsAnbmECTFmn17sIOptpS
	hmIYpUtfaw2ekzVBY7WHDc7y1OaHRuIojJJiNh8doNH0FVjpx0NEl4QBnEl8ugdr
	OXO3hoHRLgj+kn5n2tL11wr7sjVhrIuohr69Jl2hZ5t5u9KG2+BD329mwHWUHUXN
	ZPLbWnPOr8o00rVv3Po1KzRxC72357+4eRxiqVxy0FIx+opxqXukTA4b6UiQ6pGm
	PxyZGfqMhDboxJxCQqZPLHYZn4gXq0+yvji13MsGs89mckxcaBYjuLNxgintYlf/
	vaAzEQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g487j90y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 14:32:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46OEW7iw009354
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 14:32:07 GMT
Received: from [10.111.176.36] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Jul
 2024 07:32:06 -0700
Message-ID: <dacba423-f164-4ff4-b497-0730ddcf45df@quicinc.com>
Date: Wed, 24 Jul 2024 07:32:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vsprintf: add missing MODULE_DESCRIPTION() macro
Content-Language: en-US
To: Petr Mladek <pmladek@suse.com>
CC: Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt
	<rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky
	<senozhatsky@chromium.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20240531-md-vsprintf-v1-1-d8bc7e21539a@quicinc.com>
 <ZmmG_dQaTpq4TkGE@pathway.suse.cz>
 <9614c130-d90a-4023-87fd-0b3b12516021@quicinc.com>
 <ZqEJYJScuEJpo778@pathway.suse.cz>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <ZqEJYJScuEJpo778@pathway.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wEw3MkRSrGxzQlD471V6rSrJ119t86ze
X-Proofpoint-GUID: wEw3MkRSrGxzQlD471V6rSrJ119t86ze
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_13,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407240107

On 7/24/2024 7:02 AM, Petr Mladek wrote:
> On Tue 2024-07-23 11:53:34, Jeff Johnson wrote:
>> On 6/12/2024 4:31 AM, Petr Mladek wrote:
>>> On Fri 2024-05-31 19:42:25, Jeff Johnson wrote:
>>>> make allmodconfig && make W=1 C=1 reports:
>>>> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_printf.o
>>>> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_scanf.o
>>>>
>>>> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>>>>
>>>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>>
>>> JFYI, the patch has been comitted into printk/linux.git,
>>> branch for-6.11.
>>>
>>> Best Regards,
>>> Petr
>>
>> Hi Petr,
>> I see this landed in linux-next, but is not currently in Linus' tree for 6.11.
>> Will you be able to have this pulled during the merge window?
>> I'm trying to eradicate all of these warnings before 6.11 rc-final.
> 
> The pull request is still being discussed, see
> https://lore.kernel.org/r/CAHk-=whU_woFnFN-3Jv2hNCmwLg_fkrT42AWwxm-=Ha5BmNX4w@mail.gmail.com
> 
> If the printk rework part is not acceptable then I'll send these
> trivial changes separately.
> 
> Best Regards,
> Petr
> 
> PS: I have sent the pull request late because I have had vacation
>     previous two weeks.

Thanks for the update.

Note that, at the advice of Greg KH, after the merge window closes I'll send a
series that contains all of the MODULE_DESCRIPTION patches that didn't make it
in, so it can come in via that series as well.

/jeff

