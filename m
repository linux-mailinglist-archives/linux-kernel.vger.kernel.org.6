Return-Path: <linux-kernel+bounces-397012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 339739BD592
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64DE81C22D1E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6691EBA12;
	Tue,  5 Nov 2024 19:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="u45KSegv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4112D1EB9E7;
	Tue,  5 Nov 2024 19:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730833358; cv=none; b=sKzoryVxV8iRclr56k3g+2t82VYwBpOKa5HqB2LIbl59r8QP2CNxuGKqdxK2SAJzgjs+qEqTHRBUEbSTFM/5EFNeQ7k3ReMzRoJQ0yf/JIb2dhZIdRe8FKfxZPpLSuF3W4v2FcKOXZ8W/VtakQSi2cLzyzor1nGMFL3Oqj1Rexk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730833358; c=relaxed/simple;
	bh=0v2wd5Jz2p/5neJZXwXEwg2oCHX8NYIqBryaYbkegO4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Hxhwb16e2pfBZuYkJuskGy+UT9bREb0M2uXlpuMjBnYDZwroesmopAXGFfU9aE4l5uBaUwQaMAf4/QO+1kAViTMJznRSyhPvSyuWda+E6W6D2s2QcW34d5GlFvpmaOI0M0givCln5Q11Yn+g3zkiectDVKMTk5ha+Kb+p6kcbGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=u45KSegv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC8CC4CECF;
	Tue,  5 Nov 2024 19:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730833357;
	bh=0v2wd5Jz2p/5neJZXwXEwg2oCHX8NYIqBryaYbkegO4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u45KSegvLAB++aXRZIEOAQspDt2aA0GeT3ZGnC5e2Wr04NqxivocP+tYmSzgaokOx
	 +F04RWJxRaZFRR4mqb1JNq1jal7x1b2b1jBKf/+MzbPgmDCgV9EDccmUV/zBLer9k+
	 Z2NPK5+u/zJU5YCtwIKBf7cZo38HerCzRXfYbIoA=
Date: Tue, 5 Nov 2024 11:02:36 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: syzbot <syzbot+ccc0e1cfdb72b664f0d8@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 pasha.tatashin@soleen.com, syzkaller-bugs@googlegroups.com,
 linux-usb@vger.kernel.org
Subject: Re: [syzbot] [mm?] kernel BUG in __page_table_check_zero (2)
Message-Id: <20241105110236.40819b7effad3f44de73dddf@linux-foundation.org>
In-Reply-To: <f94f3351-be53-4d61-a31a-2bb07925c5ad@rowland.harvard.edu>
References: <67230d7e.050a0220.529b6.0005.GAE@google.com>
	<20241104200007.dc8d0f018cc536a4957a1cd0@linux-foundation.org>
	<f94f3351-be53-4d61-a31a-2bb07925c5ad@rowland.harvard.edu>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Nov 2024 11:39:59 -0500 Alan Stern <stern@rowland.harvard.edu> wrote:

> On Mon, Nov 04, 2024 at 08:00:07PM -0800, Andrew Morton wrote:
> > On Wed, 30 Oct 2024 21:54:22 -0700 syzbot <syzbot+ccc0e1cfdb72b664f0d8@syzkaller.appspotmail.com> wrote:
> > 
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > 
> > Thanks.  I'm suspecting some USB issue - fault injection was used to
> > trigger a memory allocation failure and dec_usb_memory_use_count() ended
> > up freeing an in-use page.  Could USB folks please have a look?
> 
> Andrew, I'm not sure what to look for.

Thanks for looking.

> Can you read through 
> usbdev_mmap() in drivers/usb/core/devio.c, along with the four short 
> routines preceding it, and let us know if anything seems obviously 
> wrong?

All I see is lots of USB code which I don't understand ;) It seems odd
that usbdev_mmap() calls dec_usb_memory_use_count() on some error
paths, but goes direct to usbfs_decrease_memory_usage() on others.

Did you try running the "C reproducer"?



