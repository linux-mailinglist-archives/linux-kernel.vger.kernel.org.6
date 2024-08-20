Return-Path: <linux-kernel+bounces-293688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABAA958326
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21FE1F24453
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5B315852A;
	Tue, 20 Aug 2024 09:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n5OtXpT6"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA8818991B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724147282; cv=none; b=uEWZ6y417L0SIBTJQFxB20q6Y+oJPwXCbTdk/GrTvM4z7X3P/bGyO78XNrKVyTZhVDy1/gG0zvLvUp+rabT2ScL9c/mGQjOIay6KhLmMqSd5ydrrDni0bKtrrLL/Objp+MSAgDkeL2bUwvULSP8VpX//IrA7H0u49pWe9627n2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724147282; c=relaxed/simple;
	bh=C+lrelehWmti/GpTiBFFCsKbE6qTQDuISR36MHDMWwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMo9CSrVLASGZlCUIyX7hIwXYn9IduseSrqiLDaIAd8b9QmRgbbAocN1xXlzHm9E7H4xlhhEX/3uL/ZQRSfEnPa4PUAqMWR+MLITcgO7aPR3vusrDxC9eGsmVEbWxqjgr+YUsIjSf/uZIWrm8Yngz65q5h0ikCdaDBfB4OztmBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n5OtXpT6; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3719896b7c8so2173056f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724147279; x=1724752079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkbZOyJmmuZ1wf7Nih6xoGcKtCEbVt1IodvD++9LNEM=;
        b=n5OtXpT6dQuBBMQ61HGg6t+rIt94iYhxKDYdt0jON3KaLGXllvlV/8KWVfa9lom28O
         sv4ChlkNBmcR7OAxblzkoNBCyhn2VvcUKuxHlGU/J0+X4twXhnhZXCuoUh5pZR6nDRtI
         zgHojhu3YXbxnaLygTojl7tz1OEAFYtLS6tMH24/ga5MzD5GktvIFq0jB4qkCRVA7ZqC
         BzNfhHpzvlLUoTCljlmZcarvWIG7ZkwZVzzkbSISoVUvZGALLXkQVUIVwOsYMT8RzU5G
         9sUh1nkn8eFF7AH8pTD6FrMBDw5rASbkwhwdW0jx75/quVWQUKEndKg7ifKW3ITnQmI4
         eIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724147279; x=1724752079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkbZOyJmmuZ1wf7Nih6xoGcKtCEbVt1IodvD++9LNEM=;
        b=Q1C16t5c3hNuQp0DOnz68IEgaeYK0qzDT+QTowmJ3RWnPKwR4MRa3JcU9VMiivH1fy
         JaU3cQzij5ulOAzEs3IIohpqu73m24uk0/rEy0f3YYrvp6ZPYuOfvsJPTB4xOz85F8OA
         qtSR/6cgY59E6xb0hxbqbYTf65ZKebdCuitbmKUfzH71b3uhMnyBlnrIEURStcKmVv3f
         6U20DrhVlYEHHRNMi9g/MKYr9b0/10rCprSTbpFA18MTNzikvEtGDEIJU+GBX50ehM4T
         sR3H8LRz2dczV+UpDvyst7AdlRF4tKRWdcURR79f2cY9larlFpGmjKksav2hChuk0lqd
         Z+cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsqCFfc7JxFGtak3LdTGupkWFAa4fQe1tcl0biKE9S6RDvEnE0MUP4+/YxAgr4K9qtgFe6qT0lvYFffA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFXd23Rd2pJ0+dQjo2naN3BKS1b3I9FoYxLNFGtfcu1j7cL3Ch
	/UjHx/+Ij2jZLfz5pOyWAKzamCKixOlkbVimHq0li+bj0y4cZPeQphrR/uhZZPN2RoTgxPhWwvc
	6sXvEODM3jBr9i97o68ygsjyOfBBv3+4WoIM2
X-Google-Smtp-Source: AGHT+IEVUUgMFhEKKPpSyV6A7eW6jCZuMIA6MUx6Pkw8BpG70r3d1xZ/pttplYFiCUfLgBTqFJirTtBuWp0RxHiPvIM=
X-Received: by 2002:a05:6000:1844:b0:368:117c:84fd with SMTP id
 ffacd0b85a97d-371c5fa676dmr1167035f8f.3.1724147278349; Tue, 20 Aug 2024
 02:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-10-dakr@kernel.org>
In-Reply-To: <20240816001216.26575-10-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 20 Aug 2024 11:47:45 +0200
Message-ID: <CAH5fLggUzUuiVuKOYmvo1fAcXGpsHUiRKx6DTg2cgkMe2YcF4g@mail.gmail.com>
Subject: Re: [PATCH v6 09/26] rust: alloc: implement kernel `Box`
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, akpm@linux-foundation.org, 
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com, 
	boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, 
	zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 2:13=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> `Box` provides the simplest way to allocate memory for a generic type
> with one of the kernel's allocators, e.g. `Kmalloc`, `Vmalloc` or
> `KVmalloc`.
>
> In contrast to Rust's `Box` type, the kernel `Box` type considers the
> kernel's GFP flags for all appropriate functions, always reports
> allocation failures through `Result<_, AllocError>` and remains
> independent from unstable features.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Overall looks good to me, but I have a question:

> +impl<T: 'static, A> ForeignOwnable for Box<T, A>
> +where
> +    A: Allocator,
> +{
> +    type Borrowed<'a> =3D &'a T;
> +    type BorrowedMut<'a> =3D &'a mut T;
> [..]
> +    unsafe fn borrow_mut<'a>(ptr: *const core::ffi::c_void) -> &'a mut T=
 {
> +        // SAFETY: The safety requirements of this method ensure that th=
e pointer is valid and that
> +        // nothing else will access the value for the duration of 'a.
> +        unsafe { &mut *ptr.cast_mut().cast() }
> +    }

Where does this come from? It looks like you've based the series on
top of [1], but I dropped that patch a long time ago, and I don't see
it in rust-dev anymore.

Alice

[1]: https://lore.kernel.org/all/20230710074642.683831-1-aliceryhl@google.c=
om/

