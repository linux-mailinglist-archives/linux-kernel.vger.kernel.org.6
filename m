Return-Path: <linux-kernel+bounces-355910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5A19958B0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E4B51C21DCB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B811C215024;
	Tue,  8 Oct 2024 20:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="liIqqjxN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC9B1E104B
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728420067; cv=none; b=uxov5QTWzLu/aBRn/go4Ee+IIKhiGJi2zS9do1tyOmnIc+3uD00HB0Wm336L3/HWrQUhVhqY4jcs87l46xJgLEMsQ4hguGNYYOe34R8QMw+5b6JHajpiNM4IW+bZrJ4t59TR9rXfKQybcBOsWxbwqP9ytWTfuKIuP2mAMB+0eno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728420067; c=relaxed/simple;
	bh=OrQq05l/cyi8s7TqpaLFFLbnL8oV31kUSYQFBfk2a1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QDJ7TCmssBnryrXTDuA4unmsMsTllImmGCCzsmGhbLuxVDAbAkUhfAIYLS4rITrj9GUnWZDyav2cRT5UokhGZiSXIBCtx9WiwpI7BMWKyepOnvM93gdZQHkxRYRuMJiqPvoriCVbYqyBbbpLTfTThdJHm1PLSQl1Fm3klVnTvGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=liIqqjxN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498ALXJn000960;
	Tue, 8 Oct 2024 20:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y3ga/sxWUsmRy3CcArtrcNesmN4oEuwGX5s9+nMN18w=; b=liIqqjxNtA6uwXgA
	IBPyv6Bbb2uVGlj9VwBcXBvetvbcbV05tiVULSZd2zol2LjdNp25A47VUkAwqNVH
	i65IsjBWIujYeBKI/TzQLWzO3uY7ORSiSnw5jlU8/1OWOb5tNr60yuQMsnRfkVY6
	FrincSLjHQR/jZlsnlxUt8DPDQ1tX/EWKbTEDJl4P6tZ6g6Rq2qy91hWpkshQxVQ
	3ERPxABj6yhVJzjJ8DlAekqyFwnp5OI5HtKuS7KKaxkBCatUu7UpTPkteXr3eUBM
	sYDlGlYxn9HpmJEcCqrmAntboOytlZb5REaQwp3C6UwkRa8ikYLqvMNzpn7lMNeH
	+gUQLA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4252wsspqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 20:40:52 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 498Keqji014852
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Oct 2024 20:40:52 GMT
Received: from [10.110.106.40] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 8 Oct 2024
 13:40:48 -0700
Message-ID: <9d105bdb-b0d7-44b8-8bab-a5c161759567@quicinc.com>
Date: Tue, 8 Oct 2024 13:40:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v1] arm64: defconfig: enable WCD937x driver as module
To: Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <kernel@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <krzysztof.kozlowski@linaro.org>
References: <20241007082312.2136358-1-quic_mohs@quicinc.com>
Content-Language: en-US
From: Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <20241007082312.2136358-1-quic_mohs@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TCIhoVJxebFNxkRvoQ7uMbc_giSWLUjt
X-Proofpoint-GUID: TCIhoVJxebFNxkRvoQ7uMbc_giSWLUjt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=615 priorityscore=1501 spamscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1011 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080134

On 10/7/2024 1:23 AM, Mohammad Rafi Shaik wrote:
> Enable the Qualcomm WCD937x codec driver as module as
> is now used on the QCM6490 platform.

Rephrase this sentence a bit. "Enable Qualcomm WCD937x
codec driver as modules since it now used on the QCM6490
platform" ? or better?

-- 
---Trilok Soni


