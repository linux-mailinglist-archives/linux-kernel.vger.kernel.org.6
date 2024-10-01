Return-Path: <linux-kernel+bounces-346270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EFB98C21B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C06A01C22A41
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3051CB327;
	Tue,  1 Oct 2024 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Qcommawu"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5E51C6F70;
	Tue,  1 Oct 2024 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798522; cv=none; b=on7Giq6LPTrKIka3WOhwJ4/VyeyXb5BEZ5yR0qUHUrCYUX3ix4EbKdHvxsBegTenJodEJNh1s1hiOW2oxWYra/i/ENsvZIMOHO+FxsGlbzuDv+fh4xZj6CjgNXiDJWhAbF0kJ8o+Mi4vZ5fvD+s1sCI/JzEKQ0xgsy4x9+/CyqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798522; c=relaxed/simple;
	bh=sMC8j4p63CdtfJ0sdGakdc12GQvRywEdcFw0FglUb+c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJb46ooXCwKxsBTCdGLAKGNxl81z3HQUsviJUCISjPl53dHAwI+UL2bq4bJBX+9fSr83bOixwQTEf8P3fK6vI78jQG1lZqvQeeSr861oDBDrwNlRJILZj9CVjDy4Za2TojF32CmuDtq0pHX+79507GNyl+OZtYndQUXpKh3H8ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Qcommawu; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=fgkfw2netrchxmkecz4hwysdly.protonmail; t=1727798516; x=1728057716;
	bh=tfVaqKbb1vbxPwYQmbROEUl/ek8lFp6P9QuUbVmZCUI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QcommawugZPGq/slqtGWC1xzQViJw7s3DREHbcv0m6BHfcOwsOoGFx2RD39EPKclq
	 GTmzBDC5J9H8kqqI2i/bOyUMD15h6U87OJD0cfKZTO+ApdDm4NnDrGJBlRNz9jfxmK
	 xN2/ClWEfc2IG9P5ek0E23wmMkmZmSlaMexbbM+z8iA90R9C1prfcn1MBQpceNdF00
	 mXQSsPkmtqUfFd4PBZJhQkutM6ZXga+fbVH78UwIjdrjVPAMvhA01MOl4X3P7Y0Wa0
	 phh5iz+OFeb2KgtzoYJmSeKQoW580oT0+Ha/irz5KzfsdzHV/l64QrsAAXhiWYhwfb
	 i6obKi1zkrp0w==
Date: Tue, 01 Oct 2024 16:01:53 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8 06/29] rust: alloc: implement `Allocator` for `Kmalloc`
Message-ID: <28891e74-1658-4170-b144-fcf29c5ba449@proton.me>
In-Reply-To: <20241001150008.183102-7-dakr@kernel.org>
References: <20241001150008.183102-1-dakr@kernel.org> <20241001150008.183102-7-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 734656b1957c36c516f169f8559ce7ae99391fdb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.10.24 16:59, Danilo Krummrich wrote:
> Implement `Allocator` for `Kmalloc`, the kernel's default allocator,
> typically used for objects smaller than page size.
>=20
> All memory allocations made with `Kmalloc` end up in `krealloc()`.
>=20
> It serves as allocator for the subsequently introduced types `KBox` and
> `KVec`.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc/allocator.rs | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno


