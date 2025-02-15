Return-Path: <linux-kernel+bounces-516135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E723A36D48
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 11:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFB34170D6D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 10:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5ED1A2642;
	Sat, 15 Feb 2025 10:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+hGUZI9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58D0155CB3
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739615106; cv=none; b=gKL6Q2Pc7AGijf8i8ONdqXfmdSMGkmbVPpRXlttcpAY++4Gmj6oyOZTP4iXGQ5Mf4ppwkgf1UaraIqpadbqqda47fNDhvZyrvz97DSMR6t8KZoHwBDFA3AMqLySR/qRyuGynkKhbmK5pGVFfGvViHQXElw9yFFTQpBxnmcVvjTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739615106; c=relaxed/simple;
	bh=9xNLXOo2q2bVrWlk34RqPRRCzEbJY4gHbShAdtSVDjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEGzOnOOjpL8DP++98UzsZxGJJ/cozWGZ1cCVSJjrzxxN6GzrH0CSRm5h9rZ4i0b/DFnLOuoxo75rsDURAT5NggIhDt6uspau/23yuyHd3R5igz4j3qC53z6CA5kvhEx8YZwFCRudDzXwinsdHcimsTfsqEfAhp3sEJKRtjkDYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R+hGUZI9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739615103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ywkakhDb6C9zHP7TcT3WogD7vHQ564M3tb1gpNfgvE4=;
	b=R+hGUZI99uWKOCqq/uzoIsH8/ZMKKTJfO7zTWq6Cmqe1ZX1BpRYBteBhRd52ZK1uhWVvqq
	btpyN6b9YGv3Hv0zaLyTPySAwnUuJFFsi+1/wsiAJdYbxNsB60PbcLrPpFhqywf87L4ufy
	LPUxxoaMt7Y2zmglzQrPsAYo6ZF7VUc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-HpNZMEPpPxWx_9DC5rBgYQ-1; Sat,
 15 Feb 2025 05:24:59 -0500
X-MC-Unique: HpNZMEPpPxWx_9DC5rBgYQ-1
X-Mimecast-MFC-AGG-ID: HpNZMEPpPxWx_9DC5rBgYQ_1739615097
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5DDBE180034E;
	Sat, 15 Feb 2025 10:24:57 +0000 (UTC)
Received: from localhost (unknown [10.72.112.76])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F105180087D;
	Sat, 15 Feb 2025 10:24:55 +0000 (UTC)
Date: Sat, 15 Feb 2025 18:24:50 +0800
From: Baoquan He <bhe@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: kernel/vmcore_info.c:117 paddr_vmcoreinfo_note() warn: unsigned
 '_x' is never less than zero.
Message-ID: <Z7Brcjzuh+SG/io1@MiWiFi-R3L-srv>
References: <202502141843.5QoKdQ7g-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202502141843.5QoKdQ7g-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 02/14/25 at 06:44pm, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   128c8f96eb8638c060cd3532dc394d046ce64fe1
> commit: 443cbaf9e2fdbef7d7cae457434a6cb8a679441b crash: split vmcoreinfo exporting code out from crash_core.c
> date:   12 months ago
> config: riscv-randconfig-r073-20250213 (https://download.01.org/0day-ci/archive/20250214/202502141843.5QoKdQ7g-lkp@intel.com/config)
> compiler: riscv32-linux-gcc (GCC) 14.2.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202502141843.5QoKdQ7g-lkp@intel.com/
> 
> smatch warnings:
> kernel/vmcore_info.c:117 paddr_vmcoreinfo_note() warn: unsigned '_x' is never less than zero.

Thanks for reporting this.

I am preparing to reproduce this issue, while I may not know what are
the steps to reproduce.  Just run smatch or just build with the provided
riscv-randconfig-r073-20250213?

> 
> vim +/_x +117 kernel/vmcore_info.c
> 
>    114	
>    115	phys_addr_t __weak paddr_vmcoreinfo_note(void)
>    116	{
>  > 117		return __pa(vmcoreinfo_note);
>    118	}
>    119	EXPORT_SYMBOL(paddr_vmcoreinfo_note);
>    120	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 


