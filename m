Return-Path: <linux-kernel+bounces-275053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A306E948011
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA992871E4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6980015E5D3;
	Mon,  5 Aug 2024 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WUIzRWeW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9C115ECCA;
	Mon,  5 Aug 2024 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722877828; cv=none; b=TilDws40yRkXKgcncSINIYaTghZ6Dxyx8WR+7OrkPQw8AEjtnk9x3/QB7CmFd/vsiLw9rTWHmfSZ/fCF1h7A1iWWXijmvlczRiySucxPH4swHa3pZvde7SmidMCj9N2b6U+qTkmYZMrZGezJtwZRXgM5UQfqfp1gva5ZyvIMBks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722877828; c=relaxed/simple;
	bh=9tJaWLv4mH3R2QhybNu7BkXVXh1WGgRljPqYxPDWIWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XiaJo3GuCg1Fv/NBKZ3YpXHsTDAncbnAzjo3zSbHCOE3hTjiUIcdAvqIB9I9O+pg368hiPDobMfoJI+uYAMSEPhyGUsuN2mLNo3NkrAGHqEN6x99VV3hcJGEVpBEOOzxTvj3gTSQBAk4Hag2q4EMqFFANRt8asPfU5KYENrJrBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WUIzRWeW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 475B7lYh012000;
	Mon, 5 Aug 2024 17:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CSGWQsvtlZMinEODr6YY8KrA+Zzj/QeVdsbGelRGysY=; b=WUIzRWeWE70wGzNl
	Bq+5P8KkAOvImyvThjB0acODkuCmdjG0gYxDjGPca9erbYiQ4GHY4z+jVkguYCGE
	V1v6vENVnE64C3QooqN7i8fIrZ7E4TYmld82FMsXTfwDjQWDQz/l2GIuq/CUuWnI
	RWcQ1PthsCt+zohHNEq15TfUbsxIM46sFZcs2CMW2HHnycF7hV6gut7Knasbjk7c
	5LFDmiQymp7alaIwB3hB9hX/0fpQv9A3B/5iTuURKL1dLVZESRdbukpcpqLiLO3E
	j0XC3MHRXtsFGnU5Jb7QthZJl106gtUWj5A9NUSq5ZgBHyFt3rxwd0qwS1UdL0ZM
	sISKmw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40scx6ms32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 17:09:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 475H9o8x017152
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Aug 2024 17:09:50 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 5 Aug 2024
 10:09:49 -0700
Message-ID: <61b3248a-a132-432b-afc2-f7415b0e2db5@quicinc.com>
Date: Mon, 5 Aug 2024 10:09:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 15/17] drm/vkms: Create KUnit tests for YUV conversions
To: Louis Chauvet <louis.chauvet@bootlin.com>,
        Rodrigo Siqueira
	<rodrigosiqueiramelo@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        =?UTF-8?Q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>,
        Haneen Mohammed
	<hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        <rdunlap@infradead.org>, <arthurgrillo@riseup.net>,
        <pekka.paalanen@haloniitty.fi>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <jeremie.dautheribes@bootlin.com>,
        <miquel.raynal@bootlin.com>, <thomas.petazzoni@bootlin.com>,
        <seanpaul@google.com>, <marcheu@google.com>,
        <nicolejadeyee@google.com>,
        Pekka Paalanen <pekka.paalanen@collabora.com>
References: <20240802-yuv-v9-0-08a706669e16@bootlin.com>
 <20240802-yuv-v9-15-08a706669e16@bootlin.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240802-yuv-v9-15-08a706669e16@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UolHV7q6Aasazs224d0UVDKaE81Ucfet
X-Proofpoint-GUID: UolHV7q6Aasazs224d0UVDKaE81Ucfet
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_05,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 clxscore=1011 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408050123

On 8/2/24 09:10, Louis Chauvet wrote:
> From: Arthur Grillo <arthurgrillo@riseup.net>
> 
> Create KUnit tests to test the conversion between YUV and RGB. Test each
> conversion and range combination with some common colors.
> 
> The code used to compute the expected result can be found in comment.
> 
> [Louis Chauvet:
> - fix minor formating issues (whitespace, double line)
> - change expected alpha from 0x0000 to 0xffff
> - adapt to the new get_conversion_matrix usage
> - apply the changes from Arthur
> - move struct pixel_yuv_u8 to the test itself]
> 
> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>   drivers/gpu/drm/vkms/Kconfig                  |  15 ++
>   drivers/gpu/drm/vkms/Makefile                 |   1 +
>   drivers/gpu/drm/vkms/tests/.kunitconfig       |   4 +
>   drivers/gpu/drm/vkms/tests/Makefile           |   3 +
>   drivers/gpu/drm/vkms/tests/vkms_format_test.c | 230 ++++++++++++++++++++++++++
>   drivers/gpu/drm/vkms/vkms_formats.c           |   7 +-
>   drivers/gpu/drm/vkms/vkms_formats.h           |   5 +
>   7 files changed, 263 insertions(+), 2 deletions(-)
...
> diff --git a/drivers/gpu/drm/vkms/tests/vkms_format_test.c b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
> new file mode 100644
> index 000000000000..c7c556b4fd98
> --- /dev/null
> +++ b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
> @@ -0,0 +1,230 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
...
> +kunit_test_suite(vkms_format_test_suite);
> +
> +MODULE_LICENSE("GPL");

Please add a MODULE_DESCRIPTION()

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
description is missing"), a module without a MODULE_DESCRIPTION() will
result in a warning when built with make W=1. Recently, multiple 
developers have been eradicating these warnings treewide, so please 
don't introduce a new one.

/jeff

