Return-Path: <linux-kernel+bounces-372437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EAB9A4871
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E1F8B23661
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EC518CC1D;
	Fri, 18 Oct 2024 20:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OUZG6/1Q"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8879A18DF8D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729284562; cv=none; b=Z90e8WPjuipFNDPDh/RyFwg8XI3JNJILqk2bHVpLdTdbui3t8avEAGkwvuF6TBom1WosjJiCtpvA9GucNDeKJjcmS5hgzBTwS7tgPf2pWuyY5E+GLV/SmCSQ3hg5rlodx9YCYxjSbSpwvyOXkuB1aEmFo/WfaTP7s7RYpKmlNjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729284562; c=relaxed/simple;
	bh=ZhKr3JJJNUJsoAYsCh2fRvClWkaLijyw78xW7PuwiTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rV/46SlLlO91Jof9tSISRKCagO5cVTYsS7cd388/COeX6xK5uVMEKy7vkcFLSewR1gSxIGXlzn8DxqHM7qoa9v/prF90ddhYs08xroNZLK2lWdF5+qFdZTbPC3pUy021EX7J75Hu4UZo0QSLtNAEoM0jqBcxdEpcMGCsBPOpF4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OUZG6/1Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IDugUD029894;
	Fri, 18 Oct 2024 20:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AfbTRaWR5GEYW/o9u0jm1HRuI1b1WVqFKFrn2tKJ0zQ=; b=OUZG6/1QL2Emv7xZ
	aTiGvqL0EAHZr44aD4TgGm5Z9cN9rATzrx9MD0xtvJgxqYkRVVTh4vuDgAVvkmOa
	81m+jL8tTXr8wAvsiJrPnnzVkTLOudItf00NbXewxbI1bV8eKHSuE0uSDY1Om94z
	mrGdv4v2HPS2KHv+He8xy1hz1KIuU9VbjXmfwwpvevpLGVet9jpXqopdu4mggULi
	/dU4SQrvaf67vrAgHh/DW4QynffWa17AI0+Y1o1yZv8kQ7SzkHVfNrKuYELk5Vfd
	4EeLM7HvZVKv4+qtQHn5SwVQXY7xCWygfpvJP2BaRvs6i3ZmnZrnycfNfnaVmcg7
	jp1tIw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42bs0ms2yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 20:49:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49IKn9le025584
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 20:49:09 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 18 Oct
 2024 13:49:08 -0700
Message-ID: <3696e980-1bb9-db9e-acea-e04762c8166a@quicinc.com>
Date: Fri, 18 Oct 2024 14:49:08 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V4 06/10] accel/amdxdna: Add GEM buffer object management
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>
References: <20241011231244.3182625-1-lizhi.hou@amd.com>
 <20241011231244.3182625-7-lizhi.hou@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20241011231244.3182625-7-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wCMBMkoaHCMCVJtVEcGgCyLV1P59N3dC
X-Proofpoint-GUID: wCMBMkoaHCMCVJtVEcGgCyLV1P59N3dC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=932 suspectscore=0 bulkscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180133

On 10/11/2024 5:12 PM, Lizhi Hou wrote:
> There different types of BOs are supported:
> 
> - shmem
> A user application uses shmem BOs as input/output for its workload running
> on NPU.
> 
> - device memory heap
> The fixed size buffer dedicated to the device.
> 
> - device buffer
> The buffer object allocated from device memory heap.
> 
> - command buffer
> The buffer object created for delivering commands. The command buffer
> object is small and pinned on creation.
> 
> New IOCTLs are added: CREATE_BO, GET_BO_INFO, SYNC_BO. SYNC_BO is used
> to explicitly flush CPU cache for BO memory.
> 
> Co-developed-by: Min Ma <min.ma@amd.com>
> Signed-off-by: Min Ma <min.ma@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

