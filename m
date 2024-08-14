Return-Path: <linux-kernel+bounces-286896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEADB95201C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62A2F28A7FB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F271B8EB5;
	Wed, 14 Aug 2024 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="JOvj2lJs"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092EE2D638
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723653326; cv=none; b=YXUxYxsXzu2a+Oqvtbcicy7136nhUOSiEX5SLDU3Ygp2JLAKE38Hs7qoTLCnOkQ2uMB5T79Altff45B1yxuP4gXHaueRJhF4i65D7WQfFSSZ4FSvcbRpLVeM45h1hhdkcpBMR/7ed+C43vRbcB/dKGgnnQWmbJDT8NV0At4c9zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723653326; c=relaxed/simple;
	bh=BEi72zh/A0Ym3ieP4T9A+P93iD1olPrV9gba4Kak+Pk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sL/MikHlWcu/2YtI3R0Zn3H4Vvmoosz3D//et96RUr5V6TMQz+Lng8033o87JxVuMTEghXt4tItNo7ndHazEe/j1p0QQ2RA1OCXlej4ok3r272oO82IdySwCw2MZm9bJGjn0BCkeyLbVhxm+IjlPeGlCGujdGs3c2/havDsFbSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=JOvj2lJs; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ux4hrfrohbcj7aosnhhhwh7yui.protonmail; t=1723653323; x=1723912523;
	bh=TWJzCnlP6EoG4SDdUYzTYEz41isA+56G/7vmG1iqMnU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=JOvj2lJsCTcx7o10PlK3p/nXRjv559fD0LNYjw62n1YGqr+Fb9U9VAW3/HdnwK7Aa
	 1f+reoPv7KVUhWeW0LFQrwLZR2ezvGysZYmoGAyXj/lMAJuJJMYNxSn1EoRZICHJzz
	 Seb38n3g63QG7fymU3UoCLdnEze0EMiDILEPScZQg7VnYmTsEl7gfPrTQI9wbjkP84
	 xAXy6vsCmZKzGiBTgemp3Rg4t0SMPagsOxXVolMCAEPCtHRMBOANtKnV+YmA4JhATc
	 Og/iMXrfoqQYezkNr8w/Kw/4K/0JULaS5C5Ort62hFReWUukl1mB1I0+kbxesyjJjT
	 fSZ4ArXRQzn9w==
Date: Wed, 14 Aug 2024 16:35:18 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 08/26] rust: alloc: add __GFP_NOWARN to `Flags`
Message-ID: <e217d5cb-206d-47a3-bb0e-2466f1dc506e@proton.me>
In-Reply-To: <20240812182355.11641-9-dakr@kernel.org>
References: <20240812182355.11641-1-dakr@kernel.org> <20240812182355.11641-9-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 5398ae4da48429626b4f122ed52bd7548cd274f6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.08.24 20:22, Danilo Krummrich wrote:
> Some test cases in subsequent patches provoke allocation failures. Add
> `__GFP_NOWARN` to enable test cases to silence unpleasant warnings.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/bindings/bindings_helper.h | 1 +
>  rust/kernel/alloc.rs            | 5 +++++
>  2 files changed, 6 insertions(+)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno


