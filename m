Return-Path: <linux-kernel+bounces-260334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53B993A77A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3245DB220F7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5246B13D8A6;
	Tue, 23 Jul 2024 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f5WE/BNG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5678513C8EE;
	Tue, 23 Jul 2024 18:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721760824; cv=none; b=gl7ABJpqv+MNnM6OyJldnTi1wVCDZ7kOBavG0uaIBkhXKl0gRGD7Rkz9qTAM7WXTeG25GQ1KLYa5i7FvLBJdLAt09vkpJJnNXdouW4mql04IfE2bSidEmm/RsPRPvCEpiSLgjciPCX+UdemQyKeO2k1ag4/ZCtnDDZqzb7yUoFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721760824; c=relaxed/simple;
	bh=FaqOfyaoIJ9NQTOabIl6FMrNW1dadYoWvVqTEVGuGN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gDo6JNlgPxefaUbqXglDaRaidZVBCRhJa/Ch6K7t/Mhf71YYDoSdA3bAZRLv9QsznhVmPL03WfvtTD0O9cFIVrDxtQt2IRs+3NjcSwTd+orCkz90JG4PoKgIgQNKtRD8C0L1r2xu0ZxITnDUs6KYvZoj87gri/CTAHI6gzi/or0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f5WE/BNG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NAXuZ0027111;
	Tue, 23 Jul 2024 18:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WrXjeVHZRtiSTWSOfzEOlMUp8Bn3yPQzZD06dptNiGY=; b=f5WE/BNGaMonIX2m
	PB8EkpGryS8Bg4T4nb9S0darsgRRp+3u3vkyeEFm5j8GmEWmcy2uvhVK5MchT+wv
	299iRuhNtr4CufTA77WTublkMF8k/0GVZ89T39OOT4W/IYgo36gmiPHrjODoGxSL
	lYuQtteHI9IvvSxdMlaeSoj4tnKRpyvxQ0UFVPrACl7P/H1SPzXOpTPDxz8ahHbb
	FqOhlW1HKOzYyaSM+UTY8sS7BtHE52BkUGaxFyllqOICmQHQ1/k8qpTMO78kZRuc
	ZSvN7t5vRiTPtUyVerZSSkmT66gspAB88P61OAqpZiog/68JHVSo9e0Si30EDKfG
	7PW1oQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40gurtpm47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 18:53:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46NIrZhX018867
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 18:53:35 GMT
Received: from [10.111.176.36] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Jul
 2024 11:53:34 -0700
Message-ID: <9614c130-d90a-4023-87fd-0b3b12516021@quicinc.com>
Date: Tue, 23 Jul 2024 11:53:34 -0700
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
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <ZmmG_dQaTpq4TkGE@pathway.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EgzGHABQZTM97YqJurbDpemrQj4mflWC
X-Proofpoint-ORIG-GUID: EgzGHABQZTM97YqJurbDpemrQj4mflWC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_09,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 mlxlogscore=957
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230131

On 6/12/2024 4:31 AM, Petr Mladek wrote:
> On Fri 2024-05-31 19:42:25, Jeff Johnson wrote:
>> make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_printf.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_scanf.o
>>
>> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> JFYI, the patch has been comitted into printk/linux.git,
> branch for-6.11.
> 
> Best Regards,
> Petr

Hi Petr,
I see this landed in linux-next, but is not currently in Linus' tree for 6.11.
Will you be able to have this pulled during the merge window?
I'm trying to eradicate all of these warnings before 6.11 rc-final.

Thanks!
/jeff

