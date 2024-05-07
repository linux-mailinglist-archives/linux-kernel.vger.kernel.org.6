Return-Path: <linux-kernel+bounces-172020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 621C58BEC0B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178471F233F7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422A316D9DC;
	Tue,  7 May 2024 18:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V9RoUkwg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B3D14EC5F;
	Tue,  7 May 2024 18:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108270; cv=none; b=JAQuKQGfAGHyEPWSzz0wWE3kyGpeiaVI4FXIhA5RHMWFCzJHqg8RKTHHZ4HE/jO8Rji3dcRLDtDUbtc9aNRBc/0IATM4ym8uV8ojdFpaxrqfOFQwBrRevy74C/cvNM46jZ+jaJCOl4J36gJBFnypDoqa1OiCwzxYdkdaPo6Ormg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108270; c=relaxed/simple;
	bh=tNOdKmg7Xx1blxwo8VN7+j2M0OCqSHxIvoDIUgjRaTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mGhEt9UI2MZvfYnskVVc9s4uAAwOhhcTLu20vWpBkHVRn8bTaUL0c/oDb2O6pdHecviiGPqizLwgwZoym1Z7tsvAfs8qhY2KoVZSHiS+1NeEdfo/eqxnNdMXzdVIFoj/BV0wYgxoYzWtV0pIkSuAE07Jy2FCRYAtJrCaHSVtt7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V9RoUkwg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447ILYs2014925;
	Tue, 7 May 2024 18:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=iGvhz58MppoipnV7yjkVm9lgEZdDmugeunZltlfL36c=; b=V9
	RoUkwgETbPUNkI45ve7kOOXp640GIULbDSqgSIdv3PjZeqkrHvZ0XxyVsEu1SxzU
	AoMt9RVGrGTr6EcfB1m1vApLJDASO4tbRDiElEZ8MnpWXEWRJc+1TXCOPUw7I//K
	6+7G6SLKXJdeyzXpsTs0nrb4Fxf+AvAPMcksgzaB/9udT0hRdBCgzINkp5wGYfoS
	F5d1/5z3SoIb1TahxUWZYDZcTKrojhX/kPaNeVkFu8dPAv8SgftMRbcco+kY8M+P
	NKM7Yp0wJXzqtiSXHqPFaLsxYSUdwZLV6coObeQqDnzzFk432RarE/18vSf6L50J
	T9rTwIQ5eg2HQRtPuBUA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xysgc82t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 18:57:42 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 447IvfZI007564
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 May 2024 18:57:41 GMT
Received: from [10.71.112.114] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 7 May 2024
 11:57:40 -0700
Message-ID: <518a046b-1056-287b-f505-149958ad9c9c@quicinc.com>
Date: Tue, 7 May 2024 11:57:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] usb: dwc3: gadget: create per ep interrupts
To: Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <michael.riesch@wolfvision.net>, <kernel@pengutronix.de>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240507-dwc3_per_ep_irqthread-v1-1-f14dec6de19f@pengutronix.de>
Content-Language: en-US
From: Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <20240507-dwc3_per_ep_irqthread-v1-1-f14dec6de19f@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YWCxCUKrPKzorRXLBQXvxvY1q6OHF7hq
X-Proofpoint-ORIG-GUID: YWCxCUKrPKzorRXLBQXvxvY1q6OHF7hq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_11,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 mlxlogscore=564 mlxscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405070133

Hi Michael,

On 5/6/2024 4:06 PM, Michael Grzeschik wrote:
> This patch is splitting up the interrupt event handling from one
> interrupt thread to separate per endpoint interrupt threads.
> 

I assume that the incentive from doing this is to improve overall 
throughput numbers.  Would you be able to share some data on the 
benefits of moving to per EP event management?

> To achieve this we create a new dwc3 interrupt domain in which
> we map all claimed interrupts to individual interrupt threads.
> 
> Although the gadget layer is preparing the claimed parameter
> of each usb_ep which could be checked if the endpoint is
> to used or not, the claimed value was 0 for each ep in gadget_start.
> This was tested when describing some composite gadget using configfs.
> 

yeah... the claimed flag is cleared by the USB gadget, ie USB configfs 
(not sure if you're using this) whenever it adds a USB config.  This is 
to handle multi config situations, so subsequent USB configs can be 
assigned (resuse) endpoints, since only one config is active at a time 
for a USB device.

This was a struggle for me as well when adding the TXFIFO resizing 
logic.  We won't actually know which EPs are going to be used until the 
host issues the set configuration packet to select a config, and the 
set_alt() callback issues usb_ep_enable().  So the implementation 
(TXFIFO resizing) is currently based on the maximum potential endpoints 
used by any USB configuration.

Not sure if having 31 (potentially) different IRQ entries would be ok, 
but maybe it would be simpler to just to request IRQ for dwc->num_eps 
always?

Have you tried this on a multi config device?

Thanks
Wesley Cheng

