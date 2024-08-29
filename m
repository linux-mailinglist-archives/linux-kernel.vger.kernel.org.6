Return-Path: <linux-kernel+bounces-307468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9001F964DE6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2FB61C222F5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3401B86CB;
	Thu, 29 Aug 2024 18:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="hAJNVeDC"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3941B375C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 18:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956875; cv=none; b=tMaEu66gvwjWbNQazI0WP3LE92wVWyRzyPWQn2YAaTE1z9bD/rPM9ieEtS8MEXFbkZY13oE6QdrtwcEz/EH1UHG7czWr4O160rX9ec6LJR3QkmxlW5SZw3Wy1zDor9vZV2FK8Z1Ih1zZjTnFrzRb5AzXVaAhpxknbWTILJQpuzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956875; c=relaxed/simple;
	bh=y3CKx9yPAClsfMxRC+2fQN6G4AoThcuox7GNcLSnyH0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihZ81uZBZqoCOxxpZ1+GZZWDHWhXaiuuHck0mODpDxc9PHTrU6hjqeUv3HQ6x4/4+KagK2VYhupSikSUUPec2UhFXd1tNIMNSCejmXKt/9ns97Rv6a1prlRoD6bqywEeEjmuoBMJ6hW9d6WAIGLQhBjAdqIAyq9yImV2HfqwFuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=hAJNVeDC; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1724956870; x=1725216070;
	bh=DK8G/oV0NQnHR6ELSMxXz1prgv5XgJZSEeMYPgII70Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hAJNVeDCD2Ibocs524Es1RBzLtEu6p/DFCxnmWQVebyrqlyqvTC/wArdcakGsd3Wj
	 2v6n6SNW2+JHKjZIjbzYpgT0ps6+BjXRIthfF9lCwC9yNuRlOLoZDMqvrnQ851oiC5
	 /umMKZjamxVlxhm6Rk8QGrjk2W2suooALsK6KhtgEbC7Eq1928cWiVE/1FmR1N9YLf
	 b6N9vEXBzGyQL6OAZdrAQpskKpFg4hF8Iuxnm5YaVXzHB0I+O9S1lvQw0OLcmYqGPY
	 N99qaUvtT3BleZTXcXVg0Kxuw/koc46IUNjTwPS8AFXRFg18WPu2KgfI+V3Jsu/GLa
	 9TAGXfqtXZDFw==
Date: Thu, 29 Aug 2024 18:41:05 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 16/26] rust: treewide: switch to the kernel `Vec` type
Message-ID: <d98c810e-6fbb-4e90-9689-109d7194d1b5@proton.me>
In-Reply-To: <20240816001216.26575-17-dakr@kernel.org>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-17-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 9ad2676be0af3915e5f3da50ea6a3fbfab4633de
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.08.24 02:10, Danilo Krummrich wrote:
> Now that we got the kernel `Vec` in place, convert all existing `Vec`
> users to make use of it.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/str.rs            | 12 +++++-------
>  rust/kernel/sync/locked_by.rs |  2 +-
>  rust/kernel/types.rs          |  2 +-
>  rust/kernel/uaccess.rs        | 17 +++++++----------
>  rust/macros/lib.rs            |  6 +++---
>  samples/rust/rust_minimal.rs  |  4 ++--
>  6 files changed, 19 insertions(+), 24 deletions(-)


