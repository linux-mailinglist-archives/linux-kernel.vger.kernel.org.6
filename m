Return-Path: <linux-kernel+bounces-347758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457F698DE73
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF91AB2A128
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B608F40;
	Wed,  2 Oct 2024 14:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="D10Gv7S/"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5178D10E9
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881128; cv=none; b=qRwEVcon3fsOu46dKfRc7R3y+AVPgj4Cc/0bE7t02QGTZQIgafcjPEKJjLWskTI2JtPaQmdJTxxF/cSm6+qcvrv+HInOc11Lpo5onBVOHodd+LTwD4+ZBLgwD4Dn6MybW2QcV1CJTiaYNpcA0x1nEUGIHtSVRkrSkjiBar30y5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881128; c=relaxed/simple;
	bh=hfdo4l5G20sIkh5DBqDcle7dFGM5xZUucU2o8hu9fcw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onQaZIKInNkeRlP6ZA/VZY+6DyJnWsz5wJnlv+jVc1qc0/F0czUcESe36C+vrZXTGzH2GNPlJIm9xBhPVez0ag0mMrXWtMYJqLNQmPQ6mrQxemXqodbvPAiboQQaMSuUOK+evgXxuLAXG+BFDZJSTBIuQeumvy2APsreAGooLhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=D10Gv7S/; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1727881118; x=1728140318;
	bh=K2723G9fzDX+kI7ajUK6ae8XzHm7KJoI44NNGhW1hZI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=D10Gv7S/tpGtLyIFTrRXa57FT7igEF2dgZ9p1WoP5ufRK+TLZg6cvLEgugJU4X9V5
	 G9W0HoVt5ZRyx+O//GOkGGNeaeP9FOqf20nZePG8Z0Hh9uYsd4OSJPL+fOMOwIqt9i
	 WZY00SwAej7cF/NIQH3J1AuwS7+ToQo6fGhVuwUreQ69toePsGV68BVOrFplnxf4AI
	 ZOgJTmNobqyfQXvoJno/FE4UFOX04li3I7PUoP3p1m7IB5g+VEtli+qNX/jeH5lxVp
	 9OIuMfc81aV2UCZRPVzjsIkHQ+W/hsc4dd7AD0+gsy0ypC5eO1gYS7Y7NNb8NYg4W2
	 yHQn+tGeSVx2w==
Date: Wed, 02 Oct 2024 14:58:31 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8 25/29] rust: alloc: implement `Cmalloc` in module allocator_test
Message-ID: <14385ba2-8fb3-484e-9b1d-429512e1b39e@proton.me>
In-Reply-To: <20241001150008.183102-26-dakr@kernel.org>
References: <20241001150008.183102-1-dakr@kernel.org> <20241001150008.183102-26-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 93aa017c321ba650d548a36d59cfb2f6b4f927fa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.10.24 17:00, Danilo Krummrich wrote:
> So far the kernel's `Box` and `Vec` types can't be used by userspace
> test cases, since all users of those types (e.g. `CString`) use kernel
> allocators for instantiation.
>=20
> In order to allow userspace test cases to make use of such types as
> well, implement the `Cmalloc` allocator within the allocator_test module
> and type alias all kernel allocators to `Cmalloc`. The `Cmalloc`
> allocator uses libc's realloc() function as allocator backend.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc/allocator_test.rs | 88 ++++++++++++++++++++++++++---
>  1 file changed, 81 insertions(+), 7 deletions(-)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno


