Return-Path: <linux-kernel+bounces-366834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275BA99FB3F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACA30B21600
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BE51B6D08;
	Tue, 15 Oct 2024 22:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PxJZrXCL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC5D1C9EDB
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 22:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729030702; cv=none; b=bnf9ncgD6JBRzuAPYMeQeA4F5o3faN+UelFmYTRDTCuPxqVVAFsKEAVqgMrb1Pf32pKwxWWBakL3S4Pv6dwnKKrlyWRIJhHN2jU1qW3hrIjgooIdUWc5noAhkgvPQ1dOsIHgOM2JNDoU1hOWvyVjZqLfeF87RyRFZ5NxCSCn9E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729030702; c=relaxed/simple;
	bh=CU0/rJg141aCOclr/MUNNmWSlk7F/7DYGCEiIlTKg7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=o1Z3v0O1Fip4Ewz6EDenGSaHbP7HnQTlcuwDijZnszaEeBcKvI8BcLsfctrmV5cVg7bPKiE7XlxbwdRdwcU4udWIB5401C/HHLCf5g7Rrvj3plobGICoSew0c3qUD1yZqrZVYAV0DUZU6jz1OnqcmM1612+Q5fNRjDgkS3+SIg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PxJZrXCL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FC5B2s023378;
	Tue, 15 Oct 2024 22:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ODxjLB700NK0lK+QbYHvsBSndZD3n2gp1IyLtFLL35A=; b=PxJZrXCLEuopUhWR
	yAfloUuo7/sjj1swOURbNUPYMDZpm4nrDMFD+8qmu7ymwKkF4CRWigkqAeKJg9d1
	BGOhqjiH34gnY9KptLrr8Wr6ILEAY25i+EsPsYcMncQNTHAvZcM/F8LpDmEzZYtm
	gRXaG4f8fzRn7VPMR7tPvuU4gAKO1qjH9H3WJA8eP/FLYPKV4kGYRvCI9zh4qOk3
	byNq4a1F3mRcjq/hB1rhjBytC3Y/QhpBpUSncCSf/QkdP+lMes//fvteknu4h/3i
	/IvnFv2ZBDb4hAPuH9hfJW33SeTfjmjcgnYeEeg35EaHtiB/n06RnInjqirDtUSn
	n+HP/A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429r3b9r5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 22:18:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49FMICaf025930
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 22:18:12 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 15 Oct
 2024 15:18:11 -0700
Message-ID: <92435cd4-c0e1-4d05-8ecf-52dd9249adf4@quicinc.com>
Date: Tue, 15 Oct 2024 15:18:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] misc: misc_minor_alloc to use ida for all dynamic/misc
 dynamic minors
To: Vimal Agrawal <avimalin@gmail.com>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <arnd@arndb.de>
CC: <vimal.agrawal@sophos.com>
References: <2024101416-scouring-upbeat-b658@gregkh>
 <20241015070226.15790-1-vimal.agrawal@sophos.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241015070226.15790-1-vimal.agrawal@sophos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 69CLDjXh06Xhuvtfiq0Xe0sjY_jnSfWM
X-Proofpoint-GUID: 69CLDjXh06Xhuvtfiq0Xe0sjY_jnSfWM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 priorityscore=1501 clxscore=1011 adultscore=0 lowpriorityscore=0
 mlxlogscore=942 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150147

On 10/15/24 00:02, Vimal Agrawal wrote:
...
> +static struct kunit_suite test_suite = {
> +	.name = "misc_minor_test",
> +	.test_cases = test_cases,
> +};
> +kunit_test_suite(test_suite);
> +
> +MODULE_LICENSE("GPL");

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
description is missing"), a module without a MODULE_DESCRIPTION() will
result in a warning when built with make W=1. Recently, multiple
developers have been eradicating these warnings treewide, and very few
(if any) are left, so please don't introduce a new one :)

Please add the missing MODULE_DESCRIPTION()

/jeff

