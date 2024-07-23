Return-Path: <linux-kernel+bounces-260304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B57C193A5B9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73151C22188
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE644158A07;
	Tue, 23 Jul 2024 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="moUdw95I"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D866B157A4F;
	Tue, 23 Jul 2024 18:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759252; cv=none; b=csDVtHbI+ElB7Kk4C84WHYN6WUUl2hiKw5ZsAYjrkzWiZ0ydHH3O6yRSTqK9Q4sQsRLD1xQnNz32Z/9X7f2rk3jH6+d9RkmQpBxFIsqm86JBj21nJ7HcCFM/79TxUUTTkh4Q0zN1XRhxaFpLtRwapiGrUE9MbLXYGejcBfhUd1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759252; c=relaxed/simple;
	bh=7HK/DMMkgTcwkTdzzH3kdsFcEBaz2rUtURvULSG77QA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qKW5ZA3Yu7SJXtDGhGEKGlnpeZA7Y/Kk3FFfSJ6Y1uCgjQduRpoyG7PFQGisU89o+Pq9DZCpe2k6z3115d2kaWI5iGs9EobSadIVwlZXyT1YhAuCtTafoxMTKvX2RHJyg6IQR8AzXp11egS/g9KWNMxIEHESDa4QCVR4JwfGQ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=moUdw95I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N9wYKb004696;
	Tue, 23 Jul 2024 18:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fw30OEhuHwCRjgbtq5C9lGL+3YIoOYO6hiSFpsN8Jms=; b=moUdw95IBax6Mzle
	uobuNjz82NHceGOBdzLqvWoxLdUyJLuzZiRsBBZchSNPN1NwbnZ9azeXkzM3dmnl
	u9RkDGwT6vcvKfPIjyftAAv4Q5L+pWXoyxOsAoQnGhD/f+sgCKWJv2dLKChldowL
	swl3HPw016tOAH+vsjfYZqYy0ZI7YM9+xR7rJPf97VDI5MfOZco019lNDtIf20+x
	0QQGTxHcygzi51yUTu/rYDZewqeO3b+OPL0r3EImZuu9ENL2l9WNsWzpTxD5H5+x
	zQB/Gftpl/qXU1BMetxsEIPVF4jvyfDK96VouqLFNheRkm1E4g9AgtX0saDUUqTX
	ee6/kg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g6djyqv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 18:27:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46NIR654026949
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 18:27:06 GMT
Received: from [10.111.176.36] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Jul
 2024 11:27:06 -0700
Message-ID: <13e24ef9-f2e5-478b-8854-0e33a2c497b3@quicinc.com>
Date: Tue, 23 Jul 2024 11:27:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: imx: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Abel Vesa <abel.vesa@linaro.org>, Abel Vesa <abelvesa@kernel.org>,
        Peng
 Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen
 Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer
	<s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC: <linux-clk@vger.kernel.org>, <imx@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240602-md-clk-imx-v1-1-5c6d240f6fab@quicinc.com>
 <171923430571.3352368.17603224359381270285.b4-ty@linaro.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <171923430571.3352368.17603224359381270285.b4-ty@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: F0V6ygj9nRYO0KsyfgvjBakyfc_-5ZuP
X-Proofpoint-ORIG-GUID: F0V6ygj9nRYO0KsyfgvjBakyfc_-5ZuP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_09,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 suspectscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230127

On 6/24/2024 6:05 AM, Abel Vesa wrote:
> 
> On Sun, 02 Jun 2024 08:59:17 -0700, Jeff Johnson wrote:
>> make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/imx/mxc-clk.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/imx/clk-imxrt1050.o
>>
>> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>>
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/1] clk: imx: add missing MODULE_DESCRIPTION() macros
>       commit: 1919d77a9591aa692c8de11540ffc0e7d18eabb4


Hi Abel,
I see this landed in linux-next, but is not currently in Linus' tree for 6.11.
Will you be able to have this pulled during the merge window?
I'm trying to eradicate all of these warnings before 6.11 rc-final.

Thanks!
/jeff

