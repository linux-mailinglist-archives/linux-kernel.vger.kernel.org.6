Return-Path: <linux-kernel+bounces-240548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B376D926EB0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 07:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C99141C22091
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 05:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B1F1A01A6;
	Thu,  4 Jul 2024 05:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rb1cZVzT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A2E1B7F4;
	Thu,  4 Jul 2024 05:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720069403; cv=none; b=hfSzcApxG1cIR6Ru8BuKVaoZXLdvX+A0YcULP5jLIwwSePygfIWodIONmNRQaasV3uxBPdaMEpUlAkjJbGwNxEWgdTC9m3gk9GC5GwuvJFk+BdLdQfGBH8ckBvmnLQRDyvWDG5inNtPsLy6IcE2SftQcNyNFfCfqGh0UOcfkgt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720069403; c=relaxed/simple;
	bh=Hjf3JAXpXfAWWms/5UKIQ2jB2126fzQdVq72QWeU1SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAg0YcJyD+8tg+c62pU6hVg243WeA6fnuXbPi1e0I6Bx+pKZlcwQjVxAGc9/qwvejGnb8ZFfjqKPTesN87i5qBD9QcfrIvYffubMsbK1ebIe5Zfw70lCenHG3/xDafPuCOXIIesuzQXNJJUgih+tNOWz40+LBaFFY8BSTINpLZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rb1cZVzT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46706C3277B;
	Thu,  4 Jul 2024 05:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720069402;
	bh=Hjf3JAXpXfAWWms/5UKIQ2jB2126fzQdVq72QWeU1SY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rb1cZVzTlJpr/k6oeKlH6QQHACs6VCGZyFHWJOYUKcADHzJ4VAxtmh0X0c0fmWz0D
	 MR49wp5r4Fj5cxXpvNgXZvAozMuuQ8eMOBoFPJbt0lQRfVIJOTR2BMfPbiyBJnUpYQ
	 6t8t7J0pkE1zBkxx5Es8U2yAYbhdxfjNa7MTFDBs=
Date: Thu, 4 Jul 2024 07:03:19 +0200
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
Subject: Re: [PATCH 0/4] drm/panic: Add a qr_code panic screen
Message-ID: <2024070417-husked-edgy-f527@gregkh>
References: <20240703154309.426867-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703154309.426867-1-jfalempe@redhat.com>

On Wed, Jul 03, 2024 at 05:33:57PM +0200, Jocelyn Falempe wrote:
> This series adds a new panic screen, with the kmsg data embedded in a QR-code.
> 
> The main advantage of QR-code, is that you can copy/paste the debug data to a bug report.
> 
> The QR-code encoder is written in rust, and is very specific to drm_panic.
> The reason is that it is called in a panic handler, and thus can't allocate memory, or use locking.
> The rust code uses a few rust core API, and provides only two C entry points.
> There is no particular reason to do it in rust, I just wanted to learn rust, and see if it can work in the kernel.
> 
> If you want to see what it looks like, I've put a few screenshots here:
> https://github.com/kdj0c/panic_report/issues/1

Cool, this idea has been floating around for decades, here's the last
attempt at this back in 2014:
	https://lore.kernel.org/all/1395093587-2583-1-git-send-email-teobaluta@gmail.com/

> 
> -- 
> 
> Jocelyn
> 
> 
> Jocelyn Falempe (4):
>   drm/panic: Add integer scaling to blit()
>   drm/rect: add drm_rect_overlap()
>   drm/panic: simplify logo handling
>   drm/panic: Add a qr_code panic screen
> 
>  drivers/gpu/drm/Kconfig         |  29 +
>  drivers/gpu/drm/Makefile        |   1 +
>  drivers/gpu/drm/drm_drv.c       |   3 +
>  drivers/gpu/drm/drm_panic.c     | 338 +++++++++--
>  drivers/gpu/drm/drm_panic_qr.rs | 989 ++++++++++++++++++++++++++++++++

Wait, we can put .rs files in any directory now?  I didn't think that
worked properly yet.

thanks,

greg k-h

