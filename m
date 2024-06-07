Return-Path: <linux-kernel+bounces-206040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 844C290038F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8891F28298
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2585B194080;
	Fri,  7 Jun 2024 12:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KjPjdNZR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCD1192B68
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763287; cv=none; b=tNYYi+aMGjMd37sNC9ecd8cg6PU6xhzlldddzaxQx7w8G6y0Ee8qrS/+hmY3fPILYxcdsBcHjCOunTPoIjH/Hnja8OYnaWzY1wpvKJRDqmQ+i4/RNLqIMvTcAwwzrG4cDprpJfqwWOaoWBx/MRZXrw9qe3mF6W65hWevzDqTKdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763287; c=relaxed/simple;
	bh=LwhNQ1eCnRTqzjjHU2aOFHYIf1xQZVUjFs8qXMa6vto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdEjnCH9w9qz0oUE3lp9q4y/3vIaiETMxHREQxcrwufwvbpiqorWJqz4Y6bM/JgkfgBgpxRKVWszPj8kxOcPlGfCvhSau+jsyR9sWPp+DmXeK9hofXhfKvnr24yggvyMlzjxBRSWJwUZLQBAvbOwvKaVLntf+StR0HtjE3iPwww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KjPjdNZR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KbWgNDxp6kqI8KSc+gmSAycDQgB7Zp2ds8pce0lyFW0=;
	b=KjPjdNZROJgn1KFkPYqrYQWbRO7n2MZDWbqku1KXNrYeDx+9fwJ79vHfjETsDvHgnEckB2
	DfTDIHlIUR8ihl0hXNM+dEDfLiB+i/t6Ct5/53It7BDZyADTfGcaTILeqauNLgkRdkFLuv
	4Gb/aCRr7Z3z2KLkUhuDbD76mLcL4nw=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-xhUMYvsiPr2u6AkGUNClww-1; Fri, 07 Jun 2024 08:28:03 -0400
X-MC-Unique: xhUMYvsiPr2u6AkGUNClww-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eb34c7a2e5so220899839f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 05:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763282; x=1718368082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbWgNDxp6kqI8KSc+gmSAycDQgB7Zp2ds8pce0lyFW0=;
        b=WN4scDbGqasMZi2xkhwgCVqcySpvnY+WENlZouq1Sk+wepdl6bOhEpqWKqyFw9/aIb
         Fe4s2/mrE7QotuiDUMp1HaY/4GTeWeH1oDrGNfdX5OntefNHjGKmkgJdbgyHfJs9pNbC
         bhRfMRsFQgDXuVcU8j7DqJI2joXsM0r1dwnRa/7LRnprRrNyYzosC8GyyVhaONOceuM4
         6tVAuHq3icLVgEKu5aIz700woVJ9fsL6V0aNAvjW1I6aV66JFNwDHIrR5fVF+eGyQBUC
         dyV44PrrKaImaoRMzfZtQQdvZ0EJc/yCymJHB1loqa2yK/tHUV244nsgLIOYbbcQ2Yl9
         H4IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxgCx5fW05ar58Dnx4U6lKhVqTE4Pp8BonTx8IzPbyRsS27O8dJ+eURthxWzLYe8LaqOH4rjlD2ByjtO2uHCb9neoptNsOaIy5UgIG
X-Gm-Message-State: AOJu0Ywni+vNh3kis1N7nuJGRpPfvL38jdKOmrp97/A0rEp/TdomcC/6
	8vdjLP1PIprgbQ6S7m8T3vIYxEf3DO8Eu1UOUDJ5KUMldnjLbFvusTHegpY5rsrRU60QyFeAe6W
	ZYmU6tm9JgdH0dDrVsCx2o4NmFTzSFSsHw5ZL1H6HssmowkMqmFaKHCrZBC3vdg==
X-Received: by 2002:a05:6602:3f94:b0:7eb:54ed:b5a7 with SMTP id ca18e2360f4ac-7eb57214c4dmr298375539f.10.1717763282032;
        Fri, 07 Jun 2024 05:28:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkQ/weh8538++SUkRqyPxVISqGPPf+OfZIrUi8Bg5xu2zrDrA/DcENnY/2SmEnB/E3niLYSQ==
X-Received: by 2002:a05:6602:3f94:b0:7eb:54ed:b5a7 with SMTP id ca18e2360f4ac-7eb57214c4dmr298371939f.10.1717763281515;
        Fri, 07 Jun 2024 05:28:01 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b7c2273238sm58172173.102.2024.06.07.05.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:28:01 -0700 (PDT)
Date: Fri, 7 Jun 2024 20:26:39 +0800
From: Coiby Xu <coxu@redhat.com>
To: kernel test robot <lkp@intel.com>, Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, oe-kbuild-all@lists.linux.dev, 
	Ondrej Kozina <okozina@redhat.com>, Milan Broz <gmazyland@gmail.com>, 
	Thomas Staudt <tstaudt@de.ibm.com>, Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
	Kairui Song <ryncsn@gmail.com>, Jan Pazdziora <jpazdziora@redhat.com>, 
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Dave Hansen <dave.hansen@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v4 3/7] crash_dump: store dm keys in kdump reserved memory
Message-ID: <um2wwcbti6vyu72lbjhh3ywzzardeize2joi5qedvzce277hav@f5bfokh3k7po>
References: <20240523050451.788754-4-coxu@redhat.com>
 <202405241012.KlmCbp77-lkp@intel.com>
 <Zl8ckh7FBErY3Oh6@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Zl8ckh7FBErY3Oh6@MiWiFi-R3L-srv>

On Tue, Jun 04, 2024 at 09:54:26PM +0800, Baoquan He wrote:
>Hi Coiby,

Hi Baoquan,

>
>On 05/24/24 at 11:17am, kernel test robot wrote:
>> Hi Coiby,
>>
>> kernel test robot noticed the following build errors:
>>
>> [auto build test ERROR on de7e71ef8bed222dd144d8878091ecb6d5dfd208]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/kexec_file-allow-to-place-kexec_buf-randomly/20240523-130727
>> base:   de7e71ef8bed222dd144d8878091ecb6d5dfd208
>> patch link:    https://lore.kernel.org/r/20240523050451.788754-4-coxu%40redhat.com
>> patch subject: [PATCH v4 3/7] crash_dump: store dm keys in kdump reserved memory
>> config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20240524/202405241012.KlmCbp77-lkp@intel.com/config)
>> compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240524/202405241012.KlmCbp77-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202405241012.KlmCbp77-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>
>Please respond to lkp report sooner, otherwise the reproducer link could
>be unavailable.

Thanks for the reminder! I believe these errors are false positives
because 1) include/linux/kexec.h is included after "#include <linux/crash_dump.h>"
and 2) similar errors are seen for kernel/kexec_file.c by 
"make ARCH=arm CROSS_COMPILE=arm-linux-gnu- kernel/kexec_file.o"

>
>>
>>    kernel/crash_dump_dm_crypt.c: In function 'crash_load_dm_crypt_keys':
>> >> kernel/crash_dump_dm_crypt.c:158:16: error: variable 'kbuf' has initializer but incomplete type
>>      158 |         struct kexec_buf kbuf = {
>>          |                ^~~~~~~~~
>> >> kernel/crash_dump_dm_crypt.c:159:18: error: 'struct kexec_buf' has no member named 'image'
>>      159 |                 .image = image,
>>          |                  ^~~~~
>>    kernel/crash_dump_dm_crypt.c:159:26: warning: excess elements in struct initializer
>>      159 |                 .image = image,
>>          |                          ^~~~~
>>    kernel/crash_dump_dm_crypt.c:159:26: note: (near initialization for 'kbuf')
>> >> kernel/crash_dump_dm_crypt.c:160:18: error: 'struct kexec_buf' has no member named 'buf_min'
>>      160 |                 .buf_min = 0,
>>          |                  ^~~~~~~
>>    kernel/crash_dump_dm_crypt.c:160:28: warning: excess elements in struct initializer
>>      160 |                 .buf_min = 0,
>>          |                            ^
>>    kernel/crash_dump_dm_crypt.c:160:28: note: (near initialization for 'kbuf')
>> >> kernel/crash_dump_dm_crypt.c:161:18: error: 'struct kexec_buf' has no member named 'buf_max'
>>      161 |                 .buf_max = ULONG_MAX,
>>          |                  ^~~~~~~
>>    In file included from include/linux/limits.h:7,
>>                     from include/linux/thread_info.h:12,
>>                     from include/asm-generic/preempt.h:5,
>>                     from ./arch/arm/include/generated/asm/preempt.h:1,
>>                     from include/linux/preempt.h:79,
>>                     from include/linux/rcupdate.h:27,
>>                     from include/linux/rbtree.h:24,
>>                     from include/linux/key.h:15,
>>                     from kernel/crash_dump_dm_crypt.c:2:
>>    include/vdso/limits.h:13:25: warning: excess elements in struct initializer
>>       13 | #define ULONG_MAX       (~0UL)
>>          |                         ^
>>    kernel/crash_dump_dm_crypt.c:161:28: note: in expansion of macro 'ULONG_MAX'
>>      161 |                 .buf_max = ULONG_MAX,
>>          |                            ^~~~~~~~~
>>    include/vdso/limits.h:13:25: note: (near initialization for 'kbuf')
>>       13 | #define ULONG_MAX       (~0UL)
>>          |                         ^
>>    kernel/crash_dump_dm_crypt.c:161:28: note: in expansion of macro 'ULONG_MAX'
>>      161 |                 .buf_max = ULONG_MAX,
>>          |                            ^~~~~~~~~
>> >> kernel/crash_dump_dm_crypt.c:162:18: error: 'struct kexec_buf' has no member named 'top_down'
>>      162 |                 .top_down = false,
>>          |                  ^~~~~~~~
>>    kernel/crash_dump_dm_crypt.c:162:29: warning: excess elements in struct initializer
>>      162 |                 .top_down = false,
>>          |                             ^~~~~
>>    kernel/crash_dump_dm_crypt.c:162:29: note: (near initialization for 'kbuf')
>> >> kernel/crash_dump_dm_crypt.c:163:18: error: 'struct kexec_buf' has no member named 'random'
>>      163 |                 .random = true,
>>          |                  ^~~~~~
>>    kernel/crash_dump_dm_crypt.c:163:27: warning: excess elements in struct initializer
>>      163 |                 .random = true,
>>          |                           ^~~~
>>    kernel/crash_dump_dm_crypt.c:163:27: note: (near initialization for 'kbuf')
>> >> kernel/crash_dump_dm_crypt.c:158:26: error: storage size of 'kbuf' isn't known
>>      158 |         struct kexec_buf kbuf = {
>>          |                          ^~~~
>> >> kernel/crash_dump_dm_crypt.c:187:20: error: 'KEXEC_BUF_MEM_UNKNOWN' undeclared (first use in this function)
>>      187 |         kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>          |                    ^~~~~~~~~~~~~~~~~~~~~
>>    kernel/crash_dump_dm_crypt.c:187:20: note: each undeclared identifier is reported only once for each function it appears in
>> >> kernel/crash_dump_dm_crypt.c:188:13: error: implicit declaration of function 'kexec_add_buffer' [-Werror=implicit-function-declaration]
>>      188 |         r = kexec_add_buffer(&kbuf);
>>          |             ^~~~~~~~~~~~~~~~
>>    kernel/crash_dump_dm_crypt.c:158:26: warning: unused variable 'kbuf' [-Wunused-variable]
>>      158 |         struct kexec_buf kbuf = {
>>          |                          ^~~~
>>    cc1: some warnings being treated as errors
>>
>>
>> vim +/kbuf +158 kernel/crash_dump_dm_crypt.c
>>
>>    155	
>>    156	int crash_load_dm_crypt_keys(struct kimage *image)
>>    157	{
>>  > 158		struct kexec_buf kbuf = {
>>  > 159			.image = image,
>>  > 160			.buf_min = 0,
>>  > 161			.buf_max = ULONG_MAX,
>>  > 162			.top_down = false,
>>  > 163			.random = true,
>>    164		};
>>    165	
>>    166		int r;
>>    167	
>>    168		if (state == FRESH)
>>    169			return 0;
>>    170	
>>    171		if (key_count != keys_header->key_count) {
>>    172			pr_err("Only record %u keys (%u in total)\n", key_count,
>>    173			       keys_header->key_count);
>>    174			return -EINVAL;
>>    175		}
>>    176	
>>    177		image->dm_crypt_keys_addr = 0;
>>    178		r = build_keys_header();
>>    179		if (r)
>>    180			return r;
>>    181	
>>    182		kbuf.buffer = keys_header;
>>    183		kbuf.bufsz = keys_header_size;
>>    184	
>>    185		kbuf.memsz = kbuf.bufsz;
>>    186		kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>>  > 187		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>  > 188		r = kexec_add_buffer(&kbuf);
>>
>> --
>> 0-DAY CI Kernel Test Service
>> https://github.com/intel/lkp-tests/wiki
>>
>

-- 
Best regards,
Coiby


