Return-Path: <linux-kernel+bounces-337342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7CB9848DD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA8F2844C0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289F81ABEA6;
	Tue, 24 Sep 2024 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wWyF+ks4"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811401AB6F6
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 15:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193167; cv=none; b=Rvzn7rjTU1hTIdK5AMe4r5z9lwUEvl1klSuGBslUOzmswYO07ncKYe5Na3KiL/gux9q2tO0GQHhugH3rKkHDsmMD+2XkPUtdqmH/yCXDq9LSXWrZ8sTqxcpW68Jm24HPy/1qdKBxSqWRj6V8+yuPmVspydd2kswGvKvu9BhL2EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193167; c=relaxed/simple;
	bh=G0znbKOJzJpF6kwSD1mm85E7O07VfHarIcFX09pb0Hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9ILliTeCEY10p68KC/b15ZVukK3r1vtnERaxZj+/U2ZjCY6NWkqoxzyJRIJiXgAUeYCOK3j7EtBIHXDNu0/jcIyiJD7iBxOQxASX/DK5St3R7FrOWgxjizS4rWQ2xHmlXWScd3F30KEJA+VNqmxnW6Fui2R4/9nKuQTP6qMtys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wWyF+ks4; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a0cb892c6aso369065ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727193164; x=1727797964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENsNIixmdO/D33v64/Hx/nN4OGp/TO1/agjSHYnW6c8=;
        b=wWyF+ks4cGr2u8o4VJ2ipybJivX4CH9c4tHMY9kmXHmAghrTHx/qDv682lZrvfFHky
         1/emgsmzjcXvsgAUg2ot8qrKQmqe21H5GXpXWnyd9lU5IrEh/JbqTFIOT4d+SMsRxCZf
         eLVzq4kLni9T3vaVOhej2r047RdlF5+A1A2G/XeRZfcKFCPVf2Zsp5IECM8FSjY7FPla
         nrPC0+RbUmfM2a4Q22l3Eez8lOoJj9muMC1oglvZb4V0lJPwe3vpahA1oMMUPIrlaoE7
         53QQgO72bBSdfTjSgVls52idXhPxB5+9TseknFWsGmakGu0JJFESBO0Ek6QhIgt/6hi3
         SXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727193164; x=1727797964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENsNIixmdO/D33v64/Hx/nN4OGp/TO1/agjSHYnW6c8=;
        b=vhPVvJAFCufdp4YTS6kyvCxNvd5rlw+F3XiOsZAW44ChxWJz762CqWJEYg9GhqVOUj
         rJPqUOi40AZeiETrzvP4fDBPvU1WgnGRSqOTDg3rZCgJ83edPVlXXvy43HnKJ+fBLXde
         e27n3X+c7V1PxUGUPBfBfuQYjBkCADYFpytsLH98FDz3QI0gZJr5wgece0D938Qlzao4
         qNq1N56KiPxVHp6rxnAYxpl4kfTl0gloKPWvCeQhUcFa9I0rh0qOKDpiZvmgt0tOuJ0S
         P8Bi8VAVEssPdq/9fEPapyRIupvRj3MI83W0QKCg3czHDJKGCsuhM/lcK8n9hvHrZfJS
         Oyyg==
X-Forwarded-Encrypted: i=1; AJvYcCU0RGQEP0ZGHLWXjFxKS32j8b1DaYff95QRAC/DTDyi6AykIwhRWDhc76OdOmlKlG+pRDY0TNpCsyFMRiY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza90jfgybFBqVMn3iK8n32vRCBStmrgSSwCHDspXwIV3X2m09u
	1hVWdQ0Klujl9o7TSEsIqRuAHAXpBCBQrJ5U73II2MohJUXtkt9n54NPLI4PoI0XCapTPPHGGJM
	0VqSnT64YYoMiUA1cStVUoKWlBby/072NJ6IE5AefVdCC7p7lPg==
X-Google-Smtp-Source: AGHT+IELGZjXltkg3qBeobxfMw7rerOwxwG8wpctteLRbwplJ6NsWp8Xt3vulpIq6pA2by6mmcs96Df/iUnCU4neaQI=
X-Received: by 2002:a05:6e02:1aab:b0:3a0:91e7:67dc with SMTP id
 e9e14a558f8ab-3a1a3eebe75mr4783475ab.4.1727193164068; Tue, 24 Sep 2024
 08:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911025600.3681789-1-senozhatsky@chromium.org>
 <20240917013021.868769-1-senozhatsky@chromium.org> <CAF8kJuPq+JwvwrG+H+XU23Xz+Do+qy8RPJBBVRsL0YGQzZpfrQ@mail.gmail.com>
In-Reply-To: <CAF8kJuPq+JwvwrG+H+XU23Xz+Do+qy8RPJBBVRsL0YGQzZpfrQ@mail.gmail.com>
From: Chris Li <chriscli@google.com>
Date: Tue, 24 Sep 2024 08:52:32 -0700
Message-ID: <CAF8kJuMQqib-2qhjNTFzKdUdJoUhTOuhv5GtgLnSsUStMHbwdw@mail.gmail.com>
Subject: Re: [PATCHv2] zram: free secondary algorithms names
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	Kairui Song <ryncsn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On Tue, Sep 24, 2024 at 8:36=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> Hi Sergey,
>
> The current mm-unstable is breaking my swap stress test again. While ther=
e seems to be multiple bad commits that cause it. I have bisected into this=
 commit causing kernel warning and followed by BUG().
>
> [   56.630032] zswap: loaded using pool lzo/zsmalloc
> [   56.718027] zram0: detected capacity change from 16777216 to 0
> [   56.725492] zram: Removed device: zram0
> [   56.740125] ------------[ cut here ]------------
> [   56.744616] WARNING: CPU: 2 PID: 1894 at mm/slub.c:4556 free_large_kma=
lloc+0x4d/0x80
> [   56.745119] Modules linked in:
> [   56.749551] CPU: 2 UID: 0 PID: 1894 Comm: zram-generator Tainted: G S =
                6.11.0-rc6+ #33
> [   56.750129] Tainted: [S]=3DCPU_OUT_OF_SPEC
> [   56.750908] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9,=
 BIOS P89 09/21/2023
> [   56.751354] RIP: 0010:free_large_kmalloc+0x4d/0x80
> [   56.756120] Code: 00 10 00 00 48 d3 e0 f7 d8 81 e2 c0 00 00 00 75 2f 8=
9 c6 48 89 df e8 82 ff ff ff f0 ff 4b 34 0f 85 e
> 9 7d f5 00 e9 eb 7d f5 00 <0f> 0b 80 3d a8 f3 9b 02 00 0f 84 bd 7d f5 00 =
b8 00 f0 ff ff eb d1
> [   56.761370] RSP: 0018:ffffaeaaa3657b20 EFLAGS: 00010246
> [   56.761676] RAX: 0057ffffc0002000 RBX: ffffece0c1f40e80 RCX: 000000008=
040003f
> [   56.766293] RDX: ffffece0c1f40e88 RSI: ffffffff9a03a131 RDI: ffffece0c=
1f40e80
> [   56.770931] RBP: 0000000000200000 R08: ffff95571d256480 R09: 000000008=
040003f
> [   56.775540] R10: 000000008040003f R11: 000000000000032c R12: 000000000=
0200000
> [   56.780212] R13: ffff953787c71e40 R14: 0000000000000047 R15: ffff95379=
b2e3e20
> [   56.784943] FS:  00007fb0f1d58bc0(0000) GS:ffff95567ed00000(0000) knlG=
S:0000000000000000
> [   56.785403] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   56.789937] CR2: 00007f35b6449050 CR3: 00000001112ac006 CR4: 000000000=
01706f0
> [   56.794784] Call Trace:
> [   56.794941]  <TASK>
> [   56.799377]  ? free_large_kmalloc+0x4d/0x80
> [   56.799598]  ? __warn.cold+0x8e/0xe8
> [   56.799842]  ? free_large_kmalloc+0x4d/0x80
> [   56.800065]  ? report_bug+0xff/0x140
> [   56.800296]  ? handle_bug+0x3c/0x80
> [   56.804703]  ? exc_invalid_op+0x17/0x70
> [   56.804912]  ? asm_exc_invalid_op+0x1a/0x20
> [   56.805132]  ? free_large_kmalloc+0x4d/0x80
> [   56.805344]  zram_destroy_comps+0x32/0x70
> [   56.805568]  zram_reset_device+0x102/0x190
> [   56.805812]  reset_store+0xa6/0x110
> [   56.810207]  kernfs_fop_write_iter+0x141/0x1f0
> [   56.814689]  vfs_write+0x294/0x460
> [   56.819106]  ksys_write+0x6d/0xf0
> [   56.823550]  do_syscall_64+0x82/0x160
> [   56.823827]  ? __pfx_kfree_link+0x10/0x10
> [   56.824051]  ? do_sys_openat2+0x9c/0xe0
> [   56.824263]  ? __handle_mm_fault+0xb34/0xfb0
> [   56.828752]  ? syscall_exit_to_user_mode+0x10/0x220
> [   56.833220]  ? do_syscall_64+0x8e/0x160
> [   56.833429]  ? __count_memcg_events+0x77/0x130
> [   56.838021]  ? count_memcg_events.constprop.0+0x1a/0x30
> [   56.838318]  ? handle_mm_fault+0x1bb/0x2c0
> [   56.838542]  ? do_user_addr_fault+0x55a/0x7b0
> [   56.843014]  ? exc_page_fault+0x7e/0x180
> [   56.843228]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   56.843831] RIP: 0033:0x7fb0f1f7a984
> [   56.844045] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 0=
0 00 00 00 00 f3 0f 1e fa 80 3d c5 06 0e 00 00 7
> 4 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 =
e5 48 83 ec 20 48 89
> [   56.849247] RSP: 002b:00007ffc7db8fde8 EFLAGS: 00000202 ORIG_RAX: 0000=
000000000001
> [   56.853889] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fb0f=
1f7a984
> [   56.858482] RDX: 0000000000000001 RSI: 0000560df4e4ea65 RDI: 000000000=
0000004
> [   56.863154] RBP: 0000000000000004 R08: 0000560e0e417010 R09: 000000000=
0000007
> [   56.867794] R10: 00000000000001b6 R11: 0000000000000202 R12: 7ffffffff=
fffffff
> [   56.872980] R13: 00007fb0f1f7a970 R14: 0000560df4e4ea65 R15: 0000560df=
4e71bd0
> [   56.878043]  </TASK>
> [   56.878555] ---[ end trace 0000000000000000 ]---
> [   56.883420] object pointer: 0x00000000f38e5ae7
> [   56.888235] BUG: Bad page state in process zram-generator  pfn:407d03a
> [   56.889026] page: refcount:0 mapcount:0 mapping:0000000000000000 index=
:0x0 pfn:0x407d03a
> [   56.889877] flags: 0x57ffffc0002000(reserved|node=3D1|zone=3D2|lastcpu=
pid=3D0x1fffff)
> [   56.894915] raw: 0057ffffc0002000 ffffece0c1f40e88 ffffece0c1f40e88 00=
00000000000000
> [   56.895771] raw: 0000000000000000 0000000000000000 00000000ffffffff 00=
00000000000000
> [   56.896562] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
> [   56.897332] Modules linked in:
> [   56.902165] CPU: 2 UID: 0 PID: 1894 Comm: zram-generator Tainted: G S =
     W          6.11.0-rc6+ #33
> [   56.903155] Tainted: [S]=3DCPU_OUT_OF_SPEC, [W]=3DWARN
> [   56.908082] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9,=
 BIOS P89 09/21/2023
> [   56.908918] Call Trace:
> [   56.909484]  <TASK>
> [   56.914148]  dump_stack_lvl+0x5d/0x80
> [   56.914747]  bad_page.cold+0x7a/0x91
> [   56.915318]  free_unref_page+0x344/0x520
> [   56.915975]  zram_destroy_comps+0x32/0x70
> [   56.916452]  zram_reset_device+0x102/0x190
> [   56.917057]  reset_store+0xa6/0x110
> [   56.921874]  kernfs_fop_write_iter+0x141/0x1f0
> [   56.926685]  vfs_write+0x294/0x460
> [   56.931385]  ksys_write+0x6d/0xf0
> [   56.936087]  do_syscall_64+0x82/0x160
> [   56.936656]  ? __pfx_kfree_link+0x10/0x10
> [   56.937257]  ? do_sys_openat2+0x9c/0xe0
> [   56.937810]  ? __handle_mm_fault+0xb34/0xfb0
> [   56.942593]  ? syscall_exit_to_user_mode+0x10/0x220
> [   56.947362]  ? do_syscall_64+0x8e/0x160
> [   56.947974]  ? __count_memcg_events+0x77/0x130
> [   56.952762]  ? count_memcg_events.constprop.0+0x1a/0x30
> [   56.953356]  ? handle_mm_fault+0x1bb/0x2c0
> [   56.953937]  ? do_user_addr_fault+0x55a/0x7b0
> [   56.958999]  ? exc_page_fault+0x7e/0x180
> [   56.959523]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   56.960163] RIP: 0033:0x7fb0f1f7a984
> [   56.960731] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 0=
0 00 00 00 00 f3 0f 1e fa 80 3d c5 06 0e 00 00 7
> 4 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 =
e5 48 83 ec 20 48 89
> [   56.966840] RSP: 002b:00007ffc7db8fde8 EFLAGS: 00000202 ORIG_RAX: 0000=
000000000001
> [   56.971903] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fb0f=
1f7a984
> [   56.976953] RDX: 0000000000000001 RSI: 0000560df4e4ea65 RDI: 000000000=
0000004
> [   56.981946] RBP: 0000000000000004 R08: 0000560e0e417010 R09: 000000000=
0000007
> [   56.986980] R10: 00000000000001b6 R11: 0000000000000202 R12: 7ffffffff=
fffffff
> [   56.991985] R13: 00007fb0f1f7a970 R14: 0000560df4e4ea65 R15: 0000560df=
4e71bd0
> [   56.996963]  </TASK>
> [   56.997533] Disabling lock debugging due to kernel taint
> [   57.037759] zram: Added device: zram0
> [   57.088669] zram: Added device: zram1
> [   57.249105] zram0: detected capacity change from 0 to 6553600
> [   57.320547] zram1: detected capacity change from 0 to 40960000
> [   57.443012] Adding 3276796k swap on /dev/zram0.  Priority:100 extents:=
1 across:3276796k SS
> [   57.470295] Adding 20479996k swap on /dev/zram1.  Priority:0 extents:1=
 across:20479996k SS
>
> Here is the bisect log:
>
> $ git bisect log
> # bad: [684826f8271ad97580b138b9ffd462005e470b99] zram: free secondary al=
gorithms names
> # good: [2cacbdfdee65b18f9952620e762eab043d71b564] mm: swap: add a adapti=
ve full cluster cache reclaim
> git bisect start 'mm-stable' 'HEAD'
> # good: [9bfbaa5e44c52422a046ce291469c8ebeb6c475d] mm/damon: move kunit t=
ests to tests/ subdirectory with _kunit suffix
> git bisect good 9bfbaa5e44c52422a046ce291469c8ebeb6c475d
> # good: [1e673c8cf7f9c1156f615b7c00f224a8110070da] zram: add dictionary s=
upport to lz4hc
> git bisect good 1e673c8cf7f9c1156f615b7c00f224a8110070da
> # good: [3c8e44c9b369b3d422516b3f2bf47a6e3c61d1ea] mm: mark special bits =
for huge pfn mappings when inject
> git bisect good 3c8e44c9b369b3d422516b3f2bf47a6e3c61d1ea
> # good: [f9e54c3a2f5b79ecc57c7bc7d0d3521e461a2101] vfio/pci: implement hu=
ge_fault support
> git bisect good f9e54c3a2f5b79ecc57c7bc7d0d3521e461a2101
> # good: [659c55ef981bb63355a65ffc3b3b5cad562b806a] mm/vma: return the exa=
ct errno in vms_gather_munmap_vmas()
> git bisect good 659c55ef981bb63355a65ffc3b3b5cad562b806a
> # good: [325efb16da2c840e165d9b620fec8049d4d664cc] mm: add nr argument in=
 mem_cgroup_swapin_uncharge_swap() helper to support large folios
> git bisect good 325efb16da2c840e165d9b620fec8049d4d664cc
> # good: [ed8d5b0ce1d738e13c60d6b1a901a56d832e5070] Revert "uprobes: use v=
m_special_mapping close() functionality"
> git bisect good ed8d5b0ce1d738e13c60d6b1a901a56d832e5070
> # good: [2abbcc099ec60844ca7c15214ab12955d3c11e68] uprobes: turn xol_area=
->pages[2] into xol_area->page
> git bisect good 2abbcc099ec60844ca7c15214ab12955d3c11e68
> # first bad commit: [684826f8271ad97580b138b9ffd462005e470b99] zram: free=
 secondary algorithms names
>
> Sergey told me there is a fix on the way:
> https://lore.kernel.org/all/20240923164843.1117010-1-andrej.skvortzov@gma=
il.com/

Confirm the fix in the above thread to fix the kernel oops for me.

Tested-by: Chris Li <chrisl@kernel.org>

Chris


> On Mon, Sep 16, 2024 at 6:30=E2=80=AFPM Sergey Senozhatsky <senozhatsky@c=
hromium.org> wrote:
>>
>> We need to kfree() secondary algorithms names when reset
>> zram device that had multi-streams, otherwise we leak memory.
>>
>> Fixes: 001d92735701 ("zram: add recompression algorithm sysfs knob")
>> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
>> ---
>>  drivers/block/zram/zram_drv.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv=
.c
>> index f8206ba6cbbb..c3d245617083 100644
>> --- a/drivers/block/zram/zram_drv.c
>> +++ b/drivers/block/zram/zram_drv.c
>> @@ -2115,6 +2115,11 @@ static void zram_destroy_comps(struct zram *zram)
>>                 zram->num_active_comps--;
>>         }
>>
>> +       for (prio =3D ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++=
) {
>> +               kfree(zram->comp_algs[prio]);
>> +               zram->comp_algs[prio] =3D NULL;
>> +       }
>> +
>>         zram_comp_params_reset(zram);
>>  }
>>
>> --
>> 2.46.0.662.g92d0881bb0-goog
>>
>>

