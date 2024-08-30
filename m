Return-Path: <linux-kernel+bounces-308890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A25966343
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F87C283C9A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BD71AD5EB;
	Fri, 30 Aug 2024 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="O2k0hWVq"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727A3172BD0
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725025450; cv=none; b=B+za1GwZdG+xKfavr0fZQQGBfUG3xpemZLemPivNOHFwGUIyyWSQ81SSgij99Gak8PFLow8GKwJmZG14vZjQkRpWGDuV6OPbfu7KplItiSZq+UMnFmI9Q7bUbE3y9ejSYvkWBBJq8Pc8gZtjqW81D6RV9klBJdveVs/L+Nd/yD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725025450; c=relaxed/simple;
	bh=djdNbVmrsW6hw8WUj/Mlg46zFCWw3zbmK3wHUsqxZrQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L/4qwfYUSCCyff5nnUdSiOPPXs3+uIAYXttlxNvzftEc050hy3R1lxx6OQoFIB/2bcJvgE5Dct0kqoApVwGDRWxWJuK0fg0Pdg/S3RMXuPE75xWi8xJyajR7n5tAmtXZue1YEAJ0SZm7f1J6pLBHE14zqtKVKpb1A59vN5ucl9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=O2k0hWVq; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725025446; x=1725284646;
	bh=djdNbVmrsW6hw8WUj/Mlg46zFCWw3zbmK3wHUsqxZrQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=O2k0hWVqhq8TMzWrtg0Zx0rjM0N6EwyUo9dJeYEnA44tPUt5JAS+yn50H1g8isKWX
	 GjQ+4FBomSLb157NXqpBlaPCJhDpHTVvBuMndGSVBZ8+vrV6JOtQBfqT5JAKwMIe6L
	 5gLRnxGCOgHWBEJpywLas+0m0L/steoQEJmh6uoUAi7EyQ4mPDo6BY7Zaq1pDR9c33
	 FMRjfenAzeWAU2SHKk+20FyAxUA6c9Dlg17E8LABBcNEjABAblNN0I2bVPipujitMo
	 c25uNvuV2VtwtXUrd+rvok6WCxSgVg+mx/noG3ojDLBI5dplLGMzNiPJWpug7tz/29
	 s4lRbFT7wWPyQ==
Date: Fri, 30 Aug 2024 13:44:00 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 01/26] rust: alloc: add `Allocator` trait
Message-ID: <097db593-d25c-4a87-97e1-b7214b4606da@proton.me>
In-Reply-To: <20240816001216.26575-2-dakr@kernel.org>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-2-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 22877c4c02f7adf62ef126904bffd48369a0b00c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.08.24 02:10, Danilo Krummrich wrote:
> +/// The kernel's [`Allocator`] trait.
> +///
> +/// An implementation of [`Allocator`] can allocate, re-allocate and fre=
e memory buffer described
> +/// via [`Layout`].
> +///
> +/// [`Allocator`] is designed to be implemented as a ZST; [`Allocator`] =
functions do not operate on
> +/// an object instance.
> +///
> +/// In order to be able to support `#[derive(SmartPointer)]` later on, w=
e need to avoid a design
> +/// that requires an `Allocator` to be instantiated, hence its functions=
 must not contain any kind
> +/// of `self` parameter.
> +///
> +/// # Safety
> +///
> +/// A memory allocation returned from an allocator must remain valid unt=
il it is explicitly freed.
> +///
> +/// Any pointer to a valid memory allocation must be valid to be passed =
to any other [`Allocator`]
> +/// function of the same type.
> +///
> +/// Implementers must ensure that all trait functions abide by the guara=
ntees documented in the
> +/// `# Guarantees` sections.

Can you make a bullet point list out of these three paragraphs?

---
Cheers,
Benno



