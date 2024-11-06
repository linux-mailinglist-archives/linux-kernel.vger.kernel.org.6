Return-Path: <linux-kernel+bounces-398263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EE49BED15
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59070285ED9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD141F80CD;
	Wed,  6 Nov 2024 13:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rNqiOOqC"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026591DFDB3
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 13:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898154; cv=none; b=oFGZVcJKnxike0r4iJPFh8ykpy8r5KVSk9lsXJ0wTwsQTO/g+Et1NXlGHNXMsLgjgclBag7yIMQST52NLnSw9h3BppJj5jV0dAU7Cnn788RXHMkX4+1pAdxXFMc7tYpAVWJItS4HQ0sDwcsq8PMSH69Uzf2YRu57D42hPtN1jGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898154; c=relaxed/simple;
	bh=7eVcjPX9gYUzc8X8Uwr1u6wuRzeJQYG8WzcwDWwSNoA=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=sUAjBJvM/KbMsJLwRB3ac2U85K+/3Kwdta2pDUUXpYGK5Tt64+fiajPettl3F23BbI/nJkaQCCL3Kq0B15E9n89mq/ylHypOWUnATzNyyHAnAqe806HqObld7SmbZ/k6ObE7/gcs5So9+Kip1nipMBFL34LKXKmCDbyKSra3GXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rNqiOOqC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6CsfFN013425;
	Wed, 6 Nov 2024 13:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=IFAQ2jL3vk6r82GGeYkZFOBienoB
	peYOhZgdaD3L39E=; b=rNqiOOqCTEZMsVPe73UtrCzWGu+bmG+o9IazmKE80Hjn
	4u4ap7mYKRM1zdRuEh+yMQ150fra6EiP13Gp8ivwcg03WGrqOB1mPBEeKrumtSqC
	IyVkNaPElOIueFAlvfnUaxE9C9dI11Sy65kGb060IyghkmawDAf9uGYyjyxNQbF+
	ZwHrYR6XdNjlrsQLhWhEJ0xa1eBshA2u3EwK7t9ZSKHYoz3q8aW98N1kovfxgLTH
	RtIVyvn68qdxpZWZD3237Ddor751A+tCPTojnjBq6NbcLd/3LYogs6tiDltONp7S
	Sdq+70xyGSgvBZ1OIWZMQwkCYtr93/xX20QIEX+oog==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42r8vgg1j9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 13:02:29 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A6D2Sue030687;
	Wed, 6 Nov 2024 13:02:28 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42r8vgg1j7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 13:02:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A65O7EJ012237;
	Wed, 6 Nov 2024 13:02:27 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p140x42b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 13:02:27 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A6D2R7Y57409826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Nov 2024 13:02:27 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46FD358067;
	Wed,  6 Nov 2024 13:02:27 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43A975805D;
	Wed,  6 Nov 2024 13:02:25 +0000 (GMT)
Received: from [9.171.20.63] (unknown [9.171.20.63])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Nov 2024 13:02:24 +0000 (GMT)
Message-ID: <7cbbd751-8332-4ab2-afa7-8c353834772a@linux.ibm.com>
Date: Wed, 6 Nov 2024 18:32:23 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
Subject: [bug report] cpumask: gcc 13.x emits compilation error on PowerPC
To: briannorris@chromium.org, kees@kernel.org, nathan@kernel.org,
        yury.norov@gmail.com
Cc: linux-kernel@vger.kernel.org, Gregory Joyce <gjoyce@ibm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EbRiPEjS0ztEKiKN18fCM1OMdksXF24K
X-Proofpoint-ORIG-GUID: adYppsxNZ1Il1-JIQjFe5bO7CX5tTMke
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411060103

Hi,

Of late, I've been encountering the following compilation error while using GCC 13.x and latest upstream code:

Compilation error:
==================
  <snip>
  CC      kernel/padata.o
In file included from ./include/linux/string.h:390,
                 from ./arch/powerpc/include/asm/paca.h:16,
                 from ./arch/powerpc/include/asm/current.h:13,
                 from ./include/linux/thread_info.h:23,
                 from ./include/asm-generic/preempt.h:5,
                 from ./arch/powerpc/include/generated/asm/preempt.h:1,
                 from ./include/linux/preempt.h:79,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/swait.h:7,
                 from ./include/linux/completion.h:12,
                 from kernel/padata.c:14:
In function ‘bitmap_copy’,
    inlined from ‘cpumask_copy’ at ./include/linux/cpumask.h:839:2,
    inlined from ‘__padata_set_cpumasks’ at kernel/padata.c:730:2:
./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ reading between 257 and 536870904 bytes from a region of size 256 [-Werror=stringop-overread]
  114 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
./include/linux/fortify-string.h:633:9: note: in expansion of macro ‘__underlying_memcpy’
  633 |         __underlying_##op(p, q, __fortify_size);                        \
      |         ^~~~~~~~~~~~~
./include/linux/fortify-string.h:678:26: note: in expansion of macro ‘__fortify_memcpy_chk’
  678 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
      |                          ^~~~~~~~~~~~~~~~~~~~
./include/linux/bitmap.h:259:17: note: in expansion of macro ‘memcpy’
  259 |                 memcpy(dst, src, len);
      |                 ^~~~~~
kernel/padata.c: In function ‘__padata_set_cpumasks’:
kernel/padata.c:713:48: note: source object ‘pcpumask’ of size [0, 256]
  713 |                                  cpumask_var_t pcpumask,
      |                                  ~~~~~~~~~~~~~~^~~~~~~~
In function ‘bitmap_copy’,
    inlined from ‘cpumask_copy’ at ./include/linux/cpumask.h:839:2,
    inlined from ‘__padata_set_cpumasks’ at kernel/padata.c:730:2:
./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ reading between 257 and 536870904 bytes from a region of size 256 [-Werror=stringop-overread]
  114 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
./include/linux/fortify-string.h:633:9: note: in expansion of macro ‘__underlying_memcpy’
  633 |         __underlying_##op(p, q, __fortify_size);                        \
      |         ^~~~~~~~~~~~~
./include/linux/fortify-string.h:678:26: note: in expansion of macro ‘__fortify_memcpy_chk’
  678 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
      |                          ^~~~~~~~~~~~~~~~~~~~
./include/linux/bitmap.h:259:17: note: in expansion of macro ‘memcpy’
  259 |                 memcpy(dst, src, len);
      |                 ^~~~~~
kernel/padata.c: In function ‘__padata_set_cpumasks’:
kernel/padata.c:713:48: note: source object ‘pcpumask’ of size [0, 256]
  713 |                                  cpumask_var_t pcpumask,
      |                                  ~~~~~~~~~~~~~~^~~~~~~~
cc1: all warnings being treated as errors
make[3]: *** [scripts/Makefile.build:229: kernel/padata.o] Error 1
make[2]: *** [scripts/Makefile.build:478: kernel] Error 2
make[1]: *** [/root/linux/Makefile:1936: .] Error 2
make: *** [Makefile:224: __sub-make] Error 2

# gcc --version 
gcc (GCC) 13.2.1 20231205 (Red Hat 13.2.1-6)
Copyright (C) 2023 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Note:
=====
I don't encounter above error using GCC 11.x and 12.x on PowerPC.
Moreover, I don't encounter above error using GCC 11.x or 12.x or 13.x on x86_64.

Git bisect:
===========
The git bisect points to the following commit causing the above compilation error:

commit ab6b1010dab68f6d4bf063517db4ce2d63554bc6 (HEAD)
Author: Brian Norris <briannorris@chromium.org>
Date:   Thu Jul 18 17:50:39 2024 -0700

    cpumask: Switch from inline to __always_inline
    
    On recent (v6.6+) builds with Clang (based on Clang 18.0.0) and certain
    configurations [0], I'm finding that (lack of) inlining decisions may
    lead to section mismatch warnings like the following:
    
      WARNING: modpost: vmlinux.o: section mismatch in reference:
      cpumask_andnot (section: .text) ->
      cpuhp_bringup_cpus_parallel.tmp_mask (section: .init.data) ERROR:
      modpost: Section mismatches detected.
    
    or more confusingly:
    
      WARNING: modpost: vmlinux: section mismatch in reference:
      cpumask_andnot+0x5f (section: .text) -> efi_systab_phys (section:
      .init.data)
    
    The first warning makes a little sense, because
    cpuhp_bringup_cpus_parallel() (an __init function) calls
    cpumask_andnot() on tmp_mask (an __initdata symbol). If the compiler
    doesn't inline cpumask_andnot(), this may appear like a mismatch.
    
    The second warning makes less sense, but might be because efi_systab_phys
    and cpuhp_bringup_cpus_parallel.tmp_mask are laid out near each other,
    and the latter isn't a proper C symbol definition.
    
    In any case, it seems a reasonable solution to suggest more strongly to
    the compiler that these cpumask macros *must* be inlined, as 'inline' is
    just a recommendation.
    
    This change has been previously proposed in the past as:
      Subject: [PATCH 1/3] bitmap: switch from inline to __always_inline
      https://lore.kernel.org/all/20221027043810.350460-2-yury.norov@gmail.com/
    
    But the change has been split up, to separately justify the cpumask
    changes (which drive my work) and the bitmap/const optimizations (that
    Yury separately proposed for other reasons). This ends up as somewhere
    between a "rebase" and "rewrite" -- I had to rewrite most of the patch.
    
    According to bloat-o-meter, vmlinux decreases minimally in size (-0.00%
    to -0.01%, depending on the version of GCC or Clang and .config in
    question) with this series of changes:
    
    gcc 13.2.0, x86_64_defconfig
    -3005 bytes, Before=21944501, After=21941496, chg -0.01%
    
    clang 16.0.6, x86_64_defconfig
    -105 bytes, Before=22571692, After=22571587, chg -0.00%
    
    gcc 9.5.0, x86_64_defconfig
    -1771 bytes, Before=21557598, After=21555827, chg -0.01%
    
    clang 18.0_pre516547 (ChromiumOS toolchain), x86_64_defconfig
    -191 bytes, Before=22615339, After=22615148, chg -0.00%
    
    clang 18.0_pre516547 (ChromiumOS toolchain), based on ChromiumOS config + gcov
    -979 bytes, Before=76294783, After=76293804, chg -0.00%
    
    [0] CONFIG_HOTPLUG_PARALLEL=y ('select'ed for x86 as of [1]) and
        CONFIG_GCOV_PROFILE_ALL.
    
    [1] commit 0c7ffa32dbd6 ("x86/smpboot/64: Implement
        arch_cpuhp_init_parallel_bringup() and enable it")
    
    Co-developed-by: Brian Norris <briannorris@chromium.org>
    Signed-off-by: Brian Norris <briannorris@chromium.org>
    Reviewed-by: Kees Cook <kees@kernel.org>
    Reviewed-by: Nathan Chancellor <nathan@kernel.org>
    Signed-off-by: Yury Norov <yury.norov@gmail.com>

So it appears that changing cpumask_copy() from inline to __always_inline causing the 
above error using Gcc 13.x. I am not gcc expert but it seems some issue with GCC 13.x?

I tried the following patch which helps fix the above error but I'm not sure if this
is the proper fix or do we need to fix it differently.

Patch:
======
diff --git a/kernel/padata.c b/kernel/padata.c
index d899f34558af..86aad2f71890 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -710,8 +710,8 @@ static bool padata_validate_cpumask(struct padata_instance *pinst,
 }
 
 static int __padata_set_cpumasks(struct padata_instance *pinst,
-                                cpumask_var_t pcpumask,
-                                cpumask_var_t cbcpumask)
+                                struct cpumask *pcpumask,
+                                struct cpumask *cbcpumask)
 {
        int valid;
        int err;


Please let me know if you need any further information.

Thanks,
--Nilay







