Return-Path: <linux-kernel+bounces-449883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF4D9F575A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3DB1891E98
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 20:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610B417BEA2;
	Tue, 17 Dec 2024 20:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SC9ukFpk"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D350B1D9A63
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 20:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734466252; cv=none; b=Awmxbgv8IW2tXZ6/bOz4ByRXy/wgUfqjPdKe7lo3xaQcT9j6IUFq3KjgKwkyA8cuHkmdun1nEvRWmhEoK4lP83YaT3l/MnL2bK5i+jmUU3Hb1mHjtqcjSLu5/VWhvHBkLyArpfHWYy0nJpDRp474Ww6UQxkmGGoUX5HLhoisbss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734466252; c=relaxed/simple;
	bh=S9DoO5a3n3vU6X/je+MmroDxVIgCBKe2ddmDuJmV/mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZoHYfAEXG86WNbB9kW7oPzIHQiyetfwcWB+Xi1cdqfmvPcIT/TxR5BY5mkRc0vSSifCDccjRjG8uZbiVVY1N0zM9kTJRyf+b8fb6pStMk9GDmZ8+Ay5vc9adupNMuATneLuEu0ADtvvbMwuC0mbULpBeQ8PPwxvUtXuTG6F9CwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SC9ukFpk; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3863703258fso31195f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 12:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734466249; x=1735071049; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ptCMEfalScg4HE+s2WF5iyeS7CJ5LoQymYStrG4iRVc=;
        b=SC9ukFpkLeX3Ab8vupeb/6U3Sa1A4Yipa5Mmdt8mtiVcxh+XXswWzrgJgXeHwePziS
         WkLJX04TvTtVL/MhOCQm6aoTqLiVxcYXjMl3k5LWGH6dA88qrBu9gUCGrNyfmKCUbfli
         vSzaWP202LoVtzqRWAu6fgcg+MirDJ3bzoZmcbVu9vMELpftpzrRI9r6OrjZQIDJwQVa
         ztTMtwqswcWWH6nQxzq+GpVSGFDsEGNNkTYYo5pBZPIdy6IdL5MpaRDcYuoRnJdthoPJ
         5yCFYmNgcvrebUTMuzfbL8FYmgiPT6br0zOM3IIXw5UklsLbIE25/qe5SK+otRuxwd2v
         okPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734466249; x=1735071049;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ptCMEfalScg4HE+s2WF5iyeS7CJ5LoQymYStrG4iRVc=;
        b=pd/dNXqqSDDjkcMxKZb2Y54B7VP/pXNDr2Lq8xMRnhMtCs5qxuqgTkxIB35GS5TmX2
         rjahjw1jAz3a0q7M6Bs3LYKhUufS2X/R1ePQrHeh28/hs+MuyOXhTgrsUmD4priVGDDg
         8oGAYW1RuPpB1JIZMzjTMZZ4Paq4j+JHlcpLsXVFDvIqE2XywILSe989sAn+/RIykTAd
         ITrq57rY/7rRXA1Hs1qBG6BSqjODGU/BsN42k1VRfTavuWchyKcbS+xlLlCMoGTQuVUY
         eL1o6lI1QvzpVx8H4mo9sEU4Ghmsmggp3zzi6D1xhulk9GmDKit7J/Ji0Xc/pkkokUhf
         olHg==
X-Forwarded-Encrypted: i=1; AJvYcCXh6cVGlGHBwz6KKZRDVyeyD9BMOronwPsGg3+dJMUuxKsQgR9v4UamQC7q9vt7xrcYdJ+Fv/SPcGBgbJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNkKnPvtbWuScHvet7m7uRm0F2lIjtXmMRzmzmwLB1rtcrA9Jo
	7P1DZOHMjt9u8L/O4uqNvH2XIFAGy0GslANMbt7WOVW/PST0qPCQqyKtUQ1sB9LOBrqH+snaHIe
	bvvIUYK1hOhMAAz/DN2MRBCaIlZvdAUZ55XTpjw==
X-Gm-Gg: ASbGnctSsnKpKF/7fTyUPQDoNx/1n/cTIPsocC3LdffKrL/xhefow2upUG+Qf5jB/45
	+HCW/Hu1ezVfqGNNHeMhWAFKsRcboUH8QtZH8hnIgzriOksGM4o359u2TRBbMaUPHh0epug==
X-Google-Smtp-Source: AGHT+IGKGM3GSJM51xtpyhc2/6RhhD/S1kZ/YygELvpxDkqeIEk+YG5SrrmAjsx+Q88wsvntYUv7XsFnXak8mvmHL9g=
X-Received: by 2002:a5d:584f:0:b0:386:3958:2ec5 with SMTP id
 ffacd0b85a97d-388db294b60mr4487740f8f.28.1734466249108; Tue, 17 Dec 2024
 12:10:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212163357.35934-1-dakr@kernel.org> <20241212163357.35934-8-dakr@kernel.org>
In-Reply-To: <20241212163357.35934-8-dakr@kernel.org>
From: Fabien Parent <fabien.parent@linaro.org>
Date: Tue, 17 Dec 2024 12:10:38 -0800
Message-ID: <CAPFo5V+WOWzzXxN=-n+ADrFdkSV7C66Lq-+gitx+TnrsAzYJnw@mail.gmail.com>
Subject: Re: [PATCH v6 07/16] rust: add `io::{Io, IoRaw}` base types
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com, 
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net, 
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, dirk.behme@de.bosch.com, 
	j@jannau.net, chrisi.schrefl@gmail.com, paulmck@kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Danilo,

> +/// ```no_run
> +/// # use kernel::{bindings, io::{Io, IoRaw}};
> +/// # use core::ops::Deref;
> +///
> +/// // See also [`pci::Bar`] for a real example.
> +/// struct IoMem<const SIZE: usize>(IoRaw<SIZE>);
> +///
> +/// impl<const SIZE: usize> IoMem<SIZE> {
> +///     /// # Safety
> +///     ///
> +///     /// [`paddr`, `paddr` + `SIZE`) must be a valid MMIO region that is mappable into the CPUs
> +///     /// virtual address space.
> +///     unsafe fn new(paddr: usize) -> Result<Self>{
> +///         // SAFETY: By the safety requirements of this function [`paddr`, `paddr` + `SIZE`) is
> +///         // valid for `ioremap`.
> +///         let addr = unsafe { bindings::ioremap(paddr as _, SIZE.try_into().unwrap()) };

This line generates a warning when building the doctests on arm64:

warning: useless conversion to the same type: usize
    --> rust/doctests_kernel_generated.rs:3601:59
     |
3601 |         let addr = unsafe { bindings::ioremap(paddr as _,
SIZE.try_into().unwrap()) };
     |                                                           ^^^^^^^^^^^^^^^
     |
     = help: consider removing .try_into()
     = help: for further information visit
https://rust-lang.github.io/rust-clippy/master/index.html#useless_conversion

Same things happens as well in devres.rs

> +///         if addr.is_null() {
> +///             return Err(ENOMEM);
> +///         }
> +///
> +///         Ok(IoMem(IoRaw::new(addr as _, SIZE)?))
> +///     }
> +/// }
> +///
> +/// impl<const SIZE: usize> Drop for IoMem<SIZE> {
> +///     fn drop(&mut self) {
> +///         // SAFETY: `self.0.addr()` is guaranteed to be properly mapped by `Self::new`.
> +///         unsafe { bindings::iounmap(self.0.addr() as _); };
> +///     }
> +/// }
> +///
> +/// impl<const SIZE: usize> Deref for IoMem<SIZE> {
> +///    type Target = Io<SIZE>;
> +///
> +///    fn deref(&self) -> &Self::Target {
> +///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
> +///         unsafe { Io::from_raw(&self.0) }
> +///    }
> +/// }
> +///
> +///# fn no_run() -> Result<(), Error> {
> +/// // SAFETY: Invalid usage for example purposes.
> +/// let iomem = unsafe { IoMem::<{ core::mem::size_of::<u32>() }>::new(0xBAAAAAAD)? };
> +/// iomem.writel(0x42, 0x0);
> +/// assert!(iomem.try_writel(0x42, 0x0).is_ok());
> +/// assert!(iomem.try_writel(0x42, 0x4).is_err());
> +/// # Ok(())
> +/// # }
> +/// ```

