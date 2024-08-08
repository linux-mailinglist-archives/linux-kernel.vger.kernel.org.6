Return-Path: <linux-kernel+bounces-278946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE31E94B6EC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C39C1F2209F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 06:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC5718787C;
	Thu,  8 Aug 2024 06:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="gZzIhZnY"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF1C5228;
	Thu,  8 Aug 2024 06:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723099759; cv=none; b=uonUOLOPEfEIdjMsErzs4YW8rxx2ZVmVc/6tQMX2pVHHN7Em4Z+Fg4vGg+ZwmfFk0CGZiagtBSU9252IDy+RR3wdKPrPX2FUXuP39RXTGMJHNOk28K5KPa2xsmJ2bfF9uFU/zqxGjGD+F/Ubcydxo9bZpqEkcl/XliB03SnwjQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723099759; c=relaxed/simple;
	bh=bVX1rOYnUObP38XChLEDnc51mYxhtCO1Yg2yd1VhpPU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=crC2CcGMMHX6+JuevZ5ePH0Bilw3YLs+wZUJ3pHRaaJlSo5kyH47MRqcoCjPwx9fK3cPQjQFd8I98uvYVIWa7UdVMh5q2zUArBu+dWZp8sHjHEiUm1qGgm4TlscEyz3F1FlvXSCRUYk/D/j5/rEAo3XC1GA9p8tV1M6Y0C+zixU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=gZzIhZnY; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=5jhm4nvhhng53ltcimickgczj4.protonmail; t=1723099756; x=1723358956;
	bh=r+iBirEkz9zdRZUOXIsoz+8Ct/YLQbNnghIUazSahuk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=gZzIhZnYSN2KtUHf+ka/viVTwzQgJe1uLPTsN96oarO/VjWYam7I5tCKYzmR8wetI
	 w15GaWqizPWrLaDRj2RnMpxPEnZ1qyDBvLH8dK9osKqv2VKR6xkF9vJVIDrlUu/1yz
	 LUDyQuArDGPBXqfVGfR9Q3bg07BxX6auwISOGLkn0xZxbqvylWEq0ohUPrtKNfb8ND
	 ug9Uf+RJt05Ikl7TA4y/vXnlnWDkhnPMugIQREuTuAAemwkN+dmU18ys+HqvIwLjLe
	 SGRpJa1+i/Z7nWHoBFio13begU96iZrz5pFYwbC7ca2DLvTHzEAu+8QGh5SWgwtqoa
	 LtRJOaafVF+VA==
Date: Thu, 08 Aug 2024 06:49:13 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 12/28] rust: alloc: add `Box` to prelude
Message-ID: <e8b2cd65-4a9a-45e8-842b-9669624a15fa@proton.me>
In-Reply-To: <20240805152004.5039-13-dakr@kernel.org>
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-13-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 6d706988b4cda0f0e4b0845f99f74475cbd6639a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.08.24 17:19, Danilo Krummrich wrote:
> Now that we removed `BoxExt` and the corresponding includes in
> prelude.rs, add the new kernel `Box` type instead.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/prelude.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> index a8018ef2e691..6bf77577eae7 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs
> @@ -14,7 +14,7 @@
>  #[doc(no_inline)]
>  pub use core::pin::Pin;
>=20
> -pub use crate::alloc::{flags::*, vec_ext::VecExt, KBox, KVBox, VBox};
> +pub use crate::alloc::{flags::*, vec_ext::VecExt, Box, KBox, KVBox, VBox=
};
>=20
>  #[doc(no_inline)]
>  pub use alloc::vec::Vec;
> --
> 2.45.2
>=20


