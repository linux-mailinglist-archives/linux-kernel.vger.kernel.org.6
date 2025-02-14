Return-Path: <linux-kernel+bounces-515236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ADAA36228
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE883B0897
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C840267382;
	Fri, 14 Feb 2025 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jzti3O0J"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E94267388
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547945; cv=none; b=ByPo4TcWFUw8+mUqctgr2ItuRn3PuMik+IZn4dIXcBZymPsQjeOJjbmG1NY1EXk+6e4nsKKJkKbHqDPtsiscFgOb5t88aYtKqlMwZKCbW3iS8mCVA/Nq/SwPikE1EGcnqGFkZ5BijE2IKsDWePR7/IdOuhwqRPuGvKYi4RwZldo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547945; c=relaxed/simple;
	bh=+ExP713b5mFjP4wt8A8r6eD5DXu2eMFlEH4rTnVFuK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A0PCkC92X5p3aBrE/DDkZuDKbq589D+6R/UY28klN3II/8jnCbhX4ipr7/CvcoC2xeh+bMo+B3IB2IjQIcZn6Mlor8AQ6YsmQhimTC9EEJhqmmh4gJeo/A+Yit6IWnkLYr1fXfeU/Y2DqW8qkoj6wP+03gW++yM0seYapF5RAMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jzti3O0J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EARXrH002710;
	Fri, 14 Feb 2025 15:45:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k8V7JDSxjlA4RsSI3aJs/XBi3Tu4zciSnDhpB7IYiW4=; b=jzti3O0JXasS3d6t
	ErYUfIiUG6qrQm9L25xchYOz2ho2ljFloCGHYeZbmO1vFqx6ESeKdl0H49CevbkM
	zuWVmT3Bvr9BhyyqEwtG4s30X2/yP3xVB76YTa8Qn9cf8PfIKkSFQKlB1b9UU7wF
	LBh6I90hypJnuWLLiW049TpfDmsToHHVXo0TjCSYC6DDEv4H+Z0Y+rKc/TVlIQPF
	7rDH9HZ6nAevwF+zclcFIT0hZTCVwDa2lCmIFhVf1HI1uNYo/FHpn77big3r+Id2
	rnrYCoXtB+9DyVEVXqFPtRxKO14+1vJ9JvZdjJ6NaL2ZbhTLL7U0YCqrAwDkJHVA
	594vXw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44s5w4den7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 15:45:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51EFjbWJ015965
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 15:45:37 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 14 Feb
 2025 07:45:36 -0800
Message-ID: <3df2425e-8772-4b32-bfe3-6e58e232b52e@quicinc.com>
Date: Fri, 14 Feb 2025 08:45:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] accel/amdxdna: Refactor hardware context destroy routine
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>,
        <mario.limonciello@amd.com>
References: <20250124173536.148676-1-lizhi.hou@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20250124173536.148676-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: m19_ry8L68jujEXEd1l80ZMigNFpIJrE
X-Proofpoint-ORIG-GUID: m19_ry8L68jujEXEd1l80ZMigNFpIJrE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502140112

On 1/24/2025 10:35 AM, Lizhi Hou wrote:
> It is required by firmware to wait up to 2 seconds for pending commands
> before sending the destroy hardware context command. After 2 seconds
> wait, if there are still pending commands, driver needs to cancel them.
> 
> So the context destroy steps need to be:
>    1. Stop drm scheduler. (drm_sched_entity_destroy)
>    2. Wait up to 2 seconds for pending commands.
>    3. Destroy hardware context and cancel the rest pending requests.
>    4. Wait all jobs associated with the hwctx are freed.
>    5. Free job resources.
> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

Pushed to drm-misc-next.

-Jeff

