Return-Path: <linux-kernel+bounces-288453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEF6953A48
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F5CF1C24DC8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FFB73451;
	Thu, 15 Aug 2024 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KAW/lY4M"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D54B7174F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723747222; cv=none; b=ZXNtk6/nwfpcES22jAHI4qxpJw+WYfIHKuF0Q2X5cO0v3xy8WjwcgKjTbI21/oiUgPlKhwJ1l4EZE/pdeEY9l5t+LeFPXgOKJLOGsXKWYuN2ircZ8HUYoVuwb2SLFnc1Fmgkm+vRSLLmutUI1Iwn47VhjvA52LkgtVe9dCoUU3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723747222; c=relaxed/simple;
	bh=iP3pBZunv9an/JWK4uwHy90nm2BGiu5BnA3PGofU75Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgN/X+HMzjlOuB0ZZazQi+4rbC+DaVT29XrymMij/6DsGazJWTshX6TuGpqIKaaEwBOoOgLjAZuIwDXN2yzVw4ov9HxEYU1rJk9ugPtDSPLuj9IjCo5SsKFDJOestOQukO1NQPG53jBZDxNq0PSBtaoVtgISNbq6pAirX2ZNhH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KAW/lY4M; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e115ef5740dso1331807276.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 11:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723747220; x=1724352020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6twqm9Yc6e/2w4/oA8h/PlAlhh+vo52vlGS7BIi8mc=;
        b=KAW/lY4Mygr6dcUGp33x4RS/7vZYRrzOt1cYXMgikMvlWI+JKPAGvTgYk/TCLv5NT+
         nhDgKgnBosxA3TdCYkXnhVw+S9uhe/3cDNjiCIyLBPPmyxhUUtotCvbFZl6tWWhvndR3
         8xF25FAVWVvQt0zaUmM3iuGqDoEHZFUbRDJYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723747220; x=1724352020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6twqm9Yc6e/2w4/oA8h/PlAlhh+vo52vlGS7BIi8mc=;
        b=R6EKiV0k3utGgMgC7r08fn7NN/V516khv4s5Ms7sA7B+TqD9QQjOL07qcK12ybHYK2
         k3Yr6mwDCLd/GOGSF15boZCWluPzpyfuUKI/tkTwY32wV+U59y0aG5jNXL9dGrC5AfAT
         ctOwP9gIquqKxusGTtfZqjuF06ohCSwjnMmqKyHexoYk/G/6sXgSGMxVRlyF1N27p43k
         6zanoGsRM+si7eZvKC72DPXpU1v97nU6STRmd7zxJJaDeCjHp8SkUTDKuxtUO4Wz+QMB
         ivoUo5H04jW573BbA2JkOnzA8NZtg6tIGdh1amVuIDqDySzbcIu1zBZhM98De7SaB2kc
         lpwg==
X-Forwarded-Encrypted: i=1; AJvYcCWGlKg3iWICGq7b8jBnHf3QOivSHkStzJg/FFb5QkRzNDyIlGMMG2fcN2xQdMfiUdaWCFbHCp1WcfB3eNr1AQiOK8E1GyBIBO9CiApu
X-Gm-Message-State: AOJu0YyQDfRbrGj5kw7aEIAvdGPIQg6vuyCcEWMjEKq+HAt0XFjcRI0G
	ZSe2yP7DC/rEm2d0GUM6mwEV8lSzbeTFO+Bj1MPWt481P1f6RGR0oA0ZXZCbJ0ISkNmCfhilJtB
	6qQ4VvM/CsvPPhy3uU7kDMXJ9WeCBVO9zaNT2hOuywZdOWKg=
X-Google-Smtp-Source: AGHT+IEcy7xzmO5hq16LPn4v17KdZBaVx0Voi4qh8NqcvNrYQaoAHytKR/xOq4LHfcwLe5YLHgQojVrduburu1Ax+lU=
X-Received: by 2002:a05:6902:11cb:b0:e11:44b9:6bb7 with SMTP id
 3f1490d57ef6-e1180f6e192mr966482276.24.1723747220109; Thu, 15 Aug 2024
 11:40:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0d0330f3-2ac0-4cd5-8075-7f1cbaf72a8e@heusel.eu>
In-Reply-To: <0d0330f3-2ac0-4cd5-8075-7f1cbaf72a8e@heusel.eu>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Thu, 15 Aug 2024 14:40:09 -0400
Message-ID: <CABQX2QM09V=+G=9T6Ax8Ad3F85hU0Cg4WqD82hTN=yhktXNDaQ@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] vmwgfx crashes with command buffer error
 after update
To: Christian Heusel <christian@heusel.eu>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Martin Krastev <martin.krastev@broadcom.com>, 
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>, dri-devel@lists.freedesktop.org, 
	Brad Spengler <spender@grsecurity.net>, rdkehn@gmail.com, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 1:48=E2=80=AFPM Christian Heusel <christian@heusel.=
eu> wrote:
>
> Hello Zack,
>
> the user rdkehn (in CC) on the Arch Linux Forums reports that after
> updating to the 6.10.4 stable kernel inside of their VM Workstation the
> driver crashes with the error attached below. This error is also present
> on the latest mainline release 6.11-rc3.
>
> We have bisected the issue together down to the following commit:
>
>     d6667f0ddf46 ("drm/vmwgfx: Fix handling of dumb buffers")
>
> Reverting this commit on top of 6.11-rc3 fixes the issue.
>
> While we were still debugging the issue Brad (also CC'ed) messaged me
> that they were seeing similar failures in their ESXi based test
> pipelines except for one box that was running on legacy BIOS (so maybe
> that is relevant). They noticed this because they had set panic_on_warn.
>
> Cheers,
> Chris
>
> ---
>
> #regzbot introduced: d6667f0ddf46
> #regzbot title: drm/vmwgfx: driver crashes due to command buffer error
> #regzbot link: https://bbs.archlinux.org/viewtopic.php?id=3D298491
>
> ---
>
> dmesg snippet:
> [   13.297084] ------------[ cut here ]------------
> [   13.297086] Command buffer error.
> [   13.297139] WARNING: CPU: 0 PID: 186 at drivers/gpu/drm/vmwgfx/vmwgfx_=
cmdbuf.c:399 vmw_cmdbuf_ctx_process+0x268/0x270 [vmwgfx]
> [   13.297160] Modules linked in: uas usb_storage hid_generic usbhid mpts=
pi sr_mod cdrom scsi_transport_spi vmwgfx serio_raw mptscsih ata_generic at=
kbd drm_ttm_helper libps2 pata_acpi vivaldi_fmap ttm mptbase crc32c_intel x=
hci_pci intel_agp xhci_pci_renesas ata_piix intel_gtt i8042 serio
> [   13.297172] CPU: 0 PID: 186 Comm: irq/16-vmwgfx Not tainted 6.10.4-arc=
h2-1 #1 517ed45cc9c4492ee5d5bfc2d2fe6ef1f2e7a8eb
> [   13.297174] Hardware name: VMware, Inc. VMware Virtual Platform/440BX =
Desktop Reference Platform, BIOS 6.00 11/12/2020
> [   13.297175] RIP: 0010:vmw_cmdbuf_ctx_process+0x268/0x270 [vmwgfx]
> [   13.297186] Code: 01 00 01 e8 ba 8c 4f f9 0f 0b 4c 89 ff e8 40 fb ff f=
f e9 9d fe ff ff 48 c7 c7 99 d9 3f c0 c6 05 52 2f 01 00 01 e8 98 8c 4f f9 <=
0f> 0b e9 1f fe ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> [   13.297187] RSP: 0018:ffffb9c1805e3d78 EFLAGS: 00010282
> [   13.297188] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 000000000=
0000003
> [   13.297189] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 000000000=
0000001
> [   13.297190] RBP: ffff907fc8274c98 R08: 0000000000000000 R09: ffffb9c18=
05e3bf8
> [   13.297191] R10: ffff9086dbdfffa8 R11: 0000000000000003 R12: ffff907fc=
4db5b00
> [   13.297192] R13: ffff907fc83fd318 R14: ffff907fc8274c88 R15: ffff907fc=
83fd300
> [   13.297193] FS:  0000000000000000(0000) GS:ffff9086dbe00000(0000) knlG=
S:0000000000000000
> [   13.297194] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   13.297194] CR2: 0000774dc57671ca CR3: 00000006b9e20005 CR4: 000000000=
03706f0
> [   13.297196] Call Trace:
> [   13.297198]  <TASK>
> [   13.297199]  ? vmw_cmdbuf_ctx_process+0x268/0x270 [vmwgfx a4fe13044bca=
4eda782d964fb8c4ca15afb325e9]
> [   13.297209]  ? __warn.cold+0x8e/0xe8
> [   13.297211]  ? vmw_cmdbuf_ctx_process+0x268/0x270 [vmwgfx a4fe13044bca=
4eda782d964fb8c4ca15afb325e9]
> [   13.297221]  ? report_bug+0xff/0x140
> [   13.297222]  ? console_unlock+0x84/0x130
> [   13.297225]  ? handle_bug+0x3c/0x80
> [   13.297226]  ? exc_invalid_op+0x17/0x70
> [   13.297227]  ? asm_exc_invalid_op+0x1a/0x20
> [   13.297230]  ? vmw_cmdbuf_ctx_process+0x268/0x270 [vmwgfx a4fe13044bca=
4eda782d964fb8c4ca15afb325e9]
> [   13.297238]  ? vmw_cmdbuf_ctx_process+0x268/0x270 [vmwgfx a4fe13044bca=
4eda782d964fb8c4ca15afb325e9]
> [   13.297245]  vmw_cmdbuf_man_process+0x5d/0x100 [vmwgfx a4fe13044bca4ed=
a782d964fb8c4ca15afb325e9]
> [   13.297253]  vmw_cmdbuf_irqthread+0x25/0x30 [vmwgfx a4fe13044bca4eda78=
2d964fb8c4ca15afb325e9]
> [   13.297261]  vmw_thread_fn+0x3a/0x70 [vmwgfx a4fe13044bca4eda782d964fb=
8c4ca15afb325e9]
> [   13.297271]  irq_thread_fn+0x20/0x60
> [   13.297273]  irq_thread+0x18a/0x270
> [   13.297274]  ? __pfx_irq_thread_fn+0x10/0x10
> [   13.297276]  ? __pfx_irq_thread_dtor+0x10/0x10
> [   13.297277]  ? __pfx_irq_thread+0x10/0x10
> [   13.297278]  kthread+0xcf/0x100
> [   13.297281]  ? __pfx_kthread+0x10/0x10
> [   13.297282]  ret_from_fork+0x31/0x50
> [   13.297285]  ? __pfx_kthread+0x10/0x10
> [   13.297286]  ret_from_fork_asm+0x1a/0x30
> [   13.297288]  </TASK>
> [   13.297289] ---[ end trace 0000000000000000 ]---

Hi, Christian.

Thanks for the report! So just to be clear vmwgfx doesn't crash, but
it shows a warning and the kernel has been compiled with panic on
warning which is actually what panics, right?

I haven't seen this on any of our systems so I'm guessing the affected
systems aren't running gnome/kde? Is there any chance I could see the
full "journalctl -b" log and the vmware.log file associated with those
warnings? They could give me some clues on how to reproduce this.

z

