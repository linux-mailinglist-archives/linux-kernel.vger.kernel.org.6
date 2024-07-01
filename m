Return-Path: <linux-kernel+bounces-236406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D83991E1D3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D401C23376
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04F015F412;
	Mon,  1 Jul 2024 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H/ouHzEV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCADB15FA61;
	Mon,  1 Jul 2024 14:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719842726; cv=none; b=dxHXhlpWfYJMd6V8WYTYdG8/+Q86yTfisx7yUkROZmIgPGob6FdJVubQ9Ur/nptWn4AgMkrFX7nZEUrZJxTSL8cObseoAxnJNh54/RntrCmsU8467KK5VBfyGLJu1iWDTEGtkZqguIc879ygr8WqLXDPWK0a8CmWTk4W7lV0Po8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719842726; c=relaxed/simple;
	bh=P7mHMYINrxetobn9ZViIRylKEP14vvmxEG4jiK7LAww=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pl9mkOfYpheG51Rjlfh/DYp4jBS/ezyl5eheBqTob2XX0vPE6ca9giD/M6E5vxn3Osjnx1357xoFIs17bjW5d5Cw4T4ulnPpBLSgs8E2XLpR/FK5Lj326iPSBPTKEZcWbIODETM2n/015UNvHFG+9TRZatJ3rZM/hDY5xJUzyDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H/ouHzEV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461Ar1u1016968;
	Mon, 1 Jul 2024 14:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8yEHUL1+8lG8dOzQpz4+tSx6KmesEvcgYDIBanPw4yw=; b=H/ouHzEVtUjUWr0+
	1LTP5rt/Gm2V63hfHhRSi8nJLfYfAhvKIxklSC1kWoP7ajWsA1IsfY6jz1pa/R4i
	fM23R1AW2lmthl8ElU46Lavgz5+mx2iOTZZQ3iMJpgNBttFfFUuDc+Cz99qCaVzK
	1BYLsWL2U5jSlpYW+UCECgwUdgFYUG4yRh4TEd/lGvb6XZYoJ9RvcjQKVyoEiow6
	88nlyWnAvhGQZ4osK3MxH15+SCKGpB6djAmhIv2EPnZTVDk84VaHNOZ/CotUXWDP
	sc5kUC0EGc1bjrPDeGCfGet9+i0wSVMszDZaT09AEBB2LFu0IjfsIT4M6sAuinit
	VEJtZw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 402bj8475j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 14:05:02 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 461E51NS030326
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Jul 2024 14:05:01 GMT
Received: from [10.204.78.151] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 1 Jul 2024
 07:04:58 -0700
Message-ID: <a8a670f9-f03f-eff8-5cb2-b40b06267bc6@quicinc.com>
Date: Mon, 1 Jul 2024 19:34:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 3/3] ASoC: codecs: wcd937x: Remove separate handling
 for vdd-buck supply
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Prasad Kumpatla <quic_pkumpatl@quicinc.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>
References: <20240628101143.1508513-1-quic_mohs@quicinc.com>
 <20240628101143.1508513-4-quic_mohs@quicinc.com>
 <53015d64-a194-4596-8950-a55b4b0e429a@sirena.org.uk>
From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
In-Reply-To: <53015d64-a194-4596-8950-a55b4b0e429a@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4z7-36iqK6WtMQCuMu3R855gofjn0oUO
X-Proofpoint-GUID: 4z7-36iqK6WtMQCuMu3R855gofjn0oUO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_12,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 suspectscore=0 mlxlogscore=734 mlxscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407010108

On 6/28/2024 6:12 PM, Mark Brown wrote:
> On Fri, Jun 28, 2024 at 03:41:43PM +0530, Mohammad Rafi Shaik wrote:
> 
Thanks for the review.
>> Replace free_irq() with devm_free_irq() because irq have been requested
>> wth devm_request_threaded_irq().
> 
> This seems like an unrelated change, and TBH if explict frees are
> required I'd question if devm_ should be being used in the first place.

okay, will remove this specific change from patch change.

Based on review comments added devm_free_irq().

https://lore.kernel.org/all/f741630e-f9e8-45e1-b3e2-4866f0baeac2@sirena.org.uk/

Thanks and Regards,
Rafi.





