Return-Path: <linux-kernel+bounces-284139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 795D094FD78
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D98F1C227F9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 05:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609362E3EE;
	Tue, 13 Aug 2024 05:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ufal.mff.cuni.cz header.i=@ufal.mff.cuni.cz header.b="QArkieaa"
Received: from ufal-mail.mff.cuni.cz (ufal-mail.mff.cuni.cz [195.113.20.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EDF36AFE;
	Tue, 13 Aug 2024 05:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723528524; cv=none; b=GKNV1Mtt1vYWK/PjYN0w/EqEur1wBM5oQpIl49IcXtE3ml5vGYDmw7gAR+lmBJ2FELD9rLCjoV73KP9o472IerukRjzlE9/xa6TM/tHAbbG4GK5RizseFanpAIM7XUiZcenVRK6xsrhn3OguvOedwp4w1KxbPxfvuygYv3vQk/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723528524; c=relaxed/simple;
	bh=iAVIEQAhWPDzY21DHkmExc2LBQqx5cirQIOnN4kA5bQ=;
	h=From:To:Cc:Subject:Date:MIME-Version:Message-ID:In-Reply-To:
	 References:Content-Type; b=VJgkOigdek96t7uIzrNIeFdKrrZiboORufaT4Zn/WgGSisi9EhQ2XU6GG6glFLT+67iV24BukVXnopJGWgcLHvDYzka/9jI/FuCQCUJvkoGr1fz5fi+5hBeVuly4kZ8aT21U8Ja3iZl0/jPP6RFewVZg67rC4hTRULKHVIggBEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ufal.mff.cuni.cz; spf=fail smtp.mailfrom=ufal.mff.cuni.cz; dkim=pass (2048-bit key) header.d=ufal.mff.cuni.cz header.i=@ufal.mff.cuni.cz header.b=QArkieaa; arc=none smtp.client-ip=195.113.20.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ufal.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=ufal.mff.cuni.cz
Received: from localhost (localhost.localdomain [127.0.0.1])
	by ufal-mail.mff.cuni.cz (Postfix) with ESMTP id 760B3466DA3;
	Tue, 13 Aug 2024 07:49:35 +0200 (CEST)
Received: from ufal-mail.mff.cuni.cz ([127.0.0.1])
 by localhost (ufal-mail.mff.cuni.cz [127.0.0.1]) (amavis, port 10032)
 with ESMTP id FzvFRP1vahuu; Tue, 13 Aug 2024 07:49:35 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by ufal-mail.mff.cuni.cz (Postfix) with ESMTP id 45C8E466DA2;
	Tue, 13 Aug 2024 07:49:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 ufal-mail.mff.cuni.cz 45C8E466DA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ufal.mff.cuni.cz;
	s=9D3691E2-3533-11E9-988E-D2516E4D0B60; t=1723528175;
	bh=9Qo3RBNfQlfYKO/iSyaYd7ScNV7xgdfPamMg9nqfVeA=;
	h=From:To:Date:MIME-Version:Message-ID;
	b=QArkieaaSx21qiWbVSshDwjKsmfLTWDUFQLFBVO8QKedYbiPGjYKMmMyuGPnwjJw+
	 1RIaguISIOemaJymPN9STGKIMoMlYKSQF1ogbQAG7Zw5cjTdrO9kdxl3dKmz3arzqB
	 mNm7q7usjruejlAo9bhaaUc/4yo0wAglGsIQpLEO1xT5mSEBaI5xMp5c3GNFtLtneG
	 j35lQpRhWQDfU3IQ2/bPI06A9lRS+XczdVIJe0ElKZbtKzeaTY2SwOmDgU4eeOEPUA
	 QIlaQjOX18NAZuu9TQ4a9EXCFYmdWMrBvbVfPlpgF7PXJ4uqKj6IjV9JmgFnJCGSSc
	 NGcmTfBXqsj4A==
X-Virus-Scanned: amavis at ufal.mff.cuni.cz
Received: from ufal-mail.mff.cuni.cz ([127.0.0.1])
 by localhost (ufal-mail.mff.cuni.cz [127.0.0.1]) (amavis, port 10026)
 with ESMTP id J8qxn1nIJEyT; Tue, 13 Aug 2024 07:49:35 +0200 (CEST)
Received: from localhost (snat-16.cgn.sat-an.net [176.222.226.16])
	by ufal-mail.mff.cuni.cz (Postfix) with ESMTPSA id 158AF466DA1;
	Tue, 13 Aug 2024 07:49:35 +0200 (CEST)
From: =?utf-8?B?Sm9uw6HFoSBWaWRyYQ==?= <vidra@ufal.mff.cuni.cz>
To: =?iso-8859-1?Q?Kolbj=F8rn_Barmen?= <linux-ppc@kolla.no>
Cc: <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>,
 <linux-ide@vger.kernel.org>,
 <mpe@ellerman.id.au>,
 <cassel@kernel.org>,
 <linux@roeck-us.net>
Subject: Re: Since 6.10 - kernel oops/panics on G4 macmini due to change in =?iso-8859-1?Q?drivers/ata/pata=5Fmacio.c?=
Date: Tue, 13 Aug 2024 07:49:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3b6441b8-06e6-45da-9e55-f92f2c86933e@ufal.mff.cuni.cz>
In-Reply-To: <62d248bb-e97a-25d2-bcf2-9160c518cae5@kolla.no>
References: <62d248bb-e97a-25d2-bcf2-9160c518cae5@kolla.no>
User-Agent: Trojita/v0.7-596-g21dfb8c3; Qt/5.15.14; xcb; Linux; Gentoo Linux
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Tue 13. Aug 2024 0:32:37 CEST, Kolbj=C3=B8rn Barmen wrote:
> Ever since 6.10, my macmini G4 behaved unstable when dealing with lots of
> I/O activity, such as sync'ing of Gentoo portage tree, unpacking kernel
> source tarball, building large software packages (or kernel) etc.
>
> After a bit of testing, and patient kernel rebuilding (while crashing) I
> found the cuplit to be this commit/change
>
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/diff/?id=3D=
09fe2bfa6b83f865126ce3964744863f69a4a030

I've been able to reproduce this pata_macio bug on a desktop PowerMac G4
with the 6.10.3 kernel version. Reverting the linked change
("ata: pata_macio: Fix max_segment_size with PAGE_SIZE =3D=3D 64K") makes
the errors go away.

CCing linux-ide and the authors of that patch; I hope this is OK with
you guys.


> Exampe of what a opps/panic looks like (and they all look very much alike)
>
> https://share.icloud.com/photos/042BHRkrXqPO-fllvpxMFl2CA

Textual form for easier searching:


------------[ cut here ]------------
kernel BUG at drivers/ata/pata_macio.c:544!
Oops: Exception in kernel mode, sig: 5 [#1]
BE PAGE_SIZE=3D4K MMU=3DHash SMP NR_CPUS=3D2 DEBUG_PAGEALLOC PowerMac
Modules linked in: ipv6 binfmt_misc b43 mac80211 radeon libarc4 cfg80211=20
snd_aoa_codec_tas snd_aoa_fabric_layout snd_aoa rfkill snd_aoa_i2sbus hwmon=20=

drm_suballoc_helper snd_aoa_soundbus i2c_algo_bit snd_pcm backlight=20
drm_ttm_helper ttm xhci_pci pmac_zilog therm_windtunnel xhci_hcd=20
drm_display_helper firewire_ohci snd_timer snd firewire_core serial_base=20
ssb soundcore crc_itu_t
CPU: 1 PID: 1870 Comm: kworker/u10:4 Tainted: G                T =20
6.10.3-gentoo #1
Hardware name: PowerMac3,6 7455 0x80010303 PowerMac
Workqueue: btrfs-worker btrfs_work_helper
NIP:  c0719670 LR: c0719678 CTR: 00000001
REGS: f2db9bf0 TRAP: 0700   Tainted: G                T   (6.10.3-gentoo)
MSR:  00021032 <ME,IR,DR,RI>  CR: 44008408  XER: 20000000

GPR00: c06fc28c f2db9cb0 c10d8020 c12d28cc 00000000 00000000 00000000=20
c109cff4=20
GPR08: 69fd0000 00000100 00010000 00000000 00000000 00000000 c007801c=20
c40c1980=20
GPR16: 00000000 00000000 00000000 00000000 00000000 00000100 00000122=20
c11377c8=20
GPR24: 000000ff 00000008 0000ff00 00000000 c14200a8 00000101 00000000=20
c109d000=20
NIP [c0719670] pata_macio_qc_prep+0xf4/0x190
LR [c0719678] pata_macio_qc_prep+0xfc/0x190
Call Trace:
[f2db9cb0] [c1421660] 0xc1421660 (unreliable)
[f2db9ce0] [c06fc28c] ata_qc_issue+0x14c/0x2d4
[f2db9d00] [c0707c5c] __ata_scsi_queuecmd+0x200/0x53c
[f2db9d20] [c0707fe8] ata_scsi_queuecmd+0x50/0xe0
[f2db9d40] [c06e2644] scsi_queue_rq+0x788/0xb1c
[f2db9d80] [c0492464] __blk_mq_issue_directly+0x58/0xf4
[f2db9db0] [c0497828] blk_mq_plug_issue_direct+0x8c/0x1b4
[f2db9de0] [c0498074] blk_mq_flush_plug_list.part.0+0x584/0x5e0
[f2db9e30] [c0485a40] __blk_flush_plug+0xf8/0x194
[f2db9e70] [c0485f88] __submit_bio+0x1b8/0x2e0
[f2db9ec0] [c04862e0] submit_bio_noacct_nocheck+0x230/0x304
[f2db9f00] [c03aaf30] btrfs_work_helper+0x200/0x338
[f2db9f40] [c006cae0] process_one_work+0x1a8/0x338
[f2db9f70] [c006d79c] worker_thread+0x364/0x4c0
[f2db9fc0] [c007811c] kthread+0x100/0x104
[f2db9ff0] [c001b304] start_kernel_thread+0x10/0x14
Code: 38ff0004 b37f0002 7d20ff2c 3bff0010 7d003d2c 7d084a14 93dffff8=20
b3dffffe b3dffffc 41820010 3bbd0001 4200ffc0 <0fe00000> 4bdcbb01 813c0044=20
3b180001=20
---[ end trace 0000000000000000 ]---

note: kworker/u10:4[1870] exited with irqs disabled
------------[ cut here ]------------
WARNING: CPU: 1 PID: 1870 at kernel/exit.c:825 do_exit+0x854/0x9ec
Modules linked in: ipv6 binfmt_misc b43 mac80211 radeon libarc4 cfg80211=20
snd_aoa_codec_tas snd_aoa_fabric_layout snd_aoa rfkill snd_aoa_i2sbus hwmon=20=

drm_suballoc_helper snd_aoa_soundbus i2c_algo_bit snd_pcm backlight=20
drm_ttm_helper ttm xhci_pci pmac_zilog therm_windtunnel xhci_hcd=20
drm_display_helper firewire_ohci snd_timer snd firewire_core serial_base=20
ssb soundcore crc_itu_t
CPU: 1 PID: 1870 Comm: kworker/u10:4 Tainted: G      D         T =20
6.10.3-gentoo #1
Hardware name: PowerMac3,6 7455 0x80010303 PowerMac
Workqueue: btrfs-worker btrfs_work_helper
NIP:  c004f09c LR: c004e8a4 CTR: 00000000
REGS: f2db9a80 TRAP: 0700   Tainted: G      D         T   (6.10.3-gentoo)
MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 88db92e2  XER: 00000000

GPR00: c004f2c4 f2db9b40 c10d8020 00000000 00002710 00000000 00000000=20
00000000=20
GPR08: 00000000 f2db9e88 00000004 00000000 28db92e2 00000000 c007801c=20
c40c1980=20
GPR16: 00000000 00000000 00000000 00000000 00000000 00000100 00000122=20
c11377c8=20
GPR24: 000000ff c0db0000 00001032 c0a21000 c138d520 00000005 c10d8020=20
c1447220=20
NIP [c004f09c] do_exit+0x854/0x9ec
LR [c004e8a4] do_exit+0x5c/0x9ec
Call Trace:
[f2db9b40] [c00b0c38] _printk+0x78/0xc4 (unreliable)
[f2db9b90] [c004f2c4] make_task_dead+0x90/0x174
[f2db9bb0] [c0010b9c] die+0x324/0x32c
[f2db9be0] [c0004828] ProgramCheck_virt+0x108/0x158
--- interrupt: 700 at pata_macio_qc_prep+0xf4/0x190
NIP:  c0719670 LR: c0719678 CTR: 00000001
REGS: f2db9bf0 TRAP: 0700   Tainted: G      D         T   (6.10.3-gentoo)
MSR:  00021032 <ME,IR,DR,RI>  CR: 44008408  XER: 20000000

GPR00: c06fc28c f2db9cb0 c10d8020 c12d28cc 00000000 00000000 00000000=20
c109cff4=20
GPR08: 69fd0000 00000100 00010000 00000000 00000000 00000000 c007801c=20
c40c1980=20
GPR16: 00000000 00000000 00000000 00000000 00000000 00000100 00000122=20
c11377c8=20
GPR24: 000000ff 00000008 0000ff00 00000000 c14200a8 00000101 00000000=20
c109d000=20
NIP [c0719670] pata_macio_qc_prep+0xf4/0x190
LR [c0719678] pata_macio_qc_prep+0xfc/0x190
--- interrupt: 700
[f2db9cb0] [c1421660] 0xc1421660 (unreliable)
[f2db9ce0] [c06fc28c] ata_qc_issue+0x14c/0x2d4
[f2db9d00] [c0707c5c] __ata_scsi_queuecmd+0x200/0x53c
[f2db9d20] [c0707fe8] ata_scsi_queuecmd+0x50/0xe0
[f2db9d40] [c06e2644] scsi_queue_rq+0x788/0xb1c
[f2db9d80] [c0492464] __blk_mq_issue_directly+0x58/0xf4
[f2db9db0] [c0497828] blk_mq_plug_issue_direct+0x8c/0x1b4
[f2db9de0] [c0498074] blk_mq_flush_plug_list.part.0+0x584/0x5e0
[f2db9e30] [c0485a40] __blk_flush_plug+0xf8/0x194
[f2db9e70] [c0485f88] __submit_bio+0x1b8/0x2e0
[f2db9ec0] [c04862e0] submit_bio_noacct_nocheck+0x230/0x304
[f2db9f00] [c03aaf30] btrfs_work_helper+0x200/0x338
[f2db9f40] [c006cae0] process_one_work+0x1a8/0x338
[f2db9f70] [c006d79c] worker_thread+0x364/0x4c0
[f2db9fc0] [c007811c] kthread+0x100/0x104
[f2db9ff0] [c001b304] start_kernel_thread+0x10/0x14
Code: 915e02fc 81410014 912a0004 915e03c0 939e03c4 91210014 813e04cc=20
4bfffcec 807e0370 38800000 4bffe195 4bfffc9c <0fe00000> 4bfff848 0fe00000=20
4bfff7ec=20
---[ end trace 0000000000000000 ]---


