Return-Path: <linux-kernel+bounces-207847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7F9901CF4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990731C20DCA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5406F31D;
	Mon, 10 Jun 2024 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r0JuEdTO"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8000038DFC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718008219; cv=none; b=FeOBvNOhmI9vdYqQT9ItmYB/zsKjEbrjo5AnDsUQl9wUnTzk9ih851P1w54ou/8LqgMkminPKs4Xl0yyF9mqpnGvXhPJoGbG7emV7KyMRd5Bl8zVMMNrT7fJ3N1zlbmSwC5FKEm4XEsmA4GNIBTk/8B8Y+0SK5nZEl2AiCAD6FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718008219; c=relaxed/simple;
	bh=ZrQXB5sq9y+EJn888M/eWGe31yz976GHUoxEVuvXVQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b0/kwJJj6rcMGg9vzqCmzpaeg/ckgGRwqA2ap6WpmGknOQLRrTJSmAx7nxjh8XHrRyEwq/coC/wJrltwurxHpE5w5w4Jhg8NUabIURqEtZKIzIWPzjZYqdXLGiWnQTtXqun1M7owxMwP9IFdRlQPZZtRftB2Abzhc18IDgAtaZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r0JuEdTO; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35f06861ae6so2084743f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 01:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718008216; x=1718613016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikZtrGjNtsw8eqbnsEbMWgcSlq9bAYVZbEsIK9DE49I=;
        b=r0JuEdTOE0IjupGsxmt6sx99ckqT4B+YnwXt52zTF6K5nwlarnnsQea930x6r5KMsZ
         DHkQaxSeING2yFBvrqz0coJ3HuXxSvrNYVKwLr3NJu9p0Lnr9A78fFjwFETHuyQ0fJ5U
         8lHBYhby0hDcR+NpDDzuEMs1iCLuEzWL/RKP7N0gPaDarwNhIVmqrkPzMUDdPuPJVtsJ
         dyYrsmOpmKe+liCQI+laKvalg9Vf7Y4yvP+0fJVPc4mwdi6gm8Ia2W/w0KUDUXqyyxWe
         hICQ7NIhx13M8HylJnpU4y6tFZqcgEGvkDiOk33LpXzhyuITU3D38WpbVOx4zbetejHd
         W5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718008216; x=1718613016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikZtrGjNtsw8eqbnsEbMWgcSlq9bAYVZbEsIK9DE49I=;
        b=p4lBQXNhUHQgYFlgl2F1L3FLItdEEqCHnyl7Haawbomm/5GXxkJi46k1bTjsIb5sOS
         4mBu1m4LKE4yHmicEvbY3VWr9TApc6bZTCUvBqm65fS6crsEUQy0HQz+V5OK38yih2d9
         oZ6feAJK3Fp3KWBoqALK5Tz6udYb14oZmv+6IHXaUfHXxaJNr7VgHRzRW7l9vHcDuuDy
         stvlhi3GTN9onuEIltuLgfJghxGx3HWrRsMFC4eHT4OcBssUBYfNea89d2EjRvySeB8I
         Qdesm8BmpQSQwp1wHuZhjTsXLFm6sM3bK87GGDcZYMRnmXkkVkQEp7bwHdp0iPXcMTMO
         K8Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVvfiA/PRx3Yo2pz+G3KqK78Yo0FCo7KPDGTkS69kAJDaudmd0fxIEvekFbHmjdltdfIcy98xiHP63l7SJlFf9vntJWkjqu2CauTXgM
X-Gm-Message-State: AOJu0YxX1FfqcbC+CNKtxOshrBFRYUgu9cY3rB5AATrC/Pt2XTZqvKn+
	TdXeKobTj02K/a2iyN648INRSoWkHiGMUYZNHgza2rchBw+ahb0AF6tA+wp04cipxcCTQrMIbux
	aSVbbyUi0chQNU4dn2AYj1Vqnwi54o1+hIKnO
X-Google-Smtp-Source: AGHT+IGcdDEvr50Ma0CZTKPkSeYP1ylY+l2mXGOD8+zgOCruJaXcj40eBmVe9MAZ56jPE/j2/rkdCuKIx0jfTqIxvHQ=
X-Received: by 2002:a5d:5f41:0:b0:354:f724:6417 with SMTP id
 ffacd0b85a97d-35efed2b4cemr6903257f8f.12.1718008215068; Mon, 10 Jun 2024
 01:30:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717750631.git.viresh.kumar@linaro.org> <dc156230814a899e5e3ffb6f3a0e5471d92506de.1717750631.git.viresh.kumar@linaro.org>
 <epir3.2kxc5jzd28c@linaro.org>
In-Reply-To: <epir3.2kxc5jzd28c@linaro.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 10 Jun 2024 10:30:01 +0200
Message-ID: <CAH5fLgiWsWaqTTv5=tA6-+LnpFF62vF8P7NNraSNHbM+h0AZuA@mail.gmail.com>
Subject: Re: [RFC PATCH V2 2/8] rust: Extend OPP bindings for the OPP table
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6_rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, 
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org, 
	Erik Schilling <erik.schilling@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>, 
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 1:04=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> On Fri, 07 Jun 2024 12:12, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >+/// OPP search types.
> >+#[derive(Copy, Clone, Debug, Eq, PartialEq)]
> >+pub enum SearchType {
> >+    /// Search for exact value.
> >+    Exact,
> >+    /// Search for highest value less than equal to value.
> >+    Floor,
> >+    /// Search for lowest value greater than equal to value.
> >+    Ceil,
> >+}
>
> Seeing this enum made me think about memory layouts which are not stable
> in Rust and can change between compilations unless they have a specific
> `repr`.
>
> Not related to this series directly, has there been discussion about
> guaranteeing struct layouts in kernel APIs? It'd require a lot of things
> to happen to cause a problem (multiple users of an API in the kernel in
> separate compilation units maybe even compiled with different rustc
> versions).

If you have two compilation units A and B where A depends on B, then
part of the input to `rustc A` will be the metadata emitted by `rustc
B`, which contains enough information to ensure that they agree on the
layout of structs defined in B. The metadata format is unstable and
changes each rustc release, so you cannot mix different rustc
compilers.

Alice

