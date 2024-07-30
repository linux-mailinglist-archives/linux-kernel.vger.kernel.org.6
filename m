Return-Path: <linux-kernel+bounces-267906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E858B941AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAA6CB23DF7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99335189503;
	Tue, 30 Jul 2024 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dRa1PddM"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5D6187FF6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357856; cv=none; b=o1k8zkjVUBfYEaYcGTixP5XJeEXyaUAaW81UXN/969pQs0dJYz5JoZk/pR8ctzbe0mZ/AIDO4xxCQrA5aFnGDUwh4tk0wUYn09ogrxwL9SxNZfb9JLuTDV2IVVAmzA/bqCmuCs1E46McrYzFSTHdhw22B+hWQdvM3wA0ftDu5xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357856; c=relaxed/simple;
	bh=/9OG9y6hP+6SfnI18c2tJ5kPmALXdgpYpAlvKpnHS3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQuRVsnZhPMLDwXnq2yKmOTDKIsWELis8YIbbqJeub7HpzL5eh9DSYAusMWp5Hiab/auqAaqnZGu2MHm0ZqsgQd3WVon+cNkEvtP0NkVi/2Z0yxkQNg/j4auYsjpKVoVt6l4At1qkokLbTToM0POnp1UKZXGa+lOyotK0OlWMj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dRa1PddM; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-368440b073bso35349f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722357854; x=1722962654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5021+fwAvRxGdu5GI9N27lF6o38chWudSfjBKY3WxUk=;
        b=dRa1PddMw6EVRFsTvLXVGEzKHoWryOAOCmYhbIKcCR+pHLxDvetRxcnQ/sCB6UCt7R
         W4L5giBcM64RnTiW2sAph+NOZafJ9VCOnsHLLO1rAgkt07UimtUfsPbu+B9OIXWoLQf1
         bavzFiXOOEUCsQ8kyCCMUl7brQGz1dqaw56/3hTV0t4UxPeDh6U0qVJgYuByM563JZth
         kQBbbfkB4d9IbbBj5Vbre5o7P67sZooSESHxFtVDAiFYbsPY3O59VTryg0Yy6BYmB3lW
         cUxPHu32xbWRbbMTE6khzLuONxqUQEHVYYh49d06cksHtxyDOTzZQ8bstMxhB2ZkNQtX
         IX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722357854; x=1722962654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5021+fwAvRxGdu5GI9N27lF6o38chWudSfjBKY3WxUk=;
        b=Ya1r9GQxqy+00C4CqhJF3vhnQp0NvDHEOMPtqebpF6KNJ7HzsoTqN6hzSofsTalc9y
         O2nMqV3ZmI+t2aGVdU7Vw5/znxkFqtJ0eBb6ROFpajAEBhy0WZsGcAcQYJ9AGtu3U/4V
         tnWkO4/lWJKsmLrC/OsjnwkoDs69XYVQHVLH26S0t0x2nu5+GX9DuuYxfSnlsEci/dS5
         kW7YRVK4CIx9SpbUItOIs5aXvA6aCEYUVCv1/C+4NNJ88MbuLq0aNLNKfVYTfv7i0weu
         AOcoYuuMNvgLgJrd8j0P55pxQn+n9YXHf6cyLjYfH4kqOYteGuiH75VObYgFk63tEYGf
         AYWw==
X-Forwarded-Encrypted: i=1; AJvYcCWPcepc/FNAV1wjg4phVRE86UhZhUdGKdnnNGgpNcA1wqgdjA8a0fZT3XlojdaMdMX5TPkpGHnwv32XZItYk9vH3UUDERK71I5XTZuE
X-Gm-Message-State: AOJu0YwfyAipOq32L4HCf4sm1CP9JT9hKY/FnWiu478L3HjTQ1nWCc6E
	wyHrP3aSbf5Eiq4o2hPrpgQjkIWVo3MoF1WA4wyVfvTG5qohZfGTqPuh2Z7dWEOh+5AtIggUhUz
	vePrp6371w9jC+pkydFvUu+duX1nDZBbMRBu5
X-Google-Smtp-Source: AGHT+IFyPEWVu13a/JXKYRwNhAY0ulJH7mLayPlDw+oEoMsOSEDWr2v4wLogU1iA2qYMBVhWygDzrgUTv0poXAGRpBA=
X-Received: by 2002:adf:e2c5:0:b0:367:8e63:4da4 with SMTP id
 ffacd0b85a97d-36b8c8e9959mr1768784f8f.14.1722357853484; Tue, 30 Jul 2024
 09:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-kcfi-v1-0-bbb948752a30@google.com> <20240730-kcfi-v1-2-bbb948752a30@google.com>
 <CANiq72mshrgXJLw+AZ+ovfhZXjYYfgQLdyYdW_v0FmdWdEjvbg@mail.gmail.com>
In-Reply-To: <CANiq72mshrgXJLw+AZ+ovfhZXjYYfgQLdyYdW_v0FmdWdEjvbg@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 30 Jul 2024 18:44:01 +0200
Message-ID: <CAH5fLghu8Gy8copyBgcBknMN7GaikhYZb57M0Ye2_xANW6YzoQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: cfi: add support for CFI_CLANG with Rust
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Sami Tolvanen <samitolvanen@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Matthew Maurer <mmaurer@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 1:51=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Jul 30, 2024 at 11:40=E2=80=AFAM Alice Ryhl <aliceryhl@google.com=
> wrote:
> >
> > +       RS_FLAGS_CFI   :=3D -Zsanitizer=3Dkcfi -Zsanitizer-cfi-normaliz=
e-integers
>
> Before I forget: this should probably be `RUSTC_...` for consistency
> with the rest (and, in this case, these are flags, so it makes sense
> they target the particular compiler).

Hmm. It seems like the existing variables containing rustc flags just
use RUST not RUSTC in the name?

Alice

