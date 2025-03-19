Return-Path: <linux-kernel+bounces-567184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AB2A682FE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 03:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0A73B511C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 02:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7832C20C46A;
	Wed, 19 Mar 2025 02:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e1a5CJqk"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A853F9D5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 02:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742349993; cv=none; b=Hno/Nqg94/72d+GoMplqTwBoChjr0YDEZwxDFUDuBdW6FNytuGXxcf9kqXzNAmQN/aAjhrVlk6jFgYNwKW7jTWKXoEwv7Og1DZFu4GdaI/12QFHqsg3TlKe96C0ck1LSkqMo+TOw1GpnEL+UBHZ+Ajdr79vfH+lIh2zbknYXlPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742349993; c=relaxed/simple;
	bh=KuV+TwESU7NPXT+oT8YHECWcJGul3fY6qbk8rvb8H9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q05XB6e4EtPqclxdqYucqmWzqymOsH85vP1Z/CsnRD3AcwgDooc73+Uljl9RmM711Irr7PYSukJL2C55HZNx/1btd3P+TcxJrLYb/ISyzOt71BL+ml6Gp4b/75D/0/tEgDsjsAMwWoY2RabPBHJfdeMjdDiiU2TLfdTPoWFvBjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e1a5CJqk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IKqsJm015381;
	Wed, 19 Mar 2025 02:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TpO5zM
	WHSqnsfVEXRxj22SIw7P54O7quVzaG6vmYJ2Y=; b=e1a5CJqkGZLd4d3Sq9ny9I
	hkeQ8RmGvrCBp6rcmovYxMGjxx4fcap/w2IsgrEYy/BEBDMPvRd5Scv9j2xbcofu
	HeBrA7pnx3j68d1slqxuxwMEkyJ/m1C3caW6RFIxwW2x4EGDf+gbblY5VuS2fhTO
	2MsWN8NTqeuEqY6DzPx1DTHr55SpedykKLyFp44SByikluN4WJSwJqUp1H5TAiRG
	cC4p4JEzxof65f7pADe9Yo1kgdbtx/kFTRFwhs5IVhKqqWsA2W4kTMB/s0TZrbyq
	tks+sCDBqztES9Hp1K4X0Fx2yiwkH04GwVmE1YQQBwb5kjqFo2qh7TRmVM1Yco0w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fg87h03h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 02:06:09 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52J23Lra022340;
	Wed, 19 Mar 2025 02:06:08 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fg87h03e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 02:06:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52IMeCwQ005741;
	Wed, 19 Mar 2025 02:06:08 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dpk2erbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 02:06:08 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52J267JA17629932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 02:06:07 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2399B5805E;
	Wed, 19 Mar 2025 02:06:07 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5D345805D;
	Wed, 19 Mar 2025 02:06:01 +0000 (GMT)
Received: from [9.43.115.80] (unknown [9.43.115.80])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Mar 2025 02:06:01 +0000 (GMT)
Message-ID: <952dbc9c-f720-4a66-b083-27b9c6fa82db@linux.ibm.com>
Date: Wed, 19 Mar 2025 07:35:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/prom_init: Fixup missing powermac #size-cells on
 i2s nodes
To: "Rob Herring (Arm)" <robh@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>
Cc: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250318192256.3534046-1-robh@kernel.org>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <20250318192256.3534046-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ueaK4xiw1esXU2b_ia4JMmc7Q1gHdJkC
X-Proofpoint-ORIG-GUID: 1vmI6gwI_RgPA_AMK8ilQ_ZZD3dbv9ia
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_10,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=972 bulkscore=0
 malwarescore=0 clxscore=1011 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503190012



On 3/19/25 12:52 AM, Rob Herring (Arm) wrote:
> On some powermacs `i2s` nodes are missing `#size-cells` properties,
> which is deprecated and now triggers a warning at boot since commit
> 045b14ca5c36 ("of: WARN on deprecated #address-cells/#size-cells
> handling").
> 
> For example:
> 
>   Missing '#size-cells' in /pci@f2000000/mac-io@17/i2s@10000
>   WARNING: CPU: 0 PID: 462 at drivers/of/base.c:134 of_bus_n_size_cells+0xb0/0x120
>   Hardware name: PowerMac3,4 7400 0xc0209 PowerMac
>   ...
>   Call Trace:
>     of_bus_n_size_cells+0xb0/0x120 (unreliable)
>     of_bus_default_count_cells+0x40/0x60
>     __of_get_address+0x158/0x294
>     __of_address_to_resource+0x48/0x258
>     i2sbus_probe+0x564/0x85c [snd_aoa_i2sbus]
>     macio_device_probe+0x60/0x108
>     really_probe+0xd8/0x344
>     __driver_probe_device+0x90/0x1f0
>     driver_probe_device+0x40/0xf4
>     ...
> 
> As there's already a fixup for the same issue on `escc` nodes, add
> `i2s` device_type to the existing fixup.
> 
> Reported-by: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Have already picked up this patch as part of powerpc-next. 

https://patchwork.ozlabs.org/project/linuxppc-dev/patch/875xmizl6a.fsf@igel.home/

Maddy

> ---
>  arch/powerpc/kernel/prom_init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index 57082fac4668..69018a2afc41 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -2889,11 +2889,11 @@ static void __init fixup_device_tree_pmac(void)
>  	char type[8];
>  	phandle node;
>  
> -	// Some pmacs are missing #size-cells on escc nodes
> +	// Some pmacs are missing #size-cells on escc and i2s nodes
>  	for (node = 0; prom_next_node(&node); ) {
>  		type[0] = '\0';
>  		prom_getprop(node, "device_type", type, sizeof(type));
> -		if (prom_strcmp(type, "escc"))
> +		if (prom_strcmp(type, "escc") && prom_strcmp(type, "i2s"))
>  			continue;
>  
>  		if (prom_getproplen(node, "#size-cells") != PROM_ERROR)


