Return-Path: <linux-kernel+bounces-245496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D49792B351
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBFC9281DA8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5941C15383C;
	Tue,  9 Jul 2024 09:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ms/nfM4W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905BC146016;
	Tue,  9 Jul 2024 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720516298; cv=none; b=YDua6iAylZ+2qFtwuE6b8BHruvrRNuSVT/+gYHY3NY9BaQH+JxpOo1TlLPMPpWvgZjaIq5HktOptewvWjwTVO07EW+stuDFOta6MgE1q0PoaTSMzZztzeYknA6N4jTlfxln9erqSPeEgZm5umWQwCZfxb+c0+m1WxnN9rDGASkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720516298; c=relaxed/simple;
	bh=bF04r8LuquU/qir0aCll9+NDJrFTCzvu0tF1oglQD78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgXYYx8bcHgqrrhYxIPyHwZw2Xc0/GZtzEhJTW615oZ/4zaIyMfS38Akt41XXYHr7KFqfJf0IU39fFdbn5kHH9jhoCBkQ9NPgv/kHzlmdlkIchVJtcEql2a0tPJPIT+7ynhc97cNsAxv6BeyGrpTnNgW+B4M5HE+pbiRyzPUomM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ms/nfM4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1BEC3277B;
	Tue,  9 Jul 2024 09:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720516298;
	bh=bF04r8LuquU/qir0aCll9+NDJrFTCzvu0tF1oglQD78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ms/nfM4Wxk8p5OGqAW6f8WdhgRTO9uLKNrF812GfyLcaO2s4aAXI2r1tC2P6vRjj/
	 xdrWu3TDW4yyvZsCvtkJdY+hilXEPP5fPcy4ea6oVeQOCRpXTs2xnFCZsk1YEq7X17
	 6Cc0ici7NOLuyh/tqjqK0+xDXxWdYzGtzz7cKkKs=
Date: Tue, 9 Jul 2024 11:11:34 +0200
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
Message-ID: <2024070951-tall-effective-c916@gregkh>
References: <20240709084458.158659-1-jfalempe@redhat.com>
 <20240709084458.158659-5-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709084458.158659-5-jfalempe@redhat.com>

On Tue, Jul 09, 2024 at 10:40:10AM +0200, Jocelyn Falempe wrote:
> +config DRM_PANIC_SCREEN_QR_CODE_URL
> +	string "Base url of the QR code in the panic screen"
> +	depends on DRM_PANIC_SCREEN_QR_CODE
> +	help
> +	  This option sets the base url to report the kernel panic. If it's set
> +	  the qr code will contain the url and the kmsg compressed with zlib as
> +	  url parameter. If it's empty, the qr code will contain the kmsg as
> +	  uncompressed text only.

meta-comment, should we by default do this on a kernel.org domain so
that no specific distro has to worry about hosing this type of web
service?

thanks,

greg k-h

