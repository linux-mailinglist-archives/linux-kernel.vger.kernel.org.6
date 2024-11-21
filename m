Return-Path: <linux-kernel+bounces-417480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 836B99D5495
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1B91F22B95
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 21:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599D41DAC8E;
	Thu, 21 Nov 2024 21:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BmM90W7q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708791B1D63
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 21:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732223813; cv=none; b=W49AvSzZ8rOvFUiY1TOCczsAEDDnphC65o4mceN24Qo83gAikuOk0CjK6klGdjwA4WfI/kA9iTgnFpgNugaJjv4jQKzXxiEvzfXAKTlEzDH/uYNFqWxP/NXk+e6WVdxnZqpa2vhCGDwy/RtCkqKHYUfN5GivUC+loiAzBKp7DEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732223813; c=relaxed/simple;
	bh=/1wFz0sib+rkY8LjdrazAJpAHhGV/iWll7dQQGBkm00=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y3fZL4M1vuq6ubY8pXCmFxTEIHA6RI68Hfn0uF/60sIUYVUu7I+sKjW6RPFNr0OSo/YUBh2OP7283EKaczRvPATiies1hDAHf5zr/e1C4wlxHs6pZFlTvSOLnM+H7eeFYeq3eprnR3DURP4oP5hD0mQd6bi7wL0L8T/7BdIQkkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BmM90W7q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALAwsT9004461;
	Thu, 21 Nov 2024 21:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/1wFz0sib+rkY8LjdrazAJpAHhGV/iWll7dQQGBkm00=; b=BmM90W7qqh+Tw6q7
	uO7rHyWujFl/lPkTDWA6dHThxmEu7icE+NjyTkKNJs5xGy5Z9GLkgK92+1gErUbI
	o7obROwga7JfFvon12/V3PvDQklfyyV/zClgmdCimA4Aiak8O1kJVz7cFSI6M7kC
	ljVI4dv7l7nhj5keVsiiWx9dfFLK5npGG2C5lAtH46BVTiDXBtTLhMYqshB2Chgp
	RJhWvtymQni8fV7P4TNO1EfFf+fVk+ZQ1FJQwC3TaSEYdk3+1KZoPAcHhfYKNjoG
	sm81Gp+g+sAoq105nr/Ur3hPJBxflMk4CGHsvqs1/uoK8J444IfnXw7n6HflNPND
	WxWgpg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431ea74xgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 21:16:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ALLGXTX027010
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 21:16:33 GMT
Received: from [10.111.176.168] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 21 Nov
 2024 13:16:33 -0800
Message-ID: <d72582f0-8262-439f-abe6-14b6352156ca@quicinc.com>
Date: Thu, 21 Nov 2024 13:16:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] firewall: remove misplaced semicolon
 fromstm32_firewall_get_firewall
To: guanjing <guanjing@cmss.chinamobile.com>,
        Gatien CHEVALLIER
	<gatien.chevallier@foss.st.com>,
        Alexandre TORGUE
	<alexandre.torgue@foss.st.com>,
        <mcoquelin.stm32@gmail.com>
CC: <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20241109055049.269163-1-guanjing@cmss.chinamobile.com>
 <cfb1caed-9402-4148-831d-57c50bdf6a27@foss.st.com>
 <1179b3a6-e430-4d9a-8f86-470e8cbe5738@foss.st.com>
 <bee10978-ce12-4813-957d-2d1288f49815@cmss.chinamobile.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <bee10978-ce12-4813-957d-2d1288f49815@cmss.chinamobile.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OUoS1DW_6jEoAX_ryS0u1XDZrp7DfqUH
X-Proofpoint-ORIG-GUID: OUoS1DW_6jEoAX_ryS0u1XDZrp7DfqUH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxlogscore=828
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411210159

On 11/21/2024 1:19 AM, guanjing wrote:
> Thanks for your advice. I apologize for the omission. :)

Please avoid top-posting

https://docs.kernel.org/process/submitting-patches.html#use-trimmed-interleaved-replies-in-email-discussions


