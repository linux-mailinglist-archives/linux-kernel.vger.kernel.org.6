Return-Path: <linux-kernel+bounces-313378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D874E96A4B9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10B1BB269E0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A74718C921;
	Tue,  3 Sep 2024 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SqLL03h8"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8D618BC1E
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381834; cv=none; b=aOpuA9K0y81jCGXOrFPkhLnd7xmrkUfqQ2u/OI0XKiJDHaTjr0VU78MLePzjaJYJZkvHIOwWFc3UGFNsCeSg/rg0TqHPsGWzOnSS3AFpjXXT5M5TnAlki+h4e+zVPP1ieErwKeN6yQ3NUZ0lc6NQvc6ErwVO5iw6XQJ1sdrrkEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381834; c=relaxed/simple;
	bh=5k2olMjv1qn0zrpJD2KcRKfLdEG4U2BRVUmOZG0VK/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jw3df3KGCyJOsLh/+Lu9UBRMkGUWAUTnQWDScmRLB92AzmkR2rK75iI8jKoEWJbu3d1nDRtZExZHLOnF2srF6zbtpPtZMWPo9YUw18yuk5ekWOyGSr/VrEDaUY3M9+EO6qckCYE+XplR5nCBme7Q72wWB17il1FLG2n/AIukBsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=SqLL03h8; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-82a29c11e53so230932739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 09:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1725381832; x=1725986632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BqvXA/3XZ5X8cHInUkHq4ej7Z/KzDFXPr58Ls+fV6i4=;
        b=SqLL03h8N1VJQMXy0FQktMFGfA3KUNbk//aSFEaiWv9ld6NKHwe1zzdQHgNxHOXpyO
         QDkr0pnXBWjNcP1/lznkmpcF9zGNzqe6zxijIOz3ke0ibtYxfxXdrfKfEGF3G+MavxlA
         xZgpb3vzRF1TVP+J+WiTS1ZrHAN8GGVzQOfOcDtW5PSls2GhCTEp4BOr6VHfnomo9ENz
         4smbysGlu8rhJwpe8G41UC1eHcETSTZlAOI3IsE6neKI2TtNzJK+gzykuwrX58Ki2GhZ
         Jpy6lYQkHaEQh7eYg1IAMaENNJTRsm0Yhk/p4ZmvrBx62Qg0vvBhAF/Kd+xVLz+ZyapU
         +X7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725381832; x=1725986632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BqvXA/3XZ5X8cHInUkHq4ej7Z/KzDFXPr58Ls+fV6i4=;
        b=H0Wni9aWnAp9MjxnZOmqU/EOqZkPY9hGOemri16x/3yPgMCU4lMiPWCqowqdLHCe9p
         ZLvrwcdOYVL8/gKQy79fb6DU7TEmOlvTRU8WnU8mA8a3X/XEyzF0URZ0CZUkIZZxdxlD
         jrYa/KN0nMtEN/ItFCLmMa5p+JNv0lbreggPk5gbOian/OmNyM8A0RwsLli1VGZUVYjS
         IM0EUcDYBcAqksG8Z9OA1Z5x7dPPFppqKMQfckTi4NKaBkXl0lZmqk1lSjx98hoEGUbF
         zzIORcdGDeIoqOl9u1qN5U7AHoSpoMi0RHVkzdMSAsd/l3SO74sAp8lbpQptbik3Feek
         Zj8A==
X-Forwarded-Encrypted: i=1; AJvYcCW/WTo+CGzYspoi1fnl9V9Gkd3eyaC0+X04uRSlT9jFsFiAZaHqmrHKq+eeEdUtpFTOwF6tM6MEd16JC00=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7B2MVJzSiXKMfXJcONsIK5atK72qV5UOgh8f50ctTNlsVWecC
	RyuQp0sXhtN5w+KWswjZauo2F0lvDRqXi5cZg+EVLlmCV04d16ZYkcQqoAmz5+OuDVbYKTo35tQ
	tkjE=
X-Google-Smtp-Source: AGHT+IGWs0ecj4oOIIuZ0aCG8Rb5IKSS80e/aUXkI0a4z3y9UTTKRgHACCHwKnH4Q+AQWhR4cx7fKA==
X-Received: by 2002:a05:6602:15c6:b0:82a:2cd4:a788 with SMTP id ca18e2360f4ac-82a37560e77mr1271578739f.15.1725381832025;
        Tue, 03 Sep 2024 09:43:52 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2de7825sm2781071173.63.2024.09.03.09.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 09:43:50 -0700 (PDT)
Message-ID: <d7a686a5-dfc8-4e26-8e4a-11f90fbf6d68@sifive.com>
Date: Tue, 3 Sep 2024 11:43:48 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [arm?] upstream test error: KASAN: invalid-access Write
 in setup_arch
To: Marc Zyngier <maz@kernel.org>, Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
 Aleksandr Nogikh <nogikh@google.com>, kasan-dev
 <kasan-dev@googlegroups.com>, Will Deacon <will@kernel.org>,
 syzbot <syzbot+908886656a02769af987@syzkaller.appspotmail.com>,
 catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000f362e80620e27859@google.com>
 <20240830095254.GA7769@willie-the-truck> <86wmjwvatn.wl-maz@kernel.org>
 <CANp29Y6EJXFTOy6Pd466r+RwzaGHe7JQMTaqMPSO2s7ubm-PKw@mail.gmail.com>
 <CAG_fn=UbWvN=FiXjU_QZKm_qDhxU8dZQ4fgELXsRsPCj4YHp9A@mail.gmail.com>
 <86seugvi25.wl-maz@kernel.org>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <86seugvi25.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-09-03 11:05 AM, Marc Zyngier wrote:
> On Tue, 03 Sep 2024 16:39:28 +0100,
> Alexander Potapenko <glider@google.com> wrote:
>>
>> On Mon, Sep 2, 2024 at 12:03 PM 'Aleksandr Nogikh' via kasan-dev
>> <kasan-dev@googlegroups.com> wrote:
>>>
>>> +kasan-dev
>>>
>>> On Sat, Aug 31, 2024 at 7:53 PM 'Marc Zyngier' via syzkaller-bugs
>>> <syzkaller-bugs@googlegroups.com> wrote:
>>>>
>>>> On Fri, 30 Aug 2024 10:52:54 +0100,
>>>> Will Deacon <will@kernel.org> wrote:
>>>>>
>>>>> On Fri, Aug 30, 2024 at 01:35:24AM -0700, syzbot wrote:
>>>>>> Hello,
>>>>>>
>>>>>> syzbot found the following issue on:
>>>>>>
>>>>>> HEAD commit:    33faa93bc856 Merge branch kvmarm-master/next into kvmarm-m..
>>>>>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git fuzzme
>>>>>
>>>>> +Marc, as this is his branch.
>>>>>
>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1398420b980000
>>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=2b7b31c9aa1397ca
>>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=908886656a02769af987
>>>>>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>>>>>> userspace arch: arm64
>>>>
>>>> As it turns out, this isn't specific to this branch. I can reproduce
>>>> it with this config on a vanilla 6.10 as a KVM guest. Even worse,
>>>> compiling with clang results in an unbootable kernel (without any
>>>> output at all).
>>>>
>>>> Mind you, the binary is absolutely massive (130MB with gcc, 156MB with
>>>> clang), and I wouldn't be surprised if we were hitting some kind of
>>>> odd limit.
>>>>
>>>>>>
>>>>>> Downloadable assets:
>>>>>> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-33faa93b.raw.xz
>>>>>> vmlinux: https://storage.googleapis.com/syzbot-assets/9093742fcee9/vmlinux-33faa93b.xz
>>>>>> kernel image: https://storage.googleapis.com/syzbot-assets/b1f599907931/Image-33faa93b.gz.xz
>>>>>>
>>>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>>>> Reported-by: syzbot+908886656a02769af987@syzkaller.appspotmail.com
>>>>>>
>>>>>> Booting Linux on physical CPU 0x0000000000 [0x000f0510]
>>>>>> Linux version 6.11.0-rc5-syzkaller-g33faa93bc856 (syzkaller@syzkaller) (gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #0 SMP PREEMPT now
>>>>>> random: crng init done
>>>>>> Machine model: linux,dummy-virt
>>>>>> efi: UEFI not found.
>>>>>> NUMA: No NUMA configuration found
>>>>>> NUMA: Faking a node at [mem 0x0000000040000000-0x00000000bfffffff]
>>>>>> NUMA: NODE_DATA [mem 0xbfc1d340-0xbfc20fff]
>>>>>> Zone ranges:
>>>>>>   DMA      [mem 0x0000000040000000-0x00000000bfffffff]
>>>>>>   DMA32    empty
>>>>>>   Normal   empty
>>>>>>   Device   empty
>>>>>> Movable zone start for each node
>>>>>> Early memory node ranges
>>>>>>   node   0: [mem 0x0000000040000000-0x00000000bfffffff]
>>>>>> Initmem setup node 0 [mem 0x0000000040000000-0x00000000bfffffff]
>>>>>> cma: Reserved 32 MiB at 0x00000000bba00000 on node -1
>>>>>> psci: probing for conduit method from DT.
>>>>>> psci: PSCIv1.1 detected in firmware.
>>>>>> psci: Using standard PSCI v0.2 function IDs
>>>>>> psci: Trusted OS migration not required
>>>>>> psci: SMC Calling Convention v1.0
>>>>>> ==================================================================
>>>>>> BUG: KASAN: invalid-access in smp_build_mpidr_hash arch/arm64/kernel/setup.c:133 [inline]
>>>>>> BUG: KASAN: invalid-access in setup_arch+0x984/0xd60 arch/arm64/kernel/setup.c:356
>>>>>> Write of size 4 at addr 03ff800086867e00 by task swapper/0
>>>>>> Pointer tag: [03], memory tag: [fe]
>>>>>>
>>>>>> CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-rc5-syzkaller-g33faa93bc856 #0
>>>>>> Hardware name: linux,dummy-virt (DT)
>>>>>> Call trace:
>>>>>>  dump_backtrace+0x204/0x3b8 arch/arm64/kernel/stacktrace.c:317
>>>>>>  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
>>>>>>  __dump_stack lib/dump_stack.c:93 [inline]
>>>>>>  dump_stack_lvl+0x260/0x3b4 lib/dump_stack.c:119
>>>>>>  print_address_description mm/kasan/report.c:377 [inline]
>>>>>>  print_report+0x118/0x5ac mm/kasan/report.c:488
>>>>>>  kasan_report+0xc8/0x108 mm/kasan/report.c:601
>>>>>>  kasan_check_range+0x94/0xb8 mm/kasan/sw_tags.c:84
>>>>>>  __hwasan_store4_noabort+0x20/0x2c mm/kasan/sw_tags.c:149
>>>>>>  smp_build_mpidr_hash arch/arm64/kernel/setup.c:133 [inline]
>>>>>>  setup_arch+0x984/0xd60 arch/arm64/kernel/setup.c:356
>>>>>>  start_kernel+0xe0/0xff0 init/main.c:926
>>>>>>  __primary_switched+0x84/0x8c arch/arm64/kernel/head.S:243
>>>>>>
>>>>>> The buggy address belongs to stack of task swapper/0
>>>>>>
>>>>>> Memory state around the buggy address:
>>>>>>  ffff800086867c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>>>  ffff800086867d00: 00 fe fe 00 00 00 fe fe fe fe fe fe fe fe fe fe
>>>>>>> ffff800086867e00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>>>>>>                    ^
>>>>>>  ffff800086867f00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>>>>>>  ffff800086868000: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>>>>>> ==================================================================
>>>>>
>>>>> I can't spot the issue here. We have a couple of fixed-length
>>>>> (4 element) arrays on the stack and they're indexed by a simple loop
>>>>> counter that runs from 0-3.
>>>>
>>>> Having trimmed the config to the extreme, I can only trigger the
>>>> warning with CONFIG_KASAN_SW_TAGS (CONFIG_KASAN_GENERIC does not
>>>> scream). Same thing if I use gcc 14.2.0.
>>>>
>>>> However, compiling with clang 14 (Debian clang version 14.0.6) does
>>>> *not* result in a screaming kernel, even with KASAN_SW_TAGS.
>>>>
>>>> So I can see two possibilities here:
>>>>
>>>> - either gcc is incompatible with KASAN_SW_TAGS and the generic
>>>>   version is the only one that works
>>>>
>>>> - or we have a compiler bug on our hands.
>>>>
>>>> Frankly, I can't believe the later, as the code is so daft that I
>>>> can't imagine gcc getting it *that* wrong.
>>>>
>>>> Who knows enough about KASAN to dig into this?
>>
>> This looks related to Samuel's "arm64: Fix KASAN random tag seed
>> initialization" patch that landed in August.
> 
> f75c235565f9 arm64: Fix KASAN random tag seed initialization
> 
> $ git describe --contains f75c235565f9 --match=v\*
> v6.11-rc4~15^2
> 
> So while this is in -rc4, -rc6 still has the same issue (with GCC --
> clang is OK).

I wouldn't expect it to be related to my patch. smp_build_mpidr_hash() gets
called before kasan_init_sw_tags() both before and after applying my patch.

Since the variable in question is a stack variable, the random tag is generated
by GCC, not the kernel function.

Since smp_build_mpidr_hash() is inlined into setup_arch(), which also calls
kasan_init(), maybe the issue is that GCC tries to allocate the local variable
and write the tag to shadow memory before kasan_init() actually sets up the
shadow memory?

Regards,
Samuel

>> I am a bit surprised the bug is reported before the
>> "KernelAddressSanitizer initialized" banner is printed - I thought we
>> shouldn't be reporting anything until the tool is fully initialized.
> 
> Specially if this can report false positives...
> 
> Thanks,
> 
> 	M.
> 


