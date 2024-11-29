Return-Path: <linux-kernel+bounces-425403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B13269DC197
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662092824EF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998CF17ADFA;
	Fri, 29 Nov 2024 09:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0c52VNuO"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D21165EED
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732873329; cv=none; b=FdI+QoCxfhz9HfLhbvCqugSWeGmGHg79ZhuJvzzilHYM46dfLKvI066HxUtL3Kozw2mOZJeknJUR9oVy99LOEGeVkOXij50IPPC17BFJ6x+UNBpMNQ0CB9t3BHcRjeprC20REwnwPE7+R5uI4YJtRTVVuCTslWrVf08ucdhofsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732873329; c=relaxed/simple;
	bh=xC3TBC3hXDQtRMMLwHaC2Yx9WYQVsimtRWH+4eR5vK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O6ihj3hB1SKKNhHVeg+euH5LNOx/MIcT2+4rIXrXwAFtWsRLXbD3Zu02dvu7YLKeIkA7k++155R80wwRv9eqqmcFBQkD1qDaeKxRl9ZJ8bxKmZOR39gfERyXHZEMpmSmHhC4SKQ1acfNJcyQX3Oyw9+R4pphWnZsUqoPBIALAQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0c52VNuO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434a2033562so15152665e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 01:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732873325; x=1733478125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCya0V2ouJjFIBaqKyJ8rlrVuDCrvVqJzJ78/+Hkl4w=;
        b=0c52VNuOrPSgIl5S8eXmO+8Vm8/sxzRh1nNOY1qhSK1AiYRTtgIWWQPN9QqQJA8H++
         FTgT44PTX+BLBxbGQsfKGDduMmarc4kmTmX6Qns5FiaFzK6oiLeqPBrBAf5Wu2a/gM3I
         839R90fQFGIFkhPZrHlrQpTpZD8H/KDKTaRtmDob1UYYjSCxnGx/ERmDKptQxqAogxlv
         xFS6lgQNV2l5koAAVwQu3dYTT61hwxbKe3canDAYvoLKkpzU8M/YgV8qnx8q2fC7jNkw
         VL8YwzE8Ky4JxH6c1amzu4RQ2OaibvNemMwxJjJKv2GhIX3F6xAdccv2Au6ml5HL6cnY
         gGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732873325; x=1733478125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCya0V2ouJjFIBaqKyJ8rlrVuDCrvVqJzJ78/+Hkl4w=;
        b=ugwrDp6XCuRH1Egfmb5SX4rpLheWnJkJahfr2GftCss94ntKessCzC18KywdEEqE0I
         BoVVunA7ioOpHnT/W2FVa3GpeN9miC52X1EaAnYVQSSEYeA3S7nXZ2zVlPHUoWD8/I+r
         XFXlG9dpJ8CNzYfch6pIo2qSfJli21ZwG4nVfTo4+H1dR0x0uavvCoXJqYmXTW0IdD0U
         KVp7JiHKQSD/FhVRJpJN77Cyxnpl+1WvS37A+5cgB36rjX+R2zNHkCrw2prLwJ+SFW/w
         yqG6yXX3YGBF7ss7mpVWqw7T2JcWqcDkeT87viBJQEcnh/Zm+I6NpUFjZKVTJXt9reaQ
         N0AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgDmIW/fcGUOVNR52J4hcW66IzfcGucKsDKdTKhRjL1FnmRN33ArCSNARHxDVLa6onUFkAxLzgfDWdpHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmMa6izUDveGY0poZxaXWOsfLHi4SLGyWmhyqzIHmuOOD9KHBJ
	omxiZtotivDAu2Qp8iYmMzHqGL1CGCRV/MnW6snsny/jpGaaCw3RhBhmBm9b9IXisPjCrjgtGEV
	2ig4YYM6b/qa+FICR09xkXdjMrItfa5UQs3NQ
X-Gm-Gg: ASbGncu/RE+XiGMrdirHmOxMYALMntHrqsmnZS/Wagn5XxZGBBes8ckobiN+IIsJPwR
	/CYqjaPz1C8yWcJ32JlthAlxE3ihYIxmhUsrH8uPFyy9gLYy/0krEhVhvz6xEYA==
X-Google-Smtp-Source: AGHT+IE9/TgAZVKCU5TDmSXossBwgPrlUoxMO11jrwBXUmpCqnfqprE/r7XZr8dFH04PAocSUQRrR43EoUB/tAuRFhE=
X-Received: by 2002:a05:600c:5101:b0:434:9dfe:20e6 with SMTP id
 5b1f17b1804b1-434a9df71c6mr87366995e9.23.1732873325500; Fri, 29 Nov 2024
 01:42:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128141323.481033-1-pbonzini@redhat.com> <20241128141323.481033-3-pbonzini@redhat.com>
In-Reply-To: <20241128141323.481033-3-pbonzini@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 29 Nov 2024 10:41:53 +0100
Message-ID: <CAH5fLgi9+d6PwZdU23xcF0p+m6mja3Dx8BufiiM-ZgLtDSqQDw@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: block/mq: replace mem::zeroed() with Zeroable trait
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	boqun.feng@gmail.com, ojeda@kernel.org, benno.lossin@proton.me, 
	axboe@kernel.dk, tmgross@umich.edu, bjorn3_gh@protonmail.com, 
	gary@garyguo.net, alex.gaynor@gmail.com, a.hindborg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 3:13=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Isolate the unsafety in the declaration of the Zeroable trait, instead of=
 having
> to use "unsafe" just to declare a struct.  This is more similar to how yo=
u would
> use "..Default::default()" (which is also a possibility here, but arguabl=
y
> less efficient).
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/kernel/block/mq/gen_disk.rs |  8 +++++---
>  rust/kernel/block/mq/tag_set.rs  | 10 ++++++----
>  2 files changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_=
disk.rs
> index 708125dce96a..65342d065296 100644
> --- a/rust/kernel/block/mq/gen_disk.rs
> +++ b/rust/kernel/block/mq/gen_disk.rs
> @@ -6,7 +6,7 @@
>  //! C header: [`include/linux/blk_mq.h`](srctree/include/linux/blk_mq.h)
>
>  use crate::block::mq::{raw_writer::RawWriter, Operations, TagSet};
> -use crate::{bindings, error::from_err_ptr, error::Result, sync::Arc};
> +use crate::{bindings, error::from_err_ptr, error::Result, init::Zeroable=
, sync::Arc};
>  use crate::{error, static_lock_class};
>  use core::fmt::{self, Write};
>
> @@ -31,6 +31,9 @@ fn default() -> Self {
>      }
>  }
>
> +// SAFETY: `bindings::queue_limits` contains only fields that are valid =
when zeroed.
> +unsafe impl Zeroable for bindings::queue_limits {}
> +
>  impl GenDiskBuilder {
>      /// Create a new instance.
>      pub fn new() -> Self {
> @@ -93,8 +96,7 @@ pub fn build<T: Operations>(
>          name: fmt::Arguments<'_>,
>          tagset: Arc<TagSet<T>>,
>      ) -> Result<GenDisk<T>> {
> -        // SAFETY: `bindings::queue_limits` contain only fields that are=
 valid when zeroed.
> -        let mut lim: bindings::queue_limits =3D unsafe { core::mem::zero=
ed() };
> +        let mut lim: bindings::queue_limits =3D Zeroable::ZERO;
>
>          lim.logical_block_size =3D self.logical_block_size;
>          lim.physical_block_size =3D self.physical_block_size;
> diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_s=
et.rs
> index f9a1ca655a35..1ff7366ca549 100644
> --- a/rust/kernel/block/mq/tag_set.rs
> +++ b/rust/kernel/block/mq/tag_set.rs
> @@ -10,6 +10,7 @@
>      bindings,
>      block::mq::{operations::OperationsVTable, request::RequestDataWrappe=
r, Operations},
>      error,
> +    init::Zeroable,
>      prelude::PinInit,
>      try_pin_init,
>      types::Opaque,
> @@ -32,6 +33,10 @@ pub struct TagSet<T: Operations> {
>      _p: PhantomData<T>,
>  }
>
> +// SAFETY: `blk_mq_tag_set` only contains integers and pointers, which
> +// all are allowed to be 0.
> +unsafe impl Zeroable for bindings::blk_mq_tag_set {}

This will have to be reverted if we want to split up the kernel crate
due to the orphan rule.

Alice

