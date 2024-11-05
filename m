Return-Path: <linux-kernel+bounces-397174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADCB9BD7A7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F12628461E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602C4215F52;
	Tue,  5 Nov 2024 21:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ypjWPhiD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEA813CFA8;
	Tue,  5 Nov 2024 21:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730842253; cv=none; b=ZSeG/jILq1TzIO+I6EuZmtzaNsQkMHzqwtdR76nwr4imUPWhigqz6JsfpWseqPPmU0slf7bVJmDz9p5DrVhzWmpdJX8wkTeA9BATVS80RlKr62I9DH5CE+qb72sJg1Qu+FRt2zxd1w5h2co0kBctoMNmYdo8Qhny+izEAZm5ch0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730842253; c=relaxed/simple;
	bh=hJ/fSdGuiPSVJejMeODYq2K1U7Qo+Lt7vA/fPUxTEzk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=l4a3tK8bABLdEjGC3cHED9vS5ReaPG7EUIMhcPemqrvagQFH0uz0ZsyNj7ge9bwMpfve9c7q5eos6jqF4bml9lXM411CPwycFt07rUhAonbf3qEt0bH1dO/A9OTEizjjoMKtzb2TfZyNsoNFPhzIy5FmH8bIU5dPz4PES/a6Vb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ypjWPhiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5BDC4CED1;
	Tue,  5 Nov 2024 21:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730842253;
	bh=hJ/fSdGuiPSVJejMeODYq2K1U7Qo+Lt7vA/fPUxTEzk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ypjWPhiD0+8G318Ox8rIxvKJYksWuuDkEoIyInZ5jqX4+dKNR7wN6TmrTxp3XDlHf
	 boRdf4dIqtlhkAL91aHmoE1c3v+ms1lItK1GB2/RQkA1MpL69X/z/i4J4KwfHUSrEK
	 c0UM2E+sJP+OIcpI4BiTatl086BAVD9Dun/1QPh8=
Date: Tue, 5 Nov 2024 13:30:52 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: syzbot <syzbot+ccc0e1cfdb72b664f0d8@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 pasha.tatashin@soleen.com, syzkaller-bugs@googlegroups.com,
 linux-usb@vger.kernel.org
Subject: Re: [syzbot] [mm?] kernel BUG in __page_table_check_zero (2)
Message-Id: <20241105133052.599b6b71ff547092c9c7aad7@linux-foundation.org>
In-Reply-To: <c5a71213-ca55-4165-8e50-2686d05614e3@rowland.harvard.edu>
References: <67230d7e.050a0220.529b6.0005.GAE@google.com>
	<20241104200007.dc8d0f018cc536a4957a1cd0@linux-foundation.org>
	<f94f3351-be53-4d61-a31a-2bb07925c5ad@rowland.harvard.edu>
	<20241105110236.40819b7effad3f44de73dddf@linux-foundation.org>
	<c5a71213-ca55-4165-8e50-2686d05614e3@rowland.harvard.edu>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Nov 2024 15:42:12 -0500 Alan Stern <stern@rowland.harvard.edu> wrote:

> On Tue, Nov 05, 2024 at 11:02:36AM -0800, Andrew Morton wrote:
> > On Tue, 5 Nov 2024 11:39:59 -0500 Alan Stern <stern@rowland.harvard.edu> wrote:
> > 
> > > On Mon, Nov 04, 2024 at 08:00:07PM -0800, Andrew Morton wrote:
> > > > On Wed, 30 Oct 2024 21:54:22 -0700 syzbot <syzbot+ccc0e1cfdb72b664f0d8@syzkaller.appspotmail.com> wrote:
> > > > 
> > > > > Hello,
> > > > > 
> > > > > syzbot found the following issue on:
> > > > 
> > > > Thanks.  I'm suspecting some USB issue - fault injection was used to
> > > > trigger a memory allocation failure and dec_usb_memory_use_count() ended
> > > > up freeing an in-use page.  Could USB folks please have a look?
> > > 
> > > Andrew, I'm not sure what to look for.
> > 
> > Thanks for looking.
> > 
> > > Can you read through 
> > > usbdev_mmap() in drivers/usb/core/devio.c, along with the four short 
> > > routines preceding it, and let us know if anything seems obviously 
> > > wrong?
> > 
> > All I see is lots of USB code which I don't understand ;) It seems odd
> 
> Well, I wouldn't expect you to understand the USB-specific stuff.  I was 
> really asking about the memory-management calls and error handling.
> 
> > that usbdev_mmap() calls dec_usb_memory_use_count() on some error
> > paths, but goes direct to usbfs_decrease_memory_usage() on others.
> 
> The paths that call dec_usb_memory_use_count() are those on which a 
> memory buffer has been allocated and needs to be deallocated.  That 
> routine then calls usbfs_decrease_memory_usage() as needed.
> 
> > Did you try running the "C reproducer"?
> 
> No, I haven't.  I haven't had much time to work on this.  In fact, I 
> couldn't even tell exactly which call in dec_usb_memory_use_count() 
> caused the fault; the line number listed in the bug report didn't match 
> up with any obvious suspects in my copy of the kernel source.  Was it 
> the kfree(usbm) call?

Check out the sysbot commit first: 850925a8133c.  Line 198 is the
hcd_buffer_free_pages() call.

hcd_buffer_free_pages() doesn't appear in the backtrace - a bunch of
things I'd expect to be present aren't there.

