Return-Path: <linux-kernel+bounces-307878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B4F96544F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 02:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901431F264F8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 00:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A5BEACD;
	Fri, 30 Aug 2024 00:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G8V+SsEW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2780F23BE;
	Fri, 30 Aug 2024 00:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724979500; cv=none; b=RYWJcLmgszAGOtW/DXg31T1kCnI4Fn36eaZxGJCslEYSNHHgOc/UvAJUX0BFh9xlEaMwFrj1bYeon4Z9gZNzI5shEHfoPP+B9ek+Ml05s7rBqbzDZ4Xxlrh4KPvb3ojGUWp0t13d/QD6hzcV5QmGYQ35MF0GOXiHZQHk06PY23Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724979500; c=relaxed/simple;
	bh=x3PkcUYbk93wlv0T8Lo2vEKgSgWzq8eNSQhUcpy26JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U6nmt0pN/ZhpwTBBhTvECouUT0vkiw6sQa/QTRlYNO1Pe1r/WEj8ztOiPLsDsT7T4RyR1k6mA8XPGQcUirhR/oN0ZpX86Z6dwVEBubbQEPs3tILg/jBQiNrmpd62Xbd+YijKnjLTmDqZjknKt7odcXg5hXkxzMGXw1W4rryh4uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G8V+SsEW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TGoTlK012453;
	Fri, 30 Aug 2024 00:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/WHiyZwuFXaUdRDCgl5OHcim/e2B56+x9mCP/4nGyAI=; b=G8V+SsEWUbmmH+ZQ
	wM2LjTxIgBFxUDTZDZcEEzQi6vHJfGBNbfxo3MKtiGTDyr1ZfUpL9UOBGbqsB77j
	HErvbQ/g2ZOxRy45/CgAmEbIYZxHA9uKcGXbuyq/VZ0CyL9XZNq7qG8r3/ApNh6m
	5OYrQP2ysWAsS5DLJO0EqalKuCiFYe7+yefu5GCNp5L13tNfarwJdBTHkvw8wX1v
	+C1QLDpSi8cWPPVGkHhU6PV5sU4xDNSVs8nOI4X8BzjMOj8Wo/l7Xc1+rlgTlo0Q
	JdkN1nNhPnEwhWPiSKQOsu6R/3Tt1KbT+tfuQzlOmUbwEfOt22dzqub1y35elf4q
	oJ5jaQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419pv0q43q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 00:58:07 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47U0w53F026871
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 00:58:05 GMT
Received: from [10.111.142.110] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 29 Aug
 2024 17:58:01 -0700
Message-ID: <958333ec-a636-4eee-a582-0b26daf5856e@quicinc.com>
Date: Fri, 30 Aug 2024 02:57:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] usb: typec: Add new driver for Parade PS8830
 Type-C Retimer
To: Abel Vesa <abel.vesa@linaro.org>,
        Heikki Krogerus
	<heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Sibi
 Sankar" <quic_sibis@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        "Dmitry
 Baryshkov" <dmitry.baryshkov@linaro.org>,
        Trilok Soni
	<quic_tsoni@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20240829-x1e80100-ps8830-v1-0-bcc4790b1d45@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <quic_kdybcio@quicinc.com>
In-Reply-To: <20240829-x1e80100-ps8830-v1-0-bcc4790b1d45@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cg7TzyTvItGoD-p8egykMd1xzKGUq5oE
X-Proofpoint-ORIG-GUID: cg7TzyTvItGoD-p8egykMd1xzKGUq5oE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_06,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=671 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1011
 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408300006



On 29-Aug-24 20:44, Abel Vesa wrote:
> The Parade PS8830 is a Type-C multi-protocol retimer that is controlled
> via I2C. It provides altmode and orientation handling and usually sits
> between the Type-C port and the PHY.
> 
> It is currently used alongside Qualcomm Snapdragon X Elite SoCs on quite
> a few laptops already.
> 
> This new driver adds support for the following 3 modes:
>  - DP 4lanes - with pin assignments C and E
>  - USB3
>  - DP 2lanes + USB3
> 
> Only DP 4lanes and USB3 modes have been succesfully tested on
> Qualcomm (X Elite) CRD and Lenovo Thinkpad T14s so fat.
> Devicetree patches for these 2 boards will follow.
> 
> The DP 2lanes + USB3 is still work-in-progress as it might involve changes
> outside of this retimer driver.

Yep, it's the QC combo PHY being grumpy, this one's fine

Tested-by: Konrad Dybcio <quic_kdybcio@quicinc.com> # x1e80100-romulus

Konrad

