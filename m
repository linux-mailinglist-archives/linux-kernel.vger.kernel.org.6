Return-Path: <linux-kernel+bounces-519358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0308EA39C09
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E41F3A7479
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D192417F6;
	Tue, 18 Feb 2025 12:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WX9ssG2C"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D66622E3E6;
	Tue, 18 Feb 2025 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739881028; cv=none; b=d4WQ8uMC+mkb95GE9UUhyAjM4lLLL2Bre7iW6AbEU4/5DChkVvgr1mocrJWfzf5JDuT9o0CWRXUJE3AfmVsTFTo8q4d4A8QszKU3yeBrhcOJ9PARiKnP+1hpCIE+PH+8smo4zyKHXsx1K/TvxhRX+iwvdcryIG5Rq6YyUaxbaNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739881028; c=relaxed/simple;
	bh=/AzQb30OOP2Y/Cyju7Hx/qEr867cl3qE/8gM99+gnZ4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GzCJm9riPU298e1K0Ui4e3f/O/J3UYGLZvM3pCwQy4L5/kzrVYlQVmsvd+yyE+REEMtZb+wxShvdUEdMWUjWMh7vMy3au268k2WZST9yCmMPiJT9SQoqeGPZ5nveqo+67jV/o+WtLZ3HNs17XSO9EvGIqEGLTxemAZ9P76rGUy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WX9ssG2C; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-471c8bcb4a9so42081131cf.2;
        Tue, 18 Feb 2025 04:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739881026; x=1740485826; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94WjMlwBeMhqPjiS2ysQkSO3XWSoqcMcB1ehVgKIhdg=;
        b=WX9ssG2CjIJRFYccXn8InIEnzpKM4C+5LQtPv8DDHglsNnS0rTFaf7SccF3VggK+u8
         YNl8Pa8iQEOijafRb/6qhX57G4SWkoZSn/jCjT5wkG+lT/85bODCMYmT0N5ypNpjDCJY
         w1oYBJjketyqpMmbYwn7dup10fKOdVP59QQGF5xkLCgsj8iQ0LGGOHmmbuyAQgUdAofP
         QVfCoRvc23t9DxNg43tdTxsRqr+XKMbmDduvUipY7XEgDQOORWiv05MIiH7scZx/axbB
         YzgrH17LM0MsxE/vpIPRs84Lg0Xb+s6uvs8uP9hBXu/yatpmyJRtlCVGy+261rOHvbb1
         iqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739881026; x=1740485826;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94WjMlwBeMhqPjiS2ysQkSO3XWSoqcMcB1ehVgKIhdg=;
        b=lCPL3XrYxSwggBEr68zhMLbIBK7B+Nzo3oowIwlnBnfGT5s+Z74KFUUHEn27dzTyc6
         BqiEX53eLDkUxIs5JKKNkHY+OGdf3zhfmXcKQrbuMxtHQ3ChHfY4qxe+C0NGN5/vXLNZ
         NW6OgzJLSrcz9W4LGeKRzywSAP+69HvDvdgUuTK+7nITEJ56w3g7en62YMoUOyUEP0X/
         L0b55mtmoYNYCSoFvqu4Gcy3PZB2NzFLFBNxcYY9ZcYaBlfyQpdPKmsbuO4fUINtF+KN
         glUxgXxtXkNbaH9dROwB2jg8B1Vmer2fkZ1YpADoKk+QTAQbtHJo+ZeBrult2H8BovaG
         1Mig==
X-Forwarded-Encrypted: i=1; AJvYcCU7Rz5f0Ampy6ecs3Msjt62Fq6nbF9QFy2e4XizdAgoRB8gZMbJHSXvPiTBhY3q9c1m8Uxmrmkvv3lwAfIH4Q==@vger.kernel.org, AJvYcCV6jyqiKI9K3L5n4JWaLEAZ5a6k4zYxa4iPovXmUARwhXYTP/LNf4VsvzvSYF3ScO6QXtNjtLqEXCbwBYV4@vger.kernel.org
X-Gm-Message-State: AOJu0YwbGvwRQ2UvQWfIxX7/lzji4f/gHqEgkw9EsbySZvptH1RgoD5L
	/iNymhKkMREZBmHb/sSN5PQ4bT5vuffmnw+R5sZwsTdckL6q1/4Cr4M60YQv
X-Gm-Gg: ASbGncurb/knZ4cz5Rc4uLJk1GfpAFlIx/n6DOhl/c+g9JIddynrcul9GaWAtj5/A2r
	kvZ906mCbXcTS8Qcez0+SVWYzVwIQn38305sIN2VdiYdU+B099FOfhMt9Ns/8J7L5lPuq8mOEC4
	CGwrrqlYye8wfG3SWNvuMuun+6IGelYqnNqo2RYmIHO+xc7H9x7uP6V2n35n2cI99g2us2m/FFG
	o0BiDh/D+Aq6ROB+AUaN7c08ZvqydibnHDbmOLmmTn/WJZ8gKZJt1+2FPtvrebK9+OH4VrLrsI=
X-Google-Smtp-Source: AGHT+IETRkYKNULtxGK4oITPLh08WB2UZ4ajJJiFWUY9vNSiK2SYnkPX1qRLwrmdFqzLSnE1ns4U1w==
X-Received: by 2002:a05:622a:15c5:b0:471:f992:8c24 with SMTP id d75a77b69052e-471f992982fmr76299241cf.49.1739881025821;
        Tue, 18 Feb 2025 04:17:05 -0800 (PST)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f89e397esm14071501cf.29.2025.02.18.04.16.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2025 04:17:04 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [syzbot] [mm?] [bcachefs?] WARNING in lock_list_lru_of_memcg
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <CAMgjq7D_gf6Kcp3e0wLDCboHUHXpjzMsFagC83gqmAn_dvuejQ@mail.gmail.com>
Date: Tue, 18 Feb 2025 20:16:40 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 kent.overstreet@linux.dev,
 syzbot <syzbot+38a0cbd267eff2d286ff@syzkaller.appspotmail.com>,
 chengming.zhou@linux.dev,
 hannes@cmpxchg.org,
 linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 mhocko@suse.com,
 muchun.song@linux.dev,
 roman.gushchin@linux.dev,
 sashal@kernel.org,
 shakeel.butt@linux.dev,
 syzkaller-bugs@googlegroups.com,
 willy@infradead.org,
 yuzhao@google.com,
 zhengqi.arch@bytedance.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <ACDD48FA-728B-45A4-896E-B4A28E586EAF@gmail.com>
References: <675d01e9.050a0220.37aaf.00be.GAE@google.com>
 <67af8747.050a0220.21dd3.004c.GAE@google.com>
 <20250214152358.7ba29d10229e2155c0899774@linux-foundation.org>
 <CAMgjq7DQm+nwTWMdWQ66WW84O6YnhRQvZEjaY3EeXZ5-iKXo-A@mail.gmail.com>
 <CAMgjq7AqZaRuu+udJd7MyU2n3eF7wKX8bjDugFrdHYd2Lq=EXQ@mail.gmail.com>
 <751557A5-5417-497D-95FF-62E7CFCCDC59@gmail.com>
 <CAMgjq7D_gf6Kcp3e0wLDCboHUHXpjzMsFagC83gqmAn_dvuejQ@mail.gmail.com>
To: Kairui Song <ryncsn@gmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)

On Feb 18, 2025, at 19:40, Kairui Song <ryncsn@gmail.com> wrote:
>=20
> On Tue, Feb 18, 2025 at 2:09=E2=80=AFAM Alan Huang =
<mmpgouride@gmail.com> wrote:
>>=20
>> On Feb 18, 2025, at 01:12, Kairui Song <ryncsn@gmail.com> wrote:
>>>=20
>>> On Mon, Feb 17, 2025 at 12:13=E2=80=AFAM Kairui Song =
<ryncsn@gmail.com> wrote:
>>>>=20
>>>> On Sat, Feb 15, 2025 at 7:24=E2=80=AFAM Andrew Morton =
<akpm@linux-foundation.org> wrote:
>>>>>=20
>>>>> On Fri, 14 Feb 2025 10:11:19 -0800 syzbot =
<syzbot+38a0cbd267eff2d286ff@syzkaller.appspotmail.com> wrote:
>>>>>=20
>>>>>> syzbot has found a reproducer for the following issue on:
>>>>>=20
>>>>> Thanks.  I doubt if bcachefs is implicated in this?
>>>>>=20
>>>>>> HEAD commit:    128c8f96eb86 Merge tag 'drm-fixes-2025-02-14' of =
https://g..
>>>>>> git tree:       upstream
>>>>>> console output: =
https://syzkaller.appspot.com/x/log.txt?x=3D148019a4580000
>>>>>> kernel config:  =
https://syzkaller.appspot.com/x/.config?x=3Dc776e555cfbdb82d
>>>>>> dashboard link: =
https://syzkaller.appspot.com/bug?extid=3D38a0cbd267eff2d286ff
>>>>>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils =
for Debian) 2.40
>>>>>> syz repro:      =
https://syzkaller.appspot.com/x/repro.syz?x=3D12328bf8580000
>>>>>>=20
>>>>>> Downloadable assets:
>>>>>> disk image (non-bootable): =
https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_dis=
k-128c8f96.raw.xz
>>>>>> vmlinux: =
https://storage.googleapis.com/syzbot-assets/a97f78ac821e/vmlinux-128c8f96=
.xz
>>>>>> kernel image: =
https://storage.googleapis.com/syzbot-assets/f451cf16fc9f/bzImage-128c8f96=
.xz
>>>>>> mounted in repro: =
https://storage.googleapis.com/syzbot-assets/a7da783f97cf/mount_3.gz
>>>>>>=20
>>>>>> IMPORTANT: if you fix the issue, please add the following tag to =
the commit:
>>>>>> Reported-by: =
syzbot+38a0cbd267eff2d286ff@syzkaller.appspotmail.com
>>>>>>=20
>>>>>> ------------[ cut here ]------------
>>>>>> WARNING: CPU: 0 PID: 5459 at mm/list_lru.c:96 =
lock_list_lru_of_memcg+0x39e/0x4d0 mm/list_lru.c:96
>>>>>=20
>>>>>       VM_WARN_ON(!css_is_dying(&memcg->css));
>>>>=20
>>>> I'm checking this, when last time this was triggered, it was caused =
by
>>>> a list_lru user did not initialize the memcg list_lru properly =
before
>>>> list_lru reclaim started, and fixed by:
>>>> =
https://lore.kernel.org/all/20241222122936.67501-1-ryncsn@gmail.com/T/
>>>>=20
>>>> This shouldn't be a big issue, maybe there are leaks that will be
>>>> fixed upon reparenting, and this new added sanity check might be =
too
>>>> lenient, I'm not 100% sure though.
>>>>=20
>>>> Unfortunately I couldn't reproduce the issue locally with the
>>>> reproducer yet. will keep the test running and see if it can hit =
this
>>>> WARN_ON.
>>>=20
>>> So far I am still unable to trigger this VM_WARN_ON using the
>>> reproducer, and I'm seeing many other random crashes.
>>>=20
>>> But after I changed the .config a bit adding more debug configs
>>> (SLAB_FREELIST_HARDENED, DEBUG_PAGEALLOC), following crash showed up
>>> and will be triggered immediately after I start the test:
>>>=20
>>> [ T1242] BUG: unable to handle page fault for address: =
ffff888054c60000
>>> [ T1242] #PF: supervisor read access in kernel mode
>>> [ T1242] #PF: error_code(0x0000) - not-present page
>>> [ T1242] PGD 19e01067 P4D 19e01067 PUD 19e04067 PMD 7fc5c067 PTE
>>> 800fffffab39f060
>>> [ T1242] Oops: Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN PTI
>>> [ T1242] CPU: 1 UID: 0 PID: 1242 Comm: kworker/1:1H Not tainted
>>> 6.14.0-rc2-00185-g128c8f96eb86 #2
>>> [ T1242] Hardware name: Red Hat KVM/RHEL-AV, BIOS
>>> 1.16.0-4.module+el8.8.0+664+0a3d6c83 04/01/2014
>>> [ T1242] Workqueue: bcachefs_btree_read_complete =
btree_node_read_work
>>> [ T1242] RIP: 0010:validate_bset_keys+0xae3/0x14f0
>>> [ T6058] bcachefs (loop2): empty btree root xattrs
>>> [ T1242] Code: 49 39 df 0f 87 fc 09 00 00 e8 79 54 a8 fd 41 0f b7 c6
>>> 48 8b 4c 24 68 48 8d 04 c1 4c 29 f8 48 c1 e8 03 89 c1 48 89 de 4c 89
>>> ff <f3> 48 a5 48 8b bc 24 c8 00 00 08
>>> [ T1242] RSP: 0018:ffffc900070a72c0 EFLAGS: 00010206
>>> [ T1242] RAX: 000000000000ec0f RBX: ffff888054c20110 RCX: =
0000000000006c31
>>> [ T1242] RDX: 0000000000000000 RSI: ffff888054c60000 RDI: =
ffff888054c5ff90
>>> [ T1242] RBP: ffffc900070a7570 R08: ffff888065e001af R09: =
1ffff1100cbc0035
>>> [ T1242] R10: dffffc0000000000 R11: ffffed100cbc0036 R12: =
ffff888054c2009e
>>> [ T1242] R13: dffffc0000000000 R14: 000000000000ec0f R15: =
ffff888054c200a0
>>> [ T1242] FS:  0000000000000000(0000) GS:ffff88807ea00000(0000)
>>> knlGS:0000000000000000
>>> [ T1242] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [ T1242] CR2: ffff888054c60000 CR3: 000000006cea6000 CR4: =
00000000000006f0
>>> [ T1242] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
>>> [ T1242] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
>>> [ T1242] Call Trace:
>>> [ T1242]  <TASK>
>>> [ T1242]  bch2_btree_node_read_done+0x1d20/0x53a0
>>> [ T1242]  btree_node_read_work+0x54d/0xdc0
>>> [ T1242]  process_scheduled_works+0xaf8/0x17f0
>>> [ T1242]  worker_thread+0x89d/0xd60
>>> [ T1242]  kthread+0x722/0x890
>>> [ T1242]  ret_from_fork+0x4e/0x80
>>> [ T1242]  ret_from_fork_asm+0x1a/0x30
>>> [ T1242]  </TASK>
>>> [ T1242] Modules linked in:
>>> [ T1242] ---[ end trace 0000000000000000 ]---
>>> [ T1242] RIP: 0010:validate_bset_keys+0xae3/0x14f0
>>> [ T1242] Code: 49 39 df 0f 87 fc 09 00 00 e8 79 54 a8 fd 41 0f b7 c6
>>> 48 8b 4c 24 68 48 8d 04 c1 4c 29 f8 48 c1 e8 03 89 c1 48 89 de 4c 89
>>> ff <f3> 48 a5 48 8b bc 24 c8 00 00 08
>>> [ T1242] RSP: 0018:ffffc900070a72c0 EFLAGS: 00010206
>>> [ T1242] RAX: 000000000000ec0f RBX: ffff888054c20110 RCX: =
0000000000006c31
>>> [ T1242] RDX: 0000000000000000 RSI: ffff888054c60000 RDI: =
ffff888054c5ff90
>>> [ T1242] RBP: ffffc900070a7570 R08: ffff888065e001af R09: =
1ffff1100cbc0035
>>> [ T1242] R10: dffffc0000000000 R11: ffffed100cbc0036 R12: =
ffff888054c2009e
>>> [ T1242] R13: dffffc0000000000 R14: 000000000000ec0f R15: =
ffff888054c200a0
>>> [ T1242] FS:  0000000000000000(0000) GS:ffff88807ea00000(0000)
>>> knlGS:0000000000000000
>>> [ T1242] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [ T1242] CR2: ffff888054c60000 CR3: 000000006cea6000 CR4: =
00000000000006f0
>>> [ T1242] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
>>> [ T1242] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
>>> [ T1242] Kernel panic - not syncing: Fatal exception
>>> [ T1242] Kernel Offset: disabled
>>> [ T1242] Rebooting in 86400 seconds..
>>>=20
>>> It's caused by the memmove_u64s_down in validate_bset_keys of
>>> fs/bcachefs/btree_io.c:
>>> -> memmove_u64s_down(k, bkey_p_next(k), (u64 *) vstruct_end(i) - =
(u64 *) k);
>>=20
>>=20
>> Might need this.
>>=20
>> diff --git a/fs/bcachefs/btree_io.c b/fs/bcachefs/btree_io.c
>> index e71b278672b6..fb53174cb735 100644
>> --- a/fs/bcachefs/btree_io.c
>> +++ b/fs/bcachefs/btree_io.c
>> @@ -997,7 +997,7 @@ static int validate_bset_keys(struct bch_fs *c, =
struct btree *b,
>>                }
>> got_good_key:
>>                le16_add_cpu(&i->u64s, -next_good_key);
>> -               memmove_u64s_down(k, bkey_p_next(k), (u64 *) =
vstruct_end(i) - (u64 *) k);
>> +               memmove_u64s_down(k, bkey_p_next(k), (u64 *) =
vstruct_end(i) - (u64 *) bkey_p_next(k));
>>                set_btree_node_need_rewrite(b);
>>        }
>> fsck_err:
>>=20
>=20
> Thanks, but this didn't fix everything. I think the problem is more
> complex, syzbot seems to be trying to mount damaged bcachefs (on
> purpose I think), so the vstruct_end(i) is already returning an offset
> that is out of border.

Could you try this (I need to go out now):

diff --git a/fs/bcachefs/btree_io.c b/fs/bcachefs/btree_io.c
index e71b278672b6..80a0094be356 100644
--- a/fs/bcachefs/btree_io.c
+++ b/fs/bcachefs/btree_io.c
@@ -997,7 +997,7 @@ static int validate_bset_keys(struct bch_fs *c, =
struct btree *b,
                }
 got_good_key:
                le16_add_cpu(&i->u64s, -next_good_key);
-               memmove_u64s_down(k, bkey_p_next(k), (u64 *) =
vstruct_end(i) - (u64 *) k);
+               memmove_u64s_down(k, (u64 *) k + next_good_key, (u64 *) =
vstruct_end(i) - (u64 *) k);
                set_btree_node_need_rewrite(b);
        }
 fsck_err:

>=20
> I retriggered it and print some more debug info: i->_data is
> ffff88806d5c00a0, i->u64s is 60928, and the faulting address is
> ffff88806d600000.



