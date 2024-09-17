Return-Path: <linux-kernel+bounces-331580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8655197AE82
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B832E1C236D0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548C9161319;
	Tue, 17 Sep 2024 10:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w5+wZPXv"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0573913C836
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726567802; cv=none; b=kmTbPd55hrMKx02m695pyBFQc+tKNBtPrcE9ftt0Y1JJfRF8OWrvVl+DyWgc/nT7l9W1AYSMEhmCFPq9GopRpCLRUg7FVOaBosqTR0l8oPc+iPePGuPn4x9z0DMxmh0urBFwLSmalegaVhxbkok5VYIwtUhcpJsjKf1Zrhq1elY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726567802; c=relaxed/simple;
	bh=mci6yPUx+wsul89Nqm1QrvcXenOqtKT5eHzKYgTmGJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5iYHbmehcT8UvWinKtMYhxazO9VjmH53JfGBz5xPwtvxkGlkz6qiMD6lpMbiqnDXRMMcwiwr6Sb5MU21qG418O0sXrsmAbEwBdMwzyQWLS5YIralHqu7f/ezot3XnwJ8q6q5DA9cbB5wkrsrKdn0HeHEU8je0tb3z1L9KT6Mrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w5+wZPXv; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-49bdc6e2e3dso1809875137.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 03:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726567800; x=1727172600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEzwSJGE/IhfM3ZCNhdv0v538ihtzVo7TmOfB7fiKIM=;
        b=w5+wZPXvQCEDuUHFEKZyPvA+M/7BQXJptBTIOhr2wvOoEwqXEf0AnuOh3C00WPinF6
         b7I7M+kVOXEptkI+aVG77ERU13/RjFfYnDBxZ+fFgTXBMXamKIw33EseMG2TUhSGZvr7
         zRQ0t3mR9GiyvkuLNXJRVnLu0qad0AFSmHudAXPjmpQ4o2tzBrubkLAQABICuTpKY4km
         kecPoMP9Dd++pkeDVP5dJUTNNFSVfMyExrIM+iRx37VPCX1jJ1Ju/sejOE74nMMm4PUP
         AcnZhX2owLruJvRN9D77RjVNnkqXmH+SHveDRtURYj0+qEafKBSU9k5kdDIPm1mD9ZfI
         ZtSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726567800; x=1727172600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QEzwSJGE/IhfM3ZCNhdv0v538ihtzVo7TmOfB7fiKIM=;
        b=FsQuxlctK+6YfFZO39HhWGxAC2s8i/tQd7x2bqtQRnLanZNo+ObqAdsgK+6YuxmJmx
         T+mJNWcFVghYSxD7GiEwztlsULAige4ftUFK9ZaSF/udUMcwix7SWuq/C2oZJsOQammQ
         LBvti0g/15I46kXVbz2odj6T8ciA5RCjEWmDUXNlMp4sNzmdHIwf1JGOdw785ixgZtG9
         y1W8MeG1iAZpUyO+uULZM+FkjYb2zXd4QOUUnZDhYB8+CEAcf3/I6d0KTuSL9LwK7aHi
         csUy3vVXcyCl74hB+ciTqVJggjbbK0zZY3+DoeZ5UZc0NZHK+PVN4nZ+cIcJ1ZcOQKNG
         3R5A==
X-Forwarded-Encrypted: i=1; AJvYcCXZm2ExaWj5GAr7C3Vsj6WdoFmSiwTeodb3+N2cXpBni8oOxzxoSPRXvvzg6QWnzf3/iQMjnI7lxgNtwAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd3hadoFUB8LhPq0h0LrSQGF9Mzj/jNxebzpTnhkmXfNb5pPcR
	crkBwk8hhAsMs1U1wokofZlXDb5+1KalvQI8Eb96c3BDcMhiz9DTeQ3v2mtLDKjdvJbhSNWcQqe
	8rxmsoa6CWNjp6LvpedRenmk6LpzmpmR814Gq
X-Google-Smtp-Source: AGHT+IF/+AY8Y44nMN9VUOTL+sG+4U2ePtDKxC1isK7HLOyM/JyvWzLOHy7MuIKAIhfqlNkhK/4NsSG649ctJq8kdEM=
X-Received: by 2002:a05:6102:c8a:b0:49b:fe4d:20e4 with SMTP id
 ada2fe7eead31-49d4157d270mr12189094137.28.1726567799603; Tue, 17 Sep 2024
 03:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66e57e46.050a0220.115905.0002.GAE@google.com> <rVaWgPULej8K7HqMPNIu8kVNyXNjjCiTB-QBtItLFBmk0alH6fV2tk4joVPk97Evnuv4ZRDd8HB5uDCkiFG6u81xKdzDj-KrtIMJSlF6Kt8=@proton.me>
 <CANp29Y5LiryeHFtHtx2XPZkPitOW2NhQfwDbUGw6XxDQ0q-vRw@mail.gmail.com>
In-Reply-To: <CANp29Y5LiryeHFtHtx2XPZkPitOW2NhQfwDbUGw6XxDQ0q-vRw@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 17 Sep 2024 12:09:19 +0200
Message-ID: <CAG_fn=XSQvdeFXCx2rsgdoUCyDV8t4LJBuRA8nKHKdCHrcWBYw@mail.gmail.com>
Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_bkey_cmp_packed_inlined
To: Aleksandr Nogikh <nogikh@google.com>
Cc: Piotr Zalewski <pZ010001011111@proton.me>, 
	syzbot <syzbot+6f655a60d3244d0c6718@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 8:27=E2=80=AFAM Aleksandr Nogikh <nogikh@google.com=
> wrote:
>
> +Alexander Potapenko
>
>
> On Tue, Sep 17, 2024 at 8:26=E2=80=AFAM 'Piotr Zalewski' via syzkaller-bu=
gs
> <syzkaller-bugs@googlegroups.com> wrote:
> >
> > Hello,
> >
> > On Saturday, September 14th, 2024 at 2:15 PM, syzbot <syzbot+6f655a60d3=
244d0c6718@syzkaller.appspotmail.com> wrote:
> >
> > > Hello,
> > >
> > > syzbot has tested the proposed patch but the reproducer is still trig=
gering an issue:
> > > kernel panic: corrupted stack end in x64_sys_call
> > >
> > > bucket 0:127 gen 0 has wrong data_type: got free, should be sb, fixin=
g
> > > bucket 0:127 gen 0 data type sb has wrong dirty_sectors: got 0, shoul=
d be 256, fixing
> > > done
> > > bcachefs (loop0): going read-write
> > > bcachefs (loop0): journal_replay...
> > > Kernel panic - not syncing: corrupted stack end detected inside sched=
uler
> > > CPU: 0 UID: 0 PID: 5945 Comm: syz.0.15 Not tainted 6.11.0-rc7-syzkall=
er-g57719771a244-dirty #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 08/06/2024
> > > Call Trace:
> > > <TASK>
> > >
> > > __dump_stack lib/dump_stack.c:93 [inline]
> > > dump_stack_lvl+0x216/0x2d0 lib/dump_stack.c:119
> > > dump_stack+0x1e/0x30 lib/dump_stack.c:128
> > > panic+0x4e2/0xcd0 kernel/panic.c:354
> > > schedule_debug kernel/sched/core.c:5745 [inline]
> >
> > The place where kernel task's stack magic number gets
> > smashed was found. Backtrace was presented below. Seems
> > like it is KMSAN's fault. Is this considered a bug?

Interesting, 18446744071600444244 is 0xffffffff82499354, which is the
get_shadow_origin_ptr() return address.
So we're indeed seeing a stack overflow in the instrumentation code.

Looking at vmlinux-b7718454 from
https://storage.googleapis.com/syzbot-assets/094db88ff1c2/vmlinux-b7718454.=
xz
(I am assuming it was used to test this patch), I see that a number
functions from the report have quite big stack frames:

symbol_string
ffffffff8fc9b801: 48 81 ec 00 03 00 00 sub    $0x300,%rsp
bch2_path_get
ffffffff853a7ad1: 48 81 ec 60 01 00 00 sub    $0x160,%rsp
bch2_btree_path_traverse_one
ffffffff85399741: 48 81 ec 70 02 00 00 sub    $0x270,%rsp
bch2_bucket_alloc_set_trans
ffffffff852bf441: 48 81 ec 98 03 00 00 sub    $0x398,%rsp
__open_bucket_add_buckets
ffffffff852d128d: 48 81 ec 70 02 00 00 sub    $0x270,%rsp
bch2_alloc_sectors_start_trans
ffffffff852c25d1: 48 81 ec b0 01 00 00 sub    $0x1b0,%rsp
bch2_btree_update_start
ffffffff85456c1d: 48 81 ec 20 01 00 00 sub    $0x120,%rsp
__bch2_trans_commit
ffffffff85424541: 48 81 ec a0 01 00 00 sub    $0x1a0,%rsp
btree_write_buffer_flush_seq
ffffffff8548dd6d: 48 81 ec 10 02 00 00 sub    $0x210,%rsp
journal_flush_pins
ffffffff856f6bad: 48 81 ec 38 01 00 00 sub    $0x138,%rsp
bch2_fs_recovery
ffffffff8575cff1: 48 81 ec 78 01 00 00 sub    $0x178,%rsp
bch2_fs_get_tree
ffffffff855ac5c1: 48 81 ec e8 01 00 00 sub    $0x1e8,%rsp

KASAN creates even bigger frames for these functions, but that's
because of redzones added around local variables.
For KASAN we increase the default kernel stack sizes to account for
that, but we do not for KMSAN, because its effect on stack frame sizes
was usually moderate.
But looking at the same stack sizes for a binary with CONFIG_KMSAN=3Dn
now, I'm seeing much lower values for some of them:

symbol_string
ffffffff8fd6d6e1: 48 81 ec 10 03 00 00 sub    $0x310,%rsp
bch2_path_get
ffffffff853ec4e1: 48 81 ec 68 01 00 00 sub    $0x168,%rsp
bch2_btree_path_traverse_one
ffffffff853de5a1: 48 81 ec 58 02 00 00 sub    $0x258,%rsp
bch2_bucket_alloc_set_trans
ffffffff853051d1: 48 81 ec b0 03 00 00 sub    $0x3b0,%rsp
__open_bucket_add_buckets
ffffffff8531759d: 48 81 ec 68 02 00 00 sub    $0x268,%rsp
bch2_alloc_sectors_start_trans
ffffffff85308de1: 48 81 ec b8 01 00 00 sub    $0x1b8,%rsp
bch2_btree_update_start
ffffffff8549a63d: 48 81 ec 20 01 00 00 sub    $0x120,%rsp
__bch2_trans_commit
ffffffff85468b51: 48 81 ec 80 01 00 00 sub    $0x180,%rsp
btree_write_buffer_flush_seq
ffffffff854d17fd: 48 81 ec 10 02 00 00 sub    $0x210,%rsp
journal_flush_pins
ffffffff8573c36d: 48 81 ec 30 01 00 00 sub    $0x130,%rsp
bch2_fs_recovery
ffffffff857a27d1: 48 81 ec 68 01 00 00 sub    $0x168,%rsp
bch2_fs_get_tree
ffffffff855f04d1: 48 81 ec e8 01 00 00 sub    $0x1e8,%rsp

I'll probably need to recalculate the overall stack bloat for KMSAN
builds and land something along the lines of
https://github.com/google/kmsan/commit/060de96aa5de0a95b42589920b64e9aa95af=
2151,
if needed.

