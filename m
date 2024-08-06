Return-Path: <linux-kernel+bounces-276559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF56949540
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D849281ABD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B10182C5;
	Tue,  6 Aug 2024 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bniKvxnE"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6896218D63A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 16:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960429; cv=none; b=XpGS5+GxALzg9phdHK4jFTKdFFAB6KtBcAfCiSLVDsMXHm8AHGmH0KGlwaT1MLZ15zo7zQGo5waHS6U/NWgZ/xxrnH88Y3zsHC1iYb/eBBXLDEGkRrE1XevKcSKd1vur5GElqXzPBJsMQkDoVY/FTKauREa5A4VTU9J1n6lf+Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960429; c=relaxed/simple;
	bh=KLm+PWps8aGARJwn8+BNYQaKeVRQecvICMLY1LikY3c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nyO0lt2mEedqhO+fjhITJlLa2RJqkXa6mg9cAO9s0aci20eyJaUs3RSlyadIdSB+WvsfQ19wxIKIDzV0L/I47ReSRFFoB3MBTBhHqEApOcaCdWJi+4qRwuEkbmiW+nIIrXPpPNzTOotdLwlGCX7r5qINV/OBrx7AJba83xG+MAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bniKvxnE; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722960426; x=1723219626;
	bh=5CFGbheCF72VGPU2C+9f4dfxfcyjEie2W/gW7Pfy5nM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bniKvxnELU53NIXp7/k3bWpJYZBOYbqTRp4L2dEgwSOK02INPSvgHXPzqKJIV9aF4
	 lRqu1Y9p8blV2cm1ZE7GVe98MtgBHh/fVdWV7L3IsA7usy0Lp+bVDXeins24ggsGPW
	 9EPjPeqf4UOdFUm3ZLlFTSrrnBn2564DKxdawKL0beYqkXmyrofD+nLnTy0ntR941s
	 uf2Y8MQR4CLt4GwhHp/ycpI0i2RFQYs4gBEnvQMZDRYb/HAUxgLaPRBlVrjxbw8TkG
	 RdH2QDnChPwVBi9y0mph1DCiwQ92YoNUNZxDhs26l+5yKRt5FVz74r9sHdZhpk/wNP
	 AIRqyJmO60U3w==
Date: Tue, 06 Aug 2024 16:07:02 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 03/28] rust: alloc: rename `KernelAllocator` to `Kmalloc`
Message-ID: <51ca763d-ad12-47a3-9222-60b76bf1a618@proton.me>
In-Reply-To: <20240805152004.5039-4-dakr@kernel.org>
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-4-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 2b9167085dc89959d33e8c395c7b0f4b4114c1f5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.08.24 17:19, Danilo Krummrich wrote:
> Subsequent patches implement `Vmalloc` and `KVmalloc` allocators, hence
> align `KernelAllocator` to this naming scheme.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc/allocator.rs | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno


