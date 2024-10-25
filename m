Return-Path: <linux-kernel+bounces-382304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBA39B0C16
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DFEC1C232E2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6A6187FE2;
	Fri, 25 Oct 2024 17:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MSYXnvOi"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85141169AC5
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729878542; cv=none; b=U0HDYd/99/XGz6mrK/8uHKr89jCOdvktduF22DmVmjFWJMI1GPLd5EJIAM1SKE64QKPpqmmWL7OCxGOTQDt1YvnKxEtH6rkdPN9oqEWJKiv9uVe5INJOC5l2ZYKUd7v7nJPrtwzVppK5eu7awyFVtr1pofmoplB3ozsbgs7ZDrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729878542; c=relaxed/simple;
	bh=3w9xTcSLwVY9awlM4yhYl9Axwo7w98pdayZVdCZKbXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e9RqvOnK2ONs0cLiyWKLpFtp77GaWJvdS7wzKfBNafnGQvzMF+CmV+9z6VqbzoJfGYQHUV5wOglldrxdtzNg0re8bjcXu9JXAyHzJ8yRJ8ZyizyNAxp8nSpEW6Dimiu0XKmrU+I+Wfrgzb/tyusJw5Ce0jcHGPdXKPhtw5pEF1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MSYXnvOi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PBjONp009174;
	Fri, 25 Oct 2024 17:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7pWi13LTGv1OARIyBbyQjH23hmWACd6rJZqZxMpdY8s=; b=MSYXnvOibanRFPhs
	KliJoHKeFsddxkIbHm4hOMgmdXLBg27skurRpjIrJnl6z+pQLLY+T7pY8wFprRSA
	HAk/EXbVtmj8dbB95CQgneudQGk4kIQExUtJLc9tD3Ql813TYRja9XQKVuhl3ejo
	E3WPLiiKZdj3fVWfQpjqNRPmP3fle6gPef6FxHCgb0eGiu09IC6XkAb8m9Jm5acc
	fNLzNcRcrZ8Mn+JXVH/CNA0qAVD9TX58+CV0Fs0J8qnMKiJ9vK4rs4mSe8rhAXz8
	qqGr863nGJNNoh6E2bc2faZz30kCcL243s1auComP2Ovg8HHPaTUO0VhuvnxgHfy
	6JAUEw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em43j032-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 17:48:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49PHmr5x014246
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 17:48:53 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 25 Oct
 2024 10:48:52 -0700
Message-ID: <3d66e80a-7781-5682-2dd3-571407798d81@quicinc.com>
Date: Fri, 25 Oct 2024 11:48:51 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V5 09/10] accel/amdxdna: Add error handling
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>
References: <20241021161931.3701754-1-lizhi.hou@amd.com>
 <20241021161931.3701754-10-lizhi.hou@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20241021161931.3701754-10-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QigT02SBC6BNQOdbDKfeULY2ETnpjpfr
X-Proofpoint-ORIG-GUID: QigT02SBC6BNQOdbDKfeULY2ETnpjpfr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=924 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410250136

On 10/21/2024 10:19 AM, Lizhi Hou wrote:
> When there is a hardware error, the NPU firmware notifies the host through
> a mailbox message. The message includes details of the error, such as the
> tile and column indexes where the error occurred.
> 
> The driver starts a thread to handle the NPU error message. The thread
> stops the clients which are using the column where error occurred. Then
> the driver resets that column.
> 
> Co-developed-by: Min Ma<min.ma@amd.com>
> Signed-off-by: Min Ma<min.ma@amd.com>
> Signed-off-by: Lizhi Hou<lizhi.hou@amd.com>

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

