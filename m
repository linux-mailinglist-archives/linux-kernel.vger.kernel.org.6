Return-Path: <linux-kernel+bounces-351267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD79990F2A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 21:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0361C22F3F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 19:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04439231CA0;
	Fri,  4 Oct 2024 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QgSK3jpE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B3C231C91
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 18:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066791; cv=none; b=QST4yVHWeMUXCZS+2xCLDBChVtfP2eGHT2OzsdxcWYXrgR5mCDlYR0A8VRuqGn4ph9arE9gZho0t56sfURKo/GlNa6HTgW9aeMWoRipliC/mU8iOEr2c9qZbBhjmq5ClZaUM7glXuemp5gok7nr0416uXyd7KUbODGAP8Em4Drg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066791; c=relaxed/simple;
	bh=CJkthIwbyQ2P295Vy9Qj+ckjweCDMd6jXFZiFV0zFWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G1ZkK8nt2AHQs4H5Tsbn5TUrsziW4N1Qpf4/En0thTVyAjca0mWUOz7avIq7PuAFta/WPG5sWVefYq5kUO+v9LgWv6K7wYFHi1K0HrfACUSTUATXmXKnjKpq3DoEa0v4H945ocBV2M8hrpS7lSlXTu4e76oik0yueo1WgZKNbCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QgSK3jpE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494AqpHV005396;
	Fri, 4 Oct 2024 18:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3+xaBo+tQwgmphShqtZjZP+Jn+aYi/Hz1R5K3p9jxYY=; b=QgSK3jpE0wHwBrG8
	dYCR3VAaVYJKOM7c4qXfBQ2zQEA50s0Gm5wVaifEfkgAOaK1901CZ46QKmMOHbo8
	Da1+eGgOcGNMaCeMMhs2vpJLXoe5K/fK9pGU0TmeCGE29tnmqKVZe7rGkwlnJftn
	7o4QE3mKVVVaqvr0b7HHiuvMJB8UUAxRCpBHpPEVHKW9UpDJJ2f/Mtv0J4Fd++Bz
	SM9LFkVbSFJcNArVG8nPxWECbOKAaDxzqNF8Hb/lCr3XIZdqtVwMwMWrQzxSvAzi
	fqFCYDsX26EU5MVAl9eQWW2aPioozlYzfzI9Radwzq2HY4y5V38OxCC3I6IKVUa4
	DFIRbw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42205e315e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 18:33:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 494IX38b028853
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 4 Oct 2024 18:33:03 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 4 Oct 2024
 11:33:02 -0700
Message-ID: <1a2bb8fc-0242-d86b-1de0-cc9eec1c61c0@quicinc.com>
Date: Fri, 4 Oct 2024 12:33:01 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V3 11/11] accel/amdxdna: Add firmware debug buffer support
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>
References: <20240911180604.1834434-1-lizhi.hou@amd.com>
 <20240911180604.1834434-12-lizhi.hou@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20240911180604.1834434-12-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FfKdEFuTcf_7m05uejgdJZu_GnxXU5gl
X-Proofpoint-ORIG-GUID: FfKdEFuTcf_7m05uejgdJZu_GnxXU5gl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=956
 mlxscore=0 adultscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410040128

On 9/11/2024 12:06 PM, Lizhi Hou wrote:
> User application may allocate a debug buffer and attach it to an NPU
> context through the driver. Then the NPU firmware prints its debug
> information to this buffer for debugging.

I feel like I must be missing something. It looks like this patch 
accepts a buffer from the user, and stores it. However I don't see how 
the NPU firmware ever learns that this special buffer exists to then use it.

