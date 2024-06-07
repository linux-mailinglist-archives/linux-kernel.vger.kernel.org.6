Return-Path: <linux-kernel+bounces-205909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF89900212
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE03C1F251A4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD97187330;
	Fri,  7 Jun 2024 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VLYqQIjb"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B77187346
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759481; cv=none; b=mwT4pjFQ8QcWuOYU6/EuvoKV7GjbdNH2wWWQqMWxjoKIIV8CkNIXdgzkJTFhzQ7Y+KI8sthcpMEXPM/6Id+Garq4Q9PCx+0Ackppok6zirEbMyKicaaQfkwiCILdRUYEmcR3y6ZY+4kSWInsxJxOyHwrHYqxObBXKQJVmVZba6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759481; c=relaxed/simple;
	bh=QDB7wOedg633ySJnJZZj65PiGCmpyS2TDfWcEfEhYxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=RguLTpTKV2hMs6NJscpuvAIHdErCKgnmQa6Z6Z+03IN41CGiYAigtfmniwONbuMMpnp1OSaqKDm7TYYgaLDpDg28c/3IED4qJGclYMz3/nyIkAguxZYKIy9g+vQe8wVF/XGFz9+igxgbRpB3eo6N/Q2hSVod4YhXRTm1n5KIRL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VLYqQIjb; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52b8b638437so2262806e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 04:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717759478; x=1718364278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TxKqtp38KhT9aMHnsIeC+TX8dWAC4DZuSMvsQh7h8Sc=;
        b=VLYqQIjbfl2wPFGZk2xA8XlK0+V39hR5wdPBCyTESDrnh3YR30F8bI4q/SNm47jJNe
         o08BMPN+GNyTgFimyII+lrhnkC4Uf1FEikintb3U3gDEASsfWcXlegSE88S+ImBqNEFP
         9F7RZGDc178x3utWSuvRTTWc/mj2ek9oT4Cl0VpP7BYQiDCMTBYcB5PzrUB+BW5LEX4I
         +tXkTrTxVl+P1ByffSeVnyaVa9ErMgczBm7Jwnf5EUJBfR2fxIHPhwNyVFPTrVm/8g4T
         CkY1imGKX6k4PAdjUA9Ma+I/9VcXHPiPwdeo/2g+xpewxISLuVQAX4c8kl1LJkrdtfXz
         /aUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717759478; x=1718364278;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :references:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TxKqtp38KhT9aMHnsIeC+TX8dWAC4DZuSMvsQh7h8Sc=;
        b=H0h2pQUHMCmJn6YUWAbsaKyaRsNAuNqbbxIi1qdnPwF3rUUjSyziHjIBtIdsTbiVX3
         ZE+/iP70roACRwLxLHXJQOfdHtu2LnU+zgb5RHS+3PvBwRpDhndiJQklNhcYq3cCRpYb
         m7r6ImBiNsnpwT8ex1uLNp8k4D8CRpvu130R3c1JArCykbAUKAPkMx6/cyNDmR1YmJxM
         Fk325//ehrxB1D3cbFvl6X/2EtAQKaZmQyiYTU6v5Zo9ppsoXjXMEcodzdOlLyeKGby9
         PzXYhaYyxwnc0vZzzCs+aB3AhGrXGP9DUcriKtnz6iJatIPe5Rz0UgQfn4xYC8wsvc4s
         a6aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAYgR9i1DbNWrCgV30eB891hWEpoCk7jnPCd8kTFfNv/RuRd/yQNWqy3jzZ4BsArMea2+415UANvOJZdZKWcDIXVBuTTnQ71q0G6Hk
X-Gm-Message-State: AOJu0YwZsD9X7tFpTcXnrzQqFvr6lIq2lXJIan/RskvV3qJDc/kEmtLp
	vtnHwEIIidB8kN8oM+lGrqNZodm85cEqaBqo90bVrjTsv/Ay84fR5sZP4y4cyVg=
X-Google-Smtp-Source: AGHT+IGn858uClRXM981tpsaA+vmiD0FQcCFjuKV9/5cUuIuy0VYS5bgZRqyLlCPVkDX655Cz+J0Tw==
X-Received: by 2002:a05:6512:ac4:b0:52b:7bde:896b with SMTP id 2adb3069b0e04-52bb9f5d3b5mr1689086e87.14.1717759477758;
        Fri, 07 Jun 2024 04:24:37 -0700 (PDT)
Received: from meli-email.org (adsl-105.37.6.1.tellas.gr. [37.6.1.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c19e572sm50531555e9.10.2024.06.07.04.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:24:37 -0700 (PDT)
Date: Fri, 07 Jun 2024 14:18:54 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Alice Ryhl <aliceryhl@google.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, Bj=?UTF-8?B?w7Y=?= rn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Erik Schilling <erik.schilling@linaro.org>, Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>, Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V2 1/8] rust: Add initial bindings for OPP framework
User-Agent: meli 0.8.5
References: <cover.1717750631.git.viresh.kumar@linaro.org> <e74e3a14e6da3f920cee90d32a023ba4805328a0.1717750631.git.viresh.kumar@linaro.org> <CAH5fLgjChZCtTUnHVHJat-sXFyLVE+MgDXrNDiUD0LNsUndpBQ@mail.gmail.com>
In-Reply-To: <CAH5fLgjChZCtTUnHVHJat-sXFyLVE+MgDXrNDiUD0LNsUndpBQ@mail.gmail.com>
Message-ID: <epjoz.s6l4l8qrt331@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed

On Fri, 07 Jun 2024 13:51, Alice Ryhl <aliceryhl@google.com> wrote:
>On Fri, Jun 7, 2024 at 11:12 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>
>> This commit adds initial Rust bindings for the Operating performance
>> points (OPP) core. This adds bindings for `struct dev_pm_opp` and
>> `struct dev_pm_opp_data` to begin with.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
>> +//! Operating performance points.
>> +//!
>> +//! This module provides bindings for interacting with the OPP subsystem.
>> +//!
>> +//! C header: [`include/linux/pm_opp.h`](../../../../../../include/linux/pm_opp.h)
>
>Please use srctree links instead.
>
>C header: [`include/linux/pm_opp.h`](srctree/include/linux/pm_opp.h)
>
>> +impl OPP {
>> +    /// Creates a reference to a [`OPP`] from a valid pointer.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
>> +    /// returned [`OPP`] reference.
>> +    pub unsafe fn from_ptr_owned(ptr: *mut bindings::dev_pm_opp) -> Result<ARef<Self>> {
>> +        let ptr = ptr::NonNull::new(ptr).ok_or(ENODEV)?;
>> +
>> +        // SAFETY: The safety requirements guarantee the validity of the pointer.
>> +        //
>> +        // INVARIANT: The refcount is already incremented by the C API that returned the pointer,
>> +        // and we pass ownership of the refcount to the new `ARef<OPP>`.
>> +        Ok(unsafe { ARef::from_raw(ptr.cast()) })
>> +    }
>> +
>> +    /// Creates a reference to a [`OPP`] from a valid pointer.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
>> +    /// returned [`OPP`] reference.
>> +    pub unsafe fn from_ptr(ptr: *mut bindings::dev_pm_opp) -> Result<ARef<Self>> {
>> +        let opp = unsafe { Self::from_ptr_owned(ptr) }?;
>> +
>> +        // Take an extra reference to the OPP since the caller didn't take it.
>> +        opp.inc_ref();
>> +
>> +        Ok(opp)
>> +    }
>
>I would recommend a slightly different approach here. You can provide
>a method called `from_raw_opp` that takes a *mut bindings::dev_pm_opp
>and returns a &Self. The ARef type provides a method that converts
>&Self to ARef<Self> by taking a refcount. This way, users would also
>be able to call OPP methods without giving Rust any refcounts. You can

Wouldn't this allow for use-after-free? What if the refcount drops to 0 
before the method is called?

>As for `from_ptr_owned`, I would probably rename it to
>`from_raw_opp_owned` or similar. It's often nice to use a more
>descriptive name than just "ptr".
>I think most existing examples call this `as_raw` and mark it 
>`#[inline]`.

I think `ptr` is more idiomatic to Rust users, not that your suggestion 
is wrong. from_ptr_owned also implies the function signature.


>
>> +    /// Adds an OPP dynamically.
>> +    pub fn add(dev: ARef<Device>, mut data: Data) -> Result<()> {
>> +        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
>> +        // requirements.
>> +        to_result(unsafe { bindings::dev_pm_opp_add_dynamic(dev.as_raw(), &mut data.0) })
>> +    }
>> +
>> +    /// Removes a dynamically added OPP.
>> +    pub fn remove(dev: ARef<Device>, freq: u64) {
>> +        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
>> +        // requirements.
>> +        unsafe { bindings::dev_pm_opp_remove(dev.as_raw(), freq) };
>> +    }
>
>Is it intentional that these methods take ownership of a refcount to
>the device that it then drops after calling the C function?

use-after-free again? Though I'm suggesting this without actually 
examining if it can happen.

