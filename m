Return-Path: <linux-kernel+bounces-209990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 030FF903DCD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A01C286400
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C55117D34A;
	Tue, 11 Jun 2024 13:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LTGqxHyC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBFE17BB35
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718113377; cv=none; b=HP7xXZ9REyxiWib6vw2Q+7PizPZa7IKgFMd/02qFc7iid+36kGS+wNa6tnKwPKvJtKK02kBlpgs0R7MWNoLk6VuVuy6PyiIGX55EUx9T/HUsiEH+5j0ZyGjvki0qg7BfpXfICUXwmEgvFuWVXvVCCOmSD+vrhti7u0/6QB9xkoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718113377; c=relaxed/simple;
	bh=I5GaCUcz5hV8Iq9UYbwq9Qkhrmua7XjwFGXvmMzJ4J8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d0hnbzkZ8c9/wnQQdmScpnp7ObowAzpAfsHPypq/EPGnJ/uV72kxmPIErecnaTjCr089j6z6loULIjoPzGuNIlw0um1H7YgfZZCMV2b0LZioiccFkccrPdtsH1mr5kxKmmgc5ijlteD8mpCEtp4NU9/uvYHS9VTgnJGRtloanxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LTGqxHyC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45B5kNqo014980;
	Tue, 11 Jun 2024 13:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EGv3QeMPBoLjpiRzl1DcqZgPJZpLuI3J01GLec8uR20=; b=LTGqxHyCdGU8Gh83
	P1fyq9Yv6AJ88wq5Kc+0QyFcUAi37SqNnU1Y4GnqZROWJttfWlIG8t8QU8WF81zJ
	EGWyQ5Jql8SqcAct2toRDZ5yFre//gnLQb1+SKDVyXO1G3L//y66AsB99WK6ZSgs
	lPEfvi5vlvXqk0TiVT1Py4IE9VU94TIi1EDQo6swgjIVyPiHxQ3j194heI8/Bk1K
	oZS5Q47NcNMUtNzHYFU25Ycoe/5KvFN/O0/0N/AZ5oGPTVqYb2UbUpw/6FakMOHb
	kf5T92SbJF0UFvTxSs+v22/nyDlz7hobqz6zet7TyiSbFTlxFf8fnCSP0JG+7K6q
	zpLpTA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymfp7e8as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 13:42:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45BDgikT024959
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 13:42:44 GMT
Received: from [10.48.243.20] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Jun
 2024 06:42:43 -0700
Message-ID: <a9d73ecb-1ad3-4f3f-8a32-2aff3713f023@quicinc.com>
Date: Tue, 11 Jun 2024 06:42:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] drm/mipi-dbi: Add missing MODULE_DESCRIPTION()
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20240425125627.2275559-1-andriy.shevchenko@linux.intel.com>
 <ZmDMxtDz5aq0xom6@smile.fi.intel.com> <ZmhSSvT0pxp3Sz8s@smile.fi.intel.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <ZmhSSvT0pxp3Sz8s@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hWV5l01UdnHhVkmgY0gXF86h_lciRO00
X-Proofpoint-ORIG-GUID: hWV5l01UdnHhVkmgY0gXF86h_lciRO00
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_07,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=791 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406110100

On 6/11/2024 6:34 AM, Andy Shevchenko wrote:
> On Wed, Jun 05, 2024 at 11:38:31PM +0300, Andy Shevchenko wrote:
>> On Thu, Apr 25, 2024 at 03:56:26PM +0300, Andy Shevchenko wrote:
>>> The modpost script is not happy
>>>
>>>   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/drm_mipi_dbi.o
>>>
>>> because there is a missing module description.
>>>
>>> Add it to the module.
>>
>> Any comments on this?
> 
> +Cc: Jeff, FYI
> 
I'm handling this plus others in:

https://lore.kernel.org/all/20240609-md-drivers-gpu-drm-v1-1-89e9a316d513@quicinc.com/

