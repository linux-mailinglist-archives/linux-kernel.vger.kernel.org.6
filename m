Return-Path: <linux-kernel+bounces-523707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B22E5A3DA32
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9541895A6E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9591F4606;
	Thu, 20 Feb 2025 12:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ynP4yddS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FA117BD9;
	Thu, 20 Feb 2025 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740055070; cv=none; b=O/Fcqi/5gxEqKsPyZ39sCqGMf6Jna01QcPfKVCd9DXvXfhNiBYehd3HXdPyUCrjbFGL23OFpNrf4DOwej5J/Jpi6mzWF9H2GOFCejCLltEU8H7X3H4fblYSo+ij2QVGuChZiaPc0JL2b3mrLdUtrh9ht5HsRmsTpkS5zaUputA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740055070; c=relaxed/simple;
	bh=giOkKYSWvXP5XpSwiqiqP2R17fK2x7YAHCFDt+x1ZxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fokAVsf4xq946CmJV2Lz1gJHg8FPY1FTSjk6SVhXpSN8m/GQkxWKJXKKNCs6Goo0qFiOtJiz/bqruts+HldrJnBdzlEY3IXJhTlLvROd6BOnmKapkAJkMQZ6yXvbb6pvFX9auFekmKDQrqgmFL1oTzFeTuj7WZvfrOc6T6DPFkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ynP4yddS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BACC4CED1;
	Thu, 20 Feb 2025 12:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740055069;
	bh=giOkKYSWvXP5XpSwiqiqP2R17fK2x7YAHCFDt+x1ZxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ynP4yddSXKFK/K9mc/U5Yn7NVo480h1xiEIN1UuRYkR0Kr+JnS+6BLV/ekCTWjvD2
	 +ki998if/ulYG3k4rXsEWgOJnO5JPyES8gEgRjDkPjG9l8eXFfWphbIMc6r7WKdN/o
	 fzn+ebNHRKZ5UWGHiN+u9G0zS1ku74l17oGJteYs=
Date: Thu, 20 Feb 2025 13:37:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jan Engelhardt <ej@inai.de>
Cc: Boqun Feng <boqun.feng@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <2025022052-ferment-vice-a30b@gregkh>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
 <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
 <Z7VKW3eul-kGaIT2@Mac.home>
 <2025021954-flaccid-pucker-f7d9@gregkh>
 <2nn05osp-9538-11n6-5650-p87s31pnnqn0@vanv.qr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2nn05osp-9538-11n6-5650-p87s31pnnqn0@vanv.qr>

On Thu, Feb 20, 2025 at 01:28:58PM +0100, Jan Engelhardt wrote:
> 
> On Wednesday 2025-02-19 06:39, Greg KH wrote:
> >
> >The majority of bugs (quantity, not quality/severity) we have are due to
> >the stupid little corner cases in C that are totally gone in Rust.
> 
> If and when Rust receives its own corner cases in the future,
> I will happily point back to this statement.

I'm not saying that rust has no such issues, I'm saying that a huge
majority of the stupid things we do in C just don't happen in the same
code implemented in rust (i.e. memory leaks, error path cleanups, return
value checking, etc.)

So sure, let's make different types of errors in the future, not
continue to make the same ones we should have learned from already
please :)

thanks,

greg k-h

