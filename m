Return-Path: <linux-kernel+bounces-327857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFEC977BF7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C44D2823E9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6171D6C57;
	Fri, 13 Sep 2024 09:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scm.com header.i=@scm.com header.b="a+j+S3e5"
Received: from ext6.scm.com (ext6.scm.com [5.9.60.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0CF1D6C7A
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.9.60.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726218705; cv=none; b=gpoHDzWOI0tKuAZSLiV0qE/yk0hrNYNE6+MIWVLVzYhJdmH6qwstvZxO5nZmWnpcJTLc3ze+VjtzMkZq+qf3Y/PT8eHaov+JshJfTzP409RFqyu81uUoj82wlyuJQmXZ2MPwSdtBEYOgcA1rOFE2VPd0dw5Y6KXP+bft5GKG39w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726218705; c=relaxed/simple;
	bh=GOa3Kj3gLzKZ/yXb9Z9IYGE0Ic6VQawIiBfsPuEh6HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=TMXTMGVxVllqhaYlswsIcSF3DETyZQ7qr+dFXxA4Kdl6PQMJtpv9lvGm5JTMRcnrT1tBQ6IFmvOk3MMg5Tj566jOZ4ZQSHBaydh3+XhcvodpCY+sdhnnJCcAscwyLiu8Ps6VxhRybjPog/pJNvbsd2ZvcHgzHmHGsIa5efmI4g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scm.com; spf=pass smtp.mailfrom=scm.com; dkim=pass (2048-bit key) header.d=scm.com header.i=@scm.com header.b=a+j+S3e5; arc=none smtp.client-ip=5.9.60.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scm.com
Received: from electra.localnet (unknown [95.85.255.24])
	by ext6.scm.com (Postfix) with ESMTPSA id 1EF807E807CD;
	Fri, 13 Sep 2024 11:03:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=scm.com;
	s=dkim20220819; t=1726218213;
	bh=GOa3Kj3gLzKZ/yXb9Z9IYGE0Ic6VQawIiBfsPuEh6HA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:From;
	b=a+j+S3e59q5Q6fhruuDU9NhfnXbKGiMcMUGTp7qczyaqCAjwOsm6fBC9SBVd/3lH4
	 AaI6GMyvJV9a/CKczi5rgHJulEkk4k2zWhxfO+LcMadbsWHNstQ+/KfKOqdyqZq+5e
	 Tny95dlWQWQ60qxMu65YyoCbv6+DkE1HvOpnCR1z+nwCUitHvv2cRCENHyYANQ0iLt
	 9hHqjcqF3nyu2Z1N+7zXixNB5F7iOSTsTQZFVcjCyiavDrRGlL5ZWRmeByaRbX5UEP
	 Td0LhHq2bPoZSl3vGQoulTWyxNr27R6XcDJ4liz9q/qTrpLm9qa0YxOFyN03Ct26AQ
	 xPcEn2g9KH6mQ==
From: =?UTF-8?B?VG9tw6HFoQ==?= Trnka <trnka@scm.com>
To: yosryahmed@google.com
Cc: hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 nphamcs@gmail.com, pedro.falcato@gmail.com, piotr.oniszczuk@gmail.com,
 regressions@lists.linux.dev, willy@infradead.org
Subject:
 Re: [regression] oops on heavy compilations ("kernel BUG at mm/zswap.c:1005!"
 and "Oops: invalid opcode: 0000")
Date: Fri, 13 Sep 2024 11:03:18 +0200
Message-ID: <2272920.vFx2qVVIhK@electra>
In-Reply-To:
 <CAJD7tkaTcnuCFW+dWTzSAuLKBqkkGv9s5uByYm9DaJC=Cp-Xqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

> Well, it's possible that some zswap change was not fully compatible
> with z3fold, or surfaced a dormant bug in z3fold. Either way, my
> recommendation is to use zsmalloc. I have been trying to deprecate
> z3fold, and honestly you are the only person I have seen use z3fold in
> a while -- which is probably why no one else reported such a problem.

=46WIW, I have repeatedly hit this exact BUG (mm/zswap.c:1005) on two of my=
=20
machines on 6.10.x (possibly 6.9.x as well, but I don't have the logs at ha=
nd=20
to confirm). In both cases, this was also using z3fold under moderate memor=
y=20
pressure. I think this fairly conclusively rules out a HW issue.

Additionally, I have hit the following BUG on 6.10.8, which is potentially=
=20
related (note __z3fold_alloc in there):

list_del corruption, ffff977c17128000->next is NULL
=2D-----------[ cut here ]------------
kernel BUG at lib/list_debug.c:52!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
CPU: 3 PID: 248608 Comm: kworker/u32:3 Tainted: G        W         =20
6.10.8-100.fc39.x86_64 #1
Hardware name: HP HP EliteBook 850 G6/8549, BIOS R70 Ver. 01.28.00 04/12/20=
24
Workqueue: zswap12 compact_page_work
RIP: 0010:__list_del_entry_valid_or_report+0x5d/0xc0
Code: 48 8b 01 48 39 f8 75 5a 48 8b 72 08 48 39 f0 75 65 b8 01 00 00 00 c3 =
cc=20
cc cc cc 48 89 fe 48 c7 c7 f0 89 ba ad e8 73 34 8f ff <0f> 0b 48 89 fe 48 c=
7=20
c7 20 8a ba ad e8 62 34 8f ff 0f 0b 48 89 fe
RSP: 0018:ffffac7299f5bdb0 EFLAGS: 00010246
RAX: 0000000000000033 RBX: ffff977c0afd0b08 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff977f2d5a18c0 RDI: ffff977f2d5a18c0
RBP: ffff977c0afd0b00 R08: 0000000000000000 R09: 4e20736920747865
R10: 7478656e3e2d3030 R11: 4c4c554e20736920 R12: ffff977c17128010
R13: 000000000000000a R14: 00000000000000a0 R15: ffff977c17128000
=46S:  0000000000000000(0000) GS:ffff977f2d580000(0000) knlGS:0000000000000=
000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f063638a000 CR3: 0000000179428002 CR4: 00000000003706f0
Call Trace:
 <TASK>
 ? die+0x36/0x90
 ? do_trap+0xdd/0x100
 ? __list_del_entry_valid_or_report+0x5d/0xc0
 ? do_error_trap+0x6a/0x90
 ? __list_del_entry_valid_or_report+0x5d/0xc0
 ? exc_invalid_op+0x50/0x70
 ? __list_del_entry_valid_or_report+0x5d/0xc0
 ? asm_exc_invalid_op+0x1a/0x20
 ? __list_del_entry_valid_or_report+0x5d/0xc0
 __z3fold_alloc+0x4e/0x4b0
 do_compact_page+0x20e/0xa60
 process_one_work+0x17b/0x390
 worker_thread+0x265/0x380
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xcf/0x100
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x31/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Modules linked in: nf_conntrack_netbios_ns nf_conntrack_broadcast lp parpor=
t=20
ti_usb_3410_5052 hid_logitech_hidpp snd_usb_audio snd_usbmidi_lib snd_ump=20
snd_rawmidi hid_logitech_dj r8153_ecm cdc_ether usbnet r8152 mii ib_core=20
dimlib tls >
 snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_component=20
snd_soc_dmic snd_sof_pci_intel_cnl snd_sof_intel_hda_generic soundwire_inte=
l=20
soundwire_cadence snd_sof_intel_hda_common snd_sof_intel_hda_mlink=20
snd_sof_intel_hda snd>
 processor_thermal_device_pci_legacy intel_cstate hp_wmi=20
processor_thermal_device snd_timer sparse_keymap processor_thermal_wt_hint=
=20
intel_uncore intel_wmi_thunderbolt thunderbolt wmi_bmof cfg80211 snd=20
processor_thermal_rfim i2c_i801 sp>
=2D--[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x5d/0xc0
Code: 48 8b 01 48 39 f8 75 5a 48 8b 72 08 48 39 f0 75 65 b8 01 00 00 00 c3 =
cc=20
cc cc cc 48 89 fe 48 c7 c7 f0 89 ba ad e8 73 34 8f ff <0f> 0b 48 89 fe 48 c=
7=20
c7 20 8a ba ad e8 62 34 8f ff 0f 0b 48 89 fe
RSP: 0018:ffffac7299f5bdb0 EFLAGS: 00010246
RAX: 0000000000000033 RBX: ffff977c0afd0b08 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff977f2d5a18c0 RDI: ffff977f2d5a18c0
RBP: ffff977c0afd0b00 R08: 0000000000000000 R09: 4e20736920747865
R10: 7478656e3e2d3030 R11: 4c4c554e20736920 R12: ffff977c17128010
R13: 000000000000000a R14: 00000000000000a0 R15: ffff977c17128000
=46S:  0000000000000000(0000) GS:ffff977f2d580000(0000) knlGS:0000000000000=
000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f063638a000 CR3: 0000000179428002 CR4: 00000000003706f0
note: kworker/u32:3[248608] exited with preempt_count 3

> > Is there any possibility/way to avoid bisecting? (due limited time from=
 my
> > side)>=20
> So unless you have a reason to specifically use z3fold or avoid
> zsmalloc, please use zsmalloc. It should be better for you anyway. I
> doubt that you (or anyone) wants to spend time debugging a z3fold
> problem :)

I could conceivably try to bisect this, but since I don't have a quick=20
reproducer, it would likely take weeks to finish. I'm wondering whether it'=
s=20
worth trying or if z3fold is going out of the door anyway. I don't think it=
's=20
hardware-related so it should be possible to test this in a VM, but that st=
ill=20
takes some effort to set up.

Best regards,

Tom=C3=A1=C5=A1 Trnka



