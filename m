Return-Path: <linux-kernel+bounces-260300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCD993A57C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCD841C222A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD339158856;
	Tue, 23 Jul 2024 18:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ae6o0/+f"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E3E155351;
	Tue, 23 Jul 2024 18:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721758971; cv=none; b=TmV4PSB3tlgdbyGLXxuo7Ts5JOhy1791xebKG8Wz5TpaN7saUjMWXughVkHCW/97IC7MoXCopGM3yho32SMJfhrJvWmnL30Qe8nqijY//4i5BAcxPqUEkjZuD4iNir647hN5fHco6N5020gykDNZBuQKZ4JezvDgCaAC8WjYgFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721758971; c=relaxed/simple;
	bh=vFTjkjzz34xL6L2DBbWWYS8cnZZm2UWeiFpbpLqEytQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BAGUi5nb6ttBObnufCzfvAsuwDnKInXQfwje72Jq//MFgHH7eZ8DpnPxVXQHBD46ZlmNj23aBVA5+ePFl5RB0YkkNwuDWrsH2nwNq/N+MT0O7BLGNuygc/WZGI/f9/hBbFCzgzZ05t2mYadvdKIe5fQVicLx6bt4E09L4hSdUkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ae6o0/+f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NB1reW004602;
	Tue, 23 Jul 2024 18:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UYE0uQURONhbWexZ8yFIhiO/Gq/nGVIY2xkAxGFtJ9s=; b=Ae6o0/+fk3kaqXpB
	L+4Crzcw5F+PMrA3JlmaU8t/3ykpYOZCU/YgHLVYbogVk9e5jGyX/n21Cl65lp7j
	ojQolJstBKo9qNDm3/kcofYVxpYc2mZda9BmK4Q+04tnJ06gRAPZYcvFl275kzL1
	iK0hUr+1rgXqR/A8rD4TuC3tGllDYlRgSHdOzKpBeDb0hvN8QaHuKgQCDLXzrPxV
	d6nnrPvA/E7kj2kzPRdn3WiNRTOEN1wjd2yqpHhV3SdtIczw+oG5SyTRRD/wSVPB
	XL22voq5TvMvRDeK+RolnsWA0GMV5DsXgAgKagVylcR5xeoi3noYMHHb0WaLF5M9
	Kp6qAA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g487fvdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 18:22:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46NIMg7J020285
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 18:22:42 GMT
Received: from [10.111.176.36] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Jul
 2024 11:22:41 -0700
Message-ID: <3f18dc40-ac63-48a3-bf25-66617d37b27a@quicinc.com>
Date: Tue, 23 Jul 2024 11:22:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] auxdisplay: hd44780: add missing MODULE_DESCRIPTION()
 macro
Content-Language: en-US
To: Andy Shevchenko <andy@kernel.org>,
        Geert Uytterhoeven
	<geert@linux-m68k.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Greg KH
	<gregkh@linuxfoundation.org>
References: <20240602-md-drivers-auxdisplay-hd44780-v1-1-0f15bd19f949@quicinc.com>
 <CAMuHMdWCTKBJ5FXeDTD+opJshNk3micT06kea+YRD7WTtqsnbg@mail.gmail.com>
 <Zl4eNFEdrsFmHFq1@smile.fi.intel.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <Zl4eNFEdrsFmHFq1@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kB6ocGvIFI9PVuZxSca_3Yxf6Awed3u0
X-Proofpoint-GUID: kB6ocGvIFI9PVuZxSca_3Yxf6Awed3u0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_09,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407230127

On 6/3/2024 12:49 PM, Andy Shevchenko wrote:
> On Mon, Jun 03, 2024 at 09:55:00AM +0200, Geert Uytterhoeven wrote:
>> On Mon, Jun 3, 2024 at 4:50 AM Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
>>> make allmodconfig && make W=1 C=1 reports:
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/hd44780_common.o
>>>
>>> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>>>
>>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>
>> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> Pushed to my review and testing queue, thanks!
> 

Hi Andy,
I see this landed in linux-next, but is not currently in Linus' tree for 6.11.
Will you be able to have this pulled during the merge window?
I'm trying to eradicate all of these warnings before 6.11 rc-final.

Thanks
/jeff

