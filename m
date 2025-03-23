Return-Path: <linux-kernel+bounces-573054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 370FAA6D242
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 23:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C4916F95A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF911C8611;
	Sun, 23 Mar 2025 22:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="pPcWRwJ6"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB541C5490
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 22:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742770121; cv=none; b=aqvbVeqa6NuXMdXGH3DrhA0E3xQCi7RXYLdpBHGWIiK7JrDQz0ZWEzXDBYjU3qKSFjiENzt+4uswUSuuzYenyhH7ncxzoSQqjzsiN8t3/558j4of6dPhnYBAoEhCy4Bp5c8qfrhz2AL5e8Q5xciZ/DkJYg3JNxgGRdP5cB5vAmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742770121; c=relaxed/simple;
	bh=dnFhYYnzKlVDFTJsHnhxZlxKUHTxCBnQ8RG2gM1BrKA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6C7R0flyzffA85363AO9BPCfAPMOTGmy1PRXY2/J9+gF3yFLZlhA4FIZUOGBxTQSflaIwzQ7AFdRIrAw4lCvnNKpwJSFV9SnpKCVI1McWe4t73VBfiW51a5JvCdD3kV8IeEqoPzqnamtsi3TyxiwN4RuaeVrrsIUzMC0vVYL7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=pPcWRwJ6; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Sun, 23 Mar 2025 18:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1742770117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IPUcsPWWa2X9NKfpybVnP9b2BUGvSK430jlCkPrgcYg=;
	b=pPcWRwJ6ULwbzFVnYhIkw85Ou/fbeyBqqixE9bPjue5gt4XnjsIwZtqv/W8AOOimwa//lw
	MGeQNOeLPbmVR4Uyo46BmpfX7ZGdrSley00lutcJsJ0Wpcr2x4oaYsBYKei0QTrvg7djta
	RF22Z3ZIY7jDI5SSCYfwpPEY/zAcQ5Z3M143egmgItXDXvPjsyLJfWiTEckWlVTJLeGhsL
	8zRsfeddKqwItobtsycZyajOv3GLCEWP4k2k+4qrEEjucPkaAWbnM391NLpwvYC907xwjq
	AZ7HfTVC+7PB4IFJv044IpsrUy4Lz2wsJejWoLjKXioqgx1zyBbtCFEYQnthnw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Faith Ekstrand <faith.ekstrand@collabora.com>,
	Janne Grunau <j@jannau.net>, Sven Peter <sven@svenpeter.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Sergio Lopez Pascual <slp@sinrega.org>,
	Ryan Houdek <sonicadvance1@gmail.com>, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH v3] drm: Add UAPI for the Asahi driver
Message-ID: <Z-CPspG_Cy-f-MKe@blossom>
References: <20250314-agx-uapi-v3-1-3abf7e74ea2f@rosenzweig.io>
 <Z912pMazVwHKLi72@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z912pMazVwHKLi72@phenom.ffwll.local>
X-Migadu-Flow: FLOW_OUT

> Since this is a deparature from our usual requirement that all pieces
> should be ready before landing anything we had discussion whether this is
> an acceptable one-off exception for special circumstance. Thanks a lot to
> Alyssa for driving this. The very much summarized consensus is that due to
> rust this is a special case, and because the userspace is in upstream mesa
> and lead by people who know what they're doing and have been around for
> years, it should all work out. As a stand-in for that discussion:
> 
> Acked-by: Simona Vetter <simona.vetter@ffwll.ch>
> 
> But Dave&me very much do not want to make this a recurring thing, please
> don't try :-)

Thanks for the ack :)

