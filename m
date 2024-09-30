Return-Path: <linux-kernel+bounces-344199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF42998A643
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B114B24BD2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF8C1990A3;
	Mon, 30 Sep 2024 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hhg7wni6"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4928119884B;
	Mon, 30 Sep 2024 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704385; cv=none; b=IkgxvaeKTOFLWrHSa+GgLnDqFZqNC6ZavJng3/Do9W1ZWmp73aAG1/s6o4JKRi9/4lsghWjJDs9eXhZ8Mnc5l3YCNIa/9W/5iW4nT4Pc5W1QIFFORcsf4yqyvQXM6wjSGQDfZPkTXfztJb/IbJ/ArUzAAsBJeR9RVdLQfEFIUZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704385; c=relaxed/simple;
	bh=Znd1k4WBQQDK89MbCJPRBt9urQ3WJb7ilcGQAQ+x+M8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4TSQoDaQSOg/J740DCPRQFPckxDQAine0slpj2ZwydJ8CBF/PMp8I9ee/3M1/FmsBJ3n0CmPVsIYcadlbaWex79hqhFiaiKRTibLdNBPa/w7r25/tWWojnfW7BHqXh3Hz2iuE3iZ3o9pKv86Wz96S8q3Q7s8k29nCQlU8pTxBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hhg7wni6; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-45821ebb4e6so37764791cf.2;
        Mon, 30 Sep 2024 06:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727704383; x=1728309183; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u0OkympynRcjXtrMFGHNcG4xxmNqvJSPoPRRyeWatKE=;
        b=Hhg7wni6XAZCTwxoZpShS3x+pTBZ5WCaDmYih+fRZ47qWqMPekIzFfgz8QiuVIhTok
         jc9BTl1lw/HpNo2JfGXmwD0vctlsTvvlTutMUZfYvBv35L72DBcU9JCZC0EcoPUEsHAV
         LeLwkzrhgbZhJVEp5o2WO9HLjCkXNLcSHRGpO70nleQSNVU2JyQViUo6rf3Ibt5gt0tO
         niZGWfuADcwJqm9h5gTnvtxHPvtFoUHalZCANMCMmrFwHwmLnQrK2x/m/RfehvC9uLup
         9r4HqGrWn5v320IJU+FGdlz0ba7fhp3/aNriZI/XXfo9qgQsIcUPU6pURbNEhRpI8ExH
         mAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727704383; x=1728309183;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u0OkympynRcjXtrMFGHNcG4xxmNqvJSPoPRRyeWatKE=;
        b=vxykpX91lNSKRZjqNAPjX9QHvhilOnehkhWq/exJvmZ/j9MLVFbJdWNcCpbktAT7mv
         993TpvMK/fnRaWpHxtVBCg51+I4UcHFFedkW9vpgR6SNScTB8Eu097i1Axz8cWkxBS03
         7wJO4OdVoGfJ8+4vQIi0Fe2XxSNC+WPh96DqDNnOlDUkY0mQKDYZs6eytIq1K7zR2dcF
         cEL0iYMlhZp7f4FlPeqWEB1ElMA1CN9CW4OXwScnvk1UNNjP40JKgpa5ckRBZytqW8z2
         8WiWVU/sdn37UGjxxWSIKieKFoV2xrKqhOa+B1b/U0KDnVAJo49906SNl2AO4n0zRzsU
         vzSw==
X-Forwarded-Encrypted: i=1; AJvYcCUiF+UN73kJqElB8Obw8uxby0hnLwhU+1/jmKCfzOR2Efmoi4ERnfVzAuWbKA6ZrILGdFujQEh+UItTPVxkMsc=@vger.kernel.org, AJvYcCWrrn6+QcOUMVo5gyLr16nS/RNLlw+GwoyJpgJKK4scVWhzRFEak6Wm0HUbYI4UI/Sf33tzL+d4B0cuyrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhPB84kJd/a4C+dt+6i+yt4ZEy6TgDwvb03d35d7u3aUguKT/L
	Vv20CF+I0bcndWlmBInJo3JO/nstNUQyffrkFkGKis/rDva7Alw043j69fEWMeKKOpjLhwSLYNi
	vBM+D1yHqZ2zLrtNMMF/PO6SxiZc=
X-Google-Smtp-Source: AGHT+IGt2o0swMb4vOejBplxSWawjvPqkfCBQG5T+6g8aqFWgm62yonwyuBRVAixAqWy7Nu/XW7+zUwRg3OYGISALxk=
X-Received: by 2002:a05:622a:490:b0:458:2ce2:269 with SMTP id
 d75a77b69052e-45c9f2a2638mr230475331cf.40.1727704383017; Mon, 30 Sep 2024
 06:53:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930123957.49181-1-trintaeoitogc@gmail.com>
 <20240930123957.49181-2-trintaeoitogc@gmail.com> <ZvqkAuxWZIMZshN_@pollux>
In-Reply-To: <ZvqkAuxWZIMZshN_@pollux>
From: =?UTF-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
Date: Mon, 30 Sep 2024 10:52:27 -0300
Message-ID: <CAM_RzfYXWJ1ePZk7-DFR4P--F1pyzWg8bnC40mbLWaHpx_aNJA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] device: rust: change the name function
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, aliceryhl@google.com, 
	mcgrof@kernel.org, russ.weight@linux.dev, dakr@redhat.com, 
	a.hindborg@kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Danilo Krummrich <dakr@kernel.org> writes:
>
> On Mon, Sep 30, 2024 at 09:39:56AM -0300, Guilherme Giacomo Simoes wrote:
> > This function increment the refcount by this command "bindings::get_device(prt)".
>
> 'increments', 'bindings::get_device(ptr)'
>
> I'd also say 'by a call to' instead of 'by this command'.
>
> > This can be confuse becuase, the function Arc::from_raw() from standard library, don't increment the refcount.
>
> Neither the stdlib one, nor the kernel one.
>
> > Then, this function "Device::from_raw()" will be renamed for don't make confusing in the future.
>
> Prefer the imperative, e.g. "Hence, rename `Device::from_raw` to avoid
> confusion with other `from_raw` semantics."
>
> >
> > Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
>
> Please make sure to run ./scripts/checkpatch.pl before submitting patches.
>
> I see the following two warnings:
>
> WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
> #6:
> This function increment the refcount by this command "bindings::get_device(prt)".
>
> WARNING: 'becuase' may be misspelled - perhaps 'because'?
> #7:
> This can be confuse becuase, the function Arc::from_raw() from standard library, don't increment the refcount.
>
> Please also use a more descriptive commit summary, e.g.
> "rust: device: rename `Device::from_raw`".
>

Thanks for your suggestions...  I will make this changes.

> > ---
> >  rust/kernel/device.rs   | 2 +-
> >  rust/kernel/firmware.rs | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> > index 851018eef885..ecffaff041e0 100644
> > --- a/rust/kernel/device.rs
> > +++ b/rust/kernel/device.rs
> > @@ -51,7 +51,7 @@ impl Device {
> >      ///
> >      /// It must also be ensured that `bindings::device::release` can be called from any thread.
> >      /// While not officially documented, this should be the case for any `struct device`.
> > -    pub unsafe fn from_raw(ptr: *mut bindings::device) -> ARef<Self> {
> > +    pub unsafe fn get_device(ptr: *mut bindings::device) -> ARef<Self> {
>
> As a follow-up, it probably makes sense to also change the function body to
> just: `unsafe { Self::as_ref(ptr) }.into()`.

But if we change the function body that is suggested for you, the
function will not have your own refcount. If I don't wrong, the
Device::as_ref() expects the caller to have its own reference counter.
And if we change the behavior of function, your name don't need to be
changed, because your behavior will be equal the from_raw() from
standard library.

>
> >          // SAFETY: By the safety requirements, ptr is valid.
> >          // Initially increase the reference count by one to compensate for the final decrement once
> >          // this newly created `ARef<Device>` instance is dropped.
> > diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> > index dee5b4b18aec..13a374a5cdb7 100644
> > --- a/rust/kernel/firmware.rs
> > +++ b/rust/kernel/firmware.rs
> > @@ -44,7 +44,7 @@ fn request_nowarn() -> Self {
> >  ///
> >  /// # fn no_run() -> Result<(), Error> {
> >  /// # // SAFETY: *NOT* safe, just for the example to get an `ARef<Device>` instance
> > -/// # let dev = unsafe { Device::from_raw(core::ptr::null_mut()) };
> > +/// # let dev = unsafe { Device::get_device(core::ptr::null_mut()) };
> >  ///
> >  /// let fw = Firmware::request(c_str!("path/to/firmware.bin"), &dev)?;
> >  /// let blob = fw.data();
> > --
> > 2.46.2
> >

