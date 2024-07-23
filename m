Return-Path: <linux-kernel+bounces-260323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ABB93A744
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC540284325
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751EC158A29;
	Tue, 23 Jul 2024 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mdT6sQWM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777C1158873;
	Tue, 23 Jul 2024 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721760250; cv=none; b=l5zk0aRLsweZZyAuoGvzFPbXgcR/MBn24uu0Ee+RXBIH58yV9nDOSf/pZYBNDOODBqWeJytNv5stv7nqY5ww6MKidJEZYpQj5zDh7MvQB06hq303UgzN4f86Mouv3TDASUVexvGmVd8bx7z+1+ytunp5+ntaENY40AgEIJeG5NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721760250; c=relaxed/simple;
	bh=GpityV/7iR5+t+2TQIMKZ3ofyVjPPZdiPXgbRKnY9Uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f5/DvyolVcWvM/AyCxfdQeotEk+PsyQznwHmgL3RLebU03GugJhTdGnO56cDBuDQgMCvgoXve4KokvVZOveMPMWiJYr8qH7cuw38sQXQuWrt7RlXLTdGPM2lB2d35tvo0NgWpp7ltftasdrt2dOhxzmhMjCcVdvUC6Zd3Iz0nNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mdT6sQWM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NApvMm014983;
	Tue, 23 Jul 2024 18:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AZowfvYhAXkeXT5NOjpoBiLrslsFgacpUQRuPZlreUM=; b=mdT6sQWMcRgB63M8
	SCvp6m0gozC8IfTYqgfbAy3EGu6oYOX+TR82oQl+5smYAtru/NYYa33ZjPLc5K1M
	x6lhcm25nSYJqPWMiNB73hj6eb8gq2QkjjVY3Ow3K4mciM+7gtcr/vhVHDXVmPoL
	CAm495nu+1PlTn4kg5cEFW/2qluuwKJkqX1dp6hspolVBGtZi6JUFLOPftLszz7y
	j7Rk/yqQ4gNwwOJjuAPGHnks69fa1eaYn5vdoUu0MBhXrQQzlXqZQdwY7NgCgH23
	Ss1w4ajeKvNCF6M75doDPXwp/2PAOrAHkFIwm5HPtW3SlRUdvjoupiRgGP8AEpau
	5e7c7Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g6djyryw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 18:44:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46NIi5tO016589
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 18:44:05 GMT
Received: from [10.111.176.36] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Jul
 2024 11:44:05 -0700
Message-ID: <108d8399-9b09-4a1d-8424-a6fa69b63d77@quicinc.com>
Date: Tue, 23 Jul 2024 11:44:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: serial: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Johan Hovold <johan@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240611-md-drivers-usb-serial-v1-1-c6ada535890a@quicinc.com>
 <ZofajSjhaaZsFRro@hovoldconsulting.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <ZofajSjhaaZsFRro@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -_NOaTg5WBAlzQOiObOjMopQ58pD6C6C
X-Proofpoint-ORIG-GUID: -_NOaTg5WBAlzQOiObOjMopQ58pD6C6C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_09,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230130

On 7/5/2024 4:35 AM, Johan Hovold wrote:
> On Tue, Jun 11, 2024 at 10:52:54AM -0700, Jeff Johnson wrote:
>> With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/ch341.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/usb_debug.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/mxuport.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/navman.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/qcaux.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/usb-serial-simple.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/symbolserial.o
>>
>> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> I amended the commit message with the (recent) commit that added this
> W=1 warning (and dropped C=1). I also tweaked three descriptions
> slightly. End result is here:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/commit/?h=usb-next&id=9f4dc05107a6db3743e6b9ea4014cbdc3795682d


Hi,
I see this landed in linux-next, but is not currently in Linus' tree for 6.11.
Will you be able to have this pulled during the merge window?
I'm trying to eradicate all of these warnings before 6.11 rc-final.

Thanks!
/jeff

