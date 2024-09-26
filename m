Return-Path: <linux-kernel+bounces-340204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34006986FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2611F22E4A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103021AB6D9;
	Thu, 26 Sep 2024 09:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YdPmMLa1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BE41A725B;
	Thu, 26 Sep 2024 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342278; cv=none; b=WwbNR2MwBx0fOJBRuIHXAzhC5UxaTJT7S2Q/hA/C7b/K1e0+QBp7WXEFfVK3n/Ep/xFG+F1hTBLzimtWSmpmP5NMYnLjUHLiVLUyMN+pQy2eGcjiPX/mus72A0uVi7m8qSM5DQV5e7l6CdtL9N6lamb3hlhoEhv2N+d735jHIt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342278; c=relaxed/simple;
	bh=76GpQGhZkjCfeWetiWnAHeNT+12jlVPIrvWNY9KtHR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EpOZQ4JPX/pAH0fhkQgnMDn7lkOwmQugWpFZ2gOfryTA/LhMR1FnAkFcoRs7WYBCQyF+U6SAGPq4gqVn6uiAudrY0+9nhkMOuzkZ30ea/Hj/kDGw3grbAm1nUOzczynJvg45F0K+/biHpCshtfqnnZf6C4ZknZluPROV3u0oogQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YdPmMLa1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48Q79e9r013247;
	Thu, 26 Sep 2024 09:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4exlecG3IZ7kuJZJ1pDRlY7GYiLMuCNgLguFE+VUoLY=; b=YdPmMLa1inknWNCf
	YxI08T5vSu1YQ78qMMcbjB+7nVPjEEqR8Jd+G5fgcT4BpklQP+UFpVufrueRyvwb
	y78jos97ZD5ihllYofaZRnDAxMC+nhkeBuD1iAaItPC1h1ESBcFL8q+L4LmtwKNz
	cWv5vMGDAGHUE/IBGMIi/rqo/oLScmHmVpeFY31cyM0fagJ+q+6ndjA04inKnvqS
	YlrsBxzka1ME4ash4FpPu/M6XcuoemlYQXWUbTAX0eBkzm8gd1B23M7sQQuRbDTs
	ddGHasimp+rfmXCQpeJBVU/T2VB5EbWa47Z1ykiyTuEdseU2qgkVpfO0mMjl3L1j
	G/m96Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41snqyq16t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Sep 2024 09:17:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48Q9HaNw015961
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Sep 2024 09:17:36 GMT
Received: from [10.218.35.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 26 Sep
 2024 02:17:33 -0700
Message-ID: <54cfad7a-9b54-4114-9c2a-1f8600b65460@quicinc.com>
Date: Thu, 26 Sep 2024 14:47:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: u_serial: fix null-ptr-deref in gs_start_io
To: hbuczynski <hubert.buczynski94@gmail.com>, <balbi@kernel.org>,
        <gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        hubert.buczynski <Hubert.Buczynski.ext@feig.de>
References: <20240926064910.17429-1-hubert.buczynski94@gmail.com>
Content-Language: en-US
From: Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <20240926064910.17429-1-hubert.buczynski94@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fXzLjA0kWrPn-Pu6qM530cJiYfXfmWAm
X-Proofpoint-ORIG-GUID: fXzLjA0kWrPn-Pu6qM530cJiYfXfmWAm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0 mlxlogscore=674
 spamscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409260062



On 26-09-24 12:19 pm, hbuczynski wrote:
> From: "hubert.buczynski" <Hubert.Buczynski.ext@feig.de>
> 
> The commit "5a444bea usb: gadget: u_serial: Set start_delayed during
> suspend" caused invocation of the gs_start_io in the gserial_resume.
> The gs_start_io doesn't check the ptr of the 'port.tty'. As a result, the
> tty_wakeup function is passed on to the NULL ptr causing kernel panic.
> 
[...]
> 
> If the device sends data and does not receive msg from the host then the
> field port->read_started contains a positive value. After disconnecting
> the cable, gserial_suspend() is invoked and the port->start_delayed is set
> to true. Connecting the cable again causes invocation of the
> gserial_resume().
> The callstack after connecting the cable looks like the following:
> gserial_resume()
>   --> gs_start_io()
>     --> tty_wakeup() - with NULL argument
> 
> Fixes: 5a444bea37e2 ("usb: gadget: u_serial: Set start_delayed during suspend")
> 
> Signed-off-by: hubert.buczynski <Hubert.Buczynski.ext@feig.de>
> ---
>  drivers/usb/gadget/function/u_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
> index 5111fcc0cac3..384f219fe01d 100644
> --- a/drivers/usb/gadget/function/u_serial.c
> +++ b/drivers/usb/gadget/function/u_serial.c
> @@ -564,7 +564,7 @@ static int gs_start_io(struct gs_port *port)
>  	port->n_read = 0;
>  	started = gs_start_rx(port);
>  
> -	if (started) {
> +	if (started && port->port.tty) {
>  		gs_start_tx(port);
>  		/* Unblock any pending writes into our circular buffer, in case
>  		 * we didn't in gs_start_tx() */

Commit ffd603f21423 ("usb: gadget: u_serial: Add null pointer check in
gs_start_io") fixed this issue. Please try adding it into your builds.

Regards,
Prashanth K

