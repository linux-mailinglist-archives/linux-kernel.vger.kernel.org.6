Return-Path: <linux-kernel+bounces-526426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65ADA3FE94
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE053BDF94
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EF1250C13;
	Fri, 21 Feb 2025 18:19:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF17E21128F;
	Fri, 21 Feb 2025 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740161952; cv=none; b=sSldo94E+BXYXhQy+QePJK9z2eDEbE+b1VImAFu+ZHWGdltoVmaJ9JeGUeKoqgwl+DLXcqQtut0h2rIpZ0pwDPHN3Y/sJUiA66XK6V2XoEW8dXpOXFC+9c9RDxg2Hbc5H9HGqy+6Qv5xVnpQJ/njoIgukNvOHCZD7QqpN2ZSGSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740161952; c=relaxed/simple;
	bh=Es7ghDygD2xkMuhK4aDVfA9oFbdQaNPrdep7ueQDqz4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jwmt3toh0YlCZKpMInM7Z7o6JOitZPYWnL4XlY7vUCVNjouKOdL+6Blmcm5y6GH/vTsXFUpICMeA3SCrXnzvlb0IP/Up+VdIRvC/MduMWKrU5q5IuoeERAfUpDX3DRw6TcCnNVacHmCf/5qY1kc4pRTzh6wvGi6bpaCrjpETu7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6CCC4CED6;
	Fri, 21 Feb 2025 18:19:10 +0000 (UTC)
Date: Fri, 21 Feb 2025 13:19:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Uecker <uecker@tugraz.at>, Dan Carpenter
 <dan.carpenter@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Boqun
 Feng <boqun.feng@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 rust-for-linux <rust-for-linux@vger.kernel.org>, David Airlie
 <airlied@gmail.com>, linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <20250221131910.5ddac0f3@batman.local.home>
In-Reply-To: <CAHk-=wgg2A_iHNwf_JDjYJF=XHnKVGOjGp50FzVWniA2Z010bw@mail.gmail.com>
References: <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
	<CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
	<a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
	<Z7VKW3eul-kGaIT2@Mac.home>
	<2025021954-flaccid-pucker-f7d9@gregkh>
	<4e316b01634642cf4fbb087ec8809d93c4b7822c.camel@tugraz.at>
	<2025022024-blooper-rippling-2667@gregkh>
	<1d43700546b82cf035e24d192e1f301c930432a3.camel@tugraz.at>
	<2025022042-jot-favored-e755@gregkh>
	<b9a5de64fe1ded2ad3111763f35af9901bd81cc4.camel@tugraz.at>
	<caea3e79-78e6-4d98-9f3b-f8e7f6f00196@stanley.mountain>
	<61a7e7db786d9549cbe201b153647689cbe12d75.camel@tugraz.at>
	<20250221124304.5dec31b2@gandalf.local.home>
	<CAHk-=wgg2A_iHNwf_JDjYJF=XHnKVGOjGp50FzVWniA2Z010bw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 10:07:42 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

>          if (x < 0 || x >= 10) {
> 
> just because 'x' may in some cases be an unsigned entity is not worth
> even discussing with.
> 
> Educate yourself. The "unsigned smaller than 0" warning is not valid.

Bah, you're right. I wasn't looking at the x >= 10 part, and just fixed
a bug in user space that was caused by an unsigend < 0, and my mind was
on that.

Sorry for the noise here.

-- Steve

