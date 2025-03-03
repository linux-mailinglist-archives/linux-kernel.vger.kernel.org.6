Return-Path: <linux-kernel+bounces-542348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B79A4C8FF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401353B3A0F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382482512D2;
	Mon,  3 Mar 2025 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYsBl577"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6909250C12
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020398; cv=none; b=QmuXtCEixq/3uqHRCKKcPcExmcBiC+qScggdNVU21YDQ6/PoFMGCXQKtCaxkmNIxOrLsTZb1r8LeN5rLFQHlJVyLMocrbNDEe4F4OPOYBkWDI2sFxOy5o5nCjP82VxtuEnYFJu5OtsDCmhn+8yJKIyCrP6dIaf1IGjcz3WPtjbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020398; c=relaxed/simple;
	bh=F6HNbgsPWAN5LWQUdNVC3XbuFJZN56aHKHYxhDstltg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aGKdo89QNkgJbyyxIFinUfJqtDhmqlchUMIZuolLSLMQLhH60TG+TyQ8Jqug7naABnFzDRXuiXzO4AyP1mF9OT3DS/0n2PfhNSY3qXoaPzx4bEsP0fWm4pXbRNnJSGzVaR7DXJr9ynK2gxh08ssA7U/cFHIQUuk1+Wnf3tAm0js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TYsBl577; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741020395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dSm9FbqleokqOgHDmRDUnZh4oGvfFBiZ+uQxTGBWfyE=;
	b=TYsBl577B+KMfFeh52w5ygiPtNOB7JZiUD0aYVtNwJiDuriXMvuSGl8sl8TDXRjDPNiY7k
	+Mvq2JgjO9gAhBOb51ZN8LSSzXxXNwMfvpXbuN0ipo3LKkx7jfaUW/9B+H+ow0NIPyCgyD
	P3yvJx5I+VZWMjHH7ovYTl03viBdYcM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-yY8Dh8-VNQOzvnxby7i6rw-1; Mon, 03 Mar 2025 11:46:32 -0500
X-MC-Unique: yY8Dh8-VNQOzvnxby7i6rw-1
X-Mimecast-MFC-AGG-ID: yY8Dh8-VNQOzvnxby7i6rw_1741020391
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43ab456333aso41626835e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:46:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020391; x=1741625191;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSm9FbqleokqOgHDmRDUnZh4oGvfFBiZ+uQxTGBWfyE=;
        b=vP1/uyMx6+XFe2QtCnesLuhKhsm2cGVEUkFQ4spOmOo92aZqodTiMMBHEAGCp3ow5X
         dNL/x9XvBRrVWU6Ii0rhE5+Io2oiKaz65TxetgH7sivHrfWkSoMk/uoM2nlT0FLnAD58
         ZaBj8pF2ozOomuuBEjWWwy8XDju8GJWKNJkDX+r3bUAelbMLjIaBv4UUSRDs5JMgPhrW
         P7UKECdyjq8sQ6L3rrSFdKniP5xiCDJVJflTETpV/vr12vRNlfWMuPKyqVruMqCPHxn/
         cP69imbq5c0BvNTOr4i2mRy3DFJeldAffOsVar4/3zD/XuXiEUiZvFRul6jazJv3GOZr
         4aoA==
X-Gm-Message-State: AOJu0YyBh3U/N15isStuspw4KVuJzHwB54IAC4o5mNh117LmVlpc+BuL
	pjrwUBX/pukRh09xj1TXKrAUteYe3EqFGPfYFryN/75+dsOUUmQp6Jd0PNgQMXW69cwfM/U20or
	iCbx6TMWC6liqA3w8MSLm88bN2Id6tH7oWMvR1hNeOgTLe4080NTlV9Be5pUMlQ==
X-Gm-Gg: ASbGncsye/VX7x+WCLSQWOsu8QKRKFZYMsFjKuQWMt7TMGF63pjduO/YKFITjYGynzf
	rSDnR/jvkCijzMQaqyLLzl1M4q1GsnDLgPML4LYxGfzUXnTzmahEFekzlSydDrOPbiYeOTJ1zBW
	PHevIKjt9WD9rfvoQ2iVY8R0r23inqdG+JuCBzGtySKR3Me9fb7SJEpm5k7Wx2Ehkjg72KRAJ+k
	ZjNJ2gkjb0KTIQ0OTwEOGOoI81+LPbiBizkwtiBaFHPGHe2RE7bO5EDtnoUzQxp5DxATDIB7ZHq
	IzYDNuAJIAHKEC5MTzro0wtDfH62ipV1SV5Ouj3GzqUyqJJLB/asTTFJRHvmzyDgPPS2RU2piFr
	B6Fm2Y9p0o9x9BWyGTHBvCLHKdvmKitRKRGBXS6Q9m0I=
X-Received: by 2002:a05:600c:4fd3:b0:439:a255:b2ed with SMTP id 5b1f17b1804b1-43ba66e5f09mr139944085e9.9.1741020391080;
        Mon, 03 Mar 2025 08:46:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfYzwt9QxpbKClJYXe8+pF5oEzRieGO2Rkc5PIh9FjKKRoO2TIkQQs6doEwSSc3wdltpwpDg==
X-Received: by 2002:a05:600c:4fd3:b0:439:a255:b2ed with SMTP id 5b1f17b1804b1-43ba66e5f09mr139943845e9.9.1741020390633;
        Mon, 03 Mar 2025 08:46:30 -0800 (PST)
Received: from ?IPV6:2003:cb:c734:9600:af27:4326:a216:2bfb? (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bbbff18b3sm57280375e9.24.2025.03.03.08.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:46:30 -0800 (PST)
Message-ID: <efc2a483-34a2-4445-8dcb-7168869834af@redhat.com>
Date: Mon, 3 Mar 2025 17:46:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] kernel BUG in try_to_unmap_one
To: Hillf Danton <hdanton@sina.com>,
 syzbot <syzbot+fb86166504f57eff29d7@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com, Zi Yan <ziy@nvidia.com>
References: <20250301234002.2893-1-hdanton@sina.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250301234002.2893-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.03.25 00:40, Hillf Danton wrote:
> On Sat, 01 Mar 2025 14:41:20 -0800
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    e5d3fd687aac Add linux-next specific files for 20250218
>> git tree:       linux-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=12faf7f8580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=4e945b2fe8e5992f
>> dashboard link: https://syzkaller.appspot.com/bug?extid=fb86166504f57eff29d7
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/ef079ccd2725/disk-e5d3fd68.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/99f2123d6831/vmlinux-e5d3fd68.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/eadfc9520358/bzImage-e5d3fd68.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+fb86166504f57eff29d7@syzkaller.appspotmail.com
>>
>>   evict+0x4e8/0x9a0 fs/inode.c:806
>>   __dentry_kill+0x20d/0x630 fs/dcache.c:660
>>   dput+0x19f/0x2b0 fs/dcache.c:902
>>   __fput+0x60b/0x9f0 fs/file_table.c:472
>>   task_work_run+0x24f/0x310 kernel/task_work.c:227
>>   resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>>   exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>>   exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
>>   __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>>   syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
>>   do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> ------------[ cut here ]------------
>> kernel BUG at mm/rmap.c:1858!
>> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
>> CPU: 1 UID: 0 PID: 6053 Comm: syz.4.27 Not tainted 6.14.0-rc3-next-20250218-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
>> RIP: 0010:try_to_unmap_one+0x3d0d/0x3fa0 mm/rmap.c:1858
>> Code: c7 c7 80 93 c3 8e 48 89 da e8 ef f3 19 03 e9 68 ca ff ff e8 b5 12 ab ff 48 8b 7c 24 20 48 c7 c6 80 17 36 8c e8 94 d2 f5 ff 90 <0f> 0b e8 9c 12 ab ff 48 8b 7c 24 18 48 c7 c6 40 1c 36 8c e8 7b d2
>> RSP: 0018:ffffc9000b1be9c0 EFLAGS: 00010246
>> RAX: 367eb4645686ad00 RBX: 00000000f4000000 RCX: ffffc9000b1be503
>> RDX: 0000000000000004 RSI: ffffffff8c2aaf60 RDI: ffffffff8c8156e0
>> RBP: ffffc9000b1bedf0 R08: ffffffff903da477 R09: 1ffffffff207b48e
>> R10: dffffc0000000000 R11: fffffbfff207b48f R12: 8000000053c008e7
>> R13: dffffc0000000000 R14: ffffea00014f0000 R15: ffffea00014f0030
>> FS:  00007f4d2783e6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 000000110c465fa1 CR3: 000000002a1f6000 CR4: 00000000003526f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>   <TASK>
>>   __rmap_walk_file+0x420/0x5f0 mm/rmap.c:2774
>>   try_to_unmap+0x219/0x2e0
>>   unmap_folio+0x183/0x1f0 mm/huge_memory.c:3053
>>   __folio_split+0x849/0x16d0 mm/huge_memory.c:3696
>>   truncate_inode_partial_folio+0x9b1/0xdc0 mm/truncate.c:234
>>   shmem_undo_range+0x82f/0x1820 mm/shmem.c:1143
> 
> Given folio_test_hugetlb(folio) [1], what is weird is hugetlb page in a
> shmem mapping.
> 

Right, the problem begins when we call __folio_split() on a hugetlb 
folio, and the issue is that we seem to find that in the pagecache.

I wonder if there is some weird interaction with out recent folio split 
changes in next. Maybe, for some reason, we end up adding a wrong folio 
to the pagecache during a split (truncation), and a follow-up split 
(truncation) finds the wrong folio.

Just a guess, though. CCing Zi Yan.

-- 
Cheers,

David / dhildenb


