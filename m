Return-Path: <linux-kernel+bounces-218646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB6690C320
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 07:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85312283DA2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 05:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1941BF50;
	Tue, 18 Jun 2024 05:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c1bnkoHJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CBB10A16;
	Tue, 18 Jun 2024 05:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718688769; cv=none; b=KfGrpCUXMXOOhxSo70ln9YCxpcbLV8iUUibXiOSGFVgOZ10aTZHLenPjaZ1bXQhxWq2djgHFYg7QZcNg7GPaOe/x+TTlAwACTBKscm1CUoWFt9DkHAh7/u3JA7qPNsOvTJ9zUwSBdnBu0hLtl8bFs0sg0qEQzryz8fofWPBvYtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718688769; c=relaxed/simple;
	bh=4ehkunQ9SeJWraLshi+BAELwwVti6ueaMFyirxlk3K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jE+vNyQJZB2iLyOnAPr0ec9jMHCmk2l5mg+XwWdIx/oWv5pTnuQz+/OEbBK+slagBTKKBIy9A/FMuBD2GSz+CqmnltAU6wpE9eQk+x6kx3xU5E9n4bpGZGtHXzTdF6HnDoPMqa6eL+lgRRoy7rbzHL5MGbmjv+0A5fwjHMna/AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c1bnkoHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D495EC3277B;
	Tue, 18 Jun 2024 05:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718688768;
	bh=4ehkunQ9SeJWraLshi+BAELwwVti6ueaMFyirxlk3K0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c1bnkoHJmAVElBjSOVbDTPYsiXF+dmq7kWz2/+pwlMfoK3c1f4r5xPR7vnjn35bdv
	 R8GzyRtC4BMrip287VV0bT1FUroQKPOShIRoA29AmZQOvxEbMy/3/5NlHFsw9yvx33
	 3etRFIbvNI/1nS9HA4dP0LL0Opml9RBIy4OOK5dI=
Date: Tue, 18 Jun 2024 07:32:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: rafael@kernel.org, mcgrof@kernel.org, russ.weight@linux.dev,
	ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] rust: add abstraction for struct device
Message-ID: <2024061819-deprecate-bladder-8639@gregkh>
References: <20240617203010.101452-1-dakr@redhat.com>
 <20240617203010.101452-2-dakr@redhat.com>
 <2024061823-judo-overhang-eeb1@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024061823-judo-overhang-eeb1@gregkh>

On Tue, Jun 18, 2024 at 07:31:47AM +0200, Greg KH wrote:
> On Mon, Jun 17, 2024 at 10:29:40PM +0200, Danilo Krummrich wrote:
> > Add an (always) reference-counted abstraction for a generic C `struct
> > device`. This abstraction encapsulates existing `struct device` instances
> > and manages its reference count.
> > 
> > Subsystems may use this abstraction as a base to abstract subsystem
> > specific device instances based on a generic `struct device`, such as
> > `struct pci_dev`.
> > 
> > Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> > ---
> >  rust/helpers.c        |   1 +
> >  rust/kernel/device.rs | 102 ++++++++++++++++++++++++++++++++++++++++++
> >  rust/kernel/lib.rs    |   1 +
> >  3 files changed, 104 insertions(+)
> >  create mode 100644 rust/kernel/device.rs
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 

Wait, I should just take this in my driver-core tree, right?  Any
objections for me taking both of these there now for 6.11-rc1 inclusion?

thanks,

greg k-h

