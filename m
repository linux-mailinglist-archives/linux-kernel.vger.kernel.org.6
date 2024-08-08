Return-Path: <linux-kernel+bounces-279135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EF894B96D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963361F21E6E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B45E189517;
	Thu,  8 Aug 2024 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="MmWwrHEB"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728321422AD
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723107737; cv=none; b=V0BvdhwaK0+beVaNX/2GmUJ/0vN5c1z3hJCWmH1K9PnaMAq9eQjYx20zS4JHeTmq8pVkjMGb12FKhKR4YAWE74zkc34rfYW3yHVXYoPZbnjNrJ6gXenwkvxUNL6e2l+O5TBj055gdWBWDbODcaFG7g7+10ztP38oMRameQ+Bf/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723107737; c=relaxed/simple;
	bh=iP//oevBEAxtIOncAnpKXE2CeY4AlOAC1pNg0K0Cf9w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UDKP3Iuzz6HSqOFqW0zRHSxknmuHFMN3hMOkOdOVlGPqTLQcPhJDRuzIpGrXLNELWn7Nyg1ROdc8/C9qghapXeRej5RPx1m9UMtXKApNwsFlPD2gim5znzPCl75G9KmUrJp5DjrDiLyZE/fN6EcfKBX52AGJe4TFx3KVUL2Dm9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=MmWwrHEB; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723107732; x=1723366932;
	bh=iP//oevBEAxtIOncAnpKXE2CeY4AlOAC1pNg0K0Cf9w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=MmWwrHEBiCGg7C+K2Xlv4TiE9PM8an5znwPnOnjGqcqG/+bg/fgULxnoRwmOG0qis
	 Tnd5OkkFtthP9aWPjPQMWwZOlupwcMOQEnY/vG4v0W9X132z08yXNmO+ENdscJTC/N
	 2NuxdvKITrJeyFznBhTuMo85lXQQ95spAzWHQhNEfOq8nNwDlyDNyFk5VFql8QP6ye
	 jNfSSolVuSnObOeoWRxl8zJIecax03w5fm3ogEK+VKTN5v64ysNjZFebjwA6I3d529
	 hXsnb5JPEZYAKGZ1LO7vFU1sP6SwzQeBdxR2gXnb/n4L1cBhyCSznb+q13ZbC6S8wZ
	 aqX2Xzp5QGY5A==
Date: Thu, 08 Aug 2024 09:02:06 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 04/28] rust: alloc: implement `Allocator` for `Kmalloc`
Message-ID: <7b97e646-2d8d-4947-9313-b828b8f773c2@proton.me>
In-Reply-To: <d005fe7e-74a8-4609-92e0-5dd3743ca060@proton.me>
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-5-dakr@kernel.org> <fe982cb6-4910-4ba2-ae4d-892514c9e7f7@proton.me> <ZrJxkwF2Y59xln1e@pollux.localdomain> <8ab83e4b-9c72-4a5d-974a-7f123753e7fe@proton.me> <ZrNIaAcGkGU0d8I3@pollux> <9e22d4ab-eff2-4c69-8a2f-f55a8eaeb892@proton.me> <ZrP90NR1lOpDrQ0X@pollux> <d005fe7e-74a8-4609-92e0-5dd3743ca060@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: ce737a7277b35ef8b58768657532d95832eec3be
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.08.24 10:55, Benno Lossin wrote:
> On 08.08.24 01:05, Danilo Krummrich wrote:
>> It's also not that we safe code with that. `Box`, `Vec`, any other user,=
 still
>> would have to create the `Layout` before they call `A::free`.
>=20
> But for `Box` it would just be `Layout::<T>::new()` and `Vec` needs
> `Layout::<T>::new().repeat(self.cap)`.
>=20
> Though for `repeat` we need the `alloc_layout_extra` feature, which is
> an argument against doing this.

Oops, I overlooked the `Layout::array` function, so this is not a
problem. Instead it just is `Layout::<T>::array(self.cap).unwrap()`.

---
Cheers,
Benno


