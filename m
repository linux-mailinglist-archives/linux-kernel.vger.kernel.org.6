Return-Path: <linux-kernel+bounces-245607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E15492B4DE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B7AA1F23888
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E991156885;
	Tue,  9 Jul 2024 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PkMI40gs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E7B155CAF;
	Tue,  9 Jul 2024 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720519947; cv=none; b=CkUFDjrVHHhqYm+SqfNBgI1mOb1LaZT8dk06zS8W67XE8rhBBC/rle/4zJCAvQvU5r1G78Lkb0OmaTGK5+FFrP524589Je91z/qmhPh334S3xO1DRWYol4GPNHW8ye4LuP/R4AFEQyptcrtn6vnWY9WfjhXVUeptg3qmPmz0/Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720519947; c=relaxed/simple;
	bh=QTVr9Ak9h9/KHymtrOw183jiVNTBqvgeZKw77gWCJ5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkX/OsR5tHgFmBzSCOGAYNnXWvnRe72TmfWAC1+bC+DpQp+zde933SzzbcbmiO+wd9LPlLy6q1W7NojicqUkLfyIPa3cb9DKiEK7ZWJEEIScN+/AFqAdtheKKhjF5XJyUzOR4PmPUzmQZkZETTsDJmDtkWdU9bN/23edS6ObbVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PkMI40gs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DD6C3277B;
	Tue,  9 Jul 2024 10:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720519947;
	bh=QTVr9Ak9h9/KHymtrOw183jiVNTBqvgeZKw77gWCJ5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PkMI40gsW6zHp2h+9tjVIOA0xbImY2jxyQ1RBtLfCelGp+X9ZtFmedSIOw6H3x9oj
	 pIq4IMM5CGCULrV3JzmphPvyQ16LCYj4U2Tnbq8atH01in8LJunBfqo6icCtlU8JEc
	 kh5uu1nw5N8Bqfpga21BWV30AIN1+IUCKmvAqh9c=
Date: Tue, 9 Jul 2024 12:12:24 +0200
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
Message-ID: <2024070944-follow-crazy-ff95@gregkh>
References: <20240709084458.158659-1-jfalempe@redhat.com>
 <20240709084458.158659-5-jfalempe@redhat.com>
 <2024070951-tall-effective-c916@gregkh>
 <2024070947-exorcism-purchase-2f28@gregkh>
 <acd5c505-f058-46e7-9d92-620dea41d707@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acd5c505-f058-46e7-9d92-620dea41d707@redhat.com>

On Tue, Jul 09, 2024 at 12:04:02PM +0200, Jocelyn Falempe wrote:
> 
> 
> On 09/07/2024 11:12, Greg KH wrote:
> > On Tue, Jul 09, 2024 at 11:11:35AM +0200, Greg KH wrote:
> > > On Tue, Jul 09, 2024 at 10:40:10AM +0200, Jocelyn Falempe wrote:
> > > > +config DRM_PANIC_SCREEN_QR_CODE_URL
> > > > +	string "Base url of the QR code in the panic screen"
> > > > +	depends on DRM_PANIC_SCREEN_QR_CODE
> > > > +	help
> > > > +	  This option sets the base url to report the kernel panic. If it's set
> > > > +	  the qr code will contain the url and the kmsg compressed with zlib as
> > > > +	  url parameter. If it's empty, the qr code will contain the kmsg as
> > > > +	  uncompressed text only.
> > > 
> > > meta-comment, should we by default do this on a kernel.org domain so
> > > that no specific distro has to worry about hosing this type of web
> > > service?
> > 
> > Also, do you have the backend source for this to show how anyone can
> > host it themselves as well?  We can't add features to the kernel that no
> > one but closed-source implementations will use for obvious reasons.
> 
> I've made a proof of concept backend here:
> https://github.com/kdj0c/panic_report/
> 
> And the javascript to decode the kmsg trace is here (under MIT licence):
> https://github.com/kdj0c/panic_report/blob/main/docs/panic_report.js

SPDX lines are your friend, you might want to look into that for this
stuff :)

> It uses the pako js library to uncompress the zlib data, which is also under
> MIT/Zlib licence https://github.com/nodeca/pako/

Great, can you put that in the Kconfig help area for this option in your
next version?

> If kernel.org want to host a default service for that, that would be great.
> It can be linked with https://bugzilla.kernel.org to easily create a bug, or
> look for similar bugs.

Someone should at least propose it if this is going to be an option that
the kernel supports.

thanks,

greg k-h

