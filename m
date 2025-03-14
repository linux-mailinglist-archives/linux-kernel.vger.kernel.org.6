Return-Path: <linux-kernel+bounces-561355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA207A61067
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17B2883DEE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821D01FDE24;
	Fri, 14 Mar 2025 11:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcB1Hmou"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7D5166F32;
	Fri, 14 Mar 2025 11:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952942; cv=none; b=bfsDEleO/430Apnv1iSa1saUwxyxLjth+TOZKFYnAo/fzoRIZCHxTSJZLCyxSAP1McYlHEqWK5TNO+GtwD88+CFrXRJ3qL83rnER/i7YpgJsGyvyoTU6PchN22Nl+MoR1gYotZmLPYHhQN3SxOi5TKuoEjEu+IxI+SK5NycVMH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952942; c=relaxed/simple;
	bh=27DMW218nRvLGFSPbZfKfMJ8zzDAqnq1Puiz351Oajg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHBBfQgu/QRP9luF4WM/OVHjbHiKAuGlXObqBcf/ztL9G0CRxJDvPhxtRUdbAdz7WtpVKgb8yGrldCor3PhuIrxbH2i/ddcFa/Tk6uLBlubVV02FKLdqFfnC/7rjNribYo9F9KAPnwKS86AA7k9VbrDOT9Ms1yUAE5bxz9vVXaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcB1Hmou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFE5C4CEE3;
	Fri, 14 Mar 2025 11:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741952941;
	bh=27DMW218nRvLGFSPbZfKfMJ8zzDAqnq1Puiz351Oajg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XcB1Hmou+cQo9dLJVtB1ZK7pGmxWPgTypguLf2Xcgbrb+JMut9XP7vhS8MnJqj4EG
	 qI3Fn06wstBOf2Z8lVRh8aivqSYwwmCfGrHtbcY1w77SLdnoRbGi1scWIjb6rKbX+w
	 /aMYe2E9k+piMlf/uPmGSwanOhPiWONkM1EwYXshi7/PXpm+SNxvLXw8Nm9YO+lg11
	 rEr060mdECviQuo+n8e5PyT2xakVFFm+sLuUD82CmzQLSF1AH0ld/e0RAWRudD6RSU
	 uwTud9TBWkKkOs3bEhpOfzLtFPzlPCPkm0gff4PrD5AEtT221+rMfF6CJ0mhkheE69
	 f5AZFzJfpgeUg==
Date: Fri, 14 Mar 2025 12:48:58 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, mcanal@igalia.com, Alice Ryhl <aliceryhl@google.com>, 
	Simona Vetter <sima@ffwll.ch>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Asahi Lina <lina@asahilina.net>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v3 07/33] rust: drm/kms: Add drm_encoder bindings
Message-ID: <20250314-manipulative-important-mackerel-7a25ba@houat>
References: <20250305230406.567126-1-lyude@redhat.com>
 <20250305230406.567126-8-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="g47mv63cjnchwwjn"
Content-Disposition: inline
In-Reply-To: <20250305230406.567126-8-lyude@redhat.com>


--g47mv63cjnchwwjn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [RFC v3 07/33] rust: drm/kms: Add drm_encoder bindings
MIME-Version: 1.0

On Wed, Mar 05, 2025 at 05:59:23PM -0500, Lyude Paul wrote:
> +unsafe extern "C" fn encoder_destroy_callback<T: DriverEncoder>(
> +    encoder: *mut bindings::drm_encoder,
> +) {
> +    // SAFETY: DRM guarantees that `encoder` points to a valid initialized `drm_encoder`.
> +    unsafe { bindings::drm_encoder_cleanup(encoder) };
> +
> +    // SAFETY:
> +    // - DRM guarantees we are now the only one with access to this [`drm_encoder`].
> +    // - This cast is safe via `DriverEncoder`s type invariants.
> +    unsafe { drop(KBox::from_raw(encoder as *mut Encoder<T>)) };
> +}

I'm not sure we should expose drm_encoder_cleanup() there, if only
because it's not really up to the driver to deal with it anymore. We're
switching to drmm_encoder_alloc/init where having a destroy hook is
explicitly rejected.

Maxime

--g47mv63cjnchwwjn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ9QXqgAKCRAnX84Zoj2+
dng1AX4lM8eAeLLHIHCVb6WGxGggfuubtHjG1Siqk2oobFl9xxhMe7o26QyYTZ3t
DYVA0T8BgMZLG+TwwxyzowXFT4tJ7HPLFf8bJqQLI6A3oA4eXg5fXlGjNDPiSmIx
IyVzVKUM7g==
=T9DB
-----END PGP SIGNATURE-----

--g47mv63cjnchwwjn--

