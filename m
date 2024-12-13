Return-Path: <linux-kernel+bounces-445253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFD19F135C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056ED188D3B0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF361E3DC6;
	Fri, 13 Dec 2024 17:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Gl4kJNG6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECA717C21E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734109922; cv=none; b=MoRqh3OCQDPzEvwabwJhy35s8absrwa2adzbgvCVQwac3ZGc2Jyf/9WCDHpwzhaQ7dYuNVunQJg3+oDpQIFikl8qhdM9UqSQZWOjQHYnSZAf8jaf30W50Zff9GEJT98E7yOZ2LAsvZm6NjJgyExYJ5Rqx/7vslFofs1HXQbBNIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734109922; c=relaxed/simple;
	bh=/PXErJk/KUHfhXCq5uYSvMqv7qurNkRYTQ9NOnYkkjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qtZyERYF4v/vg7sNt4VipCPoPwQI4UjkEL81MlgX4F3KH3hzXBWtbAnODZH4PSACw5my+XjbhPPbPHl9yTOjE9VQIj5sU135rS2HtrkxtJXVFFF9ZRQtp61ZpwjCIV4wUshRzsYNCM97vZVNvgKWkNl2YMSBxMOHSe4xnWXhjhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Gl4kJNG6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDBhkZY017829;
	Fri, 13 Dec 2024 17:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fvN/e/rxh5xYieWw/LvfRYvBj0k8SmcWrGqG4VRTU9U=; b=Gl4kJNG6H/132uS8
	cCYiykj8CaTLnIAy11K+5E6FCKTOBhVxL71at6AEe0/8vmTuw6dHtybQnlBbwBut
	98o5dR7us5H6StIriUBzy68j1enPIp+XyOw69+FtUDXsopOp+l5ooi0O3McAfskz
	PSwjzHby1Nw4saVjNVN++kU59KFgI7lWROsYVF37e1oIBdjWEYkJVCKAv77n1G7u
	I8KmYuwak85uyZzcMsFxHI7DChARowk3D65SmyE8yskgjm1A75vb9YkSwMu0CSHF
	c6oU/hEUIgFMwFl9W2QmXDuPgZBAYDlNjhA8H5Y7sCS9FWd+AxFsmyzSS8Gb0RN6
	qEPvOw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gmac0ufk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 17:11:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BDHBsLV013836
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 17:11:54 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 13 Dec
 2024 09:11:53 -0800
Message-ID: <ead454cb-230c-cef7-6403-7b798920ffb5@quicinc.com>
Date: Fri, 13 Dec 2024 10:11:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] accel/amdxdna: Add include interrupt.h to
 amdxdna_mailbox.c
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>, <mike@fireburn.co.uk>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>,
        <mario.limonciello@amd.com>
References: <20241213163856.1472207-1-lizhi.hou@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20241213163856.1472207-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IAAzL1kRDq6q-merRRFiEgTzHPDDyKCM
X-Proofpoint-GUID: IAAzL1kRDq6q-merRRFiEgTzHPDDyKCM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=963 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130121

On 12/13/2024 9:38 AM, Lizhi Hou wrote:
> From: Mike Lothian <mike@fireburn.co.uk>
> 
> For amdxdna_mailbox.c, linux/interrupt.h is indirectly included by
> trace/events/amdxdna.h. So if TRACING is disabled, driver compiling will
> fail.
> 
> Fixes: b87f920b9344 ("accel/amdxdna: Support hardware mailbox")
> Reported-by: Mike Lothian <mike@fireburn.co.uk>
> Closes: https://lore.kernel.org/dri-devel/CAHbf0-E+Z2O7rW-x+-EKNQ-nLbf=_ohaNzXxE7WD2cj9kFJERQ@mail.gmail.com/
> Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

Applied to drm-misc-next

-Jeff


