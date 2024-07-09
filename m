Return-Path: <linux-kernel+bounces-245499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EFE92B357
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E3C01C226DD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF6315443C;
	Tue,  9 Jul 2024 09:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zO3HIz6D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479AE42058;
	Tue,  9 Jul 2024 09:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720516347; cv=none; b=JBdE2py5rEYy0xndyV30OAHD+sWr8MRbJYI45Rh3GkpvMpgMp9gQqmo4DbI48GLpjWkmj27JOhSBRj9hnvBT98asYUtWjEAXzdeTHwSzi+4eJZ+E2UacJDZBENBxx9/t0aIB1XZUF5VAoW1uadoojIxbtg1/KtDHC8tBq2lurfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720516347; c=relaxed/simple;
	bh=b/0wVpcZTr4G/VUEJ8mNFiEeZSUCxOw/iFz5OcDVYKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gqhe+F7+IvuH9BC5rCBM7yKoxGfTJPGNcWIfMK87Op/h27bZms3p/CVE35wfT2RShBuHd3wQQ3WNNYCG1IwTTilN3YSJhVItZm0tM/bwGLfDqjh7s9TlFrmwightOuvLeeC3+PXVZC9f2ddnpCsZDZLvWs5Cddpjs6grTeQSazg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zO3HIz6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47920C3277B;
	Tue,  9 Jul 2024 09:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720516346;
	bh=b/0wVpcZTr4G/VUEJ8mNFiEeZSUCxOw/iFz5OcDVYKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zO3HIz6D3go5oKHNJHNNgsd7NduYEFclnADP6yQ27XoOjKG3IGYM40qB570CIR2x4
	 YopSTiPZvfzl10XahTyOPVmXgSIWvmjmIm1MY+3ouUhMaxA2HCLbkoOmAxj2zCcYm5
	 q33KgL5SMJYfvmhvn8APX/bJVe0yUK232fwDXfIs=
Date: Tue, 9 Jul 2024 11:12:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: Re: [PATCH v2 4/4] drm/panic: Add a qr_code panic screen
Message-ID: <2024070947-exorcism-purchase-2f28@gregkh>
References: <20240709084458.158659-1-jfalempe@redhat.com>
 <20240709084458.158659-5-jfalempe@redhat.com>
 <2024070951-tall-effective-c916@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024070951-tall-effective-c916@gregkh>

On Tue, Jul 09, 2024 at 11:11:35AM +0200, Greg KH wrote:
> On Tue, Jul 09, 2024 at 10:40:10AM +0200, Jocelyn Falempe wrote:
> > +config DRM_PANIC_SCREEN_QR_CODE_URL
> > +	string "Base url of the QR code in the panic screen"
> > +	depends on DRM_PANIC_SCREEN_QR_CODE
> > +	help
> > +	  This option sets the base url to report the kernel panic. If it's set
> > +	  the qr code will contain the url and the kmsg compressed with zlib as
> > +	  url parameter. If it's empty, the qr code will contain the kmsg as
> > +	  uncompressed text only.
> 
> meta-comment, should we by default do this on a kernel.org domain so
> that no specific distro has to worry about hosing this type of web
> service?

Also, do you have the backend source for this to show how anyone can
host it themselves as well?  We can't add features to the kernel that no
one but closed-source implementations will use for obvious reasons.

thanks,

greg k-h

