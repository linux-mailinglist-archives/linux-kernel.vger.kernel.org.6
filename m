Return-Path: <linux-kernel+bounces-529251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB4BA4226A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5A63A2AA8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1879F24CEFD;
	Mon, 24 Feb 2025 13:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="FOLL4kub"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386D22E62B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405530; cv=none; b=NkMZHRNTJ+JBQalEkxtgiUsb+QDz2e00EfgySucrnEj1con7VD3V81AJmgvGfHJa2IPeDArWw2AdB2C/yuYIgY/CvaA/PAZsPYq49mAGZYnwzavy60BRTVbAa09gcVVdHBBhOaidzGlRT4tcHDEqqZ/WaCm7wvRN8fqei8ESEtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405530; c=relaxed/simple;
	bh=aWKU1HZM41aiqyNuDVucD7WdfPeGzPXcgxJS9DNmRGw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qgFUd7sPmhkACd3FIpxJpD1OTRuK/YCo/l42dsTwSSY/kiqj3rxtY5XZDj6o8VlHjDNMx09zmXu1eiGCk6+nxuxnxXUh5JRkwswvk9qsFMzpIW9+G0k7dPdxGu47mHJy73Rxq9oY0132ywpH4T464itiDO7G3wtIg0AzSU4FuO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=FOLL4kub; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1740405466; x=1741010266; i=christian@heusel.eu;
	bh=tbY3wrH6y6x/nkZ550MYydYW2nALhZ/ebJVhWPghixo=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FOLL4kubQDqWYAkXJsWI+MCD3fy6qtSfL2xNkc5bQS+7wyz/IGB+15scC2/ZYEo0
	 q2A/jY1dCMhsTBm6DDyiNW7e/nDfYgCJI1TFXiobKSL/l472pFngE8nwCHPPkSvuR
	 HTfswprCpzn0L+omjzbfVJdRFc9ziEmH/D8pFy6RmmAhdlg/xg7jvf0mDP65dKX/Q
	 kPVxa1DWkPGVCawv8gZCcJBHEXZV2LYdkw90J5fNgQ80CrP0OpDTi0rmm0IVb7VVs
	 W5qGmF9wmm4LMp7rXCC3o94UGNKvmD5fVDWjeOT7gKyCf3ZhlxYVGvpQyfFmV6uFM
	 3cIrZvbP3nQm8LpUww==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue010
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MkpOZ-1t2Bja3EVD-00ZOdb; Mon, 24
 Feb 2025 14:57:45 +0100
Date: Mon, 24 Feb 2025 14:57:40 +0100
From: Christian Heusel <christian@heusel.eu>
To: Rik van Riel <riel@surriel.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, 
	Zqiang <qiang.zhang1211@gmail.com>, Thorsten Blum <thorsten.blum@linux.dev>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Warning/trace in kernel/smp.c:815 smp_call_function_many_cond
Message-ID: <46a200b4-1293-413c-8b73-37f7b50abd1a@heusel.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hr23r556o5hrbv7v"
Content-Disposition: inline
X-Provags-ID: V03:K1:mTW23k8LzPfn0PEbMIBMfY7ymXPNWL90uYCfmE6ddyaUquOWcia
 vLSxJfF+throVK8KMHWOKSzrD2opZd/aTL3kyTGF8JD3skT4uNJ1k2aG4CrptqFNXn7ykB5
 JP9ld6PiOks4So/jeNI+V8b3FE6fRVKFSAQq75LSKTUVuJxCC5e6lb8x4GvZlVW7zzGIuZ9
 kqJiLhEOao7OR85KC/onA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4gNCrbXP5dM=;krTIhgsiGnOBfRzHOmPlGNBJOvN
 b7I/Tphhjnsoiaz+C1ue+dDmMEdUZ92BzMt1b1yTGf+/F/WlsSRtl9MSEmTq0ppf45ZmDMQ0z
 bGVauJvEPT4lnnyjNyinMyzoggpGUZ2PI+TRksoIJ8tW06uk40XZaHdnHlJpkQJZWWjHRls+h
 xIktQ2HI8zbpssHop4Dn4TyibegVG68pZf0Ex/lnMjDsSbAj+olJP5sZkAf2NiKR8KVX9l0yE
 oa6n29T6Ol0sjuIiEWotaNwA8d8SAOBAWug9EFNVIws7jiPfuFe2znfzW3qJmjL6MBNTo9TwR
 JLMN8sW8xMljHMbtG/K2ADSntL3cK8ZZ0BP1vxzwM9hLvYriIAh9O5+Pme4Tpmmur0b6dzYv/
 h9SEWx7/9pjbIcExv3X08jB0ctYWQCklN/ck408dl6rqdTSloqkgifV7WefUmNKGg52L0FRE3
 O2+kZfZ9Qxq4Kem0TK4Vgv0G7Q4Z3uoaXTMnpBrccxCVrs9YFN06chm8Sj4KGeswgOQbi20pJ
 WDB3+xeJJJv2i4DwHW+6fESjSAi0G0FNYWx27/uTNRtCSsfwNYKkBjrgWUggOnFVCt0sN8zVG
 AnpuMtl1BLSJO5Zd6FgKaB9GJsBOGX8ofa0eZI7m7/Y6A0WaEqfmMSvvkFkbc2AjG5JdiLUXS
 c/1CWC7Cbnp8iJOK5uYzrSgwQtei9Q/3Uyol0whmI8Fsrk0gIC8k0PobZNfMAgYDCV2g8OcxB
 c0EYd/6Y36m4I0vTUi6sQ5vtIOdw8oodPidaJVbVo9UIRL+ly0R7izNAUvTpkzp3cHCIsnsaD
 G0B1eoRYXwjiAI2RF639oqSmbbOJzljxs8AZxcyw+4+dDQqxG7FABI7OlrUG7SLm0Upu3HHlm
 KGk6AzT6f3lw38xir98ESodDA7Z7WnQ0JQGSMhKlW06VA6q/9OYZ57lTzRh7Pb47bLbUhyiIg
 5UzaJMskvTBonuOrJcn1j+ygQPwlPlJzM0tVvPsvSywwNJQxilR+WmSF10tcIgNom26Gl37fK
 3Ogf1HLywDSyQiO+EikahvmtOd37R1xQNBQc99vHONJ715OjRjvnxtNTrld5YujmPX8hPS9cf
 LpddAu1Dj9783FUTwOQ5oWNEPckJAlgPbmcWdv/T7CSNOlpqOpHY4tNn7GaG8MknOGAOAhM22
 iJfXX0fwBF+aVeoPrW2HZun+jQH/97nAKfND8tFL8HYRyxjRX2iVJ7HOC8XqArOvXMlHxDS/y
 w6GtdJSiV2Yf+MOl857nEpEY7Fu12m1ibCXpykPE8pgBS48zrnS5tBFODnQuAfr2JeLkd78kV
 ZGItVV8SS6QDGDjP5LwLFubyvLO1MuLmT0+KhtvFvksim9wx9Q7WkC8nks8DDwtLiWYAcAgG+
 LYrFRScSzW5mQVAA==


--hr23r556o5hrbv7v
Content-Type: multipart/mixed; protected-headers=v1;
	boundary="ehb65j4gtm3i6hrc"
Content-Disposition: inline
Subject: Warning/trace in kernel/smp.c:815 smp_call_function_many_cond
MIME-Version: 1.0


--ehb65j4gtm3i6hrc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello everyone,

I have noticed the following new warning in my dmesg output, I think I
have first seen this when upgrading to v6.14-rc1.

So far I have been unsuccessfull in bisecting it, therefore it would be
nice to get some input whether this is something serious or how I could
debug it further. I have also attached a full dmesg for more context.

    ------------[ cut here ]------------
    WARNING: CPU: 3 PID: 0 at kernel/smp.c:815 smp_call_function_many_cond+0x46b/0x4c0
    Modules linked in: usbhid amdgpu(+) crc16 amdxcp i2c_algo_bit drm_ttm_helper polyval_clmulni polyval_generic ttm ghash_clmulni_intel thinkpad_acpi sha512_ssse3 drm_exec sha256_ssse3 serio_raw gpu_sched sparse_keymap sha1_ssse3 atkbd drm_suballoc_helper platform_profile aesni_intel snd libps2 drm_panel_backlight_quirks vivaldi_fmap nvme drm_buddy crypto_simd soundcore rfkill drm_display_helper cryptd nvme_core video ccp cec i8042 nvme_auth serio wmi
    CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted 6.14.0-rc4-1.2-mainline-dirty #1 15d4d304a72b35c263f4a043f428325d584ede12
    Hardware name: LENOVO 20YDS00G00/20YDS00G00, BIOS R1OET26W (1.05 ) 04/28/2021
    RIP: 0010:smp_call_function_many_cond+0x46b/0x4c0
    Code: 28 e8 f9 d7 f3 ff 84 c0 0f 84 a4 fe ff ff 48 8b 54 24 60 66 90 8b 7c 24 28 48 8b 05 6f db de 01 e8 5a 6b ca 00 e9 88 fe ff ff <0f> 0b e9 d2 fb ff ff 65 8b 05 13 f5 fe 4f 48 0f a3 05 5f e3 04 02
    RSP: 0018:ffffa6bec037cd28 EFLAGS: 00010202
    RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000003
    RDX: 0000000000000000 RSI: ffffffffafebe1d0 RDI: ffffffffb2094b60
    RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
    R10: ffffffffb1eb44a8 R11: 0000000000000003 R12: 0000000000000003
    R13: 0000000000000003 R14: 0000000000000003 R15: 0000000000000000
    FS:  0000000000000000(0000) GS:ffff98ad5eb80000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 0000555c696da788 CR3: 000000009e222000 CR4: 0000000000350ef0
    Call Trace:
    <IRQ>
    ? smp_call_function_many_cond+0x46b/0x4c0
    ? __warn.cold+0x93/0xf6
    ? smp_call_function_many_cond+0x46b/0x4c0
    ? report_bug+0xff/0x140
    ? handle_bug+0x58/0x90
    ? exc_invalid_op+0x17/0x70
    ? asm_exc_invalid_op+0x1a/0x20
    ? __pfx_do_sync_core+0x10/0x10
    ? smp_call_function_many_cond+0x46b/0x4c0
    ? __pfx_text_poke_memcpy+0x10/0x10
    ? __pfx_do_sync_core+0x10/0x10
    on_each_cpu_cond_mask+0x24/0x40
    text_poke_bp_batch+0xc1/0x300
    ? vsnprintf+0x205/0x5c0
    ? arch_jump_label_transform_queue+0x57/0x80
    text_poke_finish+0x1f/0x30
    arch_jump_label_transform_apply+0x1a/0x30
    static_key_disable_cpuslocked+0x7d/0x80
    static_key_disable+0x1a/0x20
    tsc_cs_mark_unstable+0x31/0x50
    __clocksource_unstable+0x33/0x70
    clocksource_watchdog.cold+0xca/0x1aa
    ? __pfx_clocksource_watchdog+0x10/0x10
    ? __pfx_clocksource_watchdog+0x10/0x10
    call_timer_fn+0x2a/0x120
    __run_timers+0x1f4/0x280
    run_timer_softirq+0x49/0xf0
    handle_softirqs+0xeb/0x2b0
    __irq_exit_rcu+0xc2/0xe0
    sysvec_apic_timer_interrupt+0x71/0x90
    </IRQ>
    <TASK>
    asm_sysvec_apic_timer_interrupt+0x1a/0x20
    RIP: 0010:cpuidle_enter_state+0xc6/0x420
    Code: 00 00 e8 1d 4b 2e ff e8 98 f1 ff ff 49 89 c5 0f 1f 44 00 00 31 ff e8 19 dd 2c ff 45 84 ff 0f 85 40 02 00 00 fb 0f 1f 44 00 00 <45> 85 f6 0f 88 84 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
    RSP: 0018:ffffa6bec01c7e80 EFLAGS: 00000246
    RAX: ffff98ad5eb80000 RBX: 0000000000000003 RCX: 0000000000000000
    RDX: 000000007ec21a6e RSI: fffffffd76e37cf8 RDI: 0000000000000000
    RBP: ffff98aa80ffe800 R08: 0000000000000002 R09: 0000000000000000
    R10: 0000000000000000 R11: 000000000000ffff R12: ffffffffb1fca360
    R13: 000000007ec21a6e R14: 0000000000000003 R15: 0000000000000000
    cpuidle_enter+0x2d/0x40
    do_idle+0x1ad/0x210
    cpu_startup_entry+0x29/0x30
    start_secondary+0x11e/0x140
    common_startup_64+0x13e/0x141
    </TASK>
    ---[ end trace 0000000000000000 ]---

Cheers,
Chris

--ehb65j4gtm3i6hrc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.log"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Linux version 6.14.0-rc4-1.2-mainline-dirty (linux-mainline@=
archlinux) (gcc (GCC) 14.2.1 20250207, GNU ld (GNU Binutils) 2.44) #1 SMP P=
REEMPT_DYNAMIC Mon, 24 Feb 2025 13:26:40 +0000
[    0.000000] Command line: initrd=3D\initramfs-linux-mainline.img cryptde=
vice=3DUUID=3D8913bf3e-3df0-478e-b072-f7bec731154b:archlinux root=3D/dev/ma=
pper/archlinux rootflags=3Dsubvol=3D@ rw loglevel=3D10
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009bfffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000009c00000-0x0000000009da0fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000009da1000-0x0000000009efffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000009f00000-0x0000000009f0efff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x0000000009f0f000-0x00000000c4b7dfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000c4b7e000-0x00000000cad7dfff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000cad7e000-0x00000000cc17dfff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x00000000cc17e000-0x00000000cc1fdfff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x00000000cc1fe000-0x00000000cdffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000ce000000-0x00000000cfffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fdc00000-0x00000000fdcfffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed80fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000003ee2fffff] usable
[    0.000000] BIOS-e820: [mem 0x00000003ee300000-0x000000042fffffff] reser=
ved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] e820: update [mem 0x98dc3018-0x98dd0857] usable =3D=3D> usab=
le
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009ef=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000000009f000-0x000000000009ff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000000e0000-0x00000000000fff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x0000000009bfff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x0000000009c00000-0x0000000009da0f=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000009da1000-0x0000000009efff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x0000000009f00000-0x0000000009f0ef=
ff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x0000000009f0f000-0x0000000098dc30=
17] usable
[    0.000000] reserve setup_data: [mem 0x0000000098dc3018-0x0000000098dd08=
57] usable
[    0.000000] reserve setup_data: [mem 0x0000000098dd0858-0x00000000c4b7df=
ff] usable
[    0.000000] reserve setup_data: [mem 0x00000000c4b7e000-0x00000000cad7df=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000cad7e000-0x00000000cc17df=
ff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x00000000cc17e000-0x00000000cc1fdf=
ff] ACPI data
[    0.000000] reserve setup_data: [mem 0x00000000cc1fe000-0x00000000cdffff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x00000000ce000000-0x00000000cfffff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000f8000000-0x00000000fbffff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fdc00000-0x00000000fdcfff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed80000-0x00000000fed80f=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x00000003ee2fff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x00000003ee300000-0x000000042fffff=
ff] reserved
[    0.000000] efi: EFI v2.7 by Lenovo
[    0.000000] efi: ACPI=3D0xcc1fd000 ACPI 2.0=3D0xcc1fd014 SMBIOS=3D0xc7c6=
8000 SMBIOS 3.0=3D0xc7c5b000 TPMFinalLog=3D0xcb01e000 MEMATTR=3D0xc15be018 =
ESRT=3D0xc323a018 RNG=3D0xcc1fcf18 INITRD=3D0x99b7bc98 TPMEventLog=3D0xcc1f=
1018=20
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem62: MMIO range=3D[0xfdc00000-0xfdcfffff] (1MB=
) from e820 map
[    0.000000] e820: remove [mem 0xfdc00000-0xfdcfffff] reserved
[    0.000000] efi: Not removing mem63: MMIO range=3D[0xfed80000-0xfed80fff=
] (4KB) from e820 map
[    0.000000] SMBIOS 3.3.0 present.
[    0.000000] DMI: LENOVO 20YDS00G00/20YDS00G00, BIOS R1OET26W (1.05 ) 04/=
28/2021
[    0.000000] DMI: Memory slots populated: 2/2
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2095.984 MHz processor
[    0.000011] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000013] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000019] last_pfn =3D 0x3ee300 max_arch_pfn =3D 0x400000000
[    0.000026] MTRR map: 6 entries (3 fixed + 3 variable; max 20), built fr=
om 9 variable MTRRs
[    0.000027] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.000330] last_pfn =3D 0xce000 max_arch_pfn =3D 0x400000000
[    0.004077] esrt: Reserving ESRT space from 0x00000000c323a018 to 0x0000=
0000c323a0c8.
[    0.004084] e820: update [mem 0xc323a000-0xc323afff] usable =3D=3D> rese=
rved
[    0.004100] Using GB pages for direct mapping
[    0.004685] Secure boot disabled
[    0.004686] RAMDISK: [mem 0x90ffa000-0x940bcfff]
[    0.004946] ACPI: Early table checksum verification disabled
[    0.004949] ACPI: RSDP 0x00000000CC1FD014 000024 (v02 LENOVO)
[    0.004952] ACPI: XSDT 0x00000000CC1FB188 0000FC (v01 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.004957] ACPI: FACP 0x00000000C5997000 000114 (v06 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.004961] ACPI: DSDT 0x00000000C5982000 00F37E (v01 LENOVO TP-R1O   00=
001050 INTL 20180313)
[    0.004963] ACPI: FACS 0x00000000CB01A000 000040
[    0.004965] ACPI: SSDT 0x00000000C7C9B000 00094D (v01 LENOVO UsbCTabl 00=
000001 INTL 20180313)
[    0.004967] ACPI: SSDT 0x00000000C7C8E000 007229 (v02 LENOVO TP-R1O   00=
000002 MSFT 04000000)
[    0.004969] ACPI: IVRS 0x00000000C7C8D000 0001A4 (v02 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.004971] ACPI: SSDT 0x00000000C7C3B000 000924 (v01 LENOVO WmiTable 00=
000001 INTL 20180313)
[    0.004973] ACPI: SSDT 0x00000000C7BB6000 000632 (v02 LENOVO Tpm2Tabl 00=
001000 INTL 20180313)
[    0.004975] ACPI: TPM2 0x00000000C7BB5000 000034 (v03 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.004977] ACPI: POAT 0x00000000C7BB2000 000055 (v03 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.004979] ACPI: BATB 0x00000000C7B9D000 00004A (v02 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.004980] ACPI: HPET 0x00000000C5996000 000038 (v01 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.004982] ACPI: APIC 0x00000000C5995000 000138 (v02 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.004984] ACPI: MCFG 0x00000000C5994000 00003C (v01 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.004986] ACPI: SBST 0x00000000C5993000 000030 (v01 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.004988] ACPI: WSMT 0x00000000C5992000 000028 (v01 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.004990] ACPI: VFCT 0x00000000C5974000 00D884 (v01 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.004992] ACPI: SSDT 0x00000000C5970000 003E88 (v02 LENOVO TP-R1O   00=
000001 AMD  00000001)
[    0.004994] ACPI: CRAT 0x00000000C596F000 000B80 (v01 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.004996] ACPI: CDIT 0x00000000C596E000 000029 (v01 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.004998] ACPI: FPDT 0x00000000C7B9E000 000034 (v01 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.005000] ACPI: SSDT 0x00000000C596C000 000149 (v01 LENOVO TP-R1O   00=
000001 INTL 20180313)
[    0.005001] ACPI: SSDT 0x00000000C596A000 0014C3 (v01 LENOVO TP-R1O   00=
000001 INTL 20180313)
[    0.005003] ACPI: SSDT 0x00000000C5968000 0015A8 (v01 LENOVO TP-R1O   00=
000001 INTL 20180313)
[    0.005005] ACPI: SSDT 0x00000000C5964000 003979 (v01 LENOVO TP-R1O   00=
000001 INTL 20180313)
[    0.005007] ACPI: BGRT 0x00000000C5963000 000038 (v01 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.005009] ACPI: UEFI 0x00000000CB019000 0000B2 (v01 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.005011] ACPI: SSDT 0x00000000C7C9A000 000090 (v01 LENOVO TP-R1O   00=
000001 INTL 20180313)
[    0.005013] ACPI: SSDT 0x00000000C7C99000 0009BD (v01 LENOVO TP-R1O   00=
000001 INTL 20180313)
[    0.005014] ACPI: Reserving FACP table memory at [mem 0xc5997000-0xc5997=
113]
[    0.005015] ACPI: Reserving DSDT table memory at [mem 0xc5982000-0xc5991=
37d]
[    0.005016] ACPI: Reserving FACS table memory at [mem 0xcb01a000-0xcb01a=
03f]
[    0.005017] ACPI: Reserving SSDT table memory at [mem 0xc7c9b000-0xc7c9b=
94c]
[    0.005017] ACPI: Reserving SSDT table memory at [mem 0xc7c8e000-0xc7c95=
228]
[    0.005018] ACPI: Reserving IVRS table memory at [mem 0xc7c8d000-0xc7c8d=
1a3]
[    0.005018] ACPI: Reserving SSDT table memory at [mem 0xc7c3b000-0xc7c3b=
923]
[    0.005019] ACPI: Reserving SSDT table memory at [mem 0xc7bb6000-0xc7bb6=
631]
[    0.005019] ACPI: Reserving TPM2 table memory at [mem 0xc7bb5000-0xc7bb5=
033]
[    0.005020] ACPI: Reserving POAT table memory at [mem 0xc7bb2000-0xc7bb2=
054]
[    0.005020] ACPI: Reserving BATB table memory at [mem 0xc7b9d000-0xc7b9d=
049]
[    0.005021] ACPI: Reserving HPET table memory at [mem 0xc5996000-0xc5996=
037]
[    0.005021] ACPI: Reserving APIC table memory at [mem 0xc5995000-0xc5995=
137]
[    0.005022] ACPI: Reserving MCFG table memory at [mem 0xc5994000-0xc5994=
03b]
[    0.005023] ACPI: Reserving SBST table memory at [mem 0xc5993000-0xc5993=
02f]
[    0.005023] ACPI: Reserving WSMT table memory at [mem 0xc5992000-0xc5992=
027]
[    0.005024] ACPI: Reserving VFCT table memory at [mem 0xc5974000-0xc5981=
883]
[    0.005024] ACPI: Reserving SSDT table memory at [mem 0xc5970000-0xc5973=
e87]
[    0.005025] ACPI: Reserving CRAT table memory at [mem 0xc596f000-0xc596f=
b7f]
[    0.005025] ACPI: Reserving CDIT table memory at [mem 0xc596e000-0xc596e=
028]
[    0.005026] ACPI: Reserving FPDT table memory at [mem 0xc7b9e000-0xc7b9e=
033]
[    0.005026] ACPI: Reserving SSDT table memory at [mem 0xc596c000-0xc596c=
148]
[    0.005027] ACPI: Reserving SSDT table memory at [mem 0xc596a000-0xc596b=
4c2]
[    0.005028] ACPI: Reserving SSDT table memory at [mem 0xc5968000-0xc5969=
5a7]
[    0.005028] ACPI: Reserving SSDT table memory at [mem 0xc5964000-0xc5967=
978]
[    0.005029] ACPI: Reserving BGRT table memory at [mem 0xc5963000-0xc5963=
037]
[    0.005029] ACPI: Reserving UEFI table memory at [mem 0xcb019000-0xcb019=
0b1]
[    0.005030] ACPI: Reserving SSDT table memory at [mem 0xc7c9a000-0xc7c9a=
08f]
[    0.005031] ACPI: Reserving SSDT table memory at [mem 0xc7c99000-0xc7c99=
9bc]
[    0.005089] No NUMA configuration found
[    0.005090] Faking a node at [mem 0x0000000000000000-0x00000003ee2fffff]
[    0.005096] NODE_DATA(0) allocated [mem 0x3ee2d52c0-0x3ee2fffff]
[    0.005284] Zone ranges:
[    0.005285]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.005286]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.005287]   Normal   [mem 0x0000000100000000-0x00000003ee2fffff]
[    0.005288]   Device   empty
[    0.005289] Movable zone start for each node
[    0.005290] Early memory node ranges
[    0.005291]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.005292]   node   0: [mem 0x0000000000100000-0x0000000009bfffff]
[    0.005293]   node   0: [mem 0x0000000009da1000-0x0000000009efffff]
[    0.005293]   node   0: [mem 0x0000000009f0f000-0x00000000c4b7dfff]
[    0.005294]   node   0: [mem 0x00000000cc1fe000-0x00000000cdffffff]
[    0.005295]   node   0: [mem 0x0000000100000000-0x00000003ee2fffff]
[    0.005297] Initmem setup node 0 [mem 0x0000000000001000-0x00000003ee2ff=
fff]
[    0.005301] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.005318] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.005466] On node 0, zone DMA32: 417 pages in unavailable ranges
[    0.011609] On node 0, zone DMA32: 15 pages in unavailable ranges
[    0.011972] On node 0, zone DMA32: 30336 pages in unavailable ranges
[    0.037144] On node 0, zone Normal: 8192 pages in unavailable ranges
[    0.037224] On node 0, zone Normal: 7424 pages in unavailable ranges
[    0.037619] ACPI: PM-Timer IO Port: 0x408
[    0.037628] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.037630] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.037630] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.037631] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.037631] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.037632] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.037632] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.037633] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.037633] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.037634] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.037634] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.037635] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.037635] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.037636] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.037636] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.037637] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.037650] IOAPIC[0]: apic_id 32, version 33, address 0xfec00000, GSI 0=
-23
[    0.037655] IOAPIC[1]: apic_id 33, version 33, address 0xfec01000, GSI 2=
4-55
[    0.037656] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.037658] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.037661] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.037662] ACPI: HPET id: 0x43538210 base: 0xfed00000
[    0.037673] e820: update [mem 0xc0cdb000-0xc0d6bfff] usable =3D=3D> rese=
rved
[    0.037687] CPU topo: Max. logical packages:   1
[    0.037688] CPU topo: Max. logical dies:       1
[    0.037689] CPU topo: Max. dies per package:   1
[    0.037693] CPU topo: Max. threads per core:   2
[    0.037694] CPU topo: Num. cores per package:     6
[    0.037694] CPU topo: Num. threads per package:  12
[    0.037695] CPU topo: Allowing 12 present CPUs plus 0 hotplug CPUs
[    0.037710] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.037712] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0=
x0009ffff]
[    0.037712] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0=
x000dffff]
[    0.037713] PM: hibernation: Registered nosave memory: [mem 0x000e0000-0=
x000fffff]
[    0.037714] PM: hibernation: Registered nosave memory: [mem 0x09c00000-0=
x09da0fff]
[    0.037715] PM: hibernation: Registered nosave memory: [mem 0x09f00000-0=
x09f0efff]
[    0.037716] PM: hibernation: Registered nosave memory: [mem 0x98dc3000-0=
x98dc3fff]
[    0.037718] PM: hibernation: Registered nosave memory: [mem 0x98dd0000-0=
x98dd0fff]
[    0.037719] PM: hibernation: Registered nosave memory: [mem 0xc0cdb000-0=
xc0d6bfff]
[    0.037720] PM: hibernation: Registered nosave memory: [mem 0xc323a000-0=
xc323afff]
[    0.037721] PM: hibernation: Registered nosave memory: [mem 0xc4b7e000-0=
xcad7dfff]
[    0.037722] PM: hibernation: Registered nosave memory: [mem 0xcad7e000-0=
xcc17dfff]
[    0.037722] PM: hibernation: Registered nosave memory: [mem 0xcc17e000-0=
xcc1fdfff]
[    0.037723] PM: hibernation: Registered nosave memory: [mem 0xce000000-0=
xcfffffff]
[    0.037724] PM: hibernation: Registered nosave memory: [mem 0xd0000000-0=
xf7ffffff]
[    0.037724] PM: hibernation: Registered nosave memory: [mem 0xf8000000-0=
xfbffffff]
[    0.037725] PM: hibernation: Registered nosave memory: [mem 0xfc000000-0=
xfed7ffff]
[    0.037725] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0=
xfed80fff]
[    0.037726] PM: hibernation: Registered nosave memory: [mem 0xfed81000-0=
xffffffff]
[    0.037727] [mem 0xd0000000-0xf7ffffff] available for PCI devices
[    0.037728] Booting paravirtualized kernel on bare hardware
[    0.037730] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 1910969940391419 ns
[    0.042349] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:12 nr_cpu_ids:12 =
nr_node_ids:1
[    0.043368] percpu: Embedded 67 pages/cpu s237568 r8192 d28672 u524288
[    0.043377] pcpu-alloc: s237568 r8192 d28672 u524288 alloc=3D1*2097152
[    0.043379] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07=20
[    0.043382] pcpu-alloc: [0] 08 09 10 11=20
[    0.043398] Kernel command line: initrd=3D\initramfs-linux-mainline.img =
cryptdevice=3DUUID=3D8913bf3e-3df0-478e-b072-f7bec731154b:archlinux root=3D=
/dev/mapper/archlinux rootflags=3Dsubvol=3D@ rw loglevel=3D10
[    0.043459] Unknown kernel command line parameters "cryptdevice=3DUUID=
=3D8913bf3e-3df0-478e-b072-f7bec731154b:archlinux", will be passed to user =
space.
[    0.043479] printk: log buffer data + meta data: 131072 + 458752 =3D 589=
824 bytes
[    0.045594] Dentry cache hash table entries: 2097152 (order: 12, 1677721=
6 bytes, linear)
[    0.046655] Inode-cache hash table entries: 1048576 (order: 11, 8388608 =
bytes, linear)
[    0.046744] Fallback order for Node 0: 0=20
[    0.046750] Built 1 zonelists, mobility grouping on.  Total pages: 38856=
78
[    0.046751] Policy zone: Normal
[    0.047068] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.047112] software IO TLB: area num 16.
[    0.098495] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D12, =
Nodes=3D1
[    0.098554] ftrace: allocating 51850 entries in 203 pages
[    0.113924] ftrace: allocated 203 pages with 5 groups
[    0.114024] Dynamic Preempt: full
[    0.114077] rcu: Preemptible hierarchical RCU implementation.
[    0.114078] rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=
=3D12.
[    0.114079] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.114080] 	Trampoline variant of Tasks RCU enabled.
[    0.114080] 	Rude variant of Tasks RCU enabled.
[    0.114080] 	Tracing variant of Tasks RCU enabled.
[    0.114081] rcu: RCU calculated value of scheduler-enlistment delay is 1=
00 jiffies.
[    0.114081] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D12
[    0.114093] RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adjus=
t=3D1 rcu_task_cpu_ids=3D12.
[    0.114095] RCU Tasks Rude: Setting shift to 4 and lim to 1 rcu_task_cb_=
adjust=3D1 rcu_task_cpu_ids=3D12.
[    0.114097] RCU Tasks Trace: Setting shift to 4 and lim to 1 rcu_task_cb=
_adjust=3D1 rcu_task_cpu_ids=3D12.
[    0.118055] NR_IRQS: 524544, nr_irqs: 1064, preallocated irqs: 16
[    0.118262] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.118368] kfence: initialized - using 2097152 bytes for 255 objects at=
 0x(____ptrval____)-0x(____ptrval____)
[    0.118398] Console: colour dummy device 80x25
[    0.118401] printk: legacy console [tty0] enabled
[    0.118748] ACPI: Core revision 20240827
[    0.118907] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 133484873504 ns
[    0.118928] APIC: Switch to symmetric I/O mode setup
[    0.119551] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR0, rdevid:0xa0
[    0.119554] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR1, rdevid:0xa0
[    0.119557] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR2, rdevid:0xa0
[    0.119561] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR3, rdevid:0xa0
[    0.119563] AMD-Vi: Using global IVHD EFR:0x206d73ef22254ade, EFR2:0x0
[    0.120661] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.124942] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x1e365ec32fc, max_idle_ns: 440795244491 ns
[    0.124949] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 4191.96 BogoMIPS (lpj=3D2095984)
[    0.124973] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.125026] LVT offset 1 assigned for vector 0xf9
[    0.125135] LVT offset 2 assigned for vector 0xf4
[    0.125162] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
[    0.125165] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 1GB 0
[    0.125169] process: using mwait in idle threads
[    0.125173] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    0.125177] Spectre V2 : Mitigation: Retpolines
[    0.125178] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    0.125181] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    0.125183] Spectre V2 : Enabling Speculation Barrier for firmware calls
[    0.125184] RETBleed: Mitigation: untrained return thunk
[    0.125187] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    0.125190] Spectre V2 : Selecting STIBP always-on mode to complement re=
tbleed mitigation
[    0.125192] Spectre V2 : User space: Mitigation: STIBP always-on protect=
ion
[    0.125195] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl
[    0.125198] Speculative Return Stack Overflow: Mitigation: Safe RET
[    0.125205] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.125207] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.125209] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.125212] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.125214] x86/fpu: Enabled xstate features 0x7, context size is 832 by=
tes, using 'compacted' format.
[    0.151877] Freeing SMP alternatives memory: 44K
[    0.151889] pid_max: default: 32768 minimum: 301
[    0.154850] LSM: initializing lsm=3Dcapability,landlock,lockdown,yama,bpf
[    0.154940] landlock: Up and running.
[    0.154949] Yama: becoming mindful.
[    0.155187] LSM support for eBPF active
[    0.155239] Mount-cache hash table entries: 32768 (order: 6, 262144 byte=
s, linear)
[    0.155265] Mountpoint-cache hash table entries: 32768 (order: 6, 262144=
 bytes, linear)
[    0.258431] smpboot: CPU0: AMD Ryzen 5 5500U with Radeon Graphics (famil=
y: 0x17, model: 0x68, stepping: 0x1)
[    0.258733] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
[    0.258745] ... version:                0
[    0.258749] ... bit width:              48
[    0.258753] ... generic registers:      6
[    0.258757] ... value mask:             0000ffffffffffff
[    0.258761] ... max period:             00007fffffffffff
[    0.258765] ... fixed-purpose events:   0
[    0.258769] ... event mask:             000000000000003f
[    0.258889] signal: max sigframe size: 1776
[    0.258947] rcu: Hierarchical SRCU implementation.
[    0.258947] rcu: 	Max phase no-delay instances is 400.
[    0.258947] Timer migration: 2 hierarchy levels; 8 children per group; 2=
 crossnode level
[    0.264102] MCE: In-kernel MCE decoding enabled.
[    0.264156] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.264271] smp: Bringing up secondary CPUs ...
[    0.264387] smpboot: x86: Booting SMP configuration:
[    0.264392] .... node  #0, CPUs:        #2  #4  #6  #8 #10  #1  #3  #5  =
#7  #9 #11
[    0.275078] Spectre V2 : Update user space SMT mitigation: STIBP always-=
on
[    0.280991] smp: Brought up 1 node, 12 CPUs
[    0.280991] smpboot: Total of 12 processors activated (50303.61 BogoMIPS)
[    0.282117] Memory: 15079888K/15542712K available (17375K kernel code, 2=
683K rwdata, 14500K rodata, 4324K init, 3912K bss, 444964K reserved, 0K cma=
-reserved)
[    0.283168] devtmpfs: initialized
[    0.283168] x86/mm: Memory block size: 128MB
[    0.285237] ACPI: PM: Registering ACPI NVS region [mem 0x09f00000-0x09f0=
efff] (61440 bytes)
[    0.285237] ACPI: PM: Registering ACPI NVS region [mem 0xcad7e000-0xcc17=
dfff] (20971520 bytes)
[    0.285302] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 1911260446275000 ns
[    0.285325] futex hash table entries: 4096 (order: 6, 262144 bytes, line=
ar)
[    0.285406] pinctrl core: initialized pinctrl subsystem
[    0.285500] PM: RTC time: 13:40:03, date: 2025-02-24
[    0.286401] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.286792] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic alloca=
tions
[    0.287048] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations
[    0.287289] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations
[    0.287311] audit: initializing netlink subsys (disabled)
[    0.287337] audit: type=3D2000 audit(1740404402.168:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.287337] thermal_sys: Registered thermal governor 'fair_share'
[    0.287337] thermal_sys: Registered thermal governor 'bang_bang'
[    0.287337] thermal_sys: Registered thermal governor 'step_wise'
[    0.287337] thermal_sys: Registered thermal governor 'user_space'
[    0.287337] thermal_sys: Registered thermal governor 'power_allocator'
[    0.287337] cpuidle: using governor ladder
[    0.287337] cpuidle: using governor menu
[    0.287337] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it
[    0.287337] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.288039] PCI: ECAM [mem 0xf8000000-0xfbffffff] (base 0xf8000000) for =
domain 0000 [bus 00-3f]
[    0.288059] PCI: Using configuration type 1 for base access
[    0.288244] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.
[    0.288257] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.288257] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.288257] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.288257] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.289046] fbcon: Taking over console
[    0.289081] ACPI: Added _OSI(Module Device)
[    0.289085] ACPI: Added _OSI(Processor Device)
[    0.289090] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.289094] ACPI: Added _OSI(Processor Aggregator Device)
[    0.318023] ACPI: 12 ACPI AML tables successfully acquired and loaded
[    0.320994] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.340700] ACPI: EC: EC started
[    0.340705] ACPI: EC: interrupt blocked
[    0.341554] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.341560] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC used to handle tran=
sactions
[    0.341566] ACPI: Interpreter enabled
[    0.341589] ACPI: PM: (supports S0 S3 S4 S5)
[    0.341593] ACPI: Using IOAPIC for interrupt routing
[    0.343316] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.343324] PCI: Using E820 reservations for host bridge windows
[    0.345871] ACPI: \_SB_.PCI0.GPP5.PXSX.WRST: New power resource
[    0.354038] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.354051] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI EDR HPX-Type3]
[    0.354204] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplu=
g LTR DPC]
[    0.354477] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER =
PCIeCapability]
[    0.354483] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    0.354500] acpi PNP0A08:00: [Firmware Info]: ECAM [mem 0xf8000000-0xfbf=
fffff] for domain 0000 [bus 00-3f] only partially covers this bridge
[    0.354967] PCI host bridge to bus 0000:00
[    0.354977] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000efff=
f window]
[    0.354984] pci_bus 0000:00: root bus resource [mem 0xd0000000-0xf7fffff=
f window]
[    0.354991] pci_bus 0000:00: root bus resource [mem 0xfc000000-0xfdfffff=
f window]
[    0.354997] pci_bus 0000:00: root bus resource [mem 0x430000000-0xffffff=
ffff window]
[    0.355003] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.355009] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.355015] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.355032] pci 0000:00:00.0: [1022:1630] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.355131] pci 0000:00:00.2: [1022:1631] type 00 class 0x080600 convent=
ional PCI endpoint
[    0.355217] pci 0000:00:01.0: [1022:1632] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.355333] pci 0000:00:02.0: [1022:1632] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.355434] pci 0000:00:02.1: [1022:1634] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.355453] pci 0000:00:02.1: PCI bridge to [bus 01]
[    0.355462] pci 0000:00:02.1:   bridge window [mem 0xfd600000-0xfd6fffff]
[    0.355512] pci 0000:00:02.1: PME# supported from D0 D3hot D3cold
[    0.355635] pci 0000:00:02.2: [1022:1634] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.355654] pci 0000:00:02.2: PCI bridge to [bus 02]
[    0.355661] pci 0000:00:02.2:   bridge window [io  0x3000-0x3fff]
[    0.355668] pci 0000:00:02.2:   bridge window [mem 0xfd500000-0xfd5fffff]
[    0.355717] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
[    0.355836] pci 0000:00:02.3: [1022:1634] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.355854] pci 0000:00:02.3: PCI bridge to [bus 03]
[    0.355862] pci 0000:00:02.3:   bridge window [io  0x2000-0x2fff]
[    0.355868] pci 0000:00:02.3:   bridge window [mem 0xfd400000-0xfd4fffff]
[    0.355918] pci 0000:00:02.3: PME# supported from D0 D3hot D3cold
[    0.356043] pci 0000:00:08.0: [1022:1632] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.356146] pci 0000:00:08.1: [1022:1635] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.356164] pci 0000:00:08.1: PCI bridge to [bus 04]
[    0.356171] pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]
[    0.356178] pci 0000:00:08.1:   bridge window [mem 0xfd000000-0xfd3fffff]
[    0.356187] pci 0000:00:08.1:   bridge window [mem 0x460000000-0x4701fff=
ff 64bit pref]
[    0.356198] pci 0000:00:08.1: enabling Extended Tags
[    0.356236] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.356392] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500 convent=
ional PCI endpoint
[    0.356522] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100 convent=
ional PCI endpoint
[    0.356696] pci 0000:00:18.0: [1022:1448] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.356775] pci 0000:00:18.1: [1022:1449] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.356851] pci 0000:00:18.2: [1022:144a] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.356930] pci 0000:00:18.3: [1022:144b] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.357011] pci 0000:00:18.4: [1022:144c] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.357097] pci 0000:00:18.5: [1022:144d] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.357173] pci 0000:00:18.6: [1022:144e] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.357251] pci 0000:00:18.7: [1022:144f] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.357558] pci 0000:01:00.0: [144d:a809] type 00 class 0x010802 PCIe En=
dpoint
[    0.357599] pci 0000:01:00.0: BAR 0 [mem 0xfd600000-0xfd603fff 64bit]
[    0.358029] pci 0000:00:02.1: PCI bridge to [bus 01]
[    0.358097] pci 0000:02:00.0: [10ec:8168] type 00 class 0x020000 PCIe En=
dpoint
[    0.358148] pci 0000:02:00.0: BAR 0 [io  0x3000-0x30ff]
[    0.358157] pci 0000:02:00.0: BAR 2 [mem 0xfd504000-0xfd504fff 64bit]
[    0.358165] pci 0000:02:00.0: BAR 4 [mem 0xfd500000-0xfd503fff 64bit]
[    0.358260] pci 0000:02:00.0: supports D1 D2
[    0.358265] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.358491] pci 0000:00:02.2: PCI bridge to [bus 02]
[    0.358592] pci 0000:03:00.0: [10ec:c822] type 00 class 0x028000 PCIe En=
dpoint
[    0.358656] pci 0000:03:00.0: BAR 0 [io  0x2000-0x20ff]
[    0.358666] pci 0000:03:00.0: BAR 2 [mem 0xfd400000-0xfd40ffff 64bit]
[    0.358789] pci 0000:03:00.0: supports D1 D2
[    0.358794] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.359063] pci 0000:00:02.3: PCI bridge to [bus 03]
[    0.359161] pci 0000:04:00.0: [1002:164c] type 00 class 0x030000 PCIe Le=
gacy Endpoint
[    0.359190] pci 0000:04:00.0: BAR 0 [mem 0x460000000-0x46fffffff 64bit p=
ref]
[    0.359197] pci 0000:04:00.0: BAR 2 [mem 0x470000000-0x4701fffff 64bit p=
ref]
[    0.359203] pci 0000:04:00.0: BAR 4 [io  0x1000-0x10ff]
[    0.359209] pci 0000:04:00.0: BAR 5 [mem 0xfd300000-0xfd37ffff]
[    0.359218] pci 0000:04:00.0: enabling Extended Tags
[    0.359274] pci 0000:04:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.359419] pci 0000:04:00.1: [1002:1637] type 00 class 0x040300 PCIe Le=
gacy Endpoint
[    0.359446] pci 0000:04:00.1: BAR 0 [mem 0xfd3c8000-0xfd3cbfff]
[    0.359458] pci 0000:04:00.1: enabling Extended Tags
[    0.359492] pci 0000:04:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.359587] pci 0000:04:00.2: [1022:15df] type 00 class 0x108000 PCIe En=
dpoint
[    0.359615] pci 0000:04:00.2: BAR 2 [mem 0xfd200000-0xfd2fffff]
[    0.359622] pci 0000:04:00.2: BAR 5 [mem 0xfd3cc000-0xfd3cdfff]
[    0.359631] pci 0000:04:00.2: enabling Extended Tags
[    0.359749] pci 0000:04:00.3: [1022:1639] type 00 class 0x0c0330 PCIe En=
dpoint
[    0.359776] pci 0000:04:00.3: BAR 0 [mem 0xfd000000-0xfd0fffff 64bit]
[    0.359788] pci 0000:04:00.3: enabling Extended Tags
[    0.359824] pci 0000:04:00.3: PME# supported from D0 D3hot D3cold
[    0.359924] pci 0000:04:00.4: [1022:1639] type 00 class 0x0c0330 PCIe En=
dpoint
[    0.359954] pci 0000:04:00.4: BAR 0 [mem 0xfd100000-0xfd1fffff 64bit]
[    0.359966] pci 0000:04:00.4: enabling Extended Tags
[    0.360002] pci 0000:04:00.4: PME# supported from D0 D3hot D3cold
[    0.360106] pci 0000:04:00.5: [1022:15e2] type 00 class 0x048000 PCIe En=
dpoint
[    0.360133] pci 0000:04:00.5: BAR 0 [mem 0xfd380000-0xfd3bffff]
[    0.360145] pci 0000:04:00.5: enabling Extended Tags
[    0.360179] pci 0000:04:00.5: PME# supported from D0 D3hot D3cold
[    0.360270] pci 0000:04:00.6: [1022:15e3] type 00 class 0x040300 PCIe En=
dpoint
[    0.360296] pci 0000:04:00.6: BAR 0 [mem 0xfd3c0000-0xfd3c7fff]
[    0.360308] pci 0000:04:00.6: enabling Extended Tags
[    0.360342] pci 0000:04:00.6: PME# supported from D0 D3hot D3cold
[    0.360459] pci 0000:00:08.1: PCI bridge to [bus 04]
[    0.360856] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.360965] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.361044] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.361145] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.361238] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.361311] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.361384] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.361457] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.362953] ACPI: EC: interrupt unblocked
[    0.362958] ACPI: EC: event unblocked
[    0.362964] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.362968] ACPI: EC: GPE=3D0x3
[    0.362972] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC initialization comp=
lete
[    0.362978] ACPI: \_SB_.PCI0.LPC0.EC0_: EC: Used to handle transactions =
and events
[    0.363085] iommu: Default domain type: Translated
[    0.363085] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.363148] SCSI subsystem initialized
[    0.363160] libata version 3.00 loaded.
[    0.363160] ACPI: bus type USB registered
[    0.363160] usbcore: registered new interface driver usbfs
[    0.363160] usbcore: registered new interface driver hub
[    0.363160] usbcore: registered new device driver usb
[    0.363160] EDAC MC: Ver: 3.0.0
[    0.364072] efivars: Registered efivars operations
[    0.364225] NetLabel: Initializing
[    0.364230] NetLabel:  domain hash size =3D 128
[    0.364234] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.364258] NetLabel:  unlabeled traffic allowed by default
[    0.364268] mctp: management component transport protocol core
[    0.364272] NET: Registered PF_MCTP protocol family
[    0.364288] PCI: Using ACPI for IRQ routing
[    0.366385] PCI: pci_cache_line_size set to 64 bytes
[    0.366598] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.366603] e820: reserve RAM buffer [mem 0x09c00000-0x0bffffff]
[    0.366608] e820: reserve RAM buffer [mem 0x09f00000-0x0bffffff]
[    0.366613] e820: reserve RAM buffer [mem 0x98dc3018-0x9bffffff]
[    0.366618] e820: reserve RAM buffer [mem 0xc0cdb000-0xc3ffffff]
[    0.366623] e820: reserve RAM buffer [mem 0xc323a000-0xc3ffffff]
[    0.366627] e820: reserve RAM buffer [mem 0xc4b7e000-0xc7ffffff]
[    0.366632] e820: reserve RAM buffer [mem 0xce000000-0xcfffffff]
[    0.366637] e820: reserve RAM buffer [mem 0x3ee300000-0x3efffffff]
[    0.366976] pci 0000:04:00.0: vgaarb: setting as boot VGA device
[    0.366976] pci 0000:04:00.0: vgaarb: bridge control possible
[    0.366976] pci 0000:04:00.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dnone,locks=3Dnone
[    0.366982] vgaarb: loaded
[    0.367021] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.367030] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.369013] clocksource: Switched to clocksource tsc-early
[    0.369147] VFS: Disk quotas dquot_6.6.0
[    0.369159] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.369247] pnp: PnP ACPI init
[    0.369478] system 00:00: [mem 0xfec00000-0xfec01fff] could not be reser=
ved
[    0.369487] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.369493] system 00:00: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.369804] system 00:02: [io  0x0400-0x04cf] has been reserved
[    0.369810] system 00:02: [io  0x04d0-0x04d1] has been reserved
[    0.369816] system 00:02: [io  0x04d6] has been reserved
[    0.369824] system 00:02: [io  0x0c00-0x0c01] has been reserved
[    0.369830] system 00:02: [io  0x0c14] has been reserved
[    0.369835] system 00:02: [io  0x0c50-0x0c52] has been reserved
[    0.369840] system 00:02: [io  0x0c6c] has been reserved
[    0.369845] system 00:02: [io  0x0c6f] has been reserved
[    0.369850] system 00:02: [io  0x0cd0-0x0cdb] has been reserved
[    0.369964] system 00:03: [mem 0x000e0000-0x000fffff] could not be reser=
ved
[    0.369971] system 00:03: [mem 0x00000000-0x01ffffff] could not be reser=
ved
[    0.369977] system 00:03: [mem 0xfec10000-0xfec1001f] has been reserved
[    0.369983] system 00:03: [mem 0xfed00000-0xfed003ff] has been reserved
[    0.369989] system 00:03: [mem 0xfed61000-0xfed613ff] has been reserved
[    0.369995] system 00:03: [mem 0xfed80000-0xfed80fff] has been reserved
[    0.370406] pnp: PnP ACPI: found 6 devices
[    0.376740] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.376936] NET: Registered PF_INET protocol family
[    0.377226] IP idents hash table entries: 262144 (order: 9, 2097152 byte=
s, linear)
[    0.393578] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5,=
 131072 bytes, linear)
[    0.393624] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
[    0.393719] TCP established hash table entries: 131072 (order: 8, 104857=
6 bytes, linear)
[    0.394109] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes,=
 linear)
[    0.394385] TCP: Hash tables configured (established 131072 bind 65536)
[    0.394654] MPTCP token hash table entries: 16384 (order: 6, 393216 byte=
s, linear)
[    0.394796] UDP hash table entries: 8192 (order: 7, 524288 bytes, linear)
[    0.394960] UDP-Lite hash table entries: 8192 (order: 7, 524288 bytes, l=
inear)
[    0.395175] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.395216] NET: Registered PF_XDP protocol family
[    0.395244] pci 0000:00:02.3: bridge window [mem 0x00100000-0x000fffff 6=
4bit pref] to [bus 03] add_size 200000 add_align 100000
[    0.395287] pci 0000:00:02.3: bridge window [mem 0x430000000-0x4301fffff=
 64bit pref]: assigned
[    0.395311] pci 0000:00:02.1: PCI bridge to [bus 01]
[    0.395330] pci 0000:00:02.1:   bridge window [mem 0xfd600000-0xfd6fffff]
[    0.395352] pci 0000:00:02.2: PCI bridge to [bus 02]
[    0.395368] pci 0000:00:02.2:   bridge window [io  0x3000-0x3fff]
[    0.395386] pci 0000:00:02.2:   bridge window [mem 0xfd500000-0xfd5fffff]
[    0.395408] pci 0000:00:02.3: PCI bridge to [bus 03]
[    0.395423] pci 0000:00:02.3:   bridge window [io  0x2000-0x2fff]
[    0.395441] pci 0000:00:02.3:   bridge window [mem 0xfd400000-0xfd4fffff]
[    0.395458] pci 0000:00:02.3:   bridge window [mem 0x430000000-0x4301fff=
ff 64bit pref]
[    0.395486] pci 0000:00:08.1: PCI bridge to [bus 04]
[    0.395500] pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]
[    0.395518] pci 0000:00:08.1:   bridge window [mem 0xfd000000-0xfd3fffff]
[    0.395535] pci 0000:00:08.1:   bridge window [mem 0x460000000-0x4701fff=
ff 64bit pref]
[    0.395560] pci_bus 0000:00: resource 4 [mem 0x000a0000-0x000effff windo=
w]
[    0.395578] pci_bus 0000:00: resource 5 [mem 0xd0000000-0xf7ffffff windo=
w]
[    0.395594] pci_bus 0000:00: resource 6 [mem 0xfc000000-0xfdffffff windo=
w]
[    0.395610] pci_bus 0000:00: resource 7 [mem 0x430000000-0xffffffffff wi=
ndow]
[    0.395627] pci_bus 0000:00: resource 8 [io  0x0000-0x0cf7 window]
[    0.395642] pci_bus 0000:00: resource 9 [io  0x0d00-0xffff window]
[    0.395658] pci_bus 0000:01: resource 1 [mem 0xfd600000-0xfd6fffff]
[    0.395674] pci_bus 0000:02: resource 0 [io  0x3000-0x3fff]
[    0.395689] pci_bus 0000:02: resource 1 [mem 0xfd500000-0xfd5fffff]
[    0.395705] pci_bus 0000:03: resource 0 [io  0x2000-0x2fff]
[    0.395719] pci_bus 0000:03: resource 1 [mem 0xfd400000-0xfd4fffff]
[    0.395734] pci_bus 0000:03: resource 2 [mem 0x430000000-0x4301fffff 64b=
it pref]
[    0.395753] pci_bus 0000:04: resource 0 [io  0x1000-0x1fff]
[    0.395767] pci_bus 0000:04: resource 1 [mem 0xfd000000-0xfd3fffff]
[    0.395783] pci_bus 0000:04: resource 2 [mem 0x460000000-0x4701fffff 64b=
it pref]
[    0.396350] pci 0000:04:00.1: D0 power state depends on 0000:04:00.0
[    0.396372] pci 0000:04:00.3: extending delay after power-on from D3hot =
to 20 msec
[    0.396780] pci 0000:04:00.4: extending delay after power-on from D3hot =
to 20 msec
[    0.396918] PCI: CLS 32 bytes, default 64
[    0.396947] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters support=
ed
[    0.397034] Trying to unpack rootfs image as initramfs...
[    0.397046] pci 0000:00:00.0: Adding to iommu group 0
[    0.397073] pci 0000:00:01.0: Adding to iommu group 1
[    0.397105] pci 0000:00:02.0: Adding to iommu group 2
[    0.397128] pci 0000:00:02.1: Adding to iommu group 3
[    0.397149] pci 0000:00:02.2: Adding to iommu group 4
[    0.397171] pci 0000:00:02.3: Adding to iommu group 5
[    0.397209] pci 0000:00:08.0: Adding to iommu group 6
[    0.397230] pci 0000:00:08.1: Adding to iommu group 6
[    0.397265] pci 0000:00:14.0: Adding to iommu group 7
[    0.397285] pci 0000:00:14.3: Adding to iommu group 7
[    0.397364] pci 0000:00:18.0: Adding to iommu group 8
[    0.397386] pci 0000:00:18.1: Adding to iommu group 8
[    0.397411] pci 0000:00:18.2: Adding to iommu group 8
[    0.397432] pci 0000:00:18.3: Adding to iommu group 8
[    0.397453] pci 0000:00:18.4: Adding to iommu group 8
[    0.397474] pci 0000:00:18.5: Adding to iommu group 8
[    0.397494] pci 0000:00:18.6: Adding to iommu group 8
[    0.397515] pci 0000:00:18.7: Adding to iommu group 8
[    0.397539] pci 0000:01:00.0: Adding to iommu group 9
[    0.397560] pci 0000:02:00.0: Adding to iommu group 10
[    0.397581] pci 0000:03:00.0: Adding to iommu group 11
[    0.397600] pci 0000:04:00.0: Adding to iommu group 6
[    0.397610] pci 0000:04:00.1: Adding to iommu group 6
[    0.397623] pci 0000:04:00.2: Adding to iommu group 6
[    0.397633] pci 0000:04:00.3: Adding to iommu group 6
[    0.397644] pci 0000:04:00.4: Adding to iommu group 6
[    0.397655] pci 0000:04:00.5: Adding to iommu group 6
[    0.397666] pci 0000:04:00.6: Adding to iommu group 6
[    0.399260] AMD-Vi: Extended features (0x206d73ef22254ade, 0x0): PPR X2A=
PIC NX GT IA GA PC GA_vAPIC
[    0.399289] AMD-Vi: Interrupt remapping enabled
[    0.399294] AMD-Vi: X2APIC enabled
[    0.399609] AMD-Vi: Virtual APIC enabled
[    0.399621] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.399627] software IO TLB: mapped [mem 0x00000000bc19e000-0x00000000c0=
19e000] (64MB)
[    0.399732] LVT offset 0 assigned for vector 0x400
[    0.400302] perf: AMD IBS detected (0x000003ff)
[    0.400313] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/b=
ank).
[    0.432407] Initialise system trusted keyrings
[    0.432426] Key type blacklist registered
[    0.432497] workingset: timestamp_bits=3D36 max_order=3D22 bucket_order=
=3D0
[    0.432646] fuse: init (API version 7.42)
[    0.432758] integrity: Platform Keyring initialized
[    0.432764] integrity: Machine keyring initialized
[    0.444152] Key type asymmetric registered
[    0.444157] Asymmetric key parser 'x509' registered
[    0.444182] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 246)
[    0.444285] io scheduler mq-deadline registered
[    0.444299] io scheduler kyber registered
[    0.444342] io scheduler bfq registered
[    0.446269] ledtrig-cpu: registered to indicate activity on CPUs
[    0.446403] pcieport 0000:00:02.1: PME: Signaling with IRQ 28
[    0.446541] pcieport 0000:00:02.2: PME: Signaling with IRQ 29
[    0.446664] pcieport 0000:00:02.3: PME: Signaling with IRQ 30
[    0.446687] pcieport 0000:00:02.3: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+
[    0.446893] pcieport 0000:00:08.1: PME: Signaling with IRQ 31
[    0.447002] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.447867] ACPI: AC: AC Adapter [AC] (on-line)
[    0.447920] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input0
[    0.447946] ACPI: button: Power Button [PWRB]
[    0.447987] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0=
D:00/input/input1
[    0.449408] ACPI: button: Lid Switch [LID]
[    0.449441] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input2
[    0.453444] ACPI: button: Sleep Button [SLPB]
[    0.453564] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input3
[    0.453839] ACPI: button: Power Button [PWRF]
[    0.454456] Monitor-Mwait will be used to enter C-1 state
[    0.456182] Estimated ratio of average max frequency by base frequency (=
times 1024): 1501
[    0.456532] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.457260] ACPI: battery: Slot [BAT0] (battery present)
[    0.458713] Non-volatile memory driver v1.3
[    0.458719] Linux agpgart interface v0.103
[    0.460272] tpm_tis STM0125:00: 2.0 TPM (device-id 0x0, rev-id 78)
[    0.469472] Freeing initrd memory: 49932K
[    0.687150] ACPI: bus type drm_connector registered
[    0.691707] xhci_hcd 0000:04:00.3: xHCI Host Controller
[    0.691733] xhci_hcd 0000:04:00.3: new USB bus registered, assigned bus =
number 1
[    0.692328] xhci_hcd 0000:04:00.3: hcc params 0x0268ffe5 hci version 0x1=
10 quirks 0x0000020000000010
[    0.693518] xhci_hcd 0000:04:00.3: xHCI Host Controller
[    0.693526] xhci_hcd 0000:04:00.3: new USB bus registered, assigned bus =
number 2
[    0.693533] xhci_hcd 0000:04:00.3: Host supports USB 3.1 Enhanced SuperS=
peed
[    0.693620] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.14
[    0.693627] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.693634] usb usb1: Product: xHCI Host Controller
[    0.693638] usb usb1: Manufacturer: Linux 6.14.0-rc4-1.2-mainline-dirty =
xhci-hcd
[    0.693644] usb usb1: SerialNumber: 0000:04:00.3
[    0.693768] hub 1-0:1.0: USB hub found
[    0.693821] hub 1-0:1.0: 4 ports detected
[    0.694302] usb usb2: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    0.694333] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.14
[    0.694340] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.694346] usb usb2: Product: xHCI Host Controller
[    0.694351] usb usb2: Manufacturer: Linux 6.14.0-rc4-1.2-mainline-dirty =
xhci-hcd
[    0.694357] usb usb2: SerialNumber: 0000:04:00.3
[    0.694450] hub 2-0:1.0: USB hub found
[    0.694461] hub 2-0:1.0: 2 ports detected
[    0.694844] xhci_hcd 0000:04:00.4: xHCI Host Controller
[    0.694852] xhci_hcd 0000:04:00.4: new USB bus registered, assigned bus =
number 3
[    0.695464] xhci_hcd 0000:04:00.4: hcc params 0x0268ffe5 hci version 0x1=
10 quirks 0x0000020000000010
[    0.696588] xhci_hcd 0000:04:00.4: xHCI Host Controller
[    0.696595] xhci_hcd 0000:04:00.4: new USB bus registered, assigned bus =
number 4
[    0.696602] xhci_hcd 0000:04:00.4: Host supports USB 3.1 Enhanced SuperS=
peed
[    0.696685] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.14
[    0.696694] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.696700] usb usb3: Product: xHCI Host Controller
[    0.696706] usb usb3: Manufacturer: Linux 6.14.0-rc4-1.2-mainline-dirty =
xhci-hcd
[    0.696713] usb usb3: SerialNumber: 0000:04:00.4
[    0.696814] hub 3-0:1.0: USB hub found
[    0.696880] hub 3-0:1.0: 4 ports detected
[    0.697329] usb usb4: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    0.697358] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.14
[    0.697365] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.697371] usb usb4: Product: xHCI Host Controller
[    0.697375] usb usb4: Manufacturer: Linux 6.14.0-rc4-1.2-mainline-dirty =
xhci-hcd
[    0.697381] usb usb4: SerialNumber: 0000:04:00.4
[    0.697472] hub 4-0:1.0: USB hub found
[    0.697501] hub 4-0:1.0: 2 ports detected
[    0.697734] usbcore: registered new interface driver usbserial_generic
[    0.697744] usbserial: USB Serial support registered for generic
[    0.697861] rtc_cmos 00:01: RTC can wake from S4
[    0.699411] rtc_cmos 00:01: registered as rtc0
[    0.699687] rtc_cmos 00:01: setting system clock to 2025-02-24T13:40:03 =
UTC (1740404403)
[    0.699813] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes nvram
[    0.702979] simple-framebuffer simple-framebuffer.0: [drm] Registered 1 =
planes with drm panic
[    0.702987] [drm] Initialized simpledrm 1.0.0 for simple-framebuffer.0 o=
n minor 0
[    0.707071] Console: switching to colour frame buffer device 240x67
[    0.712457] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledr=
mdrmfb frame buffer device
[    0.713306] hid: raw HID events driver (C) Jiri Kosina
[    0.713438] drop_monitor: Initializing network drop monitor service
[    0.713598] NET: Registered PF_INET6 protocol family
[    0.720168] Segment Routing with IPv6
[    0.720202] RPL Segment Routing with IPv6
[    0.720280] In-situ OAM (IOAM) with IPv6
[    0.720373] NET: Registered PF_PACKET protocol family
[    0.721771] microcode: Current revision: 0x08608108
[    0.721800] microcode: Updated early from: 0x08608103
[    0.722141] resctrl: L3 allocation detected
[    0.722155] resctrl: MB allocation detected
[    0.722165] resctrl: L3 monitoring detected
[    0.722195] IPI shorthand broadcast: enabled
[    0.724713] sched_clock: Marking stable (723952024, 656951)->(736410627,=
 -11801652)
[    0.725000] registered taskstats version 1
[    0.738422] Loading compiled-in X.509 certificates
[    0.746945] Loaded X.509 cert 'Build time autogenerated kernel key: 3489=
41f038a2217e3a6c2f8ce6d0c9b66c02bac3'
[    0.749412] Demotion targets for Node 0: null
[    0.749685] Key type .fscrypt registered
[    0.749711] Key type fscrypt-provisioning registered
[    0.750570] integrity: Loading X.509 certificate: UEFI:db
[    0.750616] integrity: Loaded X.509 cert 'Lenovo Ltd.: ThinkPad Product =
CA 2012: 838b1f54c1550463f45f98700640f11069265949'
[    0.750660] integrity: Loading X.509 certificate: UEFI:db
[    0.750699] integrity: Loaded X.509 cert 'Lenovo(Beijing)Ltd: swqagent: =
24b0bd0836b2f545edea93e058bd3a3c5a8f6a49'
[    0.750743] integrity: Loading X.509 certificate: UEFI:db
[    0.750778] integrity: Loaded X.509 cert 'Lenovo UEFI CA 2014: 4b91a6873=
2eaefdd2c8ffffc6b027ec3449e9c8f'
[    0.750817] integrity: Loading X.509 certificate: UEFI:db
[    0.750857] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA =
2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    0.750899] integrity: Loading X.509 certificate: UEFI:db
[    0.750938] integrity: Loaded X.509 cert 'Microsoft Windows Production P=
CA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    0.752148] blacklist: Duplicate blacklisted hash bin:80b4d96931bf0d02fd=
91a61e19d14f1da452e66db2408ca8604d411f92659f0a
[    0.752193] blacklist: Duplicate blacklisted hash bin:f52f83a3fa9cfbd692=
0f722824dbe4034534d25b8507246b3b957dac6e1bce7a
[    0.752236] blacklist: Duplicate blacklisted hash bin:c5d9d8a186e2c82d09=
afaa2a6f7f2e73870d3e64f72c4e08ef67796a840f0fbd
[    0.752276] blacklist: Duplicate blacklisted hash bin:1aec84b84b6c65a512=
20a9be7181965230210d62d6d33c48999c6b295a2b0a06
[    0.752317] blacklist: Duplicate blacklisted hash bin:c3a99a460da464a057=
c3586d83cef5f4ae08b7103979ed8932742df0ed530c66
[    0.752358] blacklist: Duplicate blacklisted hash bin:58fb941aef95a25943=
b3fb5f2510a0df3fe44c58c95e0ab80487297568ab9771
[    0.752400] blacklist: Duplicate blacklisted hash bin:5391c3a2fb112102a6=
aa1edc25ae77e19f5d6f09cd09eeb2509922bfcd5992ea
[    0.752444] blacklist: Duplicate blacklisted hash bin:d626157e1d6a718bc1=
24ab8da27cbb65072ca03a7b6b257dbdcbbd60f65ef3d1
[    0.752487] blacklist: Duplicate blacklisted hash bin:d063ec28f67eba53f1=
642dbf7dff33c6a32add869f6013fe162e2c32f1cbe56d
[    0.752528] blacklist: Duplicate blacklisted hash bin:29c6eb52b43c3aa18b=
2cd8ed6ea8607cef3cfae1bafe1165755cf2e614844a44
[    0.752571] blacklist: Duplicate blacklisted hash bin:90fbe70e69d633408d=
3e170c6832dbb2d209e0272527dfb63d49d29572a6f44c
[    0.754515] blacklist: Duplicate blacklisted hash bin:106faceacfecfd4e30=
3b74f480a08098e2d0802b936f8ec774ce21f31686689c
[    0.756380] blacklist: Duplicate blacklisted hash bin:174e3a0b5b43c6a607=
bbd3404f05341e3dcf396267ce94f8b50e2e23a9da920c
[    0.758243] blacklist: Duplicate blacklisted hash bin:2b99cf26422e92fe36=
5fbf4bc30d27086c9ee14b7a6fff44fb2f6b9001699939
[    0.759600] blacklist: Duplicate blacklisted hash bin:2e70916786a6f77351=
1fa7181fab0f1d70b557c6322ea923b2a8d3b92b51af7d
[    0.761309] blacklist: Duplicate blacklisted hash bin:3fce9b9fdf3ef09d54=
52b0f95ee481c2b7f06d743a737971558e70136ace3e73
[    0.763382] blacklist: Duplicate blacklisted hash bin:47cc086127e2069a86=
e03a6bef2cd410f8c55a6d6bdb362168c31b2ce32a5adf
[    0.764644] blacklist: Duplicate blacklisted hash bin:71f2906fd222497e54=
a34662ab2497fcc81020770ff51368e9e3d9bfcbfd6375
[    0.765927] blacklist: Duplicate blacklisted hash bin:82db3bceb4f60843ce=
9d97c3d187cd9b5941cd3de8100e586f2bda5637575f67
[    0.767257] blacklist: Duplicate blacklisted hash bin:8ad64859f195b5f58d=
afaa940b6a6167acd67a886e8f469364177221c55945b9
[    0.768392] blacklist: Duplicate blacklisted hash bin:8d8ea289cfe70a1c07=
ab7365cb28ee51edd33cf2506de888fbadd60ebf80481c
[    0.769541] blacklist: Duplicate blacklisted hash bin:aeebae3151271273ed=
95aa2e671139ed31a98567303a332298f83709a9d55aa1
[    0.770683] blacklist: Duplicate blacklisted hash bin:c409bdac4775add8db=
92aa22b5b718fb8c94a1462c1fe9a416b95d8a3388c2fc
[    0.771837] blacklist: Duplicate blacklisted hash bin:c617c1a8b1ee2a811c=
28b5a81b4c83d7c98b5b0c27281d610207ebe692c2967f
[    0.772991] blacklist: Duplicate blacklisted hash bin:c90f336617b8e7f983=
975413c997f10b73eb267fd8a10cb9e3bdbfc667abdb8b
[    0.774139] blacklist: Duplicate blacklisted hash bin:64575bd912789a2e14=
ad56f6341f52af6bf80cf94400785975e9f04e2d64d745
[    0.775314] blacklist: Duplicate blacklisted hash bin:45c7c8ae750acfbb48=
fc37527d6412dd644daed8913ccd8a24c94d856967df8e
[    0.776767] blacklist: Duplicate blacklisted hash bin:47ff1b63b140b6fc04=
ed79131331e651da5b2e2f170f5daef4153dc2fbc532b1
[    0.778050] blacklist: Duplicate blacklisted hash bin:5391c3a2fb112102a6=
aa1edc25ae77e19f5d6f09cd09eeb2509922bfcd5992ea
[    0.779351] blacklist: Duplicate blacklisted hash bin:80b4d96931bf0d02fd=
91a61e19d14f1da452e66db2408ca8604d411f92659f0a
[    0.780692] blacklist: Duplicate blacklisted hash bin:992d359aa7a5f789d2=
68b94c11b9485a6b1ce64362b0edb4441ccc187c39647b
[    0.782087] blacklist: Duplicate blacklisted hash bin:c452ab846073df5ace=
25cca64d6b7a09d906308a1a65eb5240e3c4ebcaa9cc0c
[    0.783326] blacklist: Duplicate blacklisted hash bin:e051b788ecbaeda530=
46c70e6af6058f95222c046157b8c4c1b9c2cfc65f46e5
[    0.785614] PM:   Magic number: 13:290:686
[    0.792247] RAS: Correctable Errors collector initialized.
[    0.809544] clk: Disabling unused clocks
[    0.811466] PM: genpd: Disabling unused power domains
[    0.814204] Freeing unused decrypted memory: 2028K
[    0.815647] Freeing unused kernel image (initmem) memory: 4324K
[    0.816593] Write protecting the kernel read-only data: 34816k
[    0.818162] Freeing unused kernel image (text/rodata gap) memory: 1056K
[    0.819626] Freeing unused kernel image (rodata/data gap) memory: 1884K
[    0.880381] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.882277] rodata_test: all tests were successful
[    0.883437] Run /init as init process
[    0.884074]   with arguments:
[    0.885484]     /init
[    0.886477]   with environment:
[    0.888150]     HOME=3D/
[    0.889312]     TERM=3Dlinux
[    0.890850]     cryptdevice=3DUUID=3D8913bf3e-3df0-478e-b072-f7bec731154=
b:archlinux
[    0.935355] usb 3-3: new full-speed USB device number 2 using xhci_hcd
[    0.936539] usb 1-3: new high-speed USB device number 2 using xhci_hcd
[    1.062517] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x6=
0,0x64 irq 1,12
[    1.065329] ACPI: video: Video Device [VGA] (multi-head: yes  rom: no  p=
ost: no)
[    1.067245] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.068338] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/device:0a/LNXVIDEO:00/input/input4
[    1.068690] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.071900] ccp 0000:04:00.2: enabling device (0000 -> 0002)
[    1.072629] usb 1-3: New USB device found, idVendor=3D13d3, idProduct=3D=
56fb, bcdDevice=3D20.04
[    1.073929] ccp 0000:04:00.2: ccp: unable to access the device: you migh=
t be running a broken BIOS.
[    1.075121] usb 1-3: New USB device strings: Mfr=3D3, Product=3D1, Seria=
lNumber=3D2
[    1.077978] usb 1-3: Product: Integrated Camera
[    1.078489] ccp 0000:04:00.2: tee enabled
[    1.079593] usb 1-3: Manufacturer: Azurewave
[    1.081195] ccp 0000:04:00.2: psp enabled
[    1.082461] usb 1-3: SerialNumber: 0000
[    1.082598] cryptd: max_cpu_qlen set to 1000
[    1.091705] usb 3-3: New USB device found, idVendor=3D06cb, idProduct=3D=
00fd, bcdDevice=3D 0.00
[    1.092524] usb 3-3: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D1
[    1.093157] usb 3-3: SerialNumber: 3b39bbc4a1e6
[    1.095894] nvme nvme0: pci function 0000:01:00.0
[    1.100558] AES CTR mode by8 optimization enabled
[    1.125112] nvme nvme0: D3 entry latency set to 8 seconds
[    1.161844] nvme nvme0: allocated 64 MiB host memory buffer (1 segment).
[    1.210728] usb 1-4: new full-speed USB device number 3 using xhci_hcd
[    1.213684] usb 3-4: new full-speed USB device number 3 using xhci_hcd
[    1.219907] nvme nvme0: 12/0/0 default/read/poll queues
[    1.240730]  nvme0n1: p1 p2
[    1.252273] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input5
[    1.264013] thinkpad_acpi: ThinkPad ACPI Extras v0.26
[    1.265111] thinkpad_acpi: http://ibm-acpi.sf.net/
[    1.266811] thinkpad_acpi: ThinkPad BIOS R1OET26W (1.05 ), EC R1OHT26W
[    1.268007] thinkpad_acpi: Lenovo ThinkPad E14 Gen 3, model 20YDS00G00
[    1.270510] thinkpad_acpi: radio switch found; radios are enabled
[    1.272735] thinkpad_acpi: This ThinkPad has standard ACPI backlight bri=
ghtness control, supported by the ACPI video driver
[    1.273669] thinkpad_acpi: Disabling thinkpad-acpi brightness events by =
default...
[    1.286229] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is u=
nblocked
[    1.332708] thinkpad_acpi: Standard ACPI backlight interface available, =
not loading native one
[    1.359494] usb 3-4: New USB device found, idVendor=3D0bda, idProduct=3D=
c123, bcdDevice=3D 0.00
[    1.360911] usb 3-4: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[    1.361440] usb 3-4: Product: Bluetooth Radio
[    1.361909] usb 3-4: Manufacturer: Realtek
[    1.362360] usb 3-4: SerialNumber: 00e04c000001
[    1.364679] usb 1-4: New USB device found, idVendor=3D1050, idProduct=3D=
0407, bcdDevice=3D 4.37
[    1.365360] usb 1-4: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    1.365858] usb 1-4: Product: Yubikey 4 OTP+U2F+CCID
[    1.366314] usb 1-4: Manufacturer: Yubico
[    1.371697] thinkpad_acpi: secondary fan control detected & enabled
[    1.383428] thinkpad_acpi: battery 1 registered (start 95, stop 100, beh=
aviours: 0x7)
[    1.384725] ACPI: battery: new hook: ThinkPad Battery Extension
[    1.399926] input: ThinkPad Extra Buttons as /devices/platform/thinkpad_=
acpi/input/input6
[    1.430684] tsc: Refined TSC clocksource calibration: 2111.941 MHz
[    1.431406] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1e7=
140ef45e, max_idle_ns: 440795279637 ns
[    1.432039] clocksource: Switched to clocksource tsc
[    1.528205] usbcore: registered new interface driver usbhid
[    1.529538] usbhid: USB HID core driver
[    2.126669] clocksource: timekeeping watchdog on CPU3: Marking clocksour=
ce 'tsc' as unstable because the skew is too large:
[    2.128267] clocksource:                       'hpet' wd_nsec: 499760653=
 wd_now: 1b8ad51 wd_last: 14b7d82 mask: ffffffff
[    2.128877] clocksource:                       'tsc' cs_nsec: 496003478 =
cs_now: 66814158c cs_last: 629a40ae8 mask: ffffffffffffffff
[    2.129397] clocksource:                       Clocksource 'tsc' skewed =
-3757175 ns (-3 ms) over watchdog 'hpet' interval of 499760653 ns (499 ms)
[    2.129903] clocksource:                       'tsc' is current clocksou=
rce.
[    2.130450] ------------[ cut here ]------------
[    2.130980] WARNING: CPU: 3 PID: 0 at kernel/smp.c:815 smp_call_function=
_many_cond+0x46b/0x4c0
[    2.131497] Modules linked in: usbhid amdgpu(+) crc16 amdxcp i2c_algo_bi=
t drm_ttm_helper polyval_clmulni polyval_generic ttm ghash_clmulni_intel th=
inkpad_acpi sha512_ssse3 drm_exec sha256_ssse3 serio_raw gpu_sched sparse_k=
eymap sha1_ssse3 atkbd drm_suballoc_helper platform_profile aesni_intel snd=
 libps2 drm_panel_backlight_quirks vivaldi_fmap nvme drm_buddy crypto_simd =
soundcore rfkill drm_display_helper cryptd nvme_core video ccp cec i8042 nv=
me_auth serio wmi
[    2.132616] CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted 6.14.0-rc4-=
1.2-mainline-dirty #1 15d4d304a72b35c263f4a043f428325d584ede12
[    2.133174] Hardware name: LENOVO 20YDS00G00/20YDS00G00, BIOS R1OET26W (=
1.05 ) 04/28/2021
[    2.133739] RIP: 0010:smp_call_function_many_cond+0x46b/0x4c0
[    2.134325] Code: 28 e8 f9 d7 f3 ff 84 c0 0f 84 a4 fe ff ff 48 8b 54 24 =
60 66 90 8b 7c 24 28 48 8b 05 6f db de 01 e8 5a 6b ca 00 e9 88 fe ff ff <0f=
> 0b e9 d2 fb ff ff 65 8b 05 13 f5 fe 4f 48 0f a3 05 5f e3 04 02
[    2.134937] RSP: 0018:ffffa6bec037cd28 EFLAGS: 00010202
[    2.135547] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00003
[    2.136161] RDX: 0000000000000000 RSI: ffffffffafebe1d0 RDI: ffffffffb20=
94b60
[    2.136776] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00001
[    2.137383] R10: ffffffffb1eb44a8 R11: 0000000000000003 R12: 00000000000=
00003
[    2.137993] R13: 0000000000000003 R14: 0000000000000003 R15: 00000000000=
00000
[    2.138591] FS:  0000000000000000(0000) GS:ffff98ad5eb80000(0000) knlGS:=
0000000000000000
[    2.139185] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.139780] CR2: 0000555c696da788 CR3: 000000009e222000 CR4: 00000000003=
50ef0
[    2.140376] Call Trace:
[    2.140968]  <IRQ>
[    2.141561]  ? smp_call_function_many_cond+0x46b/0x4c0
[    2.142161]  ? __warn.cold+0x93/0xf6
[    2.142764]  ? smp_call_function_many_cond+0x46b/0x4c0
[    2.143373]  ? report_bug+0xff/0x140
[    2.143970]  ? handle_bug+0x58/0x90
[    2.144565]  ? exc_invalid_op+0x17/0x70
[    2.145161]  ? asm_exc_invalid_op+0x1a/0x20
[    2.145749]  ? __pfx_do_sync_core+0x10/0x10
[    2.146334]  ? smp_call_function_many_cond+0x46b/0x4c0
[    2.146920]  ? __pfx_text_poke_memcpy+0x10/0x10
[    2.147498]  ? __pfx_do_sync_core+0x10/0x10
[    2.148077]  on_each_cpu_cond_mask+0x24/0x40
[    2.148659]  text_poke_bp_batch+0xc1/0x300
[    2.149235]  ? vsnprintf+0x205/0x5c0
[    2.149811]  ? arch_jump_label_transform_queue+0x57/0x80
[    2.150381]  text_poke_finish+0x1f/0x30
[    2.150948]  arch_jump_label_transform_apply+0x1a/0x30
[    2.151507]  static_key_disable_cpuslocked+0x7d/0x80
[    2.152074]  static_key_disable+0x1a/0x20
[    2.152628]  tsc_cs_mark_unstable+0x31/0x50
[    2.153189]  __clocksource_unstable+0x33/0x70
[    2.153736]  clocksource_watchdog.cold+0xca/0x1aa
[    2.154285]  ? __pfx_clocksource_watchdog+0x10/0x10
[    2.154821]  ? __pfx_clocksource_watchdog+0x10/0x10
[    2.155350]  call_timer_fn+0x2a/0x120
[    2.155880]  __run_timers+0x1f4/0x280
[    2.156403]  run_timer_softirq+0x49/0xf0
[    2.156924]  handle_softirqs+0xeb/0x2b0
[    2.157443]  __irq_exit_rcu+0xc2/0xe0
[    2.157968]  sysvec_apic_timer_interrupt+0x71/0x90
[    2.158489]  </IRQ>
[    2.158997]  <TASK>
[    2.159499]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[    2.160008] RIP: 0010:cpuidle_enter_state+0xc6/0x420
[    2.160513] Code: 00 00 e8 1d 4b 2e ff e8 98 f1 ff ff 49 89 c5 0f 1f 44 =
00 00 31 ff e8 19 dd 2c ff 45 84 ff 0f 85 40 02 00 00 fb 0f 1f 44 00 00 <45=
> 85 f6 0f 88 84 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
[    2.161048] RSP: 0018:ffffa6bec01c7e80 EFLAGS: 00000246
[    2.161577] RAX: ffff98ad5eb80000 RBX: 0000000000000003 RCX: 00000000000=
00000
[    2.162117] RDX: 000000007ec21a6e RSI: fffffffd76e37cf8 RDI: 00000000000=
00000
[    2.162650] RBP: ffff98aa80ffe800 R08: 0000000000000002 R09: 00000000000=
00000
[    2.163178] R10: 0000000000000000 R11: 000000000000ffff R12: ffffffffb1f=
ca360
[    2.163708] R13: 000000007ec21a6e R14: 0000000000000003 R15: 00000000000=
00000
[    2.164241]  cpuidle_enter+0x2d/0x40
[    2.164777]  do_idle+0x1ad/0x210
[    2.165300]  cpu_startup_entry+0x29/0x30
[    2.165814]  start_secondary+0x11e/0x140
[    2.166323]  common_startup_64+0x13e/0x141
[    2.166834]  </TASK>
[    2.167323] ---[ end trace 0000000000000000 ]---
[    2.168096] tsc: Marking TSC unstable due to clocksource watchdog
[    2.169791] TSC found unstable after boot, most likely due to broken BIO=
S. Use 'tsc=3Dunstable'.
[    2.170449] sched_clock: Marking unstable (2169143750, 657004)<-(2181592=
402, -11801652)
[    2.172467] clocksource: Checking clocksource tsc synchronization from C=
PU 9 to CPUs 0,5-8.
[    2.173804] clocksource: Switched to clocksource hpet
[    3.983013] input: Yubico Yubikey 4 OTP+U2F+CCID as /devices/pci0000:00/=
0000:00:08.1/0000:04:00.3/usb1/1-4/1-4:1.0/0003:1050:0407.0001/input/input8
[    3.991471] [drm] amdgpu kernel modesetting enabled.
[    4.018430] amdgpu: Virtual CRAT table created for CPU
[    4.019720] amdgpu: Topology: Add CPU node
[    4.021066] amdgpu 0000:04:00.0: enabling device (0006 -> 0007)
[    4.022202] [drm] initializing kernel modesetting (RENOIR 0x1002:0x164C =
0x17AA:0x5097 0xC2).
[    4.023401] [drm] register mmio base: 0xFD300000
[    4.024596] [drm] register mmio size: 524288
[    4.028949] amdgpu 0000:04:00.0: amdgpu: detected ip block number 0 <soc=
15_common>
[    4.029744] amdgpu 0000:04:00.0: amdgpu: detected ip block number 1 <gmc=
_v9_0>
[    4.031432] amdgpu 0000:04:00.0: amdgpu: detected ip block number 2 <veg=
a10_ih>
[    4.032900] amdgpu 0000:04:00.0: amdgpu: detected ip block number 3 <psp>
[    4.034163] amdgpu 0000:04:00.0: amdgpu: detected ip block number 4 <smu>
[    4.035485] amdgpu 0000:04:00.0: amdgpu: detected ip block number 5 <dm>
[    4.036962] amdgpu 0000:04:00.0: amdgpu: detected ip block number 6 <gfx=
_v9_0>
[    4.038515] amdgpu 0000:04:00.0: amdgpu: detected ip block number 7 <sdm=
a_v4_0>
[    4.039793] amdgpu 0000:04:00.0: amdgpu: detected ip block number 8 <vcn=
_v2_0>
[    4.040920] amdgpu 0000:04:00.0: amdgpu: detected ip block number 9 <jpe=
g_v2_0>
[    4.042070] amdgpu 0000:04:00.0: amdgpu: Fetched VBIOS from VFCT
[    4.043284] amdgpu: ATOM BIOS: 113-LUCIENNE-016
[    4.069993] Console: switching to colour dummy device 80x25
[    4.087102] amdgpu 0000:04:00.0: vgaarb: deactivate vga console
[    4.087119] amdgpu 0000:04:00.0: amdgpu: Trusted Memory Zone (TMZ) featu=
re enabled
[    4.087131] amdgpu 0000:04:00.0: amdgpu: MODE2 reset
[    4.087590] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, f=
ragment size is 9-bit
[    4.087609] amdgpu 0000:04:00.0: amdgpu: VRAM: 1024M 0x000000F400000000 =
- 0x000000F43FFFFFFF (1024M used)
[    4.087620] amdgpu 0000:04:00.0: amdgpu: GART: 1024M 0x0000000000000000 =
- 0x000000003FFFFFFF
[    4.087635] [drm] Detected VRAM RAM=3D1024M, BAR=3D1024M
[    4.087642] [drm] RAM width 128bits DDR4
[    4.087955] [drm] amdgpu: 1024M of VRAM memory ready
[    4.087965] [drm] amdgpu: 7400M of GTT memory ready.
[    4.087992] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    4.088140] [drm] PCIE GART of 1024M enabled.
[    4.088146] [drm] PTB located at 0x000000F43FC00000
[    4.088786] [drm] Loading DMUB firmware via PSP: version=3D0x0101002B
[    4.089548] [drm] Found VCN firmware Version ENC: 1.24 DEC: 8 VEP: 0 Rev=
ision: 3
[    4.095105] hid-generic 0003:1050:0407.0001: input,hidraw0: USB HID v1.1=
0 Keyboard [Yubico Yubikey 4 OTP+U2F+CCID] on usb-0000:04:00.3-4/input0
[    4.095627] hid-generic 0003:1050:0407.0002: hiddev96,hidraw1: USB HID v=
1.10 Device [Yubico Yubikey 4 OTP+U2F+CCID] on usb-0000:04:00.3-4/input1
[    4.821581] amdgpu 0000:04:00.0: amdgpu: reserve 0x400000 from 0xf43f800=
000 for PSP TMR
[    4.908787] amdgpu 0000:04:00.0: amdgpu: RAS: optional ras ta ucode is n=
ot available
[    4.917677] amdgpu 0000:04:00.0: amdgpu: RAP: optional rap ta ucode is n=
ot available
[    4.922345] amdgpu 0000:04:00.0: amdgpu: psp gfx command LOAD_TA(0x1) fa=
iled and response status is (0x7)
[    4.922475] amdgpu 0000:04:00.0: amdgpu: psp gfx command INVOKE_CMD(0x3)=
 failed and response status is (0x4)
[    4.922486] amdgpu 0000:04:00.0: amdgpu: Secure display: Generic Failure.
[    4.922494] amdgpu 0000:04:00.0: amdgpu: SECUREDISPLAY: query securedisp=
lay TA failed. ret 0x0
[    4.923221] amdgpu 0000:04:00.0: amdgpu: SMU is initialized successfully!
[    4.924363] [drm] Display Core v3.2.316 initialized on DCN 2.1
[    4.924378] [drm] DP-HDMI FRL PCON supported
[    4.925041] [drm] DMUB hardware initialized: version=3D0x0101002B
[    5.105370] amdgpu 0000:04:00.0: amdgpu: [drm] Using ACPI provided EDID =
for eDP-1
[    5.112859] [drm] kiq ring mec 2 pipe 1 q 0
[    5.119187] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    5.119211] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[    5.119403] amdgpu: Virtual CRAT table created for GPU
[    5.119614] amdgpu: Topology: Add dGPU node [0x164c:0x1002]
[    5.119622] kfd kfd: amdgpu: added device 1002:164c
[    5.119638] amdgpu 0000:04:00.0: amdgpu: SE 1, SH per SE 1, CU per SH 8,=
 active_cu_number 7
[    5.119671] amdgpu 0000:04:00.0: amdgpu: ring gfx uses VM inv eng 0 on h=
ub 0
[    5.119680] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng=
 1 on hub 0
[    5.119690] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng=
 4 on hub 0
[    5.119699] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng=
 5 on hub 0
[    5.119708] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng=
 6 on hub 0
[    5.119717] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng=
 7 on hub 0
[    5.119726] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng=
 8 on hub 0
[    5.119735] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng=
 9 on hub 0
[    5.119744] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng=
 10 on hub 0
[    5.119753] amdgpu 0000:04:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv en=
g 11 on hub 0
[    5.119763] amdgpu 0000:04:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on=
 hub 8
[    5.119772] amdgpu 0000:04:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 =
on hub 8
[    5.119781] amdgpu 0000:04:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4=
 on hub 8
[    5.119790] amdgpu 0000:04:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5=
 on hub 8
[    5.119799] amdgpu 0000:04:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6=
 on hub 8
[    5.120848] amdgpu 0000:04:00.0: amdgpu: Runtime PM not available
[    5.121787] amdgpu 0000:04:00.0: [drm] Registered 4 planes with drm panic
[    5.121796] [drm] Initialized amdgpu 3.61.0 for 0000:04:00.0 on minor 1
[    5.126520] fbcon: amdgpudrmfb (fb0) is primary device
[    5.126936] [drm] pre_validate_dsc:1601 MST_DSC dsc precompute is not ne=
eded
[    5.161206] Console: switching to colour frame buffer device 240x67
[    5.180873] amdgpu 0000:04:00.0: [drm] fb0: amdgpudrmfb frame buffer dev=
ice
[    5.270640] device-mapper: uevent: version 1.0.3
[    5.270800] device-mapper: ioctl: 4.49.0-ioctl (2025-01-17) initialised:=
 dm-devel@lists.linux.dev
[    5.287490] Key type trusted registered
[    5.385260] Key type encrypted registered
[   15.993072] raid6: skipped pq benchmark and selected avx2x4
[   15.993305] raid6: using avx2x2 recovery algorithm
[   15.996992] xor: automatically using best checksumming function   avx   =
   =20
[   16.125723] Btrfs loaded, zoned=3Dyes, fsverity=3Dyes
[   16.178538] BTRFS: device label archlinux-btrfs devid 1 transid 542671 /=
dev/mapper/archlinux (254:0) scanned by mount (503)
[   16.179868] BTRFS info (device dm-0): first mount of filesystem 924db749=
-b786-4970-9fed-688cccb609e9
[   16.186513] BTRFS info (device dm-0): using crc32c (crc32c-x86) checksum=
 algorithm
[   16.186534] BTRFS info (device dm-0): using free-space-tree
[   16.433832] systemd[1]: systemd 257.3-1-arch running in system mode (+PA=
M +AUDIT -SELINUX -APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT +GNUTLS +OPEN=
SSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETU=
P +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM=
2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP -SYSVINI=
T +LIBARCHIVE)
[   16.433905] systemd[1]: Detected architecture x86-64.
[   16.434919] systemd[1]: Hostname set to <meterpeter>.
[   16.572675] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[   16.732272] systemd[1]: Queued start job for default target Graphical In=
terface.
[   16.759752] systemd[1]: Created slice Slice /system/dirmngr.
[   16.760425] systemd[1]: Created slice Slice /system/getty.
[   16.761021] systemd[1]: Created slice Slice /system/gpg-agent.
[   16.761617] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[   16.765339] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[   16.768009] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[   16.770222] systemd[1]: Created slice Slice /system/keyboxd.
[   16.772221] systemd[1]: Created slice Slice /system/modprobe.
[   16.774173] systemd[1]: Created slice Slice /system/systemd-fsck.
[   16.776002] systemd[1]: Created slice User and Session Slice.
[   16.777475] systemd[1]: Started Dispatch Password Requests to Console Di=
rectory Watch.
[   16.779531] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[   16.781272] systemd[1]: Set up automount Arbitrary Executable File Forma=
ts File System Automount Point.
[   16.782675] systemd[1]: Expecting device /dev/disk/by-uuid/924db749-b786=
-4970-9fed-688cccb609e9...
[   16.783927] systemd[1]: Expecting device /dev/disk/by-uuid/FABC-FA07...
[   16.785178] systemd[1]: Reached target Local Encrypted Volumes.
[   16.786431] systemd[1]: Reached target Local Integrity Protected Volumes.
[   16.787706] systemd[1]: Reached target Preparation for Network.
[   16.788972] systemd[1]: Reached target Path Units.
[   16.790232] systemd[1]: Reached target Remote File Systems.
[   16.791502] systemd[1]: Reached target Slice Units.
[   16.792785] systemd[1]: Reached target Local Verity Protected Volumes.
[   16.794163] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[   16.797248] systemd[1]: Listening on Process Core Dump Socket.
[   16.799423] systemd[1]: Listening on Credential Encryption/Decryption.
[   16.801052] systemd[1]: Listening on Journal Socket (/dev/log).
[   16.802580] systemd[1]: Listening on Journal Sockets.
[   16.804003] systemd[1]: TPM PCR Measurements was skipped because of an u=
nmet condition check (ConditionSecurity=3Dmeasured-uki).
[   16.804628] systemd[1]: Make TPM PCR Policy was skipped because of an un=
met condition check (ConditionSecurity=3Dmeasured-uki).
[   16.805372] systemd[1]: Listening on udev Control Socket.
[   16.806828] systemd[1]: Listening on udev Kernel Socket.
[   16.810817] systemd[1]: Mounting Huge Pages File System...
[   16.814042] systemd[1]: Mounting POSIX Message Queue File System...
[   16.838702] systemd[1]: Mounting Kernel Debug File System...
[   16.842241] systemd[1]: Mounting Kernel Trace File System...
[   16.846690] systemd[1]: Starting Create List of Static Device Nodes...
[   16.849870] systemd[1]: Starting Load Kernel Module configfs...
[   16.852879] systemd[1]: Starting Load Kernel Module dm_mod...
[   16.855778] systemd[1]: Starting Load Kernel Module drm...
[   16.858832] systemd[1]: Starting Load Kernel Module fuse...
[   16.862046] systemd[1]: Starting Load Kernel Module loop...
[   16.864305] systemd[1]: Clear Stale Hibernate Storage Info was skipped b=
ecause of an unmet condition check (ConditionPathExists=3D/sys/firmware/efi=
/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
[   16.867109] systemd[1]: Starting Journal Service...
[   16.870290] systemd[1]: Starting Load Kernel Modules...
[   16.872103] systemd[1]: TPM PCR Machine ID Measurement was skipped becau=
se of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[   16.873370] loop: module loaded
[   16.874026] systemd[1]: Starting Remount Root and Kernel File Systems...
[   16.876137] systemd[1]: Early TPM SRK Setup was skipped because of an un=
met condition check (ConditionSecurity=3Dmeasured-uki).
[   16.878287] systemd[1]: Starting Load udev Rules from Credentials...
[   16.881742] systemd[1]: Starting Coldplug All udev Devices...
[   16.886345] systemd[1]: Mounted Huge Pages File System.
[   16.888061] systemd-journald[573]: Collecting audit messages is disabled.
[   16.890252] systemd[1]: Mounted POSIX Message Queue File System.
[   16.893169] systemd[1]: Mounted Kernel Debug File System.
[   16.895705] systemd[1]: Mounted Kernel Trace File System.
[   16.897920] systemd[1]: Finished Create List of Static Device Nodes.
[   16.899861] systemd[1]: modprobe@configfs.service: Deactivated successfu=
lly.
[   16.900900] systemd[1]: Finished Load Kernel Module configfs.
[   16.902879] systemd[1]: modprobe@dm_mod.service: Deactivated successfull=
y.
[   16.903924] systemd[1]: Finished Load Kernel Module dm_mod.
[   16.905896] systemd[1]: modprobe@drm.service: Deactivated successfully.
[   16.906970] systemd[1]: Finished Load Kernel Module drm.
[   16.908990] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[   16.910228] systemd[1]: Finished Load Kernel Module fuse.
[   16.912871] systemd[1]: modprobe@loop.service: Deactivated successfully.
[   16.913975] systemd[1]: Finished Load Kernel Module loop.
[   16.916302] systemd[1]: Finished Load Kernel Modules.
[   16.918286] systemd[1]: Finished Remount Root and Kernel File Systems.
[   16.921654] systemd[1]: Finished Load udev Rules from Credentials.
[   16.925028] systemd[1]: Activating swap /swap/swapfile...
[   16.927964] systemd[1]: Mounting FUSE Control File System...
[   16.941363] systemd[1]: Mounting Kernel Configuration File System...
[   16.944369] systemd[1]: Rebuild Hardware Database was skipped because no=
 trigger condition checks were met.
[   16.947388] systemd[1]: Starting Load/Save OS Random Seed...
[   16.948893] Adding 16777212k swap on /swap/swapfile.  Priority:-2 extent=
s:33 across:450363392k SS
[   16.950250] systemd[1]: Repartition Root Disk was skipped because no tri=
gger condition checks were met.
[   16.952102] systemd[1]: Starting Apply Kernel Variables...
[   16.955210] systemd[1]: Starting Create Static Device Nodes in /dev grac=
efully...
[   16.957464] systemd[1]: TPM SRK Setup was skipped because of an unmet co=
ndition check (ConditionSecurity=3Dmeasured-uki).
[   16.959169] systemd[1]: Activated swap /swap/swapfile.
[   16.962083] systemd[1]: Started Journal Service.
[   17.321959] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, re=
vision 0
[   17.323371] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port=
 selection
[   17.327146] i2c i2c-5: Successfully instantiated SPD at 0x50
[   17.330053] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at=
 0xb20
[   17.419023] snd_rn_pci_acp3x 0000:04:00.5: enabling device (0000 -> 0002)
[   17.419268] RAPL PMU: API unit is 2^-32 Joules, 2 fixed counters, 163840=
 ms ovfl timer
[   17.419681] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[   17.420999] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[   17.421990] RAPL PMU: hw unit of domain package 2^-16 Joules
[   17.423206] sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog MMIO ad=
dress
[   17.424056] RAPL PMU: hw unit of domain core 2^-16 Joules
[   17.424484] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   17.424697] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db1=
8c600'
[   17.425346] sp5100-tco sp5100-tco: initialized. heartbeat=3D60 sec (nowa=
yout=3D0)
[   17.442632] r8169 0000:02:00.0: can't disable ASPM; OS doesn't have ASPM=
 control
[   17.446241] ee1004 5-0050: 512 byte EE1004-compliant SPD EEPROM, read-on=
ly
[   17.449907] r8169 0000:02:00.0 eth0: RTL8168gu/8111gu, 38:f3:ab:58:be:e8=
, XID 509, IRQ 68
[   17.450635] r8169 0000:02:00.0 eth0: jumbo features [frames: 9194 bytes,=
 tx checksumming: ko]
[   17.466199] r8169 0000:02:00.0 enp2s0: renamed from eth0
[   17.593072] kvm_amd: TSC scaling supported
[   17.595512] kvm_amd: Nested Virtualization enabled
[   17.596296] kvm_amd: Nested Paging enabled
[   17.596837] kvm_amd: LBR virtualization supported
[   17.597362] kvm_amd: Virtual VMLOAD VMSAVE supported
[   17.597874] kvm_amd: Virtual GIF supported
[   17.609278] snd_hda_intel 0000:04:00.1: enabling device (0000 -> 0002)
[   17.611097] snd_hda_intel 0000:04:00.1: Handle vga_switcheroo audio clie=
nt
[   17.612416] snd_hda_intel 0000:04:00.6: enabling device (0000 -> 0002)
[   17.634941] snd_hda_intel 0000:04:00.1: bound 0000:04:00.0 (ops amdgpu_d=
m_audio_component_bind_ops [amdgpu])
[   17.637884] input: HD-Audio Generic HDMI/DP,pcm=3D3 as /devices/pci0000:=
00/0000:00:08.1/0000:04:00.1/sound/card0/input10
[   17.639078] input: HD-Audio Generic HDMI/DP,pcm=3D7 as /devices/pci0000:=
00/0000:00:08.1/0000:04:00.1/sound/card0/input11
[   17.639287] rtw_8822ce 0000:03:00.0: enabling device (0000 -> 0003)
[   17.641436] rtw_8822ce 0000:03:00.0: WOW Firmware version 9.9.4, H2C ver=
sion 15
[   17.641555] input: HD-Audio Generic HDMI/DP,pcm=3D8 as /devices/pci0000:=
00/0000:00:08.1/0000:04:00.1/sound/card0/input12
[   17.643033] rtw_8822ce 0000:03:00.0: Firmware version 9.9.15, H2C versio=
n 15
[   17.651549] snd_hda_codec_realtek hdaudioC1D0: ALC257: picked fixup  for=
 PCI SSID 17aa:0000
[   17.652841] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC257: li=
ne_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[   17.653439] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=3D0 (0x0/=
0x0/0x0/0x0/0x0)
[   17.653980] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=3D1 (0x21/0x0/=
0x0/0x0/0x0)
[   17.654483] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=3D0x0
[   17.654997] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[   17.655493] snd_hda_codec_realtek hdaudioC1D0:      Internal Mic=3D0x12
[   17.656008] snd_hda_codec_realtek hdaudioC1D0:      Mic=3D0x19
[   17.684147] intel_rapl_common: Found RAPL domain package
[   17.685215] amd_atl: AMD Address Translation Library initialized
[   17.686673] intel_rapl_common: Found RAPL domain core
[   17.719738] rtw_8822ce 0000:03:00.0 wlp3s0: renamed from wlan0
[   17.746368] input: HD-Audio Generic Mic as /devices/pci0000:00/0000:00:0=
8.1/0000:04:00.6/sound/card1/input13
[   17.747743] input: HD-Audio Generic Headphone as /devices/pci0000:00/000=
0:00:08.1/0000:04:00.6/sound/card1/input14
[   17.807799] psmouse serio1: elantech: assuming hardware version 4 (with =
firmware version 0x5f3001)
[   17.822274] psmouse serio1: elantech: Synaptics capabilities query resul=
t 0x90, 0x18, 0x0d.
[   17.836749] psmouse serio1: elantech: Elan sample query result 00, 0d, a7
[   17.850920] psmouse serio1: elantech: Elan ic body: 0x11, current fw ver=
sion: 0x4
[   17.928165] psmouse serio1: elantech: Trying to set up SMBus access
[   17.928240] psmouse serio1: elantech: SMbus companion is not ready yet
[   17.955976] input: ETPS/2 Elantech TrackPoint as /devices/platform/i8042=
/serio1/input/input15
[   17.972458] input: ETPS/2 Elantech Touchpad as /devices/platform/i8042/s=
erio1/input/input9
[   17.979185] systemd-journald[573]: Received client request to flush runt=
ime journal.
[   17.982791] mousedev: PS/2 mouse device common for all mice
[   18.513949] Bluetooth: Core ver 2.22
[   18.514326] mc: Linux media interface: v0.10
[   18.515346] NET: Registered PF_BLUETOOTH protocol family
[   18.517132] Bluetooth: HCI device and connection manager initialized
[   18.518088] Bluetooth: HCI socket layer initialized
[   18.519014] Bluetooth: L2CAP socket layer initialized
[   18.519976] Bluetooth: SCO socket layer initialized
[   18.541352] videodev: Linux video capture interface: v2.00
[   18.666069] usbcore: registered new interface driver btusb
[   18.669871] Bluetooth: hci0: RTL: examining hci_ver=3D0a hci_rev=3D000c =
lmp_ver=3D0a lmp_subver=3D8822
[   18.671866] Bluetooth: hci0: RTL: rom_version status=3D0 version=3D3
[   18.672765] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cu_fw.bin
[   18.674881] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cu_config.bin
[   18.674994] Bluetooth: hci0: RTL: cfg_sz 6, total sz 37346
[   18.688032] usb 1-3: Found UVC 1.10 device Integrated Camera (13d3:56fb)
[   18.698530] usb 1-3: Found UVC 1.50 device Integrated Camera (13d3:56fb)
[   18.702510] usbcore: registered new interface driver uvcvideo
[   19.004086] Bluetooth: hci0: RTL: fw version 0xaed66dcb
[   19.112871] Bluetooth: hci0: AOSP extensions version v1.00
[   19.114852] Bluetooth: hci0: AOSP quality report is supported
[   19.245731] Generic FE-GE Realtek PHY r8169-0-200:00: attached PHY drive=
r (mii_bus:phy_addr=3Dr8169-0-200:00, irq=3DMAC)
[   19.400751] r8169 0000:02:00.0 enp2s0: Link is Down
[   19.675413] tun: Universal TUN/TAP device driver, 1.6
[   22.183347] r8169 0000:02:00.0 enp2s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx
[   22.186503] r8169 0000:02:00.0 enp2s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx
[   30.706525] nvme nvme0: using unchecked data buffer

--ehb65j4gtm3i6hrc--

--hr23r556o5hrbv7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAme8etQACgkQwEfU8yi1
JYXlbA//frdAC//Q23kK+ewxNnV3gX9mMF9Dor3GXz3lOk+R/y3SEy2JhO+q5kQv
ygqLLt/UEW6W6pUYS27sz2ICyXJh/qL+v9a/XPbh3OwBcMM+y4MZNNp2xSHoIKJu
KBD95vqZ3yjfTd/si1VUGetMDOQIO8cyB5FDmT9e2P24xHgNBvhF6QZjdfHW0Ozf
XXPwdNi72QvxThvMdNSxxyq8jywSwNJcyxanmMFaoy/8hf8NoSXvrYM5uxtc4ncs
8ISSAu7Is8I/UI1LMoCx7NsYsKfD//pKElVxru4GJxM2UYSwM+83UXbdKpcQEbZJ
BgxvVeA8JNQOARL5iVeYkk8Wc3RRtzFun+cV4zx+7G4Flf2cApz8JAR+WJJv7gzI
FItEIJwg4kKXhCFupem6fmsaWWtRwiJmzBqkGz/jTT5oPZZDGN86YN0/fCAnriwF
d+Qkv38WOOgi6iBajhcq+/dNBYLBtAq4efZA+UhpEkAtgL5sxr2bWsh40GX+y3kI
cnEK90Ug3g3syUGAxMMm6hSw3gt0arW596mFMPYv1FaQvFPbSMP3SATCwsKxXQg7
INKXduqY4mBB+a21BW0LJP6XJazDfEWUDdgkmBYVfUoWhgmQf25aWXpFzidDz/fI
NS7RgIPYNNALwE5++d8fuYEiyJ62lOCVDJM2t/MRLZw45ZvmICk=
=kIGo
-----END PGP SIGNATURE-----

--hr23r556o5hrbv7v--

