Return-Path: <linux-kernel+bounces-445173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E019F1252
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8430188DA2A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6771E3768;
	Fri, 13 Dec 2024 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MNtN0U+v"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274AB152E1C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734107593; cv=none; b=CDA4CkWgkSnjQta3VhGYAzXW4TJylYffmaS9t2nTXXNM7tWQgpt3iJO7YQZ2ckWmCcuN3cHrhiIDIqFHmw9VNnewqrqbK/e4I6fNaF76MM8mePeMNpDpb9gBOFp9i5oLZxz2qo0qYslJUK2DJ3G9snLbNNXfUWGiApTbxwMGFo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734107593; c=relaxed/simple;
	bh=GQ/Juk44Jbw9WT5lHrZ7+oghoslkdAUI7SV79TAuLMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SAxhLAMgNUsbC+QdlGm1nKDSM4DKwNE9d0zOWmAHyI1Fcj3kmbXLoFR8o/B5T9kTY94ySgqOFUhIvEUaN7/H1/S/Rfv8Tp8gvQZxG5dYXihiEPYSYz4PXq5v25UJ/vnYp40zX8RMxrcg6ei/cd2Gux2H8Dha4nypUfTFFBGgjbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MNtN0U+v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD9ntxc017554;
	Fri, 13 Dec 2024 16:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3UdoY78Ib78z33QlOlDIpVwfPAo7FkQMtIYZMTG0GEU=; b=MNtN0U+v/dHBHpq/
	TzptU+DhZxFQ244wYEABO5HLASb408fkZ7AjUYTZlw3qv7ruL/tkRSZH/LD6NICs
	2vHqVx1YqRGKQVegymHhwOS060gxssNj/AQEOH+aJ95uM3EpVIxK8dqNka4g8mrP
	Zavz4Ib3VgQQnzjRQZxPgwZqjN8HGVw4TQZ0iyJeNFRTlkdBrod/2PU0pxLvtF9X
	tqg88ahvvuCD4Vnn8bwKTI5hK9SfnFx4YZ2s4nNxSKm87C0k/ctaV9lkeBKjp6VY
	5Hrv4taw9dgTYir2uK/wHDrS0fDd0GbgTmmYfQUI7sjbImXG4pkN7pmQQExVZequ
	jhmg9Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gjmt13h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 16:33:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BDGX43s023661
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 16:33:04 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 13 Dec
 2024 08:33:04 -0800
Message-ID: <f82f3a18-82d5-4677-79c2-896c52821b27@quicinc.com>
Date: Fri, 13 Dec 2024 09:33:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V2 2/8] accel/amdxdna: Replace mmput with mmput_async to
 avoid dead lock
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>,
        <mario.limonciello@amd.com>
References: <20241206220001.164049-1-lizhi.hou@amd.com>
 <20241206220001.164049-3-lizhi.hou@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20241206220001.164049-3-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ay7faxzMBjmn0E6-RTjSvwswl98DMv8N
X-Proofpoint-ORIG-GUID: Ay7faxzMBjmn0E6-RTjSvwswl98DMv8N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=789 spamscore=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412130116

On 12/6/2024 2:59 PM, Lizhi Hou wrote:
> Hardware mailbox message receiving handler calls mmput to release the
> process mm. If the process has already exited, the mmput here may call mmu
> notifier handler, amdxdna_hmm_invalidate, which will cause a dead lock.
> Using mmput_async instead prevents this dead lock.
> 
> Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

