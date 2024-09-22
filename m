Return-Path: <linux-kernel+bounces-335201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0B997E282
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 18:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C261F21251
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 16:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEE427453;
	Sun, 22 Sep 2024 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="ZUOxvaUM"
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CF9AD52
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727023285; cv=none; b=mDPgK9OXo0a74MUYhFjVwxlrAlf97P9Kb67ctflweh9Lh5Z6kHlKEBqxSfTA6LHKhvBQX7rV8H1KnA2r5mT8lTRty5mO1Tah6EX7bWmKNuiVvYLIk3vZGYHFiSg/85s8xqNu/IeTwB3lwiGh0coJidFXxayxSdE8sNnsGjNLVuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727023285; c=relaxed/simple;
	bh=H3ITRVHeVK3MQetuvUo+jYd7fzfi4mDme8vBdLJR1bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHcoDEJ2cRbN7X7/pcPKj4tvVxha/toVB+owztIDKBKYvPoJtzTwRkrDFqexRwBqtRNfjfRr5DT7AqdJN/c6Gjf8s+6kml7RgZ3YvpHloXLZzKj4gjrfajMYNhqlOZL0XxkhegKxM8BjIMIdsXdJkJEOPBmPGIGTP62zL6Tp4aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=ZUOxvaUM; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id CE44614C1E1;
	Sun, 22 Sep 2024 18:41:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1727023274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1P1Jf0ApaFd/B8Qm3MqF7vJhOb3M7CqnXehx+3pU5eg=;
	b=ZUOxvaUMPkXN0wei9pFj8ede5uEJwaXlYsc39HlxDAOcpwPljh4l664/2WJjlrGorEs4+O
	BN9ITDY1xV7z61C4MSWveMRb9KC/XS5AKJebr5dig1bqhMqtkYKeDCUiU2SYArGZnXV1bM
	OHoR4GDi46ljuybAclwtD7+CCrT14F5D7qTeAMBJAGqokbxTVd065C2ZCZz2lbGLmQSdH0
	CyOWZvY+uLb8yv7DzT35N3JBsHjCNJnx6L5Qa7TKhwc/39J1S/vVi/R0GR3MxBiwfHJuJ6
	OMMjHhDy6LqdR6eD6q5bh2BrC9gj2UfNkAXMlcNJjB88k13jtUA0Aft1fhDglQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 0ff33cac;
	Sun, 22 Sep 2024 16:41:10 +0000 (UTC)
Date: Mon, 23 Sep 2024 01:40:55 +0900
From: asmadeus@codewreck.org
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: syzbot <syzbot+3c5d43e97993e1fa612b@syzkaller.appspotmail.com>,
	cl@linux.com, ericvh@kernel.org, linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com, lucho@ionkov.net,
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev,
	vbabka@suse.cz
Subject: Re: [syzbot] [v9fs?] WARNING in p9_client_create (2)
Message-ID: <ZvBIl8b9RRK9jgtJ@codewreck.org>
References: <66f0092d.050a0220.3195df.009b.GAE@google.com>
 <CAKbZUD08BQeK0R-KuU07=QUCW7GHbmZ0RgfUcOpzKd+Yv4b5CQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKbZUD08BQeK0R-KuU07=QUCW7GHbmZ0RgfUcOpzKd+Yv4b5CQ@mail.gmail.com>

Pedro Falcato wrote on Sun, Sep 22, 2024 at 03:59:17PM +0100:
> This was one of the issues I actually ran into when using virtme.
> Fix was submitted here back in August:
> https://lore.kernel.org/v9fs/20240807094725.2193423-1-pedro.falcato@gmail.com/
> 
> No replies nor was it picked up. Can it go through the slab tree?

Sorry, we're not getting many patches for 9p so I've been slacking and
trying to batch a bit for when I can find time to pick them up -- don't
hesitate to ping again if nobody replied in a week or two.

In this particular case I remember thinking it was a shame we're
creating a cache for this when most mounts will be sharing the same
msize but never found time to actually consider how to share the
caches... But this isn't anything wrong with the patch itself, sorry for
the delay.
(and now I'm thinking about it, I guess the slab code has something to
regroup identical caches? Just looked and didn't find it but I recall
something like that...)

Anyway, I've just picked that patch up (don't expect any trouble but
will be queued to next later today), I'll send it to Linus in a week.

(I'm also adding the syzbot reported by so this gets closed even if it
came later)

Thanks!
-- 
Dominique Martinet | Asmadeus

