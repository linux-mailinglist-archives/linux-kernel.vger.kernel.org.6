Return-Path: <linux-kernel+bounces-306238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1766963BC4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E8BDB2172E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDE9158556;
	Thu, 29 Aug 2024 06:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N64XJ8fl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7C412F399
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 06:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724913597; cv=none; b=b9US9Np+50KnxdPGrPfNFf9aXSKEqZyt9+QRVyf0n7R1cGG5nx3+lKYDfa50VV2AB+YGxzrPtaoGTdhgcHW5hFPN3lVa96xBeEM/kakEpalkWX8tkp+T4uZhR2A5LRgbwgKTx432gUkh1tMNTMrmoOj7/zCWXvilaReATPjqaz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724913597; c=relaxed/simple;
	bh=tPMnNbzqBwffx763HQhGzxd5L1ftY3mzNwl4CVYUuKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oJPw3ZywhpqJhRBrzvGfjAoPsC7NW13JmTm+PbanKwNaHD9UVAjjzUy20YN8Ui3aQ7O7aRgWH3/SAKb1l1C6mVuNUsVEOaDhixdXod1JJ3v0C/+s8JnDkrx0STl4s0do/XCJuvCH1+aDFlGrBXDqBejgTuCypdnTaJpptMJav/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N64XJ8fl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SJM4ZV026587;
	Thu, 29 Aug 2024 06:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SnzpndNdK/2kyzqJ55zW0fP85429rRJ5g+pWKtfgjks=; b=N64XJ8flOGV/xjHw
	0ZHY0FNAZkMu1Ius+kBWAbXTe3dpRQtqYt/XI1HnhbKHp6GwSfGEf1z7eU9AdSRh
	VaW3wjghhn09pehXTx6U4iGo7sowUZrlzrMX0iOc7AnDRgULl7yKj8Cis9iM+Ktk
	2TlwMdiUF+b3XKamzKMzbn7GnjP3e8o8A9Hz/DjFyI51Kl6RgvywgDuYvc57rlSL
	QHTpiPXEQU0NVUkz/pqHSvrCjBD0Gw3RJDrQmiyqMGLZib8M/AB7FCmY6IEPPYzC
	bZr5NOShky/NumXHBlC2p1VJfw7g7pnWhYZGcTiSJpq3J/2rbesKSneDR/TACWJa
	JodufA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419puuc4y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 06:39:39 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47T6ddMf019248
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 06:39:39 GMT
Received: from [10.217.219.207] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 28 Aug
 2024 23:39:37 -0700
Message-ID: <f5faa10a-25e6-4793-99ad-dbcfe0ffee8b@quicinc.com>
Date: Thu, 29 Aug 2024 12:09:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] i3c: master: cdns: fix module autoloading
To: Liao Chen <liaochen4@huawei.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: <pgaj@cadence.com>, <alexandre.belloni@bootlin.com>
References: <20240826123957.379212-1-liaochen4@huawei.com>
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <20240826123957.379212-1-liaochen4@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: y4I1wwiL6oLnG8FH6r6sVUgwqXcM2QvP
X-Proofpoint-ORIG-GUID: y4I1wwiL6oLnG8FH6r6sVUgwqXcM2QvP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1011 mlxlogscore=999 mlxscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408290047



On 8/26/2024 6:09 PM, Liao Chen wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from of_device_id table.
> 
> Signed-off-by: Liao Chen <liaochen4@huawei.com>
> ---
>   drivers/i3c/master/i3c-master-cdns.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
> index c1627f3552ce..ee555255f1a2 100644
> --- a/drivers/i3c/master/i3c-master-cdns.c
> +++ b/drivers/i3c/master/i3c-master-cdns.c
> @@ -1562,6 +1562,7 @@ static const struct of_device_id cdns_i3c_master_of_ids[] = {
>   	{ .compatible = "cdns,i3c-master", .data = &cdns_i3c_devdata },
>   	{ /* sentinel */ },
>   };
> +MODULE_DEVICE_TABLE(of, cdns_i3c_master_of_ids);
>   
why not to use i3c as type instead of "of" ? Just curious, if it makes 
sense.
>   static int cdns_i3c_master_probe(struct platform_device *pdev)
>   {

