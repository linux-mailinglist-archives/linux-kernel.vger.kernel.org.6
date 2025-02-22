Return-Path: <linux-kernel+bounces-527135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99794A407D0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECD2B7A20A3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78F7209F5E;
	Sat, 22 Feb 2025 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mWzZVi6F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCCD206F16;
	Sat, 22 Feb 2025 11:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740222443; cv=none; b=sVMe4GrvQsRpenI1ZTZXgIhssgel11PDK3+4NJgCVmLlsiiGs+f50zFbfBvqFP2g3E0nljDLjPBwNHmm7s8+T/4iYRW/AhzXoRuaN6aeiPtMPuVcfnFD8UU4j+FRty3uSNg8UP//tTVLm1VQSVXwceIXC00fvm4XHk8kYmQlhA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740222443; c=relaxed/simple;
	bh=dDrYYapdceqAhTHU8P5P38hl7k4fIgWxKDFEdkvwgLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cgz70SVlzhz8VjeuWQVsT1Xcq40p0+UiAMGJ18UDobc91VXuaCNsOqEDVshgHfpB3nj9Pef+J3yvBYW+K92x+rLXAnCfo+QBSylK5YulJUJWCdjWXikBY5nR8iqiAdYwQ+2N02jlh7pk0x4OWkghnBNb3lKthww1ncTNDm2MVjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mWzZVi6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D596C4CED1;
	Sat, 22 Feb 2025 11:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740222442;
	bh=dDrYYapdceqAhTHU8P5P38hl7k4fIgWxKDFEdkvwgLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mWzZVi6FoyU/sNWV0+xHzN9oiKD0omT3CulYjCCaUEp2rkwHz3ogTUI8zEiPotplM
	 0jH+ywI2iwIo5CkpuyVJzBz5vSzKFbOCOfWvX+CNk5KDZ6oDgucKgu9Uv+2fgonkqJ
	 e1Wiv0W1hsibAFNS8w0HcL1lEyhodiRyJb0DwWtE=
Date: Sat, 22 Feb 2025 12:07:14 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Martin Uecker <uecker@tugraz.at>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Boqun Feng <boqun.feng@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <2025022230-urgency-imminent-6032@gregkh>
References: <1d43700546b82cf035e24d192e1f301c930432a3.camel@tugraz.at>
 <2025022042-jot-favored-e755@gregkh>
 <b9a5de64fe1ded2ad3111763f35af9901bd81cc4.camel@tugraz.at>
 <caea3e79-78e6-4d98-9f3b-f8e7f6f00196@stanley.mountain>
 <61a7e7db786d9549cbe201b153647689cbe12d75.camel@tugraz.at>
 <20250221124304.5dec31b2@gandalf.local.home>
 <CAHk-=wgg2A_iHNwf_JDjYJF=XHnKVGOjGp50FzVWniA2Z010bw@mail.gmail.com>
 <6b3e4d3bdc9b6efd69068e5b22cfd05d370aed19.camel@tugraz.at>
 <1cf1d64b-128d-4dbe-8427-98405652944b@stanley.mountain>
 <5eb6554f5f600f09d5072bc524757912a36c5057.camel@tugraz.at>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eb6554f5f600f09d5072bc524757912a36c5057.camel@tugraz.at>

On Sat, Feb 22, 2025 at 11:25:26AM +0100, Martin Uecker wrote:
> Thanks, this is useful.  I was asking because it would be relatively
> easy to tweak the warnings in GCC too. GCC has similar heuristics for
> other warnings to turn them off in macros and one can certainly also
> make it smarter.  (Again, the two problems here seem lack of communication
> and lack of resources.  One needs to understand what needs to be done
> and someone has to do it. But even a limited amount of time/money could
> make a difference.)

For the time/money issue, there are a number of different groups
offering funding up for open source work like this.  If you are in the
EU there are a bunch of different ones, and also openSSF from the Linux
Foundations funds work like this.  So those might all be worth looking
into writing up a proposal if you want to do this.

hope this helps,

greg k-h

