Return-Path: <linux-kernel+bounces-524536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D3AA3E443
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C1E97A98CA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3404626388E;
	Thu, 20 Feb 2025 18:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cO/HoZGB"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC432135D0;
	Thu, 20 Feb 2025 18:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077640; cv=none; b=FM5g67/a/JISV4trlHB+pYI5YMEzJrmuRc+QaUeIoD3OMvvNpWy6Bepo3pXFyedRKm/ONIdu0FqiPnS0SFYvuRpwPtxcvELlPNDIP02+7P94OI6e453Cfqr6CNZg+ia24zRpFCqT8dWT4LYW+EWZK4pYBpxitp5FoczgTfPFU2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077640; c=relaxed/simple;
	bh=XNtukd/iR2xFzEJm4rMWbl1qhijVvclvodxQjnS4AR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLwtrv30TZTCXtumDCbESX+jGT7qjnnU3qy/3UdcZQrabONgWsYxRbUy+WA4NzDC6WnGOgBQdWUklzxJS7lMRJMxtQYOvaW8xccSXtpYYvYFs/Y2ZiaA7792SCOgsyqRFHlVIiH5jtxfaz/lZMrvuf+Ibordi0tPei6NGeVTb6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cO/HoZGB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KH1dWO013458;
	Thu, 20 Feb 2025 18:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=/9sRpAZ9G3ZPyhkT4SYRP5eAvs3Bmr
	FCqGMSaKHucN4=; b=cO/HoZGBBDgyQ3+wAOCIEngTbBbh+7fO13/1YamnWNXEil
	u8zaNKFRabvG/FSoNrXbM3nmJitWZ4wTJD/5oHnICYWLfKWYQpfay+B+3UmNLi4a
	wEEHnsfHIma02MGEG+7IkYImPzHjA9t3R1erwYdh5bW/EPDJf8ctDuhhwnl/IZVC
	Q1xajmxr5hVEKaSmjFKS6IPrUO1NoFg0s2vDnNaxoBzRz+WMGEV/hL/MJA3zF38Q
	yVAGP84ZxD8GAzVMcMCs+99x9vl1ngr0vduaVeXoDxxfWXDKhUhLn0RrqKcDupM6
	TmIY7yfKHiKng16RNt3tfi400kkyxJ7FnoVXJGaA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wreadapw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 18:53:12 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51KIrBX4004848;
	Thu, 20 Feb 2025 18:53:11 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wreadapt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 18:53:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KI7x6h005826;
	Thu, 20 Feb 2025 18:53:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w02xkn49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 18:53:10 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51KIr8gA39846268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 18:53:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D4CC20043;
	Thu, 20 Feb 2025 18:53:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CEE020040;
	Thu, 20 Feb 2025 18:53:06 +0000 (GMT)
Received: from osiris (unknown [9.171.52.26])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 20 Feb 2025 18:53:06 +0000 (GMT)
Date: Thu, 20 Feb 2025 19:53:04 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, peterz@infradead.org, willy@infradead.org,
        liam.howlett@oracle.com, lorenzo.stoakes@oracle.com,
        david.laight.linux@gmail.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com,
        mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
        oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org,
        brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com,
        hughd@google.com, lokeshgidra@google.com, minchan@google.com,
        jannh@google.com, shakeel.butt@linux.dev, souravpanda@google.com,
        pasha.tatashin@soleen.com, klarasmodin@gmail.com,
        richard.weiyang@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v10 12/18] mm: replace vm_lock and detached flag with a
 reference count
Message-ID: <20250220185304.8313A7d-hca@linux.ibm.com>
References: <20250213224655.1680278-1-surenb@google.com>
 <20250213224655.1680278-13-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213224655.1680278-13-surenb@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: M-vGldV3REsWVvBOwJDEiV9dEv7a8khD
X-Proofpoint-GUID: LuM4Ib9qTs5DatP339mkaUEvtZKh3JTf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_08,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 impostorscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0
 mlxlogscore=842 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200128

On Thu, Feb 13, 2025 at 02:46:49PM -0800, Suren Baghdasaryan wrote:
...
> While this vm_lock replacement does not yet result in a smaller
> vm_area_struct (it stays at 256 bytes due to cacheline alignment), it
> allows for further size optimization by structure member regrouping
> to bring the size of vm_area_struct below 192 bytes.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
> Changes since v9 [1]:
> - Use __refcount_inc_not_zero_limited_acquire() in vma_start_read(),
> per Hillf Danton
> - Refactor vma_assert_locked() to avoid vm_refcnt read when CONFIG_DEBUG_VM=n,
> per Mateusz Guzik
> - Update changelog, per Wei Yang
> - Change vma_start_read() to return EAGAIN if vma got isolated and changed
> lock_vma_under_rcu() back to detect this condition, per Wei Yang
> - Change VM_BUG_ON_VMA() to WARN_ON_ONCE() when checking vma detached state,
> per Lorenzo Stoakes
> - Remove Vlastimil's Reviewed-by since code is changed

This causes crashes (NULL pointer deref) with linux-next when running
the ltp test suite; mtest06 (mmap1) test case.

The bug seems to be quite obvious:

> @@ -6424,15 +6492,18 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>  	if (!vma)
>  		goto inval;
>  
> -	if (!vma_start_read(vma))
> -		goto inval;
> +	vma = vma_start_read(vma);
> +	if (IS_ERR_OR_NULL(vma)) {
            ^^^^^^^^^^^^^^^^^^^
> +		/* Check if the VMA got isolated after we found it */
> +		if (PTR_ERR(vma) == -EAGAIN) {
> +			vma_end_read(vma);
                        ^^^^^^^^^^^^^^^^

