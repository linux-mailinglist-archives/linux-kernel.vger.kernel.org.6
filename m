Return-Path: <linux-kernel+bounces-341011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B10987A2C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 22:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CECE1F2447C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 20:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE4416131A;
	Thu, 26 Sep 2024 20:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V/rDDouB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBC3282FA
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 20:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727383633; cv=none; b=jg4RNt2bTzeJUJ/kC8VMhSYYhVTGmjzCkw6KDW6PmqJMgnMObl/7YtQLb7t5PVhKE4h4IyTm7cu8sU+JOk79vH3l57kqjJJSoMHqvGuAIBaKOPEJjISKK32IummsjaPcBTuHuBNFZeH/YieUmSQez8L3BMbsO/aX6JiCIMBsSZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727383633; c=relaxed/simple;
	bh=p6BEhbVfq/NrBLwnvfSaWcgE4gJvgiGMTyCgFQpBgUg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WcjLFj0/aVtSmi+jBpAfjrbhh7HhL4xNBIIMg9g/c4p2kf9cLBUEd9E+2xIVNRNAa4SPkHbW5eF8Y0JXzp/LRs/ovYvVedwB19FGkI/zQi5QFYuHVVh9SfSmFuhrWjKuOsUlVg5N1mcEBWDXBeQgi6Y9t+AVbltVuJdGO0nPYjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V/rDDouB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DB6C4CEC5;
	Thu, 26 Sep 2024 20:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1727383633;
	bh=p6BEhbVfq/NrBLwnvfSaWcgE4gJvgiGMTyCgFQpBgUg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V/rDDouBjdNcWrH6JRKCAugyirykGI0GU3NrrFCydFRtIPRfxbo/o6ccW2wnYBML9
	 F0NZond9aRczQtzs2iKYknjEaoOxEMeA4fMPl6CPl/5YsIbJPz0kNuknftuDQObJm0
	 /s9i3PW04taTy6e3rjXlCGE7yCduOvFlZsrrfSgM=
Date: Thu, 26 Sep 2024 13:47:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: syzbot <syzbot+645f216781b26a92a732@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 pasha.tatashin@soleen.com, syzkaller-bugs@googlegroups.com, Peter Xu
 <peterx@redhat.com>
Subject: Re: [syzbot] [mm?] kernel BUG in page_table_check_clear (2)
Message-Id: <20240926134712.e99b7e7068ecc45f7cd00f16@linux-foundation.org>
In-Reply-To: <66f4f173.050a0220.211276.003c.GAE@google.com>
References: <66f4f173.050a0220.211276.003c.GAE@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Sep 2024 22:30:27 -0700 syzbot <syzbot+645f216781b26a92a732@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1ec6d097897a Merge tag 's390-6.12-1' of git://git.kernel.o..

Thanks.

> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=173cdca9980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6265dd30e362bb47
> dashboard link: https://syzkaller.appspot.com/bug?extid=645f216781b26a92a732
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12fcb080580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b76c27980000

Seems to be memfd-related.

Will the bot be performing a bisection search?

>
> ...
>

