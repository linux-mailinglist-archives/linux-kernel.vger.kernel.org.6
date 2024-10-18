Return-Path: <linux-kernel+bounces-372378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BE59A47DE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D093F1F216B2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DFB1DA0EB;
	Fri, 18 Oct 2024 20:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oULBYi7L"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B00F18C35F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729283102; cv=none; b=p8M+D6RLbYzRNjYq2PQQWrufTJbK5S1Tw803PI7kPcm6rnTw6JK0NGqmh5NpR+BHPyqFWh01gFKXBnVNm9nfpUy6ti/RL2dBhxZ0XgJnTeqMJI95A9a8xSn6rGwWZkPA8r3eRHdyn4fNEspqPdsxN/BraYf7LfBdkZ5iFWtoqPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729283102; c=relaxed/simple;
	bh=68b7Ts+IdqL/COKwd0hCRi/eHOJYDBrWidJqI/CELI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g5x/FXtJNoiC5krwUBdH9Y8FVUSFJsvnIejmDPjApnzyrHBSsDmw0gel9PZtLOGpoFxrW+xgmPCUFvDOpKIwU0ln2dyurbKK+++sF/eZ5pf4clyH379p1TxWWNW1Y06T7OIQDQFrMi7UtYl9VEcILE4PCErICk+bRhVwSWLXoqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oULBYi7L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IEhb5w029274;
	Fri, 18 Oct 2024 20:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fcrxKfuT2kfJGzuPBa6Gbyf2j+J7lnPDD3tyooyUpFU=; b=oULBYi7LVDkPXYAm
	4XDAbAPXWQ3I3YOQDwOWLP0IOQAec4jJYbYr8O63jOAW3NyjPT0fTflX/f6O2nYt
	vlSmJJvLj14szNnd22dbwYy6SL53zqqEC1IcqFN0h4/yE+QrRYDK58JoBnjRM3Ob
	TrSJJ1M2mSOFgAKH8+qajew85Nkge2ICkyBCX+jbJTgfSAJfDSZF+DndNC/1MK9D
	w31kOXLkb01yivduFkDR9by3XhmprVAVG+GrmTta7p7t/nxJj6qsJB75ZtJ98Jg3
	ifrJts1vz38MzKnwTCyba9cZ0JSkiKFgiTzcmdrFmJ3L3fq1nAXkS7VoOue3wYoG
	DUHQaQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42bhbqafan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 20:24:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49IKOtta026168
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 20:24:55 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 18 Oct
 2024 13:24:55 -0700
Message-ID: <5b4c3053-bd62-2083-14b7-9671b839080e@quicinc.com>
Date: Fri, 18 Oct 2024 14:24:54 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V4 01/10] accel/amdxdna: Add documentation for AMD NPU
 accelerator driver
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>
References: <20241011231244.3182625-1-lizhi.hou@amd.com>
 <20241011231244.3182625-2-lizhi.hou@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20241011231244.3182625-2-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hQCBqLbhqQ2sTgSXRpqIcZlO-t0NWuY8
X-Proofpoint-GUID: hQCBqLbhqQ2sTgSXRpqIcZlO-t0NWuY8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0
 clxscore=1011 suspectscore=0 mlxlogscore=798 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180130

On 10/11/2024 5:12 PM, Lizhi Hou wrote:
> AMD NPU (Neural Processing Unit) is a multi-user AI inference accelerator
> integrated into AMD client APU. NPU enables efficient execution of Machine
> Learning applications like CNN, LLM, etc. NPU is based on AMD XDNA
> Architecture. NPU is managed by amdxdna driver.
> 
> Co-developed-by: Sonal Santan <sonal.santan@amd.com>
> Signed-off-by: Sonal Santan <sonal.santan@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

