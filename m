Return-Path: <linux-kernel+bounces-372397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8069A480E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C99CEB25916
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542F4212D17;
	Fri, 18 Oct 2024 20:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="POyUYBiD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E887A21265C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729283499; cv=none; b=Z3P71s8DmOAzlSMeM81lrDN5H8pStvFw89GR+pO0yztEIAZH1A81ra3DbVrFvyRVPgk/zKn39coATnajkxVlJkiweMGAMLrZDEuSidUEE9tMfPHMR9xWl1onJmn+JyhawPEkjILc6hzNHvg7cLtsPmAieoF2zai8Z559eaT3zT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729283499; c=relaxed/simple;
	bh=37DmbodOfGQKngKOd59ESmXdUoUokmnZ57P0Oyo9rbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Fu2w5VtfaLNDc3kFJDN9aYkWLyPSNjnVT9k72W45hwcd+xJgKuuPeDg7LbwHDW5E1HGg7WrBRPp9r69bCMWmv5ZBUE6k6aIWlB5lZ1nSZyTbmQ8uknxofMhUBJvosEEJIRuAlrz7rFNAp7QM9VUA7HBfzSiB2cTizh5PBh3R6Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=POyUYBiD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IDc3UC016598;
	Fri, 18 Oct 2024 20:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NG/xyfizzcfYfSTeCTDclLa2qHCQ3KBPpWpPOo590Qs=; b=POyUYBiDyAiXwi85
	CSE47AbG7pyPFDfUlWEWwkpO1vxw3EADUXqwH0Xp276g5tezAivmBWTLgcNZk5h3
	d3xbxa9DmuNlyOJ3LLffrR7LS96924mNHmNMFmt1oDpSiMlv7rUHSNVM2L/hW76c
	dUU4AUmhIb+7xwrbdjkW0tLuGgxGJXO8uM/4kFBAOJUnMzkeK7dRPsRXJVZAyGq6
	OyXOAcBhMLnG9sEGHLWccixU/DvsEfMBalFjT5/7uJzRUJha/HBGqZX+M0mqwoLO
	Ro0mD0eEM2AfGtjdymh6VeDsyvmlBwTo3dlD9HwwE5dVYccLkci0E8stPcC4fL1K
	eMFSeA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42bh3pamks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 20:31:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49IKVTHw012229
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 20:31:29 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 18 Oct
 2024 13:31:28 -0700
Message-ID: <9b3e351d-a0f2-5b8f-59ae-e1029ca0b18d@quicinc.com>
Date: Fri, 18 Oct 2024 14:31:28 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V4 02/10] accel/amdxdna: Add a new driver for AMD AI
 Engine
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>,
        Narendra Gutta
	<VenkataNarendraKumar.Gutta@amd.com>,
        George Yang <George.Yang@amd.com>
References: <20241011231244.3182625-1-lizhi.hou@amd.com>
 <20241011231244.3182625-3-lizhi.hou@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20241011231244.3182625-3-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: D39JgtSzJhBfF7tH71tnLJcDpMWoM-OL
X-Proofpoint-ORIG-GUID: D39JgtSzJhBfF7tH71tnLJcDpMWoM-OL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 mlxlogscore=746
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180131

On 10/11/2024 5:12 PM, Lizhi Hou wrote:
> AMD AI Engine forms the core of AMD NPU and can be used for accelerating
> machine learning applications.
> 
> Add the driver to support AI Engine integrated to AMD CPU.
> Only very basic functionalities are added.
>    - module and PCI device initialization
>    - firmware load
>    - power up
>    - low level hardware initialization
> 
> Co-developed-by: Narendra Gutta<VenkataNarendraKumar.Gutta@amd.com>
> Signed-off-by: Narendra Gutta<VenkataNarendraKumar.Gutta@amd.com>
> Co-developed-by: George Yang<George.Yang@amd.com>
> Signed-off-by: George Yang<George.Yang@amd.com>
> Co-developed-by: Min Ma<min.ma@amd.com>
> Signed-off-by: Min Ma<min.ma@amd.com>
> Signed-off-by: Lizhi Hou<lizhi.hou@amd.com>

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

