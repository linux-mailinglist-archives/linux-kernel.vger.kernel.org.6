Return-Path: <linux-kernel+bounces-278952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3593C94B700
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0A12B22A55
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C96188006;
	Thu,  8 Aug 2024 07:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="jiYcXm22"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57C7188003;
	Thu,  8 Aug 2024 07:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723100406; cv=none; b=TYYI78zqimJXe80hUCCaSgFxYqan7Gnw45pFgM7fICygJF//goPOveNB0kSbdtDs6jQte3uyBUDEPIiu7cvan+YFiAjy3/bundoumUKUYxcngH3XfvHZ5FYPhpibFmeAJt0Gj21gTWcaHci/iMlDGQiY6ZkGFRv/ErQJ94HquLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723100406; c=relaxed/simple;
	bh=4vNjdVmQhk5H2iU36P+BMo+QeaenqtoM7S8EvTMWySE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fETTyt77t2P1c01RUGr/RdL+FTxbHyc8Zfv64DCqj1X2VFNaEeIO3YJSEgbh3XM+HCe8GgaFEnNURxx6PVVFniNd56wtFzgsmMeXzO8bm62pYDriGrDv/3ANHRPUOcVw4Qj2M9FvmzQUMJ8Qu2KN4cPaj3qC732iHM0FRzEdYvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=jiYcXm22; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723100401; x=1723359601;
	bh=/X5buAgp4ocA7P+Scjl9yA9qBrt9tz1Nab46AF1qQKs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=jiYcXm22sSEj/CaRW/iVY21tU3FZ70XKaArzGdxM9jD14Yfcedu01TzB37KF0SRV/
	 eX71FicjbXwQl1xIUlUt+AXlcgW8r6hi6C8ubsqabOk57gsBv1n4/oRoQJYOiIJr81
	 U8crcKDWRSomYnsq+QKrcipp8qn0aCAtkGblWhCuVM4f6j2xNxhGz8O9lZMCcMHdtv
	 wV4AMzNWBET2Zs8QE20icVggqWORf9XvJOs5Ccm77+aq0GhcyqNOPbvFAquGBgGhke
	 SNE15KlOMqMBcMOV6j1JB7POTu0i5G7s0DqxPt9b9bwRxiX0Vv3aRLioXuM7uid5Z8
	 fSKOKUfDMFqJA==
Date: Thu, 08 Aug 2024 06:59:00 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 27/28] rust: alloc: update module comment of alloc.rs
Message-ID: <886dc2f3-fee0-4a2a-baaf-760d516ab60f@proton.me>
In-Reply-To: <20240805152004.5039-28-dakr@kernel.org>
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-28-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 20df22bea0255fed734dc9cbb593931dfbb41c56
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.08.24 17:19, Danilo Krummrich wrote:
> Before we remove Rust's alloc crate, rewrite the module comment in
> alloc.rs to avoid a rustdoc warning.
>=20
> Besides that, the module comment in alloc.rs isn't correct anymore,
> we're no longer extending Rust's alloc crate.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno


