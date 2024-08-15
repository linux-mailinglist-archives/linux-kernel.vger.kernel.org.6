Return-Path: <linux-kernel+bounces-288376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6AF953970
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7658C1F21B35
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263394501A;
	Thu, 15 Aug 2024 17:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="AQBSGfz4"
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7E3381B9;
	Thu, 15 Aug 2024 17:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723744146; cv=none; b=sLe76ZsiS+Wj2ilMsKE8pQeRfqiQCy+ry39DEk2Upy6amozaTJcEjhKGd6iL8V+hJPWDlcbigmdzVja906nJbGmperWu9uotmxM4ziAuH+ZInRqLl8p/UrEEkmMgfHKZVSjZ7BCpeVEPyv82Me8xdYxJqwuSq0b6ifbIXGsWbqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723744146; c=relaxed/simple;
	bh=LShGuLwllIFzdzRuMBK4f1annK1mH489K6OuSsSb4PI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l/JjvWFe4TcV75PMUpXPT24oY+bT8k09BjN2nM5vqieoEnjThvPTgmhH33OyafoiveGv9S87MAVq5JkrZcM3gLA+uYxWPFgfQOwOFmLnKghT0TLjuZR8g0iQncF6mOopZW1rA9FaXNuWjN1PI4u3hp0RbrMPOFj9YW9621l/82k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=AQBSGfz4; arc=none smtp.client-ip=217.72.192.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1723744128; x=1724348928; i=christian@heusel.eu;
	bh=i17Do2CHDdhiq+K0XPxEeh54Rx7NpaU9ydKHVt+MESs=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AQBSGfz4/cmKMljSPCO2EVGqfVsAh7+PxrKWI3f8CUJVVr0zLUlvH2XfTOl16zNX
	 W2JyJqbcdvDsRGIcCgyIo1zJ7JWBJSF6RlIgFEGZuCSWF6c6ST5zzD7jeoqkrVK9y
	 J8WI6/9Ifju5XLoei7jYD8IHQutSoSEyiwIL9KvYnEmlYxZ7+EvKa4l8zoPGs+Lz7
	 mp5mCJjOd3UwD7/3jwUxIONPM4Auj2LcDJuzsOcru+h2LR6mobqV19+JJ9hPGby0d
	 cmNAqaX3CkWuTlrWOEzUwyaM0yKO/q0SyjYWxoX9gI3meWxdJ9iUtCwf/UzSifJnp
	 ZtgJqI9waNrUSikw0Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([93.196.140.133]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MdNLi-1s5aoy3DQO-00kYMC; Thu, 15 Aug 2024 19:48:48 +0200
Date: Thu, 15 Aug 2024 19:48:47 +0200
From: Christian Heusel <christian@heusel.eu>
To: Zack Rusin <zack.rusin@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Martin Krastev <martin.krastev@broadcom.com>, 
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>, dri-devel@lists.freedesktop.org
Cc: Brad Spengler <spender@grsecurity.net>, rdkehn@gmail.com, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: [REGRESSION][BISECTED] vmwgfx crashes with command buffer error
 after update
Message-ID: <0d0330f3-2ac0-4cd5-8075-7f1cbaf72a8e@heusel.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xeshpdgka26cyf6x"
Content-Disposition: inline
X-Provags-ID: V03:K1:JUPgxU1ZmsfwMUV62viBWTiW20EgwxgFi3H0LoPMYdVQhtzV9P8
 W9vkJ34+Ux+q7q7W4iDCxi6Hpqj1kvSbOO5yZu6LAvr29WeKtNxFLjV+MZ0Z6zVNXgfaUro
 nvreKBZVDlkoUmXnG4ZbKnwYdyCRLgc3NLOCxV5sqwygl6VOEzjHnQhJabTgInOcAq+Dp4/
 weisKGI7ImDuFclJHHjgg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DqxK9oC/dGA=;0SgwjUUKAHi33mg3g1nsJllpmFu
 qyHfhTE8kE1OpcHgFc1PEHQLkn2v32KGgmC1Aw+XofuVrdrRumsEfDxya+Noc7bQPKCGlnGsW
 p6tGOZSvBAkX6mL2vEgr1fuhfdQ3lNGhBs90voQg5K9SNHKMDV0lVKEKLwTdHO1yWIQu2VawF
 DRRD5PauShQJzyu5sxdHf2uoFEUVmAmqkt0VnV027p7OT0PHEemI3qT/Lp8SJP/873EhAbUBR
 05M58QPKDQ6Hx9yMgF8gGrDWTUXF+fKL10T8HgwJ0HdxMxn/alnkbnUZ0+4DgAVsIiN4Ym36x
 nrGpEn26eGyxqyUXoQDk4o2zHiEYMA1StrSqnJr1si6zB8hQ28OEeXCXwMT7NvzjsSg0BwHRO
 YS+zLieNeGJ5VcZg11qOzWhiUUdC7DVvbx9l4Vi0klPnGCiPVB2U3/GXR3GDwzOOrcf1LRHPj
 flsmlL6p/QGADiN0fbkybFTAsp2yH2WxkwHIwJQg6sAtcitvnTGsDT6hruVOQuaNl6ajA1aco
 oMcuWrUZQO+s09An0/7mGTA6JLzlMsZMWPgfgHD+yQLCzOi1L3KbhlI/qSiClxKzrhgcDl4ay
 cNrTeKyOG38pLVRoadrAqdCmsnemMAOdHTYzTOWRJeYj0I1YnMZi0W3F1Sv3Yw9wDjVmGhfMY
 YksPedlR0SuW0a5IgOGZbF9Hs2/KoXFSXolsslUvynbzXGYQtvbPyF0ICb32BTiCbmhCekKlq
 /UxyWVzanI8nSqLlzkVLUV+ZNFuzK2qUA==


--xeshpdgka26cyf6x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Zack,

the user rdkehn (in CC) on the Arch Linux Forums reports that after
updating to the 6.10.4 stable kernel inside of their VM Workstation the
driver crashes with the error attached below. This error is also present
on the latest mainline release 6.11-rc3.

We have bisected the issue together down to the following commit:

    d6667f0ddf46 ("drm/vmwgfx: Fix handling of dumb buffers")

Reverting this commit on top of 6.11-rc3 fixes the issue.

While we were still debugging the issue Brad (also CC'ed) messaged me
that they were seeing similar failures in their ESXi based test
pipelines except for one box that was running on legacy BIOS (so maybe
that is relevant). They noticed this because they had set panic_on_warn.

Cheers,
Chris

---

#regzbot introduced: d6667f0ddf46
#regzbot title: drm/vmwgfx: driver crashes due to command buffer error
#regzbot link: https://bbs.archlinux.org/viewtopic.php?id=298491

---

dmesg snippet:
[   13.297084] ------------[ cut here ]------------
[   13.297086] Command buffer error.
[   13.297139] WARNING: CPU: 0 PID: 186 at drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c:399 vmw_cmdbuf_ctx_process+0x268/0x270 [vmwgfx]
[   13.297160] Modules linked in: uas usb_storage hid_generic usbhid mptspi sr_mod cdrom scsi_transport_spi vmwgfx serio_raw mptscsih ata_generic atkbd drm_ttm_helper libps2 pata_acpi vivaldi_fmap ttm mptbase crc32c_intel xhci_pci intel_agp xhci_pci_renesas ata_piix intel_gtt i8042 serio
[   13.297172] CPU: 0 PID: 186 Comm: irq/16-vmwgfx Not tainted 6.10.4-arch2-1 #1 517ed45cc9c4492ee5d5bfc2d2fe6ef1f2e7a8eb
[   13.297174] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
[   13.297175] RIP: 0010:vmw_cmdbuf_ctx_process+0x268/0x270 [vmwgfx]
[   13.297186] Code: 01 00 01 e8 ba 8c 4f f9 0f 0b 4c 89 ff e8 40 fb ff ff e9 9d fe ff ff 48 c7 c7 99 d9 3f c0 c6 05 52 2f 01 00 01 e8 98 8c 4f f9 <0f> 0b e9 1f fe ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[   13.297187] RSP: 0018:ffffb9c1805e3d78 EFLAGS: 00010282
[   13.297188] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000003
[   13.297189] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000001
[   13.297190] RBP: ffff907fc8274c98 R08: 0000000000000000 R09: ffffb9c1805e3bf8
[   13.297191] R10: ffff9086dbdfffa8 R11: 0000000000000003 R12: ffff907fc4db5b00
[   13.297192] R13: ffff907fc83fd318 R14: ffff907fc8274c88 R15: ffff907fc83fd300
[   13.297193] FS:  0000000000000000(0000) GS:ffff9086dbe00000(0000) knlGS:0000000000000000
[   13.297194] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.297194] CR2: 0000774dc57671ca CR3: 00000006b9e20005 CR4: 00000000003706f0
[   13.297196] Call Trace:
[   13.297198]  <TASK>
[   13.297199]  ? vmw_cmdbuf_ctx_process+0x268/0x270 [vmwgfx a4fe13044bca4eda782d964fb8c4ca15afb325e9]
[   13.297209]  ? __warn.cold+0x8e/0xe8
[   13.297211]  ? vmw_cmdbuf_ctx_process+0x268/0x270 [vmwgfx a4fe13044bca4eda782d964fb8c4ca15afb325e9]
[   13.297221]  ? report_bug+0xff/0x140
[   13.297222]  ? console_unlock+0x84/0x130
[   13.297225]  ? handle_bug+0x3c/0x80
[   13.297226]  ? exc_invalid_op+0x17/0x70
[   13.297227]  ? asm_exc_invalid_op+0x1a/0x20
[   13.297230]  ? vmw_cmdbuf_ctx_process+0x268/0x270 [vmwgfx a4fe13044bca4eda782d964fb8c4ca15afb325e9]
[   13.297238]  ? vmw_cmdbuf_ctx_process+0x268/0x270 [vmwgfx a4fe13044bca4eda782d964fb8c4ca15afb325e9]
[   13.297245]  vmw_cmdbuf_man_process+0x5d/0x100 [vmwgfx a4fe13044bca4eda782d964fb8c4ca15afb325e9]
[   13.297253]  vmw_cmdbuf_irqthread+0x25/0x30 [vmwgfx a4fe13044bca4eda782d964fb8c4ca15afb325e9]
[   13.297261]  vmw_thread_fn+0x3a/0x70 [vmwgfx a4fe13044bca4eda782d964fb8c4ca15afb325e9]
[   13.297271]  irq_thread_fn+0x20/0x60
[   13.297273]  irq_thread+0x18a/0x270
[   13.297274]  ? __pfx_irq_thread_fn+0x10/0x10
[   13.297276]  ? __pfx_irq_thread_dtor+0x10/0x10
[   13.297277]  ? __pfx_irq_thread+0x10/0x10
[   13.297278]  kthread+0xcf/0x100
[   13.297281]  ? __pfx_kthread+0x10/0x10
[   13.297282]  ret_from_fork+0x31/0x50
[   13.297285]  ? __pfx_kthread+0x10/0x10
[   13.297286]  ret_from_fork_asm+0x1a/0x30
[   13.297288]  </TASK>
[   13.297289] ---[ end trace 0000000000000000 ]---

--xeshpdgka26cyf6x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAma+P38ACgkQwEfU8yi1
JYVwiA/9G36ZEUXT70hvlbG4U2Z7QA7bWC90b8QurNshc6Xr7tmJuLcf79HlNo4l
sJdDhUQg1L2e9wKzaBMcUOZ5lSRZ3SY5/ga6MX6bODNcxqtwif0BVT0BCWdb1qPl
zlmpE3YIkf4PsaWmrQJQJqP83aB7rl0xPv7XAHD2W6sYE15nbi2hzg6wygIfJKK7
Vv0UgYAINiVMHX0i8lH+cmtXc9bQSHDHMsZRxpvor70IrWvKFBAaztXkttAqG8LK
bDC3MPysbnOwY2wPuAWbTCw1Sll1zoPlEOPn3CaNQWBOFhzXj4JkRooJLmBxWKsc
/D423XYX2/fto5MOt2WLKeg/lb+xImLpUyVB3J+6saeuNWyIP+7/tBOr8KKlDhWj
2py/ArAOxwDFth5f1XeqRutUgyC2loPf9gQ+TiFSqCbkKVtG99ApY1VsctKsrXVW
t8/d1OCq7xJOOHc8MJN+gKWfT8gJokFG+g5TsHPO+QOrGEX4iJ/dUbLNWomO871M
6wZb88FazgBRAQdS0UUno8AF+GypG5BA55iN+ltQ81V5PEunfwB2vcB4ebNE5ISm
27bM3cS1w42ov7T3O16wIn7eOenhbcM8ppNlyvQBOMJzSRXk1YwC9H85RgVYR3uC
sPgw+g5tyj4OG/5LS9Ow2mY735c3TGCddC+kkkrb4NFtJhi1RvQ=
=d3pZ
-----END PGP SIGNATURE-----

--xeshpdgka26cyf6x--

