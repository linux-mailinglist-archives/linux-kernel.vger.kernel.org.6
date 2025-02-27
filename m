Return-Path: <linux-kernel+bounces-535252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4379A4709A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA80816E0D6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F0D8C11;
	Thu, 27 Feb 2025 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O+syTVzg"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4504D270047
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740618030; cv=none; b=KBT7SYrLmP7++htMe50Z1lZIclPSyocICA3OozDBu8+KuaOc+YLlJWNKJd0POgrLawy82AmESblvbdyQyCTTxCuxEaVQRmOXEKXPY1QDthTmkQuL0KiEZZWBHLxQAvLxtlikfVMJvnHMERczpPNeJYici8aPp/tMf+uLhwUe8ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740618030; c=relaxed/simple;
	bh=+aL6IdP6BamqRIim1+SCAPuOnQttw4MhjgjyYK7dOfs=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=kNke//7ym77T4Rox9NtyZnxy5s9mcPsoF1XsDus6Iu3/H3IoOXGVOFXsV6lzVpw9UWokJkpTiiOo7gug0KayW2c8xO4pH/AJiECsu7lacH5TckAGqmLXmNuKOFOUw3GvZqXX1qwfhU2E55YIOxSVm7S96EUEXLwUGVyg40t5XRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O+syTVzg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QHNnad005935;
	Thu, 27 Feb 2025 01:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=HbOEv3tj8S4kG6chZ5y1DKfZ+hjL
	guroIgjvXnzmkZE=; b=O+syTVzgB5PK/b9M6fr9ZVz9r+Wh5sl0EGssZJT47e2B
	lSU8R2InwCQL+BovJEey4wjMBTLiKNMkHO4cgpMWezIDKGVKz9WZ4lDkUoIvTd+6
	kcddg73bGIj2+aJrATyGcGqzCqnTPGYgFun1YIvyujd3NPir9jSrgo8MBZlkA7FC
	UsFa/Qjkf7mffV9bW51sjYjKyIoqh3JkJwrlVqQe4GcnvEC2kECeAdRQRZKzKb7A
	KUHUaczJDKynRJeK7/EELyi8eTwUlZqOcFU+7uuYpxdbGYWCL7l2ML9TBAdH1j0N
	WrHAX+PceU38vUP4ZQG8rjnJXPWAaDHJU97VXSwViw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451xnp4nex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 01:00:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51QLBRoP012470;
	Thu, 27 Feb 2025 01:00:15 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yrwsx3qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 01:00:15 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51R10FkU14025428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 01:00:15 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05C405805A;
	Thu, 27 Feb 2025 01:00:15 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA00058068;
	Thu, 27 Feb 2025 01:00:13 +0000 (GMT)
Received: from [9.61.251.243] (unknown [9.61.251.243])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Feb 2025 01:00:13 +0000 (GMT)
Message-ID: <adbe8dd1-a725-4811-ae7e-76fe770cf096@linux.vnet.ibm.com>
Date: Thu, 27 Feb 2025 06:30:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
From: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Subject: [next-20250226]Build Failure
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FfHWYYq1yecM_yanqz3eLdIG6btmahuI
X-Proofpoint-GUID: FfHWYYq1yecM_yanqz3eLdIG6btmahuI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_01,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=936 spamscore=0 phishscore=0
 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270006

Greetings!!!

I am seeing build failures with kernel next-20250226, on IBM Power8 systems.

Failures:

In file included from ./include/asm-generic/div64.h:27,
                  from ./arch/powerpc/include/generated/asm/div64.h:1,
                  from ./include/linux/math.h:6,
                  from ./include/linux/math64.h:6,
                  from ./include/linux/time.h:6,
                  from fs/ext4/file.c:22:
fs/ext4/file.c: In function 'ext4_sample_last_mounted':
./include/linux/compiler.h:197:62: error: static assertion failed: "must 
be non-C-string (not NUL-terminated)"
  #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct 
{_Static_assert(!(e), msg);}))
^~~~~~~~~~~~~~
./include/linux/compiler.h:226:2: note: in expansion of macro 
'__BUILD_BUG_ON_ZERO_MSG'
   __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
   ^~~~~~~~~~~~~~~~~~~~~~~
./include/linux/string.h:418:6: note: in expansion of macro 
'__must_be_noncstr'
       __must_be_noncstr(dest) +  \
       ^~~~~~~~~~~~~~~~~
fs/ext4/file.c:869:2: note: in expansion of macro 'strtomem_pad'
   strtomem_pad(sbi->s_es->s_last_mounted, cp, 0);
   ^~~~~~~~~~~~
In file included from ./include/linux/build_bug.h:5,
                  from ./include/linux/container_of.h:5,
                  from ./include/linux/list.h:5,
                  from ./include/linux/module.h:12,
                  from drivers/message/fusion/mptsas.c:46:
drivers/message/fusion/mptsas.c: In function 
'mptsas_exp_repmanufacture_info':
./include/linux/compiler.h:197:62: error: static assertion failed: "must 
be non-C-string (not NUL-terminated)"
  #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct 
{_Static_assert(!(e), msg);}))
^~~~~~~~~~~~~~
./include/linux/compiler.h:226:2: note: in expansion of macro 
'__BUILD_BUG_ON_ZERO_MSG'
   __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
   ^~~~~~~~~~~~~~~~~~~~~~~
./include/linux/string.h:468:26: note: in expansion of macro 
'__must_be_noncstr'
   const size_t _src_len = __must_be_noncstr(src) +  \
                           ^~~~~~~~~~~~~~~~~
drivers/message/fusion/mptsas.c:2968:3: note: in expansion of macro 
'memtostr'
    memtostr(edev->vendor_id, manufacture_reply->vendor_id);
    ^~~~~~~~
./include/linux/compiler.h:197:62: error: static assertion failed: "must 
be non-C-string (not NUL-terminated)"
  #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct 
{_Static_assert(!(e), msg);}))
^~~~~~~~~~~~~~
./include/linux/compiler.h:226:2: note: in expansion of macro 
'__BUILD_BUG_ON_ZERO_MSG'
   __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
   ^~~~~~~~~~~~~~~~~~~~~~~
./include/linux/string.h:468:26: note: in expansion of macro 
'__must_be_noncstr'
   const size_t _src_len = __must_be_noncstr(src) +  \
                           ^~~~~~~~~~~~~~~~~
drivers/message/fusion/mptsas.c:2969:3: note: in expansion of macro 
'memtostr'
    memtostr(edev->product_id, manufacture_reply->product_id);
    ^~~~~~~~
./include/linux/compiler.h:197:62: error: static assertion failed: "must 
be non-C-string (not NUL-terminated)"
  #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct 
{_Static_assert(!(e), msg);}))
^~~~~~~~~~~~~~
./include/linux/compiler.h:226:2: note: in expansion of macro 
'__BUILD_BUG_ON_ZERO_MSG'
   __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
   ^~~~~~~~~~~~~~~~~~~~~~~
./include/linux/string.h:468:26: note: in expansion of macro 
'__must_be_noncstr'
   const size_t _src_len = __must_be_noncstr(src) +  \
                           ^~~~~~~~~~~~~~~~~
drivers/message/fusion/mptsas.c:2970:3: note: in expansion of macro 
'memtostr'
    memtostr(edev->product_rev, manufacture_reply->product_rev);
    ^~~~~~~~
./include/linux/compiler.h:197:62: error: static assertion failed: "must 
be non-C-string (not NUL-terminated)"
  #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct 
{_Static_assert(!(e), msg);}))
^~~~~~~~~~~~~~
./include/linux/compiler.h:226:2: note: in expansion of macro 
'__BUILD_BUG_ON_ZERO_MSG'
   __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
   ^~~~~~~~~~~~~~~~~~~~~~~
./include/linux/string.h:468:26: note: in expansion of macro 
'__must_be_noncstr'
   const size_t _src_len = __must_be_noncstr(src) +  \
                           ^~~~~~~~~~~~~~~~~
drivers/message/fusion/mptsas.c:2973:4: note: in expansion of macro 
'memtostr'
     memtostr(edev->component_vendor_id,
     ^~~~~~~~
make[4]: *** [scripts/Makefile.build:203: fs/ext4/file.o] Error 1
make[3]: *** [scripts/Makefile.build:461: fs/ext4] Error 2
make[3]: *** Waiting for unfinished jobs....
In file included from ./include/linux/array_size.h:5,
                  from ./include/linux/kernel.h:16,
                  from drivers/scsi/mpt3sas/mpt3sas_base.c:46:
drivers/scsi/mpt3sas/mpt3sas_base.c: In function 
'_base_display_ioc_capabilities':
./include/linux/compiler.h:197:62: error: static assertion failed: "must 
be non-C-string (not NUL-terminated)"
  #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct 
{_Static_assert(!(e), msg);}))
^~~~~~~~~~~~~~
./include/linux/compiler.h:226:2: note: in expansion of macro 
'__BUILD_BUG_ON_ZERO_MSG'
   __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
   ^~~~~~~~~~~~~~~~~~~~~~~
./include/linux/string.h:468:26: note: in expansion of macro 
'__must_be_noncstr'
   const size_t _src_len = __must_be_noncstr(src) +  \
                           ^~~~~~~~~~~~~~~~~
drivers/scsi/mpt3sas/mpt3sas_base.c:4798:2: note: in expansion of macro 
'memtostr'
   memtostr(desc, ioc->manu_pg0.ChipName);
   ^~~~~~~~
In file included from ./include/linux/build_bug.h:5,
                  from ./include/linux/container_of.h:5,
                  from ./include/linux/list.h:5,
                  from ./include/linux/module.h:12,
                  from drivers/scsi/mpt3sas/mpt3sas_transport.c:45:
drivers/scsi/mpt3sas/mpt3sas_transport.c: In function 
'_transport_expander_report_manufacture':
./include/linux/compiler.h:197:62: error: static assertion failed: "must 
be non-C-string (not NUL-terminated)"
  #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct 
{_Static_assert(!(e), msg);}))
^~~~~~~~~~~~~~
./include/linux/compiler.h:226:2: note: in expansion of macro 
'__BUILD_BUG_ON_ZERO_MSG'
   __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
   ^~~~~~~~~~~~~~~~~~~~~~~
./include/linux/string.h:468:26: note: in expansion of macro 
'__must_be_noncstr'
   const size_t _src_len = __must_be_noncstr(src) +  \
                           ^~~~~~~~~~~~~~~~~
drivers/scsi/mpt3sas/mpt3sas_transport.c:461:3: note: in expansion of 
macro 'memtostr'
    memtostr(edev->vendor_id, manufacture_reply->vendor_id);
    ^~~~~~~~
./include/linux/compiler.h:197:62: error: static assertion failed: "must 
be non-C-string (not NUL-terminated)"
  #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct 
{_Static_assert(!(e), msg);}))
^~~~~~~~~~~~~~
./include/linux/compiler.h:226:2: note: in expansion of macro 
'__BUILD_BUG_ON_ZERO_MSG'
   __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
   ^~~~~~~~~~~~~~~~~~~~~~~
./include/linux/string.h:468:26: note: in expansion of macro 
'__must_be_noncstr'
   const size_t _src_len = __must_be_noncstr(src) +  \
                           ^~~~~~~~~~~~~~~~~
drivers/scsi/mpt3sas/mpt3sas_transport.c:462:3: note: in expansion of 
macro 'memtostr'
    memtostr(edev->product_id, manufacture_reply->product_id);
    ^~~~~~~~
./include/linux/compiler.h:197:62: error: static assertion failed: "must 
be non-C-string (not NUL-terminated)"
  #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct 
{_Static_assert(!(e), msg);}))
^~~~~~~~~~~~~~
./include/linux/compiler.h:226:2: note: in expansion of macro 
'__BUILD_BUG_ON_ZERO_MSG'
   __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
   ^~~~~~~~~~~~~~~~~~~~~~~
./include/linux/string.h:468:26: note: in expansion of macro 
'__must_be_noncstr'
   const size_t _src_len = __must_be_noncstr(src) +  \
                           ^~~~~~~~~~~~~~~~~
drivers/scsi/mpt3sas/mpt3sas_transport.c:463:3: note: in expansion of 
macro 'memtostr'
    memtostr(edev->product_rev, manufacture_reply->product_rev);
    ^~~~~~~~
./include/linux/compiler.h:197:62: error: static assertion failed: "must 
be non-C-string (not NUL-terminated)"
  #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct 
{_Static_assert(!(e), msg);}))
^~~~~~~~~~~~~~
./include/linux/compiler.h:226:2: note: in expansion of macro 
'__BUILD_BUG_ON_ZERO_MSG'
   __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
   ^~~~~~~~~~~~~~~~~~~~~~~
./include/linux/string.h:468:26: note: in expansion of macro 
'__must_be_noncstr'
   const size_t _src_len = __must_be_noncstr(src) +  \
                           ^~~~~~~~~~~~~~~~~
drivers/scsi/mpt3sas/mpt3sas_transport.c:466:4: note: in expansion of 
macro 'memtostr'
     memtostr(edev->component_vendor_id,
     ^~~~~~~~
make[5]: *** [scripts/Makefile.build:203: 
drivers/scsi/mpt3sas/mpt3sas_transport.o] Error 1
make[5]: *** Waiting for unfinished jobs....
make[5]: *** [scripts/Makefile.build:203: 
drivers/message/fusion/mptsas.o] Error 1
make[4]: *** [scripts/Makefile.build:461: drivers/message/fusion] Error 2
make[3]: *** [scripts/Makefile.build:461: drivers/message] Error 2
make[3]: *** Waiting for unfinished jobs....
make[5]: *** [scripts/Makefile.build:203: 
drivers/scsi/mpt3sas/mpt3sas_base.o] Error 1
In file included from ./include/linux/array_size.h:5,
                  from ./include/linux/kernel.h:16,
                  from drivers/scsi/qla2xxx/qla_def.h:9,
                  from drivers/scsi/qla2xxx/qla_mr.c:6:
drivers/scsi/qla2xxx/qla_mr.c: In function 'qlafx00_fx_disc':
./include/linux/compiler.h:197:62: error: static assertion failed: "must 
be non-C-string (not NUL-terminated)"
  #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct 
{_Static_assert(!(e), msg);}))
^~~~~~~~~~~~~~
./include/linux/compiler.h:226:2: note: in expansion of macro 
'__BUILD_BUG_ON_ZERO_MSG'
   __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
   ^~~~~~~~~~~~~~~~~~~~~~~
./include/linux/string.h:468:26: note: in expansion of macro 
'__must_be_noncstr'
   const size_t _src_len = __must_be_noncstr(src) +  \
                           ^~~~~~~~~~~~~~~~~
drivers/scsi/qla2xxx/qla_mr.c:1912:3: note: in expansion of macro 'memtostr'
    memtostr(vha->hw->model_number, pinfo->model_num);
    ^~~~~~~~
./include/linux/compiler.h:197:62: error: static assertion failed: "must 
be non-C-string (not NUL-terminated)"
  #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct 
{_Static_assert(!(e), msg);}))
^~~~~~~~~~~~~~
./include/linux/compiler.h:226:2: note: in expansion of macro 
'__BUILD_BUG_ON_ZERO_MSG'
   __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
   ^~~~~~~~~~~~~~~~~~~~~~~
./include/linux/string.h:468:26: note: in expansion of macro 
'__must_be_noncstr'
   const size_t _src_len = __must_be_noncstr(src) +  \
                           ^~~~~~~~~~~~~~~~~
drivers/scsi/qla2xxx/qla_mr.c:1913:3: note: in expansion of macro 'memtostr'
    memtostr(vha->hw->model_desc, pinfo->model_description);
    ^~~~~~~~
make[5]: *** [scripts/Makefile.build:203: drivers/scsi/qla2xxx/qla_mr.o] 
Error 1
make[5]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:461: fs] Error 2
make[2]: *** Waiting for unfinished jobs....
make[4]: *** [scripts/Makefile.build:461: drivers/scsi/mpt3sas] Error 2
make[4]: *** Waiting for unfinished jobs....
make[4]: *** [scripts/Makefile.build:461: drivers/scsi/qla2xxx] Error 2
make[3]: *** [scripts/Makefile.build:461: drivers/scsi] Error 2
make[2]: *** [scripts/Makefile.build:461: drivers] Error 2
make[1]: *** [/root/linux-next/Makefile:1989: .] Error 2
make: *** [Makefile:251: __sub-make] Error 2

Regards,

Venkat.


