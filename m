Return-Path: <linux-kernel+bounces-336734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98442983FFE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E7928669F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C0714A609;
	Tue, 24 Sep 2024 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YBniJEN1"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4CA1803A
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727165374; cv=none; b=dIqtjmPhqVgOYSwm6c8bR71AG3rDZfLy2L7fTH4kO9KTL8+p6epklHiPHeP77vO5Ywt90RVSzj4eQzqbg8aVu3fm/lQWXawS7iZ6afjXVL2MSZR6kPNxzeh6x9R1CrhLdTEGyCmGFd9mYzIqAu4Wfn+4hm4oMaMn6pufzJ/mnb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727165374; c=relaxed/simple;
	bh=oILC7b+VYGL8iCjP4snxl26072XF0sliYpvFhTTwAnw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KFewt1C4J4wGPmlgrPxXXw7//tYypjajidNkJGZd6NsN6zvxrjyvHWkAJp4Nnz1nmyNp2Dz9zBnlGr+HF3lS6XJSrPmb9ijcjeC0jGslV3lWcCtNROC007yYqaTrO8MFGSfXuq1Q7RaD0BqlCEVjPvV5bUsl19dToQx/MB6uL5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YBniJEN1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48O0UpkL022399;
	Tue, 24 Sep 2024 08:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	oILC7b+VYGL8iCjP4snxl26072XF0sliYpvFhTTwAnw=; b=YBniJEN18BSR4PyP
	NkiZBLnRIXbeyy1Raf881XPhuG5N5G7GhM7FCpAM8JVTFFZb1Y1TdjIJIRH8mUuI
	pJe2f8hEdBv/XnUOPlCfP0DDhmoT2T7ib+EKl5sXQpBBDKlWEuXBLpdGxRekJc+Q
	1ADohLg4Np48nhD2w1QKj5wFEqktFokuyk5GqLeHv5KL1GyShYAXhMkqzbK00hA7
	tGEAXk/wQlpnzG/yOwIN3Bqzl0o1E5Q/r+WBO2GIomPIjnodxy2Znln5i86VPEKF
	aCKxNQ0MaFYBQTgvYMaBxHGSBZQCfZqP+e8OUilF+ChdEnM5x3m903x9y8CZcczg
	ikBkhw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41skjrgmn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 08:09:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48O78p5s000668;
	Tue, 24 Sep 2024 08:09:08 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41t8fujx7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 08:09:08 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48O897rG13107934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 08:09:08 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97DB558059;
	Tue, 24 Sep 2024 08:09:07 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1139A58057;
	Tue, 24 Sep 2024 08:09:05 +0000 (GMT)
Received: from [9.204.204.92] (unknown [9.204.204.92])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Sep 2024 08:09:04 +0000 (GMT)
Message-ID: <71971d19-802e-4d42-88d2-512f031ebe56@linux.vnet.ibm.com>
Date: Tue, 24 Sep 2024 13:39:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug][Git-Bisect][6.11.0-next-20240917]BUG: Unable to handle
 kernel data access on read at 0xc00c020000013d88
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        akpm@linux-foundation.org, minchan@kernel.org, terrelln@fb.com,
        sfr@canb.auug.org.au
References: <57130e48-dbb6-4047-a8c7-ebf5aaea93f4@linux.vnet.ibm.com>
 <20240923021557.GA38742@google.com>
 <03a55b4b-eb45-4187-9de6-ef06f8176d05@linux.vnet.ibm.com>
 <20240923152333.GB38742@google.com>
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
In-Reply-To: <20240923152333.GB38742@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8tVPCqFal_zpP5LZVPlbyqaekVs3PsBD
X-Proofpoint-ORIG-GUID: 8tVPCqFal_zpP5LZVPlbyqaekVs3PsBD
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=828 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409240053

Hi,

Test passed with the below patch.

Regards,

Venkat.

On 23/09/24 8:53 pm, Sergey Senozhatsky wrote:
> Hi,
>
> On (24/09/23 11:06), Venkat Rao Bagalkote wrote:
>> Hello,
>>
>> Below is the TC, I was running.
>>
>> https://github.com/avocado-framework-tests/avocado-misc-tests/blob/master/generic/ltp.py
> Out of curiosity, does this [1] patch fix the issue for you?
>
> [1] https://lore.kernel.org/all/20240923080211.820185-1-andrej.skvortzov@gmail.com/

