Return-Path: <linux-kernel+bounces-551664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C417EA56F45
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA2517ABB2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DE224169C;
	Fri,  7 Mar 2025 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WksvJn1d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E2224168E;
	Fri,  7 Mar 2025 17:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369117; cv=none; b=KGMY8R2+jFn1wnSNrVB/B/KidveBCkQnDbzQWXcaAmfKb1O0h8i3KoIyCmWhpjj7ws50bVqiG07oVKr/Etl2VGO6l0yJ56mRumOC8ep4l5SWYKmtPAD0SkdBWRsewWQwgoamsyrgPBxg7dWHm1v2KcX7v8ttgKeGzenDIsHzUy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369117; c=relaxed/simple;
	bh=1anCR1zJXUnQImJd8M1Vqm1y++5+d5U9NzwTDIDXY2w=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=r+/vN9V1cmtImpPHrU92lS9No1J58cgj8FkX8rN3YRLqZDn6ib7dJ+Xs7lBsORkYLqFNqtoULDI6FfZeTt1OIPrHabHpwbGOpv6V6X9pwIys/ylpvTRRAjz56N283lCTDCMv2Yit6skQURwvn0rVmtKCnMFVtxJxSg2ULphZGFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WksvJn1d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F8FC4CEE7;
	Fri,  7 Mar 2025 17:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741369115;
	bh=1anCR1zJXUnQImJd8M1Vqm1y++5+d5U9NzwTDIDXY2w=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=WksvJn1dFP7Pkqfo0i7CGDTx945wZeMTJNNIUfv+WsTt3w6oVhwSuYYqVFDq5Q2eJ
	 4lsPNJxVHfnJBNuwQoTKZn3wMwUrbBh5wI/+xhdccEx6kJEwrp8DfuEj0GV+mJ0cxB
	 234LHk894qf6iu8RT4EpvRbpReKNjvuNu9xmlB4vjY21CCLGSxYfDY82D/Nvhfc+0v
	 uBZ/O//CD4UWzoXSzrSHMvtJuSIYeZ7eorBsD2PB/5qPNs72qIuKNeW5/omsLZ/FLU
	 2nqTYRoGlPrO6cEaChJ7JBN5KdZKPw5D1Lo7eiDgmhoqY2Y1ZnNfStP80ZmOtC6lRA
	 BRCquVafFbgRg==
Message-ID: <eb9ca88d6087514919c12a4cae1dc484@kernel.org>
Date: Fri, 07 Mar 2025 17:38:33 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Lyude Paul" <lyude@redhat.com>
Subject: Re: [RFC v3 30/33] rust: drm/kms: Add Device::num_crtcs()
In-Reply-To: <20250305230406.567126-31-lyude@redhat.com>
References: <20250305230406.567126-31-lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, mcanal@igalia.com, rust-for-linux@vger.kernel.org, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Alice Ryhl" <aliceryhl@google.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Benno Lossin" <benno.lossin@proton.me>,
 =?utf-8?b?QmrDtnJuIFJveSBCYXJvbg==?= <bjorn3_gh@protonmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Danilo
 Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Maxime Ripard" <mripard@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Simona Vetter" <sima@ffwll.ch>, "Trevor Gross" <tmgross@umich.edu>, "open
 list" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Wed, 5 Mar 2025 17:59:46 -0500, Lyude Paul wrote:
> A binding for checking drm_device.num_crtcs. We'll need this in a moment
> for vblank support, since setting it up requires knowing the number of
> CRTCs that a driver has initialized.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

