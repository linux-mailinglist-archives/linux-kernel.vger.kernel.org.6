Return-Path: <linux-kernel+bounces-526421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E887A3FE80
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE1070207F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B01F2500B1;
	Fri, 21 Feb 2025 18:12:31 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA331E5702
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 18:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740161551; cv=none; b=tPCZixiCNDxKJKUIQHxOLCX4atvxRMqfmMa0JYeHBoWvm2WAJISrgrOLmpOggWEp+Q4E1yeMXU/ey8Vj0yTRg+I2eevAVxb+6MJDDxahO7JQr96qsBdy2MnerAb3O0ccGnfOsI+PCkeGGwz9bp4s7vGk6BPhsXlYZIsFFp/+n4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740161551; c=relaxed/simple;
	bh=0p4RnLZFtp7RW0y5ZCYBPT4h4khr6k1Mz6Oc9D3uz7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVcvJcffy8xmzn5OGdueIg7zS0kCzrtfu0VHG4r0T32/sXuhkjNLUNKJ1P/jDVUDeTCHRHtJtp/y+LjquJqw0U5uiLV2CYaQkbLhogmhJnLoP7NrPyYCj/23yIwwm3Upg9XdVfvpcyuG/lJF7gZAfQVFdk0nWphXothzshaJJD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-114-12.bstnma.fios.verizon.net [173.48.114.12])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 51LIBsUl003707
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 13:11:55 -0500
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 8A2542E011A; Fri, 21 Feb 2025 13:11:54 -0500 (EST)
Date: Fri, 21 Feb 2025 13:11:54 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Martin Uecker <uecker@tugraz.at>, Greg KH <gregkh@linuxfoundation.org>,
        Boqun Feng <boqun.feng@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
        ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <20250221181154.GB2128534@mit.edu>
References: <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
 <Z7VKW3eul-kGaIT2@Mac.home>
 <2025021954-flaccid-pucker-f7d9@gregkh>
 <4e316b01634642cf4fbb087ec8809d93c4b7822c.camel@tugraz.at>
 <2025022024-blooper-rippling-2667@gregkh>
 <1d43700546b82cf035e24d192e1f301c930432a3.camel@tugraz.at>
 <2025022042-jot-favored-e755@gregkh>
 <b9a5de64fe1ded2ad3111763f35af9901bd81cc4.camel@tugraz.at>
 <caea3e79-78e6-4d98-9f3b-f8e7f6f00196@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caea3e79-78e6-4d98-9f3b-f8e7f6f00196@stanley.mountain>

On Fri, Feb 21, 2025 at 12:48:11PM +0300, Dan Carpenter wrote:
> On Thu, Feb 20, 2025 at 04:40:02PM +0100, Martin Uecker wrote:
> > I mean "memory safe" in the sense that you can not have an OOB access
> > or use-after-free or any other UB.  The idea would be to mark certain
> > code regions as safe, e.g.
> > 
> > #pragma MEMORY_SAFETY STATIC
> 
> Could we tie this type of thing to a scope instead?  Maybe there
> would be a compiler parameter to default on/off and then functions
> and scopes could be on/off if we need more fine control.
> 
> This kind of #pragma is basically banned in the kernel.  It's used
> in drivers/gpu/drm but it disables the Sparse static checker.

I'm not sure what you mean by "This kind of #pragma"?  There are quite
a lot of pragma's in the kernel sources today; surely it's only a
specific #pragma directive that disables sparse?

Not a global, general rule: if sparse sees a #pragma, it exits, stage left?

					- Ted

