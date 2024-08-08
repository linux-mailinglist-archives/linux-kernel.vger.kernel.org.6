Return-Path: <linux-kernel+bounces-280057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC1B94C521
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9931C21991
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F26E154C18;
	Thu,  8 Aug 2024 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mr7xfdjs"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE613433AD
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723144939; cv=none; b=KvXkFKb5dLXzFVfay/pylgmO/6soKkdIPWRkmsR0g30KH9GzAijm9uCECqnJvamqrgBn6E1JIhA3RWpi+JSnxhbgXbTHgjSsYsPMpC5JiDuSwDXLutSC6uimLT3tNkSeL/uadrJHJCNj+hT/M+yTh0hGUwvf1H6mZPvQJ2uJtlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723144939; c=relaxed/simple;
	bh=PYkKAy6ELFfax2YzPFG6Y+PdGhltqVncpQjO7U8XC+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vxv6TX7C3c3K2tpIWOUbCs/zr4aRk8ru9EHXMh0YBWyQRsVK39J8bPXCbyUGOxk1RuKa6G6YuXutt5xhG8jrN4B/DwkQicZ6FMJEbJLLOyfk5OF73H8gvceMscOmOt/a0EqUasa1/otIq9+o0jSBNF9fk0nuj3asL98keAUuRjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mr7xfdjs; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eeb1ba040aso17646291fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 12:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723144936; x=1723749736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjvyjj+JyXTzd8IC208rnZZnmbpX4ZlkWetNApQ+Xr8=;
        b=mr7xfdjshDPvuDU7fn9BvUeA8Z7WNB7dsZ6JH7OeodX1xtxK9durl0bXPr4RbPxY8x
         a5FNzyLtXae10Ukbush+uKNgVcITJX8GuS1qOht1LgcbCTXza9e5dKPYFgQaT/jGlO/6
         eLNYnbkLPeMXUS/ya/emGmE5kdgFWy57JDI1qKemWFeOo9Mfo7uhWlrlOjq9snVQavJ0
         Yb7RQ0u9qiQVHvkXbotRrUJ4c4Hid4rlwsuYzZ0OAOkfktTNLNI1XlYCSLRlamAZse/a
         0hFZb3ZxLUSX9QgkYNt/Fz4iawz/mpp23Lmg0Fd7DoKHEWnn+FMQ0MidhsJheFNTA+L3
         bxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723144936; x=1723749736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjvyjj+JyXTzd8IC208rnZZnmbpX4ZlkWetNApQ+Xr8=;
        b=XIMt3zUwu6ey5hKBRHlqgXlOgBxHdd5dk9zptOPM5n2Atz39G75czrnDlr3+uBWic+
         O7FaYMVHrJiKtW/Bte+rlmo26KsQXCoRupmH31YCoMB7t64ljxySD0XfEqMWlMZaWMGy
         u8S4FnbLCLrRCBvgsq0WO72BsvF7a0tMbYMi7k3C0LvBgEsiFm/KjRmPIXMlRKuvEp7D
         pojDN8k1Ml+mkrh3zzl+b+AzH+mSX0Vps6r0CKsvbawAtlALq6LFt1/am4EGUs6zeDES
         K3olG5Pk3cI4OYX9Lqfdsu85MuLHJdFZvygzjYCnBu9lE9gqTXtZ+UYREtDM74/nod1D
         klnA==
X-Forwarded-Encrypted: i=1; AJvYcCUpXoVn4HEMAvn1/udHkNudOjXSbGMjuae/O7Yd3hkbve4BEO5rGmDrBrWvFncWs6WkAHQzGB0MfsjII6dfew+Li7ZGxIS8AxFEuvCN
X-Gm-Message-State: AOJu0YwY6Q/d/DxQofsXb6taqR9IdRfw596HFRLTqopYQUpzbfiqohyM
	oQp4hfsXe2jbTuCoWKHQEG9yH5JY399h7nsi/Gx+s+e9wcDT/nFHhdbDGgxIxlL57QticXYfsVw
	DyiN3dM2BGWKTEjBgU99TRS74qqw=
X-Google-Smtp-Source: AGHT+IFlee55o2rm6o3tzckdERFX73H0kuHVMKA8+FqL0m3WoiFCbNRewn70HjCOgowKzld2hNpEaiuErpmvS7oRwpQ=
X-Received: by 2002:a2e:be94:0:b0:2ef:2016:262e with SMTP id
 38308e7fff4ca-2f19dd8709cmr29133421fa.0.1723144935424; Thu, 08 Aug 2024
 12:22:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808125430.1172152-1-longman@redhat.com> <CA+fCnZdWgAD1pu4yyjON0ph9ae1B6iaWas0CbET+MXLNNXt5Hg@mail.gmail.com>
 <f8c46f64-1ac3-4da3-87b5-ef7ec2e37fb8@redhat.com>
In-Reply-To: <f8c46f64-1ac3-4da3-87b5-ef7ec2e37fb8@redhat.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 8 Aug 2024 21:22:02 +0200
Message-ID: <CA+fCnZdnFAvFYVN9Farmg1DKHy3ZmL3ZB0XqYUJVoETUpSpEiQ@mail.gmail.com>
Subject: Re: [PATCH v3] lib/stackdepot: Double DEPOT_POOLS_CAP if KASAN is enabled
To: Waiman Long <longman@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 8:32=E2=80=AFPM Waiman Long <longman@redhat.com> wro=
te:
>
>
> On 8/8/24 12:12, Andrey Konovalov wrote:
> > On Thu, Aug 8, 2024 at 2:54=E2=80=AFPM Waiman Long <longman@redhat.com>=
 wrote:
> >> As said in commit 02754e0a484a ("lib/stackdepot.c: bump stackdepot
> >> capacity from 16MB to 128MB"), KASAN uses stackdepot to memorize stack=
s
> >> for all kmalloc/kfree calls. So stackdepot capacity was increased 8
> >> times to accommodate KASAN usage even thought it was claimed 4X should
> >> be enough at that time.
> >>
> >> With commit fc60e0caa94d ("lib/stackdepot: use fixed-sized slots
> >> for stack records"), all stackdepot records uses a fixed size with
> >> CONFIG_STACKDEPOT_MAX_FRAMES (default=3D64) entries. This is merged to
> >> support evictable KASAN stack records. Commit 31639fd6cebd ("stackdepo=
t:
> >> use variable size records for non-evictable entries") re-enabled
> >> the use of variable size records for non-KASAN use cases, but KASAN
> >> (generic mode) still uses the large fixed size stack records.
> > No, since commit 711d349174fd ("kasan: revert eviction of stack traces
> > in generic mode") Generic KASAN doesn't use fixed-sized slots.
> >
> >> With the default CONFIG_STACKDEPOT_MAX_FRAMES of 64, KASAN use of
> >> stackdepot space had been more than double than before. Assuming an
> >> average stack frame size of 16, a KASAN stack record is almost 4X the
> >> size of a non-KASAN one.
> > So this is not correct.
> Yes, you are right. I missed the KASAN commit 711d349174fd in my
> analysis. I will update the commit log in the next version.
> >> When a wide variety of workloads are run on a debug kernel with KASAN
> >> enabled, the following warning may sometimes be printed.
> >>
> >>   [ 6818.650674] Stack depot reached limit capacity
> >>   [ 6818.650730] WARNING: CPU: 1 PID: 272741 at lib/stackdepot.c:252 d=
epot_alloc_stack+0x39e/0x3d0
> >>     :
> >>   [ 6818.650907] Call Trace:
> >>   [ 6818.650909]  [<00047dd453d84b92>] depot_alloc_stack+0x3a2/0x3d0
> >>   [ 6818.650916]  [<00047dd453d85254>] stack_depot_save_flags+0x4f4/0x=
5c0
> >>   [ 6818.650920]  [<00047dd4535872c6>] kasan_save_stack+0x56/0x70
> >>   [ 6818.650924]  [<00047dd453587328>] kasan_save_track+0x28/0x40
> >>   [ 6818.650927]  [<00047dd45358a27a>] kasan_save_free_info+0x4a/0x70
> >>   [ 6818.650930]  [<00047dd45358766a>] __kasan_slab_free+0x12a/0x1d0
> >>   [ 6818.650933]  [<00047dd45350deb4>] kmem_cache_free+0x1b4/0x580
> >>   [ 6818.650938]  [<00047dd452c520da>] __put_task_struct+0x24a/0x320
> >>   [ 6818.650945]  [<00047dd452c6aee4>] delayed_put_task_struct+0x294/0=
x350
> >>   [ 6818.650949]  [<00047dd452e9066a>] rcu_do_batch+0x6ea/0x2090
> >>   [ 6818.650953]  [<00047dd452ea60f4>] rcu_core+0x474/0xa90
> >>   [ 6818.650956]  [<00047dd452c780c0>] handle_softirqs+0x3c0/0xf90
> >>   [ 6818.650960]  [<00047dd452c76fbe>] __irq_exit_rcu+0x35e/0x460
> >>   [ 6818.650963]  [<00047dd452c79992>] irq_exit_rcu+0x22/0xb0
> >>   [ 6818.650966]  [<00047dd454bd8128>] do_ext_irq+0xd8/0x120
> >>   [ 6818.650972]  [<00047dd454c0ddd0>] ext_int_handler+0xb8/0xe8
> >>   [ 6818.650979]  [<00047dd453589cf6>] kasan_check_range+0x236/0x2f0
> >>   [ 6818.650982]  [<00047dd453378cf0>] filemap_get_pages+0x190/0xaa0
> >>   [ 6818.650986]  [<00047dd453379940>] filemap_read+0x340/0xa70
> >>   [ 6818.650989]  [<00047dd3d325d226>] xfs_file_buffered_read+0x2c6/0x=
400 [xfs]
> >>   [ 6818.651431]  [<00047dd3d325dfe2>] xfs_file_read_iter+0x2c2/0x550 =
[xfs]
> >>   [ 6818.651663]  [<00047dd45364710c>] vfs_read+0x64c/0x8c0
> >>   [ 6818.651669]  [<00047dd453648ed8>] ksys_read+0x118/0x200
> >>   [ 6818.651672]  [<00047dd452b6cf5a>] do_syscall+0x27a/0x380
> >>   [ 6818.651676]  [<00047dd454bd7e74>] __do_syscall+0xf4/0x1a0
> >>   [ 6818.651680]  [<00047dd454c0db58>] system_call+0x70/0x98
> >>
> >> With all the recent changes in stackdepot to support new KASAN feature=
s,
> >> it is obvious that the current DEPOT_POOLS_CAP of 8192 may not be
> >> enough when KASAN is enabled. Fix this stackdepot capability issue
> >> by doubling DEPOT_POOLS_CAP if KASAN is enabled. With 4k pages, the
> >> maximum stackdepot capacity is doubled to 256 MB with KASAN enabled.
> > It is possible that the stack depot runs out of space due to a truly
> > large number of unique stack traces, but I would first make sure that
> > is indeed the case. The one thing to check would be to dump all the
> > stack traces from the stack depot when it overflows, and check whether
> > they make sense. There have been cases in the past, when e.g. the task
> > context part of a stack trace from an interrupt didn't get stripped
> > properly, and thus almost each stack trace from an interrupt was
> > considered unique by the stack depot. Perhaps, something similar
> > started happening again.
>
> It could be.
>
> Anyway, I got a bug report from our QE team and they have seen it once
> so far. So it is not an easily reproducible problem. I need to do
> further investigation first. Thanks for your quick response.

If you have access to the environment where the issue is happening,
you can just make the stack depot keep dumping all new stack traces
being saved and monitor them for some time. If there's a problem with
interrupt contexts, you should be able to see it even without waiting
for the stack depot to overflow.

Thanks!

