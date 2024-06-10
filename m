Return-Path: <linux-kernel+bounces-208508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A86A902603
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47D41F2329B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A029140394;
	Mon, 10 Jun 2024 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Zc9pyATQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1052C12FF86;
	Mon, 10 Jun 2024 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718034687; cv=none; b=lXV4wmmNsX+oWVw4LeEZohdyZi4xeZ/l4i6b8Y/eyH/XJQmmIdm50Ijz0qSMLBhvjPhD3eqUpNS85qyeTMmvfYrm2Aeew7G+OHo/33YLUkpPgZK3GPsi3g5GKN+35CBcMg+TmmDL8eUU6yMxlI8B+K8DQg2IO+0rk8mzxmV8LfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718034687; c=relaxed/simple;
	bh=Al2ErmL31Onn+8V/GGNbIQAKuae82QEYFcYi/9kRTq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uI/SqjXpP/gX1hPAFL31Ax246WeCREIYoCF4qDmfaQNtVaxY1qhn/6h9C9xf7JLfM+XPGH61B+9C3EKb3NNJmK4VXCgBfKHl3SCvd8HhQatuHG8mEwlB9j2VT7M0es6chIl0+Amrl46hev5c/ORhJaYpYqDsXmavf/SauZnoLPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Zc9pyATQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ADjnBu028814;
	Mon, 10 Jun 2024 15:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Al2ErmL31Onn+8V/GGNbIQAKuae82QEYFcYi/9kRTq4=; b=Zc9pyATQ45fwVXdR
	wDUC/HD+uBF0uTuCBlx8ZGuPE+TPPRcdwz4NdBt/PSPrShJl4O8cGhjeZIOdc7pS
	PEE3EjUUgYuNJPEouJXIYZMD8f5q9R/3RmPBR+RRtobGQO8eDCO4b07tP7PeknOz
	jOsE3XfBTc7QWWE12HBv1flPB3Qky1BGRo/K7+DoVc+qkoUMnzZEu+RSveqbhsAn
	/z0VVojP8PPqnQLpzCdkWUhfe1jC1cQTodxNvpvULJmlT1Msw9BBQog2NZ8rwOMx
	c24WT7vIYysV0k6Smi2YcF0emQCzQByY9ye7uPChjyzCgyROmjALAio1BsEp8K4B
	4aPgUg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymfh34j70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 15:51:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45AFpEh4031345
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 15:51:14 GMT
Received: from [10.48.242.196] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Jun
 2024 08:51:13 -0700
Message-ID: <964210f1-671f-4ecc-bdb7-3cf53089c327@quicinc.com>
Date: Mon, 10 Jun 2024 08:51:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/5] clk: meson: c3: add c3 clock peripherals
 controller driver
Content-Language: en-US
To: Xianwei Zhao <xianwei.zhao@amlogic.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet
	<jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen
 Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>, Chuan Liu <chuan.liu@amlogic.com>
References: <20240522082727.3029656-1-xianwei.zhao@amlogic.com>
 <20240522082727.3029656-6-xianwei.zhao@amlogic.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240522082727.3029656-6-xianwei.zhao@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 03jNlSYQ9ip9hAsZZar47xByHwIFSVBS
X-Proofpoint-GUID: 03jNlSYQ9ip9hAsZZar47xByHwIFSVBS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_03,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 bulkscore=0 phishscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406100120

On 5/22/2024 1:27 AM, Xianwei Zhao wrote:
> +module_platform_driver(c3_peripherals_driver);
> +MODULE_AUTHOR("Chuan Liu <chuan.liu@amlogic.com>");
> +MODULE_LICENSE("GPL");

missing MODULE_DESCRIPTION()
make W=1 will produce a warning with this file


