Return-Path: <linux-kernel+bounces-184332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5D28CA581
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D8FA1F21778
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 01:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A406FDC;
	Tue, 21 May 2024 01:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYXFWTdQ"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E0A256A
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 01:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716253222; cv=none; b=sHJaoHI5IEkcGXg8NDcyyjHpJhdDeOAAoi3E6mrqxnCPs3aYIoYhUh8+/ihgL8Li4XESyIki0qiZpWj4KmquXQ3bq5OfxapgNF05pKh+WAVh2sb8/VRc55LBd0oI22Waufe6KgFJR2QysqA9y4oNmvAHTj40n2Iyo6my3AkAsBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716253222; c=relaxed/simple;
	bh=QTJSx3nprQM4SUktwn0h9dT+wBS3NclnMMuwsQKiIvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NxrmdiMflio2JrIE5aY+kmE2wZi68MuHtCAEkTsX3O+Ke20KxAqyoEKwvGrV/To+xPNFyY+KYoCl2YWfdx/xUV0uux5+WlO0+/r2Ou/BSIskUTqF+FSifmmdot5cUmW7Ks6zLIaMSFxnWkDfWbdOcB0VIy6E58ajoYbKRR33uAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYXFWTdQ; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e538a264e0so62782251fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 18:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716253219; x=1716858019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0P//xGvIC+2Dt2xliNhzMjIFc4MiP3QnBt8IzE14Mw=;
        b=KYXFWTdQ6J3iHwKAxkrfPsgE4sIQQ+LulrmvWAiTddsIoVPjLpXzMrbuIgYM/t1mxi
         O5jY0n1Ygbf2gdPs9lTdsu+xabD8KNtMGCFKVN6ESr6cQyDUS4kA27WTUdANTNRjSwUu
         R25qQoZufpppQ/bxbcDlzojmMTQTBO5LWHpifIkrHUqfEYpky0lQHl7wYPkkxWJc8L/o
         aBpiED4kgkwgQ7yX9UtAtZ0mAS4PE6dAAA/kBZIPWSP4ZtQt8wJe6LYfpSpmXZK2elIj
         ktXKotZed06nxVbdadPUrUmvCHCKPrGzVsJZw92J9ft6JU0ybcsUvX5p5B2wvN0QeBNX
         wQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716253219; x=1716858019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0P//xGvIC+2Dt2xliNhzMjIFc4MiP3QnBt8IzE14Mw=;
        b=MT2bRjnDRfJjYHBWzJIioyOaldNkXAWATU5lyu6AxernQRor6vb4ELJozHjEoYz87d
         k8ukK8MPyNHVu/9WqyEbCrJ03khMK/qzoSOQ34XF8gg6U2vlOEaJXD08smqtaiEeJlqu
         7/rdJh7IeaF0F+D0wBglo9J9Jbbr27oJ0SlehbLs3V0kQFO/3pTUO6vN5uIG0LN26mXA
         U/hJh5Ft1Vq7MarON0XGR/zsvSl3LHH+C3ZuyHNJ0Np9Q09b4hsKOoBG79IFK1fm3u53
         sBe78iVdAd2oibeEbn+5rfz/h2MNegb+8fTu1Lozdnwl3iQyhxI4f2wxUHgv23lwr7To
         6VnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWhRtgEc49dAdd6WObdFkCSGDKdBJwOiRDd1yzsA3HRLlabyo1JjsI0s1YosCWzyRLPg4fx2DF+Hcqe74yR5Ww4Os2QD47LudEjZkI
X-Gm-Message-State: AOJu0YwzG3elvP1cNyJ48vnbaHmzh1U5fPw6iAbLRoxCMsvROSKx97OY
	gLnYzQt2GRtXAhLmQFnw9pnRQx6TOwQvuRt9QV9tYae7tNiqqYPDVDYXjLNARIOFuWiXZOcloKH
	IcsB55tCx/hOOMtLb9KOGWK552rw=
X-Google-Smtp-Source: AGHT+IEtsUsQA6sPkYbvFuCe5TW2aPcVais2aiTkTehdlxtKSLC1c+JA1+JKDJ3J7A9/7TR7skJbmSahg29Zz0kuz4s=
X-Received: by 2002:a2e:3612:0:b0:2e7:2d1f:edbd with SMTP id
 38308e7fff4ca-2e72d1fee9cmr31081741fa.39.1716253218919; Mon, 20 May 2024
 18:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412064353.133497-1-zhaoyang.huang@unisoc.com>
 <20240412143457.5c6c0ae8f6df0f647d7cf0be@linux-foundation.org>
 <CAGWkznHRyZDuumF=70DncgPHFM0+pgxuONh98Bykz5b-=rCjCQ@mail.gmail.com>
 <ZhxwIh2M8jr6IZaF@dread.disaster.area> <CAGWkznHDpw5Sw5pAfB=TdgRqsf=bmwUQ6+kvvLht3=wumNNo6Q@mail.gmail.com>
 <d9f7c779-acc0-4b8b-993e-e56e9475438e@marcinwanat.pl> <CAGWkznESMXeOhWnK93q1JJxhP0r4wR16cRJxiVzKZmM47GiEWw@mail.gmail.com>
In-Reply-To: <CAGWkznESMXeOhWnK93q1JJxhP0r4wR16cRJxiVzKZmM47GiEWw@mail.gmail.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Tue, 21 May 2024 09:00:07 +0800
Message-ID: <CAGWkznEG78ppUXyoM2HKoo9MCOBJQaW=vSdSKDYXJj6kWH6zjA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: protect xa split stuff under lruvec->lru_lock
 during migration
To: Marcin Wanat <private@marcinwanat.pl>
Cc: Dave Chinner <david@fromorbit.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Alex Shi <alexs@kernel.org>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 8:58=E2=80=AFAM Zhaoyang Huang <huangzhaoyang@gmail=
com> wrote:
>
> On Tue, May 21, 2024 at 3:42=E2=80=AFAM Marcin Wanat <private@marcinwanat=
pl> wrote:
> >
> > On 15.04.2024 03:50, Zhaoyang Huang wrote:
> > > On Mon, Apr 15, 2024 at 8:09=E2=80=AFAM Dave Chinner <david@fromorbit=
com> > wrote: >> >> On Sat, Apr 13, 2024 at 10:01:27AM +0800, Zhaoyang
> > Huang wrote: >>> loop Dave, since he has ever helped set up an
> > reproducer in >>> https://lore.kernel.org/linux- >>>
> > mm/20221101071721.GV2703033@dread.disaster.area/ @Dave Chinner , >>> I
> > would like to ask for your kindly help on if you can verify >>> this
> > patch on your environment if convenient. Thanks a lot. >> >> I don't
> > have the test environment from 18 months ago available any >> more.
> > Also, I haven't seen this problem since that specific test >>
> > environment tripped over the issue. Hence I don't have any way of >>
> > confirming that the problem is fixed, either, because first I'd >> have
> > to reproduce it... > Thanks for the information. I noticed that you
> > reported another soft > lockup which is related to xas_load since
> > NOV.2023. This patch is > supposed to be helpful for this. With regard
> > to the version timing, > this commit is actually a revert of <mm/thp:
> > narrow lru locking> > b6769834aac1d467fa1c71277d15688efcbb4d76 which is
> > merged before > v5.15. > > For saving your time, a brief description
> > below. IMO, b6769834aa > introduce a potential stall between freeze the
> > folio's refcnt and > store it back to 2, which have the
> > xas_load->folio_try_get_rcu loops > as livelock if it stalls the
> > lru_lock's holder. > > b6769834aa split_huge_page_to_list -
> > spin_lock(lru_lock) > xas_split(&xas, folio,order)
> > folio_refcnt_freeze(folio, 1 + > folio_nr_pages(folio0) +
> > spin_lock(lru_lock) xas_store(&xas, > offset++, head+i)
> > page_ref_add(head, 2) spin_unlock(lru_lock) > > Sorry in advance if the
> > above doesn't make sense, I am just a > developer who is also suffering
> > from this bug and trying to fix it
> > I am experiencing a similar error on dozens of hosts, with stack traces
> > that are all similar:
> >
> > [627163.727746] watchdog: BUG: soft lockup - CPU#77 stuck for 22s!
> > [file_get:953301]
> > [627163.727778] Modules linked in: xt_set ip_set_hash_net ip_set xt_CT
> > xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_compat
> > nf_tables nfnetlink sr_mod cdrom rfkill vfat fat intel_rapl_msr
> > intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common
> > isst_if_common skx_edac nfit libnvdimm x86_pkg_temp_thermal
> > intel_powerclamp coretemp ipmi_ssif kvm_intel kvm irqbypass mlx5_ib rap=
l
> > iTCO_wdt intel_cstate intel_pmc_bxt ib_uverbs iTCO_vendor_support
> > dell_smbios dcdbas i2c_i801 intel_uncore uas ses mei_me ib_core
> > dell_wmi_descriptor wmi_bmof pcspkr enclosure lpc_ich usb_storage
> > i2c_smbus acpi_ipmi mei intel_pch_thermal ipmi_si ipmi_devintf
> > ipmi_msghandler acpi_power_meter joydev tcp_bbr fuse xfs libcrc32c raid=
1
> > sd_mod sg mlx5_core crct10dif_pclmul crc32_pclmul crc32c_intel
> > polyval_clmulni mgag200 polyval_generic drm_kms_helper mlxfw
> > drm_shmem_helper ahci nvme mpt3sas tls libahci ghash_clmulni_intel
> > nvme_core psample drm igb t10_pi raid_class pci_hyperv_intf dca libata
> > scsi_transport_sas i2c_algo_bit wmi
> > [627163.727841] CPU: 77 PID: 953301 Comm: file_get Kdump: loaded
> > Tainted: G             L     6.6.30.el9 #2
> > [627163.727844] Hardware name: Dell Inc. PowerEdge R740xd/08D89F, BIOS
> > 2.21.2 02/19/2024
> > [627163.727847] RIP: 0010:xas_descend+0x1b/0x70
> > [627163.727857] Code: 57 10 48 89 07 48 c1 e8 20 48 89 57 08 c3 cc 0f b=
6
> > 0e 48 8b 47 08 48 d3 e8 48 89 c1 83 e1 3f 89 c8 48 83 c0 04 48 8b 44 c6
> > 08 <48> 89 77 18 48 89 c2 83 e2 03 48 83 fa 02 74 0a 88 4f 12 c3 48 83
> > [627163.727859] RSP: 0018:ffffc90034a67978 EFLAGS: 00000206
> > [627163.727861] RAX: ffff888e4f971242 RBX: ffffc90034a67a98 RCX:
> > 0000000000000020
> > [627163.727863] RDX: 0000000000000002 RSI: ffff88a454546d80 RDI:
> > ffffc90034a67990
> > [627163.727865] RBP: fffffffffffffffe R08: fffffffffffffffe R09:
> > 0000000000008820
> > [627163.727867] R10: 0000000000008820 R11: 0000000000000000 R12:
> > ffffc90034a67a20
> > [627163.727868] R13: ffffc90034a67a18 R14: ffffea00873e8000 R15:
> > ffffc90034a67a18
> > [627163.727870] FS:  00007fc5e503b740(0000) GS:ffff88bfefd80000(0000)
> > knlGS:0000000000000000
> > [627163.727871] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [627163.727873] CR2: 000000005fb87b6e CR3: 00000022875e8006 CR4:
> > 00000000007706e0
> > [627163.727875] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > 0000000000000000
> > [627163.727876] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> > 0000000000000400
> > [627163.727878] PKRU: 55555554
> > [627163.727879] Call Trace:
> > [627163.727882]  <IRQ>
> > [627163.727886]  ? watchdog_timer_fn+0x22a/0x2a0
> > [627163.727892]  ? softlockup_fn+0x70/0x70
> > [627163.727895]  ? __hrtimer_run_queues+0x10f/0x2a0
> > [627163.727903]  ? hrtimer_interrupt+0x106/0x240
> > [627163.727906]  ? __sysvec_apic_timer_interrupt+0x68/0x170
> > [627163.727913]  ? sysvec_apic_timer_interrupt+0x9d/0xd0
> > [627163.727917]  </IRQ>
> > [627163.727918]  <TASK>
> > [627163.727920]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> > [627163.727927]  ? xas_descend+0x1b/0x70
> > [627163.727930]  xas_load+0x2c/0x40
> > [627163.727933]  xas_find+0x161/0x1a0
> > [627163.727937]  find_get_entries+0x77/0x1d0
> > [627163.727944]  truncate_inode_pages_range+0x244/0x3f0
> > [627163.727950]  truncate_pagecache+0x44/0x60
> > [627163.727955]  xfs_setattr_size+0x168/0x490 [xfs]
> > [627163.728074]  xfs_vn_setattr+0x78/0x140 [xfs]
> > [627163.728153]  notify_change+0x34f/0x4f0
> > [627163.728158]  ? _raw_spin_lock+0x13/0x30
> > [627163.728165]  ? do_truncate+0x80/0xd0
> > [627163.728169]  do_truncate+0x80/0xd0
> > [627163.728172]  do_open+0x2ce/0x400
> > [627163.728177]  path_openat+0x10d/0x280
> > [627163.728181]  do_filp_open+0xb2/0x150
> > [627163.728186]  ? check_heap_object+0x34/0x190
> > [627163.728189]  ? __check_object_size.part.0+0x5a/0x130
> > [627163.728194]  do_sys_openat2+0x92/0xc0
> > [627163.728197]  __x64_sys_openat+0x53/0x90
> > [627163.728200]  do_syscall_64+0x35/0x80
> > [627163.728206]  entry_SYSCALL_64_after_hwframe+0x4b/0xb5
> > [627163.728210] RIP: 0033:0x7fc5e493e7fb
> > [627163.728213] Code: 25 00 00 41 00 3d 00 00 41 00 74 4b 64 8b 04 25 1=
8
> > 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f
> > 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 54 24 28 64 48 2b 14 25
> > [627163.728215] RSP: 002b:00007ffdd4e300e0 EFLAGS: 00000246 ORIG_RAX:
> > 0000000000000101
> > [627163.728218] RAX: ffffffffffffffda RBX: 00007ffdd4e30180 RCX:
> > 00007fc5e493e7fb
> > [627163.728220] RDX: 0000000000000241 RSI: 00007ffdd4e30180 RDI:
> > 00000000ffffff9c
> > [627163.728221] RBP: 00007ffdd4e30180 R08: 00007fc5e4600040 R09:
> > 0000000000000001
> > [627163.728223] R10: 00000000000001b6 R11: 0000000000000246 R12:
> > 0000000000000241
> > [627163.728224] R13: 0000000000000000 R14: 00007fc5e4662fa8 R15:
> > 0000000000000000
> > [627163.728227]  </TASK>
> >
> > I have around 50 hosts handling high I/O (each with 20Gbps+ uplinks
> > and multiple NVMe drives), running RockyLinux 8/9. The stock RHEL
> > kernel 8/9 is NOT affected, and the long-term kernel 5.15.X is NOT affe=
cted.
> > However, with long-term kernels 6.1.XX and 6.6.XX,
> > (tested at least 10 different versions), this lockup always appears
> > after 2-30 days, similar to the report in the original thread.
> > The more load (for example, copying a lot of local files while
> > serving 20Gbps traffic), the higher the chance that the bug will appear=
.
> >
> > I haven't been able to reproduce this during synthetic tests,
> > but it always occurs in production on 6.1.X and 6.6.X within 2-30 days.
> > If anyone can provide a patch, I can test it on multiple machines
> > over the next few days.
> Could you please try this one which could be applied on 6.6 directly. Tha=
nk you!
URL: https://lore.kernel.org/linux-mm/20240412064353.133497-1-zhaoyang.huan=
g@unisoc.com/

> >
> > Regards,
> > Marcin

