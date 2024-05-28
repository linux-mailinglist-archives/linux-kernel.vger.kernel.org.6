Return-Path: <linux-kernel+bounces-192485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128188D1DD4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82384B21132
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC2C16F287;
	Tue, 28 May 2024 14:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lpd2Bp9v"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5FF13A868;
	Tue, 28 May 2024 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716905010; cv=none; b=GAEroJL/9qquvnT/qGh21pyoA/rUMhZQY8uas9mBmr+48eX+Nr3mdDvSS6QAnw7JL2Ye1EKdnFMqA1ZEHEc9dttr/XSves7LldCerdlUs+94rmyGzscFTgVr0iWNP6Jpp+Fd3zwd5JQHJ+3C1Zyh36C/VCbkf1QsrassZkI0g2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716905010; c=relaxed/simple;
	bh=5tCZb5kyea4NJagicMF6cpfIdlu0sHvXpdfA3Z03YnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MHoug2yWm6i1KRSHsfHw7bAu5o23K5RQwVxV5T38AQT4tzzXFohYhc0EhXRuDTSY0wuMtt7JEEZ+qCKf7JnC+chSorVyGIsZl49X+VYD7WHn/a0fvXZCTQDSPnQ+a4iTptfqgVSbSvhaOk+470gks/cxhm0WoW58FiCYvCsr3fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lpd2Bp9v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44SBk8vv022220;
	Tue, 28 May 2024 14:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qf2B6uaVwOzsoHSnptOmqBPxKS/mvVhhFLc7hn4ujoo=; b=lpd2Bp9vr4QSBIlh
	DaKx7lGbc3rAM6mHbYohIazHhC5cGS34GLOmLeS/d93fwBKAI1XEg/KAlKyF4yXt
	Eg525t0jjTM+yaVF2oB5DQVQna09y2EWLTSuAuDQ3DsqRvnAvr/yYKCA+uBvCTT+
	Aze/MrNNzVVFx7e9W/orwCZMMjq0DaYAMH+tYRudg9/JiTs+tln9pZ4ZQWuNBx7N
	lgQB6ArMKrZ1prSHP9CDarIBbfqQQ/yxLZ89ZfywLNX3/MwMycv+lGmvwdHpwYFk
	8H5qayWedmBDpl9Iz+3VpsTlZtT2lJrB0my8qxQ1F+qqxWIEYPdkrh2RaYdpngTc
	7Hj+lg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yb9yj68tr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 14:03:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44SE3DHl010926
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 14:03:13 GMT
Received: from [10.110.122.222] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 28 May
 2024 07:03:12 -0700
Message-ID: <38842d90-f64d-410d-8ef5-6e1d09ff01a0@quicinc.com>
Date: Tue, 28 May 2024 07:03:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: mediatek: Add a module description where missing
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        <sboyd@kernel.org>
CC: <mturquette@baylibre.com>, <matthias.bgg@gmail.com>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <kernel@collabora.com>
References: <20240528121320.160685-1-angelogioacchino.delregno@collabora.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240528121320.160685-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8ONwqeoyukzF1gfyG5FMT2wykvTPWjZW
X-Proofpoint-ORIG-GUID: 8ONwqeoyukzF1gfyG5FMT2wykvTPWjZW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_09,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=711 spamscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405280104

On 5/28/2024 5:13 AM, AngeloGioacchino Del Regno wrote:
> Add a MODULE_DESCRIPTION() on all drivers that miss it to avoid
> modpost warnings.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

All drivers/clk/mediatek MODULE_DESCRIPTION warnings resolved :)

Tested-by: Jeff Johnson <quic_jjohnson@quicinc.com>


