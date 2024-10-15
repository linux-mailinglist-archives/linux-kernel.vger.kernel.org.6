Return-Path: <linux-kernel+bounces-366855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5950299FB7A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FAD81C234E5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FC11B0F39;
	Tue, 15 Oct 2024 22:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0+AbjJaN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F31A21E3A4
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 22:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032000; cv=none; b=QzHD+6Tv2drnNxRJlqOEdYMrFcMMfJNKfkaNBLTlVVUTkXgkdrrNzT9SfI91cv7Jy0f5zoxMfk3vTkPQ0yP33mGRhIQ/0z2Fw89POy9PYwKNKToexmXjFhFJPbHYzs8nPiKU/lquKkX6v41ELx4cubSu3TsaG+tXQzq3vwtGpr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032000; c=relaxed/simple;
	bh=q6bpVuKMTHOR5R+Wwj5sFoN19avvVIwzw3Pd88L15W4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lirAIWHji/qPRolSCKz25XSCml3LdWk7b6AyDRtZaLG7a+7RZ9P5AdhKtUJt5Kz3+lDBOP/q7RoT/11oauqOp7GCjcOAB3fAPgWIAA4MpQ5wKd78TfwC9vES36tMpgpfWr3NIc8qDPVImICbR8L002LxevUewJko1w/DlEDvRz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0+AbjJaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5712C4CEC6;
	Tue, 15 Oct 2024 22:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729031999;
	bh=q6bpVuKMTHOR5R+Wwj5sFoN19avvVIwzw3Pd88L15W4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0+AbjJaNR9Nb0ukXElz0mhePua1yo1/hxyVdNKbOTxRlNl2D4qP3Rrj5o82VDaiHk
	 8jVg7W4LU+/BnvRfkGhOGOs7rOu0eqKUsK58FNGUUmGYDIkl7ow/wef+gJqF8h7ps9
	 Zgvp+7Yv5K01RyyQI7XVMgp1vqRSN1kxSnScUw1g=
Date: Tue, 15 Oct 2024 15:39:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: syzbot <syzbot+30eac43568e2b3d65728@syzkaller.appspotmail.com>
Cc: linmiaohe@huawei.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com, vitaly.wool@konsulko.com
Subject: Re: [syzbot] [mm?] BUG: corrupted list in add_to_unbuddied
Message-Id: <20241015153958.df4e735274e389999de60d2e@linux-foundation.org>
In-Reply-To: <670e81a9.050a0220.d9b66.0153.GAE@google.com>
References: <000000000000c6b91e0621a312f4@google.com>
	<670e81a9.050a0220.d9b66.0153.GAE@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 07:52:25 -0700 syzbot <syzbot+30eac43568e2b3d65728@syzkaller.appspotmail.com> wrote:

> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    eca631b8fe80 Merge tag 'f2fs-6.12-rc4' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14d0845f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cfbd94c114a3d407
> dashboard link: https://syzkaller.appspot.com/bug?extid=30eac43568e2b3d65728
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16df4c40580000

Something seems rather wrong with the "syz repro" page.




# https://syzkaller.appspot.com/bug?id=6b5f76b3a3783e6b1876d25b2d7a981ac0e0131f
# See https://goo.gl/kgGztJ for information about syzkaller reproducers.
#{"threaded":true,"repeat":true,"procs":6,"slowdown":1,"sandbox":"none","sandbox_arg":0,"tun":true,"netdev":true,"resetnet":true,"cgroups":true,"binfmt_misc":true,"close_fds":true,"usb":true,"vhci":true,"wifi":true,"ieee802154":true,"sysctl":true,"swap":true,"tmpdir":true,"segv":true}
syz_mount_image$ntfs3(&(0x7f0000000000), &(0x7f0000000140)='./bus\x00', 0x19c6038, &(0x7f0000000180)=ANY=[], 0x1, 0x1f231, &(0x7f000003e780)="$eJzs3QmYTeUfB/D37Pu+XLvBWEO2RLLvsm+pZAvZyRalGhJRSSWpFElCQqhUEklEsi8JSZKQVEIS/2fu3JlmufOvadf7/TyPOfeee877nnu+94z5ne0ebz25edsGbRISEhKIzZAU50gGSSSJXIq9xsfGXYoNmdi/EZ3nV9ttftQreZxZcOVtoxYUXjVUa7/MfEsim+xOx09VOLwp3JT7+MW2vXoPSeg9JGHAwKEJXRO6DRw4tGu3fj0Suvce0rdsQst+PboO6ZHQe8CQHoMzvNyz38BBg0YmdB3Q3VAHDe4xZEhC1wEjE/r2GJkwdGDC0MEjE7re2rX3gISyZcsmGCqB36jd/H96CQAAAAAAAAAAAAAAAAAA4M9x6VLaoX0AAAAAAAAAAAAAAAAAAAC4TDVo3LR+OaKkPWcIQxoRhsxlCCH2L9OlXvfPZdNO8qRdoo9yRX82Sn10um/5fuf
<and a huge amount more>

