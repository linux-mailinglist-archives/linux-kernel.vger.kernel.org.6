Return-Path: <linux-kernel+bounces-431615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB009E3FB7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54339B34670
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C57020C479;
	Wed,  4 Dec 2024 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ob7VnvlD"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F7920C49C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733329052; cv=none; b=G/rlCMixHuUh4k9jn/ln9TJde+m0lwcmEVJFFgF1jbWWj3j8i8Gq36VjJyBamtzrZk/QfWv7Ds+9Pf9vV+ypt2FM5vbNT2OY2yWBZvNxnpw0pi7111KHZhtVNMry3Z2nev+lJvNoxhKH4xrrjLD2/m1Oiqj85DMFxF6Ht7Bmwe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733329052; c=relaxed/simple;
	bh=D5RMggkvqJJmWAdaEJyPdYP42ngAHaPJpovKkrzHOGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JpZMd6eUCs0xDxmYUW2EkcOl8tF6p2rCF5Ky9JnrI5N/Wr5u2u3IHkzc855oQ7fwVLHOgHdIboDWWGM+iiz1WD0MnQcEkyhMjO/EgsmrJ00pNzGNCmRk+5JuNwTdnvrYRL8vf3Ac9KM+lBORAe8cr9G30Fkh+BXIEVtvQlGer8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ob7VnvlD; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7fc41dab8e3so4878561a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 08:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733329049; x=1733933849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7P77MNq1S8T3SEsRBGWK6l0nmeNklLB0BoCdpmJrXTs=;
        b=Ob7VnvlDtFaEXoowqsNhRQIlw/R197G2+XFnRP6SylWh1VSbpu5a/gBS1W1RoGOREf
         llA0ZwUwt9z/4OeNMe1B/NtBDETYdfoLrR0JBHJw5iye+hEaQDn+TXzfAA+K4NvyHkL9
         VidkYpe+BKYSoPZOqNqx42f4WA6WnWJj//ftB5S4ZfH2QssjtmBatk4iLfW5TW7fS5mD
         Rs9/vsMZI0i9qSFlRCm7yFy2Jnd1SVwoDqovwGqhjjSpRZu3UKvTPmDaRHvtGAsazcR/
         cllTi2fREyXkhPRuvGNU1y1TyygHJDOKM3ZwYXpytsXNoZPctKRbbTP0WaaoYDCyeDSR
         9QAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733329049; x=1733933849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7P77MNq1S8T3SEsRBGWK6l0nmeNklLB0BoCdpmJrXTs=;
        b=tZz6p7eldWT2voh6LD6vojZX960fGvJsRYwfriVR9SoniDnPMlmiFhca2V5tHr0qEH
         i1R4s40/VSWtLCmirxkr7/D9JKTKQbYtoelf+tt1OBghx7tBSwyStO9G3JaorTwVS1d1
         s7hFa0frD9GVJYyaYW/YIjd2ju3PiVGN5pGqwbyfM0uOUYmZcT0RUof1gk9EiAyLSZcl
         ixEUkdSHYWx801p0wlSR7A1kwXYrjviTqAkw4nhjTVRxcWq0d//m/zWY1DLyWso/5q85
         oyp9NZGWg5V6+eW/6RrwggzWetRcGMrnayKIx4RcDl5LcogWOlhgf/S8vGHs4FyHtu68
         D7DQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3/N2yJ9/Ynn10cBF3gUWqSw6fxVLKZNUZ1pdg+1K8K9me8DHdxphSWzXMGudigiX5RoPKzRIo7CHX7hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY/FTgDIV/U+OynoZzDD542eSrjd0SeuSmKThrKtl2UaQ7sm0n
	E8SaIyfMtyu2dwqSIAGqKVr3uSEX4YIVRaa++NK/Sqnj5X7xS3/QYJG9WkHS5Z8MuOPY13pfeNP
	C
X-Gm-Gg: ASbGncvGlDcBYuv/1klvVx9jBD36sVJmyteBomE5bGy2a9lZ0hjc5TvIQvTsi53TbqT
	MeA1NmBcwAVKy6kkN3ilKkerceiJmq0hJWgnHWpFwNWbPRAbVggF26LPqNm5h9ALaEQo1uSFjLi
	LJ2h3KEZHTEcqzkQ39ASX/6IXeW4FAUnB6pLm4RFvYTeR5XBEpUFHYmkQSDWjwgvZRjgRTVw0P9
	Qr1khYOvz2M73V4qWQRNcL4PdMhmqHgk97XoOD5gT9+tZ8cuSXOnvI7Fw==
X-Google-Smtp-Source: AGHT+IGgWZB5/OqY8yzRC8nRVwrcmLa7enXp1lQBRR/0rQCRJOCO3r9s0TzV9wTD1kGRvgJ0HTuaOw==
X-Received: by 2002:a05:6a20:9185:b0:1e0:bf98:42dc with SMTP id adf61e73a8af0-1e1653f3c8amr9318189637.28.1733329048856;
        Wed, 04 Dec 2024 08:17:28 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:122::1:2343? ([2620:10d:c090:600::1:a7a9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176148csm12558612b3a.19.2024.12.04.08.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 08:17:28 -0800 (PST)
Message-ID: <1ab4e254-0254-4089-888b-2ec2ce152302@kernel.dk>
Date: Wed, 4 Dec 2024 09:17:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] KASAN: null-ptr-deref Write in
 sys_io_uring_register
To: Tamir Duberstein <tamird@gmail.com>
Cc: syzbot <syzbot+092bbab7da235a02a03a@syzkaller.appspotmail.com>,
 asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <67505f88.050a0220.17bd51.0069.GAE@google.com>
 <6be84787-b1d9-4a20-85f3-34d8d9a0d492@kernel.dk>
 <a41eb55f-01b3-4388-a98c-cc0de15179bd@kernel.dk>
 <CAJ-ks9kN_qddZ3Ne5d=cADu5POC1rHd4rQcbVSD_spnZOrLLZg@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAJ-ks9kN_qddZ3Ne5d=cADu5POC1rHd4rQcbVSD_spnZOrLLZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/4/24 8:21 AM, Tamir Duberstein wrote:
> On Wed, Dec 4, 2024 at 10:10?AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 12/4/24 8:01 AM, Jens Axboe wrote:
>>> On 12/4/24 6:56 AM, syzbot wrote:
>>>> Hello,
>>>>
>>>> syzbot found the following issue on:
>>>>
>>>> HEAD commit:    c245a7a79602 Add linux-next specific files for 20241203
>>>> git tree:       linux-next
>>>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=10ae840f980000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=af3fe1d01b9e7b7
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=092bbab7da235a02a03a
>>>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a448df980000
>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15cca330580000
>>>>
>>>> Downloadable assets:
>>>> disk image: https://storage.googleapis.com/syzbot-assets/8cc90a2ea120/disk-c245a7a7.raw.xz
>>>> vmlinux: https://storage.googleapis.com/syzbot-assets/0f6b1a1a0541/vmlinux-c245a7a7.xz
>>>> kernel image: https://storage.googleapis.com/syzbot-assets/9fa3eac09ddc/bzImage-c245a7a7.xz
>>>>
>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>> Reported-by: syzbot+092bbab7da235a02a03a@syzkaller.appspotmail.com
>>>>
>>>> ==================================================================
>>>> BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
>>>> BUG: KASAN: null-ptr-deref in atomic_long_sub_and_test include/linux/atomic/atomic-instrumented.h:4521 [inline]
>>>> BUG: KASAN: null-ptr-deref in put_cred_many include/linux/cred.h:255 [inline]
>>>> BUG: KASAN: null-ptr-deref in put_cred include/linux/cred.h:269 [inline]
>>>> BUG: KASAN: null-ptr-deref in io_unregister_personality io_uring/register.c:82 [inline]
>>>> BUG: KASAN: null-ptr-deref in __io_uring_register io_uring/register.c:698 [inline]
>>>> BUG: KASAN: null-ptr-deref in __do_sys_io_uring_register io_uring/register.c:902 [inline]
>>>> BUG: KASAN: null-ptr-deref in __se_sys_io_uring_register+0x1227/0x3b60 io_uring/register.c:879
>>>> Write of size 8 at addr 0000000000000406 by task syz-executor274/5828
>>>>
>>>> CPU: 1 UID: 0 PID: 5828 Comm: syz-executor274 Not tainted 6.13.0-rc1-next-20241203-syzkaller #0
>>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
>>>> Call Trace:
>>>>  <TASK>
>>>>  __dump_stack lib/dump_stack.c:94 [inline]
>>>>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>>>>  print_report+0xe8/0x550 mm/kasan/report.c:492
>>>>  kasan_report+0x143/0x180 mm/kasan/report.c:602
>>>>  kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
>>>>  instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
>>>>  atomic_long_sub_and_test include/linux/atomic/atomic-instrumented.h:4521 [inline]
>>>>  put_cred_many include/linux/cred.h:255 [inline]
>>>>  put_cred include/linux/cred.h:269 [inline]
>>>>  io_unregister_personality io_uring/register.c:82 [inline]
>>>>  __io_uring_register io_uring/register.c:698 [inline]
>>>>  __do_sys_io_uring_register io_uring/register.c:902 [inline]
>>>>  __se_sys_io_uring_register+0x1227/0x3b60 io_uring/register.c:879
>>>>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>>>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>> RIP: 0033:0x7f65bbcb03a9
>>>> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>>>> RSP: 002b:00007ffe8fac7478 EFLAGS: 00000246 ORIG_RAX: 00000000000001ab
>>>> RAX: ffffffffffffffda RBX: 000000000000371d RCX: 00007f65bbcb03a9
>>>> RDX: 0000000000000000 RSI: 000000000000000a RDI: 0000000000000003
>>>> RBP: 0000000000000003 R08: 00000000000ac5f8 R09: 00000000000ac5f8
>>>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
>>>> R13: 00007ffe8fac7648 R14: 0000000000000001 R15: 0000000000000001
>>>>  </TASK>
>>>> ==================================================================
>>>
>>> Not sure what's going on with -next, but this looks like nonsense - we
>>> store a valid pointer in the xarry, and then attempt to delete an
>>> invalid index which then returns a totally garbage pointer!? I'll check
>>> what is in -next, but this very much does not look like an io_uring
>>> issue.
>>
>> Took a quick look, and it's this patch:
>>
>> commit d2e88c71bdb07f1e5ccffbcc80d747ccd6144b75
>> Author: Tamir Duberstein <tamird@gmail.com>
>> Date:   Tue Nov 12 14:25:37 2024 -0500
>>
>>     xarray: extract helper from __xa_{insert,cmpxchg}
>>
>> in the current -next tree. Adding a few folks who might be interested.
>>
>> --
>> Jens Axboe
> 
> Yep, looks broken. I believe the missing bit is
> 
> diff --git a/lib/xarray.c b/lib/xarray.c
> index 2af86bede3c1..5da8d18899a1 100644
> --- a/lib/xarray.c
> +++ b/lib/xarray.c
> @@ -1509,7 +1509,7 @@ static void *xas_result(struct xa_state *xas, void *curr)
>  void *__xa_erase(struct xarray *xa, unsigned long index)
>  {
>   XA_STATE(xas, xa, index);
> - return xas_result(&xas, xas_store(&xas, NULL));
> + return xas_result(&xas, xa_zero_to_null(xas_store(&xas, NULL)));
>  }
>  EXPORT_SYMBOL(__xa_erase);
> 
> This would explain deletion of a reserved entry returning
> `XA_ZERO_ENTRY` rather than `NULL`.

Yep this works.

> My apologies for this breakage. Should I send a new version? A new
> "fixes" patch?

Since it seems quite drastically broken, and since it looks like Andrew
is holding it, seems like the best course of action would be to have it
folded with the existing patch.

-- 
Jens Axboe

