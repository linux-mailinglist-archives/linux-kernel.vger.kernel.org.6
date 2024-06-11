Return-Path: <linux-kernel+bounces-209955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFDE903D58
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BFE51C208F8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EFB17CA02;
	Tue, 11 Jun 2024 13:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Eshwi2Kz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B0217CA06;
	Tue, 11 Jun 2024 13:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112565; cv=none; b=tH3Civ+jD0c3lTxzhbJuCK5B20IFeAzjgGGpo0xT47G74N59pfjMz/nW/h2YEaIiZuajvznqsHDM1rIpTWVeVxnCTBV0wXZUjS0I+pH7lba6cWIqEdWBw9M8oAyMiIQTaF0kah+9fGI4BrOGfAq/om0tM5OO2vx6hHIPi71b8V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112565; c=relaxed/simple;
	bh=InuOlaVNE1oo9SB9Gz9Wqxu487yf8TriEQHN/x2DggE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q21mJ7aUqSiNjApAXLB0YQXv+Qkue/Tpvhq9terGaEW65dewaVU8C3MZs7NGEl8gSPw/n+0ZGV/BYJesNmSEFJixPN0q9qw9zqQRZXi0T0wGD7ZLQl07X+9C+LmS9geRurGE7FE/ihBSjEr9SQcl+GYvnNKW40uQj4hndSlc/C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Eshwi2Kz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87102C2BD10;
	Tue, 11 Jun 2024 13:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718112565;
	bh=InuOlaVNE1oo9SB9Gz9Wqxu487yf8TriEQHN/x2DggE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eshwi2KzINlHj58yYBOiu64/bM/6BwportMUM+oe9Ft63a3NoJlqO5wvMKaPjkS0s
	 4tv27t7IhFIdtAwsfzVEE1gkckwnKhlXnsLyzaOqht6TkViomuwUAgDVJp/+E7IR0i
	 1yGB503D3ITqm290pHeRAB79pcKhkf8Er0FBnzQk=
Date: Tue, 11 Jun 2024 15:29:22 +0200
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
Message-ID: <2024061136-unbridle-confirm-c653@gregkh>
References: <20240610180318.72152-1-dakr@redhat.com>
 <20240610180318.72152-2-dakr@redhat.com>
 <ZmdID8AlXtoxUfC1@boqun-archlinux>
 <ZmhPW9yq7y6jbmIg@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmhPW9yq7y6jbmIg@pollux>

On Tue, Jun 11, 2024 at 03:21:31PM +0200, Danilo Krummrich wrote:
> ...hence, I agree we should indeed add to the #Invariants and #Safety section
> that `->release` must be callable  from any thread.
> 
> However, this is just theory, do we actually have cases where `device::release`
> is not allowed to be called from any thread? If so, this would be very confusing
> for a reference counted type from a design point of view...

What do you mean exactly "by any thread"?  Maybe not from interrupt
context, but any other normal thread (i.e. that you can sleep in), it
should be fine to call release() in.

thanks,

greg k-h

