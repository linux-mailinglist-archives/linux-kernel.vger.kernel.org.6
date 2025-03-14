Return-Path: <linux-kernel+bounces-561380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3C6A610A2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56ADC3B985F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01281FDE08;
	Fri, 14 Mar 2025 12:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1TGmXL+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365C5192D6B;
	Fri, 14 Mar 2025 12:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741954092; cv=none; b=SllEU+OC+BNcOCuDg34XnxQypLY/gqATLk8Ph0qScv+th0D9ruee5ajb5StvKpsRZ+77vNiq2jvU+Ja5H9OzfCgsIdjNhTKqm3zoFom1Pa/mKdw1jSAzfjK676wQVFb+uxfhbQFJJVZaxacZQq23tV/Q+PaRWQ8KfRvgMt2bwLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741954092; c=relaxed/simple;
	bh=CsblKkzrgaBYWK1E9v2Fy8dSmqzMfbZvHjzZ2SWXI8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzkbbHwgYItzHAa//s2fA+MYqFN0HIAsUWJ0w+BlV8m92Dmv8b4HSII1m6Qb7cp3/jLourWRZisw8UKjybZVj0jXMM6b7dLY4+lDOLfbHlXZ1KsrWcOYKA3pQzxgej2kcOD+hihGkvI1WSZxUzDcH1yh1SuUaRYvXhQZYt6bvHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1TGmXL+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B55C4CEE3;
	Fri, 14 Mar 2025 12:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741954091;
	bh=CsblKkzrgaBYWK1E9v2Fy8dSmqzMfbZvHjzZ2SWXI8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A1TGmXL+04DceRTtPbY8TmL3vpktUCJ54aeExW9ij3nkZ9KJSKR5zgIVyfXmwJ0MJ
	 RE3fNr1ykVugz44dslc1HN+uPkLxn+9gQ9qf0TcGdqp1jQ1uYTdkY/g+M+WGIWYGWa
	 8CdxQZ7NONOhaq/PcPEFjqC3ydt0rwtu7HltmuclGLqPA3cRtgHByV7CC0qtwkyEV3
	 IN9Lc6uZsfrgSiBB4RRFWl5ARyT6rd9JvOAvT7Q/BbCCCsGKPg4F+4/0ZpTGn9Rpx4
	 Cj6HPJJpddyw/UuOcZLRyQfcWkymVGJhVnvKLAY/j0HuJmv0wcn/rL1lxEz+7hmMmV
	 1RsJR5ZdaPDTA==
Date: Fri, 14 Mar 2025 13:08:08 +0100
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
Subject: Re: [RFC v3 14/33] rust: drm/kms: Add OpaqueConnector and
 OpaqueConnectorState
Message-ID: <20250314-quaint-acoustic-rook-c925b0@houat>
References: <20250305230406.567126-1-lyude@redhat.com>
 <20250305230406.567126-15-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="qbatj5vagswgvyov"
Content-Disposition: inline
In-Reply-To: <20250305230406.567126-15-lyude@redhat.com>


--qbatj5vagswgvyov
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [RFC v3 14/33] rust: drm/kms: Add OpaqueConnector and
 OpaqueConnectorState
MIME-Version: 1.0

Hi,

On Wed, Mar 05, 2025 at 05:59:30PM -0500, Lyude Paul wrote:
> Since we allow drivers to have multiple implementations of DriverConnector
> and DriverConnectorState (in C, the equivalent of this is having multiple
> structs which embed drm_connector) - there are some situations we will run
> into where it's not possible for us to know the corresponding
> DriverConnector or DriverConnectorState for a given connector. The most
> obvious one is iterating through all connectors on a KMS device.

It's probabyl a bit of a stupid question again, but why can't we just
iterate over dyn Connector / ConnectorState and need an intermediate
structure?

Maxime

--qbatj5vagswgvyov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ9QcKAAKCRAnX84Zoj2+
dvkxAYCyCi1bJ3EVAOtyDym8P/XyOqRu1PVtTtQqrcykL8XC58If4p4FZRaw2oP2
8CH+Ga4Bf1BJ0OGDOfan8Z+/3tFDUgoZT7KKcrop6h30bpJrBEXR2WEHjMSEiVPT
AkNxtorvSA==
=fjKu
-----END PGP SIGNATURE-----

--qbatj5vagswgvyov--

