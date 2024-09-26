Return-Path: <linux-kernel+bounces-340497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B8E98742A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0C28286CDF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA072D045;
	Thu, 26 Sep 2024 13:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="dp/BH5sN"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D94026AE6;
	Thu, 26 Sep 2024 13:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727356053; cv=none; b=Hnr2ff5dDsPa78dFhXAaY5bbjwmv6MeqCInwzIvNuKCLlxo+vpjFYsqn1g+IQi1qe+DENbUmdKhID/4Xxc2t140W6COfwjeuHOqPRMpWUddvETvF30NFF7IVljdmFizIakVBpc6/WNDYPKbqi43HJAFVrglbU4O0cNlw93g/ox8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727356053; c=relaxed/simple;
	bh=fQIl453WPAOziOMQ6AP4yyK1pj/thuwthriOt9RlAx8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XRLCNbutIPMebfePFw4GmL/iiowo/UZ5nkcUsoFSuSiPC5EKJ1QZpGAyP0ikmCy1ibRbkX+Km8hIHqbpuDPLsKvAQNWC8asRI+uJBGa90AZ20MyZZJYNA4Bt+ZRU9h2Vv4+82kSwWr0F9BJHPH94KZf7T3JP6MYQP/uRC5hJY6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=dp/BH5sN; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1727356049; x=1727615249;
	bh=lBz8rVWrRoCqUt0Wt/NMkinBnaS4F0qS4vpGOYOEDDs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dp/BH5sN2sKmo4E7rKr7OvDuv6u7ljzKMT7hzN3ZZwaaXxSDqDNFUl1WvSGS0lVZJ
	 Et1dNjeDW0AZBjUXi9gv87rXUZ+lczTVvMrgT+kDjVmCmRVnG7xCiYf7erCjTJpazA
	 +JlKkENXoCK4F5uL/bGMVZQwj1KmrdiebutdFjmbjJb31fUJ4ddECHzz5yLvEM9ZnO
	 xej9X2mL/KnxsMYVN0OvBFRMx76r1favMlSunT69G7mx6siVPfTIkYZIVh+YB+bG84
	 +NHj/WlBunhnLe/tfY2c6rDBg4hDZNxVosPJ6vgobFjDbusuIO9JVVMC9zY0oFcSxA
	 Gs2Hhet8oBKEA==
Date: Thu, 26 Sep 2024 13:07:15 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 07/26] rust: alloc: implement `KVmalloc` allocator
Message-ID: <3fa301f0-3514-465b-93f2-b7d6fe0da9e0@proton.me>
In-Reply-To: <20240911225449.152928-8-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org> <20240911225449.152928-8-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: ce2afc3153a8da314e66147909a188cdb44f1f2b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.09.24 00:52, Danilo Krummrich wrote:
> Implement `Allocator` for `KVmalloc`, an `Allocator` that tries to
> allocate memory wth `kmalloc` first and, on failure, falls back to
> `vmalloc`.
>=20
> All memory allocations made with `KVmalloc` end up in
> `kvrealloc_noprof()`; all frees in `kvfree()`.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/helpers/slab.c                 |  6 +++++
>  rust/kernel/alloc/allocator.rs      | 35 +++++++++++++++++++++++++++++
>  rust/kernel/alloc/allocator_test.rs |  1 +
>  3 files changed, 42 insertions(+)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno


