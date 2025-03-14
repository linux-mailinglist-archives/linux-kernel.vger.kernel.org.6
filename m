Return-Path: <linux-kernel+bounces-561252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C20A60F42
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30D2F880292
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FC81FA85A;
	Fri, 14 Mar 2025 10:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3QCcD2F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8D02E3364;
	Fri, 14 Mar 2025 10:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741949095; cv=none; b=KTxsH8w0ZzcAO0r8e/mBuyfXf5OxeDzqEz9o0N2/ogipfnQbFdB7z3GKNDTXH+ufdV9igqQtb/L6DOJPlILPKUdMrlGYBZzJOkjTCAud8gvdKeH2ki/fQ9FjhVKH4rHHGxbfN7LVgw/YMEFQB4oZF5ajl5yIlpeZt/PjhAAmDPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741949095; c=relaxed/simple;
	bh=3xXe9cL0jqciAGlNVAvM5pFZkd0H2R4t8V4HdIfECpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scIaMXTdlPuvcfC/oENV2gRy2QyPqC0gl+rzJOSc0P72y+0dDwqEP5N8uoR/wEDG09Vxq9BFYJpWFnmUjqtaBOB3oaFroUs9FALYrhJQsulSwg6S7tSgV6Rm+vhMSC6n9xaOFVhrN3RU00DrUI75vnR1kjKUJffPc4zNnt+QVIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3QCcD2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE63C4CEE3;
	Fri, 14 Mar 2025 10:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741949094;
	bh=3xXe9cL0jqciAGlNVAvM5pFZkd0H2R4t8V4HdIfECpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m3QCcD2FP143X+Wwipr0T0R9vkNiZ57VQOk3kn8gLTRBj3xBE8yqnncAxAeRpjUAR
	 2jRJV5rXv6OihKzrWBWrWU505xGkQy+lnCmhXtfnRv0KvkeCSrxFBCtKjIN0Ki9lfo
	 stePMsqsZaKKJyQBZq5wEUtcVkK2hFYPTjadO8Plgdcgy3pRcrsUi+LgOVxUdNjIqf
	 SKrWZKPonjA6Po69VAP2NgkiulqrMwtFtpTB/PjFBLaSnBFrCObjKqmbbDpNJ0Oe6f
	 XdapsEuMwnOHXMnZrG4sY3dPuKhUwKa0W5QmgjlvZsLwQ6wObwBOK8QlHbMhyk8nJx
	 4i47tZurPprxg==
Date: Fri, 14 Mar 2025 11:44:52 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, mcanal@igalia.com, Alice Ryhl <aliceryhl@google.com>, 
	Simona Vetter <sima@ffwll.ch>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v3 03/33] rust: drm/kms: Introduce the main
 ModeConfigObject traits
Message-ID: <20250314-friendly-hilarious-axolotl-ccf19e@houat>
References: <20250305230406.567126-1-lyude@redhat.com>
 <20250305230406.567126-4-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="ndn5jrobqdpkuzie"
Content-Disposition: inline
In-Reply-To: <20250305230406.567126-4-lyude@redhat.com>


--ndn5jrobqdpkuzie
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC v3 03/33] rust: drm/kms: Introduce the main
 ModeConfigObject traits
MIME-Version: 1.0

On Wed, Mar 05, 2025 at 05:59:19PM -0500, Lyude Paul wrote:
> The KMS API has a very consistent idea of a "mode config object", which
> includes any object with a drm_mode_object struct embedded in it. These
> objects have their own object IDs which DRM exposes to userspace, and we
> introduce the ModeConfigObject trait to represent any object matching the=
se
> characteristics.
>=20
> One slightly less consistent trait of these objects however: some mode
> objects have a reference count, while others don't. Since rust requires
> that we are able to define the lifetime of an object up-front, we introdu=
ce
> two other super-traits of ModeConfigObject for this:

I'm not entirely sure what you mean by that, sorry. Would you have a
small example of the challenge that forced you to split it into two
separate traits?

> * StaticModeObject - this trait represents any mode object which does not
>   have a reference count of its own. Such objects can be considered to
>   share the lifetime of their parent KMS device

I think that part is true for both cases. I'm not aware of any
reference-counted object that might outlive the DRM device. Do you have
an example?

> * RcModeObject - this trait represents any mode object which does have its
>   own reference count. Objects implementing this trait get a free blanket
>   implementation of AlwaysRefCounted, and as such can be used with the AR=
ef
>   container without us having to implement AlwaysRefCounted for each
>   individual mode object.
>=20
> This will be able to handle most lifetimes we'll need with one exception:
> it's entirely possible a driver may want to hold a "owned" reference to a
> static mode object.

I guess it kind of derives from the conversation above, but would you
have an example of a driver wanting to have a reference to a mode object
that isn't on the same lifetime than the DRM device?

Maxime

--ndn5jrobqdpkuzie
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ9QIngAKCRAnX84Zoj2+
dgfCAYDJpSkIJQ3BIcvY8iCyi3ZbDQocyJRHjcZWbIu4GbuAmznpS+V/4Vg3uNAj
I5FNIC8Bf09cFAOnftFn/5P4DEJYaWozLHdDPvRj/vL7WvHwqyLfFjXW7SoF+EGL
ZNEgAHlSHA==
=PqlL
-----END PGP SIGNATURE-----

--ndn5jrobqdpkuzie--

