Return-Path: <linux-kernel+bounces-559014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BC9A5EE5C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F34C168930
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD63263886;
	Thu, 13 Mar 2025 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kiag9Sb+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C366E262D2F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855743; cv=none; b=i8ot7+VVFaIYtwpscLLE8rNhgoZmD4ut9fAmNYbSrHdET/GfrUa8zD19jGr5U9ocSj5Fa0bG6s60vNCIsrbyaCFRdgSQpkynlRAhOfNd+o1T69oAkDd5U2C08XZyj0T0AJNGpKPv9rihZHeAwzITwyA8g5LFw4A7joOgbNkkYSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855743; c=relaxed/simple;
	bh=9f0JOqyRUMhXsUhRmX2GVvdZOo3DRyh/LFwUWvB8TxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOl23OwNyIJ5jnY3fKOXlPzoa81ZRWQrSCeW6tgGYYyhWqhiDnGQCcfGlgHJih/KA6+RgYdhQlSIs+SEGroMm5vSoRd3hErag0C/0Mfc5lMYDSsgPVFnmH3s0jeDbd/Nl38qyvBxnSkPoix5oVlE7vgXEtuDDaMGPaTEyx+6rz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kiag9Sb+; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741855740; x=1773391740;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9f0JOqyRUMhXsUhRmX2GVvdZOo3DRyh/LFwUWvB8TxM=;
  b=Kiag9Sb+zDXU1oZYBX28RHz92n56OzdFR3HLZq2Ggdd8xP7kK2bFz+PH
   kzrgEv8fu1ePR/N6j0X10Robh+p/ja8UsGrr9YeS5ysJ1Y+jnfCwgOlH5
   l6G7kWPrJ0geIGdCAa9T1SZbampGVRHDJMSsEaCeyMU8VCsEZhUWfmD4Z
   gab7XuvIi2EcxSq4QBU95SUxVjdJSiQ3nf0Vx4t+OcNwhokdwp815psRt
   heJKR1RyEol/1DvxXGSEiWPkQemkHTJhKBqwmag2fxZdEjnVLX6dHETOY
   Xn916YBoBacPY+GcEB+QPRgFLfgaQRMmipie181mgaoWAKcJUmgs33qRv
   g==;
X-CSE-ConnectionGUID: q9Uej9OhRWaes6lz+jVcgA==
X-CSE-MsgGUID: C8WTr1vBRg2CfC5xb/56IQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="68316865"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="68316865"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 01:48:59 -0700
X-CSE-ConnectionGUID: usuzdrgKRqCI5BX5Ll9AWA==
X-CSE-MsgGUID: kZ1hbXwuR66meUsS/FUERg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="121811468"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 01:48:57 -0700
Date: Thu, 13 Mar 2025 16:49:19 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Liu Ye <liuye@kylinos.cn>
Cc: akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, yi1.lai@intel.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] mm/vmalloc: Move free_vm_area(area) from the
 __vmalloc_area_node function to the __vmalloc_node_range_noprof function
Message-ID: <Z9KcD/7kpZpuDfHV@ly-workstation>
References: <20250303015702.319416-1-liuye@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303015702.319416-1-liuye@kylinos.cn>

On Mon, Mar 03, 2025 at 09:57:02AM +0800, Liu Ye wrote:
> Moved free_vm_area from the __vmalloc_area_node function to the
> __vmalloc_node_range_noprof function so that allocation and freeing
> of the area can be paired in one function for better readability.
> 
> Signed-off-by: Liu Ye <liuye@kylinos.cn>
> ---
>  mm/vmalloc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index a6e7acebe9ad..dc658d4af181 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3651,7 +3651,6 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  		warn_alloc(gfp_mask, NULL,
>  			"vmalloc error: size %lu, failed to allocated page array size %lu",
>  			nr_small_pages * PAGE_SIZE, array_size);
> -		free_vm_area(area);
>  		return NULL;
>  	}
>  
> @@ -3844,8 +3843,10 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
>  
>  	/* Allocate physical pages and map them into vmalloc space. */
>  	ret = __vmalloc_area_node(area, gfp_mask, prot, shift, node);
> -	if (!ret)
> +	if (!ret) {
> +		free_vm_area(area);
>  		goto fail;
> +	}
>  
>  	/*
>  	 * Mark the pages as accessible, now that they are mapped.
> -- 
> 2.25.1
>
Hi Liu Yue,

Greetings!

I used Syzkaller and found that there is KASAN: slab-use-after-free Read in iommufd_test in linux-next tag - next-20250311.

After bisection and the first bad commit is:
"
35388cb1e37e mm/vmalloc: move free_vm_area(area) from the __vmalloc_area_node function to the __vmalloc_node_range_noprof function
"

All detailed into can be found at:
https://github.com/laifryiee/syzkaller_logs/tree/main/250312_233425_iommufd_test
Syzkaller repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/250312_233425_iommufd_test/repro.c
Syzkaller repro syscall steps:
https://github.com/laifryiee/syzkaller_logs/tree/main/250312_233425_iommufd_test/repro.prog
Syzkaller report:
https://github.com/laifryiee/syzkaller_logs/tree/main/250312_233425_iommufd_test/repro.report
Kconfig(make olddefconfig):
https://github.com/laifryiee/syzkaller_logs/tree/main/250312_233425_iommufd_test/kconfig_origin
Bisect info:
https://github.com/laifryiee/syzkaller_logs/tree/main/250312_233425_iommufd_test/bisect_info.log
bzImage:
https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/250312_233425_iommufd_test/bzImage_eea255893718268e1ab852fb52f70c613d109b99
Issue dmesg:
https://github.com/laifryiee/syzkaller_logs/blob/main/250312_233425_iommufd_test/eea255893718268e1ab852fb52f70c613d109b99_dmesg.log

"
[   22.060519]  ? __vmalloc_node_range_noprof+0x1344/0x1420
[   22.060529]  __asan_report_load8_noabort+0x18/0x20
[   22.060540]  __vmalloc_node_range_noprof+0x1344/0x1420
[   22.060552]  ? iommufd_test+0x2d8/0x4b00
[   22.060565]  ? __pfx___vmalloc_node_range_noprof+0x10/0x10
[   22.060575]  ? debug_smp_processor_id+0x20/0x30
[   22.060588]  __kvmalloc_node_noprof+0x2a9/0x6a0
[   22.060596]  ? iommufd_test+0x2d8/0x4b00
[   22.060603]  ? __fget_files+0x204/0x3b0
[   22.060613]  ? iommufd_test+0x2d8/0x4b00
[   22.060623]  iommufd_test+0x2d8/0x4b00
[   22.060629]  ? iommufd_test+0x2d8/0x4b00
[   22.060637]  ? __this_cpu_preempt_check+0x21/0x30
[   22.060650]  ? __pfx_iommufd_test+0x10/0x10
[   22.060661]  ? __might_fault+0xf1/0x1b0
[   22.060672]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[   22.060683]  iommufd_fops_ioctl+0x38e/0x520
[   22.060693]  ? __pfx_iommufd_fops_ioctl+0x10/0x10
[   22.060704]  ? __this_cpu_preempt_check+0x21/0x30
[   22.060713]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
[   22.060723]  ? lockdep_hardirqs_on+0x89/0x110
[   22.060734]  ? ktime_get_coarse_real_ts64+0xb6/0x100
[   22.060745]  ? __pfx_iommufd_fops_ioctl+0x10/0x10
[   22.060754]  __x64_sys_ioctl+0x1ba/0x220
[   22.060764]  x64_sys_call+0x1233/0x2150
[   22.060771]  do_syscall_64+0x6d/0x140
[   22.060780]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   22.060787] RIP: 0033:0x7f60b7c3ee5d
[   22.060793] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
[   22.060800] RSP: 002b:00007ffe0d196758 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
[   22.060807] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f60b7c3ee5d
[   22.060811] RDX: 0000000020000440 RSI: 0000000000003ba0 RDI: 0000000000000003
[   22.060815] RBP: 00007ffe0d196770 R08: 00007ffe0d196770 R09: 00007ffe0d196770
[   22.060820] R10: 00007ffe0d196770 R11: 0000000000000213 R12: 00007ffe0d1968c8
[   22.060824] R13: 000000000040188f R14: 0000000000403e08 R15: 00007f60b800d000
[   22.060835]  </TASK>
[   22.060840]
[   22.072913] Allocated by task 1316:
[   22.073094]  kasan_save_stack+0x2c/0x60
[   22.073298]  kasan_save_track+0x18/0x40
[   22.073499]  kasan_save_alloc_info+0x3c/0x50
[   22.073723]  __kasan_kmalloc+0x88/0xa0
[   22.073926]  __kmalloc_cache_node_noprof+0x1d0/0x470
[   22.074179]  __get_vm_area_node+0xf7/0x260
[   22.074391]  __vmalloc_node_range_noprof+0x25c/0x1420
[   22.074650]  __kvmalloc_node_noprof+0x2a9/0x6a0
[   22.074888]  iommufd_test+0x2d8/0x4b00
[   22.075085]  iommufd_fops_ioctl+0x38e/0x520
[   22.075308]  __x64_sys_ioctl+0x1ba/0x220
[   22.075517]  x64_sys_call+0x1233/0x2150
[   22.075719]  do_syscall_64+0x6d/0x140
[   22.075917]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   22.076171]
[   22.076261] Freed by task 1316:
[   22.076428]  kasan_save_stack+0x2c/0x60
[   22.076628]  kasan_save_track+0x18/0x40
[   22.076833]  kasan_save_free_info+0x3f/0x60
[   22.077054]  __kasan_slab_free+0x3d/0x60
[   22.077258]  kfree+0x28d/0x440
[   22.077423]  vfree+0x2ce/0x910
[   22.077590]  __vmalloc_node_range_noprof+0xeca/0x1420
[   22.077854]  __kvmalloc_node_noprof+0x2a9/0x6a0
[   22.078094]  iommufd_test+0x2d8/0x4b00
[   22.078293]  iommufd_fops_ioctl+0x38e/0x520
[   22.078512]  __x64_sys_ioctl+0x1ba/0x220
[   22.078724]  x64_sys_call+0x1233/0x2150
[   22.078931]  do_syscall_64+0x6d/0x140
[   22.079128]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   22.079388]
[   22.079478] The buggy address belongs to the object at ffff88804f5ce500
[   22.079478]  which belongs to the cache kmalloc-64 of size 64
[   22.080073] The buggy address is located 8 bytes inside of
[   22.080073]  freed 64-byte region [ffff88804f5ce500, ffff88804f5ce540)
[   22.080655]
[   22.080744] The buggy address belongs to the physical page:
[   22.081024] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4f5ce
[   22.081415] flags: 0xfffffc0000000(node=0|zone=1|lastcpupid=0x1fffff)
[   22.081742] page_type: f5(slab)
[   22.081917] raw: 000fffffc0000000 ffff88800d4418c0 dead000000000122 0000000000000000
[   22.082297] raw: 0000000000000000 0000000000200020 00000000f5000000 0000000000000000
[   22.082678] page dumped because: kasan: bad access detected
[   22.082956]
[   22.083045] Memory state around the buggy address:
[   22.083287]  ffff88804f5ce400: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
[   22.083646]  ffff88804f5ce480: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
[   22.084004] >ffff88804f5ce500: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
[   22.084361]                       ^
[   22.084542]  ffff88804f5ce580: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
[   22.084903]  ffff88804f5ce600: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
[   22.085263] ==================================================================
[   22.085708] Disabling lock debugging due to kernel taint
[   22.087471] ------------[ cut here ]------------
[   22.087732] Trying to vfree() bad address (000000006b1be3e6)
[   22.088039] WARNING: CPU: 1 PID: 1317 at mm/vmalloc.c:3231 remove_vm_area+0x1c2/0x220
[   22.088421] Modules linked in:
[   22.088590] CPU: 1 UID: 0 PID: 1317 Comm: repro Tainted: G    B               6.14.0-rc6-next-20250311-eea255893718 #1
[   22.089126] Tainted: [B]=BAD_PAGE
[   22.089308] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   22.089869] RIP: 0010:remove_vm_area+0x1c2/0x220
[   22.090112] Code: c3 cc cc cc cc e8 7e e2 a4 ff 49 81 ee 00 10 00 00 e9 51 ff ff ff e8 6d e2 a4 ff 4c 89 e6 48 c7 c7 a0 eb fa 85 e8 ce 71 63 ff <0f> 0b 45 31 ed eb bb 45 31 ed eb b6 e8 ed d2 0f 00 e9 10 ff ff ff
[   22.090996] ------------[ cut here ]------------
[   22.091042] RSP: 0018:ffff888022b77978 EFLAGS: 00010292
[   22.091274] Trying to vfree() bad address (00000000e905f2d4)
"

Hope this cound be insightful to you.

Regards,
Yi Lai

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install


