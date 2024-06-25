Return-Path: <linux-kernel+bounces-229761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5249173B1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 23:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA011C223DA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C20717E467;
	Tue, 25 Jun 2024 21:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DN/fooTa"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E3617C9F5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719352354; cv=none; b=o1ZkK8ntth9L1URG4eDJn71jrcHF0Ulm1SwVA7IppMMMM73X6r33ZcEZfEIX+abUGgdJcvOlCcJT+RzuXfCUDbQCLF4ZoV/N3ik0ja5fLwZtxX4WDPbm/MsC4F2ofde/6y8dqDu7KNQuV5MhgLb/U/L/UGg4dN6q8thNm8H9AdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719352354; c=relaxed/simple;
	bh=SUCCAfjJbxB1fBIzgA3DbjmnKHuIJgVpCERu6tzl5+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbC3BbW4hfDfcG+JBKheN6/hxu3nYRlTm5xKW2XWIzbl1TcThN8npyRXnunN9PMdjF4rxitEUicDy+kiGYXVGMfDailaGDLi05FFXfpbd6e3+DUKPYD6n0fXwEI+3F7BNq5oXcBouAQJK7r9ez4cWY4Ynh67cLlsKHwSe950hiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DN/fooTa; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: peili.dev@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719352349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q9ySen9ODooOKtVmjb6drkNQAb9Lmhj/yj/CTshQASI=;
	b=DN/fooTaIzJS2qhQyQZN/K0cQILZVNwgg3snOpvO/NAgh3JQKchQz8//ocq3bg9DhUgGjl
	lphzgGSg7p3ihsDcxXdQprmMRiMR6d3Ln/Ik36OlMzkbaOON04sHtFemPgngUh5AhT+Cz0
	4IqgIWbcA1GP8aZUO+znv3jnCD/Xqkw=
X-Envelope-To: bfoster@redhat.com
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: skhan@linuxfoundation.org
X-Envelope-To: syzkaller-bugs@googlegroups.com
X-Envelope-To: syzbot+a2bc0e838efd7663f4d9@syzkaller.appspotmail.com
Date: Tue, 25 Jun 2024 17:52:24 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Pei Li <peili.dev@gmail.com>
Cc: Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com, 
	syzbot+a2bc0e838efd7663f4d9@syzkaller.appspotmail.com
Subject: Re: [PATCH] bcachefs: slab-use-after-free Read in
 bch2_sb_errors_from_cpu
Message-ID: <yylyynqrcvpx2wptnstqo3v7fqizxakwjmbqivb5rwqfs3szub@hyjfokkufyol>
References: <20240625-bug2-v1-1-73f89535d3a0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625-bug2-v1-1-73f89535d3a0@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 25, 2024 at 01:04:59PM -0700, Pei Li wrote:
> Acquire fsck_error_counts_lock before accessing the critical section
> protected by this lock.
> 
> syzbot has tested the proposed patch and the reproducer did not trigger
> any issue.
> 
> Reported-by: syzbot+a2bc0e838efd7663f4d9@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=a2bc0e838efd7663f4d9
> Signed-off-by: Pei Li <peili.dev@gmail.com>
> ---
> Syzbot detected we are accessing free'd memory in
> bch2_sb_errors_from_cpu().
> 
> It is caused by race condition when another task is freeing the array
> protected by fsck_error_counts_lock.
> 
> This patch acquires fsck_error_counts_lock before accessing the entries
> and get the current number of elements in the array.
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Tested on:
> 
> commit:         55027e68 Merge tag 'input-for-v6.10-rc5' of git://git...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1790a501980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d6b9ee98d841760c
> dashboard link: https://syzkaller.appspot.com/bug?extid=a2bc0e838efd7663f4d9
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=1272faae980000
> 
> Note: testing is done by a robot and is best-effort only.

Looks good - applied

