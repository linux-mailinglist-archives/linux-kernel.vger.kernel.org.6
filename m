Return-Path: <linux-kernel+bounces-425983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F31D9DED49
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 23:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C4102821F7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 22:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7F11A42D8;
	Fri, 29 Nov 2024 22:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WXXdqVul"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E787E39ACC
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 22:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732920871; cv=none; b=V8okxWz70lSSxQ/n2L4Se0+ct+UkiILSAujyljB/buqOVUIKAL0vwOGmPaXVGp8k0xK3/nSb9lQZfkFCZhAikXiJv7zVfy8Utz6CMcOUiZXvhJGjSat4eK4i6JqsjljuCEsc2o7oe2oZbd+WhU63ZEFxRuxDpVDlwDxjX2Nf5IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732920871; c=relaxed/simple;
	bh=W1A7OLX0wP/gGqqCdc/U7nFnU92n1M+8a+PKp8xkVTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScY/P82PerDpwSfnueeIKIm2OTNTEtxu+KFhbIUTmygJNzis7vdA2Vj3Ya2siQ2LhIx1ef2eVgU86mKStGnRdhgwdT3lmP7gQiBZscoGOWrh4V68AqH3jHpoGr1wugO5LqN27Yd12NMBGYJtJwHh5f0ScLT+SrB68vyQUfzp1es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WXXdqVul; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W1A7OLX0wP/gGqqCdc/U7nFnU92n1M+8a+PKp8xkVTA=; b=WXXdqVul0chkovMR9IDWK2OQG/
	Jw+/9nycdIecolWevuai2+TZHhmq47Sz8oGnFCZlftZg81UvqzYasXV/pVq0NHWwHGZNX3XVtmDwP
	WgZzjUmkNlVAaG7fiasqpQ9a53jy8qGRQEF7Nl+TeKX44QJXS/yQeapGGURM6U/lo7z5NiEfbproS
	pMj3BlLB4bSN3KPjLeYPoMB8pDIbmZ6iXPVlOD492GN2nrxMi0hLOEpkPNEzQAGC8T3SLP675pjX+
	r20gvJdm96sDixQYfjOvQGY3Hs59r175bpyOV1/Rw8lVi6uP13QalrqaTIMU0KVcd1dKQOqSXxfNq
	5rIuEITA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tH9sV-00000003EGj-26zf;
	Fri, 29 Nov 2024 22:54:23 +0000
Date: Fri, 29 Nov 2024 22:54:23 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Nir Lichtman <nir@lichtman.org>,
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [GIT PULL] execve updates for v6.13-rc1 (take 2)
Message-ID: <20241129225423.GK3387508@ZenIV>
References: <CAHk-=wgEjs8bwSMSpoyFRiUT=_NEFzF8BXFEvYzVQCu8RD=WmA@mail.gmail.com>
 <202411271645.04C3508@keescook>
 <CAHk-=wi+_a9Y8DtEp2P9RnDCjn=gd4ym_5ddSTEAadAyzy1rkw@mail.gmail.com>
 <20241128020558.GF3387508@ZenIV>
 <CAHk-=whb+V5UC0kuJkBByeEkeRGyLhTupBvpF-z57Hvmn7kszA@mail.gmail.com>
 <13223528-74FF-4B68-B0CF-25DCC995D0A0@kernel.org>
 <CAHk-=wgKgi5eqo6oW0bBS2-Cr+d4jraoKfVq6wbmdiWWsZbMLw@mail.gmail.com>
 <20241129033419.GI3387508@ZenIV>
 <CAHk-=whi+OgKMXoPQ+48i=_Cu_Yb5_QCv9U9+Wpg0-GumHZSXg@mail.gmail.com>
 <d91debb6-2075-4e1a-af0c-2f3a658cabb3@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d91debb6-2075-4e1a-af0c-2f3a658cabb3@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Nov 29, 2024 at 10:42:47PM +0100, Vegard Nossum wrote:

> Probably a silly question, but why not do the same thing in all cases?
> file->f_path.dentry->d_name.name _is_ the basename of whatever the
> normal path resolution machinery ended up with; why not use just it
> unconditionally? It handled empty paths already. This also seems to
> match what you wrote in https://lore.kernel.org/all/CAHk-=wgKgi5eqo6oW0bBS2-Cr+d4jraoKfVq6wbmdiWWsZbMLw@mail.gmail.com/
> (no argv[0], no magic strings, no symlinks):

User-visible change of behaviour, quite possibly confusing existing
scripts...

Let's not go there, it's a silly place.

