Return-Path: <linux-kernel+bounces-357359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B667D997052
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9151F23C02
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D171F7072;
	Wed,  9 Oct 2024 15:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irG0skcj"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1C91E1A0F;
	Wed,  9 Oct 2024 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488233; cv=none; b=i6w6hYAXV3pJWnoq+5OY8C59LruUgpKrNwuR5AE2g2F1FuKGGx84uZblTtzI8o2KNaIVFrvhAW62f91yOcgZbZ5pD02F36zWga2NbgusHE/U2lr/+3QnPVQkCHMDjnBTxX2cxnWML1V0+j3dNwJ2yPWXHwJzCIv4VvToJjWNK8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488233; c=relaxed/simple;
	bh=P8MGz3LNk2Y0603knKpYlKyHn7VnI3x9yNJiXnRYrQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kQSeuKSsRy/mFeoQg2WExlcfZi9+rK9wowa/69LSRD93ciZwB+emPVhjKPqGSD64s+4TgVvdvh4Fv/gvZbZ02YCLVbAhhT5GuUqAwzGt3CLOCBIrPMKaKZdVniWYZis+DpREU3zLx18EhE0daQ75Qc2OiLi1kh5A8qSLtr2U8NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irG0skcj; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fad100dd9fso103167801fa.3;
        Wed, 09 Oct 2024 08:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728488230; x=1729093030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AYVkpM4Dea0jgBbEaWFly3uGZzFTEnbuSisXaR4H3ms=;
        b=irG0skcj/cX/ermCTpOa1KQtpxICF2hmoLS+VwfE/qfL5BfqXQVQpiOBEMRG+1Trlx
         dFNz0xEU/e/VcNGZU60HvfykVCL1HklsGTitNjUpPAg77N/Rxk6hhD389DB22DCACnja
         8OhH5NI66GLWJPq1EPEOjOXn7MuSrbrEN04IK+HQbTW8LonlFYG8NnRbABnKEUpmHGKf
         HURNtu4I8uypEBrBSc7aXwamFeumEEbOJ0hryi9b598JHbtUrqgjbQDm7n3J+iSZHysm
         khfPK/GOW7wboYjzSn/OqekiyW8XyP+ZxuFCo9tmhqPw5bJiR5Z53kTodeGC+xh7uT2q
         TncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728488230; x=1729093030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AYVkpM4Dea0jgBbEaWFly3uGZzFTEnbuSisXaR4H3ms=;
        b=hAsufuQd+ckgLmlu6SzDm5BHWca6iS3K2A1+WsXl26zSvTAavHlzRoF/pQOz5REqUi
         jGYNLNJHeD1b1w1SXPBxrTy3SBFShXR8qsWCcz41XeTPW8fVETseREDi4Du7X942vVaV
         vD0FKK+KN/hRrzo0ROqtlEC0hoXMIQXyYP92qVkxQbhxO2hqQCzINAi21NwSKdhqTvgQ
         q/CBIxzfg+9E++UiwH1oQ/hl5jmAlk5Ags3HZW5SEaw/bjIfolz2eChpKFUAwOeXU1i3
         iB8HsbkjrbPlXeZiMQpMAblkB8/ckMJz7TOVlXdYUTQ8jyn9om8dD4i57p0lEUEQwBwl
         o0sg==
X-Forwarded-Encrypted: i=1; AJvYcCUamL+ogVFUL3FnznF+b1shMMQHTwjqF/uyh30KRTimZPhz1c8Sfq02tO/FBbO2MELgf0/NNeM3TsjjCzA=@vger.kernel.org, AJvYcCV7CRksQgDWmZX4IG/61H1PVQaHTTvaPYmBkKoYEZPtleyvyjAsTGM5oPXEZrEgrgA/pn7WHj65tLhDmsT8RDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YypBQV82qDs1NEmc1iRI1rzBHED23gu9fLlHG8aEvnEJCcqT0WB
	3QMZFuBgO0sgUFm5z/3bVC/ZpBZ/6H9cD7VPm2HQ64olXutmIw2l0Cp76he4
X-Google-Smtp-Source: AGHT+IEo6/STpMGFOZfGqqWMK0ZXaIxkpaXfgffldN4wmrC5hAQNrkh14ZeNCjibF3DfKe2CC2j9Zg==
X-Received: by 2002:a05:6512:1113:b0:538:9e36:7b6a with SMTP id 2adb3069b0e04-539c48e335amr2771586e87.32.1728488229764;
        Wed, 09 Oct 2024 08:37:09 -0700 (PDT)
Received: from ?IPV6:2003:df:bf2f:2200:1a63:5a2f:b369:2dac? (p200300dfbf2f22001a635a2fb3692dac.dip0.t-ipconnect.de. [2003:df:bf2f:2200:1a63:5a2f:b369:2dac])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a996274deeesm316411966b.103.2024.10.09.08.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 08:37:09 -0700 (PDT)
Message-ID: <813594ff-b167-4ae2-8105-e2f958ec2cc7@gmail.com>
Date: Wed, 9 Oct 2024 17:37:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: remove unnecessary #includes
To: Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org
Cc: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Dirk Behme <dirk.behme@de.bosch.com>,
 Filipe Xavier <felipe_life@live.com>, linux-kernel@vger.kernel.org
References: <20241009151017.26685-1-tamird@gmail.com>
Content-Language: de-AT-frami
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <20241009151017.26685-1-tamird@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 09.10.24 um 17:09 schrieb Tamir Duberstein:
> Commit e26fa546042a ("rust: kbuild: auto generate helper exports")
> removed the need for these by automatically generating the exports; it
> removed the explicit uses of EXPORT_SYMBOL_GPL but didn't remove the
> header includes.


I was about to send the same patch. You have been faster. Thanks! :)

Two nits:

* Theoretically the grammer fix in exports.c could go into an 
independent patch. But if not it at least should be mentioned in the 
commit message. Let Miguel decide if he wants an extra patch or not ;)

* Maybe a

Fixes: e26fa546042a ("rust: kbuild: auto generate helper exports")

tag could be added? Even though Miguel might route it through 
rust-next as its not urgent for routing through rust-fixes.

Anyhow, regarding the main change:

Reviewed-by: Dirk Behme <dirk.behme@gmail.com>


> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>   rust/exports.c           | 6 +++---
>   rust/helpers/build_bug.c | 1 -
>   rust/helpers/err.c       | 1 -
>   rust/helpers/kunit.c     | 1 -
>   rust/helpers/mutex.c     | 1 -
>   rust/helpers/refcount.c  | 1 -
>   rust/helpers/signal.c    | 1 -
>   rust/helpers/spinlock.c  | 1 -
>   rust/helpers/task.c      | 1 -
>   rust/helpers/wait.c      | 1 -
>   rust/helpers/workqueue.c | 1 -
>   11 files changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/rust/exports.c b/rust/exports.c
> index e5695f3b45b7..fd278e272751 100644
> --- a/rust/exports.c
> +++ b/rust/exports.c
> @@ -3,9 +3,9 @@
>    * A hack to export Rust symbols for loadable modules without having to redo
>    * the entire `include/linux/export.h` logic in Rust.
>    *
> - * This requires the Rust's new/future `v0` mangling scheme because the default
> - * one ("legacy") uses invalid characters for C identifiers (thus we cannot use
> - * the `EXPORT_SYMBOL_*` macros).
> + * This requires Rust's new/future `v0` mangling scheme because the default one
> + * ("legacy") uses invalid characters for C identifiers (thus we cannot use the
> + * `EXPORT_SYMBOL_*` macros).
>    *
>    * All symbols are exported as GPL-only to guarantee no GPL-only feature is
>    * accidentally exposed.
> diff --git a/rust/helpers/build_bug.c b/rust/helpers/build_bug.c
> index e994f7b5928c..44e579488037 100644
> --- a/rust/helpers/build_bug.c
> +++ b/rust/helpers/build_bug.c
> @@ -1,6 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
> -#include <linux/export.h>
>   #include <linux/errname.h>
>   
>   const char *rust_helper_errname(int err)
> diff --git a/rust/helpers/err.c b/rust/helpers/err.c
> index be3d45ef78a2..544c7cb86632 100644
> --- a/rust/helpers/err.c
> +++ b/rust/helpers/err.c
> @@ -1,7 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
>   #include <linux/err.h>
> -#include <linux/export.h>
>   
>   __force void *rust_helper_ERR_PTR(long err)
>   {
> diff --git a/rust/helpers/kunit.c b/rust/helpers/kunit.c
> index 9d725067eb3b..b85a4d394c11 100644
> --- a/rust/helpers/kunit.c
> +++ b/rust/helpers/kunit.c
> @@ -1,7 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
>   #include <kunit/test-bug.h>
> -#include <linux/export.h>
>   
>   struct kunit *rust_helper_kunit_get_current_test(void)
>   {
> diff --git a/rust/helpers/mutex.c b/rust/helpers/mutex.c
> index a17ca8cdb50c..7e00680958ef 100644
> --- a/rust/helpers/mutex.c
> +++ b/rust/helpers/mutex.c
> @@ -1,6 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
> -#include <linux/export.h>
>   #include <linux/mutex.h>
>   
>   void rust_helper_mutex_lock(struct mutex *lock)
> diff --git a/rust/helpers/refcount.c b/rust/helpers/refcount.c
> index f47afc148ec3..d6adbd2e45a1 100644
> --- a/rust/helpers/refcount.c
> +++ b/rust/helpers/refcount.c
> @@ -1,6 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
> -#include <linux/export.h>
>   #include <linux/refcount.h>
>   
>   refcount_t rust_helper_REFCOUNT_INIT(int n)
> diff --git a/rust/helpers/signal.c b/rust/helpers/signal.c
> index 63c407f80c26..1a6bbe9438e2 100644
> --- a/rust/helpers/signal.c
> +++ b/rust/helpers/signal.c
> @@ -1,6 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
> -#include <linux/export.h>
>   #include <linux/sched/signal.h>
>   
>   int rust_helper_signal_pending(struct task_struct *t)
> diff --git a/rust/helpers/spinlock.c b/rust/helpers/spinlock.c
> index 775ed4d549ae..b7b0945e8b3c 100644
> --- a/rust/helpers/spinlock.c
> +++ b/rust/helpers/spinlock.c
> @@ -1,6 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
> -#include <linux/export.h>
>   #include <linux/spinlock.h>
>   
>   void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
> diff --git a/rust/helpers/task.c b/rust/helpers/task.c
> index 7ac789232d11..190fdb2c8e2f 100644
> --- a/rust/helpers/task.c
> +++ b/rust/helpers/task.c
> @@ -1,6 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
> -#include <linux/export.h>
>   #include <linux/sched/task.h>
>   
>   struct task_struct *rust_helper_get_current(void)
> diff --git a/rust/helpers/wait.c b/rust/helpers/wait.c
> index c7336bbf2750..ae48e33d9da3 100644
> --- a/rust/helpers/wait.c
> +++ b/rust/helpers/wait.c
> @@ -1,6 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
> -#include <linux/export.h>
>   #include <linux/wait.h>
>   
>   void rust_helper_init_wait(struct wait_queue_entry *wq_entry)
> diff --git a/rust/helpers/workqueue.c b/rust/helpers/workqueue.c
> index f59427acc323..b2b82753509b 100644
> --- a/rust/helpers/workqueue.c
> +++ b/rust/helpers/workqueue.c
> @@ -1,6 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
> -#include <linux/export.h>
>   #include <linux/workqueue.h>
>   
>   void rust_helper_init_work_with_key(struct work_struct *work, work_func_t func,


