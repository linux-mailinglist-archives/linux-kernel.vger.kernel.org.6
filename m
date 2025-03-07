Return-Path: <linux-kernel+bounces-551026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9904A56715
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00BF37A77DB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3588421858F;
	Fri,  7 Mar 2025 11:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UkNPUVLa"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B45421771B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 11:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741348292; cv=none; b=uBGRw2/1fSDR8vt75iIGObDcM++vElenJj9s2wt+16dW71FnTa0/MIOwY7vpJyavte5KJUfG4CQlvVkVBLaa0J3h01KoZanDEZ7wm9AR5Jtl7MXtzni3QRRMx8NDoeqNOfxTXaEK/ByXi4xKOa+qJpdCvyyxBsWNBl4EpAxMquU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741348292; c=relaxed/simple;
	bh=qKyPVKC2zEwee1to776S3zm1h04eJR+8liDpfWgaFes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcYetTLc1P/Wrr8yb7t8CbYL/Je82axBPZwGoyQ5y83BdNPvezMGMl25ot5tOAIO5WiL4k43zKrCyQ6YA0/1VhN6yABl43saF3q3obAorMa3wPxeJ+APCatadVZDw1O7tZSkoZ0Ls8rQKeINFGKI1WP4fp3tytyrjelKS0bl53s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UkNPUVLa; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 7 Mar 2025 06:51:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741348287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QG9qoN7PF3aoYfNKP/T3PtQpq+Dbf2mURFU9HigeZQY=;
	b=UkNPUVLaj6YwFJE9pAdohabEp76vgBi8Jnl+6IHqYRTOZDroy/BkRhK98C+H8oo6BVz94B
	httqJMvzyvNlw+TLdo5yb0c3nJ7oSn/HEuQxX5uirXWvbOjkcjlUDtFHg6vFWX8Ar2hOYW
	FwRRP1fME7x/7l2D6JVtEnYD9EcH8kE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Hector Martin <marcan@marcan.st>
Cc: syzbot <syzbot+4364ec1693041cad20de@syzkaller.appspotmail.com>, 
	broonie@kernel.org, joel.granados@kernel.org, kees@kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] general protection fault in proc_sys_compare
Message-ID: <ph6whomevsnlsndjuewjxaxi6ngezbnlmv2hmutlygrdu37k3w@k57yfx76ptih>
References: <67ca5dd0.050a0220.15b4b9.0076.GAE@google.com>
 <239cbc8a-9886-4ebc-865c-762bb807276c@marcan.st>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <239cbc8a-9886-4ebc-865c-762bb807276c@marcan.st>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 07, 2025 at 08:20:37PM +0900, Hector Martin wrote:
> On 2025/03/07 11:45, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    b91872c56940 Merge tag 'dmaengine-fix-6.14' of git://git.k..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1485e8b7980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=8de9cc84d5960254
> > dashboard link: https://syzkaller.appspot.com/bug?extid=4364ec1693041cad20de
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149d55a8580000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/4b855669df70/disk-b91872c5.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/e44f3c546271/vmlinux-b91872c5.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/b106e670346a/bzImage-b91872c5.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/68b26fa478ee/mount_0.gz
> > 
> > The issue was bisected to:
> > 
> > commit 579cd64b9df8a60284ec3422be919c362de40e41
> > Author: Hector Martin <marcan@marcan.st>
> > Date:   Sat Feb 8 00:54:35 2025 +0000
> > 
> >     ASoC: tas2770: Fix volume scale
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14aa03a8580000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=16aa03a8580000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12aa03a8580000
> [...]
> 
> This is a bad bisect. Not sure what the appropriate syzbot action is in
> this case.

Better bisection algorithm? Standand bisect does really badly when fed
noisy data, but it wouldn't be hard to fix that: after N successive
passes or fails, which is unlikely because bisect tests are coinflips,
backtrack and gather more data in the part of the commit history where
you don't have much.

