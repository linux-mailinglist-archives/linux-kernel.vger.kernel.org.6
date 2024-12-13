Return-Path: <linux-kernel+bounces-445161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 362489F1230
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50158188141D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B8B1547F5;
	Fri, 13 Dec 2024 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LBf/khL8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3764357C9F
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734107489; cv=none; b=SqMFlBb5E9XkT1jBc486cBet+XwszZwEcDuT95uWhVbKdfl1dpE5kvIdZIp9PNsegF+X/tfipx6jLtHXXACkjSt4Pkppz2DWv8OzlWYVo2YecRCcHNIwpiYK8GxFc5L5HEPncEA/XL7vhrN3c3u8ustdHdrJ2+RsSQ12g6xyerI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734107489; c=relaxed/simple;
	bh=XIqYSK581xkM2j/jkSszuY3SAGPqnWrSykB28NrLznk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F/lPHLytbE23ywf9M2Mg3OZB8LsqP9+CCsBFQB2vNTLsEdkBqzcOSuIQnTU5hDyXzaWJPR6oEq4jrZ4NNAQZuGf0x/VGfQlfkEtekkNODhE4FXRWXOWHqzSILwplBIvD7o1OprrkXnfjheMjiBIrKPfgHrNvXOzJKE4MviuI1NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LBf/khL8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDABdgY006448;
	Fri, 13 Dec 2024 16:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eY5dDyEesSJGxeEoUwYmTBHFBpUdAAs+LRvh+KhXU2Y=; b=LBf/khL8pA9QbhM9
	zIRxXgU+O0VnAfhvnYxaapCwXrGTKKneg2ZJ7eTSEGEzUpg86wAOM76isrZp3jDR
	dKFiyPiK4jO0ewUkQ8yAAMg4jHseeND6qoFpFnl1YmEwBvr7qL5YmApt8Op8+SHZ
	J5rM8KhwHuBoTFXxt0Ur2iPyd2ALqrsiyjjMzl8nz/QuOiuD0wzZU53LSvRg4ZiI
	8ESlz3pAjzScT+uAxqeOanZanxAJCJ3W8vEd3BbOoJP/LEvUQKEH9xegvW7Ygh2P
	cg0WO0JlyPZrQ6IPRZuMlKDLsGdo/MSSN7L3OBMjpjC/xe0h2HUCfNJQ+fprVYQw
	L0iF9A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43f6tfg5wp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 16:31:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BDGVKic021811
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 16:31:20 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 13 Dec
 2024 08:31:19 -0800
Message-ID: <c0f233bc-3b33-6763-8ced-bbf097c2a0c1@quicinc.com>
Date: Fri, 13 Dec 2024 09:31:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V2 1/8] accel/amdxdna: Add device status for aie2 devices
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>,
        <mario.limonciello@amd.com>
References: <20241206220001.164049-1-lizhi.hou@amd.com>
 <20241206220001.164049-2-lizhi.hou@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20241206220001.164049-2-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OQq3rP2-rKU12nTt_mrL3b_X99dMctqi
X-Proofpoint-ORIG-GUID: OQq3rP2-rKU12nTt_mrL3b_X99dMctqi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=894 malwarescore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130116

On 12/6/2024 2:59 PM, Lizhi Hou wrote:
> Add device status to track if aie2_hw_start() or aie2_hw_stop() is
> re-entered. In aie2_hw_stop(), call drmm_kfree to free mbox.
> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

