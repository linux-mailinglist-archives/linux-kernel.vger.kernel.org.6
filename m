Return-Path: <linux-kernel+bounces-356965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CF1996976
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35FD81C227C3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5E9192D96;
	Wed,  9 Oct 2024 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="094RUNNc"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF237192B97
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 12:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728475355; cv=none; b=ux3ysd6b1LxrpaKrAzf/oOi1xDLFy5K2U6tEel6OMx7PHAQHmUDDWoEYoHnALYinHQb3k+vZ7R1tk3buBZSoak5e13XkwWJXL6FKI1DXCN2NGjD1T99apiMRcIM3owjGGgNN2my9ebM/iVlIe42V/2gMGau3DzEXJx/XD4t7iaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728475355; c=relaxed/simple;
	bh=d0d0vbIjxKlT5RMhMyYh9iNcFRAx7FDRHnCkb6Nc+Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edyAiM3pe+Rn2hTXjACI8tY+ph3zwY5PhgniCPZKJwwXhu/xOxnLpHj6tPzkAginJep4WKWfpeCZvUbMYr+oX9eWnDRCuetGC0spH71vM6VNtp0h68EfRYOR3e0AvRj24IjSBxgCOXY3cPfRQu7HBfVKdQKtpUcgvCXbYMs7pDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=094RUNNc; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2facf40737eso75076041fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 05:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728475352; x=1729080152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0d0vbIjxKlT5RMhMyYh9iNcFRAx7FDRHnCkb6Nc+Po=;
        b=094RUNNccfdj9BPn6etOfmu2SOQYDH5bfIoiZL7YiNQJo8PyNsney7S2b9zVIUMFue
         X/zKOnqR4tVACpBPmYmRQHXvRKGFxrqic3bBiFf9KkEeXsgjjc+rGnNI5ZlgM7/7vm4g
         daLZAM13lLkU0isdUifrGYqjGoeJfdxRQqAbB5e2/kB6Ut/Nqi4oCRlZmXHewHckzg5Q
         MEjIyzZLvJZ5JjG7VUuFjBz0CnvpIhq+psopn7V916InGXHfMjlMZNNhoov0cRbkaEXf
         VtoYTNQW8NmRVmlg20MtlQH5t1w3BB82iMZOtgjVmgvOAeHHk9frYWMLOxZH/uhwrnAC
         ff2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728475352; x=1729080152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0d0vbIjxKlT5RMhMyYh9iNcFRAx7FDRHnCkb6Nc+Po=;
        b=dXDrCJl6pbEXD5vU15GvSlbOxSLJUEmwXN6ouRFfXfwAyy54s4ZuQswEfBeG4c9wMa
         ACK6H1/WmZXphEu+NT/Shjg6LBgmBAuPvTHa8I5fww9awNvkimPWj1AsbWYqp26P5I6v
         5Vkah6qk8h0Zp793Ks9HR2bd1mhjCwI7xrPDm7e6VBZV7NXBM+5TzFMCW5fHF7ErxEWS
         SbLjCgzOwVcVLWPiLba1g6AU4IxWXHuL0vwNLN9bINMrZ5fvqOZz44XecYPe9eFlYp6q
         2QPoGAAIIhKx+N5EsXMRdqJfdJ7WHs5o4nsOjFrWwuvR+9KTSOo/X2efusqmbBESf7gc
         KquA==
X-Forwarded-Encrypted: i=1; AJvYcCV+/Bw1yKYp3rm/ICXUDpZhz13IH8SAYMIekByCr0ZqjtMu6RXOqYu6VnCX6Qw8ZzyZnFy3ILbIy18nIR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb7TY7ik0GGDcPxH11r/H2xVTy0VEHdd6IkVb00qZQ3ZMphbph
	kRe19K11QCpnnUsxSkmHOE+w8uMrCVYPSFI9ANeRwAhDFb9ZsDDGnZWfHjWIMrFXrtorfombbXA
	m4YBjTuaDyWKd3G99HurPTqur0H63U3Iw1+tU
X-Google-Smtp-Source: AGHT+IH+QlKgtlwzTqoKPr7pabfTtIKf/Dn6uN0z7IhEKa8GkYkV6bH6FebX2gMi8V7F78F8sBbeluZEzIHLWyDgLaQ=
X-Received: by 2002:a2e:4a0a:0:b0:2f6:5921:f35b with SMTP id
 38308e7fff4ca-2fb1878f46fmr12619671fa.27.1728475351720; Wed, 09 Oct 2024
 05:02:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009102821.2675718-1-masahiroy@kernel.org>
In-Reply-To: <20241009102821.2675718-1-masahiroy@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 9 Oct 2024 14:02:18 +0200
Message-ID: <CAH5fLggMUPPbE1nW9PCHhhAXcVTia4TU7ARfJwp_GRNpb-51_Q@mail.gmail.com>
Subject: Re: [PATCH] kbuild: refactor cc-option-yn, cc-disable-warning,
 rust-option-yn macros
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Matthew Maurer <mmaurer@google.com>, rust-for-linux@vger.kernel.org, 
	Alex Gaynor <alex.gaynor@gmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Benno Lossin <benno.lossin@proton.me>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Trevor Gross <tmgross@umich.edu>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 12:28=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> cc-option-yn and cc-disable-warning duplicate the compile command seen
> a few lines above. These can be defined based on cc-option.
>
> I also refactored rustc-option-yn in the same way, although there are
> currently no users of it.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> This avoids applying similar fixes to rustc-option and rustc-option-yn.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

