Return-Path: <linux-kernel+bounces-544168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C008A4DE2B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AFE118888D8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47E7202C4E;
	Tue,  4 Mar 2025 12:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QvtAEIvW"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFEA202C32
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741092221; cv=none; b=JQu1nrddPM/OkEHRgHFoMymiZ3Br3zCl7sSC1+AavJkSRH5ngIFSdvNezfL9mmyQfcc9/Jp/ermn1ng91nC78BNr+uYXe7Y2L3Q1WQHRuAZ0O2QxPWzuPM7KXcw0COnWFDxg8puD0aoQCojZAPqnXOEG+He5WIW5a8e3uIo7ql8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741092221; c=relaxed/simple;
	bh=fd8Rq+TSBaHfLQ2UcQETJmwKzkJMMzp18q8gCMPF78Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZfxaIJYr8zpm6K8rsyh4B+qD82xuMSiHwg0pDmzz8L/eJuWXCcSn8Fp8KA2junvIzj/MufR4Jmq81h44zMnBGhbUTG4dn/X2p0acuayXSx8r0MeybE9/i/JlvUyOuioaBbk6MNGiatbI+OPjzcPWZ2jNPEZbOOV0u126zIXsgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QvtAEIvW reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C16F840E0214;
	Tue,  4 Mar 2025 12:43:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BqXPRURRzlYj; Tue,  4 Mar 2025 12:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741092206; bh=1Ssapqq/5f79Pbn1XcCkp5h2iInNab/QDUX2Vvg4i38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QvtAEIvWmHJsX1ZhlO+xQ0GE9CQg+DbkBeB8PLLGmwLDdF9iYVvnds0WPMhFih7cD
	 WtI0kS/P6nZc8/jVmCCfea1cpvANXeUbaWLQKbITOp8lo0zwCvYTFJPrT2JjDIWlAV
	 fsHHl226xApAVrrfdAf0XrN2o9kjY0MuJbwr5tgMXjczSA5lOOzk8dJojfi7ETW4fq
	 UEufmyXNLH79skzqX6c7/q/mmAh+knprJ9fJ7+lkR3FaY2UGRwYNliujYtvIyaZJoc
	 GgemlGX6HUk4DWCggQEgf84C0LRI25hAwwI4mBodwGJs20hLCn2HPnVEV/XYTGniAg
	 L43tdyCA1QnAaHmJf1l17flDVoWCPxLqBjZH4l9DvktBWTcg+nH4REITWErD9a3lKO
	 daJ6AfkBiwtDcey2zEOtzJi2eXIYG57HYvr//aTZmF/yJ/HzIB4XrWbAkKGu8H3d0n
	 oA0A0oviFsAovFagrxYsYkZkVvvJESrfK906KFpnFoLD7kw2lMBJCXpmX2v8PLkSKr
	 hacxtlnFiSA6FRDApq/fncDVvYZd93cH2eDztyhIS5q3kjcjYZLOOmniLtsY9FVf99
	 k4X4RgUS4nXUh9hwHs7shM62u9U2xh5J09uJ3Pz7Jch43rMn97yjVtcPi/sLenK7Db
	 9i0ncbn2YzBrcz7PiIkc0dJc=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DF92E40E020E;
	Tue,  4 Mar 2025 12:43:07 +0000 (UTC)
Date: Tue, 4 Mar 2025 13:43:01 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Rik van Riel <riel@surriel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org
Subject: Re: [PATCH] x86/mm: Always set the ASID valid bit for the INVLPGB
 instruction
Message-ID: <20250304124301.GBZ8b1VR4EgVVf_y-H@fat_crate.local>
References: <20250226030129.530345-1-riel@surriel.com>
 <20250304120449.GHZ8bsYYyEBOKQIxBm@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304120449.GHZ8bsYYyEBOKQIxBm@fat_crate.local>
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04, 2025 at 01:04:49PM +0100, Borislav Petkov wrote:
> @@ -55,9 +82,9 @@ static inline void __invlpgb(unsigned long asid, unsi=
gned long pcid,
>  			     unsigned long addr, u16 nr_pages,
>  			     enum addr_stride stride, u8 flags)
>  {
> -	u32 edx =3D (pcid << 16) | asid;
> +	u64 rax =3D addr | flags | INVLPGB_FLAG_ASID;

So I did it this way instead of how you sent it to me privately and I thi=
nk
doing it this way is equivalent.

However, my Zen3 doesn't like it somehow.

If I zap your patch, it boots fine.

So we need to stare at this some more first...

Thx.

[   13.834550] (sd-mkdcre[570]: Changing mount flags /dev/shm (MS_RDONLY|=
MS_NOSUID|MS_NODEV|MS_NOEXEC|MS_REMOUNT|MS_NOSYMFOLLOW|MS_BIND "")...
[   13.834605] (sd-mkdcre[570]: Moving mount /dev/shm =E2=86=92 /run/cred=
entials/systemd-tmpfiles-setup-dev-early.service (MS_MOVE "")...
[   13.835200] EXT4-fs (sda3): re-mounted 69500787-6b3d-4b03-96d6-6bb2066=
8e924 r/w. Quota mode: none.
[   13.867434] (journald)[561]: systemd-journald.service: Enabled MemoryD=
enyWriteExecute=3D with PR_SET_MDWE
[   13.868764] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/t=
asks: { 8-.... } 8 jiffies s: 129 root: 0x1/.
[   13.868779] rcu: blocking rcu_node structures (internal RCU debug): l=3D=
1:0-15:0x100/.
[   13.868789] Sending NMI from CPU 19 to CPUs 8:
[   13.868797] NMI backtrace for cpu 8
[   13.868799] CPU: 8 UID: 0 PID: 566 Comm: mount Not tainted 6.14.0-rc3+=
 #1
[   13.868802] Hardware name: Supermicro Super Server/H12SSL-i, BIOS 2.5 =
09/08/2022
[   13.868804] RIP: 0010:delay_halt_mwaitx+0x38/0x40
[   13.868809] Code: 31 d2 48 89 d1 48 05 00 60 00 00 0f 01 fa b8 ff ff f=
f ff b9 02 00 00 00 48 39 c6 48 0f 46 c6 48 89 c3 b8 f0 00 00 00 0f 01 fb=
 <5b> e9 cd ea 23 ff 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[   13.868810] RSP: 0018:ffffc90003b67ae0 EFLAGS: 00000097
[   13.868813] RAX: 00000000000000f0 RBX: 0000000000000b9b RCX: 000000000=
0000002
[   13.868814] RDX: 0000000000000000 RSI: 0000000000000b9b RDI: 000000364=
10a0588
[   13.868816] RBP: 00000036410a0588 R08: 000000000000005b R09: 000000000=
0000006
[   13.868817] R10: 0000000000000000 R11: 0000000000000006 R12: 000000000=
0000020
[   13.868818] R13: ffffffff83fb5900 R14: 0000000000000000 R15: 000000000=
0000001
[   13.868819] FS:  00007f04ffb9c800(0000) GS:ffff889002e00000(0000) knlG=
S:0000000000000000
[   13.868821] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.868822] CR2: 00007f92418c8350 CR3: 000000012bbe4004 CR4: 000000000=
0770ef0
[   13.868823] PKRU: 55555554
[   13.868824] Call Trace:
[   13.868826]  <NMI>
[   13.868828]  ? nmi_cpu_backtrace.cold+0x16/0x6b
[   13.868832]  ? nmi_cpu_backtrace_handler+0xd/0x20
[   13.868835]  ? nmi_handle+0xcd/0x240
[   13.868838]  ? delay_halt_mwaitx+0x38/0x40
[   13.868841]  ? default_do_nmi+0x6b/0x180
[   13.868844]  ? exc_nmi+0x12e/0x1c0
[   13.868847]  ? end_repeat_nmi+0xf/0x53
[   13.868854]  ? delay_halt_mwaitx+0x38/0x40
[   13.868857]  ? delay_halt_mwaitx+0x38/0x40
[   13.868860]  ? delay_halt_mwaitx+0x38/0x40
[   13.868863]  </NMI>
[   13.868864]  <TASK>
[   13.868865]  delay_halt+0x3b/0x60
[   13.868868]  wait_for_lsr+0x3f/0xa0
[   13.868873]  serial8250_console_write+0x270/0x670
[   13.868877]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.868879]  ? lock_release+0x183/0x2d0
[   13.868885]  ? console_flush_all+0x381/0x6b0
[   13.868888]  console_flush_all+0x3ad/0x6b0
[   13.868891]  ? console_flush_all+0x381/0x6b0
[   13.868893]  ? console_flush_all+0x39/0x6b0
[   13.868900]  console_unlock+0x157/0x240
[   13.868904]  vprintk_emit+0x304/0x550
[   13.868910]  _printk+0x58/0x80
[   13.868914]  ? ___ratelimit+0x85/0x100
[   13.868919]  __ext4_msg.cold+0x7f/0x84
[   13.868926]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.868928]  ? ext4_register_li_request+0x1c9/0x2a0
[   13.868933]  ext4_reconfigure+0x503/0xc40
[   13.868939]  ? shrink_dentry_list+0x17/0x320
[   13.868942]  ? shrink_dentry_list+0x89/0x320
[   13.868944]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.868946]  ? shrink_dentry_list+0x16c/0x320
[   13.868953]  reconfigure_super+0xc5/0x210
[   13.868958]  __do_sys_fsconfig+0x607/0x750
[   13.868967]  do_syscall_64+0x5d/0x100
[   13.868970]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   13.868973] RIP: 0033:0x7f04ffdb481a
[   13.868976] Code: 73 01 c3 48 8b 0d 06 56 0d 00 f7 d8 64 89 01 48 83 c=
8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 af 01 00 00 0f 05=
 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d6 55 0d 00 f7 d8 64 89 01 48
[   13.868977] RSP: 002b:00007ffe3e177008 EFLAGS: 00000246 ORIG_RAX: 0000=
0000000001af
[   13.868980] RAX: ffffffffffffffda RBX: 000055ab49f74a50 RCX: 00007f04f=
fdb481a
[   13.868981] RDX: 0000000000000000 RSI: 0000000000000007 RDI: 000000000=
0000004
[   13.868982] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000=
0000001
[   13.868983] R10: 0000000000000000 R11: 0000000000000246 R12: 000055ab4=
9f75ee0
[   13.868984] R13: 00007f04fff3b5e0 R14: 00007f04fff3d244 R15: 000000000=
0000065
[   13.868993]  </TASK>
[   13.880199] (tmpfiles)[564]: (sd-mkdcreds) succeeded.
[   13.936943] (journald)[561]: Restricting namespace to: n/a.
[   13.937918] (tmpfiles)[564]: systemd-tmpfiles-setup-dev-early.service:=
 Executing: systemd-tmpfiles --prefix=3D/dev --create --boot --graceful
[   14.025641] (journald)[561]: systemd-journald.service: Executing: /usr=
/lib/systemd/systemd-journald
[   14.137455] ACPI: bus type drm_connector registered
[   14.306514] (udevadm)[569]: Found cgroup2 on /sys/fs/cgroup/, full uni=
fied hierarchy
[   14.357107] (udevadm)[569]: Found cgroup2 on /sys/fs/cgroup/, full uni=
fied hierarch

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

