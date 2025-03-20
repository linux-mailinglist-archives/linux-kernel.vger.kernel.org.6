Return-Path: <linux-kernel+bounces-569338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D80A6A19D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E953D3AF135
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FBB214A74;
	Thu, 20 Mar 2025 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qHBDNMPD"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C30F21421D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742460153; cv=none; b=i8gW7hsthzO20Jlk/5yEsgY+1kh0XnTv4fRc3lYHFMDRyVcYibTksBiAf85DbP2j8JaCvbWYa5govnoKo4uXZsW5clTWpTjUPopUnGmLllhCXhoGrFMB14+qAAi7T/TPgRQnoG53w+pmzBkqXWSzN0tOAiHXxQQ5cfc3N7yg9XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742460153; c=relaxed/simple;
	bh=ETHNPzysFdBVxyexfBEmHBJj29mukUKke0l1rtbYB9E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TJiE/BJ4xsId+ofBVChn/ZNC62Fcw6sZidzc79Oi8l4cEVrXzRywGGPYma32dXKZrX/zbPeQrXoMiWew3PheJ1OdW1zfBrB7z3u3UEFN47mnBkHh1UrlAfGnzb2zm1XryEseYJRZ2+ofJGsOTZp788KzxS3bPrxZFB3AVkvlwn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qHBDNMPD; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43943bd1409so3154015e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742460150; x=1743064950; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0q/pCfHYYPtBzoXiRpe1vIV+5BdA4Fjd+4hDTSR/RtY=;
        b=qHBDNMPDWXPKlaYZyGt0POBWgiaLkzlnlpdkGeUReduF8XtrJTJl4XrlSFKZR/s2jI
         OSdorvzXaa7I2MlLCXyu8Vvm0osY0tgscpFd26j8D/xjV6QPrYSLtKaNNzxqIu/Bu+EW
         V6mdpeQpQjWsfNuhjG7Oh0L+vZKtl41D7sqmyO7djN3lzUPxa1gFSYMDuEeB2UPVHTeu
         Xk6ScYCEmog6RhAspVIOy4ua8ZWRktXpIi+lPbZeJ4S52k7ZdfWE8y7rqX6O8qNKjcJH
         dRYHjCr6OQ1a1eDS3hSXr0N/tWoR5vNfe0NxzQ3zozFrMQohFannVazBmGdiJV1f7Ri4
         Maug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742460150; x=1743064950;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0q/pCfHYYPtBzoXiRpe1vIV+5BdA4Fjd+4hDTSR/RtY=;
        b=ZMT3+Wp0PPy52LYfp5smFNHnjr+BezOJ9CWLOIpDlIeuP4KoDlwAam/ezVSqcJSsmm
         lhXTl+IDoiVjA2inIWwqbOtDlH7R49aZwGVhnp5QOO3jE4xljqSFTbfDdfn+nrPhTZHn
         3SIpXmm0zufazGqGWn4TLDOy6eUN/xXegPqRZtVLqAHFbSWYccvDNFgM+8wsAoIbuHvO
         8axetslO3ujqTYYfo2Z8EpqUSZgF579i5Z5RQxQuQqQ2fd8CdnTnJTnKEbMJ6E+iuXdk
         aPe0cLGcJ3bztqmjURb+r8u1UAdKaznUvtC2nBCVlh6UtIuAetDIYdD9jMbENjIfdqC8
         wJhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdlSEwKmhphahpLtgDtvGLNQ8+2chf8V+T95NmTR2E1bDTuP6ZubyX62nPQmkGgHIcGWm8TIe/siEHuyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG0a5LxvXXqejX1XzmCkjYa3RXSPe1VC6R0stKc9tNnsVgWg+Q
	6hbHSxV98ThEpOt+830/Imm8RJbtXUWnR5bHquxVt3R7UlMUAiDwDNHMSQI/ou2JkXuy0vWJ9TL
	XqIyJXvHfIMBn+w==
X-Google-Smtp-Source: AGHT+IG0ZxbKLoTEaoTwO913p2LfPABAlZp2ArpAG4/VyJdVxYakp4RPsHWiV0l8Ao9KV2sMc4Ra47lUkav23Ig=
X-Received: from wmbbd5.prod.google.com ([2002:a05:600c:1f05:b0:43c:f6c0:3375])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3d18:b0:43d:738:4a9 with SMTP id 5b1f17b1804b1-43d495bd8f2mr14990235e9.27.1742460149944;
 Thu, 20 Mar 2025 01:42:29 -0700 (PDT)
Date: Thu, 20 Mar 2025 08:42:28 +0000
In-Reply-To: <20250317025205.2366518-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250317025205.2366518-1-kunwu.chan@linux.dev>
Message-ID: <Z9vU9G9A0mneuqT0@google.com>
Subject: Re: [PATCH v2] rust: sync: optimize Rust symbol generation for PollCondVar
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

On Mon, Mar 17, 2025 at 10:52:05AM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <kunwu.chan@hotmail.com>
> 
> When build the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
> with ARCH=arm64, the following symbols are generated:
> 
> $nm vmlinux | grep ' _R'.*PollCondVar  | rustfilt
> ... T <kernel::sync::poll::PollCondVar>::new::{closure#0}::{closure#0}::panic_cold_explicit
> ... T <kernel::sync::poll::PollCondVar as kernel::init::PinnedDrop>::drop
> ... T <kernel::sync::poll::PollCondVar as core::ops::drop::Drop>::drop
> 
> This Rust symbol
> (<kernel::sync::poll::PollCondVar as kernel::init::PinnedDrop>::drop)
> is trivial wrappers around the C functions __wake_up_pollfree
> and synchronize_rcu. It doesn't make sense to go through a trivial
> wrapper for its functions,so mark it inline.
> 
> Link: https://github.com/Rust-for-Linux/linux/issues/1145
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Co-developed-by: Grace Deng <Grace.Deng006@Gmail.com>
> Signed-off-by: Grace Deng <Grace.Deng006@Gmail.com>
> Signed-off-by: Kunwu Chan <kunwu.chan@hotmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

