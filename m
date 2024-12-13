Return-Path: <linux-kernel+bounces-445250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9439F1352
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5A216AAB5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B5D1E411C;
	Fri, 13 Dec 2024 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WJ3e+2/l"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFE717C21E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734109857; cv=none; b=oFFZFkW+4InpHLHgmcqZhBGyTGxWhJvZRy6ZtYYIhSkLjvCEJOmxwgZTjADo1V6jc2ZpjYZQKUeZREsOWJ8LkE+lRLqxh1gekS+3mWiOSOe1bx+YpeFUvrqi6MfsFSZneIgoUPV3hU/pLAo7IsbFUxrYKAnODjVJP/ADkIKJPfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734109857; c=relaxed/simple;
	bh=xOsmFF3+Y7JJV3CR+rDTpsqQaeG/75Q40a0LVcRFoQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Qk+74kFBvtlvcfNQtAppdKXBiJnTaIbdiXRUjC8TKky7/HoFTUtH7nwTRhZTXVO6qcC1Fw7yvyKo0KVjZels1T9cUbCz+9VrGV9cxMK14uUiEeehJTNXsdtgrUv0fARovLZTefhMdNDgCjMKvCN4G8o1JalS3ecF3orfTCKD2xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WJ3e+2/l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDBiHWr019777;
	Fri, 13 Dec 2024 17:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yfRK5lIgt1G509p9iD14OdgEu2Zn47kwnYUwr3JRmRA=; b=WJ3e+2/lwqxKGW6a
	mUfMWUILaKRE19hHxT3bM2yWEliaJyXsPqmbFNV2jY90E9+8XxJi+Zz011eMMycf
	L1+0Jes569uU/RGnejGGlnBp0DmhhcAFJu6n00T7jhtODSyq0lF3fqLhmCtBc/cw
	atJxMGTJVMphDf6tygH9D0Jcpw1+HYF2hmoTvOxrB/zG3kpua7YBOLCxLcomGjU5
	G+XB3xwBaWBjqLFgtVIiS263hdHs3y3QXIUK3ysZ3E+yrfGVJvehage1H/Th71aC
	iCn8RFTQgQOIR36QQ3s0lhWdHTwNvpwJmnlQHUW2Y9ZF0G7gpRpIllNtErefjkSq
	2Z6wvQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gmac0ucr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 17:10:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BDHAkaW010986
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 17:10:46 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 13 Dec
 2024 09:10:46 -0800
Message-ID: <9822274a-26bb-41df-761f-54ad146aa204@quicinc.com>
Date: Fri, 13 Dec 2024 10:10:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 2/2] accel/amdxdna: add missing includes
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, Min Ma <min.ma@amd.com>,
        Lizhi Hou
	<lizhi.hou@amd.com>, Oded Gabbay <ogabbay@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, George Yang <George.Yang@amd.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20241213090259.68492-1-arnd@kernel.org>
 <20241213090259.68492-2-arnd@kernel.org>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20241213090259.68492-2-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Wo-Wh6Vi_krYYPdGO5yxwepZaWRpK_iR
X-Proofpoint-GUID: Wo-Wh6Vi_krYYPdGO5yxwepZaWRpK_iR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=513 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130121

On 12/13/2024 2:02 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This driver fails to build in random configurations:
> 
> drivers/accel/amdxdna/amdxdna_mailbox.c:357:8: error: unknown type name 'irqreturn_t'
>    357 | static irqreturn_t mailbox_irq_handler(int irq, void *p)
>        |        ^~~~~~~~~~~
> drivers/accel/amdxdna/amdxdna_mailbox.c: In function 'mailbox_irq_handler':
> drivers/accel/amdxdna/amdxdna_mailbox.c:367:16: error: 'IRQ_HANDLED' undeclared (first use in this function)
>    367 |         return IRQ_HANDLED;
>        |                ^~~~~~~~~~~
> drivers/accel/amdxdna/amdxdna_mailbox.c:367:16: note: each undeclared identifier is reported only once for each function it appears in
> drivers/accel/amdxdna/amdxdna_mailbox.c: In function 'mailbox_rx_worker':
> drivers/accel/amdxdna/amdxdna_mailbox.c:395:25: error: implicit declaration of function 'disable_irq'; did you mean 'disable_work'? [-Wimplicit-function-declaration]
>    395 |                         disable_irq(mb_chann->msix_irq);
>        |                         ^~~~~~~~~~~
> drivers/accel/amdxdna/aie2_solver.c: In function 'remove_partition_node':
> drivers/accel/amdxdna/aie2_solver.c:121:9: error: implicit declaration of function 'kfree' [-Wimplicit-function-declaration]
>    121 |         kfree(pt_node);
>        |         ^~~~~
> drivers/accel/amdxdna/aie2_solver.c: In function 'get_free_partition':
> drivers/accel/amdxdna/aie2_solver.c:153:19: error: implicit declaration of function 'kzalloc' [-Wimplicit-function-declaration]
>    153 |         pt_node = kzalloc(sizeof(*pt_node), GFP_KERNEL);
> 
> Include the headers that have the necessary declarations.
> 
> Fixes: c88d3325ae69 ("accel/amdxdna: Add hardware resource solver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> amdxdna: includ linux/interrupt.h
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

The interrupt part of this is now fixed, see "accel/amdxdna: Add include 
interrupt.h to amdxdna_mailbox.c".

The slab portion looks sane. I'll trim the patch when applying unless 
you'd prefer something else.

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

