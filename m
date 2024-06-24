Return-Path: <linux-kernel+bounces-226862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC44A9144EA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F991F210B3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3585380F;
	Mon, 24 Jun 2024 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DIva3t9d"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E9FBA2E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719217971; cv=none; b=XystutZp/NLX0ea6JvaWXRLj8d4qVFdnicBd/pGzvdgY08kxHoy+2iQ1ftre8DVmlddqfGWEOeHtRCuMH2jYAez1TSaIi4zFZlTxhyUREYzyIvRIbn7GX0LmU9mNwrHkURl7zXmOXnVe0kVXEa+j5dCMPB6roC4EhiF3EHau/rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719217971; c=relaxed/simple;
	bh=91kCvRf6U070uqcc0kpaGohQwSZ5TCT2Z+sMB0QGgTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSUIOtepAQMYsblyKNJ6jxjY5g75iNcXI2r3NkjkcfP4yVI44Ps+dNYcvfn1jw8fUkHvT3C6SjgyKrJRLdHgTBy9gMC3n+wf11y2qmxcfY/t5rco80OaXWnoN8CG0Hx4A3/IHS5qVn0OSckoR5weE1WPZuOwErQ4cqFALuE+3tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DIva3t9d; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-424798859dfso33705885e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 01:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719217968; x=1719822768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91kCvRf6U070uqcc0kpaGohQwSZ5TCT2Z+sMB0QGgTg=;
        b=DIva3t9dG+E1gYVdlWHy+7nFIigj+Utl45lfi1ZhaY6Ji67WM+L+5WHYhchZUJ+lfH
         jmiVQ7OoGRxBi6fwtE88lVqE2sDcG+ScKCoNHX3ZwoT6iTAPrtRSrmVHN0F8d68I/MiG
         vxBXcIgCe6zXlkUQjhVw0ZPb+J3KBhJtSJxn9RfGLrQSqCRTDze4sEvwXuOXSWAUFe0W
         5vZJ9uHN8cow8+4NbPV+f2qllHnkEZmxBlq1HOzbN5EvHEjaqBQCuPmXjGf6Xz6Moeal
         dYDKzMmTaXhA/PIjCPflTNxfRkbUEEIv/g15dTqjw5jyLQLZuqOIU8Oa9/NUymY7sR8W
         ScuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719217968; x=1719822768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91kCvRf6U070uqcc0kpaGohQwSZ5TCT2Z+sMB0QGgTg=;
        b=oMidRPX76YLMPWAtsuEEaZPZ3A4lSnAR3AKYGH9YvJeponEbK9jnTH/RJN3mzCCl8x
         6co/BePf9DkAYw/QkfkaRoA16eTUkEVFY+ahA42S7+7z1Z7LAPFmm93Mhr+Z+NNTiMHq
         FgYgteBRqUhzIZ44BL8AyTNtTryslAykwyBTvKYY6STptdSthQSqCZUvmnqk9Nf65rTC
         otBTef2KoZoxHSvxY5FyqE1/YrkuzSzdSZXAylcKJp9AghIRu7RVd6hhBoX/fN4pXAXP
         B1RvhBhIEFKSGGlF8q6Qpanbm8VYiSjdgPdLzWqnud3uU1dlB4p8QsIXrjeWMW5HHzrY
         IFTw==
X-Forwarded-Encrypted: i=1; AJvYcCXmg1cZxa2kyNo+ybZyTvW2/4huJXTZdqESSy2PejGwza5Hj004xXtdBAJaz1yXg2ZHrxKxY98xy9mt3oE0GNEWYjGvA3e0EJSQ1pOj
X-Gm-Message-State: AOJu0YyrtWaCugcG5kY4X601eVj06oBB2si8bfxRR6Dhb9zFHquF6Wv7
	Q04s5t2pfCbZVZdFXUkepGRk4QBTWye7vl0mUDW8Tr1q/otLEnNFSt8pmCScMForLXMPROLvrZ+
	FgYOhpBZ8lzME4PEwFzSaBgFXf2r95llLm5AZ
X-Google-Smtp-Source: AGHT+IFn76On24MNlNofBDrWjme9ZSj4M+IQh4Lbkedj9Mocpw7shk0nv7U0/Z7EFsaFthtTUZmaHvUnEM/C7IpsJig=
X-Received: by 2002:a5d:6985:0:b0:35f:2364:f1d9 with SMTP id
 ffacd0b85a97d-366e96567b8mr2202375f8f.61.1719217967872; Mon, 24 Jun 2024
 01:32:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624030327.90301-1-ethan.twardy@gmail.com> <20240624030327.90301-3-ethan.twardy@gmail.com>
In-Reply-To: <20240624030327.90301-3-ethan.twardy@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 24 Jun 2024 10:32:35 +0200
Message-ID: <CAH5fLghDZdt57SShnzUx_ZeBquqm-3fah3CK9YAwMYHAJdteQw@mail.gmail.com>
Subject: Re: [PATCH 2/4] rust: Enable test for macros::module
To: "Ethan D. Twardy" <ethan.twardy@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, 
	Aswin Unnikrishnan <aswinunni01@gmail.com>, "open list:RUST" <rust-for-linux@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 5:04=E2=80=AFAM Ethan D. Twardy <ethan.twardy@gmail=
.com> wrote:
>
> Previously, this test was ignored due to a missing necessary dependency
> on the `kernel` crate.
>
> Signed-off-by: Ethan D. Twardy <ethan.twardy@gmail.com>

It may be worth to call out in the commit message that you are
changing what the example does. (But the change is good - this form of
kernel parameters were never upstreamed.)

With the commit message updated:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Oh, also, you don't want an empty line between } and `# fn main() {}`
as it will show up as a weird empty line at the end of the example.

Alice

