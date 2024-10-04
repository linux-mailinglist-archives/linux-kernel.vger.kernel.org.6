Return-Path: <linux-kernel+bounces-350831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA99990A3A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 19:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10B9CB2127B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8C31D9A56;
	Fri,  4 Oct 2024 17:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XoPV9jSj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2029C1E376C
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 17:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728063423; cv=none; b=ejQ2+e7rUgW3wY8zM7Kf7+fHqE6ALJs6mD3sE/C+5lfvXngEitxNkK+F27/IVrODWVXhKWgWBONhzOm0UprQ8+2LHtY5NUS4XkwHjI/sjHMvxnpHSJNRtdcvbhPs1wfM2XBfYobov6E8e4gmWbYAZ6ITWO5rHlMCFYyIBE4oMu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728063423; c=relaxed/simple;
	bh=TWlDeZg6JyE3bGN++PzTfb6eLZ7CqJzB+545DU1cZEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ujrKcIxxyhECZ0Fsoo+LC2uP6tAuZy3ebJw2q2rck/txR+Hz09HRUuvnkcTvZeKLCOq8a7RL5Gll0/NwHCVh3yp76CvSqN8ldEOIi+QK21XMeUZL/lL14IdHd5N6d1MQJukOo+Q1wi2izhj/7whJsYK0sPzo3bRFPjJIkMqkrFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XoPV9jSj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494B3xJE026679;
	Fri, 4 Oct 2024 17:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HgKIT8BZ3ztNxKX0avm9NUOnO59kZYDTDcSiYSXcKio=; b=XoPV9jSjqTaKNhkZ
	Y+Lr4tvdhQk2jS/g2ViTguQsWrWWZn8QMfbeqZvhXwpuF2dU2EL+ZtS7D45Oro/B
	kPpWDgmyD7fT9By4CsfjZb2/tcvoIVLdqeY2vg8g+iwi/DwWyNpqvYJj5LbnBmpN
	Nhw52pFDm8J6xXhOzSNDJlWuvA9753RzM6fWWNs4Fuz/pXU+RsvkhIqaedUI7PLM
	D2eguar3ijcoIikWz3yISgfMs6V/Uh4VDPoFuGt/F5wGXDFlvVTL6DcZCNs3uVlx
	LAoPdq1Jc1jtQpKZcnW1AWc5savOs/q3CFeoaNntUMhsrJ5SAPt4r+jIW08AY81a
	SThrUQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42207v2ug4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 17:36:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 494Has6J022922
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 4 Oct 2024 17:36:54 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 4 Oct 2024
 10:36:53 -0700
Message-ID: <d4e451ed-20b8-6aab-9690-a86026d29f40@quicinc.com>
Date: Fri, 4 Oct 2024 11:36:53 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V3 04/11] accel/amdxdna: Add hardware resource solver
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>
References: <20240911180604.1834434-1-lizhi.hou@amd.com>
 <20240911180604.1834434-5-lizhi.hou@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20240911180604.1834434-5-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zKNWz0AqHHPbP5utygXYenlreMO7dg0K
X-Proofpoint-ORIG-GUID: zKNWz0AqHHPbP5utygXYenlreMO7dg0K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=847
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410040121

On 9/11/2024 12:05 PM, Lizhi Hou wrote:
> The AI Engine consists of 2D array of tiles arranged as columns. Provides
> the basic column allocation and release functions for the tile columns.
> 
> Co-developed-by: Min Ma <min.ma@amd.com>
> Signed-off-by: Min Ma <min.ma@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

