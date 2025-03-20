Return-Path: <linux-kernel+bounces-569471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A207FA6A368
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10A2C179485
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF31215783;
	Thu, 20 Mar 2025 10:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddn2M+9I"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5555B33E4;
	Thu, 20 Mar 2025 10:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742465840; cv=none; b=UzUqhNDOEqEd9DnVeSMF21JA6lqpwpEVEZDCnoYhFvmFdvFCitAzn6H4UZJnpZhH/EwwLArMORlV821iGIlboFjjB3EX3otNe9cAad+XQBMo98hgCU5p/RZe2EMlT8huRIS4sFK01+AXl9PLbT+IdaY49AvxuPxNkk1PfRm2f+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742465840; c=relaxed/simple;
	bh=8FwI3dNTXsuUp+UusLgEoQFB4n9H7qEmcgfplOt3LT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9ivOK81O0yGF1XReAFk74TaonV/xMsytVf+gzgSsc9QYiUXs/IT4kJCLX5mY7izt6lEnKPc/MSOduWwHBjCZMWRJhin44+0HPh6E7HhGzI09X49IjecZb1mLKKIrOCcJo9iWdqY/GYpjKAh545FScJ30jroFiZCbkS3r4Ri80E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddn2M+9I; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54acc04516fso635176e87.0;
        Thu, 20 Mar 2025 03:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742465836; x=1743070636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FwI3dNTXsuUp+UusLgEoQFB4n9H7qEmcgfplOt3LT8=;
        b=ddn2M+9IF85eZVzjiIFw6ECKJOgjkfivmCUxTeyNZfDO3P2epXHYjOWWDX9h93cMlQ
         20ws0y31vFvheTnUpQFEwAFy/lA17Dol5sL0MfQnK5x3DtJWz9P9aDFAEJv5/K+qB2ai
         rrdagQ2B8/zrnUPoztrsXFCwtVKB+H67xXzLFJIc1SFJaT2i+VEIkrqntiIAI7DbO+Ql
         m3+oorY2E2wJxxbf61jZxn/1gTQm9m0QBngnZhwSMrjgHGbkYnK40XaM8QQy9fq9rdjb
         vbc/wYct9NywLglWrdJPGrjPSen09I9OB8qyuF0fPukyB82Hnot/6aMUoirSsDJ/5koF
         2Fww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742465836; x=1743070636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FwI3dNTXsuUp+UusLgEoQFB4n9H7qEmcgfplOt3LT8=;
        b=j/gSJ84EUKwXWIgU3O7RA7AHWVm6UyvkpxLA2GwJ5FR172fTzsxZqyHzGQwhF6bFi2
         HShRVE/OzqJeeeAFAl1Q4QvFMZyYkkoC0FM1i3OZSx0RVnT+lGfV0FyOBAWj95p8cCna
         LDuB9TCxJypWujSBHk4xgOARFaq0GhY04ZKMVU1czD2JUj86GS6VCwxyv4a5xiOOz4wZ
         mYQNsO9m6iBhwefwf4/VB+jhXQPjV15mkT/vDfTEUPgOTlQ7g7lNtIQbqmkhnUJQbLEX
         A1xoKEcHvYb0Vm2VTD2e1DL2ry5rnANCRwZ2eiH0Ut9x2BdZKqV5hYpOkKz1rIi0ZSrE
         nKIA==
X-Forwarded-Encrypted: i=1; AJvYcCUQzY8+NE+DOw7YjjHB4i/+SpCuuTOL2w/OrJ/x/IrqKqYVXLErR0RfK+cxdyrKkHI9mJz4bTo4cblUDYTv9ko=@vger.kernel.org, AJvYcCXgNihrh0MLSgdmA6SXVOxbOBfSj55yNwfGQwThTVoiri3LM7WFTqapOtK3zkt8mCI5o7JIjL9wUpYQy38=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRg99cuYE06rywFLIh9MtXLOjN4UtJRGzZMRe/GqPPyPYSVRdi
	9GzElxChFegNvKKQjvSabDMhejwes7hmd0No1wu8oEeuiBn8gpSNHDdSer0IaC55wTtGPKw22nj
	ix4fsVXzX3/a9YT2s/BGNXjV7LDI=
X-Gm-Gg: ASbGnctr518PmrQiiT/y96kIj1+JShn/iDnB9BM20vqHUzRLh1c84oUeVqhUr5ILDVr
	CaQlTxOiRCcUnnNbyGIWww24k2KTGUoYgKIqO8O9RWyMZ/vyDPo5nDXnwpK4O/9Mndwm9Mr34sk
	5XaikL4fRsAkNje4f3n+lBz9X3anLT531rIyiYIbr9qgdvkN0gSqdSQMMm0iib
X-Google-Smtp-Source: AGHT+IFlvt70meSzfgewn33Q5PeaIXoxXNPwyuQFKujMLyrUZl4JP6t9irCBeonUXVkCKzLTf07K5E+psootTwspXuE=
X-Received: by 2002:a05:6512:1094:b0:549:903a:1c0 with SMTP id
 2adb3069b0e04-54ad0619da7mr847267e87.8.1742465835967; Thu, 20 Mar 2025
 03:17:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319-pin-init-internal-quote-v1-1-19de6a33a257@gmail.com> <Z9vH6qSAx2Hps3SX@google.com>
In-Reply-To: <Z9vH6qSAx2Hps3SX@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 20 Mar 2025 06:16:39 -0400
X-Gm-Features: AQ5f1JppL2AYeeh0o-mldl0yYUWvB6bwqZnxP09bQxBtlYY2Gu8vfuS2Loahtbw
Message-ID: <CAJ-ks9==tw30HK-jFpXtfjEoU_Bo-GkGxVvM8WtFG_2i093MmA@mail.gmail.com>
Subject: Re: [PATCH] rust: pin_init_internal: fix rust-analyzer `mod quote`
To: Alice Ryhl <aliceryhl@google.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 3:46=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Wed, Mar 19, 2025 at 09:35:40PM -0400, Tamir Duberstein wrote:
> > Replace the `#[path]` attribute with a symlink to work around a
> > limitation in rust-analyzer that requires all modules to belong to the
> > same "source root". This allows code navigation from `pin_init_internal=
`
> > to `quote` to work properly.
> >
> > Link: https://github.com/rust-lang/rust-analyzer/issues/3898
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> Are we allowed to have symlinks?

There are 77 symlinks in the kernel by my count. Perhaps most
interesting are these:

include/dt-bindings/clock/qcom,dispcc-sm8150.h
include/dt-bindings/clock/qcom,dispcc-sm8350.h
include/dt-bindings/clock/qcom,sm8650-dispcc.h
include/dt-bindings/input/linux-event-codes.h

I'm not sure if there are further criteria we need to satisfy.

