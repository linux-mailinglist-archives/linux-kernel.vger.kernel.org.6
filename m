Return-Path: <linux-kernel+bounces-381499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8609B0017
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 940502823B9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0E21E2602;
	Fri, 25 Oct 2024 10:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="stX288jr"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D2A18BC1C;
	Fri, 25 Oct 2024 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729851945; cv=none; b=uYFOqpzMwrQj4lZr757e8dnIyPcHiLSfWwSr4u8l38SmRIBeobPR50t5lhbGMWHDeoC8CYf+/MVhn2hBiQlaNETDDXrcXh511aqgCvAn6WXLvp1hul2OjKf8mVLGT4j3wCBC2aP8Ohus1eaP5ms+0aHUKnghYfgE6RPUkZyguqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729851945; c=relaxed/simple;
	bh=l6zYx3EpY8E06f6D9Nq2OmEIa8ymCnBBvQHwnns2fMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nZAWKsSjSMEZ00hhHZT0IXNguBdzvUJ84GAE/S5wnPDjGE7q/31t9bFV5qVFcH7OWg1C1cXz9PZw1vee7QCGlmAFr9lz4rC8LqtEs0RcXQ4wLXmbWBHeZkDXVyf20oFXVvtUcRoWenUKn1tpXm9sJleDJ5XTRNbMbiqVdv+B5sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=stX288jr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P1v1M4032541;
	Fri, 25 Oct 2024 10:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=u/wjAQliUeOUevukzQrFYo45PuDDJe
	S43AJbPPaIqao=; b=stX288jrkgMtzuDZx2BjnKyCnDLhgKyFBIpSMqgmn1yDFW
	kq3bAyzBp7zyBgiYqMEcQz/mmR37qn6gTErcnsXA4f/jFtKtD9wS/PehekNcxp5Q
	3bMY2RJNbb/4ZQbBMPvdT3XPDrrgokvNcciZACc7V17M2nC0OZR6/Sua9ztcHwAN
	ZktNKWdlEur4wL/aWoIEBV45GuygZEH82IwYCIQghSN9qHs16uUpc7FT8TnmAjAA
	GJqCp+hl8/u7ss/x3kz1pFoOREThY6V8cOi4EHZ9p07D8RNp79b+5c9ut7WXyb53
	9yYCB2NnQhhLUcnSLAcR+6E32gCjpIRnvttAGmiA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42g246su3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 10:25:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49PAGYUr001516;
	Fri, 25 Oct 2024 10:25:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emk9n5xh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 10:25:34 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49PAPWhE33292794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 10:25:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3472202F9;
	Fri, 25 Oct 2024 10:05:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45FD8202F8;
	Fri, 25 Oct 2024 10:05:18 +0000 (GMT)
Received: from osiris (unknown [9.171.89.199])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 25 Oct 2024 10:05:18 +0000 (GMT)
Date: Fri, 25 Oct 2024 12:05:16 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: arch/s390/mm/fault.c:566 do_secure_storage_access() warn:
 inconsistent returns '&mm->mmap_lock'.
Message-ID: <20241025100516.7541-B-hca@linux.ibm.com>
References: <5e4a2c40-9fc4-439a-8166-3a694e705d8e@stanley.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e4a2c40-9fc4-439a-8166-3a694e705d8e@stanley.mountain>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bGTE1v5lWVjbTpUNIiFH0Sm7m-1KdEOh
X-Proofpoint-GUID: bGTE1v5lWVjbTpUNIiFH0Sm7m-1KdEOh
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0
 mlxlogscore=749 clxscore=1011 impostorscore=0 mlxscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410250080

On Fri, Oct 25, 2024 at 10:35:47AM +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   c2ee9f594da826bea183ed14f2cc029c719bf4da
> commit: 7c194d84a9ce662426b2ecb59da54bb80c6b1d91 s390/mm,fault: remove VM_FAULT_BADMAP and VM_FAULT_BADACCESS
> config: s390-randconfig-r072-20241024 (https://download.01.org/0day-ci/archive/20241025/202410250552.XsMLl1sx-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 14.1.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202410250552.XsMLl1sx-lkp@intel.com/
> 
> smatch warnings:
> arch/s390/mm/fault.c:566 do_secure_storage_access() warn: inconsistent returns '&mm->mmap_lock'.
...
> 084ea4d611a3d0 Vasily Gorbik     2020-01-21  540  	case USER_FAULT:
> 084ea4d611a3d0 Vasily Gorbik     2020-01-21  541  		mm = current->mm;
> d8ed45c5dcd455 Michel Lespinasse 2020-06-08  542  		mmap_read_lock(mm);
> 084ea4d611a3d0 Vasily Gorbik     2020-01-21  543  		vma = find_vma(mm, addr);
> 7c194d84a9ce66 Heiko Carstens    2023-10-12  544  		if (!vma)
> 7c194d84a9ce66 Heiko Carstens    2023-10-12  545  			return handle_fault_error(regs, SEGV_MAPERR);
> 
> mmap_read_unlock() before returning?

This is a false positive: handle_fault_error() contains an unconditional
mmap_read_unlock() call. I would wish the __acquires() and __releases()
annotations would work better (or maybe I just can't figure out to use them
properly.

In any case: do_secure_storage_access() will very likely go away with the next
merge window and its functionality will be implemented differently.

