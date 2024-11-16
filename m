Return-Path: <linux-kernel+bounces-411919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0041E9D012C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 23:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BE44B23527
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 22:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BFB198E80;
	Sat, 16 Nov 2024 22:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="eNTEaj28"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D723311712
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 22:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731794769; cv=none; b=jqDZv0ktQ0PHv+3Da4HB9XZ9ROqC7QkbhvSJJ1qnVVQ9540oVLkfpAlINcE+nQW6d4qwRBWRC4uqkdDbAp/sFpLkVCEtm2yphtngmDzHwtgjTWzDYIiHJ0FBOD4m4LwR8639NBPLkVNkXHAjHudMtXt5kqyvPm0gOxM+IMh2OrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731794769; c=relaxed/simple;
	bh=LLxoy04THi1IZJKp01rMM58ZiPlexaQEHuI2s/wK1zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGu49WKcMrXZlXa9OQldkfIA75JqaUV9OYpHmg24cjnht/wi4rjhKha0UUs451i4bDs0s6OQTQk/VEXjSIk1hc9Kpkh5IZ/JCGxMM7+RrF/uJIbCjinE2iisOKVEDkrrkYpeRPE1/99pmU4CU36ORAjrmZOplhYqhriAiyApRBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=eNTEaj28; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zfI1UJyRR9DkLlvfwj/S8iP6JwOhwlVsZ+vUMaqSrJI=; b=eNTEaj283sB81onGSaqyNzv+Ib
	G9mC+WYrO8oKtNjaTHENd2V4aYoPlSicgFM2WAMztIwiOABiE+QqgawIPUEhgnTzJ19IL1RoZln7L
	2cKzejhHtU8oINVYrOQbfdsJrZCLxpYnI7dJMyjvGvUJRyTYCtLyY/vHxc8j6hEGFlU+DWEEx2jf/
	1G68l1KxA1hKInoqk3Tedj3DHEI2ZHTEqF6IQVhuZurjGQng30sdYNOjiWgy0SxqLyIx/4Y51b3XJ
	rJPCNMKRZCMWsj/PBtnCZFpQHoyX7OUDwIpxywS/9FKYU81zAGg6X7pCaI5TnZBHDWqdhJw3nOjrW
	YkybW78w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tCQva-0000000Fte7-2jg3;
	Sat, 16 Nov 2024 22:06:02 +0000
Date: Sat, 16 Nov 2024 22:06:02 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Nir Lichtman <nir@lichtman.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ebiederm@xmission.com,
	kees@kernel.org, brauner@kernel.org, jack@suse.cz,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] exec: make printable macro more concise
Message-ID: <20241116220602.GE3387508@ZenIV>
References: <20241116061258.GA216473@lichtman.org>
 <20241116072804.GA3387508@ZenIV>
 <CAHk-=wiMEpPZYDeF5ak8FToB_fw7pfjKhuJAcjLpjqMfCvvB7g@mail.gmail.com>
 <20241116172301.GA222714@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116172301.GA222714@lichtman.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Nov 16, 2024 at 05:23:01PM +0000, Nir Lichtman wrote:
> On Sat, Nov 16, 2024 at 08:49:39AM -0800, Linus Torvalds wrote:
> > On Fri, 15 Nov 2024 at 23:28, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > Now, whether that logics makes sense is a separate story;
> > > that's before my time (1.3.60), so...
> > 
> [...]
> > 
> > Anyway, the fs/exec.c "printable()" code most definitely shouldn't use
> > the ctype stuff. I'm not sure it should exist at all, and if it should
> > exist it probably should be renamed. Because it has *nothing* to do
> > with "isprint()".
> > 
> [...]
> > 
> > Anyway, a.out support is dead, so I think this code is pure historical
> > leftovers and should be removed.
> > 
> >            Linus
> 
> Thanks for answering Al and Linus.
> Al, continuing forward, to work on a new version of the patch removing the
> support for dynamically loading binfmt kernel modules or you'll take it
> from here?

Just kill it off, since you are poking in the area anyway...  No point
coordinating patches, etc. - removal is completely straightforward,
with something along the lines of "that was an ancient leftover from
a.out-to-ELF transition, left without a single valid use after removal
of a.out support; anyone who might find future uses for it (currently
there's none) would be better off using binfmt_misc to trigger whatever
module loading they might need - would be more flexible that way"

