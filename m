Return-Path: <linux-kernel+bounces-372451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B299A48B3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8C60B25C8D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EBA18E348;
	Fri, 18 Oct 2024 21:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UZWf5vJU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F0B13541B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 21:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729285654; cv=none; b=PIFjaK3B9REkWhr7tCeUUF6Jkk5Z5pdXDrhE8Ls0U989o7dPGHgCXNzA6I2qukcvCxx3T2EzPswrrUyIZVP5TplGOLHJQMPEbk4rq1LcBi86fvcChbYezTNrjp8T4WJnhAO20ANNA6pFVA5r8ebOtw44CdLvwouocpvfQVmqx0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729285654; c=relaxed/simple;
	bh=2yKPRpiKabSL4lwy5ryUNL+4iNLaNZlQPh1OdXi3Jdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kH7Wfs7HgMqMspVQTi/g0GmKebT/VCtBOYXqUecZPYnlyN4uCog9UWaaOz/n/UL+3lpp/5uvm1agTrH5jCCdI/VlJz4/DlaY8a1G2FEC6VzRbS+KZqhfRmWHNEZ7eLp4ZT1nob2OXd38uCjFyFuQu2x3znIAubLH7i/ZxyoY1Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UZWf5vJU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IJeBlH019478;
	Fri, 18 Oct 2024 21:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	64swdM4Jkr+YD+1vnd0F/PRbVD0xwaOP7+vBIgKA3ps=; b=UZWf5vJUpc3LkGIk
	6vl/AWCmDwftm3pkjL57T5nrjJDnWWVzJTGsfhzjqrvrEk+u7pMjqpBUQ8hbmJo/
	rQEd5FeFUJ91RBOCabtjbzvaRyoUWzMFNasK/emhw0jh4mfF1jJogn14JM2nn6FX
	pAZ45w1oFMJMbJgHhdSXsA9IGSY0Zx51aYgGiiyOjP+1cvXa5r0QGRBtrMEHq49Y
	KJUQAUFBmUGGJFZjNMCwVkGMuKlnmqpzhkHgu49KvTNBatnKVohiZis81m/bFfFl
	atjmF6R0yLTe4rOKPLlwPsa0xBk52S4PUMY6992vgtwmBUxREHK8i8Zqb310I8gg
	+m3KfQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42bhbqajj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 21:07:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49IL7QAU026719
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 21:07:26 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 18 Oct
 2024 14:07:26 -0700
Message-ID: <ed24978d-2bed-1691-0fe7-c60c50116cb1@quicinc.com>
Date: Fri, 18 Oct 2024 15:07:25 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V4 10/10] accel/amdxdna: Add query functions
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>
References: <20241011231244.3182625-1-lizhi.hou@amd.com>
 <20241011231244.3182625-11-lizhi.hou@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20241011231244.3182625-11-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZNA8V7-0RtuJ37kWJnkto34Utp1rK8bE
X-Proofpoint-GUID: ZNA8V7-0RtuJ37kWJnkto34Utp1rK8bE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 mlxlogscore=699 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180135

On 10/11/2024 5:12 PM, Lizhi Hou wrote:
> Add GET_INFO ioctl to retrieve hardware information, including
> AIE, clock, hardware context etc.
> 
> Co-developed-by: Min Ma<min.ma@amd.com>
> Signed-off-by: Min Ma<min.ma@amd.com>
> Signed-off-by: Lizhi Hou<lizhi.hou@amd.com>

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

