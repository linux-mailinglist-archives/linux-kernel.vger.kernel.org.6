Return-Path: <linux-kernel+bounces-302845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E65960427
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4FB1F239DF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1DF190075;
	Tue, 27 Aug 2024 08:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mw5T+3sl"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2456B17BEA4
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724746547; cv=none; b=SY2CbntIwNdgXbF1ms2BTg6J2VqeMy2f8MbNMEIF5QOhIICv+jD322NBbk0Sk16759X+hQiGDrrTNGXjtg7g4pBS4bntWlDh57LyrL/rIYdSahzxkpFY5E9CcpnQFVeZ3Qt457yoCtwUTKOOaVoAmAvFjxIOYglZyT7L7lXS7Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724746547; c=relaxed/simple;
	bh=f5yCQfaq3T1r9YsaGWqcZcBSr/TcL0RuFHGw/TIxxFQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ntNkAHQxNphd21GpT1ZjdXl/A983nQI2OufzyW8PxXDyX/xZDN8VwWH96z03fZfI8jMjiCLXzbiqgIIhDgrHDrhyo2v5iAWq9Jxs378d49BAtWSb/aycKPFSSiOrHv1TFg17K6jfcDZ7CQw1rZFNfrs2iyI9fc6d7YMUvbv3Ol8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mw5T+3sl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R1xQ7a015375;
	Tue, 27 Aug 2024 08:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	yTOu2Pf9GhC7wmbivrcb7Ryf3ynPpRy4DC+KmbPykGo=; b=Mw5T+3sl+ka0T0Ju
	eqAq9PVfp8Vf0GWJ/0gxTZTvpnAW6euPeNp34nR1jpk2QK4/OYCwdeOB8q7Fk64M
	311CezMdkijCF4WH4/cSC8ggnE4FEsY5cQa5MLWCyTSNwkoMyZA5t8FUCldG5AbY
	Ho9ZnHH+AQ5sPL0BH901qAQj0cPteTkwvny8PvlIzsEQ4DWJr6CYY0cGmKAIRK5C
	Gu5JMccDe74A9W2Ce5WPW9aQwd+0NLnq10ImO9p7+Q/SfW2eEaWw4Tx3Ol1k3LRC
	+eSLOZ+kcNsGTPgKTryzxauNMTyYgOSXsOcVEbqNiuc1XBD/coONxUFdJ0rHehyj
	HIzPLQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 417g51jmcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 08:15:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47R839DP008239;
	Tue, 27 Aug 2024 08:15:35 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 417v2mhpcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 08:15:35 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47R8FYiM42336720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 08:15:34 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44C7A58056;
	Tue, 27 Aug 2024 08:15:34 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE34258054;
	Tue, 27 Aug 2024 08:15:32 +0000 (GMT)
Received: from [9.43.108.197] (unknown [9.43.108.197])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Aug 2024 08:15:32 +0000 (GMT)
Message-ID: <e561213f-81b8-4582-8009-b542dc06d88f@linux.ibm.com>
Date: Tue, 27 Aug 2024 13:45:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: powerpc: Add Maddy
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
References: <20240827063651.28985-1-mpe@ellerman.id.au>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <20240827063651.28985-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aJ7yhJ2XBUouaq_vRB0cTHSaFX7vLnvA
X-Proofpoint-GUID: aJ7yhJ2XBUouaq_vRB0cTHSaFX7vLnvA
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_05,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1011
 phishscore=0 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408270061


On 8/27/24 12:06 PM, Michael Ellerman wrote:
> Maddy will be helping out with upstream maintenance, add him as a
> reviewer.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 878dcd23b331..0ee724dcc05a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12912,6 +12912,7 @@ M:	Michael Ellerman <mpe@ellerman.id.au>
>   R:	Nicholas Piggin <npiggin@gmail.com>
>   R:	Christophe Leroy <christophe.leroy@csgroup.eu>
>   R:	Naveen N Rao <naveen@kernel.org>
> +R:	Madhavan Srinivasan <maddy@linux.ibm.com>
>   L:	linuxppc-dev@lists.ozlabs.org
>   S:	Supported
>   W:	https://github.com/linuxppc/wiki/wiki

