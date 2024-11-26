Return-Path: <linux-kernel+bounces-422464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC47E9D99F5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73030283D20
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E4D1D5AC9;
	Tue, 26 Nov 2024 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jE5VOyKp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SMAlfStE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB7228F5
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732632673; cv=none; b=Uis6YKtnq34EF4Hq1CnhjylvaEfdT34D1yM1q+f3sXJ/hcGgJRs0jywLinHhn9iClvBYj1xfrKjPzvIqHUdbG9w7Szh43iZ4mLB1N9p7dmG7EibHHQ5z1mo600dbXTPVHYSYYie+be6BHNgCQfeLDdsrtnOMaWsMWsRBGou+Sow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732632673; c=relaxed/simple;
	bh=9ofGJOnVnXlwCy3x6i6NllQzH6agqh53YuhWlcN/ByI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8Fq0AWv478So0vcM3iwqPJRYIO96hBLbkIrhZrjLJ9YjGuIYl5fisYGoRjqX3TkorTDXnpxSnOxAazKL18wkre9u4Z5tDLXre74PTt+X39Swd/TB9Zq+eNldoPRv68fNTEB5orhTjVhWh5yzRb/PXodVl7eTCbb2+LDIdH8218=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jE5VOyKp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SMAlfStE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 26 Nov 2024 15:51:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732632669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vVSDCCDMTFkX5gNjADWJWeRq6cvvlxZJxWMO0JTKp+0=;
	b=jE5VOyKpgSM8a9Yq0mQJBdhoJDzaJQaDh5Gotn+00kPQABmGR4VVvigSq2k+nIj6ndr7R5
	yQ9Sm3PHX05DMDfHnWqLtJ6Y9leOKTpLBaXG4WfLpipnmLObN2FaJ+Nl5hctmk7OQjMWbo
	wXDAYqqTTSB2ZKo3GLempGeK6JWyN7HHlqONq4dumjQl9teQlAosHNhryep21DSlkl8LqQ
	qcZAsXUi5gAhLeZmWKRa15vLpDv/gY1DQnJuvI5VqqG11xQTHKjAAFPm3TGjaRo+3FMroX
	6AcgRlG9sri1AKB+mXLXIb3P+DibrwtGrmhcwQMspUNk3I9dc99+zMfq/09JDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732632669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vVSDCCDMTFkX5gNjADWJWeRq6cvvlxZJxWMO0JTKp+0=;
	b=SMAlfStEkjshJxUNNAAiS0pp5WjlhHweA2kJUZR/SABvSob0TH2YexbCJZRfkdCDduUwUQ
	5JQx4RYFD6BaZeAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: syzbot <syzbot+7f4f9a43a9c78eaee04f@syzkaller.appspotmail.com>
Cc: Jason@zx2c4.com, boqun.feng@gmail.com, hdanton@sina.com,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	tytso@mit.edu
Subject: Re: [syzbot] [kernel?] WARNING: locking bug in get_random_u8
Message-ID: <20241126145108.49mT4Lc9@linutronix.de>
References: <6738c3ba.050a0220.bb738.000d.GAE@google.com>
 <67447073.050a0220.1cc393.007b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67447073.050a0220.1cc393.007b.GAE@google.com>

On 2024-11-25 04:41:23 [-0800], syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16ee775f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d8bc8a5565eebec6
> dashboard link: https://syzkaller.appspot.com/bug?extid=7f4f9a43a9c78eaee04f
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1612dee8580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-9f16d5e6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/dbaabe559df8/vmlinux-9f16d5e6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/5fe0afceb260/bzImage-9f16d5e6.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7f4f9a43a9c78eaee04f@syzkaller.appspotmail.com

#syz fix: kasan: Make kasan_record_aux_stack_noalloc() the default behaviour
#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/staging.git 5cb0bc2a8ec81da5d1af5de29a6549c66c9254ad

Sebastian

