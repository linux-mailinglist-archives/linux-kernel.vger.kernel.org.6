Return-Path: <linux-kernel+bounces-425210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E925B9DBEE6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 04:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28762281C9A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 03:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E46113C80D;
	Fri, 29 Nov 2024 03:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cqGc3OV+"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359CF26AD3
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 03:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732851265; cv=none; b=Cu7KjCgfQjF2QhDOZ3ydcFtfrH92YD1BepyLoLgtqApLNyakgxQKWLefVuaB5pRicqE0sen4C7tVOUjihJq37kYIaK1yV2B7i4R+foeB1w0xfiikKzUfL9BCfIGxjPu1rIYdH/Kq1ZKrTJRNguqMaLsVfHB7Ww8OS32MZT3wiSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732851265; c=relaxed/simple;
	bh=sf+LE4On9V9nywqcU4AKey1mvdxkyDX/X44qrosuXgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SP/zUyJjCVqzhScGB50dfYdWWEXJDuLasLTn320tuhHyzR+1b30EidGrZuwzl6VssPqGN7KgAJWY69TAlMHjDkdQePOzlr7g29zRrytNLFyEHMNvFGbCvzyokEJH6JNgGC1SVn/30Kx4lfeJ0viUZGawDZqkWo+GFRq6Akc6PP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cqGc3OV+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qr2eQdPsHN2Hot0kCGSM678AnxlTRP7ARqB1ayT8kaY=; b=cqGc3OV+CmBxXe2hk6/fr8zKAw
	owyEW0B0K77BAISJwtBpUgEFvzmq42E3o1CL96zYxOWLA2igoKZW5pk8vo6ChCAbiv81niJRjQDGo
	H0FU0nKIZGa454GNb++fwCG6aFGdGO3ZhIoxJx971XAI7ZBKAcVJUtkfYSy3BkgGbyfuhdddZqwj+
	Nf6Zd9uGTpZqS2y9E960RjFc/acoCm/XY72i3+4UoI3M5pINZxY5apmL9Cjystm/hU1R5I4bnl7RT
	EP7ADH/G9z0xpjTV/RGdM5BR95OPDsx+sMMS+kdVVF7hSowcZsRV5Q9RycFCsjwowL/+OFq7vrv1N
	QHfZ86CA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGrlr-00000002ycL-1jG9;
	Fri, 29 Nov 2024 03:34:19 +0000
Date: Fri, 29 Nov 2024 03:34:19 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Nir Lichtman <nir@lichtman.org>,
	Tycho Andersen <tandersen@netflix.com>,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [GIT PULL] execve updates for v6.13-rc1 (take 2)
Message-ID: <20241129033419.GI3387508@ZenIV>
References: <202411210651.CD8B5A3B98@keescook>
 <CAHk-=wjMagH_5-_8KhAOJ+YSjXUR5FELYxFgqtWBHOhKyUzGxA@mail.gmail.com>
 <05F133C4-DB2D-4186-9243-E9E18FCBF745@kernel.org>
 <CAHk-=wgEjs8bwSMSpoyFRiUT=_NEFzF8BXFEvYzVQCu8RD=WmA@mail.gmail.com>
 <202411271645.04C3508@keescook>
 <CAHk-=wi+_a9Y8DtEp2P9RnDCjn=gd4ym_5ddSTEAadAyzy1rkw@mail.gmail.com>
 <20241128020558.GF3387508@ZenIV>
 <CAHk-=whb+V5UC0kuJkBByeEkeRGyLhTupBvpF-z57Hvmn7kszA@mail.gmail.com>
 <13223528-74FF-4B68-B0CF-25DCC995D0A0@kernel.org>
 <CAHk-=wgKgi5eqo6oW0bBS2-Cr+d4jraoKfVq6wbmdiWWsZbMLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgKgi5eqo6oW0bBS2-Cr+d4jraoKfVq6wbmdiWWsZbMLw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 28, 2024 at 06:43:31PM -0800, Linus Torvalds wrote:
> A sane setup has lots of options
> 
>  - just use execve() with the actual name of the executable
> 
>  - use hardlinks and use execveat()
> 
>  - use open() on a symlink and then execveat() of that file, and get
> the actual name of the executable behind the symlink
> 
>  - disagree about comm[] being relevant at all, and don't use it, and
> don't use tools that do
> 
> and none of those are wrong decisions.

Just one thing - IMO we want to use the relative pathname when it's
not empty.  Even in execveat().  Because some wanker *will* decide
that newer is better and make libc use execveat() to implement execve().
Which won't be spotted for about a year, and when it does we'll get
seriously stuck.

I agree that for fexecve() the only sane approach is to go by whatever
that opened file refers to; I'm not sold on the _usefulness_ of
fexecve() to start with, but if we want that thing, that's the way
to go.

