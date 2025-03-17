Return-Path: <linux-kernel+bounces-563882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A31A649D7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17C2816C930
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AB722F155;
	Mon, 17 Mar 2025 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CzKNJU91"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F06219A67
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207363; cv=none; b=qJd3qCoxHcuOb8rx3wUFblIs5zVMp8TMUR6Oct25ITIXcJd7ZTPmMt4IeHLoaHR+zp/lCPqWqwSh689jRmYWEfCyZ9BcTe3W7Ed4EmxehA06p8hegJe9WoAAVR8zKA3VYNE4AX2wIAfCXrH+xKI1OiidVHqen4M8tr2G8K33jAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207363; c=relaxed/simple;
	bh=BmHlcVeyDTGath6xJ5BkH3jTeyFsKHcpnCcAQlKKzB0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=euPj7rGATezTs/sQFMatmvq2i6KjRhMwc/riOgsebMrzM025pJBZf0/enXagWKC6sYB9/vXgkbmSHdzPQfnU8Q5Ng0CWfhtUepUFsXmsZxoIvuzhBYBPH/1V8WMBybrmLjp4ex9Ho9tNk+YM0ESqPUdLOzVmXGLkCladMdXhl9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CzKNJU91; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-438da39bb69so15961585e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742207360; x=1742812160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yZNMaIMiKoZDo5cQ6GyfS8+tsfIDXP/+Z/RHe17Imqk=;
        b=CzKNJU91Ku7SQqzYR9j+CnBmPiR213fxwdeYYnpiCP2UJq1XATNMMqp114S55tLZCK
         FYgu856YDGjuiJXK3UOfgcpaOWQqLBONd6PjeZHTkm75xIOJvpJH8mDDebGiUrWLJci1
         bOeb1sdiJWLiw+G8kwpSrWM+gEVL9sgBCnnNauZE0kYob//9LzYJRKbA6TwFsmcy4n+w
         w8Blc0GWXkRvlXMRKaYvrnzN/3H+kicsYFPsgyOq8CgH4QMV7tHds4QuogkXb0B/vw6R
         +sbffl3QwUmTtGUQOjCO0KTTk1FB0HA1Be+1SNLfRFS0W/APSs7jhc8jMTTiHjlGWXBR
         dDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742207360; x=1742812160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yZNMaIMiKoZDo5cQ6GyfS8+tsfIDXP/+Z/RHe17Imqk=;
        b=cVNdbLCA8cTsWMD76unJ0YCsyvqE5adZHV9d/4g8qm5u+/nrWtDKa7kmYWkw5WDWKJ
         yZH7FxkiwR+Qm38GcL/FVGgUtdZofrsMwWl5ToxdPwoP0Q0mIJU84ALN5L3NGwVPTt1S
         uKJ6A1rHL8luKss0GACvXHbVoWWd1wZZSVldglW3Y/QVxdricvHai5ERw0O6fT484isu
         6v+vXA+Xlbq0sJLwBB6d8a7mMVSIkzAAEhowcy0SKVYAIRAPiZJK+vVK2eGSw7i4kKJl
         ygyrOi1GflqiXJ+F4rq1XZRAk+sAJq/BTLyVMUyo4Cg+K6vkdl+zRmrjjONjumK8H4qc
         ifmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoxmqk56sjAN029ATk0olKGO65DjBdIkFunSHxd2Jgc3IaR64fnige0ZUngnqhFQbYEA9IwM8j+k8sh/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXInoa6Wtnc+BAkG7FCvAMOSRMTlb5oial8yMIA53stCMuoyqP
	feymwOUYbd2jB4SPNUF7VZDyTKaNcJabSN19GzeXQFExtf1RaCJQOst5wpihZX8L0TAYIyLx7zo
	3q2x19jocOEaDOQ==
X-Google-Smtp-Source: AGHT+IFN0mg3rfLnL9s+jfrXP1fPxsq6jKqq7a5CxuQ9zdvV/QwOOR7cfyj2a84t+UVdZyooaIvYicO+MWpTJRI=
X-Received: from wmbfs18.prod.google.com ([2002:a05:600c:3f92:b0:43c:e51c:1a5a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b84:b0:43c:fcb1:528a with SMTP id 5b1f17b1804b1-43d1ec622c1mr109294525e9.6.1742207359884;
 Mon, 17 Mar 2025 03:29:19 -0700 (PDT)
Date: Mon, 17 Mar 2025 10:29:17 +0000
In-Reply-To: <20250317081351.2503049-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250317081351.2503049-1-kunwu.chan@linux.dev>
Message-ID: <Z9f5fehO186xoNAV@google.com>
Subject: Re: [PATCH] rust: sync: optimize rust symbol generation for CondVar
From: Alice Ryhl <aliceryhl@google.com>
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Kunwu Chan <kunwu.chan@hotmail.com>, 
	Grace Deng <Grace.Deng006@gmail.com>
Content-Type: text/plain; charset="utf-8"

On Mon, Mar 17, 2025 at 04:13:50PM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <kunwu.chan@hotmail.com>
> 
> When build the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
> with ARCH=arm64, the following symbols are generated:
> 
> $nm vmlinux | grep ' _R'.*CondVar | rustfilt
> ... T <kernel::sync::condvar::CondVar>::notify_all
> ... T <kernel::sync::condvar::CondVar>::notify_one
> ... T <kernel::sync::condvar::CondVar>::notify_sync
> ... T <kernel::sync::condvar::CondVar>::new::{closure#0}::{closure#0}::panic_cold_explicit
> ... T <kernel::sync::condvar::CondVar>::new::{closure#0}::{closure#0}::panic_cold_explicit
> ... T <kernel::sync::poll::PollCondVar>::new::{closure#0}::{closure#0}::panic_cold_explicit
> ... T <kernel::sync::poll::PollCondVar as core::ops::drop::Drop>::drop
> 
> These notify* symbols are trivial wrappers around the C functions
> __wake_up and __wake_up_sync.
> It doesn't make sense to go through a trivial wrapper for these
> functions, so mark them inline.

You don't need to send a new version just for this, but please format
the paragraphs better in the future. For example:

The notify* symbols are trivial wrappers around the C functions
__wake_up and __wake_up_sync. It doesn't make sense to go through a
trivial wrapper for these functions, so mark them inline.

> Link: https://github.com/Rust-for-Linux/linux/issues/1145
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Co-developed-by: Grace Deng <Grace.Deng006@Gmail.com>
> Signed-off-by: Grace Deng <Grace.Deng006@Gmail.com>
> Signed-off-by: Kunwu Chan <kunwu.chan@hotmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>


