Return-Path: <linux-kernel+bounces-387076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB429B4B96
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA96283756
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAEE206E6D;
	Tue, 29 Oct 2024 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s/1PBN+O"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC634204956
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730210369; cv=none; b=maQdHjYiS1VHtYv0cyQcct9LCejoWXThiFlt9PdzPhvi/WUaJFLrpt3JJ1rXg16UD75C7Isvxt8HNSiOML4u1L3qPml/zZZXUrIfpJuFRL/DvSP1oMyjX5DcbCzF76q/OLKPPCtFcUCXeD5W6A5xH8hTKAx3w8+9EiKOZZUwHb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730210369; c=relaxed/simple;
	bh=HWBADJXnoh2NUNrdZ4R8VuuNYl1bmNxvyx9KhUtUxEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvQXxFF3fGhkXwpd5h7H28MATojfb3n76iIb9v4D31CVEFN4pkLvv5FyqM4anCJ8PIKNpMIAva+t5ddHN7OL3EQpffKBJN8dIs36rifLqqxFgOpjR8hMxJ1E1pe7yg4Tv7ZRGFydVzZVHHKwnpA1iemnte/nWrkghC9TCwqu4UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s/1PBN+O; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3807dd08cfcso1294984f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 06:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730210364; x=1730815164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0+r5DXauPWMBo80TC003d10oYhw7X04leDKPh0fruY=;
        b=s/1PBN+O4ssMce33ShcFRDVxgnF0bzyFMTPkXBQD+CHNpuVcPuUuWVIeFbSTQ2RKAX
         SzyfVCwgP9Gr6Pg6PF4WkcbBPDkpqXzHpLIp+XaOAZKHslD9yMLSO8njq8gWrrtDp20b
         FJBYhxAFMCe6o1QLNfDMRgaa51ritTL6O1Exth+2EPQ75ob8OOZ39+RqdTFbpYWkXjsv
         ZSMABo/ZMKJ4IFg+lSI2eA6UqEQQr2UI6VrBgva2iMmHufjp57xL/PCEJz4jkhV1HKFE
         5F4IVQrn3D0tk7wvtLul1Cti40IuvA1GDUxOTxTDsuBu0cdPxSfHiCAT3PZ6BvJNCBS0
         I59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730210364; x=1730815164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0+r5DXauPWMBo80TC003d10oYhw7X04leDKPh0fruY=;
        b=gjpRhHESqqODEnF3DbLPfMBz5QIhDZ3jLFDhjqmRengiFr6fllNaoola0hOkHGeDTi
         ro8IhG6CZB3pT1wUvMQPhVyj8UndNGG7IgxdnbwA7g9VU3ryHEjlgFAFS5pf390RM2zF
         Xn//qDic9um+Psy1Tsq8zW9XCasKRv2O6euXKb/mhQUbYhiTJTxAZMawjZaWFBBUs1pO
         0DaiqHMT7SjyRAG5zI7lpRQIuSfkQ44KhAAZh/WWC4l8wcLIa7GhonawTHP6JeH5OKNM
         bd3Rcy7P7OKK0wAH+Q0Fb9/gWKnBbK9w+yO02WNpGKDPe4LcIIHCyO9UT6DLij1QqUVb
         PXlw==
X-Forwarded-Encrypted: i=1; AJvYcCXeFOWEXBYnR1NfnLp5a/n+I6RcvO5z+oYp26i5/+Gd0O/QfGXbpK0foV2fWbIk7dN/vV/ms2i+cVwydjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV6ZZ33E+qt0fDotI48PjlJWXr0CQvrIhppEBTdX3D4Qw0S3XQ
	Q6fZVzc0acYPtkhen41AzUXCaQ709M98X7CLosAwRi1jENsnFnzkrnuLomsjX0U85iYGLr+jjxc
	zSQ9a+rJN4RAi/D1NWWdL308Ed1OeLL3+RGJu
X-Google-Smtp-Source: AGHT+IHKguE544j9cYCAx/GnN3x2cBIU4yFs+FD0nSAsUtdOZzL/B0VKKdtS72gv2gH4vafJAmdHPLNGHnEY0QP/rKg=
X-Received: by 2002:a5d:56d2:0:b0:37e:f4a1:2b58 with SMTP id
 ffacd0b85a97d-38061172aa9mr11280347f8f.16.1730210364034; Tue, 29 Oct 2024
 06:59:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022213221.2383-1-dakr@kernel.org> <20241022213221.2383-7-dakr@kernel.org>
In-Reply-To: <20241022213221.2383-7-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 29 Oct 2024 14:59:10 +0100
Message-ID: <CAH5fLgji5SozS2Y+G16pPS3iiKnee-p94xO+uZZykTd_7EBOpQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/16] rust: add rcu abstraction
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	tmgross@umich.edu, a.hindborg@samsung.com, airlied@gmail.com, 
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	Wedson Almeida Filho <wedsonaf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 11:33=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
>
> Add a simple abstraction to guard critical code sections with an rcu
> read lock.
>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>  rust/helpers/helpers.c  |  1 +
>  rust/helpers/rcu.c      | 13 +++++++++++
>  rust/kernel/sync.rs     |  1 +
>  rust/kernel/sync/rcu.rs | 52 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 67 insertions(+)
>  create mode 100644 rust/helpers/rcu.c
>  create mode 100644 rust/kernel/sync/rcu.rs
>
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 20a0c69d5cc7..0720debccdd4 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -16,6 +16,7 @@
>  #include "mutex.c"
>  #include "page.c"
>  #include "rbtree.c"
> +#include "rcu.c"
>  #include "refcount.c"
>  #include "signal.c"
>  #include "slab.c"
> diff --git a/rust/helpers/rcu.c b/rust/helpers/rcu.c
> new file mode 100644
> index 000000000000..f1cec6583513
> --- /dev/null
> +++ b/rust/helpers/rcu.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/rcupdate.h>
> +
> +void rust_helper_rcu_read_lock(void)
> +{
> +       rcu_read_lock();
> +}
> +
> +void rust_helper_rcu_read_unlock(void)
> +{
> +       rcu_read_unlock();
> +}
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 0ab20975a3b5..1806767359fe 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -11,6 +11,7 @@
>  mod condvar;
>  pub mod lock;
>  mod locked_by;
> +pub mod rcu;
>
>  pub use arc::{Arc, ArcBorrow, UniqueArc};
>  pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
> diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
> new file mode 100644
> index 000000000000..5a35495f69a4
> --- /dev/null
> +++ b/rust/kernel/sync/rcu.rs
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! RCU support.
> +//!
> +//! C header: [`include/linux/rcupdate.h`](srctree/include/linux/rcupdat=
e.h)
> +
> +use crate::bindings;
> +use core::marker::PhantomData;
> +
> +/// Evidence that the RCU read side lock is held on the current thread/C=
PU.
> +///
> +/// The type is explicitly not `Send` because this property is per-threa=
d/CPU.
> +///
> +/// # Invariants
> +///
> +/// The RCU read side lock is actually held while instances of this guar=
d exist.
> +pub struct Guard {
> +    _not_send: PhantomData<*mut ()>,

Once 6.13 is released, you'll want to use NotThreadSafe here instead
of PhantomData. It's landing upstream through vfs.rust.file.

Alice

