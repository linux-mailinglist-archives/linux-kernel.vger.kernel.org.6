Return-Path: <linux-kernel+bounces-544971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEADA4E737
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BCDD19C5425
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BF5204F76;
	Tue,  4 Mar 2025 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lwlAHIjY"
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC9A2BF3E8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105860; cv=fail; b=p0RJ4yWXc8j1YP9olOAaI+xlN14FsSt2vI2mjiNv+vDlkJ/A7FNBQ44rHOQ9OBDoS0dYUxFFkPhFVoR0OnEOuaNc05zGiuMAaGelV+1QC34ahLNHP7WfS97BmyqqGBCpGpkNv5BcrVMKF4/29fE7GckFKYznIjz5KoxwiqoNZVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105860; c=relaxed/simple;
	bh=xJ7qrJcx9DMfJ3i1R5ZB5T8RZ05dQ7QdpBwe9ffg8sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/iAsbpo5puU7pxF9wxeZ07APNYV5/ILGbc5EKMZxdPPmYZCTisuTTmYL6zg6EeaPhtrA3ZccIzcab+idS0fScTlEMyY0pYMpvcMD07DX3DVH3noudCKErjA0YUY+obEvsQdAJCm9sGZbMDrrqrTbZhZ1QgfwiyzUCv2gyWprx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lwlAHIjY reason="signature verification failed"; arc=none smtp.client-ip=90.155.50.34; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; arc=fail smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id C9E92408B5F6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:30:52 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6h2701x1zG3MR
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:28:31 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 5D92F42721; Tue,  4 Mar 2025 19:28:18 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lwlAHIjY
X-Envelope-From: <linux-kernel+bounces-541853-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lwlAHIjY
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id D54B141A5E
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:52:07 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 8D1722DCE0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:52:07 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B935189225D
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10642212FA6;
	Mon,  3 Mar 2025 13:51:59 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1DB86347
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741009897; cv=none; b=jtssGrAFgN5N79pEFKkB3T3Uv6kt+2HcLUOMNl44/zcIPBWnkenAlcApNiA/7d9JzheprG2bP7kEeZX3X9uSgN21ip3+tORkHq+OQSeuz1efjtNkfR0UUt4aT8x6n4luP8db6CNkE0PE8KewRmf45gUQZtx8O1DlKCGuqd4pX/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741009897; c=relaxed/simple;
	bh=Ew/LklLoG5+ZT9ECuZl+mla/V6LBUTuVrWfrtvHBCfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKUrrOU8qZc+BGJUJk2QXwmaalNOMq0ngAebi0fU1KARKOodF58HJ21yYlApyh50dvB1EbmHLTyS59mrSVqTYAmhhegHjp8w0FYtVAXUr6SMexwPKdEaZTo1BHMsHsWhvqd47nApCjd9vZGaC0/Gcmu7rgNu8G7vsvTPJWM5odI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lwlAHIjY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=p3eNUsHiTW+3oaB2nrqccfPwHPGyT7OGJkYdsWliohY=; b=lwlAHIjY+jPlxfw8Tsad+PrirM
	xQAh3WNjjoD434SxFgrnd6IQKRw4Tg3oFkPL8fC/4H+n5AH3tSL8CQ7am4pxgFjdTbsmy0Hm+ZkAb
	Aj0TXLkvsKIRfdWvMOTXXPeXIx9+PbAdr4/ASYgBV8S0RtrbNyiYwt2739IuYDsJ2U3HCl/5rLfto
	+N+Q4wo5pkhZxNQCja6N2rbS9oUZyqT48QoSn72H1aq6kXLjFm02h9pzzo1A7Zfg9pnJ+8h0Gp9fA
	+dcx/GNT3b2yeriLRWUQrE94MMZcyfF2F86tiKkx3UBCM4GDa2HsC0VQqFEvAx+XQuqBm3yXCuIls
	4HBjRk2w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tp6CY-0000000Bhwj-0sC7;
	Mon, 03 Mar 2025 13:51:22 +0000
Date: Mon, 3 Mar 2025 13:51:22 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Strforexc yn <strforexc@gmail.com>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 __put_partials in v6.14-rc4 kernel
Message-ID: <Z8Wz2gHTExGSn7aJ@casper.infradead.org>
References: <CA+HokZoY0G17a23oCyCXVGokv9z7EEaWrx_N7eAntTqDwoh1VA@mail.gmail.com>
 <60041596-5921-4f9c-9892-b0fb84b21086@suse.cz>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60041596-5921-4f9c-9892-b0fb84b21086@suse.cz>
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6h2701x1zG3MR
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741710532.50843@OA1IW9orETdacKkvXBo+ag
X-ITU-MailScanner-SpamCheck: not spam

On Mon, Mar 03, 2025 at 12:46:59PM +0100, Vlastimil Babka wrote:
> On 3/3/25 02:31, Strforexc yn wrote:
> > Dear Maintainers, When using our customized Syzkaller to fuzz the
> > latest Linux kernel, the following crash was triggered.
> >=20
> > Kernel commit: v6.14-rc4 (Commits on Feb 24, 2025)
> > Kernel Config : https://github.com/Strforexc/LinuxKernelbug/blob/main=
/.config
> > Kernel Log: attachment
> > Reproduce: attachment
> >=20
> > I=E2=80=99ve encountered a NULL pointer dereference in the SLUB alloc=
ator on
> > Linux 6.14.0-rc4, causing a kernel panic. Here are the details:

There's also a bcachefs memory corruptor in this kernel version, so
it might be nothing to do with slab.

> > A NULL pointer dereference occurs at address 0x11 in __put_partials
> > (mm/slub.c:3125), triggered during a slab flush operation. The
> > faulting instruction attempts to access slab->next from an invalid
> > pointer (0x1), crashing the kernel.
> >=20
> > Possible Issues:
> > 1.Corruption: A prior SLUB operation (e.g., allocation/freeing) may
> > have corrupted the partial slab list.
> > 2. Race: A race between slab operations and flush_cpu_slab could leav=
e
> > an invalid pointer, despite spin_lock_irqsave protection.
>=20
> It's also a single bit flip, so it could be an hardware error. Does thi=
s
> happen only one a particular machine and is the machine exhibiting diff=
erent
> errors?
>=20
> And, if the issue is new in 6.14, could it be bisected?
>=20
> I don't think the SLUB implementation has changed in partial list handl=
ing
> recently, and the next pointer is not in union with anything that could
> possibly write 1 to it, AFAICS.
>=20
> > Context: Occurs during a routine slab flush via slub_flushwq, with no
> > modules loaded, pointing to a core SLUB bug
> >=20
> > Could SLUB maintainers investigate? This might be:
> > 1. A corruption in partial slab management (e.g., add_partial or disc=
ard_slab).
> > 2. A concurrency issue in flush_cpu_slab scheduling. Suggested checks=
:
> > 3. Validate partial_slab before entering the loop in __put_partials.
> > 4. Audit SLUB list operations for race conditions.
> >=20
> > Our knowledge of the kernel is somewhat limited, and we'd appreciate
> > it if you could determine if there is such an issue. If this issue
> > doesn't have an impact, please ignore it =E2=98=BA.
> > If you fix this issue, please add the following tag to the commit:
> > Reported-by: Zhizhuo Tang <strforexctzzchange@foxmail.com>, Jianzhou
> > Zhao <xnxc22xnxc22@qq.com>, Haoran Liu <cherest_san@163.com>
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: kernel NULL pointer dereference, address: 0000000000000011
> > #PF: supervisor read access in kernel mode
> > #PF: error_code(0x0000) - not-present page
> > PGD 800000004af87067 P4D 800000004af87067 PUD 0
> > Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
> > CPU: 0 UID: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.14.0-rc4 #1
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 =
04/01/2014
> > Workqueue: slub_flushwq flush_cpu_slab
> > RIP: 0010:__put_partials+0x8a/0x190 mm/slub.c:3125
> > Code: 50 49 89 54 24 10 4d 89 7c 24 18 49 89 3f 4c 89 e7 e8 9a 98 ff
> > ff f0 80 48 01 02 48 85 db 0f 84 91 00 00 00 48 89 ef 49 89 dc <48> 8=
b
> > 5b 10 49 8b 04 24 48 83 f8 ff 74 6b 49 8b 04 24 48 c1 e8 3a
> > RSP: 0018:ffffc900001afc20 EFLAGS: 00010282
> > RAX: 0000000000000046 RBX: 0000000000000001 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> > RBP: ffff88802b638fa0 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
> > R13: 0000000000000000 R14: ffff88804619d780 R15: ffff88801b496800
> > FS:  0000000000000000(0000) GS:ffff88802b600000(0000) knlGS:000000000=
0000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000000011 CR3: 0000000049314000 CR4: 00000000000006f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  process_one_work+0x109d/0x18c0 kernel/workqueue.c:3236
> >  process_scheduled_works kernel/workqueue.c:3317 [inline]
> >  worker_thread+0x677/0xe90 kernel/workqueue.c:3398
> >  kthread+0x3b3/0x760 kernel/kthread.c:464
> >  ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:148
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >  </TASK>
> > Modules linked in:
> > CR2: 0000000000000011
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:__put_partials+0x8a/0x190 mm/slub.c:3125
> > Code: 50 49 89 54 24 10 4d 89 7c 24 18 49 89 3f 4c 89 e7 e8 9a 98 ff
> > ff f0 80 48 01 02 48 85 db 0f 84 91 00 00 00 48 89 ef 49 89 dc <48> 8=
b
> > 5b 10 49 8b 04 24 48 83 f8 ff 74 6b 49 8b 04 24 48 c1 e8 3a
> > RSP: 0018:ffffc900001afc20 EFLAGS: 00010282
> > RAX: 0000000000000046 RBX: 0000000000000001 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> > RBP: ffff88802b638fa0 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
> > R13: 0000000000000000 R14: ffff88804619d780 R15: ffff88801b496800
> > FS:  0000000000000000(0000) GS:ffff88802b600000(0000) knlGS:000000000=
0000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000000011 CR3: 0000000049314000 CR4: 00000000000006f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > ----------------
> > Code disassembly (best guess):
> >    0: 50                   push   %rax
> >    1: 49 89 54 24 10       mov    %rdx,0x10(%r12)
> >    6: 4d 89 7c 24 18       mov    %r15,0x18(%r12)
> >    b: 49 89 3f             mov    %rdi,(%r15)
> >    e: 4c 89 e7             mov    %r12,%rdi
> >   11: e8 9a 98 ff ff       call   0xffff98b0
> >   16: f0 80 48 01 02       lock orb $0x2,0x1(%rax)
> >   1b: 48 85 db             test   %rbx,%rbx
> >   1e: 0f 84 91 00 00 00     je     0xb5
> >   24: 48 89 ef             mov    %rbp,%rdi
> >   27: 49 89 dc             mov    %rbx,%r12
> > * 2a: 48 8b 5b 10           mov    0x10(%rbx),%rbx <-- trapping instr=
uction
> >   2e: 49 8b 04 24           mov    (%r12),%rax
> >   32: 48 83 f8 ff           cmp    $0xffffffffffffffff,%rax
> >   36: 74 6b                 je     0xa3
> >   38: 49 8b 04 24           mov    (%r12),%rax
> >   3c: 48 c1 e8 3a           shr    $0x3a,%rax
> >=20
> > Thanks,
> > Zhizhuo Tang
> >=20
> >=20
> > repro.log
> >=20
> > Warning: Permanently added '[localhost]:43678' (ED25519) to the list =
of known hosts.
> > Setting up swapspace version 1, size =3D 122.1 MiB (127995904 bytes)
> > no label, UUID=3D9df35e88-3d46-4e7f-9ff2-f112c2d2e98f
> > syzkaller login: [  105.561984][ T9404] Adding 124996k swap on ./swap=
-file.  Priority:0 extents:1 across:124996k=20
> > [  105.907025][ T1069] wlan0: Created IBSS using preconfigured BSSID =
50:50:50:50:50:50
> > [  105.907784][ T1069] wlan0: Creating new IBSS network, BSSID 50:50:=
50:50:50:50
> > [  105.936640][   T32] wlan0: Created IBSS using preconfigured BSSID =
50:50:50:50:50:50
> > [  105.937341][   T32] wlan0: Creating new IBSS network, BSSID 50:50:=
50:50:50:50
> > [  105.960801][ T1069] wlan0: Created IBSS using preconfigured BSSID =
50:50:50:50:50:50
> > [  105.961465][ T1069] wlan0: Creating new IBSS network, BSSID 50:50:=
50:50:50:50
> > [  105.985101][ T1069] wlan0: Created IBSS using preconfigured BSSID =
50:50:50:50:50:50
> > [  105.985771][ T1069] wlan0: Creating new IBSS network, BSSID 50:50:=
50:50:50:50
> > [  106.005136][  T236] wlan1: Created IBSS using preconfigured BSSID =
50:50:50:50:50:50
> > [  106.005849][  T236] wlan1: Creating new IBSS network, BSSID 50:50:=
50:50:50:50
> > [  106.037265][   T27] wlan1: Created IBSS using preconfigured BSSID =
50:50:50:50:50:50
> > [  106.037931][   T27] wlan1: Creating new IBSS network, BSSID 50:50:=
50:50:50:50
> > [  106.075552][   T27] wlan0: Created IBSS using preconfigured BSSID =
50:50:50:50:50:50
> > [  106.076209][   T27] wlan0: Creating new IBSS network, BSSID 50:50:=
50:50:50:50
> > [  106.114709][ T1069] wlan1: Created IBSS using preconfigured BSSID =
50:50:50:50:50:50
> > [  106.115402][ T1069] wlan1: Creating new IBSS network, BSSID 50:50:=
50:50:50:50
> > executing program
> > executing program
> > [  106.138641][ T1069] wlan1: Created IBSS using preconfigured BSSID =
50:50:50:50:50:50
> > [  106.139328][ T1069] wlan1: Creating new IBSS network, BSSID 50:50:=
50:50:50:50
> > [  106.171301][ T1069] wlan0: Created IBSS using preconfigured BSSID =
50:50:50:50:50:50
> > [  106.172771][ T1069] wlan0: Creating new IBSS network, BSSID 50:50:=
50:50:50:50
> > [  106.238033][   T32] wlan1: Created IBSS using preconfigured BSSID =
50:50:50:50:50:50
> > [  106.238714][   T32] wlan1: Creating new IBSS network, BSSID 50:50:=
50:50:50:50
> > executing program
> > executing program
> > [  106.313594][  T236] wlan1: Created IBSS using preconfigured BSSID =
50:50:50:50:50:50
> > [  106.314294][  T236] wlan1: Creating new IBSS network, BSSID 50:50:=
50:50:50:50
> > executing program
> > executing program
> > [  106.620920][ T9598] loop4: detected capacity change from 0 to 3276=
8
> > [  106.658508][ T9602] loop3: detected capacity change from 0 to 3276=
8
> > [  106.757753][ T9621] loop5: detected capacity change from 0 to 3276=
8
> > [  106.776133][ T9627] loop1: detected capacity change from 0 to 3276=
8
> > [  106.826931][ T9602] bcachefs (loop3): starting version 1.7: mi_btr=
ee_bitmap opts=3Ddata_checksum=3Dcrc64,str_hash=3Dcrc64,nojournal_transac=
tion_names,nocow
> > [  106.832716][ T9602] bcachefs (loop3): recovering from clean shutdo=
wn, journal seq 10
> > [  106.833561][ T9602] bcachefs (loop3): Doing compatible version upg=
rade from 1.7: mi_btree_bitmap to 1.20: directory_size
> > [  106.833561][ T9602]   running recovery passes: check_allocations,c=
heck_extents_to_backpointers,check_inodes,check_dirents
> > [  106.838664][ T9598] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  106.839617][ T9598] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  106.867787][ T9627] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  106.868626][ T9627] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  106.882863][ T9621] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  106.883664][ T9621] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  106.915366][ T9602] bcachefs (loop3): accounting_read... done
> > [  106.920530][ T9602] bcachefs (loop3): alloc_read... done
> > [  106.921051][ T9602] bcachefs (loop3): stripes_read... done
> > [  106.921568][ T9602] bcachefs (loop3): snapshots_read... done
> > [  106.932033][ T9602] bcachefs (loop3): check_allocations...
> > [  106.933695][ T9602] btree ptr not marked in member info btree allo=
cated bitmap
> > [  106.933716][ T9602]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 4fe84214937890c3 written 32 min_key POS_MIN durability: 1 ptr: 0:=
26:0 gen 0, fixing
> > [  106.946678][ T9602] btree ptr not marked in member info btree allo=
cated bitmap
> > [  106.946693][ T9602]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq a22d880bb51b703b written 24 min_key POS_MIN durability: 1 ptr: 0:=
38:0 gen 0, fixing
> > [  106.968648][ T9602] btree ptr not marked in member info btree allo=
cated bitmap
> > [  106.968662][ T9602]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq b5d608e41b3af1cf written 24 min_key POS_MIN durability: 1 ptr: 0:=
41:0 gen 0, fixing
> > [  106.980334][ T9602] btree ptr not marked in member info btree allo=
cated bitmap
> > [  106.980348][ T9602]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 92b180ffcc5b04f1 written 16 min_key POS_MIN durability: 1 ptr: 0:=
35:0 gen 0, fixing
> > [  106.983622][ T9631] loop0: detected capacity change from 0 to 3276=
8
> > [  106.998953][ T9602] btree ptr not marked in member info btree allo=
cated bitmap
> > [  106.998967][ T9602]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 8aae33f84eb959b0 written 16 min_key POS_MIN durability: 1 ptr: 0:=
32:0 gen 0, fixing
> > [  107.033611][ T9602] btree ptr not marked in member info btree allo=
cated bitmap
> > [  107.033625][ T9602]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 487388c888b02d23 written 32 min_key POS_MIN durability: 1 ptr: 0:=
29:0 gen 0, fixing
> > [  107.053368][ T9602]  done
> > [  107.057203][ T9602] bcachefs (loop3): going read-write
> > [  107.062978][ T9633] loop2: detected capacity change from 0 to 3276=
8
> > [  107.076933][ T9602] bcachefs (loop3): journal_replay...
> > [  107.083776][ T9598] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  107.089126][ T9621] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  107.092359][ T9627] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  107.204172][ T9602]  done
> > [  107.206340][ T9602] bcachefs (loop3): check_extents_to_backpointer=
s...
> > [  107.207223][ T9602] bcachefs (loop3): scanning for missing backpoi=
nters in 6/128 buckets
> > [  107.209001][ T9602]  done
> > [  107.214315][ T9631] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  107.215134][ T9631] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  107.254461][ T9602] bcachefs (loop3): check_inodes... done
> > [  107.261832][ T9633] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  107.282531][ T9602] bcachefs (loop3): check_dirents...
> > [  107.283399][ T9602] directory 4096:4294967295 with wrong i_size: g=
ot 0, should be 352, fixing
> > [  107.284923][ T9602]  done
> > [  107.295694][ T9633] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  107.302700][ T9602] bcachefs (loop3): resume_logged_ops... done
> > [  107.303277][ T9602] bcachefs (loop3): delete_dead_inodes... done
> > [  107.312999][ T9602] bcachefs (loop3): Fixed errors, running fsck a=
 second time to verify fs is clean
> > [  107.313784][ T9602] bcachefs (loop3): check_extents_to_backpointer=
s... done
> > [  107.320665][ T9602] bcachefs (loop3): check_inodes... done
> > [  107.321857][ T9602] bcachefs (loop3): check_dirents... done
> > [  107.351583][ T9602] bcachefs (loop3): resume_logged_ops... done
> > [  107.352763][ T9602] bcachefs (loop3): delete_dead_inodes... done
> > [  107.387023][ T9602] bcachefs (loop3): done starting filesystem
> > [  107.412807][ T9631] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  107.515014][ T9633] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  107.571280][ T9621] loop5: detected capacity change from 0 to 4042=
7
> > [  107.629078][ T9621] F2FS-fs (loop5): Found nat_bits in checkpoint
> > [  107.752793][ T9621] F2FS-fs (loop5): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  107.804096][ T9423] syz-executor182: attempt to access beyond end =
of device
> > [  107.804096][ T9423] loop5: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  107.806078][ T9423] F2FS-fs (loop5): Stopped filesystem due to rea=
son: 3
> > [  108.071771][ T9598] loop4: detected capacity change from 0 to 4042=
7
> > [  108.176496][ T9627] loop1: detected capacity change from 0 to 4042=
7
> > [  108.177964][ T9598] F2FS-fs (loop4): Found nat_bits in checkpoint
> > [  108.216050][ T9627] F2FS-fs (loop1): Found nat_bits in checkpoint
> > [  108.282027][ T9598] F2FS-fs (loop4): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  108.291145][ T9414] syz-executor182: attempt to access beyond end =
of device
> > [  108.291145][ T9414] loop4: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  108.292942][ T9414] F2FS-fs (loop4): Stopped filesystem due to rea=
son: 3
> > [  108.327484][ T9627] F2FS-fs (loop1): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  108.338610][ T9415] syz-executor182: attempt to access beyond end =
of device
> > [  108.338610][ T9415] loop1: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  108.339882][ T9415] F2FS-fs (loop1): Stopped filesystem due to rea=
son: 3
> > executing program
> > [  108.440251][ T9631] loop0: detected capacity change from 0 to 4042=
7
> > [  108.473459][ T9631] F2FS-fs (loop0): Found nat_bits in checkpoint
> > [  108.514963][ T9602] syz-executor182 (9602) used greatest stack dep=
th: 17016 bytes left
> > [  108.518794][ T9633] loop2: detected capacity change from 0 to 4042=
7
> > [  108.534582][ T9411] bcachefs (loop3): shutting down
> > [  108.535183][ T9411] bcachefs (loop3): going read-only
> > [  108.535917][ T9411] bcachefs (loop3): finished waiting for writes =
to stop
> > [  108.537988][ T9411] bcachefs (loop3): flushing journal and stoppin=
g allocators, journal seq 19
> > [  108.539126][ T9411] bcachefs (loop3): flushing journal and stoppin=
g allocators complete, journal seq 19
> > [  108.540275][ T9631] F2FS-fs (loop0): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  108.553136][ T9411] bcachefs (loop3): clean shutdown complete, jou=
rnal seq 20
> > [  108.554921][ T9419] syz-executor182: attempt to access beyond end =
of device
> > [  108.554921][ T9419] loop0: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  108.556135][ T9419] F2FS-fs (loop0): Stopped filesystem due to rea=
son: 3
> > [  108.561506][ T9411] bcachefs (loop3): marking filesystem clean
> > [  108.581184][ T9633] F2FS-fs (loop2): Found nat_bits in checkpoint
> > [  108.652305][ T9411] bcachefs (loop3): shutdown complete
> > [  108.674436][ T9633] F2FS-fs (loop2): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  108.689978][ T9416] syz-executor182: attempt to access beyond end =
of device
> > [  108.689978][ T9416] loop2: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  108.691171][ T9416] F2FS-fs (loop2): Stopped filesystem due to rea=
son: 3
> > executing program
> > executing program
> > [  108.909694][ T9728] loop5: detected capacity change from 0 to 3276=
8
> > executing program
> > [  109.128813][ T9747] loop4: detected capacity change from 0 to 3276=
8
> > [  109.177951][ T9758] loop0: detected capacity change from 0 to 3276=
8
> > executing program
> > [  109.238405][ T9749] loop1: detected capacity change from 0 to 3276=
8
> > [  109.375099][ T9770] loop2: detected capacity change from 0 to 3276=
8
> > [  109.410860][ T9728] bcachefs (loop5): starting version 1.7: mi_btr=
ee_bitmap opts=3Ddata_checksum=3Dcrc64,str_hash=3Dcrc64,nojournal_transac=
tion_names,nocow
> > [  109.416248][ T9728] bcachefs (loop5): recovering from clean shutdo=
wn, journal seq 10
> > [  109.417009][ T9728] bcachefs (loop5): Doing compatible version upg=
rade from 1.7: mi_btree_bitmap to 1.20: directory_size
> > [  109.417009][ T9728]   running recovery passes: check_allocations,c=
heck_extents_to_backpointers,check_inodes,check_dirents
> > [  109.433569][ T9728] bcachefs (loop5): accounting_read... done
> > [  109.434582][ T9728] bcachefs (loop5): alloc_read... done
> > [  109.435083][ T9728] bcachefs (loop5): stripes_read... done
> > [  109.435594][ T9728] bcachefs (loop5): snapshots_read... done
> > [  109.436146][ T9728] bcachefs (loop5): check_allocations...
> > [  109.441522][ T9728] btree ptr not marked in member info btree allo=
cated bitmap
> > [  109.441544][ T9728]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 4fe84214937890c3 written 32 min_key POS_MIN durability: 1 ptr: 0:=
26:0 gen 0, fixing
> > [  109.446395][ T9728] btree ptr not marked in member info btree allo=
cated bitmap
> > [  109.446407][ T9728]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq a22d880bb51b703b written 24 min_key POS_MIN durability: 1 ptr: 0:=
38:0 gen 0, fixing
> > [  109.448995][ T9728] btree ptr not marked in member info btree allo=
cated bitmap
> > [  109.449006][ T9728]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq b5d608e41b3af1cf written 24 min_key POS_MIN durability: 1 ptr: 0:=
41:0 gen 0, fixing
> > [  109.451727][ T9728] btree ptr not marked in member info btree allo=
cated bitmap
> > [  109.451737][ T9728]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 92b180ffcc5b04f1 written 16 min_key POS_MIN durability: 1 ptr: 0:=
35:0 gen 0, fixing
> > [  109.463293][ T9728] btree ptr not marked in member info btree allo=
cated bitmap
> > [  109.463306][ T9728]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 8aae33f84eb959b0 written 16 min_key POS_MIN durability: 1 ptr: 0:=
32:0 gen 0, fixing
> > [  109.473521][ T9728] btree ptr not marked in member info btree allo=
cated bitmap
> > [  109.473554][ T9728]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 487388c888b02d23 written 32 min_key POS_MIN durability: 1 ptr: 0:=
29:0 gen 0, fixing
> > [  109.476337][ T9758] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  109.477109][ T9758] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  109.485949][ T9770] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  109.500172][ T9728]  done
> > [  109.501999][ T9770] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  109.504480][ T9747] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  109.505261][ T9747] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  109.520263][ T9749] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  109.521083][ T9749] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  109.549414][ T9728] bcachefs (loop5): going read-write
> > [  109.556831][ T9728] bcachefs (loop5): journal_replay...
> > [  109.577825][ T9758] bcachefs: bch2_fs_get_tree() error: EINVAL
> > executing program
> > [  109.676822][ T9728]  done
> > [  109.682274][ T9728] bcachefs (loop5): check_extents_to_backpointer=
s...
> > [  109.683265][ T9728] bcachefs (loop5): scanning for missing backpoi=
nters in 6/128 buckets
> > [  109.686049][ T9747] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  109.698759][ T9728]  done
> > [  109.704094][ T9770] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  109.722687][ T9728] bcachefs (loop5): check_inodes... done
> > [  109.732368][ T9728] bcachefs (loop5): check_dirents...
> > [  109.733059][ T9728] directory 4096:4294967295 with wrong i_size: g=
ot 0, should be 352, fixing
> > [  109.734501][ T9728]  done
> > [  109.743226][ T9728] bcachefs (loop5): resume_logged_ops... done
> > [  109.743855][ T9728] bcachefs (loop5): delete_dead_inodes... done
> > [  109.746806][ T9728] bcachefs (loop5): Fixed errors, running fsck a=
 second time to verify fs is clean
> > [  109.747600][ T9728] bcachefs (loop5): check_extents_to_backpointer=
s... done
> > [  109.748810][ T9728] bcachefs (loop5): check_inodes... done
> > [  109.749712][ T9728] bcachefs (loop5): check_dirents... done
> > [  109.750811][ T9728] bcachefs (loop5): resume_logged_ops... done
> > [  109.751367][ T9728] bcachefs (loop5): delete_dead_inodes... done
> > [  109.762233][ T9749] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  109.792410][ T9728] bcachefs (loop5): done starting filesystem
> > [  110.166735][ T9803] loop3: detected capacity change from 0 to 3276=
8
> > [  110.262594][ T9803] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  110.263412][ T9803] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  110.345408][ T9747] loop4: detected capacity change from 0 to 4042=
7
> > [  110.369784][ T9747] F2FS-fs (loop4): Found nat_bits in checkpoint
> > [  110.449438][ T9803] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  110.449971][ T9747] F2FS-fs (loop4): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  110.457656][ T9758] loop0: detected capacity change from 0 to 4042=
7
> > [  110.492122][ T9414] syz-executor182: attempt to access beyond end =
of device
> > [  110.492122][ T9414] loop4: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  110.493412][ T9414] F2FS-fs (loop4): Stopped filesystem due to rea=
son: 3
> > [  110.546926][ T9758] F2FS-fs (loop0): Found nat_bits in checkpoint
> > [  110.642130][ T9758] F2FS-fs (loop0): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  110.667665][ T9770] loop2: detected capacity change from 0 to 4042=
7
> > [  110.679576][ T9419] syz-executor182: attempt to access beyond end =
of device
> > [  110.679576][ T9419] loop0: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  110.680792][ T9419] F2FS-fs (loop0): Stopped filesystem due to rea=
son: 3
> > [  110.723400][ T9770] F2FS-fs (loop2): Found nat_bits in checkpoint
> > [  110.739053][ T9749] loop1: detected capacity change from 0 to 4042=
7
> > [  110.791849][ T9749] F2FS-fs (loop1): Found nat_bits in checkpoint
> > [  110.802783][ T9770] F2FS-fs (loop2): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  110.838987][ T9728] syz-executor182 (9728) used greatest stack dep=
th: 16720 bytes left
> > [  110.840151][ T9416] syz-executor182: attempt to access beyond end =
of device
> > [  110.840151][ T9416] loop2: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  110.841435][ T9416] F2FS-fs (loop2): Stopped filesystem due to rea=
son: 3
> > [  110.852235][ T9423] bcachefs (loop5): shutting down
> > [  110.852696][ T9423] bcachefs (loop5): going read-only
> > [  110.853124][ T9423] bcachefs (loop5): finished waiting for writes =
to stop
> > [  110.858580][ T9423] bcachefs (loop5): flushing journal and stoppin=
g allocators, journal seq 19
> > [  110.859369][ T9423] bcachefs (loop5): flushing journal and stoppin=
g allocators complete, journal seq 19
> > [  110.861254][ T9423] bcachefs (loop5): clean shutdown complete, jou=
rnal seq 20
> > [  110.862602][ T9423] bcachefs (loop5): marking filesystem clean
> > [  110.873613][ T9749] F2FS-fs (loop1): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  110.903029][ T9415] syz-executor182: attempt to access beyond end =
of device
> > [  110.903029][ T9415] loop1: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  110.904242][ T9415] F2FS-fs (loop1): Stopped filesystem due to rea=
son: 3
> > [  110.939431][ T9423] bcachefs (loop5): shutdown complete
> > executing program
> > executing program
> > [  111.113762][ T9803] loop3: detected capacity change from 0 to 4042=
7
> > [  111.117385][ T9803] F2FS-fs (loop3): Found nat_bits in checkpoint
> > [  111.177503][ T9803] F2FS-fs (loop3): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  111.223132][ T9411] syz-executor182: attempt to access beyond end =
of device
> > [  111.223132][ T9411] loop3: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  111.224302][ T9411] F2FS-fs (loop3): Stopped filesystem due to rea=
son: 3
> > executing program
> > executing program
> > [  111.376673][ T9859] loop4: detected capacity change from 0 to 3276=
8
> > [  111.415647][ T9861] loop0: detected capacity change from 0 to 3276=
8
> > [  111.534212][ T9873] loop1: detected capacity change from 0 to 3276=
8
> > executing program
> > [  111.658651][ T9874] loop2: detected capacity change from 0 to 3276=
8
> > [  111.781284][ T9896] loop3: detected capacity change from 0 to 3276=
8
> > [  111.855673][ T9859] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  111.855867][ T9861] bcachefs (loop0): starting version 1.7: mi_btr=
ee_bitmap opts=3Ddata_checksum=3Dcrc64,str_hash=3Dcrc64,nojournal_transac=
tion_names,nocow
> > [  111.857751][ T9861] bcachefs (loop0): recovering from clean shutdo=
wn, journal seq 10
> > [  111.858467][ T9861] bcachefs (loop0): Doing compatible version upg=
rade from 1.7: mi_btree_bitmap to 1.20: directory_size
> > [  111.858467][ T9861]   running recovery passes: check_allocations,c=
heck_extents_to_backpointers,check_inodes,check_dirents
> > [  111.865562][ T9859] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  111.867235][ T9873] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  111.868040][ T9873] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  111.879289][ T9874] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  111.880157][ T9874] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  111.881406][ T9896] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  111.883824][ T9861] bcachefs (loop0): accounting_read... done
> > [  111.891982][ T9861] bcachefs (loop0): alloc_read... done
> > [  111.892514][ T9861] bcachefs (loop0): stripes_read... done
> > [  111.893029][ T9861] bcachefs (loop0): snapshots_read... done
> > [  111.897399][ T9861] bcachefs (loop0): check_allocations...
> > [  111.898315][ T9861] btree ptr not marked in member info btree allo=
cated bitmap
> > [  111.898327][ T9861]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 4fe84214937890c3 written 32 min_key POS_MIN durability: 1 ptr: 0:=
26:0 gen 0, fixing
> > [  111.907178][ T9861] btree ptr not marked in member info btree allo=
cated bitmap
> > [  111.907192][ T9861]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq a22d880bb51b703b written 24 min_key POS_MIN durability: 1 ptr: 0:=
38:0 gen 0, fixing
> > [  111.912411][ T9861] btree ptr not marked in member info btree allo=
cated bitmap
> > [  111.912423][ T9861]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq b5d608e41b3af1cf written 24 min_key POS_MIN durability: 1 ptr: 0:=
41:0 gen 0, fixing
> > [  111.916616][ T9861] btree ptr not marked in member info btree allo=
cated bitmap
> > [  111.916627][ T9861]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 92b180ffcc5b04f1 written 16 min_key POS_MIN durability: 1 ptr: 0:=
35:0 gen 0, fixing
> > [  111.919132][ T9861] btree ptr not marked in member info btree allo=
cated bitmap
> > [  111.919143][ T9861]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 8aae33f84eb959b0 written 16 min_key POS_MIN durability: 1 ptr: 0:=
32:0 gen 0, fixing
> > [  111.921665][ T9861] btree ptr not marked in member info btree allo=
cated bitmap
> > [  111.921675][ T9861]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 487388c888b02d23 written 32 min_key POS_MIN durability: 1 ptr: 0:=
29:0 gen 0, fixing
> > [  111.924807][ T9896] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  111.927759][ T9861]  done
> > [  111.934163][ T9861] bcachefs (loop0): going read-write
> > [  111.936747][ T9861] bcachefs (loop0): journal_replay... done
> > [  111.972967][ T9861] bcachefs (loop0): check_extents_to_backpointer=
s...
> > [  111.973779][ T9861] bcachefs (loop0): scanning for missing backpoi=
nters in 6/128 buckets
> > [  111.975451][ T9861]  done
> > [  111.977086][ T9861] bcachefs (loop0): check_inodes... done
> > [  111.978528][ T9861] bcachefs (loop0): check_dirents...
> > [  111.979162][ T9861] directory 4096:4294967295 with wrong i_size: g=
ot 0, should be 352, fixing
> > [  111.980620][ T9861]  done
> > [  111.984071][ T9861] bcachefs (loop0): resume_logged_ops... done
> > [  111.984641][ T9861] bcachefs (loop0): delete_dead_inodes... done
> > [  111.991895][ T9861] bcachefs (loop0): Fixed errors, running fsck a=
 second time to verify fs is clean
> > [  111.993635][ T9861] bcachefs (loop0): check_extents_to_backpointer=
s... done
> > [  111.994878][ T9861] bcachefs (loop0): check_inodes... done
> > [  111.999230][ T9861] bcachefs (loop0): check_dirents... done
> > [  112.000361][ T9861] bcachefs (loop0): resume_logged_ops... done
> > [  112.000899][ T9861] bcachefs (loop0): delete_dead_inodes... done
> > [  112.011223][ T9861] bcachefs (loop0): done starting filesystem
> > [  112.016159][ T9874] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  112.062409][ T9873] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  112.083674][ T9859] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  112.151050][ T9896] bcachefs: bch2_fs_get_tree() error: EINVAL
> > executing program
> > [  112.507721][ T9419] bcachefs (loop0): shutting down
> > [  112.508210][ T9419] bcachefs (loop0): going read-only
> > [  112.508674][ T9419] bcachefs (loop0): finished waiting for writes =
to stop
> > [  112.510525][ T9419] bcachefs (loop0): flushing journal and stoppin=
g allocators, journal seq 19
> > [  112.511433][ T9419] bcachefs (loop0): flushing journal and stoppin=
g allocators complete, journal seq 19
> > [  112.512929][ T9419] bcachefs (loop0): clean shutdown complete, jou=
rnal seq 20
> > [  112.514116][ T9419] bcachefs (loop0): marking filesystem clean
> > [  112.566195][ T9419] bcachefs (loop0): shutdown complete
> > [  112.729300][ T9874] loop2: detected capacity change from 0 to 4042=
7
> > [  112.762206][ T9874] F2FS-fs (loop2): Found nat_bits in checkpoint
> > [  112.832122][ T9874] F2FS-fs (loop2): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  112.860195][ T9416] syz-executor182: attempt to access beyond end =
of device
> > [  112.860195][ T9416] loop2: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  112.861378][ T9416] F2FS-fs (loop2): Stopped filesystem due to rea=
son: 3
> > [  112.956196][ T9859] loop4: detected capacity change from 0 to 4042=
7
> > [  112.970289][ T9873] loop1: detected capacity change from 0 to 4042=
7
> > [  112.989159][ T9873] F2FS-fs (loop1): Found nat_bits in checkpoint
> > [  112.990678][ T9859] F2FS-fs (loop4): Found nat_bits in checkpoint
> > [  113.030995][ T9939] loop5: detected capacity change from 0 to 3276=
8
> > [  113.050847][ T9873] F2FS-fs (loop1): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  113.063132][ T9415] syz-executor182: attempt to access beyond end =
of device
> > [  113.063132][ T9415] loop1: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  113.064397][ T9415] F2FS-fs (loop1): Stopped filesystem due to rea=
son: 3
> > [  113.102011][ T9859] F2FS-fs (loop4): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  113.116313][ T9896] loop3: detected capacity change from 0 to 4042=
7
> > [  113.126875][ T9414] syz-executor182: attempt to access beyond end =
of device
> > [  113.126875][ T9414] loop4: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  113.128082][ T9414] F2FS-fs (loop4): Stopped filesystem due to rea=
son: 3
> > [  113.135202][ T9896] F2FS-fs (loop3): Found nat_bits in checkpoint
> > executing program
> > [  113.242698][ T9896] F2FS-fs (loop3): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  113.267917][ T9411] syz-executor182: attempt to access beyond end =
of device
> > [  113.267917][ T9411] loop3: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  113.269163][ T9411] F2FS-fs (loop3): Stopped filesystem due to rea=
son: 3
> > executing program
> > executing program
> > executing program
> > [  113.579309][ T9939] bcachefs (loop5): starting version 1.7: mi_btr=
ee_bitmap opts=3Ddata_checksum=3Dcrc64,str_hash=3Dcrc64,nojournal_transac=
tion_names,nocow
> > [  113.590755][ T9939] bcachefs (loop5): recovering from clean shutdo=
wn, journal seq 10
> > [  113.591516][ T9939] bcachefs (loop5): Doing compatible version upg=
rade from 1.7: mi_btree_bitmap to 1.20: directory_size
> > [  113.591516][ T9939]   running recovery passes: check_allocations,c=
heck_extents_to_backpointers,check_inodes,check_dirents
> > [  113.616036][ T9939] bcachefs (loop5): accounting_read...
> > [  113.631621][ T9974] loop2: detected capacity change from 0 to 3276=
8
> > [  113.676232][ T9939]  done
> > [  113.676535][ T9939] bcachefs (loop5): alloc_read... done
> > [  113.678812][ T9939] bcachefs (loop5): stripes_read... done
> > [  113.679366][ T9939] bcachefs (loop5): snapshots_read... done
> > [  113.679929][ T9939] bcachefs (loop5): check_allocations...
> > [  113.680845][ T9939] btree ptr not marked in member info btree allo=
cated bitmap
> > [  113.680857][ T9939]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 4fe84214937890c3 written 32 min_key POS_MIN durability: 1 ptr: 0:=
26:0 gen 0, fixing
> > [  113.714674][ T9939] btree ptr not marked in member info btree allo=
cated bitmap
> > [  113.714687][ T9939]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq a22d880bb51b703b written 24 min_key POS_MIN durability: 1 ptr: 0:=
38:0 gen 0, fixing
> > [  113.723935][ T9939] btree ptr not marked in member info btree allo=
cated bitmap
> > [  113.723949][ T9939]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq b5d608e41b3af1cf written 24 min_key POS_MIN durability: 1 ptr: 0:=
41:0 gen 0, fixing
> > [  113.741908][ T9939] btree ptr not marked in member info btree allo=
cated bitmap
> > [  113.741978][ T9939]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 92b180ffcc5b04f1 written 16 min_key POS_MIN durability: 1 ptr: 0:=
35:0 gen 0, fixing
> > [  113.746904][ T9939] btree ptr not marked in member info btree allo=
cated bitmap
> > [  113.746916][ T9939]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 8aae33f84eb959b0 written 16 min_key POS_MIN durability: 1 ptr: 0:=
32:0 gen 0, fixing
> > [  113.749557][ T9974] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  113.750327][ T9974] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  113.757671][ T9939] btree ptr not marked in member info btree allo=
cated bitmap
> > [  113.757684][ T9939]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 487388c888b02d23 written 32 min_key POS_MIN durability: 1 ptr: 0:=
29:0 gen 0, fixing
> > [  113.764035][ T9939]  done
> > [  113.770958][ T9939] bcachefs (loop5): going read-write
> > [  113.779601][ T9939] bcachefs (loop5): journal_replay... done
> > [  113.817377][ T9939] bcachefs (loop5): check_extents_to_backpointer=
s...
> > [  113.818179][ T9939] bcachefs (loop5): scanning for missing backpoi=
nters in 6/128 buckets
> > [  113.819849][ T9939]  done
> > [  113.821094][ T9939] bcachefs (loop5): check_inodes... done
> > [  113.824003][ T9939] bcachefs (loop5): check_dirents...
> > [  113.824645][ T9939] directory 4096:4294967295 with wrong i_size: g=
ot 0, should be 352, fixing
> > [  113.831347][ T9939]  done
> > [  113.833612][ T9939] bcachefs (loop5): resume_logged_ops... done
> > [  113.834174][ T9939] bcachefs (loop5): delete_dead_inodes... done
> > [  113.837002][ T9939] bcachefs (loop5): Fixed errors, running fsck a=
 second time to verify fs is clean
> > [  113.837803][ T9939] bcachefs (loop5): check_extents_to_backpointer=
s... done
> > [  113.839023][ T9939] bcachefs (loop5): check_inodes... done
> > [  113.839906][ T9939] bcachefs (loop5): check_dirents... done
> > [  113.841110][ T9939] bcachefs (loop5): resume_logged_ops... done
> > [  113.841654][ T9939] bcachefs (loop5): delete_dead_inodes... done
> > [  113.856895][ T9939] bcachefs (loop5): done starting filesystem
> > executing program
> > [  113.940506][ T9986] loop3: detected capacity change from 0 to 3276=
8
> > [  113.994917][ T9974] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  114.053017][ T9986] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  114.053825][ T9986] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  114.059752][ T9988] loop4: detected capacity change from 0 to 3276=
8
> > [  114.061836][ T9989] loop1: detected capacity change from 0 to 3276=
8
> > [  114.207926][ T9989] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  114.219630][ T9989] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  114.232583][ T9988] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  114.233378][ T9988] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  114.250023][ T9986] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  114.258160][T10004] loop0: detected capacity change from 0 to 3276=
8
> > [  114.394931][ T9989] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  114.449022][T10004] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  114.449845][T10004] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  114.471845][ T9988] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  114.702691][T10004] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  114.941108][ T9423] bcachefs (loop5): shutting down
> > [  114.941556][ T9423] bcachefs (loop5): going read-only
> > [  114.942061][ T9423] bcachefs (loop5): finished waiting for writes =
to stop
> > [  114.975955][ T9423] bcachefs (loop5): flushing journal and stoppin=
g allocators, journal seq 19
> > [  114.976819][ T9423] bcachefs (loop5): flushing journal and stoppin=
g allocators complete, journal seq 19
> > [  114.978209][ T9423] bcachefs (loop5): clean shutdown complete, jou=
rnal seq 20
> > [  114.979373][ T9423] bcachefs (loop5): marking filesystem clean
> > [  114.991460][ T9974] loop2: detected capacity change from 0 to 4042=
7
> > [  115.032980][ T9423] bcachefs (loop5): shutdown complete
> > [  115.034965][ T9974] F2FS-fs (loop2): Found nat_bits in checkpoint
> > [  115.132344][ T9974] F2FS-fs (loop2): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  115.142555][ T9416] syz-executor182: attempt to access beyond end =
of device
> > [  115.142555][ T9416] loop2: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  115.143741][ T9416] F2FS-fs (loop2): Stopped filesystem due to rea=
son: 3
> > [  115.254587][ T9986] loop3: detected capacity change from 0 to 4042=
7
> > [  115.280074][T10004] loop0: detected capacity change from 0 to 4042=
7
> > [  115.309678][ T9986] F2FS-fs (loop3): Found nat_bits in checkpoint
> > [  115.315452][T10004] F2FS-fs (loop0): Found nat_bits in checkpoint
> > [  115.386275][ T9988] loop4: detected capacity change from 0 to 4042=
7
> > [  115.395663][ T9989] loop1: detected capacity change from 0 to 4042=
7
> > [  115.402575][ T9986] F2FS-fs (loop3): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  115.411167][ T9988] F2FS-fs (loop4): Found nat_bits in checkpoint
> > [  115.416554][ T9411] syz-executor182: attempt to access beyond end =
of device
> > [  115.416554][ T9411] loop3: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  115.417784][ T9411] F2FS-fs (loop3): Stopped filesystem due to rea=
son: 3
> > [  115.418519][T10004] F2FS-fs (loop0): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  115.425175][ T9989] F2FS-fs (loop1): Found nat_bits in checkpoint
> > [  115.439517][ T9419] syz-executor182: attempt to access beyond end =
of device
> > [  115.439517][ T9419] loop0: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  115.440691][ T9419] F2FS-fs (loop0): Stopped filesystem due to rea=
son: 3
> > [  115.484070][ T9988] F2FS-fs (loop4): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  115.502746][ T9414] syz-executor182: attempt to access beyond end =
of device
> > [  115.502746][ T9414] loop4: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  115.503974][ T9414] F2FS-fs (loop4): Stopped filesystem due to rea=
son: 3
> > [  115.555802][ T9989] F2FS-fs (loop1): Mounted with checkpoint versi=
on =3D 48b305e5
> > executing program
> > [  115.582377][ T9415] syz-executor182: attempt to access beyond end =
of device
> > [  115.582377][ T9415] loop1: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  115.583636][ T9415] F2FS-fs (loop1): Stopped filesystem due to rea=
son: 3
> > executing program
> > executing program
> > [  115.878183][T10084] loop2: detected capacity change from 0 to 3276=
8
> > executing program
> > executing program
> > [  116.075638][T10088] loop4: detected capacity change from 0 to 3276=
8
> > [  116.217872][T10104] loop0: detected capacity change from 0 to 3276=
8
> > [  116.218733][T10084] bcachefs (loop2): starting version 1.7: mi_btr=
ee_bitmap opts=3Ddata_checksum=3Dcrc64,str_hash=3Dcrc64,nojournal_transac=
tion_names,nocow
> > [  116.219959][T10084] bcachefs (loop2): recovering from clean shutdo=
wn, journal seq 10
> > [  116.220691][T10084] bcachefs (loop2): Doing compatible version upg=
rade from 1.7: mi_btree_bitmap to 1.20: directory_size
> > [  116.220691][T10084]   running recovery passes: check_allocations,c=
heck_extents_to_backpointers,check_inodes,check_dirents
> > [  116.225812][T10088] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  116.226633][T10088] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  116.275065][T10084] bcachefs (loop2): accounting_read... done
> > [  116.283912][T10084] bcachefs (loop2): alloc_read... done
> > [  116.284412][T10084] bcachefs (loop2): stripes_read... done
> > [  116.284925][T10084] bcachefs (loop2): snapshots_read... done
> > [  116.285470][T10084] bcachefs (loop2): check_allocations...
> > [  116.286367][T10084] btree ptr not marked in member info btree allo=
cated bitmap
> > [  116.286378][T10084]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 4fe84214937890c3 written 32 min_key POS_MIN durability: 1 ptr: 0:=
26:0 gen 0, fixing
> > [  116.311872][T10084] btree ptr not marked in member info btree allo=
cated bitmap
> > [  116.311886][T10084]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq a22d880bb51b703b written 24 min_key POS_MIN durability: 1 ptr: 0:=
38:0 gen 0, fixing
> > [  116.318668][T10104] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  116.319493][T10104] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  116.321843][T10084] btree ptr not marked in member info btree allo=
cated bitmap
> > [  116.321855][T10084]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq b5d608e41b3af1cf written 24 min_key POS_MIN durability: 1 ptr: 0:=
41:0 gen 0, fixing
> > [  116.340301][T10084] btree ptr not marked in member info btree allo=
cated bitmap
> > [  116.340315][T10084]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 92b180ffcc5b04f1 written 16 min_key POS_MIN durability: 1 ptr: 0:=
35:0 gen 0, fixing
> > [  116.352821][T10084] btree ptr not marked in member info btree allo=
cated bitmap
> > [  116.352835][T10084]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 8aae33f84eb959b0 written 16 min_key POS_MIN durability: 1 ptr: 0:=
32:0 gen 0, fixing
> > [  116.361065][T10084] btree ptr not marked in member info btree allo=
cated bitmap
> > [  116.361078][T10084]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 487388c888b02d23 written 32 min_key POS_MIN durability: 1 ptr: 0:=
29:0 gen 0, fixing
> > [  116.368252][T10096] loop3: detected capacity change from 0 to 3276=
8
> > [  116.412637][T10084]  done
> > [  116.420710][T10084] bcachefs (loop2): going read-write
> > [  116.430050][T10084] bcachefs (loop2): journal_replay...
> > [  116.447147][T10088] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  116.499127][T10096] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  116.500065][T10096] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  116.501697][T10084]  done
> > [  116.503008][T10084] bcachefs (loop2): check_extents_to_backpointer=
s...
> > [  116.503872][T10084] bcachefs (loop2): scanning for missing backpoi=
nters in 6/128 buckets
> > [  116.535692][T10084]  done
> > [  116.562270][T10084] bcachefs (loop2): check_inodes... done
> > [  116.577743][T10084] bcachefs (loop2): check_dirents...
> > [  116.578440][T10084] directory 4096:4294967295 with wrong i_size: g=
ot 0, should be 352, fixing
> > [  116.579893][T10084]  done
> > [  116.581171][T10084] bcachefs (loop2): resume_logged_ops... done
> > [  116.581750][T10084] bcachefs (loop2): delete_dead_inodes... done
> > [  116.584623][T10084] bcachefs (loop2): Fixed errors, running fsck a=
 second time to verify fs is clean
> > [  116.585414][T10084] bcachefs (loop2): check_extents_to_backpointer=
s... done
> > [  116.586637][T10084] bcachefs (loop2): check_inodes... done
> > [  116.587606][T10084] bcachefs (loop2): check_dirents... done
> > [  116.588841][T10084] bcachefs (loop2): resume_logged_ops... done
> > [  116.589388][T10084] bcachefs (loop2): delete_dead_inodes... done
> > [  116.592364][T10084] bcachefs (loop2): done starting filesystem
> > [  116.627557][T10106] loop1: detected capacity change from 0 to 3276=
8
> > executing program
> > [  116.665048][T10104] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  116.735839][T10096] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  116.792780][T10106] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  116.793622][T10106] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  116.975044][T10106] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  117.181503][T10139] loop5: detected capacity change from 0 to 3276=
8
> > [  117.331127][T10088] loop4: detected capacity change from 0 to 4042=
7
> > [  117.339469][T10139] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  117.341399][T10088] F2FS-fs (loop4): Found nat_bits in checkpoint
> > [  117.357980][T10139] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  117.370125][T10088] F2FS-fs (loop4): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  117.415237][ T9414] syz-executor182: attempt to access beyond end =
of device
> > [  117.415237][ T9414] loop4: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  117.416454][ T9414] F2FS-fs (loop4): Stopped filesystem due to rea=
son: 3
> > [  117.496183][T10139] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  117.531563][T10104] loop0: detected capacity change from 0 to 4042=
7
> > [  117.562831][T10104] F2FS-fs (loop0): Found nat_bits in checkpoint
> > [  117.579137][T10096] loop3: detected capacity change from 0 to 4042=
7
> > [  117.628991][T10096] F2FS-fs (loop3): Found nat_bits in checkpoint
> > [  117.649387][ T9416] bcachefs (loop2): shutting down
> > [  117.650317][ T9416] bcachefs (loop2): going read-only
> > [  117.650777][ T9416] bcachefs (loop2): finished waiting for writes =
to stop
> > [  117.651731][T10104] F2FS-fs (loop0): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  117.668770][ T9419] F2FS-fs (loop0): Stopped filesystem due to rea=
son: 3
> > [  117.673471][ T9416] bcachefs (loop2): flushing journal and stoppin=
g allocators, journal seq 19
> > [  117.674303][ T9416] bcachefs (loop2): flushing journal and stoppin=
g allocators complete, journal seq 19
> > [  117.678590][ T9416] bcachefs (loop2): clean shutdown complete, jou=
rnal seq 20
> > [  117.679768][ T9416] bcachefs (loop2): marking filesystem clean
> > [  117.711315][T10096] F2FS-fs (loop3): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  117.723718][T10106] loop1: detected capacity change from 0 to 4042=
7
> > [  117.753838][ T9411] F2FS-fs (loop3): Stopped filesystem due to rea=
son: 3
> > [  117.765155][T10106] F2FS-fs (loop1): Found nat_bits in checkpoint
> > [  117.776418][ T9416] bcachefs (loop2): shutdown complete
> > [  117.857409][T10106] F2FS-fs (loop1): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  117.880631][ T9415] bio_check_eod: 2 callbacks suppressed
> > [  117.880644][ T9415] syz-executor182: attempt to access beyond end =
of device
> > [  117.880644][ T9415] loop1: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > executing program
> > [  117.885862][ T9415] F2FS-fs (loop1): Stopped filesystem due to rea=
son: 3
> > executing program
> > executing program
> > [  118.235439][T10139] loop5: detected capacity change from 0 to 4042=
7
> > [  118.273056][T10139] F2FS-fs (loop5): Found nat_bits in checkpoint
> > executing program
> > [  118.319607][T10199] loop4: detected capacity change from 0 to 3276=
8
> > [  118.354858][T10139] F2FS-fs (loop5): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  118.366510][ T9423] syz-executor182: attempt to access beyond end =
of device
> > [  118.366510][ T9423] loop5: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  118.367689][ T9423] F2FS-fs (loop5): Stopped filesystem due to rea=
son: 3
> > [  118.465349][T10210] loop0: detected capacity change from 0 to 3276=
8
> > [  118.548928][T10208] loop3: detected capacity change from 0 to 3276=
8
> > executing program
> > [  118.668237][T10215] loop1: detected capacity change from 0 to 3276=
8
> > [  118.725319][T10199] bcachefs (loop4): starting version 1.7: mi_btr=
ee_bitmap opts=3Ddata_checksum=3Dcrc64,str_hash=3Dcrc64,nojournal_transac=
tion_names,nocow
> > [  118.726542][T10199] bcachefs (loop4): recovering from clean shutdo=
wn, journal seq 10
> > [  118.739638][T10210] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  118.740538][T10210] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  118.762058][T10199] bcachefs (loop4): Doing compatible version upg=
rade from 1.7: mi_btree_bitmap to 1.20: directory_size
> > [  118.762058][T10199]   running recovery passes: check_allocations,c=
heck_extents_to_backpointers,check_inodes,check_dirents
> > [  118.792535][T10208] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  118.793346][T10208] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  118.804875][T10199] bcachefs (loop4): accounting_read...
> > [  118.819837][T10215] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  118.821098][T10215] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  118.822992][T10199]  done
> > [  118.823273][T10199] bcachefs (loop4): alloc_read... done
> > [  118.823898][T10199] bcachefs (loop4): stripes_read... done
> > [  118.824509][T10199] bcachefs (loop4): snapshots_read... done
> > [  118.833390][T10199] bcachefs (loop4): check_allocations...
> > [  118.834326][T10199] btree ptr not marked in member info btree allo=
cated bitmap
> > [  118.834338][T10199]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 4fe84214937890c3 written 32 min_key POS_MIN durability: 1 ptr: 0:=
26:0 gen 0, fixing
> > [  118.841497][T10199] btree ptr not marked in member info btree allo=
cated bitmap
> > [  118.841510][T10199]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq a22d880bb51b703b written 24 min_key POS_MIN durability: 1 ptr: 0:=
38:0 gen 0, fixing
> > [  118.863326][T10199] btree ptr not marked in member info btree allo=
cated bitmap
> > [  118.863341][T10199]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq b5d608e41b3af1cf written 24 min_key POS_MIN durability: 1 ptr: 0:=
41:0 gen 0, fixing
> > [  118.876740][T10199] btree ptr not marked in member info btree allo=
cated bitmap
> > [  118.876754][T10199]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 92b180ffcc5b04f1 written 16 min_key POS_MIN durability: 1 ptr: 0:=
35:0 gen 0, fixing
> > [  118.888461][T10199] btree ptr not marked in member info btree allo=
cated bitmap
> > [  118.888476][T10199]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 8aae33f84eb959b0 written 16 min_key POS_MIN durability: 1 ptr: 0:=
32:0 gen 0, fixing
> > [  118.907919][T10240] loop5: detected capacity change from 0 to 3276=
8
> > [  118.912739][T10199] btree ptr not marked in member info btree allo=
cated bitmap
> > [  118.912753][T10199]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 487388c888b02d23 written 32 min_key POS_MIN durability: 1 ptr: 0:=
29:0 gen 0, fixing
> > [  118.921650][T10199]  done
> > [  118.924109][T10199] bcachefs (loop4): going read-write
> > [  118.926223][T10199] bcachefs (loop4): journal_replay... done
> > [  118.942301][T10199] bcachefs (loop4): check_extents_to_backpointer=
s...
> > [  118.943318][T10199] bcachefs (loop4): scanning for missing backpoi=
nters in 6/128 buckets
> > [  118.945074][T10199]  done
> > [  118.946730][T10199] bcachefs (loop4): check_inodes... done
> > [  118.948232][T10199] bcachefs (loop4): check_dirents...
> > [  118.948868][T10199] directory 4096:4294967295 with wrong i_size: g=
ot 0, should be 352, fixing
> > [  118.950263][T10199]  done
> > [  118.951597][T10199] bcachefs (loop4): resume_logged_ops... done
> > [  118.952956][T10199] bcachefs (loop4): delete_dead_inodes... done
> > [  118.955499][T10199] bcachefs (loop4): Fixed errors, running fsck a=
 second time to verify fs is clean
> > [  118.956291][T10199] bcachefs (loop4): check_extents_to_backpointer=
s... done
> > [  118.957517][T10199] bcachefs (loop4): check_inodes... done
> > [  118.958597][T10199] bcachefs (loop4): check_dirents... done
> > [  118.959689][T10199] bcachefs (loop4): resume_logged_ops... done
> > [  118.960463][T10199] bcachefs (loop4): delete_dead_inodes... done
> > [  118.967724][T10199] bcachefs (loop4): done starting filesystem
> > [  119.028519][T10210] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  119.030600][T10240] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  119.031409][T10240] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  119.072037][T10215] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  119.096295][T10208] bcachefs: bch2_fs_get_tree() error: EINVAL
> > executing program
> > [  119.227988][T10240] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  119.688735][T10273] loop2: detected capacity change from 0 to 3276=
8
> > [  119.813956][T10273] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  119.814786][T10273] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  119.853423][T10215] loop1: detected capacity change from 0 to 4042=
7
> > [  119.856495][T10210] loop0: detected capacity change from 0 to 4042=
7
> > [  119.857773][ T9414] bcachefs (loop4): shutting down
> > [  119.858221][ T9414] bcachefs (loop4): going read-only
> > [  119.858685][ T9414] bcachefs (loop4): finished waiting for writes =
to stop
> > [  119.868332][ T9414] bcachefs (loop4): flushing journal and stoppin=
g allocators, journal seq 19
> > [  119.869185][ T9414] bcachefs (loop4): flushing journal and stoppin=
g allocators complete, journal seq 19
> > [  119.873981][ T9414] bcachefs (loop4): clean shutdown complete, jou=
rnal seq 20
> > [  119.875178][ T9414] bcachefs (loop4): marking filesystem clean
> > [  119.882517][T10210] F2FS-fs (loop0): Found nat_bits in checkpoint
> > [  119.888971][T10215] F2FS-fs (loop1): Found nat_bits in checkpoint
> > [  119.921394][ T9414] bcachefs (loop4): shutdown complete
> > [  119.924354][T10273] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  119.928577][T10208] loop3: detected capacity change from 0 to 4042=
7
> > [  119.930941][T10210] F2FS-fs (loop0): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  119.967145][T10208] F2FS-fs (loop3): Found nat_bits in checkpoint
> > [  119.970699][ T9419] syz-executor182: attempt to access beyond end =
of device
> > [  119.970699][ T9419] loop0: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  119.971896][ T9419] F2FS-fs (loop0): Stopped filesystem due to rea=
son: 3
> > [  119.999384][T10215] F2FS-fs (loop1): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  120.040484][ T9415] syz-executor182: attempt to access beyond end =
of device
> > [  120.040484][ T9415] loop1: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  120.041720][ T9415] F2FS-fs (loop1): Stopped filesystem due to rea=
son: 3
> > [  120.069779][T10240] loop5: detected capacity change from 0 to 4042=
7
> > [  120.079270][T10208] F2FS-fs (loop3): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  120.097790][T10240] F2FS-fs (loop5): Found nat_bits in checkpoint
> > [  120.097829][ T9411] syz-executor182: attempt to access beyond end =
of device
> > [  120.097829][ T9411] loop3: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  120.099521][ T9411] F2FS-fs (loop3): Stopped filesystem due to rea=
son: 3
> > [  120.169763][T10240] F2FS-fs (loop5): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  120.192235][ T9423] syz-executor182: attempt to access beyond end =
of device
> > [  120.192235][ T9423] loop5: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  120.193486][ T9423] F2FS-fs (loop5): Stopped filesystem due to rea=
son: 3
> > executing program
> > [  120.521289][T10273] loop2: detected capacity change from 0 to 4042=
7
> > executing program
> > executing program
> > [  120.542928][T10273] F2FS-fs (loop2): Found nat_bits in checkpoint
> > executing program
> > [  120.599215][T10273] F2FS-fs (loop2): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  120.623796][ T9416] syz-executor182: attempt to access beyond end =
of device
> > [  120.623796][ T9416] loop2: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  120.624997][ T9416] F2FS-fs (loop2): Stopped filesystem due to rea=
son: 3
> > [  120.875745][T10327] loop5: detected capacity change from 0 to 3276=
8
> > [  120.891741][T10328] loop1: detected capacity change from 0 to 3276=
8
> > [  120.926119][T10329] loop0: detected capacity change from 0 to 3276=
8
> > [  120.949975][T10334] loop3: detected capacity change from 0 to 3276=
8
> > executing program
> > [  121.173000][T10328] bcachefs (loop1): starting version 1.7: mi_btr=
ee_bitmap opts=3Ddata_checksum=3Dcrc64,str_hash=3Dcrc64,nojournal_transac=
tion_names,nocow
> > [  121.174227][T10328] bcachefs (loop1): recovering from clean shutdo=
wn, journal seq 10
> > [  121.174965][T10328] bcachefs (loop1): Doing compatible version upg=
rade from 1.7: mi_btree_bitmap to 1.20: directory_size
> > [  121.174965][T10328]   running recovery passes: check_allocations,c=
heck_extents_to_backpointers,check_inodes,check_dirents
> > [  121.181983][T10334] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  121.182845][T10334] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  121.188615][T10329] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  121.189440][T10329] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  121.193662][T10327] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  121.194482][T10327] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  121.220269][T10328] bcachefs (loop1): accounting_read... done
> > [  121.227369][T10328] bcachefs (loop1): alloc_read... done
> > [  121.227893][T10328] bcachefs (loop1): stripes_read... done
> > [  121.228399][T10328] bcachefs (loop1): snapshots_read... done
> > [  121.228950][T10328] bcachefs (loop1): check_allocations...
> > [  121.240259][T10328] btree ptr not marked in member info btree allo=
cated bitmap
> > [  121.240274][T10328]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 4fe84214937890c3 written 32 min_key POS_MIN durability: 1 ptr: 0:=
26:0 gen 0, fixing
> > [  121.274276][T10328] btree ptr not marked in member info btree allo=
cated bitmap
> > [  121.274291][T10328]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq a22d880bb51b703b written 24 min_key POS_MIN durability: 1 ptr: 0:=
38:0 gen 0, fixing
> > [  121.280053][T10334] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  121.287325][T10328] btree ptr not marked in member info btree allo=
cated bitmap
> > [  121.287338][T10328]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq b5d608e41b3af1cf written 24 min_key POS_MIN durability: 1 ptr: 0:=
41:0 gen 0, fixing
> > [  121.301293][T10328] btree ptr not marked in member info btree allo=
cated bitmap
> > [  121.301307][T10328]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 92b180ffcc5b04f1 written 16 min_key POS_MIN durability: 1 ptr: 0:=
35:0 gen 0, fixing
> > [  121.315663][T10328] btree ptr not marked in member info btree allo=
cated bitmap
> > [  121.315677][T10328]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 8aae33f84eb959b0 written 16 min_key POS_MIN durability: 1 ptr: 0:=
32:0 gen 0, fixing
> > [  121.318416][T10328] btree ptr not marked in member info btree allo=
cated bitmap
> > [  121.318427][T10328]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 487388c888b02d23 written 32 min_key POS_MIN durability: 1 ptr: 0:=
29:0 gen 0, fixing
> > [  121.324447][T10362] loop2: detected capacity change from 0 to 3276=
8
> > [  121.327689][T10328]  done
> > [  121.340798][T10328] bcachefs (loop1): going read-write
> > [  121.347027][T10328] bcachefs (loop1): journal_replay... done
> > [  121.378833][T10328] bcachefs (loop1): check_extents_to_backpointer=
s...
> > [  121.379640][T10328] bcachefs (loop1): scanning for missing backpoi=
nters in 6/128 buckets
> > [  121.393116][T10328]  done
> > [  121.412909][T10328] bcachefs (loop1): check_inodes... done
> > [  121.414818][T10327] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  121.422252][T10329] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  121.423022][T10328] bcachefs (loop1): check_dirents...
> > [  121.423691][T10328] directory 4096:4294967295 with wrong i_size: g=
ot 0, should be 352, fixing
> > [  121.432858][T10362] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  121.433661][T10362] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  121.433958][T10328]  done
> > [  121.442778][T10328] bcachefs (loop1): resume_logged_ops... done
> > [  121.443384][T10328] bcachefs (loop1): delete_dead_inodes... done
> > [  121.464880][T10328] bcachefs (loop1): Fixed errors, running fsck a=
 second time to verify fs is clean
> > [  121.465711][T10328] bcachefs (loop1): check_extents_to_backpointer=
s... done
> > [  121.466942][T10328] bcachefs (loop1): check_inodes... done
> > [  121.467825][T10328] bcachefs (loop1): check_dirents... done
> > [  121.468912][T10328] bcachefs (loop1): resume_logged_ops... done
> > [  121.469472][T10328] bcachefs (loop1): delete_dead_inodes... done
> > executing program
> > [  121.522104][T10328] bcachefs (loop1): done starting filesystem
> > [  121.612635][T10362] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  122.001127][T10329] loop0: detected capacity change from 0 to 4042=
7
> > [  122.045553][T10390] loop4: detected capacity change from 0 to 3276=
8
> > [  122.049915][T10329] F2FS-fs (loop0): Found nat_bits in checkpoint
> > [  122.100763][T10334] loop3: detected capacity change from 0 to 4042=
7
> > [  122.115638][T10334] F2FS-fs (loop3): Found nat_bits in checkpoint
> > [  122.142242][T10329] F2FS-fs (loop0): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  122.179624][T10390] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  122.180456][T10390] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  122.216542][ T9419] syz-executor182: attempt to access beyond end =
of device
> > [  122.216542][ T9419] loop0: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  122.217720][ T9419] F2FS-fs (loop0): Stopped filesystem due to rea=
son: 3
> > [  122.229734][T10334] F2FS-fs (loop3): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  122.284519][T10390] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  122.286898][ T9411] syz-executor182: attempt to access beyond end =
of device
> > [  122.286898][ T9411] loop3: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  122.288151][ T9411] F2FS-fs (loop3): Stopped filesystem due to rea=
son: 3
> > [  122.416714][T10327] loop5: detected capacity change from 0 to 4042=
7
> > [  122.435862][ T9415] bcachefs (loop1): shutting down
> > [  122.436309][ T9415] bcachefs (loop1): going read-only
> > [  122.436742][ T9415] bcachefs (loop1): finished waiting for writes =
to stop
> > [  122.443370][T10327] F2FS-fs (loop5): Found nat_bits in checkpoint
> > [  122.460439][ T9415] bcachefs (loop1): flushing journal and stoppin=
g allocators, journal seq 19
> > [  122.461293][ T9415] bcachefs (loop1): flushing journal and stoppin=
g allocators complete, journal seq 19
> > [  122.463918][ T9415] bcachefs (loop1): clean shutdown complete, jou=
rnal seq 20
> > [  122.465104][ T9415] bcachefs (loop1): marking filesystem clean
> > [  122.513936][ T9415] bcachefs (loop1): shutdown complete
> > [  122.520856][T10362] loop2: detected capacity change from 0 to 4042=
7
> > [  122.547784][T10362] F2FS-fs (loop2): Found nat_bits in checkpoint
> > [  122.550586][T10327] F2FS-fs (loop5): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  122.577513][ T9423] syz-executor182: attempt to access beyond end =
of device
> > [  122.577513][ T9423] loop5: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  122.578774][ T9423] F2FS-fs (loop5): Stopped filesystem due to rea=
son: 3
> > executing program
> > [  122.659887][T10362] F2FS-fs (loop2): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  122.675820][ T9416] F2FS-fs (loop2): Stopped filesystem due to rea=
son: 3
> > executing program
> > [  122.888809][T10390] loop4: detected capacity change from 0 to 4042=
7
> > [  122.926926][T10390] F2FS-fs (loop4): Found nat_bits in checkpoint
> > executing program
> > [  122.995814][T10439] loop0: detected capacity change from 0 to 3276=
8
> > [  123.017519][T10390] F2FS-fs (loop4): Mounted with checkpoint versi=
on =3D 48b305e5
> > executing program
> > [  123.028307][ T9414] bio_check_eod: 1 callbacks suppressed
> > [  123.028319][ T9414] syz-executor182: attempt to access beyond end =
of device
> > [  123.028319][ T9414] loop4: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  123.029948][ T9414] F2FS-fs (loop4): Stopped filesystem due to rea=
son: 3
> > [  123.165203][T10452] loop2: detected capacity change from 0 to 3276=
8
> > [  123.207195][T10442] loop3: detected capacity change from 0 to 3276=
8
> > executing program
> > [  123.347765][T10459] loop5: detected capacity change from 0 to 3276=
8
> > [  123.380856][T10439] bcachefs (loop0): starting version 1.7: mi_btr=
ee_bitmap opts=3Ddata_checksum=3Dcrc64,str_hash=3Dcrc64,nojournal_transac=
tion_names,nocow
> > [  123.388942][T10442] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  123.389774][T10452] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  123.400795][T10439] bcachefs (loop0): recovering from clean shutdo=
wn, journal seq 10
> > [  123.401495][T10439] bcachefs (loop0): Doing compatible version upg=
rade from 1.7: mi_btree_bitmap to 1.20: directory_size
> > [  123.401495][T10439]   running recovery passes: check_allocations,c=
heck_extents_to_backpointers,check_inodes,check_dirents
> > [  123.417591][T10452] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  123.419570][T10439] bcachefs (loop0): accounting_read...
> > [  123.419671][T10442] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  123.427510][T10439]  done
> > [  123.427792][T10439] bcachefs (loop0): alloc_read... done
> > [  123.428285][T10439] bcachefs (loop0): stripes_read... done
> > [  123.428806][T10439] bcachefs (loop0): snapshots_read... done
> > [  123.429364][T10439] bcachefs (loop0): check_allocations...
> > [  123.430265][T10439] btree ptr not marked in member info btree allo=
cated bitmap
> > [  123.430276][T10439]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 4fe84214937890c3 written 32 min_key POS_MIN durability: 1 ptr: 0:=
26:0 gen 0, fixing
> > [  123.464399][T10439] btree ptr not marked in member info btree allo=
cated bitmap
> > [  123.464414][T10439]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq a22d880bb51b703b written 24 min_key POS_MIN durability: 1 ptr: 0:=
38:0 gen 0, fixing
> > [  123.467461][T10459] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  123.468281][T10459] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  123.500919][T10439] btree ptr not marked in member info btree allo=
cated bitmap
> > [  123.500934][T10439]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq b5d608e41b3af1cf written 24 min_key POS_MIN durability: 1 ptr: 0:=
41:0 gen 0, fixing
> > [  123.507697][T10439] btree ptr not marked in member info btree allo=
cated bitmap
> > [  123.507710][T10439]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 92b180ffcc5b04f1 written 16 min_key POS_MIN durability: 1 ptr: 0:=
35:0 gen 0, fixing
> > [  123.513653][T10439] btree ptr not marked in member info btree allo=
cated bitmap
> > [  123.513665][T10439]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 8aae33f84eb959b0 written 16 min_key POS_MIN durability: 1 ptr: 0:=
32:0 gen 0, fixing
> > [  123.522740][T10439] btree ptr not marked in member info btree allo=
cated bitmap
> > [  123.522753][T10439]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 487388c888b02d23 written 32 min_key POS_MIN durability: 1 ptr: 0:=
29:0 gen 0, fixing
> > [  123.539003][T10439]  done
> > [  123.552761][T10442] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  123.553681][T10439] bcachefs (loop0): going read-write
> > [  123.559896][T10439] bcachefs (loop0): journal_replay...
> > [  123.597954][T10452] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  123.605401][T10459] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  123.622954][T10439]  done
> > [  123.623674][T10439] bcachefs (loop0): check_extents_to_backpointer=
s...
> > [  123.624479][T10439] bcachefs (loop0): scanning for missing backpoi=
nters in 6/128 buckets
> > [  123.630581][T10439]  done
> > [  123.632561][T10439] bcachefs (loop0): check_inodes... done
> > [  123.636243][T10439] bcachefs (loop0): check_dirents...
> > [  123.636894][T10439] directory 4096:4294967295 with wrong i_size: g=
ot 0, should be 352, fixing
> > [  123.638294][T10439]  done
> > [  123.647168][T10439] bcachefs (loop0): resume_logged_ops... done
> > [  123.647731][T10439] bcachefs (loop0): delete_dead_inodes... done
> > [  123.650068][T10439] bcachefs (loop0): Fixed errors, running fsck a=
 second time to verify fs is clean
> > [  123.650884][T10439] bcachefs (loop0): check_extents_to_backpointer=
s... done
> > [  123.654947][T10439] bcachefs (loop0): check_inodes... done
> > [  123.660122][T10439] bcachefs (loop0): check_dirents... done
> > [  123.661255][T10439] bcachefs (loop0): resume_logged_ops... done
> > [  123.661825][T10439] bcachefs (loop0): delete_dead_inodes... done
> > executing program
> > [  123.682502][T10439] bcachefs (loop0): done starting filesystem
> > [  123.940481][T10479] loop4: detected capacity change from 0 to 3276=
8
> > [  124.086682][T10479] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  124.087495][T10479] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  124.222572][T10479] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  124.240960][T10459] loop5: detected capacity change from 0 to 4042=
7
> > [  124.254579][T10459] F2FS-fs (loop5): Found nat_bits in checkpoint
> > [  124.286587][T10459] F2FS-fs (loop5): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  124.318366][ T9423] syz-executor182: attempt to access beyond end =
of device
> > [  124.318366][ T9423] loop5: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  124.319569][ T9423] F2FS-fs (loop5): Stopped filesystem due to rea=
son: 3
> > [  124.330836][T10504] loop1: detected capacity change from 0 to 3276=
8
> > [  124.428028][T10504] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  124.428811][T10504] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  124.451744][ T9419] bcachefs (loop0): shutting down
> > [  124.452264][ T9419] bcachefs (loop0): going read-only
> > [  124.452705][ T9419] bcachefs (loop0): finished waiting for writes =
to stop
> > [  124.478224][ T9419] bcachefs (loop0): flushing journal and stoppin=
g allocators, journal seq 19
> > [  124.479056][ T9419] bcachefs (loop0): flushing journal and stoppin=
g allocators complete, journal seq 19
> > [  124.480358][ T9419] bcachefs (loop0): clean shutdown complete, jou=
rnal seq 20
> > [  124.481521][ T9419] bcachefs (loop0): marking filesystem clean
> > [  124.561168][ T9419] bcachefs (loop0): shutdown complete
> > [  124.566623][T10442] loop3: detected capacity change from 0 to 4042=
7
> > [  124.586990][T10442] F2FS-fs (loop3): Found nat_bits in checkpoint
> > [  124.587975][T10452] loop2: detected capacity change from 0 to 4042=
7
> > [  124.646027][T10452] F2FS-fs (loop2): Found nat_bits in checkpoint
> > [  124.727535][T10442] F2FS-fs (loop3): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  124.737729][ T9411] syz-executor182: attempt to access beyond end =
of device
> > [  124.737729][ T9411] loop3: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  124.738971][ T9411] F2FS-fs (loop3): Stopped filesystem due to rea=
son: 3
> > [  124.754490][T10452] F2FS-fs (loop2): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  124.792492][ T9416] syz-executor182: attempt to access beyond end =
of device
> > [  124.792492][ T9416] loop2: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  124.793747][ T9416] F2FS-fs (loop2): Stopped filesystem due to rea=
son: 3
> > executing program
> > [  124.864160][T10479] loop4: detected capacity change from 0 to 4042=
7
> > [  124.880139][T10479] F2FS-fs (loop4): Found nat_bits in checkpoint
> > [  124.933029][T10504] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  124.951628][T10479] F2FS-fs (loop4): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  125.004807][ T9414] syz-executor182: attempt to access beyond end =
of device
> > [  125.004807][ T9414] loop4: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  125.006025][ T9414] F2FS-fs (loop4): Stopped filesystem due to rea=
son: 3
> > executing program
> > [  125.157795][T10551] loop5: detected capacity change from 0 to 3276=
8
> > executing program
> > [  125.356192][T10569] loop2: detected capacity change from 0 to 3276=
8
> > executing program
> > [  125.467788][T10504] loop1: detected capacity change from 0 to 4042=
7
> > [  125.490885][T10504] F2FS-fs (loop1): Found nat_bits in checkpoint
> > [  125.542634][T10504] F2FS-fs (loop1): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  125.556710][T10566] loop3: detected capacity change from 0 to 3276=
8
> > [  125.562388][ T9415] syz-executor182: attempt to access beyond end =
of device
> > [  125.562388][ T9415] loop1: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  125.563626][ T9415] F2FS-fs (loop1): Stopped filesystem due to rea=
son: 3
> > [  125.657980][T10581] loop4: detected capacity change from 0 to 3276=
8
> > [  125.717691][T10569] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  125.718530][T10569] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  125.718553][T10581] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  125.720027][T10581] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  125.720520][T10551] bcachefs (loop5): starting version 1.7: mi_btr=
ee_bitmap opts=3Ddata_checksum=3Dcrc64,str_hash=3Dcrc64,nojournal_transac=
tion_names,nocow
> > [  125.721868][T10551] bcachefs (loop5): recovering from clean shutdo=
wn, journal seq 10
> > [  125.738618][T10566] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  125.739436][T10566] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  125.744211][T10551] bcachefs (loop5): Doing compatible version upg=
rade from 1.7: mi_btree_bitmap to 1.20: directory_size
> > [  125.744211][T10551]   running recovery passes: check_allocations,c=
heck_extents_to_backpointers,check_inodes,check_dirents
> > [  125.763243][T10551] bcachefs (loop5): accounting_read... done
> > [  125.764039][T10551] bcachefs (loop5): alloc_read... done
> > [  125.764542][T10551] bcachefs (loop5): stripes_read... done
> > [  125.765044][T10551] bcachefs (loop5): snapshots_read... done
> > [  125.765575][T10551] bcachefs (loop5): check_allocations...
> > [  125.766496][T10551] btree ptr not marked in member info btree allo=
cated bitmap
> > [  125.766509][T10551]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 4fe84214937890c3 written 32 min_key POS_MIN durability: 1 ptr: 0:=
26:0 gen 0, fixing
> > [  125.793125][T10551] btree ptr not marked in member info btree allo=
cated bitmap
> > [  125.793140][T10551]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq a22d880bb51b703b written 24 min_key POS_MIN durability: 1 ptr: 0:=
38:0 gen 0, fixing
> > [  125.799867][T10551] btree ptr not marked in member info btree allo=
cated bitmap
> > [  125.799880][T10551]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq b5d608e41b3af1cf written 24 min_key POS_MIN durability: 1 ptr: 0:=
41:0 gen 0, fixing
> > [  125.826704][T10551] btree ptr not marked in member info btree allo=
cated bitmap
> > [  125.826719][T10551]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 92b180ffcc5b04f1 written 16 min_key POS_MIN durability: 1 ptr: 0:=
35:0 gen 0, fixing
> > [  125.829309][T10551] btree ptr not marked in member info btree allo=
cated bitmap
> > [  125.829320][T10551]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 8aae33f84eb959b0 written 16 min_key POS_MIN durability: 1 ptr: 0:=
32:0 gen 0, fixing
> > [  125.832937][T10551] btree ptr not marked in member info btree allo=
cated bitmap
> > [  125.832949][T10551]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver=
 0: seq 487388c888b02d23 written 32 min_key POS_MIN durability: 1 ptr: 0:=
29:0 gen 0, fixing
> > [  125.838367][T10551]  done
> > [  125.851470][T10551] bcachefs (loop5): going read-write
> > [  125.852976][T10551] bcachefs (loop5): journal_replay...
> > [  125.862320][T10581] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  125.898680][T10551]  done
> > [  125.899410][T10551] bcachefs (loop5): check_extents_to_backpointer=
s...
> > [  125.900206][T10551] bcachefs (loop5): scanning for missing backpoi=
nters in 6/128 buckets
> > [  125.903547][T10551]  done
> > [  125.904829][T10551] bcachefs (loop5): check_inodes...
> > [  125.905484][T10569] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  125.908168][T10551]  done
> > [  125.922751][T10551] bcachefs (loop5): check_dirents...
> > [  125.923513][T10551] directory 4096:4294967295 with wrong i_size: g=
ot 0, should be 352, fixing
> > [  125.924989][T10551]  done
> > [  125.934332][T10551] bcachefs (loop5): resume_logged_ops... done
> > [  125.934922][T10551] bcachefs (loop5): delete_dead_inodes... done
> > [  125.939895][T10551] bcachefs (loop5): Fixed errors, running fsck a=
 second time to verify fs is clean
> > [  125.940665][T10551] bcachefs (loop5): check_extents_to_backpointer=
s... done
> > [  125.941894][T10551] bcachefs (loop5): check_inodes...
> > [  125.944215][T10566] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  125.952512][T10551]  done
> > [  125.952782][T10551] bcachefs (loop5): check_dirents... done
> > [  125.962384][T10551] bcachefs (loop5): resume_logged_ops... done
> > [  125.962916][T10551] bcachefs (loop5): delete_dead_inodes... done
> > [  125.972220][T10551] bcachefs (loop5): done starting filesystem
> > executing program
> > executing program
> > [  126.525266][T10627] loop1: detected capacity change from 0 to 3276=
8
> > [  126.638125][T10627] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  126.638978][T10627] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  126.652112][T10629] loop0: detected capacity change from 0 to 3276=
8
> > [  126.680618][T10569] loop2: detected capacity change from 0 to 4042=
7
> > [  126.720229][T10569] F2FS-fs (loop2): Found nat_bits in checkpoint
> > [  126.747897][T10629] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): filesystem UUID already open
> > [  126.748731][T10629] bcachefs (076a1832-646e-4f3c-b13d-b3e266154efd=
): shutdown complete
> > [  126.792428][T10581] loop4: detected capacity change from 0 to 4042=
7
> > [  126.840305][T10581] F2FS-fs (loop4): Found nat_bits in checkpoint
> > [  126.847945][T10629] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  126.858972][T10566] loop3: detected capacity change from 0 to 4042=
7
> > [  126.862544][T10569] F2FS-fs (loop2): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  126.883957][T10627] bcachefs: bch2_fs_get_tree() error: EINVAL
> > [  126.906213][T10566] F2FS-fs (loop3): Found nat_bits in checkpoint
> > [  126.922220][ T9416] syz-executor182: attempt to access beyond end =
of device
> > [  126.922220][ T9416] loop2: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  126.923461][ T9416] F2FS-fs (loop2): Stopped filesystem due to rea=
son: 3
> > [  126.958605][T10581] F2FS-fs (loop4): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  126.972870][ T9414] syz-executor182: attempt to access beyond end =
of device
> > [  126.972870][ T9414] loop4: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  126.974106][ T9414] F2FS-fs (loop4): Stopped filesystem due to rea=
son: 3
> > [  126.981882][ T9423] bcachefs (loop5): shutting down
> > [  126.982402][ T9423] bcachefs (loop5): going read-only
> > [  126.982836][ T9423] bcachefs (loop5): finished waiting for writes =
to stop
> > [  127.002106][T10566] F2FS-fs (loop3): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  127.022369][ T9423] bcachefs (loop5): flushing journal and stoppin=
g allocators, journal seq 19
> > [  127.023215][ T9423] bcachefs (loop5): flushing journal and stoppin=
g allocators complete, journal seq 19
> > [  127.027692][ T9423] bcachefs (loop5): clean shutdown complete, jou=
rnal seq 20
> > [  127.028898][ T9423] bcachefs (loop5): marking filesystem clean
> > [  127.042127][ T9411] syz-executor182: attempt to access beyond end =
of device
> > [  127.042127][ T9411] loop3: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  127.043371][ T9411] F2FS-fs (loop3): Stopped filesystem due to rea=
son: 3
> > [  127.097816][ T9423] bcachefs (loop5): shutdown complete
> > executing program
> > executing program
> > [  127.483307][T10629] loop0: detected capacity change from 0 to 4042=
7
> > executing program
> > [  127.501236][T10627] loop1: detected capacity change from 0 to 4042=
7
> > [  127.503209][T10629] F2FS-fs (loop0): Found nat_bits in checkpoint
> > [  127.534227][T10627] F2FS-fs (loop1): Found nat_bits in checkpoint
> > [  127.541209][T10629] F2FS-fs (loop0): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  127.578130][ T9419] syz-executor182: attempt to access beyond end =
of device
> > [  127.578130][ T9419] loop0: rw=3D2049, sector=3D45096, nr_sectors =3D=
 8 limit=3D40427
> > [  127.579391][ T9419] F2FS-fs (loop0): Stopped filesystem due to rea=
son: 3
> > [  127.633000][T10627] F2FS-fs (loop1): Mounted with checkpoint versi=
on =3D 48b305e5
> > [  127.663091][ T9415] F2FS-fs (loop1): Stopped filesystem due to rea=
son: 3
> > [  127.760244][T10681] loop4: detected capacity change from 0 to 3276=
8
> > [  127.795542][ T5205] BUG: kernel NULL pointer dereference, address:=
 0000000000000011
> > [  127.796223][ T5205] #PF: supervisor read access in kernel mode
> > [  127.796724][ T5205] #PF: error_code(0x0000) - not-present page
> > [  127.797196][ T5205] PGD 0 P4D 0=20
> > [  127.797492][ T5205] Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
> > [  127.797975][ T5205] CPU: 0 UID: 0 PID: 5205 Comm: kworker/0:3 Not =
tainted 6.14.0-rc4 #1
> > [  127.798661][ T5205] Hardware name: QEMU Standard PC (i440FX + PIIX=
, 1996), BIOS 1.15.0-1 04/01/2014
> > [  127.799410][ T5205] Workqueue: slub_flushwq flush_cpu_slab
> > [  127.799907][ T5205] RIP: 0010:__put_partials+0x8a/0x190
> > [  127.800379][ T5205] Code: 50 49 89 54 24 10 4d 89 7c 24 18 49 89 3=
f 4c 89 e7 e8 9a 98 ff ff f0 80 48 01 02 48 85 db 0f 84 91 00 00 00 48 89=
 ef 49 89 dc <48> 8b 5b 10 49 8b 04 24 48 83 f8 ff 74 6b 49 8b 04 24 48 c=
1 e8 3a
> > [  127.802494][ T5205] RSP: 0018:ffffc900022afc20 EFLAGS: 00010282
> > [  127.803267][ T5205] RAX: 0000000000000046 RBX: 0000000000000001 RC=
X: 0000000000000000
> > [  127.803944][ T5205] RDX: 0000000000000000 RSI: 0000000000000001 RD=
I: 0000000000000000
> > [  127.804617][ T5205] RBP: ffff88802b638fa0 R08: 0000000000000000 R0=
9: 0000000000000000
> > [  127.805282][ T5205] R10: 0000000000000000 R11: 0000000000000000 R1=
2: 0000000000000001
> > [  127.805954][ T5205] R13: 0000000000000000 R14: ffff88804f8db8c0 R1=
5: ffff88801b496800
> > [  127.806658][ T5205] FS:  0000000000000000(0000) GS:ffff88802b60000=
0(0000) knlGS:0000000000000000
> > [  127.807364][ T5205] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033
> > [  127.807883][ T5205] CR2: 0000000000000011 CR3: 0000000022b10000 CR=
4: 00000000000006f0
> > [  127.808508][ T5205] DR0: 0000000000000000 DR1: 0000000000000000 DR=
2: 0000000000000000
> > [  127.809129][ T5205] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR=
7: 0000000000000400
> > [  127.809738][ T5205] Call Trace:
> > [  127.810003][ T5205]  <TASK>
> > [  127.810242][ T5205]  ? __die+0x1f/0x70
> > [  127.810572][ T5205]  ? page_fault_oops+0x145/0x340
> > [  127.810970][ T5205]  ? __pfx_page_fault_oops+0x10/0x10
> > [  127.811396][ T5205]  ? search_bpf_extables+0x1c5/0x330
> > [  127.811816][ T5205]  ? __put_partials+0x8a/0x190
> > [  127.812199][ T5205]  ? fixup_exception+0x111/0xb20
> > [  127.812601][ T5205]  ? kernelmode_fixup_or_oops.constprop.0+0xb8/0=
xe0
> > [  127.813117][ T5205]  ? __bad_area_nosemaphore+0x390/0x6a0
> > [  127.813561][ T5205]  ? __lock_acquire+0xb97/0x16a0
> > [  127.813959][ T5205]  ? do_user_addr_fault+0x910/0x13a0
> > [  127.814393][ T5205]  ? rcu_is_watching+0x12/0xd0
> > [  127.814797][ T5205]  ? exc_page_fault+0x98/0x180
> > [  127.815233][ T5205]  ? asm_exc_page_fault+0x26/0x30
> > [  127.815678][ T5205]  ? __put_partials+0x8a/0x190
> > [  127.816094][ T5205]  process_one_work+0x109d/0x18c0
> > [  127.816541][ T5205]  ? __pfx_lock_acquire+0x10/0x10
> > [  127.816971][ T5205]  ? __pfx_process_one_work+0x10/0x10
> > [  127.817447][ T5205]  ? assign_work+0x194/0x250
> > [  127.817842][ T5205]  worker_thread+0x677/0xe90
> > [  127.818247][ T5205]  ? __pfx_worker_thread+0x10/0x10
> > [  127.818693][ T5205]  kthread+0x3b3/0x760
> > [  127.819044][ T5205]  ? __pfx_kthread+0x10/0x10
> > [  127.819444][ T5205]  ? _raw_spin_unlock_irq+0x23/0x60
> > [  127.819895][ T5205]  ? __pfx_kthread+0x10/0x10
> > [  127.820302][ T5205]  ret_from_fork+0x48/0x80
> > [  127.820680][ T5205]  ? __pfx_kthread+0x10/0x10
> > [  127.821056][ T5205]  ret_from_fork_asm+0x1a/0x30
> > [  127.821469][ T5205]  </TASK>
> > [  127.821738][ T5205] Modules linked in:
> > [  127.822076][ T5205] CR2: 0000000000000011
> > [  127.822441][ T5205] ---[ end trace 0000000000000000 ]---
> > [  127.822894][ T5205] RIP: 0010:__put_partials+0x8a/0x190
> > [  127.823360][ T5205] Code: 50 49 89 54 24 10 4d 89 7c 24 18 49 89 3=
f 4c 89 e7 e8 9a 98 ff ff f0 80 48 01 02 48 85 db 0f 84 91 00 00 00 48 89=
 ef 49 89 dc <48> 8b 5b 10 49 8b 04 24 48 83 f8 ff 74 6b 49 8b 04 24 48 c=
1 e8 3a
> > [  127.824881][ T5205] RSP: 0018:ffffc900022afc20 EFLAGS: 00010282
> > [  127.825371][ T5205] RAX: 0000000000000046 RBX: 0000000000000001 RC=
X: 0000000000000000
> > [  127.825991][ T5205] RDX: 0000000000000000 RSI: 0000000000000001 RD=
I: 0000000000000000
> > [  127.826638][ T5205] RBP: ffff88802b638fa0 R08: 0000000000000000 R0=
9: 0000000000000000
> > [  127.827275][ T5205] R10: 0000000000000000 R11: 0000000000000000 R1=
2: 0000000000000001
> > [  127.827902][ T5205] R13: 0000000000000000 R14: ffff88804f8db8c0 R1=
5: ffff88801b496800
> > [  127.828521][ T5205] FS:  0000000000000000(0000) GS:ffff88802b60000=
0(0000) knlGS:0000000000000000
> > [  127.829215][ T5205] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033
> > [  127.829755][ T5205] CR2: 0000000000000011 CR3: 0000000022b10000 CR=
4: 00000000000006f0
> > [  127.830416][ T5205] DR0: 0000000000000000 DR1: 0000000000000000 DR=
2: 0000000000000000
> > [  127.831059][ T5205] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR=
7: 0000000000000400
> > [  127.831710][ T5205] Kernel panic - not syncing: Fatal exception
> > [  127.832314][ T5205] Kernel Offset: disabled
> > [  127.832676][ T5205] Rebooting in 86400 seconds..
> >=20
> > VM DIAGNOSIS:
> > 21:04:28  Registers:
> > info registers vcpu 0
> > RAX=3D0000000000000032 RBX=3D00000000000003f8 RCX=3D0000000000000000 =
RDX=3D00000000000003f8
> > RSI=3D0000000000000000 RDI=3Dffffffff9b037a00 RBP=3Dffffffff9b0379c0 =
RSP=3Dffffc900022af350
> > R8 =3D0000000000000000 R9 =3D0000000000000000 R10=3D0000000000000000 =
R11=3D0000000000000000
> > R12=3D0000000000000000 R13=3D0000000000000032 R14=3Dffffffff9b0379c0 =
R15=3D0000000000000000
> > RIP=3Dffffffff8540d9bf RFL=3D00000002 [-------] CPL=3D0 II=3D0 A20=3D=
1 SMM=3D0 HLT=3D0
> > ES =3D0000 0000000000000000 ffffffff 00c00000
> > CS =3D0010 0000000000000000 ffffffff 00a09b00 DPL=3D0 CS64 [-RA]
> > SS =3D0018 0000000000000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
> > DS =3D0000 0000000000000000 ffffffff 00c00000
> > FS =3D0000 0000000000000000 ffffffff 00c00000
> > GS =3D0000 ffff88802b600000 ffffffff 00c00000
> > LDT=3D0000 0000000000000000 ffffffff 00c00000
> > TR =3D0040 fffffe0000003000 00004087 00008b00 DPL=3D0 TSS64-busy
> > GDT=3D     fffffe0000001000 0000007f
> > IDT=3D     fffffe0000000000 00000fff
> > CR0=3D80050033 CR2=3D0000000000000011 CR3=3D0000000022b10000 CR4=3D00=
0006f0
> > DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 =
DR3=3D0000000000000000=20
> > DR6=3D00000000fffe0ff0 DR7=3D0000000000000400
> > EFER=3D0000000000000d01
> > FCW=3D037f FSW=3D0000 [ST=3D0] FTW=3D00 MXCSR=3D00001f80
> > FPR0=3D0000000000000000 0000 FPR1=3D0000000000000000 0000
> > FPR2=3D0000000000000000 0000 FPR3=3D0000000000000000 0000
> > FPR4=3D0000000000000000 0000 FPR5=3D0000000000000000 0000
> > FPR6=3D0000000000000000 0000 FPR7=3D0000000000000000 0000
> > XMM00=3D00005602eff8c7a0 00005602effc6e40 XMM01=3D0000000bffffffff 00=
005602eff8c7a0
> > XMM02=3Dffffffffffff0000 ffffffffffffff00 XMM03=3Dffff000000000000 ff=
ff000000000000
> > XMM04=3D0000000000000000 0000000000000000 XMM05=3D00005602eff5cd80 00=
00000000000000
> > XMM06=3D0000000700000004 00005602eff5cda0 XMM07=3D0000000000000000 00=
00000000000000
> > XMM08=3D0000000000000110 0000000000000100 XMM09=3Dffff000000000000 00=
0000ffff00ffff
> > XMM10=3D0000000000000000 0000000000000000 XMM11=3Dffff00ffffffffff ff=
ff00ffffffffff
> > XMM12=3D0000000000000000 0000000000000000 XMM13=3D0000000000000000 00=
00000000000000
> > XMM14=3D0000000000000000 0000000000000000 XMM15=3D0000000000000000 00=
00000000000000
> > info registers vcpu 1
> > RAX=3D0000000000000000 RBX=3D0000000000000001 RCX=3Dffffffff847d9ac6 =
RDX=3Dffff88802259b980
> > RSI=3D0000000000000000 RDI=3D0000000000000001 RBP=3Dffff88801d369900 =
RSP=3Dffffc9000236f880
> > R8 =3D0000000000000000 R9 =3D0000000000000000 R10=3D0000000000000001 =
R11=3D0000000000000000
> > R12=3Dffffffff8e26f080 R13=3Dffffffff8e26f080 R14=3D000000000003d90c =
R15=3D0000000000000000
> > RIP=3Dffffffff81be0cb1 RFL=3D00000293 [--S-A-C] CPL=3D0 II=3D0 A20=3D=
1 SMM=3D0 HLT=3D0
> > ES =3D0000 0000000000000000 ffffffff 00c00000
> > CS =3D0010 0000000000000000 ffffffff 00a09b00 DPL=3D0 CS64 [-RA]
> > SS =3D0018 0000000000000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
> > DS =3D0000 0000000000000000 ffffffff 00c00000
> > FS =3D0000 000055556d686480 ffffffff 00c00000
> > GS =3D0000 ffff88807ee00000 ffffffff 00c00000
> > LDT=3D0000 0000000000000000 ffffffff 00c00000
> > TR =3D0040 fffffe000004a000 00004087 00008b00 DPL=3D0 TSS64-busy
> > GDT=3D     fffffe0000048000 0000007f
> > IDT=3D     fffffe0000000000 00000fff
> > CR0=3D80050033 CR2=3D00007f4269032460 CR3=3D0000000064a0e000 CR4=3D00=
0006f0
> > DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 =
DR3=3D0000000000000000=20
> > DR6=3D00000000fffe0ff0 DR7=3D0000000000000400
> > EFER=3D0000000000000d01
> > FCW=3D037f FSW=3D0000 [ST=3D0] FTW=3D00 MXCSR=3D00001f80
> > FPR0=3D0000000000000000 0000 FPR1=3D0000000000000000 0000
> > FPR2=3D0000000000000000 0000 FPR3=3D0000000000000000 0000
> > FPR4=3D0000000000000000 0000 FPR5=3D0000000000000000 0000
> > FPR6=3D0000000000000000 0000 FPR7=3D0000000000000000 0000
> > XMM00=3D0000000000989680 0000000000000000 XMM01=3D0000000000000000 00=
00000000989680
> > XMM02=3D00007fc13195eb60 00007fc13195eb60 XMM03=3D0000000000000000 00=
00000000000000
> > XMM04=3D0000ffffffffffff 0000000000000000 XMM05=3D0000000000000000 00=
00000000000000
> > XMM06=3D0000000000000000 0000000000000000 XMM07=3D0000000000000000 00=
00000000000000
> > XMM08=3D0000000000000000 0000000000000000 XMM09=3D0000000000000000 00=
00000000000000
> > XMM10=3D0000000000000000 0000000000000000 XMM11=3D0000000000000000 00=
00000000000000
> > XMM12=3D0000000000000000 0000000000000000 XMM13=3D0000000000000000 00=
00000000000000
> > XMM14=3D0000000000000000 0000000000000000 XMM15=3D0000000000000000 00=
00000000000000
>=20
>=20


