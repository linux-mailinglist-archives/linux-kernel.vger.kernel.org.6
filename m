Return-Path: <linux-kernel+bounces-534783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13123A46B1B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C791F188B321
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9C224292C;
	Wed, 26 Feb 2025 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MUPXdYRI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C8F23716E;
	Wed, 26 Feb 2025 19:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598352; cv=none; b=rQStF66gnZhvEcR8sM0SjTZvNWNzKyARM/KTzJg9KEl0omA6gjmo7UrDb9zQmYFwHc4mqivGoHW1GKdGBVg59E0OcwL7pMEbref5Qjk6bytKpRlKXMuJQgMpQ/SJDpRMuUlYhiAapxn8sKDII32VsGFx5kR7yZi83YfXOm3GD1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598352; c=relaxed/simple;
	bh=n34QbtmMdjpzkgNnPzOLGUCqAdv9+gXWSqDi7wMP8JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bpyk2lp6+eacdJe2zUXB8/+WQbwbsschM5aNlYgKMcX4fG31J69Dp2ZsEbXj81TLppPn3jPftCDjnbxMPlNRCUFwyBv8f086O1AOKtOzyFEeg2kbX03x39LRDdqoSTK9XoDdtbzxk9wOeKyl2ewA/vLzsjMM0eJhzE6CDlaJ71g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MUPXdYRI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01732C4CED6;
	Wed, 26 Feb 2025 19:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740598352;
	bh=n34QbtmMdjpzkgNnPzOLGUCqAdv9+gXWSqDi7wMP8JY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MUPXdYRIMYCgud+9BPFBGDu6ScQgBqRiQMtVOvZjpC2ksYD/sjJZGWclC1VyQF89f
	 NWLC6w9tcmk8ahh9imh5i7GsYfhueO8HlAJrEUlioS1INJwwqGn7flzNmDSUAJA76R
	 2N/EEzzLDC5BkEd+cM+N/DxZxz7VS87j88jVZ5Wo=
Date: Wed, 26 Feb 2025 11:31:23 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] rust/faux: Add missing parent argument to
 Registration::new()
Message-ID: <2025022628-cyclist-clubbing-9762@gregkh>
References: <20250225213112.872264-1-lyude@redhat.com>
 <20250225213112.872264-3-lyude@redhat.com>
 <2025022601-starlit-roamer-1687@gregkh>
 <7c7f9b38e321353507a75520c35efd9b20d69acf.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c7f9b38e321353507a75520c35efd9b20d69acf.camel@redhat.com>

On Wed, Feb 26, 2025 at 11:51:26AM -0500, Lyude Paul wrote:
> On Wed, 2025-02-26 at 11:01 +0100, Greg Kroah-Hartman wrote:
> > 
> > 
> > I guess you can add parent can be NULL to the SAFETY line?
> > 
> > Sorry, I thought I would just leave it this way without a parent pointer
> > until you actually had a user that needed it.  And then we could add the
> > new parameter and fix up all callers.  No need to add support for it yet
> > without that, changing apis is easy!  :)
> > 
> > Do you have a real user for this any time soon?
> > 
> 
> Not particularly! My thought process was mostly just this seems like a simple
> enough addition that it would probably be easy to add it now when we don't
> have any users upstream yet rather than building up faux device users in rust
> and potentially having to refactor later to add such an argument.
> 
> I don't think the refactoring would be that much work either, but it seemed
> harmless to just get it over with now.

Ok, fair enough, want me to take this one and you'll figure out if/when
the SAFETY comment needs to be changed for the parent pointer as an
add-on patch?

Or do you want to send a new version?  Your choice.

thanks,

greg k-h

