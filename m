Return-Path: <linux-kernel+bounces-281248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1105794D4CD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0CDA1F21F96
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484561BDDF;
	Fri,  9 Aug 2024 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iQ/RzX7U"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAE11BC2A
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723221396; cv=none; b=KxTVeTlsOAj7MnwtK7fChezeWF/V/dUOVhX/8QnfQPhdZpWsWQC49E9MAhCZ7ANitd0D3X16mKZmQIVThPi+6SsiRWXwIPIvNd+vglMNRcZ8APrbBFD1ZPjkjxLDhf0BqfYsXPB/ypra3bdvJZDywzLw6eitqx00z1r2M1Z+E5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723221396; c=relaxed/simple;
	bh=Pk181wZrc8CjOyiK+x8jE4viIK2vJcNu9pdHc000mm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qzcTiMrsc1VzOgHR8nRXbu5NUHGXboZBkN6jwWFJ3sbANaNlSHSz7gnJZsxtmWChcoWix5hCkd3iMQE7dHPsdaqDVZglLaMRip2y7uiaGVDRadGUVBPYBiB/7UWd0iQcXTJUyOwNQsxLWZgf6VOniNpe8/8YP7uNmEqnefSd8RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iQ/RzX7U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4796bLLD010747;
	Fri, 9 Aug 2024 16:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+fnDO0hWiOwDNXkXzOMlxzXZYhPAo062ATrotLP5le0=; b=iQ/RzX7UO6d4nw1l
	peP32BenC4ZvHHNTN+OR+CqWNBRHQRTQ1ZR+cc8EgVqJN9i8cNIr5CqwqIYQcgFw
	GSLPjyyXXTk4rpFpMHzvp0xtCMo/AZERh7x2QfFkdrO1O/XdQdVxtejTD/FHYIzD
	H8XPA2ICbS5fWRVwqbCeJjuJgc2LXMe/JirVXmWStWVX6exxKJtgGFCErIFcB8lw
	u1CAItHCN6t/ckkLzExeSmtevcaBuBBXyyC8uAIuirGa3fnlp81FUIZCNIL7kH0q
	3Fv67GqCeRuiT9uFdpyzjYZndmBpjO89Do9uFAiMUs/0kqoFCbZB6qHzLfjC1wV9
	+czbJg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40vpuvmytj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 16:36:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 479GaSnC009861
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Aug 2024 16:36:28 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 9 Aug 2024
 09:36:28 -0700
Message-ID: <06648b4f-c606-06fb-0b9d-945a51f9a297@quicinc.com>
Date: Fri, 9 Aug 2024 10:36:22 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V2 03/10] accel/amdxdna: Add hardware resource solver
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>
References: <20240805173959.3181199-1-lizhi.hou@amd.com>
 <20240805173959.3181199-4-lizhi.hou@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20240805173959.3181199-4-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ISCiTNZOVjEBVWlxcMl-QJ_3gDM2Xgs3
X-Proofpoint-GUID: ISCiTNZOVjEBVWlxcMl-QJ_3gDM2Xgs3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_13,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408090119

On 8/5/2024 11:39 AM, Lizhi Hou wrote:

> +int aie2_max_col = XRS_MAX_COL;
> +module_param(aie2_max_col, int, 0600);
> +MODULE_PARM_DESC(aie2_max_col, "Maximum column could be used");

I think you selected the wrong type.  What happens if someone sets this 
to a negative value?

