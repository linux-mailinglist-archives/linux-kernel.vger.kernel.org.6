Return-Path: <linux-kernel+bounces-351723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A17599155B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 10:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD1D1F234AF
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 08:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B473712F375;
	Sat,  5 Oct 2024 08:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A8vT7ygj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D8C2E400
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 08:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728117789; cv=none; b=cPNcAFoEdcZN/E5ElGb0nMOgkmMMOMOnhh78fqD//wla/GKpdnoWNK0J7bei0TTf0EL6lYBjIGOofS3ZjIC91TIcwfwOxQbHCxDYtEn842Lj/JGmdGVYMexhUn2es/IokY5+tcPQJqxFmlc0+ygCqnYpp9FFjecjmu/Jms/HJXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728117789; c=relaxed/simple;
	bh=FNY93F6fuGp0df+0BZXhKJaZOKTSiSWtKmVrPs+/u+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CV+lCWWk5MPntD+o59Hh0qTXyvFi7yLcNenfWbnBb8910pSOFMlk70ZCEip2jkZW71Mo/RWShrxWe6aQDV5LWbhtHxmEOKwiyhAlVqdzKGg+svUE0CZNsY0F2cfVxPcK+a6js6gbeWer5a7cOdkCLWMR4TnJgMgXPrWMpIuJ/5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A8vT7ygj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA643C4CEC2;
	Sat,  5 Oct 2024 08:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728117788;
	bh=FNY93F6fuGp0df+0BZXhKJaZOKTSiSWtKmVrPs+/u+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A8vT7ygjvDArA91dgUfl5eUTlcruZQmdY8at/R8J8EOIG0oq/viWwmJQ97U+Mep6o
	 7OM2creMzoeaEi7RcYj7+woz6hVafZYLKVXxiSOISZefSZ7GcQNQSaf9mgO7kn70Gh
	 ayeAkJ1kXjp1NB8l/DO+CevSdTawXRVW64kdLIBc=
Date: Sat, 5 Oct 2024 10:43:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, paulmck <paulmck@kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Hazard pointer enabled refcount prototype
Message-ID: <2024100538-acquire-imprecise-ecee@gregkh>
References: <3b749585-1286-4a4e-acd0-1534b60172da@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b749585-1286-4a4e-acd0-1534b60172da@efficios.com>

On Fri, Oct 04, 2024 at 03:52:01PM -0400, Mathieu Desnoyers wrote:
> Hi Greg,
> 
> After our discussion at KR2024, I've created a prototype adding hazard pointer
> dereference support to refcount.h:
> 
> https://github.com/compudj/linux-dev/commit/234523dc9be90f1bc9221bf2d430c9187ac61528
> 
> Branch: https://github.com/compudj/linux-dev/tree/hp-6.11-refcount
> 
> It allows dereferencing a pointer to a refcount and incrementing the refcount,
> without relying on RCU.
> 
> A good candidate for this would be the "usblp" driver which is using a static mutex
> for existence guarantees. Introducing a refcount as first field of struct usblp
> should do the trick.
> 
> I am not entirely sure if this kind of use-case justifies introducing hazard pointers
> though, as this can be done just as well with RCU. I'll let you be the judge on this.

How could it be used with RCU?  I'll have to look into that, but thanks
for the links and I'll dig into this on Monday to see if I could use
these to get rid of the "static mutex" pattern that almost all drivers
need to have these days (which in turn will mean we will not need to use
that in new rust drivers either, which will make them simpler as well
because the static mutex pattern in rust is rough to make work.)

thanks,

greg k-h

