Return-Path: <linux-kernel+bounces-231792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC388919E26
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 06:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 573D31F246D9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 04:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB1E1865A;
	Thu, 27 Jun 2024 04:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MonBNpYY"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81D317BD3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 04:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719462405; cv=none; b=RjQx65nenUnw1LL31rBYznk5vB0qaByivINjXrMJ5up2fFX/zZOOZUIOMnb/Q7qH/furHswxEKap8Wn5zTBbYaUn+H9VDaLcD4ySNn2JH5/6sowKx3/Ato0IpnDUZIdFC6DWdZifZW1t/F+iynf9ZEhyPrIrdSRa7OKbhjoxfM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719462405; c=relaxed/simple;
	bh=YPQPR/zOPIBZ0Ejou+TXRNMDtfnDtofhqtq5z9sZd40=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=msFNgSk9oB5DiYGHKz1mWFAktMDGa0eDUj3PyhMl4Fjtnxh0BpJglmRl+QNE7DNV0GdAs9mhDZPwrGqRZWY2Jr7xiqA21oKVxEWgd9Luz1/2zz13uEWgg0mOYMkbQlk64qHq8wIy6Q7tm5fLG4u0B1392kDi9Hpq0qZVh1sFDuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MonBNpYY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R4QYuI013788;
	Thu, 27 Jun 2024 04:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:from:subject:to:cc:content-type
	:content-transfer-encoding; s=pp1; bh=ug6Upa1yHyLRwNwB2/zU7SkZQ4
	9/o2s2+9f091pULmc=; b=MonBNpYYcfNEtkD3ITfIKGv3blsdg5sPzF02MwdXzt
	aPL7A8QCalrzw5iJWba9qVnYZnyMPtCwGlRBfKay4N06kag9OwgPmfjAQ3zzPvuQ
	L5YXSD3XlZj5XNSW25TaHPD5Evii/+jdwVelRk6WTfGc1Bg9WYOdDwTCJiXvq/rZ
	ozN952xFGA/63Mb+cEE9iv3Mwfudl/iq0t/ZdnI8cH8RvazjYv0Ikzmx2XFN6Zo0
	zSJo+viM2pEU9bJHut43rijzfzWOVqdNa7gBB2wc2pWn5jSKXa6gXeXP9ADuYFej
	YUt+fnwzq/kF4LfKti23ezZShP9+l0MSnm9gd9/lwm+w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4010n2g1p2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 04:26:35 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45R4QZal013831;
	Thu, 27 Jun 2024 04:26:35 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4010n2g1kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 04:26:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45R2tkWM018096;
	Thu, 27 Jun 2024 04:21:57 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yx8xugxxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 04:21:57 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45R4Lt2L23593552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 04:21:57 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04EE358045;
	Thu, 27 Jun 2024 04:21:55 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D347258054;
	Thu, 27 Jun 2024 04:21:52 +0000 (GMT)
Received: from [9.43.55.131] (unknown [9.43.55.131])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Jun 2024 04:21:52 +0000 (GMT)
Message-ID: <32f20573-7e3b-496a-8c02-9234d410113e@linux.vnet.ibm.com>
Date: Thu, 27 Jun 2024 09:51:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Subject: [linux-next-20240626]Kernel Build Fails on repo linux-next-20240626
To: jfalempe@redhat.com, akpm@linux-foundation.org, naveen.n.rao@linux.ibm.com,
        mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PrzC-PZMFxCDSbAhZbMS706piSBDAV8L
X-Proofpoint-GUID: jU1gCEhovDmcLE1alIxTTBOc0R6ILf0A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_17,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1011 mlxscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=561 malwarescore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406270030

Greetings!!!


Kernel Build fails with below error, while building with 
linux-next(next-20240626) repo.


arch/powerpc/kernel/nvram_64.c:79:17: error: initialization of ‘void 
(*)(struct kmsg_dumper *, enum kmsg_dump_reason,  const char *)’ from 
incompatible pointer type ‘void (*)(struct kmsg_dumper *, enum 
kmsg_dump_reason)’ [-Werror=incompatible-pointer-types]
    79 |         .dump = oops_to_nvram
       |                 ^~~~~~~~~~~~~
arch/powerpc/kernel/nvram_64.c:79:17: note: (near initialization for 
‘nvram_kmsg_dumper.dump’)
arch/powerpc/kernel/nvram_64.c:645:13: error: conflicting types for 
‘oops_to_nvram’; have ‘void(struct kmsg_dumper *, enum 
kmsg_dump_reason,  const char *)’
   645 | static void oops_to_nvram(struct kmsg_dumper *dumper,
       |             ^~~~~~~~~~~~~
arch/powerpc/kernel/nvram_64.c:75:13: note: previous declaration of 
‘oops_to_nvram’ with type ‘void(struct kmsg_dumper *, enum 
kmsg_dump_reason)’
    75 | static void oops_to_nvram(struct kmsg_dumper *dumper,
       |             ^~~~~~~~~~~~~
arch/powerpc/kernel/nvram_64.c:75:13: error: ‘oops_to_nvram’ used but 
never defined [-Werror]
arch/powerpc/kernel/nvram_64.c:645:13: error: ‘oops_to_nvram’ defined 
but not used [-Werror=unused-function]
   645 | static void oops_to_nvram(struct kmsg_dumper *dumper,
       |             ^~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[4]: *** [scripts/Makefile.build:244: 
arch/powerpc/kernel/nvram_64.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:485: arch/powerpc/kernel] Error 2

make[2]: *** [scripts/Makefile.build:485: arch/powerpc] Error 2


This issue has been introduced with the below commit.


Commit ID: 7e72bb7504d1192ab89809f6192dba1b06f4fa51.


Regards,

Venkat.


