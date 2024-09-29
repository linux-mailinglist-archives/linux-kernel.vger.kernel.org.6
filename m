Return-Path: <linux-kernel+bounces-343151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 703C298974A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 22:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29C9F1F214FD
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 20:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BC27DA8C;
	Sun, 29 Sep 2024 20:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="RJf3Iif9"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747972AE90
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727642203; cv=none; b=EcEhVfyIeNYFr7fgfBWRaDG4MZuuQzpLLfvOJQGco1TUwup6mR4Tg5tY0kNNXIRWI69kV35n3Ta1ZgAo/CKS6kAi4rtZ9Rnpvt1dczZ0n3LZei87zBTzNie3TwL13/UzQXKYg6fc3h2JfTg9N8x3LZqxt4IT3dnrkuhrRDD/3Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727642203; c=relaxed/simple;
	bh=yJvKHFVaWy+U/hapM0yQzvNmizf07/FN1eL92Wgn+Sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4L96CfFXQBtbSe97cqIkzaCkv4G22nI9juEZLF/Ar0o5KsHqx74EY+iQMHP/dEkoKWsONzPJ0LaTwruxWy8Q+3cniSdLyW0XeDoSh8bNlWosM0/5vB2IAef3ZCuBTDU08V+D7zXPBrhjvtB6OjYT6MPXxSiZDB1w2JEE2wGud4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=RJf3Iif9; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e2598a0070so9868227b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 13:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1727642200; x=1728247000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVnHMnmiF+13daBSttLD+aIXUDJcxVgtv3MA41ELUOQ=;
        b=RJf3Iif9Spw6qAqkijtvucZ77XCj0wBbyMDahCjzLCafo5+WX+2IwfmbMcQn2Vif3C
         4CLXqc57GWQ3BZausJoOs9yA/euW10Qr4s5EpWQkSzJtHsgp5K4+P/bOGWx7/17OSZVA
         n4oL/rw+qapRXH0JTi14mPU+nZ8L3yAeQ+GwNMIkNxgyulYV0AMQ2Z//+kPANVl/RLba
         Vqbb8CkJ71cKvgFp9oHyVWr7K+vn8LxolOFP0msLdEl12Rqa02lc0d09NU138oC9OUyf
         CLJCSO9W4Nm8xSk1UGc8ecgqOcO5hZONpbflr+WBatCp4cinw5K0uPFB9XVZj5JRFpiz
         u9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727642200; x=1728247000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVnHMnmiF+13daBSttLD+aIXUDJcxVgtv3MA41ELUOQ=;
        b=btbDxEU5mdkCDSTwlPGr1KAd+wYWBbVrvWbkpXvbkN+l+3tbd3lIMLeYJMBT9NKUD7
         9ZtOAIWpvDrFmZ4mEg3f41W1ZHNL5WinvivUYsAmhLab7FxvOAx2whnhg45lolxLa/wG
         lQJqyChZSPmpRjRxh+7U5/Z6g6Zv/tppIg1QXph2DjopHg6gs86kqw9t9GxDj9CunO9W
         WFwNj4THUFDEtV5S345LwfEZtPcvRFjyFd5F5ik/FLOe568iOlWFDy5ArDTC2vL2c0FV
         NFfOjYb/3mcwOIvXDaN+d/1acN3SBdKrERqD9HLdeTdusVPrDVMsBgGHMY1wV5u/23i+
         O6Uw==
X-Forwarded-Encrypted: i=1; AJvYcCU83B3OKuLzkl4bd6LZ39eYBC6gqeJLU4qcl5HiVwd7e21L2Zq5hEXUPXOvFI252t1J82n6vTYyltg0pmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLQpcybMD3iNUUWq+UXLZ2bdAMWLWYKx1cwPLvZ74CxEzBa2mm
	pGKJ8LWv5GrtNWBQ4UCxBrcp12NOQdjaSI8ZzXQeGOhwNe5mp4hyXc+suWog97d5eigQMbIBZnd
	/S2uJHCHKc+U0t3pfohJkji3QY1MY7iypPdKA0w==
X-Google-Smtp-Source: AGHT+IETCze3KtAe+nbUVqoRMjK6sAQNLok2M1rHft7+nawFMwPHyIKRFgxqTTpRzDf2ozXAHljC8Nhw9SfgrzI5dTA=
X-Received: by 2002:a05:690c:2905:b0:6e2:1062:9b90 with SMTP id
 00721157ae682-6e247619bd8mr54586977b3.44.1727642200296; Sun, 29 Sep 2024
 13:36:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916213025.477225-1-lyude@redhat.com> <20240916213025.477225-2-lyude@redhat.com>
In-Reply-To: <20240916213025.477225-2-lyude@redhat.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 29 Sep 2024 16:36:29 -0400
Message-ID: <CALNs47u56oVYxwNq+POgOu0m141gwG-mEoRBH8hzevj6Ve-Vag@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] rust: Introduce irq module
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	Benno Lossin <benno.lossin@proton.me>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Valentin Obst <kernel@valentinobst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 5:31=E2=80=AFPM Lyude Paul <lyude@redhat.com> wrote=
:
>
> This introduces a module for dealing with interrupt-disabled contexts,
> including the ability to enable and disable interrupts
> (with_irqs_disabled()) - along with the ability to annotate functions as
> expecting that IRQs are already disabled on the local CPU.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>

> +impl IrqDisabled<'_> {
> +    /// Create a new [`IrqDisabled`] token in an interrupt disabled cont=
ext.
> +    ///
> +    /// This creates an [`IrqDisabled`] token, which can be passed to fu=
nctions that must be run
> +    /// without interrupts. If debug assertions are enabled, this functi=
on will assert that
> +    /// interrupts are disabled upon creation. Otherwise, it has no size=
 or cost at runtime.
> +    ///
> +    /// # Panics
> +    ///
> +    /// If debug assertions are enabled, this function will panic if int=
errupts are not disabled
> +    /// upon creation.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This function must only be called in contexts where it is alread=
y known that interrupts have
> +    /// been disabled for the current CPU, and the user is making a prom=
ise that they will remain
> +    /// disabled at least until this [`IrqDisabled`] is dropped.
> +    pub unsafe fn new() -> Self {

It could be worth mentioning that you probably won't be calling this
function directly if you need an IrqDisabled, linking to
with_irqs_disabled instead.

Either way this looks great!

Reviewed-by: Trevor Gross <tmgross@umich.edu>

