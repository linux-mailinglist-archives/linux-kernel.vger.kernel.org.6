Return-Path: <linux-kernel+bounces-526738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34C7A4029B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CF3C421B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EEC253335;
	Fri, 21 Feb 2025 22:23:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEDC2045B7;
	Fri, 21 Feb 2025 22:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740176627; cv=none; b=DwPrg8bG9GclZJ5Pha5a42/nl0doP8zGCWSR1U3AHp8sSjrgZWNP7BlKPxh0MJPteMoYUHTL+ayEilXYEl09bYI0fsTzditnRMX3vca1iBQQPFlhsRaOTm7hYlf5dCJ/j8/hY1iTBhwFGb+8U4Lacy4x2cpsxCjEmqxpZ+HFYxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740176627; c=relaxed/simple;
	bh=L+WRYZAtwOgscC+CovPo7Vs26ly8n19IaxeU6ex2VFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=alskSVZaXjcoNvh5LlkFfeKwDD23XwS15JxDF1PFRk7Pv9k9fH6q7iRsPwEvRpYmcGEZeXQbreV0L42T6aFlI/JaPZ2uSjTUveZ99peNVE/sjpwF4OVvX3YUqWeB7p8oECF46hS0p9PzOOArigP4JMNhUtYQAyw7cKooeMSr2Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE30FC4CED6;
	Fri, 21 Feb 2025 22:23:45 +0000 (UTC)
Date: Fri, 21 Feb 2025 17:24:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Uecker <uecker@tugraz.at>, Dan Carpenter
 <dan.carpenter@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Boqun
 Feng <boqun.feng@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 rust-for-linux <rust-for-linux@vger.kernel.org>, David Airlie
 <airlied@gmail.com>, linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <20250221172415.5b632ae6@gandalf.local.home>
In-Reply-To: <CAHk-=wg=pZvE9cHJUPKGCajRUCtDoW73xwY5UfJApCWms_FgYw@mail.gmail.com>
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
	<6b3e4d3bdc9b6efd69068e5b22cfd05d370aed19.camel@tugraz.at>
	<CAHk-=wg=pZvE9cHJUPKGCajRUCtDoW73xwY5UfJApCWms_FgYw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 11:30:41 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> And yes, it's wrong in general. The problems with "x < 0" warning for
> an unsigned 'x' are deep and fundamental, and macros that take various
> types is only one (perhaps more obvious) example of how brokent that
> garbage is.

The bug I recently fixed, and I still constantly make, where this does
help, is the difference between size_t vs ssize_t. I keep forgetting that
size_t is unsigned, and I'll check a return of a function that returns
negative on error with it.

If I could just get a warning for this stupid mistake:

	size_t ret;

	ret = func();
	if (ret < 0)
		error();


I'd be very happy.

-- Steve

