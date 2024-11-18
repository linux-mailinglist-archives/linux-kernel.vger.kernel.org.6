Return-Path: <linux-kernel+bounces-413399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 875C69D18A9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DBA7B2142A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22921E25E4;
	Mon, 18 Nov 2024 19:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ElFLjZ3P"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29C41A08BC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 19:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731956923; cv=none; b=STr0yKKnDm7id47BAlbIAmP/j0Oem+IoNT3JDJ2HxTKIaQGfBgrNJgsr8M7bQ4f0rd9I8GvlnTJC84COxI8KYYdw0RWmmsxfIEGd1PcE5IPbURTWjc6Mzzqg95mt2mCUTY/UASfCgYwKGTmOj9cSBMZKPpqZnQ7vx5zYlTvaMcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731956923; c=relaxed/simple;
	bh=T1BC9g8E6L5X9T/sXojRAyc/OLNm7GpqrJl7kFDdc3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r7LNMXtaxAcwNgN6kQzNwZZ1xHtxpBw1WpMigeUMRN0GFmIZif/9AM0kw5l4l9hpyRn1lvP2rnXMGVM6Cs60OpxNErBaW71W45HJnvm9ieYyN6FI3QqOvMvXQ/tXpgxH2xEOX/4maDTVRCA5xyshRFDorFJFGbtRnjDG76rnDHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ElFLjZ3P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGGtfR031128;
	Mon, 18 Nov 2024 19:08:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vlFxOD1BH3U+YrDbN66hAzUoLHbhfkucIVgsnrnnLqE=; b=ElFLjZ3PmK3/+wX8
	dr2bbkTv8/eEs0lTtfikEvCiI0I1iK/7Ni9kxyEXcXiVJd3Nr2FXROHt6mgx+0BF
	qFs/0L+7Ijr7j+KBB8NNCAx4Fe37nJScb8WlLD3f1lAosjnoxpRHkT9BIG15oIKI
	/bUCFCOPmNCoOGY1QWOGdQj2xFDTSrWuysTCNEt6n1efbT8yp1aUKVtUV49K5HZh
	hjuijtPMtXH1LpNCCiNMxOLViQKWCZQS52FCSGom3qo6ndm1YgO6z/xLW2iqeAFb
	iGYXVIYFFiAwO8YpJVPeEeVSWxmGH5LQ8o/H+bk0OQ3nzlM+Ewixarmr/THc/qhd
	uWZ55Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y90ctt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 19:08:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AIJ8Ys2008477
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 19:08:34 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 18 Nov
 2024 11:08:33 -0800
Message-ID: <fb6aa162-561e-f357-be2b-6b9e46b6defc@quicinc.com>
Date: Mon, 18 Nov 2024 12:08:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V11 00/10] AMD XDNA driver
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>
References: <20241118172942.2014541-1-lizhi.hou@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20241118172942.2014541-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HqBBpZoDKzKwumB1QGxzKgbPf6B0SNB7
X-Proofpoint-ORIG-GUID: HqBBpZoDKzKwumB1QGxzKgbPf6B0SNB7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=836 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411180158

On 11/18/2024 10:29 AM, Lizhi Hou wrote:
> This patchset introduces a new Linux Kernel Driver, amdxdna for AMD NPUs.
> The driver is based on Linux accel subsystem.

Not seeing any additional issues.  Build for bisect looks good.  My plan 
is to let this sit on list until Friday to allow for one final window 
for comments.  Assuming nothing shows up, I'll merge on Friday.

-Jeff


