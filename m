Return-Path: <linux-kernel+bounces-278945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA17494B6EB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 275B51C20DE4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 06:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA12F187FE2;
	Thu,  8 Aug 2024 06:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="I6n452DY"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3344E143723
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 06:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723099703; cv=none; b=hYunB+8WJQWAfM+zJz2tlMlcpBZEGJfXH1Qd6yvYvmWQ6YvvhLSzMNdYhAsy8RqTiX+mxQXre74nNYyCvxweQomW4yKWJysDdeG8gE49YdwNzw5GIB3GC6PgeeDlMHJAQ4AGk8TDql5jT+qZf9NS2mOhIBfzTjoR+qNdXCt8PLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723099703; c=relaxed/simple;
	bh=YZmqvFtcmiuBdsEDB0/oBBbeoJpGjGMSoYbtqJBMEng=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cuvpU86nEQWX/P9ZgY3H8mq8Ym7ztsjAVz8FVETNMZuKQiRSCjXRgDbZzf3KwoO051jhh1p63nBlnGtibxjqiKJ1rq2tkvhqCCileutDp+KbbcbvMNz2cpLUnZWOVsAv/MvzEQ466PWWM/bm1iTx/W2hsJ+Xd8cgvoqRE/mOfaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=I6n452DY; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723099698; x=1723358898;
	bh=2s2voItqU9X1rXU+2ig6xFu7OqKXVF7GesxAQCS6Q6w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=I6n452DY3VTl5WNxYhIlb9F58QM2NWaOge+S9nGok7Z9UiB3wOkmEK3rC4WYAyuJf
	 fy8M9fht8GBHmZe3y49+D1ExR9ds+ZSHzHxrQK0s3xYUijjj9DCAh5JYTihCWpii3e
	 NRfVysMIfSBGyfKQEg8QoU5Z4OuU+rkkv7e9Jmm7K4Z49Ea/P9qqYEDZAs8dk82Z5R
	 4w5Oc5B7QsGd8LPotrA+uR5mc13f79YLw8qSgI1xilCTtX6Rb5SqHIBF7r6jMuRwRi
	 gYwuPxphBFMbWnq9hIAREABiYblGpvRSX5GO76vJQ1PMSrt72XcjLhGX+gOZttgePh
	 CpEtrnTNketlw==
Date: Thu, 08 Aug 2024 06:48:13 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 11/28] rust: alloc: remove `BoxExt` extension
Message-ID: <7a0876a5-624a-448e-a434-fb117fd062e8@proton.me>
In-Reply-To: <20240805152004.5039-12-dakr@kernel.org>
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-12-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 94ed4bab8263ddb41a63ae6fab6325749eda5a89
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.08.24 17:19, Danilo Krummrich wrote:
> Now that all existing `Box` users were moved to the kernel `Box` type,
> remove the `BoxExt` extension.

In the changes below you also remove the `new_uninit` feature, the
`impl InPlaceInit for Box` and the `impl ForeignOwnable for Box` but
don't mention it here.

---
Cheers,
Benno

> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc.rs         |  1 -
>  rust/kernel/alloc/box_ext.rs | 56 ------------------------------------
>  rust/kernel/init.rs          | 34 +---------------------
>  rust/kernel/lib.rs           |  1 -
>  rust/kernel/prelude.rs       |  4 +--
>  rust/kernel/types.rs         | 23 ---------------
>  6 files changed, 3 insertions(+), 116 deletions(-)
>  delete mode 100644 rust/kernel/alloc/box_ext.rs


