Return-Path: <linux-kernel+bounces-241289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EDD927966
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51861280E3D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6F21B11F9;
	Thu,  4 Jul 2024 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bxYldRAv"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B76215491
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720105149; cv=none; b=Y8aJO3keMwJPdJlfXiMO6OM4hi+3XOdlQ3SUC7SRfK6yfxVlDPQxZDdRYKp5Y9t7GjsPdqd8erp1uEyN+uNLYMYhfBDT4LhRvA5kOjL1ilRkB5V6heAQn3EZ0SubD4urbwvjVJUck4WfZgOrHibpsQVLRu3lR8/ueQQ7k1kj94E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720105149; c=relaxed/simple;
	bh=WATt3D7J/IVmxltuxLMBwEcE4iWsmNPb4qKThKSzr2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpAufE3a66d7brynWTsVisPNhHbXozRSIjpkP1rNDFDR1ZPJ0Y0Rzowzz7OhNPRsZRvvWSuwk/fZTS0wwhMx4g4cvCIjy+wcVDmxUElOy73Dzkhd35eejUYSwwvHYtMWGWMugakTeATG5SnXVFbA/B/+hRwJtF6HPYLG9+28CzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bxYldRAv; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-36733f09305so446598f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 07:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720105147; x=1720709947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipW5yF2l0h3JDASUEZRIOOwGfpjoQU4vCS+os4NDlfs=;
        b=bxYldRAv6Vt7ItneTQy/pcQsdJnrYyv84EsKjlQ4hQ5MAyTeYijtBAH/9poltQhBJy
         VBKsJ/BAQw5xjfs7l4eHRrTyDY66lcy0uMxrg2fgs8MubeHfhrGJIM3SzhG1His+MR+A
         7FOn5Vhu/qUNpg6pvT7vUq9ZvpbEkiTDAKxmz7OqgthD/m0cE0V70Imr3x+DO/hdvPsi
         N8SrxTOzILTerHWrsVWWZGpg1rxrxzzgkmpdOgYZMtUhWWX3ac3xYeBDDWKrOjlI5Qms
         5Si9KRPy8rJGxabwZXAd/YogktxyD/6aXwirJdxd4OO4IJiSSgpBm8WBOf47s2uc/YoZ
         q3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720105147; x=1720709947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipW5yF2l0h3JDASUEZRIOOwGfpjoQU4vCS+os4NDlfs=;
        b=PdW/mMUp433VUF+iVDznPd17aMBaNDs/PBoys+p9anHrfa6+NiG1cguACTocs/xz8A
         KPwp4ihIOED3V4xDIGGkHUE5Sb1nQqRS4XSEVAGGGwLfZSgRAUC5TYtqVTofeXa61BqF
         h6NCa7S3N2BBkaHnJ7xjuIxAsYTI9LFEebr+NC3TLKXEfQmxnzztkZm/qt4sUgK6xWJP
         kFQ9/HjyKE6FTlFJqGgAbZhUU27HhpT8YIVnvVmTjblug+UfFOzwDjhHf6Mnj9eBPaQw
         2gW5dNdlvD/uXnXxH0+aTEHOjNueHxvIL/ulzc1APQhi9RGQZoj1y8T18tdiHPKsx2tL
         5JBw==
X-Forwarded-Encrypted: i=1; AJvYcCXEcIqIltV4pQ4suF+8axz2E2UWRQAHOkAcUG4hhmHf9olNx6Q6umQsCmkR5Q7XYTrr3o+OhE/4CTa9lEwa+17clqjS8O8IHnrzXUG9
X-Gm-Message-State: AOJu0YwPo9LEv9HlIIfjaQ5/e4B0oG/wUZC5KqmOtY5EjoFsIvBpZ/sk
	yCCENpwYMVB8JMUtyO8UX8W+aI/dxlNGBJGjXjQdRjGPCWBJm+0zmn7B9ZOcFXL6d8eV62PkeVV
	gjlb3KcqzkiF4WGDpo8zt5NWZGlCQ5FCz2ps0
X-Google-Smtp-Source: AGHT+IHiGxLMhUSTF5OSbTLNnCaVI7g8cxF0kLlNGQwwQL9PZ17CqMlQ4bzjGShedrKKcdwCCgJYMl/YYBc5f5VGRgE=
X-Received: by 2002:adf:ff83:0:b0:367:4d9d:568b with SMTP id
 ffacd0b85a97d-3679de96b24mr1510125f8f.68.1720105146546; Thu, 04 Jul 2024
 07:59:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701112448.28638-1-ethan.twardy@gmail.com>
 <20240701112448.28638-5-ethan.twardy@gmail.com> <CAH5fLgi5HdoPzJHZUrS7r3wdQ6GheJDbzGRGKZpk9oC=U6SdHA@mail.gmail.com>
 <D2GU6M1F3QN4.31TYYGTCNHJ9F@gmail.com>
In-Reply-To: <D2GU6M1F3QN4.31TYYGTCNHJ9F@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 4 Jul 2024 16:58:53 +0200
Message-ID: <CAH5fLgi=PPX5aUiN7=kh+z8KHRmbFLLtwGw+XK1Qmf4_-Ye+_g@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] rust: macros: Enable the rest of the tests
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

On Thu, Jul 4, 2024 at 4:49=E2=80=AFPM Ethan D. Twardy <ethan.twardy@gmail.=
com> wrote:
>
> On Thu Jul 4, 2024 at 4:43 AM CDT, Alice Ryhl wrote:
> > On Mon, Jul 1, 2024 at 1:28=E2=80=AFPM Ethan D. Twardy <ethan.twardy@gm=
ail.com> wrote:
> > >
> > > Now that the rusttest target for the macros crate is compiled with th=
e
> > > kernel crate as a dependency, the rest of the rustdoc tests can be
> > > enabled.
> > >
> > > Signed-off-by: Ethan D. Twardy <ethan.twardy@gmail.com>
> >
> > I would drop the newline before `fn main()` here:
> >
> > > @@ -221,6 +248,8 @@ pub fn concat_idents(ts: TokenStream) -> TokenStr=
eam {
> > >  ///         unsafe { bindings::destroy_info(self.raw_info) };
> > >  ///     }
> > >  /// }
> > > +///
> > > +/// # fn main() {}
> > >  /// ```
>
> So close! v3 incoming :). Thank you for your review!

You're welcome :)

Unfortunately, I'm not really able to review the first patch in this series=
.

Alice

