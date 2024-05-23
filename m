Return-Path: <linux-kernel+bounces-187541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4DF8CD331
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4D71C220D8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D517114A4E9;
	Thu, 23 May 2024 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Hsj30XWr"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E53714A4EA
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716469523; cv=none; b=kjG+6gHg/Fltn5iBS6q0DdfuU6xgp6j7+5hRrErh65aNVvhJXxD6fgtN/DBZmJdN1qWjBYXZAHozLbNCepcY2fUdC77xMhbp7K63qogLAZjc1Uw2p+7ynqCvnLNRoBjiwMbqUJuLrM0ZsbKUxg6s42uKOQ46LHzpnxYAXFw+4Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716469523; c=relaxed/simple;
	bh=T9afDleXRzBxJZKBOaQ/5h1gdMwqmEHOTqhTW5+06JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTleNuWkeMZVcQ6I8DhRxNzMx2ytmUdD/eJQjQ4NUAJH3A5vKcQks3+OrZKqLg/i7p3C89LDsUWTEVFbuMkOSy6cF9c6GCar3mZN4kZSZm8PJoah/lzEM2HJqLZf0R47MEr304jSGwWqMNa1nb3eSzMNplAThF+lPF7ldQ06HL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Hsj30XWr; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-7-50-195.bstnma.fios.verizon.net [108.7.50.195])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 44ND4vx7028458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 09:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1716469499; bh=WZycEgts+i1uj4kN6iMFbOpgTuCjrceEnZED0MElG2U=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Hsj30XWrD5KN9QJX60Huqz+BT45WlWdO5cCHBmb5C2WmIy2NQtUfMq3o13mzHpgk9
	 R3PmhxlcCBtZnmfWE+q5eJnxMAA6Sq2RUglx6gLHUXAUP7sxcAc+UPt5EwcASg90O9
	 Xyw4Nfjz4LVdnCS4BjukgJt5IvK/pgpzpsd7MgjA5hS8txlRNT400lSVXr/8GgEaKI
	 aYk2MyOTEF6qWZggXlryQOiHfABZ91Akgw5SrA9vIKMhTg29kFLAWG9QK2fog07T8f
	 bWO3UGOqAKztL2J7lOOlON/YBVIeMve/ZXZwJyDKdBAVSjxs7MsgBsORCygi8dDzHU
	 1E2rLWrZ7au8A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 05EC115C0225; Thu, 23 May 2024 09:04:57 -0400 (EDT)
Date: Thu, 23 May 2024 09:04:56 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: syzbot <syzbot+50835f73143cc2905b9e@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Justin Stitt <justinstitt@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [syzbot] [ext4?] WARNING in __fortify_report
Message-ID: <20240523130456.GH65648@mit.edu>
References: <00000000000019f4c00619192c05@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000019f4c00619192c05@google.com>

On Wed, May 22, 2024 at 11:29:25PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> dashboard link: https://syzkaller.appspot.com/bug?extid=50835f73143cc2905b9e

> ...
> strnlen: detected buffer overflow: 17 byte read of buffer size 16
> [<8080fe10>] (__fortify_report) from [<818e9a40>] (__fortify_panic+0x10/0x14 lib/string_helpers.c:1036)
> [<818e9a30>] (__fortify_panic) from [<8062a3b0>] (strnlen include/linux/fortify-string.h:221 [inline])
> [<818e9a30>] (__fortify_panic) from [<8062a3b0>] (sized_strscpy include/linux/fortify-string.h:295 [inline])
> [<818e9a30>] (__fortify_panic) from [<8062a3b0>] (ext4_ioctl_getlabel fs/ext4/ioctl.c:1154 [inline])

> [<818e9a30>] (__fortify_panic) from [<8062a3b0>] (ext4_fileattr_get+0x0/0x78 fs/ext4/ioctl.c:1609)
> [<8062829c>] (__ext4_ioctl) from [<8062aaac>] (ext4_ioctl+0x10/0x14 fs/ext4/ioctl.c:1626)
>  r10:836e6c00 r9:00000005 r8:845e7900 r7:00000000 r6:845e7900 r5:00000000

This is caused by commit 744a56389f73 ("ext4: replace deprecated
strncpy with alternatives") and it's unclear whether this is being
caused by a buggy implementation of strscpy_pad(), or a buggy fortify,
but a simple way to fix is to go back to the good-old strncpy(), which
is perfectly safe, and perfectly secure.

(And this is a great example of "security initiatives" being an
exercise in pain alocation tradeoffs between overworked maintainers
and security teams...  regardless of whether the bug is in fortify,
syzkaller, or an effort to completely convert away from strncpy()
because it makes security analysis easier.)

						- Ted

