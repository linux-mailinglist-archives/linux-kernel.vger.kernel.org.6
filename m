Return-Path: <linux-kernel+bounces-242647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4F4928ACF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 16:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 697CF283F52
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D9016B3B9;
	Fri,  5 Jul 2024 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A3q++KxQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4145514B064;
	Fri,  5 Jul 2024 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720190184; cv=none; b=qO1jCGzCLy1qTjmwVRoHqnJ2OOG1m6E1uCq6U8NRQ4liXtDL+5ovybTZH9j/2AYVoTGH0EDAE2fBksa0cPkrVq81lMYSp/H2oNYgKm+V19okJkd/+CCadtp+ozCuIXgG5Gv4N/51ZcAq+NmpQglYPTDNhbIrAVagstCTJD6nQJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720190184; c=relaxed/simple;
	bh=S0tflwptBXGv+octHjP8mehHXxa/SQ0wnU0CoKIp+t4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mR4B8mz3w89B+QMhykXO9UhUHZ+JtokdiFUsyyeYP3vgAw3cIArz8YNkQicA0/Iazvo1Rm/H5VRfgGhtE2Jf9EJqOuvc3a7CMvk7pYyrp6+LUtJhdKmt07GMkWabWlz4JXG+rgf7iisE6RulNtEMEdZIS007hywJA2tvBzohHK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A3q++KxQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465AUmSQ012179;
	Fri, 5 Jul 2024 14:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cCPUoud9Du2BcRKWyIRTmehExkmPuKAluuvxNjMwDI0=; b=A3q++KxQUgaOkcLw
	5UJ+Oxtc5fIClcjAALm+7MHhBjbJA8lPx18gtpd/YPIgloyYAya1Y/1zIP0b1+cH
	hGsaXugeOd6Z7GE4kt610Kbokfo9OqjbTy5ONBgkSv/spSF1Jvn4reyeVVVrbV5p
	DL57qOwV6HRL0erWwPHHYVvhWZQdgmKOujhy51Z+dnTjFZZuECWy5DIrzDeDRgeF
	LWUE0I05rztn2yToz7p7DFiOo5iJpa0yxQgSbvmONSWJXXA2EIQaPvKZMmCl6Dst
	bIlBw/FcJ2sFytNHaftP6uDjBCkwkAXprwbaRZ8FGv8NqZylfYRRFp5HX8UMhA+6
	2/uNvg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 404yjhxu67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jul 2024 14:36:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 465EaFfd020081
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Jul 2024 14:36:15 GMT
Received: from [10.48.246.40] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 5 Jul 2024
 07:36:15 -0700
Message-ID: <fba80871-645f-4d8d-8992-424812e51cef@quicinc.com>
Date: Fri, 5 Jul 2024 07:36:14 -0700
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
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9xs2seuMWbBQSa3FyYHrpTYu-wvLmv7r
X-Proofpoint-ORIG-GUID: 9xs2seuMWbBQSa3FyYHrpTYu-wvLmv7r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_10,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxlogscore=817 clxscore=1011 lowpriorityscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407050105

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
> 
> Thanks.
> 
> Johan
LGTM, thanks for the cleanup!

/jeff

