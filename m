Return-Path: <linux-kernel+bounces-244977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C91792AC6D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 01:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44701282807
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 23:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F400152E00;
	Mon,  8 Jul 2024 23:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FnnQ8RiF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E74114F9D9;
	Mon,  8 Jul 2024 23:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720480221; cv=none; b=P2q6KjRBsbuQWULwpp1Swq4R21LHmVbER2IKtgjgXCLK3DvLV5iGx72VQxTh5rtYKJ8GQC+Z/0gUEAnc85DUufRcf4LQiQmFVyte36ZIMaUM+ljDFn+zQ/3bLoi9PvOf1l0Rs0lJ9g3BHstthSYz3tXc7W59gWsjkoW+dEh812I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720480221; c=relaxed/simple;
	bh=TtrFMUHs/W2r2VOSo2ppvM/WhSliMAnQyowd3rIp5SY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CKIjLtCl5K8BVpE4sfmj2WGAW+hbD5E0fshqDOHSMfcXdAVO7mFGh6ScHUscxbTWqHQjZ2EI4SyE9r7xDu7vbeIgFHVxrRxQb1WmMXYy3UNoTlM03CkL07kh4JUYMCjHTM13i5GXcwuw3qDgY2TaPCAGIel+pt75a2zkD3sNKhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FnnQ8RiF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468MjaYQ009259;
	Mon, 8 Jul 2024 23:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dy2UesldC4XElGF1LE9xs2PmRBnT4drShFX9fHnwLlI=; b=FnnQ8RiFtxR4b+io
	rMrIm0Pbs2bb/HF4PJ73tYBzJNHs00g0KKZc5OEUTodQ9tyKiVKSL6vv8F4XstLi
	ogquKqr9dhAkbsIYM9pwoCH2YQrmxooeHoSNIXr5r2RuXroehQPcv0CFawylfvQz
	zIWCacyJFFL5V5seLm7/s8zH0DYhWvbTC3VvWunN7h/KBQD3k2I2qr3ZumtM55CU
	HG5+eXU42MfDNyn6ysLqboPuWKALZp1hP5b7SvLlvcZ0z5y3isIFVPYkQy/tMVOq
	6M6H07E/U/juV18GPthuZtYVYc/3JcggUJ1i35mDW3h+m6OhvreW2DgjkzNO16gE
	yI6i2A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wjn500d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 23:10:07 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 468NA6Ye000939
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jul 2024 23:10:06 GMT
Received: from [10.71.109.148] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Jul 2024
 16:10:02 -0700
Message-ID: <5c363e91-581c-4d33-ad5a-154da915b3fb@quicinc.com>
Date: Mon, 8 Jul 2024 16:10:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CMA Regression issue - [PATCH v2] of: reserved_mem: Restructure
 code to call reserved mem init functions earlier
To: Aisheng Dong <aisheng.dong@nxp.com>
CC: Rob Herring <robh@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        Jason Liu <jason.hui.liu@nxp.com>,
        "dongas86@gmail.com" <dongas86@gmail.com>,
        "saravanak@google.com"
	<saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, <kernel@quicinc.com>
References: <DU0PR04MB9299C3EC247E1FE2C373440F80DE2@DU0PR04MB9299.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <DU0PR04MB9299C3EC247E1FE2C373440F80DE2@DU0PR04MB9299.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NQCTMusJS45gloHO2U81phdJdvWkemll
X-Proofpoint-GUID: NQCTMusJS45gloHO2U81phdJdvWkemll
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_13,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=881 clxscore=1011
 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407080172


On 7/4/2024 4:41 AM, Aisheng Dong wrote:
> Hi Oreoluwa,
>
> We observed a CMA regression issue on MX8MN that the CMA region failed to be
> setup by rmem_cma_setup() since the following patch:
> f2a524d9ef5b ("of: reserved_mem: Restructure code to call reserved mem init functions earlier") [1]
> And the CMA node was incorrect parsed (e.g. non-reuseable) due to NULL node pointer.
> Below is one line boot log tested with the tag next-20240703 of linux-next tree.
> OF: reserved mem: 0x0000000058000000..0x000000007fffffff (655360 KiB) map non-reusable linux,cma
> NOTE: actually there is a reusable property:
> linux,cma {
>         compatible = "shared-dma-pool";
>         reusable;
>         size = <0 0x28000000>;
>         alloc-ranges = <0 0x40000000 0 0x40000000>;
>         linux,cma-default;
> };
>
> The root cause was that the CMA region was initialized at a very early stage
> since above commit in question.
> The call flow became:
> early_init_fdt_scan_reserved_mem()->fdt_scan_reserved_mem()->
> __reserved_mem_alloc_size()->of_reserved_mem_save_node(NULL, xxx)->
> of_init_reserved_mem_node()->__reserved_mem_init_node().
>
> The rmem->dev_node is still NULL when calling __reserved_mem_init_node()
> which fails to call the rmem_cma_setup().
>
> Please let me know if there's already a fix patch.
>
> [1] https://lore.kernel.org/all/20240620001027.2326275-1-quic_obabatun@quicinc.com/
>
> Regards
> Aisheng
Hi Aisheng,

I have uploaded a fix here:
https://lore.kernel.org/all/20240708230613.448846-1-quic_obabatun@quicinc.com/

Please test and see if this fixes the issue.

Thank you!
Oreoluwa

