Return-Path: <linux-kernel+bounces-550573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F247A5615F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A815B3B3C15
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6239B19E7E2;
	Fri,  7 Mar 2025 07:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YqaQ1Jb8"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DB438382
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 07:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741330959; cv=none; b=DD081Xds3P1YkOEQQESz917tYY6bdijId7ndKHrtAezr6+rrqoFeZJ3tMkNOekEy/8ctM3WvZpCpkQiD0EmogHI1cBknZZM1sBWjO9Hp0wU3VnWpeAwziqIPrg/cT/Zb30une9hRDS0fqht+XjAl31etcaXSHJnwyzK7Ys56qlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741330959; c=relaxed/simple;
	bh=aevlX0RcSP3ySNOj6f0xTevg3cvMCU6O3qzPNpd+RKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WbpfoLUSo7qq8pOgrB+74UZPWi3LCl89taD00z9SaH0I4bbPM6z4V4jO8Yeqv/BGY4PWtwVwfnJi63RuR0jrpUif94fehROt8CiEpfnVMkAbgYVZJUjren26c+hd7PIpXJOe6xhXU5JqEuPBBbVxaIYyo6qW5tFRjvyeI5AHQm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YqaQ1Jb8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526KpgCS011863;
	Fri, 7 Mar 2025 07:02:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jeU+yf
	jHIAyalVv5PYmp3OMyddzcHlq2oCYLvb5VDjI=; b=YqaQ1Jb8/lglByMRcE0b+/
	oGli+3zkecBORCblg323nwZtDRrh7fOBhcD37c5zZNmv6cmOyVFlaLLEw9/GfVq/
	4sfLz9NgsCBmhhTfW01Bm5gE9vBEC6P7Ja71KvSoCfZxRC35C0tjEZrkxX2feEfT
	M7RxmG6XmWq+EwzuZkk1GTftI76LcSGtKNZOx/5x0rZB0WcJyPQ9E/7QplySKcH9
	E2c9lfUX8RFCpSrA4v8RsHQQUGihkzViRKBtojU1iOL0FzArPtGVZU5jRziTy3PM
	oThyynm6q32SQ66mABsnrC/W7/MVwDnVaD2mJtbt112+YMAabiKIYG9e5FSKsEsw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 457k45a6tw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 07:02:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5275YvAw020846;
	Fri, 7 Mar 2025 07:02:22 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454djnwc5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 07:02:22 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52772LJn26673916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Mar 2025 07:02:21 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46BFA58518;
	Fri,  7 Mar 2025 07:02:21 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C671E58519;
	Fri,  7 Mar 2025 07:02:17 +0000 (GMT)
Received: from [9.43.103.133] (unknown [9.43.103.133])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Mar 2025 07:02:17 +0000 (GMT)
Message-ID: <7d61512d-6dd1-4c09-b408-67bc16340237@linux.ibm.com>
Date: Fri, 7 Mar 2025 12:32:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PowerPC: sleftests/powerpc fails to compile linux-next
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <3267ea6e-5a1a-4752-96ef-8351c912d386@linux.ibm.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <3267ea6e-5a1a-4752-96ef-8351c912d386@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fSRNlexL2JJzyspuwUc5HpsP1bq2uuXT
X-Proofpoint-GUID: fSRNlexL2JJzyspuwUc5HpsP1bq2uuXT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_02,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503070048



On 3/6/25 10:30 PM, Venkat Rao Bagalkote wrote:
> Greetings!!
> 
> I see selftests/powerpc fails to compile on next-20250306.
> 
> This error has been introduced in next-20250218. Make is successful on next-20250217.
> 
> 
> Attached is the .config used.
> 
> 
> If you fix this, please add below tag.
> 
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> 
> 
> Errors:
> 
> make -C powerpc/
> make: Entering directory '/root/venkat/linux-next/tools/testing/selftests/powerpc'
> Makefile:60: warning: overriding recipe for target 'emit_tests'
> ../lib.mk:182: warning: ignoring old recipe for target 'emit_tests'
> BUILD_TARGET=/root/venkat/linux-next/tools/testing/selftests/powerpc/alignment; mkdir -p $BUILD_TARGET; make OUTPUT=$BUILD_TARGET -k -C alignment all
> make[1]: Nothing to be done for 'all'.
> BUILD_TARGET=/root/venkat/linux-next/tools/testing/selftests/powerpc/benchmarks; mkdir -p $BUILD_TARGET; make OUTPUT=$BUILD_TARGET -k -C benchmarks all
> make[1]: Nothing to be done for 'all'.
> BUILD_TARGET=/root/venkat/linux-next/tools/testing/selftests/powerpc/cache_shape; mkdir -p $BUILD_TARGET; make OUTPUT=$BUILD_TARGET -k -C cache_shape all
> make[1]: Nothing to be done for 'all'.
> BUILD_TARGET=/root/venkat/linux-next/tools/testing/selftests/powerpc/copyloops; mkdir -p $BUILD_TARGET; make OUTPUT=$BUILD_TARGET -k -C copyloops all
> make[1]: Nothing to be done for 'all'.
> BUILD_TARGET=/root/venkat/linux-next/tools/testing/selftests/powerpc/dexcr; mkdir -p $BUILD_TARGET; make OUTPUT=$BUILD_TARGET -k -C dexcr all
> make[1]: Nothing to be done for 'all'.
> BUILD_TARGET=/root/venkat/linux-next/tools/testing/selftests/powerpc/dscr; mkdir -p $BUILD_TARGET; make OUTPUT=$BUILD_TARGET -k -C dscr all
> make[1]: Nothing to be done for 'all'.
> BUILD_TARGET=/root/venkat/linux-next/tools/testing/selftests/powerpc/mm; mkdir -p $BUILD_TARGET; make OUTPUT=$BUILD_TARGET -k -C mm all
>   CC       pkey_exec_prot
> In file included from pkey_exec_prot.c:18:
> /root/venkat/linux-next/tools/testing/selftests/powerpc/include/pkeys.h: In function ‘pkeys_unsupported’:
> /root/venkat/linux-next/tools/testing/selftests/powerpc/include/pkeys.h:96:34: error: ‘PKEY_UNRESTRICTED’ undeclared (first use in this function)
>    96 |         pkey = sys_pkey_alloc(0, PKEY_UNRESTRICTED);
>       |                                  ^~~~~~~~~~~~~~~~~

Commit 6d61527d931ba ('mm/pkey: Add PKEY_UNRESTRICTED macro') added a macro PKEY_UNRESTRICTED to handle implicit literal
value of 0x0 (which is "unrestricted"). belore patch add the same to powerpc/mm selftest.

Can you try with this patch to check whether it fixes the build break for you


diff --git a/tools/testing/selftests/powerpc/include/pkeys.h b/tools/testing/selftests/powerpc/include/pkeys.h
index c6d4063dd4f6..d6deb6ffa1b9 100644
--- a/tools/testing/selftests/powerpc/include/pkeys.h
+++ b/tools/testing/selftests/powerpc/include/pkeys.h
@@ -24,6 +24,9 @@
 #undef PKEY_DISABLE_EXECUTE
 #define PKEY_DISABLE_EXECUTE   0x4
 
+#undef PKEY_UNRESTRICTED
+#define PKEY_UNRESTRICTED      0x0
+
 /* Older versions of libc do not define this */
 #ifndef SEGV_PKUERR
 #define SEGV_PKUERR    4


Maddy



> /root/venkat/linux-next/tools/testing/selftests/powerpc/include/pkeys.h:96:34: note: each undeclared identifier is reported only once for each function it appears in
> pkey_exec_prot.c: In function ‘segv_handler’:
> pkey_exec_prot.c:75:53: error: ‘PKEY_UNRESTRICTED’ undeclared (first use in this function)
>    75 |                         pkey_set_rights(fault_pkey, PKEY_UNRESTRICTED);
>       | ^~~~~~~~~~~~~~~~~
> make[1]: *** [../../lib.mk:222: /root/venkat/linux-next/tools/testing/selftests/powerpc/mm/pkey_exec_prot] Error 1
>   CC       pkey_siginfo
> In file included from pkey_siginfo.c:22:
> /root/venkat/linux-next/tools/testing/selftests/powerpc/include/pkeys.h: In function ‘pkeys_unsupported’:
> /root/venkat/linux-next/tools/testing/selftests/powerpc/include/pkeys.h:96:34: error: ‘PKEY_UNRESTRICTED’ undeclared (first use in this function)
>    96 |         pkey = sys_pkey_alloc(0, PKEY_UNRESTRICTED);
>       |                                  ^~~~~~~~~~~~~~~~~
> /root/venkat/linux-next/tools/testing/selftests/powerpc/include/pkeys.h:96:34: note: each undeclared identifier is reported only once for each function it appears in
> pkey_siginfo.c: In function ‘segv_handler’:
> pkey_siginfo.c:86:39: error: ‘PKEY_UNRESTRICTED’ undeclared (first use in this function)
>    86 |                 pkey_set_rights(pkey, PKEY_UNRESTRICTED);
>       |                                       ^~~~~~~~~~~~~~~~~
> make[1]: *** [../../lib.mk:222: /root/venkat/linux-next/tools/testing/selftests/powerpc/mm/pkey_siginfo] Error 1
> make[1]: Target 'all' not remade because of errors.
> make: *** [Makefile:40: mm] Error 2
> make: Leaving directory '/root/venkat/linux-next/tools/testing/selftests/powerpc'
> 
> 
> Regards,
> 
> Venkat.


