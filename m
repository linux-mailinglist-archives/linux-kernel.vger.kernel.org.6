Return-Path: <linux-kernel+bounces-242970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DE7928FAB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 02:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2E761F229D9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 00:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A5BEC0;
	Sat,  6 Jul 2024 00:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DzhTaylS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93BA360
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 00:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720224728; cv=none; b=XivpFFpqmazFlq0k06P+nb9UomWfIPOYjPvWWVogGrzSXEtAOS+G9ruoSE+hMhl4rW9pB0zABfB7b1QRWZstgnNiUHaD4Vk5vd5nvHckZR+DF9bR4ftmeq8dK6p7g9pWpN47q1gT3cvxKEck4kxng58zYqAVs2K6QdMdX0eY5LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720224728; c=relaxed/simple;
	bh=jn93tI6Ecgv8ripCCk/bBZy/npDcXNgnxyv6HSkEpag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFjchlJUj0+rNzaaTgiS+TigTK4w9nM/++ByFcMHc1qBxM0kes3X7QDG+07rIBuaKe0LRgD+TDsbXAITAuLsZycqMSr/vibpW9l/xXf6J0eEJqTAwIFZ+iRikHDNi+5aFXqqQq1sV7RxgBzh2wF0A/l9YKEKz6e8LtEeU+QidTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=DzhTaylS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB15C116B1;
	Sat,  6 Jul 2024 00:12:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DzhTaylS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720224722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6kkzCG1yU6CNYE6GToxrNpzNj95WbzRwOqplwdV0la8=;
	b=DzhTaylSx/bqMBPRwXV7WIcxe4lW8lmsEETKnfwKF/lsQe9u4PbX3ReXBn+RhglNaO5Oc3
	wjt/mjdxR7LSNGdglwyHMFw6FGQTyaKhwNRpos2aN8bqfE3VJK1eZgUckAp1XapCpP5mWN
	n7uPJZfyk2uKT+lTf2JKlznBj69vqUM=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 16013217 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 6 Jul 2024 00:12:01 +0000 (UTC)
Date: Sat, 6 Jul 2024 02:11:59 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: jolsa@kernel.org, mhiramat@kernel.org, cgzones@googlemail.com,
	brauner@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Subject: Re: deconflicting new syscall numbers for 6.11
Message-ID: <ZoiLzzM94m_sjfVK@zx2c4.com>
References: <CAHmME9pgFXhSdWpTwt_x51pFu2Qm878dhcQjG9WhPXV_XFXm9w@mail.gmail.com>
 <CAHk-=wjCmw1L42W-o=pW7_i=nJK5r0_HFQTWD_agKWGt4hE7JQ@mail.gmail.com>
 <CAHk-=win2mesMNEfL-KZQ_jk1YH8N8dL9r=7XOLp28_WMazpVg@mail.gmail.com>
 <ZogcxjLv3NAeQYvA@zx2c4.com>
 <CAHk-=whRpLyY+U9mkKo8O=2_BXNk=7sjYeObzFr3fGi0KLjLJw@mail.gmail.com>
 <ZogzJCb66vwxwSLN@zx2c4.com>
 <CAHk-=wgH=d8MUzJ32QNW_=KDQz7U5g_1Mm9sR9zB1iNUpxft7Q@mail.gmail.com>
 <ZohB6uPAVX03Sc96@zx2c4.com>
 <CAHk-=wgC5tWThswb1EO5W75wWL-OhB0fqrnF9nR+Fnsgjp-NfA@mail.gmail.com>
 <CAHk-=wjwU6o4QExra5qNzBxtX5NwTfaX8ytZKk8BFtOng6zqSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjwU6o4QExra5qNzBxtX5NwTfaX8ytZKk8BFtOng6zqSQ@mail.gmail.com>

Hi Linus,

On Fri, Jul 05, 2024 at 12:46:37PM -0700, Linus Torvalds wrote:
> If saying "the state size is fixed at 256 bytes" means that ten years
> from now, we won't be updating to some super-duper fancy new algorithm
> that wants to keep a huge state size - then that's a GOOD thing.

I'm all for avoiding fanciness. I can imagine three plausible scenarios
where we benefit from the kernel doing the allocation, rather than mmap,
or where it's nice to have the kernel decide on the size:

- On some platform, it's actually more efficient to generate N blocks,
  such that the state there needs to be larger.

- The amount of state that we buffer increases according to some speed
  vs practicality trade off that changes. (Right now we buffer 1.5
  blocks; maybe 3.5 would be better eventually.)

- We find out that there's a better way of doing all this with a special
  mapping instead, or some other means.

What I have in mind, IOW, isn't fanciness. But alright, let me run with
where you're urging me and see where that takes things. 

> Side note: you could just stick the size as a constant in the vdso too.

Yea, this sounds more like solution (4) from my last email. I'll give
that a shot and see what it's like nuking the syscall. I'll ping here
when v21 of the series is ready, and hopefully you like it more.

Thanks for brainstorming this all with me.

Jason

