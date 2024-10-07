Return-Path: <linux-kernel+bounces-354053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C6C9936F5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 21:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B358284B0E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BBF1DE2AD;
	Mon,  7 Oct 2024 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lr6iUxXh"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E6822098
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728327980; cv=none; b=P2Mc2HGVtAucoaSpLG6iEh/aBlbdh3au6RiqQb1fG46agIN1KlmBnovgzJ3Bw7N7xfnSIHePyAdCl1mCVCUFfBL3pEl3gJTbSv0a63+848OIN68bjHActeQo4pjVINiuul9TnyWN4RcIGsYjrt0eSSrFWZ9izXCop/71mxmybs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728327980; c=relaxed/simple;
	bh=kTxUPmAhEvlVAuLu6NEbgSwJ8s/ES9QwfodmjNnIzq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/JvDtG2Nq0Jdz3uzOrkNojdNCLspBrghFHsJ2xyMEFQfWlnCMvVX4p3VZvlOGeND+Pe5mEKPKuKqcuU6u4twoI4SgFEKt/Jog1WBfvsgkrnWKk7tPXoDyff9A7vPqhIhj4wj4zW2ngMfs9zirgXXjgVK0WNPQhRMnOr04Ezvjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lr6iUxXh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cae4ead5bso43555e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 12:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728327977; x=1728932777; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I7BLvl0BaDY7z+QL2+srsvtgfwui19rmMhSzbH1HlsY=;
        b=lr6iUxXhQ8jAX4nCom1lwJQ1nd3evA+8om92TMMgc5Sx8whNwFlvl0vmLVbQceXjG5
         tkfci3MltXZNEq+PSglnThZkkxZrXIU1a31frX9caIfDptlOYl76rsRs/QK/IgAHenEh
         IXHthSQ1ORG//iRgmA4riPPE7pXPcRC1oJhOxnGikR2ZrDy9VByK18CQ/ueglXOXUDCs
         XVbral3nmOSR9NrXYyb+rY0AeJY9a/mYZyNu1mrBhqZ9JWeblXHOF/SO+Z5mL9+dPA92
         qhh5oB05kb/4jmvgukyUxjIBZc+Omvlya8bQRVAs7qkYeqXR/ZokmDaXlVkCM+g9CQuP
         aa8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728327977; x=1728932777;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I7BLvl0BaDY7z+QL2+srsvtgfwui19rmMhSzbH1HlsY=;
        b=nCcwAMl+51jotxg3sGzKibj4xme3BYRn2RowKPYbwu8p25Kmxc/h+bSBZOBYYh5P2a
         tFfK6CJb+U0hrvF6tcGNpPkk9iaGT8RJGYawwleVG7QDxWHor1k3HFcZFzY+2PshJmdk
         46DHJ9XTk/voFkFo88hmdlt2uF3iJ3snj2redLoxM1bTASOj3qPD8PgM1yNAK8psHvKv
         tWNVvc3b6ys9F8Wf89CAnAXOyPYc5ss2R4j8GQtgu1d9ct2WfY6ln58XtcI8CTzzwJAS
         o5pYzyD+0iKP9CzmeIueDLddp75iqHLgcrcbRF0QsPwYfW8xJ2ihrPRUv8hKHJ1kvjsy
         sBuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNGyW5oh44qKE5pg+/KT0v5bLxwp31GsPciNnVeXf46yZ/v1GgPWCfzBpL981AuMvxCfC3W8MSbFPxbnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJTA3udkS/s5nkbokojWuB82p/mEFs7KLF0XBxVq2hsAu0tQlA
	Cnsmt0vYxanVNOa2rUB994PIbMEDZOHvw7u/hmsnUOTIWDQCt1Ro+Fd6vleHuqLnNGCfFYiUkpI
	gYl/1DsqOdtA+sIW78PMjFHhoBh1tqHjN/1S5
X-Google-Smtp-Source: AGHT+IF49es84bRQQNTCR1vFcCt9syxS59M7zoUaxBvAPNfJAs/dVUrrUYG50atB7jL+UCVUp3qO8M26JojM+ctc5cQ=
X-Received: by 2002:a05:600c:3d15:b0:426:6edd:61a7 with SMTP id
 5b1f17b1804b1-42fda96d727mr517735e9.7.1728327976095; Mon, 07 Oct 2024
 12:06:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830040101.822209-1-Liam.Howlett@oracle.com> <20240830040101.822209-15-Liam.Howlett@oracle.com>
In-Reply-To: <20240830040101.822209-15-Liam.Howlett@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 7 Oct 2024 21:05:38 +0200
Message-ID: <CAG48ez0ZpGzxi=-5O_uGQ0xKXOmbjeQ0LjZsRJ1Qtf2X5eOr1w@mail.gmail.com>
Subject: [BUG] page table UAF, Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma
 tree in mmap_region()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Linux-MM <linux-mm@kvack.org>, 
	kernel list <linux-kernel@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Jeff Xu <jeffxu@chromium.org>, 
	Seth Jenkins <sethjenkins@google.com>
Content-Type: multipart/mixed; boundary="00000000000012ed3a0623e7b755"

--00000000000012ed3a0623e7b755
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 6:00=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
> Instead of zeroing the vma tree and then overwriting the area, let the
> area be overwritten and then clean up the gathered vmas using
> vms_complete_munmap_vmas().
>
> To ensure locking is downgraded correctly, the mm is set regardless of
> MAP_FIXED or not (NULL vma).
>
> If a driver is mapping over an existing vma, then clear the ptes before
> the call_mmap() invocation.  This is done using the vms_clean_up_area()
> helper.  If there is a close vm_ops, that must also be called to ensure
> any cleanup is done before mapping over the area.  This also means that
> calling open has been added to the abort of an unmap operation, for now.

As currently implemented, this is not a valid optimization because it
violates the (unwritten?) rule that you must not call free_pgd_range()
on a region in the page tables which can concurrently be walked. A
region in the page tables can be concurrently walked if it overlaps a
VMA which is linked into rmaps which are not write-locked.

On Linux 6.12-rc2, when you mmap(MAP_FIXED) over an existing VMA, and
the new mapping is created by expanding an adjacent VMA, the following
race with an ftruncate() is possible (because page tables for the old
mapping are removed while the new VMA in the same location is already
fully set up and linked into the rmap):


task 1 (mmap, MAP_FIXED)     task 2 (ftruncate)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
mmap_region
  vma_merge_new_range
    vma_expand
      commit_merge
        vma_prepare
          [take rmap locks]
        vma_set_range
          [expand adjacent mapping]
        vma_complete
          [drop rmap locks]
  vms_complete_munmap_vmas
    vms_clear_ptes
      unmap_vmas
        [removes ptes]
      free_pgtables
        [unlinks old vma from rmap]
                             unmap_mapping_range
                               unmap_mapping_pages
                                 i_mmap_lock_read
                                 unmap_mapping_range_tree
                                   [loop]
                                     unmap_mapping_range_vma
                                       zap_page_range_single
                                         unmap_single_vma
                                           unmap_page_range
                                             zap_p4d_range
                                               zap_pud_range
                                                 zap_pmd_range
                                                   [looks up pmd entry]
        free_pgd_range
          [frees pmd]
                                                   [UAF pmd entry access]

To reproduce this, apply the attached mmap-vs-truncate-racewiden.diff
to widen the race windows, then build and run the attached reproducer
mmap-fixed-race.c.

Under a kernel with KASAN, you should ideally get a KASAN splat like this:

[   90.012655][ T1113]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   90.013937][ T1113] BUG: KASAN: use-after-free in
unmap_page_range+0x2d4e/0x3a80
[   90.015136][ T1113] Read of size 8 at addr ffff888006a3b000 by task
SLOWME2/1113
[   90.016322][ T1113]
[   90.016695][ T1113] CPU: 12 UID: 1000 PID: 1113 Comm: SLOWME2
Tainted: G        W          6.12.0-rc2-dirty #500
[   90.018355][ T1113] Tainted: [W]=3DWARN
[   90.018959][ T1113] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   90.020598][ T1113] Call Trace:
[   90.021126][ T1113]  <TASK>
[   90.021590][ T1113]  dump_stack_lvl+0x53/0x70
[   90.022307][ T1113]  print_report+0xce/0x670
[   90.023008][ T1113]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[   90.023942][ T1113]  ? unmap_page_range+0x2d4e/0x3a80
[   90.024763][ T1113]  kasan_report+0xe2/0x120
[   90.025468][ T1113]  ? unmap_page_range+0x2d4e/0x3a80
[   90.026293][ T1113]  unmap_page_range+0x2d4e/0x3a80
[   90.027087][ T1113]  ? srso_return_thunk+0x5/0x5f
[   90.027855][ T1113]  ? next_uptodate_folio+0x148/0x890
[   90.029299][ T1113]  ? set_pte_range+0x265/0x6c0
[   90.030058][ T1113]  ? srso_return_thunk+0x5/0x5f
[   90.030826][ T1113]  ? page_table_check_set.part.0+0x2ab/0x3e0
[   90.031773][ T1113]  ? __pfx_unmap_page_range+0x10/0x10
[   90.032622][ T1113]  ? srso_return_thunk+0x5/0x5f
[   90.033394][ T1113]  ? unmap_single_vma+0xc6/0x2c0
[   90.034211][ T1113]  zap_page_range_single+0x28a/0x4b0
[   90.035052][ T1113]  ? srso_return_thunk+0x5/0x5f
[   90.035821][ T1113]  ? __pfx_zap_page_range_single+0x10/0x10
[   90.036739][ T1113]  ? __pte_offset_map+0x1d/0x250
[   90.037528][ T1113]  ? srso_return_thunk+0x5/0x5f
[   90.038295][ T1113]  ? do_fault+0x6c4/0x1270
[   90.038999][ T1113]  ? __pfx___handle_mm_fault+0x10/0x10
[   90.039862][ T1113]  unmap_mapping_range+0x1b2/0x240
[   90.040671][ T1113]  ? __pfx_unmap_mapping_range+0x10/0x10
[   90.041563][ T1113]  ? setattr_prepare+0xed/0x7e0
[   90.042330][ T1113]  ? srso_return_thunk+0x5/0x5f
[   90.043097][ T1113]  ? current_time+0x88/0x200
[   90.043826][ T1113]  shmem_setattr+0x880/0xea0
[   90.044556][ T1113]  notify_change+0x42b/0xea0
[   90.045913][ T1113]  ? do_truncate+0x10b/0x1b0
[   90.046641][ T1113]  ? srso_return_thunk+0x5/0x5f
[   90.047407][ T1113]  do_truncate+0x10b/0x1b0
[   90.048107][ T1113]  ? __pfx_do_truncate+0x10/0x10
[   90.048890][ T1113]  ? __set_task_comm+0x53/0x140
[   90.049668][ T1113]  ? srso_return_thunk+0x5/0x5f
[   90.050472][ T1113]  ? __do_sys_prctl+0x71e/0x11f0
[   90.051262][ T1113]  do_ftruncate+0x334/0x470
[   90.051976][ T1113]  ? srso_return_thunk+0x5/0x5f
[   90.052745][ T1113]  do_sys_ftruncate+0x3d/0x80
[   90.053493][ T1113]  do_syscall_64+0x4b/0x110
[   90.054209][ T1113]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   90.055142][ T1113] RIP: 0033:0x7f89cbf2bf47
[   90.055844][ T1113] Code: 77 01 c3 48 8b 15 b9 1e 0d 00 f7 d8 64 89
02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 b8 4d
00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 89 1e 0d 00 f7 d8
64 89 02 b8
[   90.058924][ T1113] RSP: 002b:00007fff96968aa8 EFLAGS: 00000213
ORIG_RAX: 000000000000004d
[   90.060248][ T1113] RAX: ffffffffffffffda RBX: 00007fff96968c28
RCX: 00007f89cbf2bf47
[   90.061507][ T1113] RDX: 0000000000000000 RSI: 0000000000001000
RDI: 0000000000000003
[   90.063471][ T1113] RBP: 00007fff96968b10 R08: 0000000000000000
R09: 00007f89cbe29740
[   90.064727][ T1113] R10: 00007f89cbefb443 R11: 0000000000000213
R12: 0000000000000000
[   90.065990][ T1113] R13: 00007fff96968c38 R14: 000055ce5a58add8
R15: 00007f89cc05f020
[   90.067291][ T1113]  </TASK>
[   90.067772][ T1113]
[   90.068147][ T1113] The buggy address belongs to the physical page:
[   90.069168][ T1113] page: refcount:0 mapcount:0
mapping:0000000000000000 index:0xffff888006a3bf50 pfn:0x6a3b
[   90.070741][ T1113] flags: 0x100000000000000(node=3D0|zone=3D1)
[   90.071649][ T1113] raw: 0100000000000000 ffffea0000111748
ffffea000020c488 0000000000000000
[   90.073009][ T1113] raw: ffff888006a3bf50 0000000000000000
00000000ffffffff 0000000000000000
[   90.074368][ T1113] page dumped because: kasan: bad access detected
[   90.075382][ T1113]
[   90.075751][ T1113] Memory state around the buggy address:
[   90.076636][ T1113]  ffff888006a3af00: 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00
[   90.077905][ T1113]  ffff888006a3af80: 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00
[   90.079874][ T1113] >ffff888006a3b000: ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff
[   90.081173][ T1113]                    ^
[   90.081821][ T1113]  ffff888006a3b080: ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff
[   90.083134][ T1113]  ffff888006a3b100: ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff
[   90.084416][ T1113]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--00000000000012ed3a0623e7b755
Content-Type: text/x-patch; charset="US-ASCII"; name="mmap-vs-truncate-racewiden.diff"
Content-Disposition: attachment; filename="mmap-vs-truncate-racewiden.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_m1zdnw6s0>
X-Attachment-Id: f_m1zdnw6s0

ZGlmZiAtLWdpdCBhL21tL21lbW9yeS5jIGIvbW0vbWVtb3J5LmMKaW5kZXggMjM2NjU3ODAxNWFk
Li5iOTVhNDMyMjEwNTggMTAwNjQ0Ci0tLSBhL21tL21lbW9yeS5jCisrKyBiL21tL21lbW9yeS5j
CkBAIC03OCw2ICs3OCw3IEBACiAjaW5jbHVkZSA8bGludXgvcHRyYWNlLmg+CiAjaW5jbHVkZSA8
bGludXgvdm1hbGxvYy5oPgogI2luY2x1ZGUgPGxpbnV4L3NjaGVkL3N5c2N0bC5oPgorI2luY2x1
ZGUgPGxpbnV4L2RlbGF5Lmg+CiAKICNpbmNsdWRlIDx0cmFjZS9ldmVudHMva21lbS5oPgogCkBA
IC00MTAsNiArNDExLDEzIEBAIHZvaWQgZnJlZV9wZ3RhYmxlcyhzdHJ1Y3QgbW11X2dhdGhlciAq
dGxiLCBzdHJ1Y3QgbWFfc3RhdGUgKm1hcywKIAkJCQl1bmxpbmtfZmlsZV92bWFfYmF0Y2hfYWRk
KCZ2Yiwgdm1hKTsKIAkJCX0KIAkJCXVubGlua19maWxlX3ZtYV9iYXRjaF9maW5hbCgmdmIpOwor
CisJCQlpZiAoc3RyY21wKGN1cnJlbnQtPmNvbW0sICJTTE9XTUUxIikgPT0gMCkgeworCQkJCXBy
X3dhcm4oIiVzOiBzdGFydGluZyBkZWxheVxuIiwgX19mdW5jX18pOworCQkJCW1kZWxheSgyMDAw
KTsKKwkJCQlwcl93YXJuKCIlczogZW5kaW5nIGRlbGF5XG4iLCBfX2Z1bmNfXyk7CisJCQl9CisK
IAkJCWZyZWVfcGdkX3JhbmdlKHRsYiwgYWRkciwgdm1hLT52bV9lbmQsCiAJCQkJZmxvb3IsIG5l
eHQgPyBuZXh0LT52bV9zdGFydCA6IGNlaWxpbmcpOwogCQl9CkBAIC0xNzExLDYgKzE3MTksMTMg
QEAgc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIHphcF9wbWRfcmFuZ2Uoc3RydWN0IG1tdV9n
YXRoZXIgKnRsYiwKIAl1bnNpZ25lZCBsb25nIG5leHQ7CiAKIAlwbWQgPSBwbWRfb2Zmc2V0KHB1
ZCwgYWRkcik7CisKKwlpZiAoc3RyY21wKGN1cnJlbnQtPmNvbW0sICJTTE9XTUUyIikgPT0gMCkg
eworCQlwcl93YXJuKCIlczogc3RhcnRpbmcgZGVsYXlcbiIsIF9fZnVuY19fKTsKKwkJbWRlbGF5
KDIwMDApOworCQlwcl93YXJuKCIlczogZW5kaW5nIGRlbGF5XG4iLCBfX2Z1bmNfXyk7CisJfQor
CiAJZG8gewogCQluZXh0ID0gcG1kX2FkZHJfZW5kKGFkZHIsIGVuZCk7CiAJCWlmIChpc19zd2Fw
X3BtZCgqcG1kKSB8fCBwbWRfdHJhbnNfaHVnZSgqcG1kKSB8fCBwbWRfZGV2bWFwKCpwbWQpKSB7
Cg==
--00000000000012ed3a0623e7b755
Content-Type: text/x-csrc; charset="US-ASCII"; name="mmap-fixed-race.c"
Content-Disposition: attachment; filename="mmap-fixed-race.c"
Content-Transfer-Encoding: base64
Content-ID: <f_m1zdp2qv1>
X-Attachment-Id: f_m1zdp2qv1

I2RlZmluZSBfR05VX1NPVVJDRQojaW5jbHVkZSA8ZXJyLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4K
I2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxzeXMvcHJj
dGwuaD4KI2luY2x1ZGUgPHN5cy93YWl0Lmg+CiNpbmNsdWRlIDxzeXMvbW1hbi5oPgoKI2RlZmlu
ZSBTWVNDSEsoeCkgKHsgICAgICAgICAgXAogIHR5cGVvZih4KSBfX3JlcyA9ICh4KTsgICAgICBc
CiAgaWYgKF9fcmVzID09ICh0eXBlb2YoeCkpLTEpIFwKICAgIGVycigxLCAiU1lTQ0hLKCIgI3gg
IikiKTsgXAogIF9fcmVzOyAgICAgICAgICAgICAgICAgICAgICBcCn0pCgppbnQgbWFpbih2b2lk
KSB7CiAgaW50IGZkID0gU1lTQ0hLKG1lbWZkX2NyZWF0ZSgiZm9vIiwgMCkpOwogIFNZU0NISyhm
dHJ1bmNhdGUoZmQsIDB4MjAwMCkpOwogIGNoYXIgKm1hcDEgPSBTWVNDSEsobW1hcCgodm9pZCop
KDB4NDAwMDAwMDAtMHgxMDAwKSwgMHgyMDAwLCBQUk9UX1JFQUR8UFJPVF9XUklURSwgTUFQX1NI
QVJFRHxNQVBfRklYRURfTk9SRVBMQUNFLCBmZCwgMCkpOwogICgodm9sYXRpbGUgY2hhciAqKW1h
cDEpWzBdID0gJ0EnOwogICgodm9sYXRpbGUgY2hhciAqKW1hcDEpWzB4MTAwMF0gPSAnQic7Cgog
IGNoYXIgKm1hcDIgPSBtYXAxICsgMHgxMDAwOwogIFNZU0NISyhtbWFwKG1hcDIsIDB4MTAwMCwg
UFJPVF9SRUFELCBNQVBfU0hBUkVEfE1BUF9GSVhFRCwgZmQsIDApKTsKICAoKHZvbGF0aWxlIGNo
YXIgKiltYXAyKVswXTsKICAvL1NZU0NISyhtcHJvdGVjdChtYXAyLCAweDEwMDAsIFBST1RfUkVB
RCkpOwoKICAvKgogIGludCBwaXBlZmRzWzJdOwogIFNZU0NISyhwaXBlKHBpcGVmZHMpKTsKICAq
LwoKICBpZiAoU1lTQ0hLKGZvcmsoKSkgPT0gMCkgewogICAgU1lTQ0hLKG11bm1hcChtYXAxLCAw
eDIwMDApKTsKICAgIHNsZWVwKDEpOwogICAgU1lTQ0hLKHByY3RsKFBSX1NFVF9OQU1FLCAiU0xP
V01FMiIpKTsKICAgIFNZU0NISyhmdHJ1bmNhdGUoZmQsIDB4MTAwMCkpOyAvLyBybWFwIHdhbGsK
ICAgIFNZU0NISyhwcmN0bChQUl9TRVRfTkFNRSwgInRhc2syIikpOwogICAgZXhpdCgwKTsKICB9
CgogIC8vc3lzdGVtKCJjYXQgL3Byb2MvJFBQSUQvbWFwcyIpOwogIFNZU0NISyhwcmN0bChQUl9T
RVRfTkFNRSwgIlNMT1dNRTEiKSk7CiAgU1lTQ0hLKG1tYXAobWFwMiwgMHgxMDAwLCBQUk9UX1JF
QUR8UFJPVF9XUklURSwgTUFQX1NIQVJFRHxNQVBfRklYRUQsIGZkLCAweDEwMDApKTsKICBTWVND
SEsocHJjdGwoUFJfU0VUX05BTUUsICJ0YXNrMSIpKTsKICAvL3N5c3RlbSgiY2F0IC9wcm9jLyRQ
UElEL21hcHMiKTsKCiAgLyoKICBmb3IgKGludCBpPTA7IGk8ODsgaSsrKSB7CiAgICBjaGFyIGJ1
ZlsweDEwMDBdOwogICAgbWVtc2V0KGJ1ZiwgJ0EnLCAweDEwMDApOwogICAgU1lTQ0hLKHdyaXRl
KHBpcGVmZHNbMV0sIGJ1ZiwgMHgxMDAwKSk7CiAgfQogICovCgogIGludCB3c3RhdHVzOwogIFNZ
U0NISyh3YWl0KCZ3c3RhdHVzKSk7CiAgcmV0dXJuIDA7Cn0K
--00000000000012ed3a0623e7b755--

