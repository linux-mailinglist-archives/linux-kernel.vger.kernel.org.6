Return-Path: <linux-kernel+bounces-350901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 082BF990ABF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32691F2321A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F481DAC8E;
	Fri,  4 Oct 2024 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZBOpzVOh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F3F47F5F
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065295; cv=none; b=sGGTDgiUEuirX/fkcDk4roZVWzztIPX266rUmvL+eVBZ49s4abCOgK9E5zq+kpssX+71ZBYazvp+gS5TWb2V+HRLEoqGBM+s0jCUubKObjxCSM94iaEdGNHtKZ9xb6K5QUCwIZMHXwnygZvXXF/gfC7qTntGOKhDBoZFFvOWsv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065295; c=relaxed/simple;
	bh=wYPflgd1ybEdWikH4catwh/Hx8dom7saLAa8vbMooLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DxbpLY5bkk0C7DpX0dRmaMxmwSAjWqA/mPcuQD6xZ9W/kmXDub7VsmnOkczw8lnEwAcReSNlZ7J/NXVL79ochDzqj57FA13gvbIsHm6P+60DXnhWYfoC7A86ij06zwVgDjczqO/T8njIbkBEjZS8fD6RiHrDomjSwdk8PtcYDRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZBOpzVOh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494ALgD1031149;
	Fri, 4 Oct 2024 18:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y4QC37OxQXSNGhOjdjZvbGKEKAY7MLVfsRD4BEm29tk=; b=ZBOpzVOhW23l2CRZ
	/MDGdSpR6yPXfixE7UR31e5JmF2XFO/7jiCorkzwkmntx2i0B94iERW0hZxmjnK6
	tqsxJm2kSrmhHlKWYXzkMzGDMJjZoRRUpNSFFT4Kkdp9pAswjUINkitsHRs1eZci
	YT2SvDWljwy94u0ILnPmZw49zgY1BSzhEjue5Z/zgSrNCR70mvjDaaaEgQoPEGzT
	QJMgURxENvYk1EIUtXzdLe2OL08Jc2BhuswB8VSMuXQY2mD6iCKDwB2Wu0TFtlx0
	c526papYDJpSN9+kMKXaZuWNsdxT5GtZvF+bILbZQ6KTXWds0rsNP8MATZi5Ne4/
	GcLIZA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42205njwfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 18:08:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 494I86Ub011485
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 4 Oct 2024 18:08:06 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 4 Oct 2024
 11:08:06 -0700
Message-ID: <fd84e624-a534-26a1-a434-3c8390bbb311@quicinc.com>
Date: Fri, 4 Oct 2024 12:08:05 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V3 08/11] accel/amdxdna: Add suspend and resume
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>,
        Narendra Gutta
	<VenkataNarendraKumar.Gutta@amd.com>,
        Xiaoming Ren <xiaoming.ren@amd.com>
References: <20240911180604.1834434-1-lizhi.hou@amd.com>
 <20240911180604.1834434-9-lizhi.hou@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20240911180604.1834434-9-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hrFOmLt4ScfA4mm4fiOB8Sl_OzoaWU-4
X-Proofpoint-ORIG-GUID: hrFOmLt4ScfA4mm4fiOB8Sl_OzoaWU-4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 clxscore=1011 phishscore=0 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410040124

On 9/11/2024 12:06 PM, Lizhi Hou wrote:
> +static int amdxdna_rpmops_suspend(struct device *dev)
> +{
> +	struct amdxdna_dev *xdna = pci_get_drvdata(to_pci_dev(dev));
> +	int ret;
> +
> +	mutex_lock(&xdna->dev_lock);
> +	WARN_ON(!list_empty(&xdna->client_list));

This feels weird. Can you explain?

> +	ret = amdxdna_dev_suspend_nolock(xdna);
> +	mutex_unlock(&xdna->dev_lock);
> +
> +	XDNA_DBG(xdna, "Runtime suspend done ret: %d", ret);
> +	return ret;
> +}
> +

