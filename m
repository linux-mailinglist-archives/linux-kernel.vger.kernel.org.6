Return-Path: <linux-kernel+bounces-281130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F23894D36A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B532874E1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6489E198845;
	Fri,  9 Aug 2024 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FeBJurtV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B6C174EE4
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217099; cv=none; b=qRqaoqY0E9SVF5zSHSQVD33Zs4cx5yYWrDRQ3e4g2mYeV/rrkI1JijAsu5iZoX49vqbMq4cabFBLqD/eh3Q4g+k3zdqYXCT1H1AEVPCkuFATOvEPf/lFvCZBl4h5od3Ky2cgkfeMYLB6h/tAHu4nDP1nSejmjzM9zAjiv9IYlog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217099; c=relaxed/simple;
	bh=Kfv8ge7u19PYF7ic2TQOhq0hRwiCTIGkOZvZ+IoWX8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pCvuSKYuxKcU5fsWhrmxW7wpfhYdLHHSYveF368aLcNYiXVuFBqB88j+94JHPBzrJy/jKvQKzT0SKHF6gV9PebZfZ0435AHDBxHbYa+ohEyLCuP13ySW1WV6E+iKY6DBtz1RLVlDlbLuxFMViNZJGdi6WTdk5z8owRNNuMKPr4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FeBJurtV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 479A5XQ1032654;
	Fri, 9 Aug 2024 15:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JQxVezHceu/oVz9HrbF7+G3zxgfmT8Yczs9uuMQBHew=; b=FeBJurtV7gysjZz6
	5d7i4z+0s2gFLnQzBeIt2PRXe2Zo+Gu8f2nqXKT0K365ghSVwft2/leqYNqYWtHT
	BxP0r0f1UxgyJPM0fkNsxiV/g5wjnXh0BOE3VMXTJgSNnFNvmEogLEWK8ntHx1mM
	cBO6lz0y7Y+YH7NvN4aXqcYBxBvBsXTv3hhvemHwjMDZ0czc0xGp5/J41e1fzMPV
	k8y9Zg8lBRP6vOl7voYmtnBe/OiiGxOiX9t4D07B4AZJgB8mFe648nGScQ1QzgTS
	2ToYg4ywMdgaThY3IvoWJtu0saBFwuhQ+Lg4JAhoZBXuDRZsr4H8p/iC6P505m+F
	xPaJMQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40vfav5rpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 15:24:52 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 479FOofS014765
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Aug 2024 15:24:50 GMT
Received: from [10.110.23.148] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 9 Aug 2024
 08:24:50 -0700
Message-ID: <9f017342-b686-4ba0-bb0a-6912b051c152@quicinc.com>
Date: Fri, 9 Aug 2024 08:24:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 01/10] accel/amdxdna: Add a new driver for AMD AI
 Engine
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>,
        Narendra Gutta
	<VenkataNarendraKumar.Gutta@amd.com>,
        George Yang <George.Yang@amd.com>
References: <20240805173959.3181199-1-lizhi.hou@amd.com>
 <20240805173959.3181199-2-lizhi.hou@amd.com>
From: Carl Vanderlip <quic_carlv@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240805173959.3181199-2-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ym8JSr7mrvEhegnRW_fBAFHwV1HpaJlH
X-Proofpoint-GUID: ym8JSr7mrvEhegnRW_fBAFHwV1HpaJlH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_12,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408090111

On 8/5/2024 10:39 AM, Lizhi Hou wrote:
 > +static int aie2_init(struct amdxdna_dev *xdna)
 > +{
 > +    struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
 > +    struct amdxdna_dev_hdl *ndev;
 > +    struct psp_config psp_conf;
 > +    const struct firmware *fw;
 > +    void __iomem * const *tbl;
 > +    int i, bars, nvec, ret;
 > +
 > +    ndev = devm_kzalloc(&pdev->dev, sizeof(*ndev), GFP_KERNEL);
 > +    if (!ndev)
 > +        return -ENOMEM;
 > +
 > +    ndev->priv = xdna->dev_info->dev_priv;
 > +    ndev->xdna = xdna;
 > +
 > +    ret = request_firmware(&fw, ndev->priv->fw_path, &pdev->dev);
 > +    if (ret) {
 > +        XDNA_ERR(xdna, "failed to request_firmware %s, ret %d",
 > +             ndev->priv->fw_path, ret);
 > +        return ret;
 > +    }
 > +
 > +    ret = pcim_enable_device(pdev);


Does request_firmware need to be the first thing here? Its not used 
until the end of init. Likewise, fw image is copied in *_create, but 
then not released until after *_hw_start; could release_firmware more 
closely wrap where it is used? I could see it being checked first 
because if the fw isn't there, what's the point, but that could be said 
about any of the other resources here.

On 8/5/2024 10:39 AM, Lizhi Hou wrote:
 > +enum aie2_smu_reg_idx {
 > +    SMU_CMD_REG = 0,
 > +    SMU_ARG_REG,
 > +    SMU_INTR_REG,
 > +    SMU_RESP_REG,
 > +    SMU_OUT_REG,
 > +    SMU_MAX_REGS /* Kepp this at the end */
 > +};

*Keep


-Carl V.

PS Sorry for double email Lizhi, forgot to send to list.

