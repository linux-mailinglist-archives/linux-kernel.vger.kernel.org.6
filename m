Return-Path: <linux-kernel+bounces-231157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569C99186EC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1319D2821FA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5408E18FDB0;
	Wed, 26 Jun 2024 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CkioqqQX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD4518C32A;
	Wed, 26 Jun 2024 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719418097; cv=none; b=c/w3/gJX/u7mhSvpI6WD0PyRatx/MXDQsk5qh+GhbNJ7B4SpB0brUX6prmZkp+O+iIC+CoMiigmRT8t38O6e06zHaoHsoup+n4PAHISa1vtn2HN1xFyYqjcyRx8xx1n6GOMwtirseB+J/VYBJUB4vE1cnnDiu/ubWFteFThjhpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719418097; c=relaxed/simple;
	bh=h+ECohI+pS63vdbUZCDJEmah/z6yjm377K0Meg3eftI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nsd6bTP721ZTwB2Q0QOCzRFKJUtKJ4TdUrGJVJW6yzH4DAu1r9q90o7CXWnrt9DicCZvYTfbozmVZd3OhiAB0OcL2iPxqFROZwZLVyrNUIJOCIrWX1kM6kHGO8F7kB/Fhucj/vEbpsovHaaQaaVZwwpH9Q2yxq9RgL7Vm8Kwz5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CkioqqQX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAfP8u022660;
	Wed, 26 Jun 2024 16:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nfQvpxk0fZ9+T+yptaSqg/iqaE0+/X7CsK5vSn8TucU=; b=CkioqqQXb9P9+5si
	d8ikdrNaAh0KvMvau/xUGE9ww7nCHHWreblJNRj/E+ic0wBl+8tfAozM0cQL0JlI
	PblTwbgv9jL0boEb/yM28JLPoGVTiSBcT2hhdTHuUcLkssP4Nn81jzBHah4dnk7P
	jxR9xoycHXiOq35w01BkS1UwxOBmYfJaJ2QJ23vOK58MKyeLXZNK8Mkg7pw62bB5
	ehi6S65KfG29RmGGYvS7a67OscQ3CCMGY///iMy+YpmGfw40IJ9l6mtJw+g5bfPm
	pf0vbBdL9QcXb1tefOwR81UtUkEsz8WGi4ij4SCrtB9AK78bd2XTmWCjiR5D83qx
	1I7b4A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywqw9hm9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 16:08:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QG8B1x015480
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 16:08:11 GMT
Received: from [10.48.244.230] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Jun
 2024 09:08:10 -0700
Message-ID: <924856a5-a28d-4e69-8eff-9b266728d874@quicinc.com>
Date: Wed, 26 Jun 2024 09:08:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pcmcia: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Dominik Brodowski <linux@dominikbrodowski.net>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20240607-md-drivers-pcmcia-v1-1-6014889a1324@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240607-md-drivers-pcmcia-v1-1-6014889a1324@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Dv9w6GmN1yarFeHdPtks1UoCM3UAs5MG
X-Proofpoint-GUID: Dv9w6GmN1yarFeHdPtks1UoCM3UAs5MG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1011 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=767 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406260118

On 6/7/2024 3:02 PM, Jeff Johnson wrote:
> On x86, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pcmcia/pcmcia_rsrc.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pcmcia/yenta_socket.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pcmcia/i82092.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro to all
> files which have a MODULE_LICENSE(). This includes files which did not
> produce a warning with the x86 allmodconfig since they may cause this
> warning with other configurations.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Following up to see if anything else is needed from me. Hoping to see this in
linux-next so I can remove it from my tracking spreadsheet :)

/jeff


