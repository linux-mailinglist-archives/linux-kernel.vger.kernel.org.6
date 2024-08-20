Return-Path: <linux-kernel+bounces-294420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAB0958D74
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69382B25324
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACECC1C37BC;
	Tue, 20 Aug 2024 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fl4395pe"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4C818C92C;
	Tue, 20 Aug 2024 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724175068; cv=none; b=Pf8rS7knm201LGziTJiZTJfZiC2Ck8ybLooiJD9PNZ2huuzBhRUUzHakToWK4nn6WdUQVFNa33GgMcuPnm8XP/4SzhzVJjvcWgGI6wZBctpZ5/J5U00qac2NrplRhiIVYRG3KyPFRAIkt5M5RD1hEnTpVeIjBKP5cf6jVRxfb/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724175068; c=relaxed/simple;
	bh=dhnL7Ice6IFlS8gYAPIlzTuu7a5f0gXAs61HuyASOCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6R18WvbY5tDd4AICHNf9VM5OG9f25I3DgBDlFQgpQgeiDDKUxRhY5dqRcGCCRwEWRGx0ybh1JjlANNBMIhS2I7mglDzM5TgjeOgNJoCObYXkXZBwQ8vvSi9c6RDaOI2hChg6lbjAmlPyX+NeHHuFvCnx7yLLM/sgnCs8+N4D3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fl4395pe; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-428119da952so46878885e9.0;
        Tue, 20 Aug 2024 10:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724175065; x=1724779865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+lMfrKucvnoaMISj0r1o4QzhUsUMyiYhDB1sLk5438=;
        b=Fl4395peZUMLoTm2Qms5DPEBowt9+TQa8UAr8rOyUinSG5g8xtacfZI+qNIbyz7BmO
         5GQDj7OW+wCfjuSoxlQ7Rjjg6tk+YOWz6SFv0oyOj8YPx5Mpe6P8Q0KOIS7pgJnKSJqe
         9oIJ8ixY0UCrKtayvs5LQ82BNYWA4tfyCqvxp9j7Mpk3R4Kst7qXoco3Ug9Oz9qye+bq
         m/G+lDmiSF3gQULfoT1BAIBHR/nh/26CX7M+sC4uDaJFaKhbCGp7n6bEr9Gz6RZFa7NQ
         NMIa+ffngCMMv76f/LgG18B5bDTO4x0xL5mn9lM/6MOgmVoG+K/O03JlvXQoY4+iokSg
         JL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724175065; x=1724779865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+lMfrKucvnoaMISj0r1o4QzhUsUMyiYhDB1sLk5438=;
        b=ttoOCAMQ9NGma/aijsoGv13LVjw9nH16eOtI+kJRE/0gYI4M+5CfzfTSIWdjSsyPmf
         mVU5xHXk+abeLY84gmcpSS1atTHQ/sqmqecQ3QsYMchgShFYEWP7p9sYsnTR2jIfP/WS
         phSPTnjudLL1ITDdPdcuPymURqlwak1m8LXbfYwBDbzN9vZYxgiNlTUDGPmQA5c+w9/0
         E1Zw7yfE6Q3CLsJWDoPEIz8ZtQsakdD1aJVIQn8581G5RWL+q2Qd3nvDfPJVcpOgvujs
         O6OgLSzoYmBLwSaD8DFzQM929EHQp1jLACqPya7ir7F/b0edjG8oH55k7j/ItFL71iqE
         oHzw==
X-Forwarded-Encrypted: i=1; AJvYcCXGCiBkEdkwXArB4ZBgh/YkoGxIIBxV9I2DsQ1o4UfePsmX2+Jjy8ULve6CFngM/lT2spBZutMDki2IhxRLPAeX3XjUAVEam3z8BUyP8d0Ce+KUqz6XS1pkQ2U53HlNLxsSrK2HBWJfMKTmwpQ=
X-Gm-Message-State: AOJu0Yxr4PjLLuW8PzT0yEFVIjqoA9zPIv/WizmJ/DnXieZywIKeLju9
	gLOU5NdWbxOayFms6SEp8EMkxwXPH9yf5LTnTehiVXKT1Td+wOh+6mjFmzfp35RX8nMDcI7eGop
	t9Dxi/qm5eO6OuEd0QkNie8K8L8c=
X-Google-Smtp-Source: AGHT+IHV1ZaeD059ght634j4ApgDFpyM5xjkkUWHwxingOJeTAnC3d6MqvJc04/4wT+nNwT/olUJKBcDmvPXmwIVq+s=
X-Received: by 2002:a05:600c:45d0:b0:426:6edb:7e14 with SMTP id
 5b1f17b1804b1-42abd2571aemr487465e9.35.1724175064325; Tue, 20 Aug 2024
 10:31:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819213534.4080408-1-mmaurer@google.com> <20240819213534.4080408-4-mmaurer@google.com>
In-Reply-To: <20240819213534.4080408-4-mmaurer@google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 20 Aug 2024 19:30:53 +0200
Message-ID: <CA+fCnZcN9BSvhj3iQNVAiudkMFg3kCPBgDJQoJshx3BJx3N2qQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] rust: kasan: Rust does not support KHWASAN
To: Matthew Maurer <mmaurer@google.com>
Cc: dvyukov@google.com, ojeda@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Petr Mladek <pmladek@suse.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yoann Congal <yoann.congal@smile.fr>, Kees Cook <keescook@chromium.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alice Ryhl <aliceryhl@google.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	samitolvanen@google.com, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	glider@google.com, ryabinin.a.a@gmail.com, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 11:35=E2=80=AFPM Matthew Maurer <mmaurer@google.com=
> wrote:
>
> Rust does not yet have support for software tags. Prevent RUST from
> being selected if KASAN_SW_TAGS is enabled.
>
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> ---
>  init/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 72404c1f2157..a8c3a289895e 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1907,6 +1907,7 @@ config RUST
>         depends on !GCC_PLUGINS
>         depends on !RANDSTRUCT
>         depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
> +       depends on !KASAN_SW_TAGS
>         help
>           Enables Rust support in the kernel.
>
> --
> 2.46.0.184.g6999bdac58-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

