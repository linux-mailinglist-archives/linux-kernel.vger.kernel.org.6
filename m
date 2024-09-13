Return-Path: <linux-kernel+bounces-328661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B54978704
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7BCE1C242C9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B782D84DE0;
	Fri, 13 Sep 2024 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uWg4c/mr"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3819584A5C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249236; cv=none; b=c7lKzcF5ilS27Zo4AgolCBnpAjTbHaW84VD2UVKgyTS/p0AOBW7rEIKlmJXka6rM8dm9bOnPUWlsNk54Xik7qyljOIu69c88Xm1k7XaKj68HVyVzXCQUv1D0FgAdDrxfiQYzPfvcrLuLypLwtM5t9MoaoRArHgrtbCCpqmsXBzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249236; c=relaxed/simple;
	bh=/2Ohq0NMyGeL3WSa8dFttARPWMpEABhBJB3xllDYmYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=En0J7+6vKmn0DHtgTDmVQOFs3jCXR0idMIYx8Jk59ZnYRs8iE+pCnZklvmKCFurwGUGKT4ylmtyf1KzxgQiJLLBgtqbyec8iiia8xyyElB3Hyki6Zz/AbLxSJmIRfFU5IHEjQ7hgwcruIEjmMQtGZKSA8inCJJXiuRTJfIewwXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uWg4c/mr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so15797675e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 10:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726249232; x=1726854032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MV//vMadBXNAeDxNpKJbhQVJOpXHshAUgJME6e2RQz4=;
        b=uWg4c/mrdQGGEJV4zdU/Sh6BsBt2SVNNzJ/p2MtZBhkzpxOxYx2jnISEUqeJ+zCCAR
         l3Mf5llS8X67cVkQ4XHioBf+sm2UNMbd9E5qtEe7DmEmFcSmHsC9WBgI/2n/naP7pbLG
         0rZjD2PcR+ik751TNzICpNuqXQNnahE4XXdrlHoI365/bewwW1KVI5gliy63s3NfbRpf
         J0IkaZAFSXuua6mMYs2X+NZJHSqgyOQ3zCEqxpnUri3PtBnhbuas6jGTSa/lOPwY2I7F
         gxdqRhmTnCqHQtuKme5E3QOfjqumeDi03DnuMNn31Vk9TOYw1GIaGOSu8QTSJD3Cndo7
         /OEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726249232; x=1726854032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MV//vMadBXNAeDxNpKJbhQVJOpXHshAUgJME6e2RQz4=;
        b=WQwffD0sX2jQ75ayWQ4j/QnqncJ26LeeJCfpzbw1W+Z64L6KgqQybDaD/hxMRC/SOf
         JY7i3v55a9MZ7iByXz9TBywCrh+17si/oDDtPz86qOo8jrpMZyNN6WHuyKtC+I+OF/2/
         UA+kcYCWwesoS+C98ITxsCBxZHFuspCscgltnCljaXSdKbrMC5Hwa6LhkyWd+mFxdmhj
         kd1E+uANfvHJmgnhcKqpuhoW4OY3PKSqLO6tUSCNlU2ojjOZ/xw25AkLNTtA3isBu9AI
         s4VF3RIR7Ykn7ort1CXjH68AnJ5Xds6P1YEXU3tk0ez8VuvsvC1i4Ab4v9Mn0s0kHzgq
         V6tw==
X-Forwarded-Encrypted: i=1; AJvYcCX3IpUvXnnuaejI5gCdbWgQBC8QG7HE0MANT1HIJ/gm4QT2e2OklbhatOLJXeBoO0LjjR+95k4u5B4RqK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhClMprDLagX0GBtBMaxoceuyAjw3SBQjKJ8fI7YgUH87clt7K
	zptwFG4G9mGrp8sv0/WPUB/40TtBy9TG7jXCBxmgs725kHqq4uydQFgdcyMliG27D0XSReviJZI
	mWwdp7ZBy3eNvSfIvChBPVq2XC3tI1ZkTJwzzi+X3XnoAFXmRYPgh
X-Google-Smtp-Source: AGHT+IFIyujRzAe4WlemD4EfCBpbqNG9oq0567HHDveKlpdCWunt+0ofHO0jr8IHidqrsP7gfOEuMszgh2JULwWn3vs=
X-Received: by 2002:a5d:550d:0:b0:374:c69b:5a24 with SMTP id
 ffacd0b85a97d-378d6243ba0mr3009632f8f.51.1726249231412; Fri, 13 Sep 2024
 10:40:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJD7tkaTcnuCFW+dWTzSAuLKBqkkGv9s5uByYm9DaJC=Cp-Xqg@mail.gmail.com>
 <2272920.vFx2qVVIhK@electra>
In-Reply-To: <2272920.vFx2qVVIhK@electra>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 13 Sep 2024 10:39:55 -0700
Message-ID: <CAJD7tkaPjJWr28CzGoTK3e-4e4eP2gLSojaEH3U9X9E0KgBs8g@mail.gmail.com>
Subject: Re: [regression] oops on heavy compilations ("kernel BUG at
 mm/zswap.c:1005!" and "Oops: invalid opcode: 0000")
To: =?UTF-8?B?VG9tw6HFoSBUcm5rYQ==?= <trnka@scm.com>
Cc: hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	nphamcs@gmail.com, pedro.falcato@gmail.com, piotr.oniszczuk@gmail.com, 
	regressions@lists.linux.dev, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 2:03=E2=80=AFAM Tom=C3=A1=C5=A1 Trnka <trnka@scm.co=
m> wrote:
>
> > Well, it's possible that some zswap change was not fully compatible
> > with z3fold, or surfaced a dormant bug in z3fold. Either way, my
> > recommendation is to use zsmalloc. I have been trying to deprecate
> > z3fold, and honestly you are the only person I have seen use z3fold in
> > a while -- which is probably why no one else reported such a problem.
>
> FWIW, I have repeatedly hit this exact BUG (mm/zswap.c:1005) on two of my
> machines on 6.10.x (possibly 6.9.x as well, but I don't have the logs at =
hand
> to confirm). In both cases, this was also using z3fold under moderate mem=
ory
> pressure. I think this fairly conclusively rules out a HW issue.
>
> Additionally, I have hit the following BUG on 6.10.8, which is potentiall=
y
> related (note __z3fold_alloc in there):
>
> list_del corruption, ffff977c17128000->next is NULL
> ------------[ cut here ]------------
> kernel BUG at lib/list_debug.c:52!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 3 PID: 248608 Comm: kworker/u32:3 Tainted: G        W
> 6.10.8-100.fc39.x86_64 #1
> Hardware name: HP HP EliteBook 850 G6/8549, BIOS R70 Ver. 01.28.00 04/12/=
2024
> Workqueue: zswap12 compact_page_work
> RIP: 0010:__list_del_entry_valid_or_report+0x5d/0xc0
> Code: 48 8b 01 48 39 f8 75 5a 48 8b 72 08 48 39 f0 75 65 b8 01 00 00 00 c=
3 cc
> cc cc cc 48 89 fe 48 c7 c7 f0 89 ba ad e8 73 34 8f ff <0f> 0b 48 89 fe 48=
 c7
> c7 20 8a ba ad e8 62 34 8f ff 0f 0b 48 89 fe
> RSP: 0018:ffffac7299f5bdb0 EFLAGS: 00010246
> RAX: 0000000000000033 RBX: ffff977c0afd0b08 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffff977f2d5a18c0 RDI: ffff977f2d5a18c0
> RBP: ffff977c0afd0b00 R08: 0000000000000000 R09: 4e20736920747865
> R10: 7478656e3e2d3030 R11: 4c4c554e20736920 R12: ffff977c17128010
> R13: 000000000000000a R14: 00000000000000a0 R15: ffff977c17128000
> FS:  0000000000000000(0000) GS:ffff977f2d580000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f063638a000 CR3: 0000000179428002 CR4: 00000000003706f0
> Call Trace:
>  <TASK>
>  ? die+0x36/0x90
>  ? do_trap+0xdd/0x100
>  ? __list_del_entry_valid_or_report+0x5d/0xc0
>  ? do_error_trap+0x6a/0x90
>  ? __list_del_entry_valid_or_report+0x5d/0xc0
>  ? exc_invalid_op+0x50/0x70
>  ? __list_del_entry_valid_or_report+0x5d/0xc0
>  ? asm_exc_invalid_op+0x1a/0x20
>  ? __list_del_entry_valid_or_report+0x5d/0xc0
>  __z3fold_alloc+0x4e/0x4b0
>  do_compact_page+0x20e/0xa60
>  process_one_work+0x17b/0x390
>  worker_thread+0x265/0x380
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0xcf/0x100
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x31/0x50
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> Modules linked in: nf_conntrack_netbios_ns nf_conntrack_broadcast lp parp=
ort
> ti_usb_3410_5052 hid_logitech_hidpp snd_usb_audio snd_usbmidi_lib snd_ump
> snd_rawmidi hid_logitech_dj r8153_ecm cdc_ether usbnet r8152 mii ib_core
> dimlib tls >
>  snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_component
> snd_soc_dmic snd_sof_pci_intel_cnl snd_sof_intel_hda_generic soundwire_in=
tel
> soundwire_cadence snd_sof_intel_hda_common snd_sof_intel_hda_mlink
> snd_sof_intel_hda snd>
>  processor_thermal_device_pci_legacy intel_cstate hp_wmi
> processor_thermal_device snd_timer sparse_keymap processor_thermal_wt_hin=
t
> intel_uncore intel_wmi_thunderbolt thunderbolt wmi_bmof cfg80211 snd
> processor_thermal_rfim i2c_i801 sp>
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__list_del_entry_valid_or_report+0x5d/0xc0
> Code: 48 8b 01 48 39 f8 75 5a 48 8b 72 08 48 39 f0 75 65 b8 01 00 00 00 c=
3 cc
> cc cc cc 48 89 fe 48 c7 c7 f0 89 ba ad e8 73 34 8f ff <0f> 0b 48 89 fe 48=
 c7
> c7 20 8a ba ad e8 62 34 8f ff 0f 0b 48 89 fe
> RSP: 0018:ffffac7299f5bdb0 EFLAGS: 00010246
> RAX: 0000000000000033 RBX: ffff977c0afd0b08 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffff977f2d5a18c0 RDI: ffff977f2d5a18c0
> RBP: ffff977c0afd0b00 R08: 0000000000000000 R09: 4e20736920747865
> R10: 7478656e3e2d3030 R11: 4c4c554e20736920 R12: ffff977c17128010
> R13: 000000000000000a R14: 00000000000000a0 R15: ffff977c17128000
> FS:  0000000000000000(0000) GS:ffff977f2d580000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f063638a000 CR3: 0000000179428002 CR4: 00000000003706f0
> note: kworker/u32:3[248608] exited with preempt_count 3
>
> > > Is there any possibility/way to avoid bisecting? (due limited time fr=
om my
> > > side)>
> > So unless you have a reason to specifically use z3fold or avoid
> > zsmalloc, please use zsmalloc. It should be better for you anyway. I
> > doubt that you (or anyone) wants to spend time debugging a z3fold
> > problem :)
>
> I could conceivably try to bisect this, but since I don't have a quick
> reproducer, it would likely take weeks to finish. I'm wondering whether i=
t's
> worth trying or if z3fold is going out of the door anyway. I don't think =
it's
> hardware-related so it should be possible to test this in a VM, but that =
still
> takes some effort to set up.

z3fold is going out of the door anyway, I already sent a patch to deprecate=
 it:
https://lore.kernel.org/lkml/20240904233343.933462-1-yosryahmed@google.com/

I will send a new version after the merge window, and I will include
your bug report in the list of problems in the commit log :) Thanks
for the report, please don't waste time debugging this and use
zsmalloc!

>
> Best regards,
>
> Tom=C3=A1=C5=A1 Trnka
>
>

