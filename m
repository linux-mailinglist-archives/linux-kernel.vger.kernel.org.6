Return-Path: <linux-kernel+bounces-279143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C155B94B984
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A883B218E6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E858189BBE;
	Thu,  8 Aug 2024 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="T2hNgVQs"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ABC189BA0
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 09:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723108464; cv=none; b=NQPmBVZrObVCr63WQsifIpGMXUYNOetL2OwKFjibDQBhhtHqTfR1SBEpc66yFq/trlm2H86ExtmzFPh8UPmdWkkxA8dRjvQZlR53epItbUkFjkJgTgAnp5y8c1vdUVJHDkbxcsaakCGCYmD1OOqk4J1yvkTLG7GfvC7KwGUeHho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723108464; c=relaxed/simple;
	bh=+OrJxe0D7xREShQfmGh81Vo8Uz6+eWSXYbFVN4mx++E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=USgtLlT6YXXqEXCI9rJkdERtAO/rOVjpQMd5AjXeHmV7gmwsimKd0o7SdDu4fK4ztoixG7CcPI5DsaM5uANyTsK9CePvW8VQB7sPZtjpoFcQ8CH61UD1CDFC4Oj3PioKqoV1bc/bz5aJhyAZsPT7JM/XwARmupJjeM2XJ+yMjRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=T2hNgVQs; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723108460; x=1723367660;
	bh=l2VLv70ZhOSgGrwZycl6ZH7PcquoSAgvnaR1Gwl6JC0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=T2hNgVQs4AXajLZoqe35IdhFAqcF+j+dwwB5i8PYKCVR0fxd8aCrnA9usK5+xACuE
	 mABcz/slipqNyi9+3kmyVYtGmaT15iV/NjO32Ei+pLAeXCWSMfQo+TuLnoOGX/O3g8
	 aQBGdADcqkD7AHGrPqVhXAwDkPfT4UZ4yC5i4yj54b8v2mvELPEY9rmwNN/uM42Atl
	 PeQrEMHix5C0Dv4Uk5QignWdg7In9Mr/obO4rANu1UnGjkf/sQoje4s6R14OTmebrn
	 Lo+siAvZ7I95GT2nEjZaONphZYyYQPk6o806gqbFDimasqRXjZDnwLp7obNnewHf5a
	 fKrFXozIDXFiQ==
Date: Thu, 08 Aug 2024 09:14:13 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 19/28] rust: alloc: remove `VecExt` extension
Message-ID: <7b794a44-b13f-4f8d-8f10-84c5a1042107@proton.me>
In-Reply-To: <20240805152004.5039-20-dakr@kernel.org>
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-20-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f88fa19c14d097cfd90760ea67a16df15776c1c4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.08.24 17:19, Danilo Krummrich wrote:
> Now that all existing `Vec` users were moved to the kernel `Vec` type,
> remove the `VecExt` extension.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc.rs         |   1 -
>  rust/kernel/alloc/vec_ext.rs | 185 -----------------------------------
>  rust/kernel/prelude.rs       |   5 +-
>  3 files changed, 1 insertion(+), 190 deletions(-)
>  delete mode 100644 rust/kernel/alloc/vec_ext.rs

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno


