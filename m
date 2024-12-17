Return-Path: <linux-kernel+bounces-448788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A109F4578
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E99D16C6DC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 07:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0C41DA628;
	Tue, 17 Dec 2024 07:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KNkyUYTJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D80C1DA61E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734421685; cv=none; b=Hy86PxVMxJsKLEtjTU25UTJtjShMN/5pYPiDcS8xniRCq3zna8funsi2LnknI5fMWlKoz3O46x8w/vuNFUWMfwc3LgqhoVWGLAl9+nK/L8IRyRr68wiRrov+Q0eQtCo2OK5/rtrmZZN9dEZ+iVu7cTOVbKWlRey4zrHUgtPbn2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734421685; c=relaxed/simple;
	bh=cZnGtLJbS+UcjElCqv3RoFgnceeb+zaBUXxRkxhDFgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XhGdpYtwc/dd7JXu4hSwiB6/GGNK1hV1eMWawiQp//pvyPAJUNz7a49USiFjXHazRYSEDsMqubY5H0wtZJ1zKvUcKGiiiXLAyElN7qi1kwA/KEMImozdIt44pfVFlYDRlT6rwNxoS0rws1LmeMy2ISr7TGd5s+YdOyw7YIty26E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KNkyUYTJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH2wjkT015558;
	Tue, 17 Dec 2024 07:47:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0teF/46Oaov7zdRERb9KE3vehrfRENnvEWwbC7uDJI0=; b=KNkyUYTJa4dWwGas
	neIVHdv0EJj/5mv0oWQBPy5CQfXTHUvpnp1XEFSVBOcB8A8wIl4MoIvmWXMJgXMK
	IRj254DcM1lcgqDNB5x44fpzS0Dmba7WCv7CXhDftU+y439WVJLcSe2vntmbHyqu
	fW9IZTkeFAZENAhkk3vMi778FAB7TWjWtiYmoDJnj9Nfg4Rk9cidwv6F6l7M6KO+
	Ywu9q5O/FZKt12r4lGPg8X8aR8E3+wWaopkUf60Bk+WrJzgreRiAL754TMw/PTmg
	k1fZmRKLfZwVt5dnBkFieFZNdNsw5NtdoS+plozjIBOXwbpZa9nNQIAOZfMc/8Qb
	LvLZzg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43k1060m73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 07:47:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BH7llGw003553
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 07:47:47 GMT
Received: from [10.239.133.49] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 16 Dec
 2024 23:47:44 -0800
Message-ID: <e7ca1f47-8ccd-44b4-bfdd-707a1f8aef13@quicinc.com>
Date: Tue, 17 Dec 2024 15:47:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] arm64: defconfig: Enable STM protocol and source
 configs
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Geert Uytterhoeven
	<geert+renesas@glider.be>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20241101084558.36948-1-quic_jinlmao@quicinc.com>
Content-Language: en-US
From: Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <20241101084558.36948-1-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yhI47qohPhXzufK3x9PGXq1EHxIgAaqP
X-Proofpoint-ORIG-GUID: yhI47qohPhXzufK3x9PGXq1EHxIgAaqP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=976
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412170062



On 2024/11/1 16:45, Mao Jinlong wrote:
> STM is used for logging useful softevens from various entities.
> With STM and TMC sink enabled, there will be more buffer size to store
> the logs. STM source and STM protocol need to be configured along with
> STM device for STM function refer to Documentation/trace/stm.rst.
> CONFIG_CORESIGHT_STM is already added as module. Add Coresight STM
> source and Protocol configs as module so that STM functions can be
> used.
> 
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
> Changes in v5:
> - Update commit message.
> 
> Changes in v4:
> - Remove Ftrace config.
> 
> Changes in v3:
> - update commit message.
> 
> Changes in v2:
> - select ftrace config explicitly.
>   arch/arm64/configs/defconfig | 5 +++++
>   1 file changed, 5 insertions(+)

Gentle reminder for the review.

> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 5fdbfea7a5b2..ac11cd1a7c06 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1599,6 +1599,11 @@ CONFIG_NVMEM_SNVS_LPGPR=y
>   CONFIG_NVMEM_SPMI_SDAM=m
>   CONFIG_NVMEM_SUNXI_SID=y
>   CONFIG_NVMEM_UNIPHIER_EFUSE=y
> +CONFIG_STM_PROTO_BASIC=m
> +CONFIG_STM_PROTO_SYS_T=m
> +CONFIG_STM_DUMMY=m
> +CONFIG_STM_SOURCE_CONSOLE=m
> +CONFIG_STM_SOURCE_HEARTBEAT=m
>   CONFIG_FPGA=y
>   CONFIG_FPGA_MGR_ALTERA_CVP=m
>   CONFIG_FPGA_MGR_STRATIX10_SOC=m




