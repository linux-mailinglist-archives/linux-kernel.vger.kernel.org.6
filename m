Return-Path: <linux-kernel+bounces-211735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E85E905631
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5ACB1F2181F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D720917F4FE;
	Wed, 12 Jun 2024 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0LlI8vc1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2575F17A931;
	Wed, 12 Jun 2024 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204575; cv=none; b=fTtlSDKJUUq9l1DkXVt6xfmbB69jkz8xruNrXGqk0QBnCV15Vz4Xq5/VcQbci2iB/vWa6QdbfofTCqd7JAIx3oi4ZVAUV4XasqQ1LGd0mWYN8fXBfvcKjBA3Bs3+Q/KhefwVrciODqz87etGhn3XoJdZuKHO2g0TD/BmnKBTOhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204575; c=relaxed/simple;
	bh=w8xN1LUeu90ka9f2NePQMJcUgzi1zzj8+WSBQDOiGrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnMV/otrb06Nvi0BX+Qes0jVpwUb+R6ghzjJy99Z/cmqVlxLNv4FntV1Ub5jhQkx+VQJwYNArL5w/3h55gkrc1BkRp4n7Fd0RHS3f40ErTI4VuZnpiUm89ri7Mm/lGgornsTx+LbwoLUcNHO/Ot9D84sr8fqARJS5Z6oYD7o8XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0LlI8vc1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9EFC116B1;
	Wed, 12 Jun 2024 15:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718204574;
	bh=w8xN1LUeu90ka9f2NePQMJcUgzi1zzj8+WSBQDOiGrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0LlI8vc1AFsgy8mQQrWrkldkvWKEX4bVBlB8rI3b6igobLYZVZMkaPEa6hjgUMGHN
	 rXjO+LmkhYX0S+Qq6MZgzE7n3GwAIuaJSFzKETHCEmOEGnoPuSFja4ZJMmpKkUeG21
	 WsMqOOQ3jmjCUt0MKp3jH3Pf65L9e4XxpMb6Tji4=
Date: Wed, 12 Jun 2024 17:02:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, rafael@kernel.org, mcgrof@kernel.org,
	russell.h.weight@intel.com, ojeda@kernel.org, alex.gaynor@gmail.com,
	wedsonaf@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust: add abstraction for struct device
Message-ID: <2024061245-kangaroo-clothes-76e1@gregkh>
References: <20240610180318.72152-1-dakr@redhat.com>
 <20240610180318.72152-2-dakr@redhat.com>
 <ZmdID8AlXtoxUfC1@boqun-archlinux>
 <ZmhPW9yq7y6jbmIg@pollux>
 <2024061136-unbridle-confirm-c653@gregkh>
 <Zmh3oN9sWamaYHOD@Boquns-Mac-mini.home>
 <d74edb73-1dba-43f4-a50c-36354c39d758@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d74edb73-1dba-43f4-a50c-36354c39d758@redhat.com>

On Wed, Jun 12, 2024 at 04:51:42PM +0200, Danilo Krummrich wrote:
> On 6/11/24 18:13, Boqun Feng wrote:
> > On Tue, Jun 11, 2024 at 03:29:22PM +0200, Greg KH wrote:
> > > On Tue, Jun 11, 2024 at 03:21:31PM +0200, Danilo Krummrich wrote:
> > > > ...hence, I agree we should indeed add to the #Invariants and #Safety section
> > > > that `->release` must be callable  from any thread.
> > > > 
> > > > However, this is just theory, do we actually have cases where `device::release`
> > 
> > @Danilo, right, it's only theorical, but it's good to call it out since
> > it's the requirement for a safe Rust abstraction.
> 
> Similar to my previous reply, if we want to call this out as safety requirement
> in `Device::from_raw`, we probably want to add it to the documentation of the C
> `struct device`, such that we can argue that this is an invariant of C's
> `struct device`.
> 
> Otherwise we'd have to write something like:
> 
> "It must also be ensured that the `->release` function of a `struct device` can
> be called from any non-atomic context. While not being officially documented this
> is guaranteed by the invariant of `struct device`."

In the 20+ years of the driver model being part of the kernel, I don't
think this has come up yet, so maybe you can call the release function
in irq context.  I don't know, I was just guessing :)

So let's not go adding constraints that we just do not have please.
Same goes for the C code, so the rust code is no different here.

thanks,

greg k-h

