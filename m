Return-Path: <linux-kernel+bounces-372413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 248449A4837
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4F21F20F2C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168EF2144CC;
	Fri, 18 Oct 2024 20:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Jr9zJ8MF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44102141D0
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729283689; cv=none; b=lSvfpinN+0E/Il0CQCVKIm9RbO1EjUizVIiixBxc7PsKUclMLrWRo1AZu6LIeTYKSCwkWC3gKlbh7x/UE2cYB08NQsCvbPoIvXa5JDSpWJnG4Uck98ZoDc8h/5rHoOqkwtK578n3hNX16w0vbRd0GxYEElObbIBdkv5Hd70AB8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729283689; c=relaxed/simple;
	bh=bIVDWqPLBPD6g1wtNr/+mjzMkNp331zpJ/Buqh5/xIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aNlWv1CUw+VrvDoQLTdS7icgzpu5dXKMSOJdEDRcV7ngiZ5tC7eU/fENUrfN5Lz/obtRLlwLd9OKYNIt4Y1WYPWistwVRQxOjedngf/VtomlMj2PJ6VuzQ9SzEq6XP+OXO1RMtK/XqoIn0Jmc2cqw2P9J3QdddyaBKHzdBQK6XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Jr9zJ8MF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IFAYWT029257;
	Fri, 18 Oct 2024 20:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GrPBsPmFO/8nxc8IEZI/ln5U8MIFeNgMqe6Yb2cvJ6w=; b=Jr9zJ8MFJpkho++S
	VSp3qzX1SSM0VkK+q6cpSCuiSIUwRAS6EO/oY6Ds3aFRC+U5OeHV9MQw/9LnD9su
	NLbucnn4BXswASZ0EZw6QY+N6FJc365APizged6G9RodlYAukjEjpIB/UX1Ltv+F
	jD4nLMrDWLCV5/p5sxOm4vsOORbObS0kq2f/QvBEWl6+oWHHcziij/tG0C9PjjMW
	nrJ3xNl0Wna1WUONVUl0oEHKeYWnJ0w8Xl5CDVvsVDlczoHaCPlfoIxCmi1X7nge
	GLjUXVySA5fw1mWlm4+h1jO/GtE+/2vpwvjdaaUfYuiD+7mzJp0DyPoAQ38iUIVi
	I5kssA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42bhbqag1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 20:34:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49IKYfQ6008529
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 20:34:41 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 18 Oct
 2024 13:34:40 -0700
Message-ID: <b14620b6-9d6f-0a51-4c74-f8e52c5d045f@quicinc.com>
Date: Fri, 18 Oct 2024 14:34:40 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V4 03/10] accel/amdxdna: Support hardware mailbox
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>,
        George Yang <George.Yang@amd.com>
References: <20241011231244.3182625-1-lizhi.hou@amd.com>
 <20241011231244.3182625-4-lizhi.hou@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20241011231244.3182625-4-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4Z0Czwk0u-K5qAaVT_aHZ89lLxzMWcdG
X-Proofpoint-GUID: 4Z0Czwk0u-K5qAaVT_aHZ89lLxzMWcdG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 mlxlogscore=837 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180131

On 10/11/2024 5:12 PM, Lizhi Hou wrote:
> The hardware mailboxes are used by the driver to submit requests to
> firmware and receive the completion notices from hardware.
> 
> Initially, a management mailbox channel is up and running. The driver may
> request firmware to create/destroy more channels dynamically through
> management channel.
> 
> Add driver internal mailbox interfaces.
>    - create/destroy a mailbox channel instance
>    - send a message to the firmware through a specific channel
>    - wait for a notification from the specific channel
> 
> Co-developed-by: George Yang <George.Yang@amd.com>
> Signed-off-by: George Yang <George.Yang@amd.com>
> Co-developed-by: Min Ma <min.ma@amd.com>
> Signed-off-by: Min Ma <min.ma@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

