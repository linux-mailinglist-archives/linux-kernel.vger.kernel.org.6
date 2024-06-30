Return-Path: <linux-kernel+bounces-235325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F8391D3C0
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A392815AE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 20:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A09C13D509;
	Sun, 30 Jun 2024 20:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rxSBPdCE"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B8026AC9
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 20:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719778020; cv=none; b=o8zt9LwjMQ4Hp3/0SBa5V6CdKQLi8IBlxUyCubjgGi7E3UInmppJUid4DCkeJqMagvhrNr1ED8GizorQoXs3++dAZipLvxLBp4+jFRI6Ezkk8jiDQzOnajVr8i1siNARzcTPVmtkhkYOO3cM8FAUa8oJ2YmMEY+Ft5/G+FVDodI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719778020; c=relaxed/simple;
	bh=dNoMHApAVCa1TGA5eX8if0lc/Gt32SqOsTS1vP1MFAw=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=nUdXHzjPAJRTtaETJB4Lc+9rVnT3PRCtnVD+vrFNFmbzTnn4m5s+7D7wXv5hKiGGYwO7rwGinJk15Us/lNXUmMh1NMAcUdUgEWcNYMhmi/54ojR+aQgii64YC/ZNqMAEK2inHdiN0L0okCrvOM9MEJrlorBzeGTJMowaenbyxqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rxSBPdCE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UJwa6U000816;
	Sun, 30 Jun 2024 20:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:content-type
	:content-transfer-encoding:mime-version; s=pp1; bh=3p/VQq+7V82oj
	vCB8awtyEkGaJxAnboM2A5U36EcXFo=; b=rxSBPdCEihGDqK4kCbZNi+jQZVnRa
	a9nnQapuzkHG7mQLYWiuGB4OH3dUGi9w4t6W37ZVfUeMNF3cfKHejdCmaNRytES4
	xkKN2H/iafRtv0YRmTwLc+Rb6PoqMKbLKrBQrElXg1ukAPbyhzZKPAmv1ZxcIljQ
	JgxmSb0bPzvAxaTecrRRuCmmWyufsqMGPzSxWI7VNo+WVYBywVldtnJJDup+Nd0/
	qDRp+2VFJevx/20G9Q7Of6yzyOzMANaN617lwUF+sl4dml8lXFTBRKhAosL6oTe8
	9/xPMivUri/XtysT0KN/11LgHfyvM6kKxQgX5m4KcMXi1OWJceWHZf9hg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403e0180cs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Jun 2024 20:06:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45UH1oWK024124;
	Sun, 30 Jun 2024 20:06:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 402ya33887-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Jun 2024 20:06:45 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45UK6glL54526300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jun 2024 20:06:44 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EDF42004B;
	Sun, 30 Jun 2024 20:06:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFF3420043;
	Sun, 30 Jun 2024 20:06:40 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.43.82.43])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 30 Jun 2024 20:06:40 +0000 (GMT)
Date: Mon, 1 Jul 2024 01:36:38 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, Vishal Chourasia <vishalc@linux.ibm.com>
Subject: sched_ext/for-6.11: Warning [-Wcalloc-transposed-args] during build
Message-ID: <ZoG6zreEtQhAUr_2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0N-omBZBxKmYWicp6jjsfyFrVV5fiQFy
X-Proofpoint-ORIG-GUID: 0N-omBZBxKmYWicp6jjsfyFrVV5fiQFy
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-30_16,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 clxscore=1011 priorityscore=1501 adultscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406300158

I encountered a warning while building the sched-ext for the for-6.11
branch. Below are the details:

# make -j40 -s vmlinux
In file included from ./include/linux/rhashtable-types.h:12,
                 from ./include/linux/sched/ext.h:15,
                 from ./include/linux/sched.h:83,
                 from ./include/linux/sched/signal.h:7,
                 from ./include/linux/sched/cputime.h:5,
                 from kernel/sched/build_policy.c:17:
kernel/sched/ext.c: In function ‘alloc_exit_info’:
kernel/sched/ext.c:3815:32: warning: ‘kmalloc_array_noprof’ sizes specified with ‘sizeof’ in the earlier argument and not in the later argument [-Wcalloc-transposed-args]
 3815 |         ei->bt = kcalloc(sizeof(ei->bt[0]), SCX_EXIT_BT_LEN, GFP_KERNEL);
      |                                ^
./include/linux/alloc_tag.h:206:16: note: in definition of macro ‘alloc_hooks_tag’
  206 |         typeof(_do_alloc) _res = _do_alloc;                             \
      |                ^~~~~~~~~
./include/linux/slab.h:701:49: note: in expansion of macro ‘alloc_hooks’
  701 | #define kmalloc_array(...)                      alloc_hooks(kmalloc_array_noprof(__VA_ARGS__))
      |                                                 ^~~~~~~~~~~
./include/linux/slab.h:730:41: note: in expansion of macro ‘kmalloc_array’
  730 | #define kcalloc(n, size, flags)         kmalloc_array(n, size, (flags) | __GFP_ZERO)
      |                                         ^~~~~~~~~~~~~
kernel/sched/ext.c:3815:18: note: in expansion of macro ‘kcalloc’
 3815 |         ei->bt = kcalloc(sizeof(ei->bt[0]), SCX_EXIT_BT_LEN, GFP_KERNEL);
      |                  ^~~~~~~
kernel/sched/ext.c:3815:32: note: earlier argument should specify number of elements, later size of each element
 3815 |         ei->bt = kcalloc(sizeof(ei->bt[0]), SCX_EXIT_BT_LEN, GFP_KERNEL);
      |                                ^
./include/linux/alloc_tag.h:206:16: note: in definition of macro ‘alloc_hooks_tag’
  206 |         typeof(_do_alloc) _res = _do_alloc;                             \
      |                ^~~~~~~~~
./include/linux/slab.h:701:49: note: in expansion of macro ‘alloc_hooks’
  701 | #define kmalloc_array(...)                      alloc_hooks(kmalloc_array_noprof(__VA_ARGS__))
      |                                                 ^~~~~~~~~~~
./include/linux/slab.h:730:41: note: in expansion of macro ‘kmalloc_array’
  730 | #define kcalloc(n, size, flags)         kmalloc_array(n, size, (flags) | __GFP_ZERO)
      |                                         ^~~~~~~~~~~~~
kernel/sched/ext.c:3815:18: note: in expansion of macro ‘kcalloc’
 3815 |         ei->bt = kcalloc(sizeof(ei->bt[0]), SCX_EXIT_BT_LEN, GFP_KERNEL);
      |                  ^~~~~~~

# gcc -v
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/libexec/gcc/ppc64le-redhat-linux/14/lto-wrapper
OFFLOAD_TARGET_NAMES=nvptx-none
OFFLOAD_TARGET_DEFAULT=1
Target: ppc64le-redhat-linux
Configured with: ../configure --enable-bootstrap
--enable-languages=c,c++,fortran,lto --prefix=/usr
--mandir=/usr/share/man --infodir=/usr/share/info
--with-bugurl=http://bugzilla.redhat.com/bugzilla --enable-shared
--enable-threads=posix --enable-checking=release
--enable-targets=powerpcle-linux --disable-multilib --with-system-zlib
--enable-__cxa_atexit --disable-libunwind-exceptions
--enable-gnu-unique-object --enable-linker-build-id
--with-gcc-major-version-only --enable-libstdcxx-backtrace
--with-libstdcxx-zoneinfo=/usr/share/zoneinfo
--with-linker-hash-style=gnu --enable-plugin --enable-initfini-array
--without-isl --enable-offload-targets=nvptx-none
--enable-offload-defaulted --without-cuda-driver
--enable-gnu-indirect-function --enable-secureplt --with-long-double-128
--with-long-double-format=ieee --with-cpu-32=power9
--with-tune-32=power9 --with-cpu-64=power9 --with-tune-64=power9
--build=ppc64le-redhat-linux --with-build-config=bootstrap-lto
--enable-link-serialization=1 --enable-host-pie --enable-host-bind-now
Thread model: posix
Supported LTO compression algorithms: zlib zstd
gcc version 14.1.1 20240507 (Red Hat 14.1.1-2) (GCC)


If this is intentional, (I am not sure why)

// consider changing to 

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f6e25545bfc0..9050f8051918 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3812,7 +3812,7 @@ static struct scx_exit_info *alloc_exit_info(size_t exit_dump_len)
        if (!ei)
                return NULL;

-       ei->bt = kcalloc(sizeof(ei->bt[0]), SCX_EXIT_BT_LEN, GFP_KERNEL);
+       ei->bt = kcalloc(sizeof(ei->bt[0]) * SCX_EXIT_BT_LEN, 1, GFP_KERNEL);
        ei->msg = kzalloc(SCX_EXIT_MSG_LEN, GFP_KERNEL);
        ei->dump = kzalloc(exit_dump_len, GFP_KERNEL);

else 

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f6e25545bfc0..ae9ec8f542f2 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3812,7 +3812,7 @@ static struct scx_exit_info *alloc_exit_info(size_t exit_dump_len)
        if (!ei)
                return NULL;

-       ei->bt = kcalloc(sizeof(ei->bt[0]), SCX_EXIT_BT_LEN, GFP_KERNEL);
+       ei->bt = kcalloc(SCX_EXIT_BT_LEN, sizeof(ei->bt[0]), GFP_KERNEL);
        ei->msg = kzalloc(SCX_EXIT_MSG_LEN, GFP_KERNEL);
        ei->dump = kzalloc(exit_dump_len, GFP_KERNEL);

https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wcalloc-transposed-args

