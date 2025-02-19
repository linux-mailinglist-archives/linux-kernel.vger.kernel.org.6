Return-Path: <linux-kernel+bounces-522028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C51BA3C509
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3738C1744A0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ED21FE473;
	Wed, 19 Feb 2025 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fYQ5Ev10"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E451FE443
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982542; cv=none; b=Rc8x9WL5MFlKSTE9gyaEVahTbNvsHy9DHZWfhRL/jHd1PAeYeqJvKmrzLL2+A6vF4mS9rphhX8BlGxR7UbZUJ9MxLaT3gq5XxJ1t/63jp0asjrSSttrrsgkRpLPiRZqNd9WZ/HxLeOHV/pC9NNqD7Qf/6nmaxHwrT+CqPgiamIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982542; c=relaxed/simple;
	bh=emJwioSET82ma5wk2Wj8pD4x+CUD8+IT98gNrkXVzjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8dWNBzl4WuILxQEI6h4IBL/AuSBjQx1AjCcnrsaGWtLAVQGg74pEJxKj250Qqr0a+Wf8pI8IppJbiTvuqtMPk8oEIeOk4Ic93M2GhCFdQ55sIagmPHuTwNOUbOkffm9tFkRU41b85YzCb4GTxmG6I5VyQOfDsRIj8KWjSY/Ljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fYQ5Ev10; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f3ac22948so2182366f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739982538; x=1740587338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFRbR48ppuOSqbaCOW7HIqpzgud5csABpIpz146ytiI=;
        b=fYQ5Ev10eVsP5Sr2D1seGuqe7mqlEQO7yz/XkdDL0J4XsrXEBuNY7WQMi4UQdTQSlX
         Kt9r2AaoC0DPd2e8BQOkWbIy9Ax2y7ln2U6SXa/sO1Ct3UJbKaXdXjvtNUkx2D7O+MAD
         5uS8SXF6WS+Osy1Cbo9RSgbQFRwEOLUYIgROHCXsZmJqFJpOnS2KX3yBYXcM2J1VtiN0
         aJatPAfA2bk7u7FikJYyWScnjf/EWWmsUEKPzoMHaNjq7llzdj2sPxZU6J8ObQsJrJ0l
         Z7MRFAZAC0YHVB/+EtYfLAt+1ow6+uL5sijFRWLa0VYsTdgs1Gi27hoTKuxLfcJtxfJn
         JjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739982538; x=1740587338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFRbR48ppuOSqbaCOW7HIqpzgud5csABpIpz146ytiI=;
        b=fhvzn7wmsiL2hDcQPD75QS9CcYGeThv1ZHVQEKlxcBqZdUNWmZLUbfBsu8/43qC8uu
         j9VFWc90EQfeuzIVvOqaa4mmhQtIbbR6TT+CTRg8fZsf0nGG+7TOgzS8tJrAda/mtY9v
         TUFmcm9GtVi7g4r6K7K9/zWCiXi4pn0wtrmU3SS7uP1y6uiWbHOmZR9iEi8UY1Bme9bq
         YDxObAOt+VmykDOPEUMo0tahRMh8oPxUpLF9mpMOFJ1RE6rvF7x8udRTQnkezdfT6Mg6
         NUfSxwFP+oLwBUi1jq+B0j4Fv23cuwcyaZG0mx9EneRzu27V/8mz3BM9WHmZvzxHzAyV
         H+eA==
X-Forwarded-Encrypted: i=1; AJvYcCUNbYE9JO6z4UL60PIT8Yq+tY2XV5geOw3CanyGTSqR6UIoFwrEJHUWf7cLj9TYk71DZfVKOExQboLyP7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjE4Y55/CMcM7oy6vznMd903BXogd42aNlxqg+xbbqVk/+Yav1
	DjgrcSxeCYnHGitw3NvYyawWi06vaBsKiiB9akMnjgm9QMve0jTD8M2t1jWeFekCYGZPvb4cQlL
	0mKMBpWNGLB2EyNAEovT0cqPlplv2XA2WG+wL
X-Gm-Gg: ASbGncusCWJEXmTUX5k9urhSufBN+8V2Zp8a7Jrj+7QosuIgxECSioTRDHR4KWkixAA
	6nc3NBRYfIXzT8QAz99JEsSyBAp6EleYWFRknp92/RY3ekGjFGvhkRPgVLR2b4fv1AwuR+BDYZ4
	Hw1j6xwQPmH918s1uA2SWoq5V1
X-Google-Smtp-Source: AGHT+IG495bFTbE1P6h3BVXkY4LEgL34rIWGX80Z/ZM6WtwUQeIReUc06KCZ2SrkFKNMU2/Qx08kXHZdYYzMqhAy6s8=
X-Received: by 2002:a5d:5888:0:b0:38f:27d3:1b3b with SMTP id
 ffacd0b85a97d-38f33f11925mr15697927f8f.11.1739982538436; Wed, 19 Feb 2025
 08:28:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219162517.278362-1-daniel.almeida@collabora.com>
In-Reply-To: <20250219162517.278362-1-daniel.almeida@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 19 Feb 2025 16:28:46 +0000
X-Gm-Features: AWEUYZnQJ9lIBvSmKT_baEuG0BJNmNaSDuOffAsZaEl1gqpYyNt5U2oDUDBg0Fw
Message-ID: <CAH5fLgiErvnziU-hSCV6djNq7Q56ZfX9gZudmX7+r06hWoX0Tw@mail.gmail.com>
Subject: Re: [PATCH] rust: regulator: add a bare minimum regulator abstraction
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, sebastian.reichel@collabora.com, 
	sjoerd.simons@collabora.co.uk, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	a.hindborg@kernel.org, benno.lossin@proton.me, tmgross@umich.edu, 
	dakr@kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 4:26=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> Add a bare minimum regulator abstraction to be used by Rust drivers.
> This abstraction adds a small subset of the regulator API, which is
> thought to be sufficient for the drivers we have now.
>
> Regulators provide the power needed by many hardware blocks and thus are
> likely to be needed by a lot of drivers.
>
> It was tested on rk3588, where it was used to power up the "mali"
> regulator in order to power up the GPU.
>
> Note that each instance of [`Regulator`] obtained from
> `Regulator::get()` can only be enabled once. This ensures that the calls
> to enable and disable are perfectly balanced before `regulator_put()` is
> called, as mandated by the C API.
>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> ---
>  rust/bindings/bindings_helper.h |   1 +
>  rust/kernel/lib.rs              |   2 +
>  rust/kernel/regulator.rs        | 120 ++++++++++++++++++++++++++++++++
>  3 files changed, 123 insertions(+)
>  create mode 100644 rust/kernel/regulator.rs
>
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 55354e4dec14..92504f19655e 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -28,6 +28,7 @@
>  #include <linux/poll.h>
>  #include <linux/property.h>
>  #include <linux/refcount.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/sched.h>
>  #include <linux/security.h>
>  #include <linux/slab.h>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 496ed32b0911..0224f4c248c0 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -68,6 +68,8 @@
>  pub mod prelude;
>  pub mod print;
>  pub mod rbtree;
> +#[cfg(CONFIG_REGULATOR)]
> +pub mod regulator;
>  pub mod revocable;
>  pub mod security;
>  pub mod seq_file;
> diff --git a/rust/kernel/regulator.rs b/rust/kernel/regulator.rs
> new file mode 100644
> index 000000000000..df6eb325d11a
> --- /dev/null
> +++ b/rust/kernel/regulator.rs
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Regulator abstractions.
> +//!
> +//! C header: [`include/linux/regulator/consumer.h`](srctree/include/lin=
ux/regulator/consumer.h)
> +
> +use crate::{
> +    bindings,
> +    device::Device,
> +    error::{from_err_ptr, to_result, Result},
> +    prelude::*,
> +};
> +
> +use core::ptr::NonNull;
> +
> +/// A `struct regulator` abstraction.
> +///
> +/// Note that each instance of [`Regulator`] obtained from `Regulator::g=
et()`
> +/// can only be enabled once. This ensures that the calls to enable and =
disable
> +/// are perfectly balanced before `regulator_put()` is called, as mandat=
ed by
> +/// the C API.
> +///
> +/// # Invariants
> +///
> +/// - [`Regulator`] is a non-null wrapper over a pointer to a `struct re=
gulator`
> +///   obtained from `regulator_get()`.
> +/// - Each instance of [`Regulator`] obtained from `Regulator::get()` ca=
n only
> +///   be enabled once.
> +pub struct Regulator {
> +    inner: NonNull<bindings::regulator>,
> +    enabled: bool,
> +}

I wonder if enabled vs disabled should be two different types?

Alice

