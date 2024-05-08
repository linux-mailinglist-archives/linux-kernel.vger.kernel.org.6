Return-Path: <linux-kernel+bounces-173469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F3D8C00C0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CBA01F26F42
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463CD126F39;
	Wed,  8 May 2024 15:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VCPDeGCe"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093111A2C05
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181399; cv=none; b=cUIr3fI9oUvY39HjQNlP2yROIzAHtDrtEO8N0Klby1kvx7hrzTVgElx8fU+9df+YstI9vxFuBIn4aFT6BsUt44bHib46Jbo01iOPQL0X6KwTgM774mEr5hKu3wayB60Gu/VmLp977Kq210eqtoEY4MZaUEfHho74LrtFIF3yXIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181399; c=relaxed/simple;
	bh=1n1JFhMEHpxXbsCLEsA6h7UwWX9ChBNYgtKIrOPkqIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TmzyFUyVOMA9S0jfG6djxSAz9yeXytLWlSphbVws+wU0fyKRwBw7dBnCBKkvVvWDRiP1XhyqUC8U8VvkmqotcIijwRgmNdiorjCKrc2m0o5OuAWda9AuFOZaF2/B01vLiwBbIAxkXMME4UoppDTjRRfMdyUhAvEHb0unV66kDdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VCPDeGCe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 448FCr0B005990;
	Wed, 8 May 2024 15:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=MwULw37PH8betM2DCzv8Tn8ZQugnBHlhkZhXViiVS54=;
 b=VCPDeGCeq4HkyMyB2rFIVhB1y6nhQ4/+KzC3z42WYvWGz4S1GBXZDkJkXtnL3Ke7TZev
 EcDaCiMBf+yi44U5MF6MuLedWFqIOVc5VSwfTN70PGl/UvGXeoAjJ25ZiNf+BuQyMJKZ
 dhea9WymH+QRKwYlNay+uC2Wqfghc5shw0j9QX1lLo33EFOrM4y5kucwtaDtPMsXArbj
 xZzQ4wzjwtimipFaIzUuuJyS1jpgUVJMh3glETe/iQLfvYDaqDEfTnhkuW60ODQCwWpu
 cZPi6ljOfq/bLdKh0ABFfny2Zhs4macqP6maEyXKdrp2brXj3Z+6MBWzYON0mW/zPWBD Ig== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y0btug0ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 15:16:24 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 448F2oms003964;
	Wed, 8 May 2024 15:16:23 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xysgsdcgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 15:16:23 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 448FGFfi23200272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 May 2024 15:16:17 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8BE758060;
	Wed,  8 May 2024 15:16:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C37975805C;
	Wed,  8 May 2024 15:16:14 +0000 (GMT)
Received: from [9.61.25.238] (unknown [9.61.25.238])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 May 2024 15:16:14 +0000 (GMT)
Message-ID: <a924a55d-f591-498d-b80e-4889ed6691e9@linux.ibm.com>
Date: Wed, 8 May 2024 10:16:14 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] hwmon: (ucd90320) Increase delay from 250 to 500us
To: Lakshmi Yadlapati <lakshmiy@us.ibm.com>, jdelvare@suse.com,
        linux@roeck-us.net
Cc: ninad@linux.ibm.com, linux-kernel@vger.kernel.org
References: <20240507194603.1305750-1-lakshmiy@us.ibm.com>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20240507194603.1305750-1-lakshmiy@us.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YQJ3gLj7ikHBfaduKTxWf34CZn-pFDnv
X-Proofpoint-GUID: YQJ3gLj7ikHBfaduKTxWf34CZn-pFDnv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=979 suspectscore=0 clxscore=1011 malwarescore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405080109


On 5/7/24 14:46, Lakshmi Yadlapati wrote:
> Following the failure observed with a delay of 250us, experiments were
> conducted with various delays. It was found that a delay of 350us
> effectively mitigated the issue.
>
> To provide a more optimal solution while still allowing a margin for
> stability, the delay is being adjusted to 500us.


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
> ---
>   drivers/hwmon/pmbus/ucd9000.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hwmon/pmbus/ucd9000.c b/drivers/hwmon/pmbus/ucd9000.c
> index 8d9d422450e5..d817c719b90b 100644
> --- a/drivers/hwmon/pmbus/ucd9000.c
> +++ b/drivers/hwmon/pmbus/ucd9000.c
> @@ -80,11 +80,11 @@ struct ucd9000_debugfs_entry {
>    * It has been observed that the UCD90320 randomly fails register access when
>    * doing another access right on the back of a register write. To mitigate this
>    * make sure that there is a minimum delay between a write access and the
> - * following access. The 250us is based on experimental data. At a delay of
> - * 200us the issue seems to go away. Add a bit of extra margin to allow for
> + * following access. The 500 is based on experimental data. At a delay of
> + * 350us the issue seems to go away. Add a bit of extra margin to allow for
>    * system to system differences.
>    */
> -#define UCD90320_WAIT_DELAY_US 250
> +#define UCD90320_WAIT_DELAY_US 500
>   
>   static inline void ucd90320_wait(const struct ucd9000_data *data)
>   {

