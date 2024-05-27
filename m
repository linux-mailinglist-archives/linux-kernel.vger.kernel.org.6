Return-Path: <linux-kernel+bounces-191092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E7A8D067F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71785288B65
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA73C61FE7;
	Mon, 27 May 2024 15:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gl19VmpW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9lDldjhL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDEC26ADE
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716824827; cv=none; b=mGGiHeSYxTJkjJgzr256PQQBA38SvO2D02gYOSJOc0FZ0RojIYUmtR2ykgqfY5Wa7/3T1DHqTBVYKVUdOPASGS5r62028jTAQg8re5cTY3w3rPwcqp7bNTKH9taGBKF9Bx1IGLOVBfZOg8i3apF1PPN1AddtKtJgDLXDD4pcXoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716824827; c=relaxed/simple;
	bh=GEp2k5W9TvRI9RyEpVUPOmID9fhPinMprrqF9UDRpfI=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UPYIJpuEaceYp3T5mZ9nKpNqM+3SMrNsLg7xa7sqnCel+Q7nvgC/Hc2HFUpiJnXRbXUn0Tw+lxpW2kIKfy2d7L8TNsb6MXCqQ/IV0rM7a1zPup/iqe1qsod/+LuIU18m7FBXWx7prEzXYkqb2lD3/i7CTGC20DtmwqBSd6B7qYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gl19VmpW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9lDldjhL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716824824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OsjTH1PuS8M1Wx9TxA/JCt4/23ZLBMX6f89jtTtnVP8=;
	b=gl19VmpWzSJYH9XGGyr6VKQ9YcMvNpz1ii3wKkdTiE0jfrX0d8iyAEf8+1x72+uOBH+VIt
	mM+2Bo94npIKwa+GExJV1Y9jz+H7ZYtiH22H3nOfmxs0a55z8L2byJ2JARDpvSsnzFmro5
	p4c0ECsOCNYjushwn0E60CEna+vx0R8BFeg77T0RR7/CD4+uMEbiqVPksN04m6Hj1jy2tW
	UlKP7gsKsShaFYoIXvn9HT0EFGOPYB7/t9BZAssLuAGzpvpezFAj23nKl0zj5MbvfpEq7W
	8LFcoiM1bh5058SGKCYoXc/9g1V+rYBvRrs1t16IHqxd71xvmkgcbyAOlCKNbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716824824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OsjTH1PuS8M1Wx9TxA/JCt4/23ZLBMX6f89jtTtnVP8=;
	b=9lDldjhLzBpct0zDoHN5MovMMYyRBxNN5vkWOQpslABZDQjUnzrurvJfn7f5B6ptskin/c
	am/bQZziKZUQcVAg==
To: syzbot <syzbot+97f26f162079653e77b8@syzkaller.appspotmail.com>,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 linux-kernel@vger.kernel.org, mingo@redhat.com,
 syzkaller-bugs@googlegroups.com, x86@kernel.org
Subject: Re: [syzbot] [kernel?] WARNING: locking bug in collect_percpu_times
In-Reply-To: <000000000000b4935a06194e4cc7@google.com>
References: <000000000000b4935a06194e4cc7@google.com>
Date: Mon, 27 May 2024 17:47:03 +0200
Message-ID: <87wmnfb6ko.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, May 25 2024 at 14:52, syzbot wrote:
> HEAD commit:    2a8120d7b482 Merge tag 's390-6.10-2' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=145dd452980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5dd4fde1337a9e18
> dashboard link: https://syzkaller.appspot.com/bug?extid=97f26f162079653e77b8
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: i386
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2a8120d7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/78c72ae6bdaf/vmlinux-2a8120d7.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/99dbb805b738/bzImage-2a8120d7.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+97f26f162079653e77b8@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> Looking for class "->pcpu, cpu)->seq" with key __key.9, but found a different class "&per_cpu_ptr(group->pcpu, cpu)->seq" with the same key

This is a pattern I've seen in quite some recent syzbot reports where
the class string is a subset of the recorded string.

I have no idea how that can happen, but it smells like data corruption
of some sort.

