Return-Path: <linux-kernel+bounces-266512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD2E9400EE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 00:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477EF1F232E1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2545718EFCE;
	Mon, 29 Jul 2024 22:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjjqQHra"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E72118E771
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 22:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722291056; cv=none; b=PCSy0JqDdIeh0jpE7eBaT2B5YwhqQbZzVD9tv0J/jpy3jWPQYsffO5N7G6lnFm+2MyvCALKyZkC0XqGebtdrx5Ba7hoAodTwGzLflKkXzFczriJOc/8WRCjSnA7ztx1w61wpWgHJnvkTZYmHkANwSMPTGNpxFvSZ4nH/mABzoYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722291056; c=relaxed/simple;
	bh=lLtQf3assNkmEiSp09ywPzBfCbbRSh0zqiQlI3w0+YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzAEwlnvfcEo/xa1xEEupy1PF1EH5ce9Ad/xgOntcp9SqnrlX5BjJYh3pakpDCz8HsIwkudMF5uosw4y2yAs7Yi5x4Retx+1KK5VXbSeYOlUT74uqUAYRW3MuetGFX8x/PIlVU7KvNWtasUTHjx7385vZPNfYVHaoSVBF25FNto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjjqQHra; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2cb55ff1007so2304921a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 15:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722291054; x=1722895854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KsaV4aHVmDy9BEabdtZUIrUBdmxkjCnLJv1JmYCf5Ew=;
        b=YjjqQHradCOHX8S7lO6RJ1FN8rjPah3CRSjE9rjXAdps9zVgnnt2pZ1C/gzRLDxU4q
         ORA9939Lm6+js1vwLDspORkkn/5mt37ze4fjoQJxkjCYn8ZjuHf/g3BHKKyQ16Xf9vFV
         sT1HBsF7mdb+PEcp/kYmlKPJzLYBte9WQI8cwkGqmw0U1GDe+UoXXYg1kfKLjN7IbL1D
         Pc8qHqXeE8aZq6O+OMkodMOE4spyul28D5jTh7+qWUky4Wsmm1r5vO0kpmuHYT+Y4PY6
         VeInjd3YqCufhErIwWbOTGdQxI1QFLNtLhMrT7f3a9+y2SxoXhXlIJ+AX0WfVry0tP3h
         1crA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722291054; x=1722895854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsaV4aHVmDy9BEabdtZUIrUBdmxkjCnLJv1JmYCf5Ew=;
        b=s2lrroDeAK24lCiPv8wX+B7PQsib/g8FBbBT+TwHukKLngQcPbXvCXI1fRw9HjeZ9v
         9bOpSD7M8F7v9s1y844bV/rXxBE3nanR2jZvZobzSiyAkflD9dE7G7EMnqMVe6MYywzc
         otOyVp/mRGJjlaJdQhiXhV0CmjlDtVdOwjM8tpsqE0DJZzXTGAUDAOAjlvZU4LwYeOFF
         hRnyTOkxFdcCnJFqHOm8kxGpq7EvNOD4w2heO7A4pP8l5FTYSzBrj7/qWzL30ebFXQdD
         xAhI3rDvAhJTYTXg4QE+M1/fDjWiNC/4aAxwAalwZ+Hanem5wiRa/plyxWyj/hrlQzJY
         Loeg==
X-Forwarded-Encrypted: i=1; AJvYcCVa8Tbao8j5ODzrHTQHMie27fsbGW3h2LC+5xH4FiUbtL4Bgvb7Q8I5t/wcNETHYbQYm+qJegYA4l767phZN2BwyszaxN6UG1nPmm6s
X-Gm-Message-State: AOJu0Yz1+Tu+bl9LtafoeZQw5g1FlB6pgXaPdkjKNCogyLg/U1vjXyf4
	TO42cSoAshQ1TkTOAInaj8TOCBiX+dloJuXlJthYivHE6YWdOx7I
X-Google-Smtp-Source: AGHT+IHFgFcC7a2AZ2iDodzdSo6v8vO5cepaMu/+vRjjPgAt8xw8okI5cuuhotMAuv9cY44n3r+MCw==
X-Received: by 2002:a17:90b:4a0d:b0:2c9:9b65:af4d with SMTP id 98e67ed59e1d1-2cf7e098639mr6500208a91.7.1722291053817;
        Mon, 29 Jul 2024 15:10:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb74e9d4fsm11164225a91.35.2024.07.29.15.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 15:10:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 29 Jul 2024 15:10:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v7 16/23] powerpc/e500: Switch to 64 bits PGD on 85xx (32
 bits)
Message-ID: <2c7adbc9-609d-41a9-8a3b-a63d59e21a1f@roeck-us.net>
References: <cover.1719928057.git.christophe.leroy@csgroup.eu>
 <ca85397df02564e5edc3a3c27b55cf43af3e4ef3.1719928057.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca85397df02564e5edc3a3c27b55cf43af3e4ef3.1719928057.git.christophe.leroy@csgroup.eu>

Hi,

On Tue, Jul 02, 2024 at 03:51:28PM +0200, Christophe Leroy wrote:
> At the time being when CONFIG_PTE_64BIT is selected, PTE entries are
> 64 bits but PGD entries are still 32 bits.
> 
> In order to allow leaf PMD entries, switch the PGD to 64 bits entries.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

With this patch in the mainline kernel, all my boot tests based on the
mpc8544ds qemu emulation start crashing. Example crash log:

kernel BUG at include/linux/pgtable.h:1599!
Oops: Exception in kernel mode, sig: 5 [#1]
BE PAGE_SIZE=4K MPC8544 DS
Modules linked in:
CPU: 0 UID: 0 PID: 1 Comm: swapper Tainted: G                 N 6.11.0-rc1 #1
Tainted: [N]=TEST
Hardware name: MPC8544DS e500v2 0x80210030 MPC8544 DS
NIP:  c01f51b8 LR: c01f6fec CTR: 00000000
REGS: c4135c40 TRAP: 0700   Tainted: G                 N  (6.11.0-rc1)
MSR:  00029000 <CE,EE,ME>  CR: 24228288  XER: 20000000
GPR00: c01f6fc0 c4135d30 c415bf20 c762e3f0 c29c9318 c7624ff8 0000026b b5fc2ea1
GPR08: 00000000 00000000 5a5a5000 b7f4dd55 44228282 00000000 c0005014 00000000
GPR16: 00000000 00000000 00000001 00050003 24228282 24228282 00000000 00000095
GPR24: c1375b30 c4135de8 c4135e48 00050003 c762e3a0 c762e3f0 bffffff1 c7676a08
NIP [c01f51b8] pmd_write.constprop.0.isra.0+0x4/0x8
LR [c01f6fec] follow_page_mask+0x150/0x17c
Call Trace:
[c4135d30] [c4135de8] 0xc4135de8 (unreliable)
[c4135d40] [c01f6fc0] follow_page_mask+0x124/0x17c
[c4135d70] [c01f7170] __get_user_pages+0x158/0x5d8
[c4135dd0] [c01f7750] get_user_pages_remote+0x160/0x560
[c4135e30] [c026838c] get_arg_page+0xb0/0x25c
[c4135e70] [c0268dd4] copy_string_kernel+0xf0/0x200
[c4135eb0] [c026a0e4] kernel_execve+0xbc/0x190
[c4135ee0] [c0005108] kernel_init+0xf4/0x1d4
[c4135f00] [c0016224] ret_from_kernel_user_thread+0x10/0x18

This is with v6.11-rc1; the actually observed crash differs from test
to test while running bisect.

I can't just revert the patch because subsequent patches depend on it.
Is this confirmed to work on real hardware ? If so, do you have a
suggestion how I could continue to use the mpc8544ds emulation for
testing, or is it just dead ?

For reference, the configuration file is mpc85xx_defconfig.
Bisect log is attached.

Thanks,
Guenter

---
# bad: [8400291e289ee6b2bf9779ff1c83a291501f017b] Linux 6.11-rc1
# good: [2c9b3512402ed192d1f43f4531fb5da947e72bd0] Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
git bisect start 'v6.11-rc1' '2c9b3512402e'
# bad: [6dc2e98d5f1de162d1777aee97e59d75d70d07c5] s390: Remove protvirt and kvm config guards for uv code
git bisect bad 6dc2e98d5f1de162d1777aee97e59d75d70d07c5
# bad: [30d77b7eef019fa4422980806e8b7cdc8674493e] mm/mglru: fix ineffective protection calculation
git bisect bad 30d77b7eef019fa4422980806e8b7cdc8674493e
# good: [c02525a33969000fa7b595b743deb4d79804916b] ftrace: unpoison ftrace_regs in ftrace_ops_list_func()
git bisect good c02525a33969000fa7b595b743deb4d79804916b
# good: [8ef6fd0e9ea83a792ba53882ddc6e0d38ce0d636] Merge branch 'mm-hotfixes-stable' into mm-stable to pick up "mm: fix crashes from deferred split racing folio migration", needed by "mm: migrate: split folio_migrate_mapping()".
git bisect good 8ef6fd0e9ea83a792ba53882ddc6e0d38ce0d636
# good: [a898530eea3d0ba08c17a60865995a3bb468d1bc] powerpc/64e: split out nohash Book3E 64-bit code
git bisect good a898530eea3d0ba08c17a60865995a3bb468d1bc
# bad: [00f58104202c472e487f0866fbd38832523fd4f9] mm: fix khugepaged activation policy
git bisect bad 00f58104202c472e487f0866fbd38832523fd4f9
# good: [e081c14744f4a93514069e1af1a7273d5451b909] powerpc/e500: remove enc and ind fields from struct mmu_psize_def
git bisect good e081c14744f4a93514069e1af1a7273d5451b909
# bad: [57fb15c32f4f6a4f1a58f1fbc58a799c3f975ed8] powerpc/64s: use contiguous PMD/PUD instead of HUGEPD
git bisect bad 57fb15c32f4f6a4f1a58f1fbc58a799c3f975ed8
# bad: [276d5affbbaea4d369d1e5b9711cb2951037f6ee] powerpc/e500: don't pre-check write access on data TLB error
git bisect bad 276d5affbbaea4d369d1e5b9711cb2951037f6ee
# bad: [84319905ca5f3759c42082e20ed978c81f4dead0] powerpc/e500: encode hugepage size in PTE bits
git bisect bad 84319905ca5f3759c42082e20ed978c81f4dead0
# bad: [6b0e82791bd03b2326c7f7d8c1124c825742f2a4] powerpc/e500: switch to 64 bits PGD on 85xx (32 bits)
git bisect bad 6b0e82791bd03b2326c7f7d8c1124c825742f2a4
# first bad commit: [6b0e82791bd03b2326c7f7d8c1124c825742f2a4] powerpc/e500: switch to 64 bits PGD on 85xx (32 bits)

