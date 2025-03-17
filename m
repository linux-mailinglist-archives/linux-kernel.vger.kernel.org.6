Return-Path: <linux-kernel+bounces-563871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CDFA649BC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED51E16A39C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141C023C375;
	Mon, 17 Mar 2025 10:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tbXy5sjp"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59A723BD02
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207061; cv=none; b=oFoYgJk6cAUBOpCjVEV1xCaSRHyQhLeYCCBaOc/OKSdr4pe6RfOr+5VRwhjxhfzaqwjMgfYprON86SKuu9tpPkIDtYxRimlf3lOXPamZdUx3Ft8HXsLz0NVq7fAGSY1YfaMdyEv/GLf/jPnTz499j+S+xBf/IaE3NjXItrZWyIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207061; c=relaxed/simple;
	bh=T0XmXTPHuSifmlk1GQv7S8pl94t1Wv6LlKDhlqctDvU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gQ+hAOyA9Pnr7NwHuUkc92v9jX0EOHaD9+/Q9l3+TEmvBCzYsmJl1/FbWLRIVTe62SVrAuoClxPhUuyjrtJWDyB67JW2HUqDG6NFYCL99qXFBQZ2vojeLDX+Ie6wdf3hLNKVsXellX5NEzYgbFgpeXV1qZlIhrx76xS6SPkKXok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tbXy5sjp; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43cf327e9a2so15560595e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742207058; x=1742811858; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8K4Jrr2cHn05wONB/FH2XsdIcr9ioXUuaymWvPlQBPA=;
        b=tbXy5sjpD4pVnpMxCVw579Xj25M68VmTzxLgZ1bUIeaZUY+7lP4u+agcaQiT4EVeY+
         9x7FOKFggZLY8zNqTP3m4bVZZ6Hp2O4jZ6DTyqnFaTKbk/4fzfbE16drDXycgHYQpFqY
         REr2ifWo5mf4NjrpUT04rSbE2N+/SlEZFlNefEjtK3VR72Oa2D+hyKmbk9VzBdtMwGHS
         vjwElyx4Zl6qvNzxPTrvR7s9dqptYh5EKosbIBCET5tYlGeR2rPeP/kUQudM/swbbdpk
         PWUwy4tj4vHkqLsP8qd5I9hdi+U0H/wLuh0jTV/VihUkj4RQD3vZf11Bqg1eAgyJd18X
         8z8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742207058; x=1742811858;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8K4Jrr2cHn05wONB/FH2XsdIcr9ioXUuaymWvPlQBPA=;
        b=cmVO1ifOtTtf5Y9W9XINmueX5mwx9RJb9pHbLIQaTqCVSHd/K2UFgi/3/YbhGY7x4t
         6kH/UWCdAGvgP91nYLV/RtOsO2gHsPZrnNlnlUrzi5OJ3tCDZ6tvZkV+NJFBLChYuNzZ
         PK3rXZ2zUR7nnZiRo+64/9NixYz7V0QVSpSGfm5p2WG/DqiSJQvJOa8XgNF9S1d+7zw0
         Ge55LGJzVAJrptlewV2zW7p+UTg+bOdiK4u6NQqeTpL7Zj59Ne/C69H6jhCSBSS/Tloc
         Y2do1ZXIPM2ebsaK0aPYDQCbiuDNOWzRQxKH3p0FC7gpNAOOtKMSSwwIKeOcdyEXwt1X
         zN+w==
X-Forwarded-Encrypted: i=1; AJvYcCXicx2HW0BYmOO73flm5Snqxbkc6sdLA004mEcw9ggZhas43Axu15G7dynIOsSb2Gq3yKTUiATp3n5xvaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxge1jJNHI9Yu+4+sQKS77SzgkQc5/5l4DYjWu8bv1YaIMJJXZd
	p9kXIKzFK5EioiqOWf+8w1Ze+jJ9bCo6iKUS5FmBmo3/YeQGpdBspM2S4mWyQWU1l00EJYMWcm+
	cnDE1U+WIW6joUw==
X-Google-Smtp-Source: AGHT+IGHM9Im2dqX3gfz0NV8cc0x3CfI4wJk+09faVb93t75tZtSx537hGUim5yDjXgoSpEfdSGA14kssfoPG70=
X-Received: from wmgg6.prod.google.com ([2002:a05:600d:6:b0:43b:c450:ea70])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b0a:b0:43c:f969:13c2 with SMTP id 5b1f17b1804b1-43d1ece13a4mr114040775e9.28.1742207058149;
 Mon, 17 Mar 2025 03:24:18 -0700 (PDT)
Date: Mon, 17 Mar 2025 10:24:15 +0000
In-Reply-To: <20250317023702.2360726-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250317023702.2360726-1-kunwu.chan@linux.dev>
Message-ID: <Z9f4Twvl-UaX1NQp@google.com>
Subject: Re: [PATCH v2] rust: file: optimize rust symbol generation for FileDescriptorReservation
From: Alice Ryhl <aliceryhl@google.com>
To: Kunwu Chan <kunwu.chan@linux.dev>, Christian Brauner <brauner@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Kunwu Chan <kunwu.chan@hotmail.com>, 
	Grace Deng <Grace.Deng006@gmail.com>
Content-Type: text/plain; charset="utf-8"

Adding Christian Brauner who originally merged the
rust/kernel/fs/file.rs file.

On Mon, Mar 17, 2025 at 10:37:02AM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <kunwu.chan@hotmail.com>
> 
> When build the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
> with ARCH=arm64, the following symbols are generated:
> 
> $ nm vmlinux | grep ' _R'.*FileDescriptorReservation | rustfilt
> ... T <kernel::fs::file::FileDescriptorReservation>::fd_install
> ... T <kernel::fs::file::FileDescriptorReservation>::get_unused_fd_flags
> ... T <kernel::fs::file::FileDescriptorReservation as core::ops::drop::Drop>::drop
> 
> These Rust symbols are trivial wrappers around the C functions
> fd_install, put_unused_fd and put_task_struct. It
> doesn't make sense to go through a trivial wrapper for these
> functions, so mark them inline.
> 
> Link: https://github.com/Rust-for-Linux/linux/issues/1145
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Co-developed-by: Grace Deng <Grace.Deng006@Gmail.com>
> Signed-off-by: Grace Deng <Grace.Deng006@Gmail.com>
> Signed-off-by: Kunwu Chan <kunwu.chan@hotmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

