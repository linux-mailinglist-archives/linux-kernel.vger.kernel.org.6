Return-Path: <linux-kernel+bounces-246163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E1292BE69
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C08F289CB9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5417D19CCF1;
	Tue,  9 Jul 2024 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YVqycvS2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF6A19D08B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720538975; cv=none; b=UisOQ3lF6DSRafKFJTSoLjlLKp6mjMGCC8vo3mK7Xw47NlsiR6HbbP6HnoGOJyLuYiV4XInaKnSEWWt1It9ZgJzrJ5Os8e9+Z/5vBEZn8hfN4QqNndawz+zb3Q4wqEroBYQcNpxva+1obH6NJSRAcGKhObYLvduQNEsshb3zwr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720538975; c=relaxed/simple;
	bh=Crrca+M6mzX4SnfPP1ItY7AFeCLgpMEhL4zuTxTaHoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IbZ33wUnUeQi9OHsUJyKcYHJaqIy6w0XgaDlqceVneEWi02gHfbYZcbe7T4gCb4713nXyqSoGw485QevdlELNfQKi/9Rs27okhZaY9E5F8NqU4zaX9cP3aSI21qaZkbELIoREKz+ZzYK7eI8wfRSx66eceKWAjC+Fpv/Qame+DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YVqycvS2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469BQtI7013428;
	Tue, 9 Jul 2024 15:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h4WiPsIBrKbfAq1y/4pUmCzgG21sEIf+l6gOtFB40m4=; b=YVqycvS2KhXvN9Fd
	KWCtCoM9TKmQrgF0/qxk3DysQUPg6uFQ4hi3nA8+53ARcN2+AMOXZuFHrpFuPxLg
	iVzrgrrFMlH4kYiGguHD3mCc257MjTU8Oi5PAXntaN+hAw9PxIr8mrspC8uilKfd
	PZ4a/w8S2yNT3GIToDiFxDjdZW8zk70euZqn/Zxw0Lzckl8E7aSlSvqnnRHugJi4
	koBwABwQUWcKZwgfJCoZUFfqe4tZC4ZU3/52V8hCkWU7/XTI+moJKvddi1sz1kB5
	ODfoY9RqUnkbDZdVGIZiT+h7TPhFzt72N/FmqMXgwCYRvnGn32psC9IIA5oApoA9
	Ur7F5Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wmmpyrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 15:29:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 469FTQK4002573
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 15:29:26 GMT
Received: from [10.48.245.228] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Jul 2024
 08:29:25 -0700
Message-ID: <0e0150ca-fdfa-40cb-ad7f-6ac695b702e4@quicinc.com>
Date: Tue, 9 Jul 2024 08:29:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: crosstool: x86 kernel compiled with GCC 14.1 fails to boot
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Kalle Valo <kvalo@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <ath12k@lists.infradead.org>
References: <87y16bbvgb.fsf@kernel.org>
 <917565ee-732a-4df0-a717-a71fbb34fd79@quicinc.com>
 <837cd2e4-d231-411a-8af4-64b950c4066a@quicinc.com>
 <c9b23ee3-6790-404d-80a3-4ca196327546@app.fastmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <c9b23ee3-6790-404d-80a3-4ca196327546@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nkkXVyJJJxOzvMf2KM35TbI_eu5ePiEl
X-Proofpoint-ORIG-GUID: nkkXVyJJJxOzvMf2KM35TbI_eu5ePiEl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_04,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090101

On 7/8/2024 10:44 PM, Arnd Bergmann wrote:
> On Tue, Jul 9, 2024, at 05:55, Jeff Johnson wrote:
>> On 7/8/2024 6:57 PM, Jeff Johnson wrote:
>>> We tend to enable a lot of debug config options, so I'm wondering if one of
>>> them is contributing to the issue? Guess I'll turn off a bunch of those
>>> options and try again.
>>
>> OK, with a bunch of debug turned off my image boots.
>>
>> Now to find the culprit.
>>
>> Current diff between original config and working config:
> 
> Nice! I've tried the reverse now, turning on the options
> you have turned off on top of my defconfig. This version
> still works for me, booting with a plain
> 'qemu-system-x86_64 -kernel arch/x86_64/boot/bzImage'
> and building with my arm64-to-x86 cross compiler.

I picked my favorite to begin with, enabling KASAN (which in turn enabled a
few others). The resulting kernel did not boot for me (just saw a black screen
after the GRUB menu). Diff between working and non-working config is below.

I then downloaded and built the config you supplied. With that I have the same
behavior as my original config, the display is frozen with:
Loading initial ramdisk ...


[jjohnson:laptop 1966] diff .config.old .config
19a20
> CONFIG_CONSTRUCTORS=y
326a328
> CONFIG_GENERIC_CSUM=y
334a337
> CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
856d858
< CONFIG_VMAP_STACK=y
10935a10938,10940
> CONFIG_STACKDEPOT=y
> CONFIG_STACKDEPOT_ALWAYS_INIT=y
> CONFIG_STACKDEPOT_MAX_FRAMES=64
11033d11037
< # CONFIG_KCSAN is not set
11049c11053,11054
< # CONFIG_SLUB_DEBUG is not set
---
> CONFIG_SLUB_DEBUG=y
> # CONFIG_SLUB_DEBUG_ON is not set
11080c11085,11093
< # CONFIG_KASAN is not set
---
> CONFIG_KASAN=y
> CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=y
> CONFIG_KASAN_GENERIC=y
> # CONFIG_KASAN_OUTLINE is not set
> CONFIG_KASAN_INLINE=y
> CONFIG_KASAN_STACK=y
> # CONFIG_KASAN_VMALLOC is not set
> # CONFIG_KASAN_MODULE_TEST is not set
> # CONFIG_KASAN_EXTRA_INFO is not set
11300d11312
< # CONFIG_UNWINDER_GUESS is not set


