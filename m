Return-Path: <linux-kernel+bounces-310971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C87B96836F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235991F22D3A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817D61D1F7D;
	Mon,  2 Sep 2024 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCW9UIPU"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8EF179654;
	Mon,  2 Sep 2024 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269960; cv=none; b=Um+zaHECmc14bqYBvx7BQXoA/Q3vjF7PVIauWTpBYjvFyBbxSrrCt+1b0k5zgVvLCJMCWgnVpcFtNxAZExQOqcLrVCJSkn7G2YjMMJ4fttIdT5cnK0JlHx8cnFNtXvj509taGW6ByrnAb0nKHbwvuCE+6TmKqV7Hv47gOUkff3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269960; c=relaxed/simple;
	bh=hhmxC5V+xiBOTO2E3bd+btwjZNOIpNmkQwWHtizS5mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyEioEoJckFy2kar6qniUJ36byhIlW1jwhO2MI8GqPxwlmriyaOyM3VOcDpOkM//icAG3TaZsCAZGo8cMBDofdGI8MXFe4UqV7Trp+GCkkSN9hBO+Mhwuk88kqcZmMLuNS32r9FM3uIxaXFZD2SKZbFnhRpp9p9Nra3Eg9XnU5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCW9UIPU; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-714269f312fso409536b3a.3;
        Mon, 02 Sep 2024 02:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725269958; x=1725874758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azTCUX5p5rbJLOuNQLdb2F4kxD0kEsoshFDFHg0ws+w=;
        b=JCW9UIPUiZD2nYmxET6hgXQFEEwNkW5eKSlEAfn3mFHv90HtryimlXh0Q9uElRTJK1
         K4EU9UGxw61Dydfvv7UI7uNZ4LsBRtqV6gTHUOr5CyHXgSHqhSp0+r79JP6FkrXNtdB0
         yQtf0OSb1Y8s8fHZkGYhASU2hYPgNmEJK1JMK6i+m31f3EZr9Y6x2Oxqiq3scQrlb+Kp
         dVoMaxtnisAv2Iu7rQ51UePLbBXhVUFUuCZpnFpM86nuG1NRuTiebnGBXGp/QKVEuJKo
         kxYEe1BxtFOlcQg/Im7qnqDhHs7e1gk9aHJUkKfuLrzVF9XfWmEsxXz3TE6i4KjWfheD
         vS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725269958; x=1725874758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azTCUX5p5rbJLOuNQLdb2F4kxD0kEsoshFDFHg0ws+w=;
        b=aXK2gJQDdlRuYLG02OHLtUPHBgBxMXMOQYCMD6v4PaEBUYB9i2RItIeZzOpz+SszSs
         GPgyW0QFwSILZgn5K6zxSmc8lHEoABrrSdBjEAbL+E/paqP/LGI92txjwi55cRMBYxoc
         YZX7VaUY4M8kjhUMyCZP+Ff2ld866fnHOfKUqMfeCnGCThjT2z5YPSZkFoAZ7sdBWABF
         nVUmT+y4F74AncM1e6UfNqswkCVPuePB1LDbkIS87hD4+2E4/ptr36YA/8zSyc8VfapQ
         oMAedyDc/Scurkq0G1k3rxMWC2drdb55XWCUx4DLOb63cpBRyk7w21zN0URR/l26vo8N
         TrlA==
X-Forwarded-Encrypted: i=1; AJvYcCWdo4qg+lNEjQgXYkIMOkMyYxhFC0coy+4sOjekVJYgYu/T4E0eDPgjIlJ2+Wyr7jzEPBEcPTk8A42dYSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0/hOoL24wkZSKgsZmPDq2B7SxHSkMjTePVg2dVPg+2PZIrion
	RRImT+NW5+dr4G4/nnPWKi9VNCPraDCw675NrFjnmGSOKJn/5IunVivWRaqXdJmtTq5ZnvnGJsb
	FdLNDMTla69bAsw9XKPI8Qg5FcNE=
X-Google-Smtp-Source: AGHT+IE09aP3/PULrOr/3mspUu7EwweMDnAHsWHrWM+0cuo10MQ7uqoW9DZJly+8THAsl1b0u0ZQ0X+rv+9WVzbk90I=
X-Received: by 2002:a05:6a20:4327:b0:1c6:ecf5:4418 with SMTP id
 adf61e73a8af0-1ccee501d0bmr6201698637.4.1725269957610; Mon, 02 Sep 2024
 02:39:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828180129.4046355-1-boqun.feng@gmail.com>
In-Reply-To: <20240828180129.4046355-1-boqun.feng@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 2 Sep 2024 11:39:05 +0200
Message-ID: <CANiq72m1DyAVx4=bg9Hmiayp8jsQsYBirb33S=YN8ptmEu3XsQ@mail.gmail.com>
Subject: Re: [RFC PATCH] rust: Provide correct provenance when constructing THIS_MODULE
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 8:02=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Currently while defining `THIS_MODULE` symbol in `module!()`, the
> pointer used to contruct `ThisModule` is derived from an immutable
> reference of `__this_module`, which means the pointer doesn't have
> the provenance for writting, and that means any write to that pointer
> is UB regardless of data races or not. However, the usage of
> `THIS_MODULE` includes passing this pointer to functions that may write
> to it (probably in unsafe code), and this will create soundness issues.
>
> One way to fix this is using `addr_of_mut!()` but that requires the
> unstable feature "const_mut_refs". So instead of `addr_of_mut()!`,
> an extern static `Opaque` is used here: since `Opaque<T>` is transparent
> to `T`, an extern static `Opaque` will just wrap the C symbol (defined
> in a C compile unit) in an `Opaque`, which provides a pointer with
> writable provenance via `Opaque::get()`. This fix the potential UBs
> because of pointer provenance unmatched.
>
> Reported-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Applied to `rust-fixes` -- thanks everyone!

    Closes: https://rust-for-linux.zulipchat.com/#narrow/stream/x/topic/x/n=
ear/465412664
    Fixes: 1fbde52bde73 ("rust: add `macros` crate")
    Cc: stable@vger.kernel.org # 6.6.x: be2ca1e03965: ("rust: types:
Make Opaque::get const")

    [ Fixed two typos, reworded title. - Miguel ]

For 6.1 we will send a targeted patch via Option 3 instead of
cherry-picking `Opaque` and a bunch of other bits that would be
required.

Cheers,
Miguel

