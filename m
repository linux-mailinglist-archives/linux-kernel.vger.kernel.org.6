Return-Path: <linux-kernel+bounces-250614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9314592F9E8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958B71C21A61
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF26416CD3B;
	Fri, 12 Jul 2024 12:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JYZmQ3/r"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E34A26AED;
	Fri, 12 Jul 2024 12:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720785877; cv=none; b=f6Ai2IHVfuY404W4kqk8T1psn2LO9DRWVI07bA5pbBpv0hy5LjlR8biRq9bUq4qMqk5T/qjpV/kq3jRRQDY5FyzEkZho5aZltItE3T7Fh/4fMP+OuG7tyYK/sQD57IRd9+sZQj4h+qXDNnnENdYQYyShBAtFK31ZJDloexwiXOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720785877; c=relaxed/simple;
	bh=jzw2SGV82uQ1vD5497lTbv1UI5ZnU3xUCoTjiUj0lfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U67ecw5N0sKFDMhNAczPMDIKZhjr3SENY+/NKud1DiyWe1vU6Djp8x20i96HsX38Ra3PQFJbemcnTIp/8/ydtfWFC39Zdf6eCyuo0tZSAh33uaGaOtY5lCaXK9aXk9Xj3CVfjRvFqhwj7DgHZvWz+THj62jJbqkTCUmWnLZyxEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JYZmQ3/r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46C7CdwE031270;
	Fri, 12 Jul 2024 12:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fXr3MKBWgGky0//+ANaAhEIQCbe9HOXuJ4lR0HDN8EA=; b=JYZmQ3/r8w5RO64S
	ydoWQSqkNtXXb2XnGYK2yZFYOG5QC+mceoyWHGNjfKZ/XEgWMdh3mC3SgMKPutbc
	DEE+I38xkwayw5jIoFd0Z0utRPVblrbrmLoj2rk3EX7rWMXMQDyl0TjEWhrducXt
	d0DL8K6Px2yDYdTgnQQdN5xy6j/z5qibGZX5sTBkqZ/93Y2VA+XQWoLPZu0ai80i
	/3LXMBHVNwpDLaSNcpl5B4w2/wUyK6nkBd0pLe4HiArwSbx+S36wrv32jDGseI9P
	RqD2fZuO7x10ngrB3on471E1oCXf0yJEv75A2zxQ8OvhPQVvDe3tj6SD55XncYJI
	2xf/ww==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40ajbqtbmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 12:04:25 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46CC4O0Y012906
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 12:04:24 GMT
Received: from [10.216.58.53] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 12 Jul
 2024 05:04:17 -0700
Message-ID: <f9dfbbf9-6357-49e2-bed0-f6b0dc71e554@quicinc.com>
Date: Fri, 12 Jul 2024 17:34:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: gadget: Increase max configuration interface to
 32
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jing Leng
	<jleng@ambarella.com>, Felipe Balbi <balbi@kernel.org>,
        Pratham Pratap
	<quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>, <kernel@quicinc.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "Vijayavardhan
 Vennapusa" <quic_vvreddy@quicinc.com>,
        Krishna Kurapati
	<quic_kriskura@quicinc.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240521054257.32689-1-quic_akakum@quicinc.com>
Content-Language: en-US
From: AKASH KUMAR <quic_akakum@quicinc.com>
In-Reply-To: <20240521054257.32689-1-quic_akakum@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9FuoSzWPndoheD9UA11WNfeSF37M9IHT
X-Proofpoint-ORIG-GUID: 9FuoSzWPndoheD9UA11WNfeSF37M9IHT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_09,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=819 bulkscore=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407120082

Gentle Reminder!!!

On 5/21/2024 11:12 AM, Akash Kumar wrote:
> Currently, max configuration interfaces are limited to 16, which fails
> for compositions containing 10 UVC configurations with interrupt ep
> disabled along with other configurations , and we see bind failures
> while allocating interface ID in uvc bind.
>
> Increase max configuration interface to 32 to support any large
> compositions, limited to the same size as USB device endpoints, as
> interfaces cannot be more than endpoints.
>
> Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
> ---
>   include/linux/usb/composite.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.h
> index 2040696d75b6..d6d4fbfb6d0e 100644
> --- a/include/linux/usb/composite.h
> +++ b/include/linux/usb/composite.h
> @@ -255,7 +255,7 @@ int config_ep_by_speed_and_alt(struct usb_gadget *g, struct usb_function *f,
>   int config_ep_by_speed(struct usb_gadget *g, struct usb_function *f,
>   			struct usb_ep *_ep);
>   
> -#define	MAX_CONFIG_INTERFACES		16	/* arbitrary; max 255 */
> +#define	MAX_CONFIG_INTERFACES		32
>   
>   /**
>    * struct usb_configuration - represents one gadget configuration

