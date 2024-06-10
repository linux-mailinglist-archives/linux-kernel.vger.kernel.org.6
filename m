Return-Path: <linux-kernel+bounces-208507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B3590262C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27D39B26FB6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DCF140364;
	Mon, 10 Jun 2024 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FkEKWHqy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9EA1E52F;
	Mon, 10 Jun 2024 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718034472; cv=none; b=a9lnv/lckiZSux1VNmQtaEh2MgziNXMrkGg0m/Bln8r7R1NpAC3z2l12M7T/BsjrbE7bGCjPqtzU3lAcqzzYevuohgw1HlZzjkOhwjdfOuoLn3GofKS/VMRK/U2bPOrkQJnIVoi7YrfzdFAaIlpKEYIpPox/vqsql1kE9lc/Igk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718034472; c=relaxed/simple;
	bh=6rTfujD1woPMOWzNzRUyk8OfduEpNUC3GdWLs22kUoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PVGlkTr3L9nIpBafZGWpcZQngz2oV7UHpIwClF1bdCwbgo6sxn63qCmF8cC/l2TW7Qf0HDwrN2ZqCLRGHkJWR3bzLuX4XPUjigM2kzMS0iwXYxLTySfrJvKq9Rso5czGa60W5olxp6XYiZr7GXBMAPufRa93A3KbgpeMrzyoO9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FkEKWHqy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45AF0FOx028937;
	Mon, 10 Jun 2024 15:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6rTfujD1woPMOWzNzRUyk8OfduEpNUC3GdWLs22kUoc=; b=FkEKWHqyUMp61Y+N
	MRTKNb6aXfHQTiEKCqvDt6Md4gs6U4XWYVhtB7W5CiCxVz9lBujisS/2YIyqRb+M
	3PUqyiu+3oORP8oSScmXU/gZm082fIlSv3QvRwmQth64Ka7nNBUaASk5xjS0RhFd
	LR4uUGeQWSjCnPphUZ+Y/Mi5a3Mn1HjmH9aiQ8n4Pb/0sCTxr+I4dHZaGJXRnuHX
	osVpwefgxJ0z5AZt4nuWSpe8sVJmmzqC3eSlMjEvYQS4dWDm5pDoGbdsJUkZ/Kg5
	qJy3LVQJjBJz+ucPPHzXTaFESnCUB7tjvqc1yE/9cBo0tWDq8AzsaxkZcclGJCuF
	y0ebZw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymfp7bsra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 15:47:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45AFlXQ2021339
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 15:47:33 GMT
Received: from [10.48.242.196] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Jun
 2024 08:47:32 -0700
Message-ID: <fc62a3bb-4079-4bc6-ac57-2ae2eed68ae2@quicinc.com>
Date: Mon, 10 Jun 2024 08:47:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/5] clk: meson: c3: add support for the C3 SoC PLL
 clock
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
 <20240522082727.3029656-5-xianwei.zhao@amlogic.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240522082727.3029656-5-xianwei.zhao@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3LAG-p6qLkHcjpWLgpMCATE3coLhT7cH
X-Proofpoint-ORIG-GUID: 3LAG-p6qLkHcjpWLgpMCATE3coLhT7cH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=986 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406100119

On 5/22/2024 1:27 AM, Xianwei Zhao wrote:
...
> +module_platform_driver(c3_pll_driver);
> +MODULE_AUTHOR("Chuan Liu <chuan.liu@amlogic.com>");
> +MODULE_LICENSE("GPL");

missing MODULE_DESCRIPTION()
make W=1 will produce a warning with this file

