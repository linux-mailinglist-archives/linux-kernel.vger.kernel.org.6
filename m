Return-Path: <linux-kernel+bounces-274430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AA99477FF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D24C28173E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1208C148311;
	Mon,  5 Aug 2024 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KmvuKoS3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JG8rUSJI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KmvuKoS3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JG8rUSJI"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F31A149DF0
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722849021; cv=none; b=mYTasx2eoZATMGDROGEkj5SaYZwIJ0RMgLP0juN7qYcMnIxOvVINbVbagkTRYVVdo+kj3DnfwFPtzi/QOXAFaJ57mh7ax7oW0SGtfX1UPanWpADO72TwlsNs7L4BY+u8BL84o0h77AZhO/sv3TboeCb7glqFgZ68J3MSWTScEL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722849021; c=relaxed/simple;
	bh=kdqFHMz6M+S1yH8uvLNdzIfIPKLeTLjriaIP+pTPdLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0ojjJ9fyUdvaHKr57x8Gr8tfyVR9y0l5SdJwoP1nolDgaxtmpnUrsG+Ka6L9Euwo/sZeQjQueu8oyD2a0XA8mFSvjZ+e/GD7xUmzvCcZLmx4gaDdeAxgNrAQ+yMzmDLAJAEATvTGmDxTbPN6ACIEmayvgzH1Pgb/qxbEGWGZ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KmvuKoS3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JG8rUSJI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KmvuKoS3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JG8rUSJI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 103A51F820;
	Mon,  5 Aug 2024 09:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722849017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NGfQsSPKfsoSvEqC13onJ378tQVms6hrO9Wi5S7Ld3Q=;
	b=KmvuKoS3L0avg++wdThdhAYJ55hM8mnHvCv+qOp3/TZhcW2+BQXQqGflwWQ5RoM8Q1CrNF
	a64OvqWzXpsVmG2OhjdbW50x0nZwSkQ2woSa6QRCGu+Iqk3vFSxAn95fQuW/fInmtuBgmK
	SvXj//A0lZai23sREHMAkYw7Evpo/Wo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722849017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NGfQsSPKfsoSvEqC13onJ378tQVms6hrO9Wi5S7Ld3Q=;
	b=JG8rUSJI7xF+at08YY5FNp64m+30FMSLGuGqzDCnt1K0v4fKX0ydUsGF73LSWGDsaDzxax
	OznkRz4Akp9inCAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KmvuKoS3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JG8rUSJI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722849017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NGfQsSPKfsoSvEqC13onJ378tQVms6hrO9Wi5S7Ld3Q=;
	b=KmvuKoS3L0avg++wdThdhAYJ55hM8mnHvCv+qOp3/TZhcW2+BQXQqGflwWQ5RoM8Q1CrNF
	a64OvqWzXpsVmG2OhjdbW50x0nZwSkQ2woSa6QRCGu+Iqk3vFSxAn95fQuW/fInmtuBgmK
	SvXj//A0lZai23sREHMAkYw7Evpo/Wo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722849017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NGfQsSPKfsoSvEqC13onJ378tQVms6hrO9Wi5S7Ld3Q=;
	b=JG8rUSJI7xF+at08YY5FNp64m+30FMSLGuGqzDCnt1K0v4fKX0ydUsGF73LSWGDsaDzxax
	OznkRz4Akp9inCAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAA5F13ACF;
	Mon,  5 Aug 2024 09:10:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C5frOPiWsGZSaQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 05 Aug 2024 09:10:16 +0000
Message-ID: <d27f3355-66d3-4fad-b3e0-45b61f560c47@suse.cz>
Date: Mon, 5 Aug 2024 11:10:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: include/linux/slab.h:663:78: error: subscripted value is neither
 array nor pointer nor vector
To: kernel test robot <lkp@intel.com>, Kees Cook <kees@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
References: <202408032258.ShUXX4qU-lkp@intel.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <202408032258.ShUXX4qU-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.50 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -1.50
X-Rspamd-Queue-Id: 103A51F820

On 8/3/24 17:04, kernel test robot wrote:
> Hi Kees,
> 
> FYI, the error/warning still remains.

But it's also still misattributed to this commit?

https://lore.kernel.org/all/CAMuHMdWMSpv1BbvCqf0Abfxf0sGp+5it-m1GtFR2nGuQ5-ZCAg@mail.gmail.com/

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   17712b7ea0756799635ba159cc773082230ed028
> commit: 72e0fe2241ce113cbba339ca8c2450b167774530 mm/slab: Introduce kmem_buckets typedef
> date:   4 weeks ago
> config: m68k-alldefconfig (https://download.01.org/0day-ci/archive/20240803/202408032258.ShUXX4qU-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240803/202408032258.ShUXX4qU-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408032258.ShUXX4qU-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    arch/m68k/include/asm/page.h:10:25: error: 'CONFIG_PAGE_SHIFT' undeclared here (not in a function); did you mean 'CONFIG_LOG_BUF_SHIFT'?
>       10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
>          |                         ^~~~~~~~~~~~~~~~~
>    arch/m68k/include/asm/page.h:11:40: note: in expansion of macro 'PAGE_SHIFT'
>       11 | #define PAGE_SIZE       (_AC(1, UL) << PAGE_SHIFT)
>          |                                        ^~~~~~~~~~
>    arch/m68k/include/asm/thread_info.h:23:26: note: in expansion of macro 'PAGE_SIZE'
>       23 | #define THREAD_SIZE     (PAGE_SIZE << THREAD_SIZE_ORDER)
>          |                          ^~~~~~~~~
>    include/linux/sched.h:1851:29: note: in expansion of macro 'THREAD_SIZE'
>     1851 |         unsigned long stack[THREAD_SIZE/sizeof(long)];
>          |                             ^~~~~~~~~~~
>    arch/m68k/include/asm/page.h:10:25: warning: "CONFIG_PAGE_SHIFT" is not defined, evaluates to 0 [-Wundef]
>       10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
>          |                         ^~~~~~~~~~~~~~~~~
>    arch/m68k/include/asm/page.h:11:40: note: in expansion of macro 'PAGE_SHIFT'
>       11 | #define PAGE_SIZE       (_AC(1, UL) << PAGE_SHIFT)
>          |                                        ^~~~~~~~~~
>    include/linux/mm_types.h:531:6: note: in expansion of macro 'PAGE_SIZE'
>      531 | #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>          |      ^~~~~~~~~
>    In file included from include/vdso/const.h:5,
>                     from include/linux/const.h:4,
>                     from include/linux/bits.h:5,
>                     from include/linux/ratelimit_types.h:5,
>                     from include/linux/printk.h:9,
>                     from include/asm-generic/bug.h:22,
>                     from arch/m68k/include/asm/bug.h:32,
>                     from include/linux/bug.h:5,
>                     from include/linux/thread_info.h:13:
>    arch/m68k/include/asm/page.h:10:25: warning: "CONFIG_PAGE_SHIFT" is not defined, evaluates to 0 [-Wundef]
>       10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
>          |                         ^~~~~~~~~~~~~~~~~
>    include/uapi/linux/const.h:32:50: note: in definition of macro '__ALIGN_KERNEL_MASK'
>       32 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
>          |                                                  ^~~~
>    include/linux/mm_types.h:508:41: note: in expansion of macro '__ALIGN_MASK'
>      508 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
>          |                                         ^~~~~~~~~~~~
>    arch/m68k/include/asm/page.h:11:40: note: in expansion of macro 'PAGE_SHIFT'
>       11 | #define PAGE_SIZE       (_AC(1, UL) << PAGE_SHIFT)
>          |                                        ^~~~~~~~~~
>    arch/m68k/include/asm/page.h:12:28: note: in expansion of macro 'PAGE_SIZE'
>       12 | #define PAGE_MASK       (~(PAGE_SIZE-1))
>          |                            ^~~~~~~~~
>    include/linux/mm_types.h:508:62: note: in expansion of macro 'PAGE_MASK'
>      508 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
>          |                                                              ^~~~~~~~~
>    include/linux/mm_types.h:531:18: note: in expansion of macro 'PAGE_FRAG_CACHE_MAX_SIZE'
>      531 | #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>          |                  ^~~~~~~~~~~~~~~~~~~~~~~~
>    arch/m68k/include/asm/page.h:10:25: warning: "CONFIG_PAGE_SHIFT" is not defined, evaluates to 0 [-Wundef]
>       10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
>          |                         ^~~~~~~~~~~~~~~~~
>    include/uapi/linux/const.h:32:61: note: in definition of macro '__ALIGN_KERNEL_MASK'
>       32 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
>          |                                                             ^~~~
>    include/linux/mm_types.h:508:41: note: in expansion of macro '__ALIGN_MASK'
>      508 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
>          |                                         ^~~~~~~~~~~~
>    arch/m68k/include/asm/page.h:11:40: note: in expansion of macro 'PAGE_SHIFT'
>       11 | #define PAGE_SIZE       (_AC(1, UL) << PAGE_SHIFT)
>          |                                        ^~~~~~~~~~
>    arch/m68k/include/asm/page.h:12:28: note: in expansion of macro 'PAGE_SIZE'
>       12 | #define PAGE_MASK       (~(PAGE_SIZE-1))
>          |                            ^~~~~~~~~
>    include/linux/mm_types.h:508:62: note: in expansion of macro 'PAGE_MASK'
>      508 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
>          |                                                              ^~~~~~~~~
>    include/linux/mm_types.h:531:18: note: in expansion of macro 'PAGE_FRAG_CACHE_MAX_SIZE'
>      531 | #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>          |                  ^~~~~~~~~~~~~~~~~~~~~~~~
>    In file included from include/linux/init.h:5,
>                     from include/linux/printk.h:6:
>    arch/m68k/include/asm/page.h:10:25: error: expression in static assertion is not an integer
>       10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
>          |                         ^~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
>       78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>          |                                                        ^~~~
>    include/linux/slab.h:527:1: note: in expansion of macro 'static_assert'
>      527 | static_assert(PAGE_SHIFT <= 20);
>          | ^~~~~~~~~~~~~
>    include/linux/slab.h:527:15: note: in expansion of macro 'PAGE_SHIFT'
>      527 | static_assert(PAGE_SHIFT <= 20);
>          |               ^~~~~~~~~~
>    In file included from include/linux/irq.h:21,
>                     from include/asm-generic/hardirq.h:17,
>                     from ./arch/m68k/include/generated/asm/hardirq.h:1,
>                     from include/linux/hardirq.h:11,
>                     from include/linux/interrupt.h:11,
>                     from include/linux/kernel_stat.h:9,
>                     from arch/m68k/kernel/asm-offsets.c:16:
>    include/linux/slab.h:593:33: warning: 'assume_aligned' attribute argument <erroneous-expression> is not an integer constant [-Wattributes]
>      593 |                                 __assume_page_alignment __alloc_size(1);
>          |                                 ^~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/slab.h:596:33: warning: 'assume_aligned' attribute argument <erroneous-expression> is not an integer constant [-Wattributes]
>      596 |                                 __assume_page_alignment __alloc_size(1);
>          |                                 ^~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/slab.h: In function 'kmalloc_noprof':
>>> include/linux/slab.h:663:78: error: subscripted value is neither array nor pointer nor vector
>      663 |                                 kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
>          |                                                                              ^
>    include/linux/slab.h:656:30: warning: variable 'index' set but not used [-Wunused-but-set-variable]
>      656 |                 unsigned int index;
>          |                              ^~~~~
>    include/linux/slab.h: In function 'kmalloc_node_noprof':
>    include/linux/slab.h:680:78: error: subscripted value is neither array nor pointer nor vector
>      680 |                                 kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
>          |                                                                              ^
>    include/linux/slab.h:673:30: warning: variable 'index' set but not used [-Wunused-but-set-variable]
>      673 |                 unsigned int index;
>          |                              ^~~~~
>    make[3]: *** [scripts/Makefile.build:117: arch/m68k/kernel/asm-offsets.s] Error 1
>    make[3]: Target 'prepare' not remade because of errors.
>    make[2]: *** [Makefile:1208: prepare0] Error 2
>    make[2]: Target 'prepare' not remade because of errors.
>    make[1]: *** [Makefile:240: __sub-make] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:240: __sub-make] Error 2
>    make: Target 'prepare' not remade because of errors.
> 
> 
> vim +663 include/linux/slab.h
> 
> f1b6eb6e6be149 Christoph Lameter     2013-09-04  572  
> a0a44d9175b349 Vlastimil Babka       2024-05-27  573  /*
> a0a44d9175b349 Vlastimil Babka       2024-05-27  574   * The following functions are not to be used directly and are intended only
> a0a44d9175b349 Vlastimil Babka       2024-05-27  575   * for internal use from kmalloc() and kmalloc_node()
> a0a44d9175b349 Vlastimil Babka       2024-05-27  576   * with the exception of kunit tests
> a0a44d9175b349 Vlastimil Babka       2024-05-27  577   */
> a0a44d9175b349 Vlastimil Babka       2024-05-27  578  
> a0a44d9175b349 Vlastimil Babka       2024-05-27  579  void *__kmalloc_noprof(size_t size, gfp_t flags)
> a0a44d9175b349 Vlastimil Babka       2024-05-27  580  				__assume_kmalloc_alignment __alloc_size(1);
> f1b6eb6e6be149 Christoph Lameter     2013-09-04  581  
> a0a44d9175b349 Vlastimil Babka       2024-05-27  582  void *__kmalloc_node_noprof(size_t size, gfp_t flags, int node)
> a0a44d9175b349 Vlastimil Babka       2024-05-27  583  				__assume_kmalloc_alignment __alloc_size(1);
> a0a44d9175b349 Vlastimil Babka       2024-05-27  584  
> a0a44d9175b349 Vlastimil Babka       2024-05-27  585  void *__kmalloc_cache_noprof(struct kmem_cache *s, gfp_t flags, size_t size)
> a0a44d9175b349 Vlastimil Babka       2024-05-27  586  				__assume_kmalloc_alignment __alloc_size(3);
> 7bd230a26648ac Suren Baghdasaryan    2024-03-21  587  
> a0a44d9175b349 Vlastimil Babka       2024-05-27  588  void *__kmalloc_cache_node_noprof(struct kmem_cache *s, gfp_t gfpflags,
> a0a44d9175b349 Vlastimil Babka       2024-05-27  589  				  int node, size_t size)
> a0a44d9175b349 Vlastimil Babka       2024-05-27  590  				__assume_kmalloc_alignment __alloc_size(4);
> 7bd230a26648ac Suren Baghdasaryan    2024-03-21  591  
> a0a44d9175b349 Vlastimil Babka       2024-05-27  592  void *__kmalloc_large_noprof(size_t size, gfp_t flags)
> a0a44d9175b349 Vlastimil Babka       2024-05-27 @593  				__assume_page_alignment __alloc_size(1);
> a0c3b940023eef Hyeonggon Yoo         2022-08-17  594  
> a0a44d9175b349 Vlastimil Babka       2024-05-27  595  void *__kmalloc_large_node_noprof(size_t size, gfp_t flags, int node)
> a0a44d9175b349 Vlastimil Babka       2024-05-27  596  				__assume_page_alignment __alloc_size(1);
> a0c3b940023eef Hyeonggon Yoo         2022-08-17  597  
> f1b6eb6e6be149 Christoph Lameter     2013-09-04  598  /**
> 838de63b101147 Vlastimil Babka       2022-11-10  599   * kmalloc - allocate kernel memory
> f1b6eb6e6be149 Christoph Lameter     2013-09-04  600   * @size: how many bytes of memory are required.
> 838de63b101147 Vlastimil Babka       2022-11-10  601   * @flags: describe the allocation context
> f1b6eb6e6be149 Christoph Lameter     2013-09-04  602   *
> f1b6eb6e6be149 Christoph Lameter     2013-09-04  603   * kmalloc is the normal method of allocating memory
> f1b6eb6e6be149 Christoph Lameter     2013-09-04  604   * for objects smaller than page size in the kernel.
> 7e3528c3660a2e Randy Dunlap          2013-11-22  605   *
> 59bb47985c1db2 Vlastimil Babka       2019-10-06  606   * The allocated object address is aligned to at least ARCH_KMALLOC_MINALIGN
> 59bb47985c1db2 Vlastimil Babka       2019-10-06  607   * bytes. For @size of power of two bytes, the alignment is also guaranteed
> ad59baa3169591 Vlastimil Babka       2024-07-03  608   * to be at least to the size. For other sizes, the alignment is guaranteed to
> ad59baa3169591 Vlastimil Babka       2024-07-03  609   * be at least the largest power-of-two divisor of @size.
> 59bb47985c1db2 Vlastimil Babka       2019-10-06  610   *
> 01598ba6b1a863 Mike Rapoport         2018-11-11  611   * The @flags argument may be one of the GFP flags defined at
> e9d198f2be851f Thorsten Scherer      2023-03-12  612   * include/linux/gfp_types.h and described at
> 01598ba6b1a863 Mike Rapoport         2018-11-11  613   * :ref:`Documentation/core-api/mm-api.rst <mm-api-gfp-flags>`
> 7e3528c3660a2e Randy Dunlap          2013-11-22  614   *
> 01598ba6b1a863 Mike Rapoport         2018-11-11  615   * The recommended usage of the @flags is described at
> 2370ae4b1d5aa7 Mauro Carvalho Chehab 2020-04-10  616   * :ref:`Documentation/core-api/memory-allocation.rst <memory_allocation>`
> 7e3528c3660a2e Randy Dunlap          2013-11-22  617   *
> 01598ba6b1a863 Mike Rapoport         2018-11-11  618   * Below is a brief outline of the most useful GFP flags
> 7e3528c3660a2e Randy Dunlap          2013-11-22  619   *
> 01598ba6b1a863 Mike Rapoport         2018-11-11  620   * %GFP_KERNEL
> 01598ba6b1a863 Mike Rapoport         2018-11-11  621   *	Allocate normal kernel ram. May sleep.
> 7e3528c3660a2e Randy Dunlap          2013-11-22  622   *
> 01598ba6b1a863 Mike Rapoport         2018-11-11  623   * %GFP_NOWAIT
> 01598ba6b1a863 Mike Rapoport         2018-11-11  624   *	Allocation will not sleep.
> 7e3528c3660a2e Randy Dunlap          2013-11-22  625   *
> 01598ba6b1a863 Mike Rapoport         2018-11-11  626   * %GFP_ATOMIC
> 01598ba6b1a863 Mike Rapoport         2018-11-11  627   *	Allocation will not sleep.  May use emergency pools.
> 7e3528c3660a2e Randy Dunlap          2013-11-22  628   *
> 7e3528c3660a2e Randy Dunlap          2013-11-22  629   * Also it is possible to set different flags by OR'ing
> 7e3528c3660a2e Randy Dunlap          2013-11-22  630   * in one or more of the following additional @flags:
> 7e3528c3660a2e Randy Dunlap          2013-11-22  631   *
> 838de63b101147 Vlastimil Babka       2022-11-10  632   * %__GFP_ZERO
> 838de63b101147 Vlastimil Babka       2022-11-10  633   *	Zero the allocated memory before returning. Also see kzalloc().
> 838de63b101147 Vlastimil Babka       2022-11-10  634   *
> 01598ba6b1a863 Mike Rapoport         2018-11-11  635   * %__GFP_HIGH
> 01598ba6b1a863 Mike Rapoport         2018-11-11  636   *	This allocation has high priority and may use emergency pools.
> 7e3528c3660a2e Randy Dunlap          2013-11-22  637   *
> 01598ba6b1a863 Mike Rapoport         2018-11-11  638   * %__GFP_NOFAIL
> 01598ba6b1a863 Mike Rapoport         2018-11-11  639   *	Indicate that this allocation is in no way allowed to fail
> 7e3528c3660a2e Randy Dunlap          2013-11-22  640   *	(think twice before using).
> 7e3528c3660a2e Randy Dunlap          2013-11-22  641   *
> 01598ba6b1a863 Mike Rapoport         2018-11-11  642   * %__GFP_NORETRY
> 01598ba6b1a863 Mike Rapoport         2018-11-11  643   *	If memory is not immediately available,
> 7e3528c3660a2e Randy Dunlap          2013-11-22  644   *	then give up at once.
> 7e3528c3660a2e Randy Dunlap          2013-11-22  645   *
> 01598ba6b1a863 Mike Rapoport         2018-11-11  646   * %__GFP_NOWARN
> 01598ba6b1a863 Mike Rapoport         2018-11-11  647   *	If allocation fails, don't issue any warnings.
> 7e3528c3660a2e Randy Dunlap          2013-11-22  648   *
> 01598ba6b1a863 Mike Rapoport         2018-11-11  649   * %__GFP_RETRY_MAYFAIL
> 01598ba6b1a863 Mike Rapoport         2018-11-11  650   *	Try really hard to succeed the allocation but fail
> dcda9b04713c3f Michal Hocko          2017-07-12  651   *	eventually.
> f1b6eb6e6be149 Christoph Lameter     2013-09-04  652   */
> 7bd230a26648ac Suren Baghdasaryan    2024-03-21  653  static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t flags)
> f1b6eb6e6be149 Christoph Lameter     2013-09-04  654  {
> 6fa57d78aa7f21 Kees Cook             2022-11-17  655  	if (__builtin_constant_p(size) && size) {
> cc252eae85e095 Vlastimil Babka       2018-10-26  656  		unsigned int index;
> 3bf019334fbbb5 Kees Cook             2022-11-17  657  
> f1b6eb6e6be149 Christoph Lameter     2013-09-04  658  		if (size > KMALLOC_MAX_CACHE_SIZE)
> a0a44d9175b349 Vlastimil Babka       2024-05-27  659  			return __kmalloc_large_noprof(size, flags);
> f1b6eb6e6be149 Christoph Lameter     2013-09-04  660  
> cc252eae85e095 Vlastimil Babka       2018-10-26  661  		index = kmalloc_index(size);
> a0a44d9175b349 Vlastimil Babka       2024-05-27  662  		return __kmalloc_cache_noprof(
> 3c615294058429 GONG, Ruiqi           2023-07-14 @663  				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
> f1b6eb6e6be149 Christoph Lameter     2013-09-04  664  				flags, size);
> f1b6eb6e6be149 Christoph Lameter     2013-09-04  665  	}
> 7bd230a26648ac Suren Baghdasaryan    2024-03-21  666  	return __kmalloc_noprof(size, flags);
> f1b6eb6e6be149 Christoph Lameter     2013-09-04  667  }
> 7bd230a26648ac Suren Baghdasaryan    2024-03-21  668  #define kmalloc(...)				alloc_hooks(kmalloc_noprof(__VA_ARGS__))
> ce6a50263d4dde Christoph Lameter     2013-01-10  669  
> 
> :::::: The code at line 663 was first introduced by commit
> :::::: 3c6152940584290668b35fa0800026f6a1ae05fe Randomized slab caches for kmalloc()
> 
> :::::: TO: GONG, Ruiqi <gongruiqi@huaweicloud.com>
> :::::: CC: Vlastimil Babka <vbabka@suse.cz>
> 


