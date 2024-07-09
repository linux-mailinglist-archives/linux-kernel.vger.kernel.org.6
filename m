Return-Path: <linux-kernel+bounces-246618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9CC92C461
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C92E1C22345
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419F5180047;
	Tue,  9 Jul 2024 20:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X6hG75XZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0C413BC12;
	Tue,  9 Jul 2024 20:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720556331; cv=none; b=Y1qJtoHZN7uLhBOTs8XsAjoC9W/mj6M/AsvCb9Dc4wVM6kKvyYmb0KosmOfxc81pz+pFo0JVAlpR9GQYSUVI1DfgV41HvR5UXD/UlKwdMusTK9obW01E4Vd9InMIQ8evx1Egz75M2m4qQ8XEgJoNCbypVIT+eXUYDN2PMsR+XoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720556331; c=relaxed/simple;
	bh=VukW3dPn89v7tpqU5pMeMunT1WLQ6xIJguy4I+fUAwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UOAECG+Df24CJpyRZqEs8znlXlEPE1wEg06EclRK8DJdWWJ4h1cImfi1OhFf/KyLuhnN4POHlEfx8XGGl7z9eVQvegSYegha1wd+NnE62/3wGkUtWlwP3PPTsS/RfgCtBKNDxOZrZmU2+1D8Le1TeNZQOcWaIpKVBSKA5DZrMgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X6hG75XZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469A8iq4031371;
	Tue, 9 Jul 2024 20:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zPJerng+kDc1LY3H2mGFxN66rUQLOcC9lpeQo7I31lA=; b=X6hG75XZt0lNdTyR
	HTtcHtbIJISUPFB5zjrb5wiR1v3sR6WX2q+4NlL02UlBwySsrVlkHPAy42GrAEws
	uZFXd5j3jmUAE/Ooy7PCKuzzGmvB9emtcmEb7tfLSNoZxom37owginGlPNq5wc71
	J7OX3EAcHHws+SBItvj/MFPFmNbN3fTzW4uOkju97EwJFXpFnIr8zFjiv6FcoNtT
	L8L3OeUtt6ejrIFO4vt9fodQfgKsUn1gQb/D1lNLJYR+We8a5k4hIX2xKjbOMzVb
	zv/s0M3FC4lTiXuq9Lfe22uWSzpqNip26XghUOuhZXISCTBxROg+RyjFODUt9lgg
	XoY13g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406xa67de7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 20:18:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 469KIgCa013897
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 20:18:42 GMT
Received: from [10.48.245.228] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Jul 2024
 13:18:42 -0700
Message-ID: <45b5d489-1fd1-47d7-bdb0-2096b8badbfd@quicinc.com>
Date: Tue, 9 Jul 2024 13:18:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mailbox: mtk-cmdq: add missing MODULE_DESCRIPTION()
 macro
Content-Language: en-US
To: Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger
	<matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240624-md-drivers-mailbox-v2-1-e5a428d52224@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240624-md-drivers-mailbox-v2-1-e5a428d52224@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rpvEh_hARBkQhTUwaySMhroGvqAnW6ia
X-Proofpoint-ORIG-GUID: rpvEh_hARBkQhTUwaySMhroGvqAnW6ia
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_09,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090137

On 6/24/2024 9:09 AM, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mailbox/mtk-cmdq-mailbox.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
> Changes in v2:
> - Updated description per AngeloGioacchino Del Regno and propaged the
>   Reviewed-by tag
> - Link to v1: https://lore.kernel.org/r/20240608-md-drivers-mailbox-v1-1-6ce5d6f924ad@quicinc.com
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index 4aa394e91109..71eb78c3d6ce 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -790,4 +790,5 @@ static void __exit cmdq_drv_exit(void)
>  subsys_initcall(cmdq_drv_init);
>  module_exit(cmdq_drv_exit);
>  
> +MODULE_DESCRIPTION("Mediatek Command Queue(CMDQ) Mailbox driver");
>  MODULE_LICENSE("GPL v2");
> 
> ---
> base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
> change-id: 20240608-md-drivers-mailbox-3cd31fdfc4b6

I don't see this in linux-next yet so following up to see if anything else is
needed to get this merged.


