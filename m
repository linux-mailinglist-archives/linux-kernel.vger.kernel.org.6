Return-Path: <linux-kernel+bounces-446134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 750629F202B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 18:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D02D7A075C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 17:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8669619645D;
	Sat, 14 Dec 2024 17:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QxqI05j0"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D938193072
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 17:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734198758; cv=none; b=aNww1erGCUXwQoCqb24c4LF1QrtWokkF5wA/8jioDJPOmUig2RaC+Zn06Ks3CA2Dreze9ZoCze/39KAQ//4+SKNyzSMGQUf503R4mPR8S3Vm9ZaKxSPyGMg1JNQh2SMcmoPgpqWQS7NsGcAwHQCyZRbBJY3/JqjY0FyN2LujjfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734198758; c=relaxed/simple;
	bh=hUHA8mihXEerggjMXuh4VL5b5YWiyDdHRe/8FA/N2rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocaLPn396rEJABNy4M5pgB5zwEboRPf0pl+illzsJ/bUxCFX6b5Z2DCrGYipjD/dho5DQWCZr0Rc51KqhrbIFGWQrS4YusZ5+i4S+CePOun83lJc9gtthwTQo8WJXrzhv7guaXEwAgCwYHJgOA3l7tY9wYixzfIYSgr7j1nhRpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QxqI05j0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E974B40E0263;
	Sat, 14 Dec 2024 17:52:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ld48mwVjRaOV; Sat, 14 Dec 2024 17:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1734198742; bh=ViRfaJmIdg28UrX2uWGDWU81a7DubOgYnhMbsowTPMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QxqI05j03FhOR77+1FMljMbHG3RT7FKkMxCe0VIOCyo3L33LB26qZAtV1WoiJqtcG
	 6KLziu19a2LgkEBhtEc3h8TRczdt626LE7dcprrK3OkpunH017VzI2P70Dv2KbeoUV
	 vt++iNTjynlPJs+Gq3RVqHGHtC08HWbk74HhHKslCNMmLmZBnfQpmOZRAky27oEUdB
	 FEvWzW/fzNTtjKUN+rQS4blLIFsbS6FsqS5LwW5bUaqjVGmxV+o/SSMMAgsZ3uwWiW
	 LUHYHbC8K/9lIYTsEf2RVZiyKlFoPEGat7jV9Xd9pF7xISlDo+mqm2n0+g9o7xcEr6
	 RdaayLDRGn8zqxku68uaJmiYRbHpO+FTwxNzAjWR+fmEIpG81LxE/4RNSq6SSacj0V
	 J9isE2wyaw34+4149+FmbCa6WbgoDAsRxd57M+fNMmAZTBoCQzIHNz0QynWQm+i1z1
	 UCtIgy8WPoWMwV5vaqU8ghFBIOUkn2k22PQ8uOjJWEI7S6wqoD9VE/b91V+Nrd7Id/
	 jUWcuT6BCqG4myDgsiy5ldOMnHYAtif12YRvQpuu8dJ7K1h2OWPBkQhTaYmOv4W2yw
	 wjdyT6kTIuf3XaG2yE9G3OkD6o8owEOiKr3gsZFmkjC65NCMTG66JlgZ2w9FXx4qaI
	 dv4r2jEPsSCSddH66B9RGrjQ=
Received: from zn.tnic (p200300EA971f937c329c23ffFEA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:937c:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2D4DD40E022F;
	Sat, 14 Dec 2024 17:52:16 +0000 (UTC)
Date: Sat, 14 Dec 2024 18:52:09 +0100
From: Borislav Petkov <bp@alien8.de>
To: Sasha Levin <sashal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT PULL] sched/urgent for v6.13-rc3
Message-ID: <20241214175209.GCZ13Fyb_3YjKPLhoI@fat_crate.local>
References: <20241209094822.GAZ1a85tp2J_T7_Ctd@fat_crate.local>
 <Z13BzesSJDSuSXRc@lappy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z13BzesSJDSuSXRc@lappy>

+ some more folks

On Sat, Dec 14, 2024 at 12:36:07PM -0500, Sasha Levin wrote:
> On Mon, Dec 09, 2024 at 10:48:22AM +0100, Borislav Petkov wrote:
> > Hi Linus,
> > 
> > please pull the sched/urgent lineup for v6.13-rc3.
> 
> Hey Boris,
> 
> I'm a bit late to this party, but I've started seeing the following
> warning. I'm not 100% sure that this PR is the culprit because Linus
> ended up pulling it before I could run tests on it, but I haven't seen
> this warning before.

Reverting makes it go silent again I presume?

The only deadline patch in there is:

22368fe1f9bb ("sched/deadline: Fix replenish_dl_new_period dl_server condition")

 
> [ 1107.003243] ------------[ cut here ]------------
> [ 1107.010677] WARNING: CPU: 0 PID: 16 at kernel/sched/deadline.c:1995 enqueue_dl_entity+0x4a8/0x570
> [ 1107.021252] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce sha512_ce sha512_arm64 fuse drm backlight ip_tables x_tables [last unloaded: ftrace_direct]
> [ 1107.056578] CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.13.0-rc2 #1
> [ 1107.064302] Hardware name: linux,dummy-virt (DT)
> [ 1107.071887] pstate: a24020c9 (NzCv daIF +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
> [ 1107.080224] pc : enqueue_dl_entity+0x4a8/0x570
> [ 1107.086456] lr : return_to_handler+0x0/0x48
> [ 1107.093564] sp : ffff8000800d3a40
> [ 1107.098945] x29: ffff8000800d3a40 x28: fff00000ff6e8d80 x27: 0000000000000000
> [ 1107.112664] x26: 0000000000000001 x25: 0000000000000000 x24: 0000000000000048
> [ 1107.125440] x23: fff00000ff6c6d80 x22: 0000000000000001 x21: 000000000016e360
> [ 1107.137742] x20: 0000000000000001 x19: fff00000ff6c76e8 x18: 0000000000000000
> [ 1107.150485] x17: 0000000000000000 x16: ffff800080008000 x15: 0000000000000000
> [ 1107.163991] x14: fff00000ff6e8e00 x13: 0000000000000001 x12: 0000000000002229
> [ 1107.174756] x11: ffffb0af24c4a670 x10: ffff8000800d3a70 x9 : ffffb0af227176d0
> [ 1107.187747] x8 : ffff8000800d38d8 x7 : 0000000002d37310 x6 : fff00000c6d27500
> [ 1107.200948] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> [ 1107.215525] x2 : 0000000000000001 x1 : 0000000000000001 x0 : 0000000000000001
> [ 1107.228386] Call trace:
> [ 1107.233927]  enqueue_dl_entity+0x4a8/0x570 (P)
> [ 1107.240669]  dl_server_start+0x4c/0x138 (F)
> [ 1107.246980]  enqueue_task_fair+0x128/0x4b0 (F)
> [ 1107.253826]  enqueue_task+0x44/0x80 (F)
> [ 1107.259958]  activate_task+0x70/0x90 (F)
> [ 1107.265928]  attach_task+0x54/0x88 (F)
> [ 1107.272053]  sched_balance_rq+0x714/0xc18 (F)
> [ 1107.278502]  sched_balance_newidle.isra.0+0x1c0/0x408 (F)
> [ 1107.285769]  pick_next_task_fair+0x58/0x310 (F)
> [ 1107.292581]  __schedule+0x13c/0x918 (F)
> [ 1107.298583]  schedule+0x38/0x110
> [ 1107.304448]  smpboot_thread_fn+0x90/0x208 (F)
> [ 1107.310822]  kthread+0x104/0x118
> [ 1107.317269]  ret_from_fork+0x10/0x20
> [ 1107.323922] ---[ end trace 0000000000000000 ]---
> [ 1107.331245] ------------[ cut here ]------------
> [ 1107.337711] WARNING: CPU: 0 PID: 16 at kernel/sched/deadline.c:1971 enqueue_dl_entity+0x4dc/0x570
> [ 1107.346972] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce sha512_ce sha512_arm64 fuse drm backlight ip_tables x_tables [last unloaded: ftrace_direct]
> [ 1107.379887] CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Tainted: G        W          6.13.0-rc2 #1
> [ 1107.388490] Tainted: [W]=WARN
> [ 1107.394103] Hardware name: linux,dummy-virt (DT)
> [ 1107.400895] pstate: a24020c9 (NzCv daIF +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
> [ 1107.410286] pc : enqueue_dl_entity+0x4dc/0x570
> [ 1107.417196] lr : enqueue_dl_entity+0x21c/0x570
> [ 1107.423700] sp : ffff8000800d3a40
> [ 1107.428962] x29: ffff8000800d3a40 x28: fff00000ff6e8d80 x27: 0000000000000000
> [ 1107.441295] x26: 0000000000000001 x25: 0000000000000000 x24: 0000000000000048
> [ 1107.453709] x23: fff00000ff6c6d80 x22: 0000000000000001 x21: 000000000016e360
> [ 1107.465918] x20: fff00000ff6c6d80 x19: fff00000ff6c76e8 x18: 0000000000000000
> [ 1107.478257] x17: 0000000000000000 x16: ffff800080008000 x15: 0000000000000000
> [ 1107.490615] x14: fff00000ff6e8e00 x13: 0000000000000001 x12: 0000000000002229
> [ 1107.502996] x11: ffffb0af24c4a670 x10: ffff8000800d3a40 x9 : 0000000000000001
> [ 1107.515024] x8 : 000000003b9aca00 x7 : 00000000000cf95d x6 : 00000000000ee6b2
> [ 1107.527426] x5 : fff00000ff6c76e8 x4 : 000000003b9aca00 x3 : 000000003b9aca00
> [ 1107.541958] x2 : 0000000033e57787 x1 : 0000002000000000 x0 : 0000000000000001
> [ 1107.555125] Call trace:
> [ 1107.560909]  enqueue_dl_entity+0x4dc/0x570 (P)
> [ 1107.568530]  dl_server_start+0x4c/0x138 (F)
> [ 1107.574623]  enqueue_task_fair+0x128/0x4b0 (F)
> [ 1107.580979]  enqueue_task+0x44/0x80 (F)
> [ 1107.586877]  activate_task+0x70/0x90 (F)
> [ 1107.592854]  attach_task+0x54/0x88 (F)
> [ 1107.598655]  sched_balance_rq+0x714/0xc18 (F)
> [ 1107.605092]  sched_balance_newidle.isra.0+0x1c0/0x408 (F)
> [ 1107.612589]  pick_next_task_fair+0x58/0x310 (F)
> [ 1107.619724]  __schedule+0x13c/0x918 (F)
> [ 1107.626871]  schedule+0x38/0x110
> [ 1107.633403]  smpboot_thread_fn+0x90/0x208 (F)
> [ 1107.641197]  kthread+0x104/0x118
> [ 1107.647508]  ret_from_fork+0x10/0x20
> [ 1107.653843] ---[ end trace 0000000000000000 ]---

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

