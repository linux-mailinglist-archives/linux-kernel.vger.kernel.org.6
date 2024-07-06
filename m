Return-Path: <linux-kernel+bounces-243406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2879295E1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 01:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7020281B84
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 23:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECAB43AC3;
	Sat,  6 Jul 2024 23:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QEbND5Cu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E970D208BA
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 23:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720308378; cv=none; b=S37c8bxRvex7nC6osA9u9360Xxt+sVMw/sovKXBFLxzcH5yqTsGIV0yxUbu7iDLW/RCBhS/1z9ZJ61duNiD/unEPu/l+CMJJow9INn8dFip3M2BlsYW3JSB1e7prxyTbe47P5SW2Vhj8Dxsn+WiG5/N00Ajn+YYUJHbGcAGyOhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720308378; c=relaxed/simple;
	bh=sX1BZ9AgLzzn2az8RZNnCqCxvpTqfrEHESYZ0g452wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASpuLJ0AkxGMhX7HmUalAfrizb3L7ZxxfjR/4RnG+vPX/nxxbLUGS8i7RjIxS0BQ3b22bbr1762tIJaKNUgF+TzSy9HJxZzoSTwWVxc+bqFsFSjXQxXII4jewORSJM2UbYpATXIZ/7PNVfPzoY0PKftkLZbo+ywy3jUvNmQ8WDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=QEbND5Cu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D7CC2BD10;
	Sat,  6 Jul 2024 23:26:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QEbND5Cu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720308374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B83bxoRfCAFI+JIVmqyQu1wlzNm60i+mjr8CbGA6YZQ=;
	b=QEbND5CuTCLZriPzVNm1RGqIA0vL8EYv78qcqkQKXYH+AWuozIjAWaIfnKYj/G04vOgT8K
	/5MaAnvLrm1o2MdQoB/SEBZPoNKyPs3JmhuWYXI8bKbeyaudvl5VB0sdHrOydkuZiNHecM
	thxPbWnU3sR3+mO9lQH2i+bhrIdyy8o=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a7c61a4f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 6 Jul 2024 23:26:13 +0000 (UTC)
Date: Sun, 7 Jul 2024 01:26:11 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: jolsa@kernel.org, mhiramat@kernel.org, cgzones@googlemail.com,
	brauner@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Subject: Re: deconflicting new syscall numbers for 6.11
Message-ID: <ZonSk0OOD66BdB-S@zx2c4.com>
References: <ZogcxjLv3NAeQYvA@zx2c4.com>
 <CAHk-=whRpLyY+U9mkKo8O=2_BXNk=7sjYeObzFr3fGi0KLjLJw@mail.gmail.com>
 <ZogzJCb66vwxwSLN@zx2c4.com>
 <CAHk-=wgH=d8MUzJ32QNW_=KDQz7U5g_1Mm9sR9zB1iNUpxft7Q@mail.gmail.com>
 <ZohB6uPAVX03Sc96@zx2c4.com>
 <CAHk-=wgC5tWThswb1EO5W75wWL-OhB0fqrnF9nR+Fnsgjp-NfA@mail.gmail.com>
 <CAHk-=wjwU6o4QExra5qNzBxtX5NwTfaX8ytZKk8BFtOng6zqSQ@mail.gmail.com>
 <ZoiLzzM94m_sjfVK@zx2c4.com>
 <ZoinidZQY6hU99XT@zx2c4.com>
 <CAHk-=wg0qkgpNtm_OL-evArZxenQyJtk4BG0fVPGYqoooP6+Cw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg0qkgpNtm_OL-evArZxenQyJtk4BG0fVPGYqoooP6+Cw@mail.gmail.com>

Hi Linus,

On Fri, Jul 05, 2024 at 07:56:03PM -0700, Linus Torvalds wrote:
> On Fri, 5 Jul 2024 at 19:10, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> >     https://git.zx2c4.com/linux-rng/log/
> 
> So we already expose VM_WIPEONFORK and VM_DONTDUMP using madvise().
> Exposing them at mmap creation time with MMAP_xyz sounds fine.
> 
> However, I do note that both the pre-existing VM_WIPEONFORK - and the
> new VM_DROPPABLE - needs to be limited to anonymous private mappings
> only.
> 
> You did that for VM_DROPPABLE, but not for VM_WIPEONFORK.

Good catch, thanks. I'll look over all of that again closely too.

> Anyway, that patch looks largely fine to me apart from that note, but
> I do think you want to check it with the mm people on linux-mm.

They'll certainly be on the list of recipients for the v+1 series when I
post it (hopefully shortly).

> > The selftest code is the largest part of it. There's no more syscall. I
> > think it should be much more to your liking and seems like an alright
> > set of compromises. Hopefully that's a bit closer to the mark.
> 
> From a "look through the patches" standpoint, this did look more
> palatable to me, but I also would have had an easier time with looking
> at the patches if the self-tests were separate commits.

Okay, will do. I think you've got some selftest makefile fixes from
John/Shuah that'll be sent your way if they haven't already for 6.10
that I'll rebase on so that there isn't an annoying merge conflict.
https://lore.kernel.org/all/d99a1e3b-1893-4fac-bf05-bcb60ca7f89c@linuxfoundation.org/

Jason

