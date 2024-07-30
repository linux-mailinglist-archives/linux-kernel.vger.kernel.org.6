Return-Path: <linux-kernel+bounces-266718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6A09405D2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 05:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A22BD283190
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F811465A7;
	Tue, 30 Jul 2024 03:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0hU4UYZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9C81854
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 03:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722309826; cv=none; b=ucZw6reO2p/S8IDbAbkHCXHFlffOYaHEWFtaAhO6bMiYZBz9xG2Elalmvpqe8D4kCsWNAfttsl1a5Pe0tpTKhYaSSsBIc28v++8dXA6FCbzr2ZSIeR/MVHQfpWTRq9aDMZLL95+0DcIhRRZIusHZgRYgZOkB/shWoGKJ8dylflg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722309826; c=relaxed/simple;
	bh=LPHiNM/ySxmb7ADe95ep1YgztC8+yncxDwt9We8X1WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRdLEDf5hDp6YKaixOXVWnrBuPva1yPH3O30+A8zUtdNX0TgJjPgHAfL0hZRMwr5YBZfNYgMRRyFAliOyvjfzse0bvaIlu+Wl2VOeS9Tk4l987yTwGGMRPYhWh5omtXxyNBLSP3ZGist2Ue+OyNczCDtP4Mb+NdsDpDM37VphTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A0hU4UYZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722309823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GtrNBkDdZPh+gPccVoPZA+x1HvmaEjVmj6LGnN30uJQ=;
	b=A0hU4UYZq8LyY159qEr9+cQo0UeF6sF3AZCyj9Glgmv/mFPaEuNpDoqGqW7Hu5l9CrDOYc
	5/1fH6TU3WZmYyqdd6Q1mqE1pqlKqn9VmL7pCqySYvZG4VHaELDOAqULszzOPp0/qWeoGF
	W/szhIEZwYXD6roNxrA45fSZR3wxD9w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-GuyB0HIGPIOzdZ3lFXzQnA-1; Mon,
 29 Jul 2024 23:23:41 -0400
X-MC-Unique: GuyB0HIGPIOzdZ3lFXzQnA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 189041955D45;
	Tue, 30 Jul 2024 03:23:39 +0000 (UTC)
Received: from localhost (unknown [10.72.112.91])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9657B19560AE;
	Tue, 30 Jul 2024 03:23:37 +0000 (UTC)
Date: Tue, 30 Jul 2024 11:23:33 +0800
From: Baoquan He <bhe@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: kernel/iomem.c:18:32: sparse: sparse: cast truncates bits from
 constant value (38400000050e becomes 50e)
Message-ID: <ZqhctcU7UHxIGs3R@MiWiFi-R3L-srv>
References: <202407282201.lk1cNoMd-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202407282201.lk1cNoMd-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 07/28/24 at 10:43pm, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5437f30d3458ad36e83ab96088d490ebfee844d8
> commit: 0453c9a78015cb2219cda7239d881f4e3137bff8 sh: mm: convert to GENERIC_IOREMAP
> date:   12 months ago
> config: sh-randconfig-r133-20240727 (https://download.01.org/0day-ci/archive/20240728/202407282201.lk1cNoMd-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 14.1.0
> reproduce: (https://download.01.org/0day-ci/archive/20240728/202407282201.lk1cNoMd-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407282201.lk1cNoMd-lkp@intel.com/

I every tried to fix this when I got this report one year ago. The thing
is I found there are many places like this. I am not sure if it's worth
doing the type casting to satisfy sparse. And the type casting makes
very long line of code and reduce readibility.

If this is confirmed worth, I can post patch to fix them.

> 
> sparse warnings: (new ones prefixed by >>)
>    kernel/iomem.c:113:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[assigned] addr @@     got void [noderef] __iomem * @@
>    kernel/iomem.c:113:22: sparse:     expected void *[assigned] addr
>    kernel/iomem.c:113:22: sparse:     got void [noderef] __iomem *
>    kernel/iomem.c:116:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[assigned] addr @@     got void [noderef] __iomem * @@
>    kernel/iomem.c:116:22: sparse:     expected void *[assigned] addr
>    kernel/iomem.c:116:22: sparse:     got void [noderef] __iomem *
> >> kernel/iomem.c:18:32: sparse: sparse: cast truncates bits from constant value (38400000050e becomes 50e)
>    kernel/iomem.c: note: in included file (through include/linux/gfp.h, include/linux/xarray.h, include/linux/radix-tree.h, ...):
>    include/linux/mmzone.h:1997:40: sparse: sparse: self-comparison always evaluates to false
> --
>    arch/sh/boards/board-sh7785lcr.c:298:13: sparse: sparse: symbol 'init_sh7785lcr_IRQ' was not declared. Should it be static?
>    arch/sh/boards/board-sh7785lcr.c:322:11: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char *p @@     got void [noderef] __iomem * @@
>    arch/sh/boards/board-sh7785lcr.c:322:11: sparse:     expected unsigned char *p
>    arch/sh/boards/board-sh7785lcr.c:322:11: sparse:     got void [noderef] __iomem *
> >> arch/sh/boards/board-sh7785lcr.c:328:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char *p @@
>    arch/sh/boards/board-sh7785lcr.c:328:17: sparse:     expected void volatile [noderef] __iomem *addr
>    arch/sh/boards/board-sh7785lcr.c:328:17: sparse:     got unsigned char *p
>    arch/sh/boards/board-sh7785lcr.c: note: in included file (through arch/sh/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
> >> include/asm-generic/io.h:1089:41: sparse: sparse: cast truncates bits from constant value (384000000506 becomes 506)
> --
>    drivers/spi/spi-sh-sci.c: note: in included file (through arch/sh/include/asm/io.h, include/linux/scatterlist.h, include/linux/spi/spi.h):
> >> include/asm-generic/io.h:1089:41: sparse: sparse: cast truncates bits from constant value (384000000506 becomes 506)
> --
>    drivers/spi/spi-nxp-fspi.c:513:25: sparse: sparse: cast from restricted __be32
>    drivers/spi/spi-nxp-fspi.c: note: in included file (through arch/sh/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
> >> include/asm-generic/io.h:1089:41: sparse: sparse: cast truncates bits from constant value (384000000506 becomes 506)
> --
>    drivers/scsi/esas2r/esas2r_init.c:908:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] length @@     got restricted __le32 [usertype] @@
>    drivers/scsi/esas2r/esas2r_init.c:908:41: sparse:     expected unsigned int [usertype] length
>    drivers/scsi/esas2r/esas2r_init.c:908:41: sparse:     got restricted __le32 [usertype]
>    drivers/scsi/esas2r/esas2r_init.c:1164:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sgl_page_size @@     got restricted __le32 [usertype] @@
>    drivers/scsi/esas2r/esas2r_init.c:1164:35: sparse:     expected unsigned int [usertype] sgl_page_size
>    drivers/scsi/esas2r/esas2r_init.c:1164:35: sparse:     got restricted __le32 [usertype]
>    drivers/scsi/esas2r/esas2r_init.c:1166:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] epoch_time @@     got restricted __le32 [usertype] @@
>    drivers/scsi/esas2r/esas2r_init.c:1166:32: sparse:     expected unsigned int [usertype] epoch_time
>    drivers/scsi/esas2r/esas2r_init.c:1166:32: sparse:     got restricted __le32 [usertype]
>    drivers/scsi/esas2r/esas2r_init.c:1178:41: sparse: sparse: cast to restricted __le16
>    drivers/scsi/esas2r/esas2r_init.c:1178:41: sparse: sparse: cast to restricted __le16
>    drivers/scsi/esas2r/esas2r_init.c:1178:41: sparse: sparse: cast to restricted __le16
>    drivers/scsi/esas2r/esas2r_init.c:1178:41: sparse: sparse: cast to restricted __le16
>    drivers/scsi/esas2r/esas2r_init.c:1181:38: sparse: sparse: cast to restricted __le16
>    drivers/scsi/esas2r/esas2r_init.c:1181:38: sparse: sparse: cast to restricted __le16
>    drivers/scsi/esas2r/esas2r_init.c:1181:38: sparse: sparse: cast to restricted __le16
>    drivers/scsi/esas2r/esas2r_init.c:1181:38: sparse: sparse: cast to restricted __le16
>    drivers/scsi/esas2r/esas2r_init.c:1196:25: sparse: sparse: cast to restricted __be32
>    drivers/scsi/esas2r/esas2r_init.c:1207:56: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] ctl_len @@     got restricted __le32 [usertype] @@
>    drivers/scsi/esas2r/esas2r_init.c:1207:56: sparse:     expected unsigned int [usertype] ctl_len
>    drivers/scsi/esas2r/esas2r_init.c:1207:56: sparse:     got restricted __le32 [usertype]
>    drivers/scsi/esas2r/esas2r_init.c:1209:56: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] address @@     got restricted __le64 [usertype] @@
>    drivers/scsi/esas2r/esas2r_init.c:1209:56: sparse:     expected unsigned long long [usertype] address
>    drivers/scsi/esas2r/esas2r_init.c:1209:56: sparse:     got restricted __le64 [usertype]
>    drivers/scsi/esas2r/esas2r_init.c:1223:41: sparse: sparse: cast to restricted __le32
>    drivers/scsi/esas2r/esas2r_init.c:1223:41: sparse: sparse: cast to restricted __le32
>    drivers/scsi/esas2r/esas2r_init.c:1223:41: sparse: sparse: cast to restricted __le32
>    drivers/scsi/esas2r/esas2r_init.c:1223:41: sparse: sparse: cast to restricted __le32
>    drivers/scsi/esas2r/esas2r_init.c:1223:41: sparse: sparse: cast to restricted __le32
>    drivers/scsi/esas2r/esas2r_init.c:1223:41: sparse: sparse: cast to restricted __le32
>    drivers/scsi/esas2r/esas2r_init.c:1225:41: sparse: sparse: cast to restricted __le32
>    drivers/scsi/esas2r/esas2r_init.c:1225:41: sparse: sparse: cast to restricted __le32
>    drivers/scsi/esas2r/esas2r_init.c:1225:41: sparse: sparse: cast to restricted __le32
>    drivers/scsi/esas2r/esas2r_init.c:1225:41: sparse: sparse: cast to restricted __le32
>    drivers/scsi/esas2r/esas2r_init.c:1225:41: sparse: sparse: cast to restricted __le32
>    drivers/scsi/esas2r/esas2r_init.c:1225:41: sparse: sparse: cast to restricted __le32
>    drivers/scsi/esas2r/esas2r_init.c: note: in included file (through arch/sh/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
> >> include/asm-generic/io.h:1089:41: sparse: sparse: cast truncates bits from constant value (384000000506 becomes 506)
> >> include/asm-generic/io.h:1089:41: sparse: sparse: cast truncates bits from constant value (384000000506 becomes 506)
>    drivers/scsi/esas2r/esas2r_init.c:286:15: sparse: sparse: memset with byte count of 557736
>    drivers/scsi/esas2r/esas2r_init.c: note: in included file:
>    drivers/scsi/esas2r/esas2r.h:1260:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] ppsense_buf @@     got restricted __le64 [usertype] @@
>    drivers/scsi/esas2r/esas2r.h:1260:17: sparse:     expected unsigned long long [usertype] ppsense_buf
>    drivers/scsi/esas2r/esas2r.h:1260:17: sparse:     got restricted __le64 [usertype]
>    drivers/scsi/esas2r/esas2r.h:1260:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] ppsense_buf @@     got restricted __le64 [usertype] @@
>    drivers/scsi/esas2r/esas2r.h:1260:17: sparse:     expected unsigned long long [usertype] ppsense_buf
>    drivers/scsi/esas2r/esas2r.h:1260:17: sparse:     got restricted __le64 [usertype]
> 
> vim +18 kernel/iomem.c
> 
> 5981690ddb8f72 Dan Williams 2018-03-29  14  
> 5981690ddb8f72 Dan Williams 2018-03-29  15  #ifndef arch_memremap_wb
> 5981690ddb8f72 Dan Williams 2018-03-29  16  static void *arch_memremap_wb(resource_size_t offset, unsigned long size)
> 5981690ddb8f72 Dan Williams 2018-03-29  17  {
> 5981690ddb8f72 Dan Williams 2018-03-29 @18  	return (__force void *)ioremap_cache(offset, size);
> 5981690ddb8f72 Dan Williams 2018-03-29  19  }
> 5981690ddb8f72 Dan Williams 2018-03-29  20  #endif
> 5981690ddb8f72 Dan Williams 2018-03-29  21  
> 
> :::::: The code at line 18 was first introduced by commit
> :::::: 5981690ddb8f72f9546a2d017a914cf56095fc1f memremap: split devm_memremap_pages() and memremap() infrastructure
> 
> :::::: TO: Dan Williams <dan.j.williams@intel.com>
> :::::: CC: Dan Williams <dan.j.williams@intel.com>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 


