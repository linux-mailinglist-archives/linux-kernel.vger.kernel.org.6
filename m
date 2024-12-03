Return-Path: <linux-kernel+bounces-429808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293EA9E2790
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FE5CB284AF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9520A1F76CD;
	Tue,  3 Dec 2024 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQqzOTRF"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768E71F7561;
	Tue,  3 Dec 2024 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733241714; cv=none; b=LIpLKVRIac7J6cMvnHAwJHTGZMmMkle7s0b5C3CDi8iggg5SYt1bHBIBf0l2h3kEJwN/qTJVIdsnMrtHHMolNgjOnXCxCIHh764wUqx+YyREqjZF9cl98v/U/bHlIfK5SOvkhrT+msW2JfKMduafTdAv4hYFVmef+G0cOB4e258=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733241714; c=relaxed/simple;
	bh=HElT2R9P9ig84rKSVqEPmPesnPqPUxhHyF6xTeixoHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=chLkYBmaPkQUgM50CuZtJAa/3lu95X0RKdUt2E4BvypcHN3MbS3ZCwNw72tqwKOm5hCmWp/etz2b4ZJXcSdTd9IwBzT7VguDwBd4VgdEPIfnXQW8kueMJleFmhpaTQ79SWe019fQRHCzBDF0bi/uent72fcYYLQ1fsL/pchN71g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQqzOTRF; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3001490ba93so4100521fa.0;
        Tue, 03 Dec 2024 08:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733241711; x=1733846511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HElT2R9P9ig84rKSVqEPmPesnPqPUxhHyF6xTeixoHs=;
        b=AQqzOTRF482TEXwtG3zKSAL1tPYuV3SfhURUqFGIN/OtfcPSSYqwYQ9l+QGIrGWxqt
         cYWBjKi3ebIc1Yxg/Og9hLy3uf5UV3I3CIY1xOE6lSugLsga60kh+4Gge6MLwq4oZxjz
         U8iedNDXHlmxHh6TvzxfZ8N7XDSEC+DuAtgXE5HJWOvrx8nN6cGwVQzRIk1M8eyhaErg
         WFAGSimfTb/c3/Pnvdxhbx9eY3acvloVYjAgNSigZZi+TAYUEGhPlMjymnnd+X9C/dbo
         VOLksKQeA2E6Zd0BWqCd1KckRkVWEyY0CAJb7PK7c5dhn4UrWr3tsE6FmiimD/unaBel
         ycsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733241711; x=1733846511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HElT2R9P9ig84rKSVqEPmPesnPqPUxhHyF6xTeixoHs=;
        b=r+BZGgkf89FfEZ7gKOWVNFBT4bpfsLRlNKf8Dsnclp/dw6AytW4AmjOhqlnQRFVu6M
         KwN+uA434ySj3cqcIq6NvVmM/w14hn+dQAQIi8McE2XyUFs94AC8pkKADYb4ESN469B6
         hYjiKggQ7Y++/xbPUqa8jsTCV0xbBB2446+CfjekgoZ78awAjSO8jBnPR1I+BOdm2CAs
         tu5oSQxFZncWE2IgzHw0cWCD0Taw1Kx/4C1K5D1Tpt1Np8p2Bj5EJmcIYKBINbzrOn0L
         fGi3lruf+lwCfqTSKAKG79fiFTI3gL+/TzptHZTG+71dt28GPPBZ6NAzAcBMxRmc6tjB
         zZ6A==
X-Forwarded-Encrypted: i=1; AJvYcCU7rmx060p2hctmuw6KU/NWDLRh/oQu+2wZ16p1BYpnZkdjt/AvnKfV7JclbWZQDdl07VOa6oN45Q6MO64=@vger.kernel.org, AJvYcCUioEqQjEpalsCXvZOiaFJ20U9mgCNeOQ0bzxmlPlCoGq4B4vhD6Ba1319kXUlbqmdN1dKQVJr7juIKNO76uR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjvOZ+AVSwJXe5xfCIderKIK9UIZAbqRzPnDq2DykjRSCc+A1c
	QYqC2GT83PsJsopCmqMK7CNGFvwGXwThZOGG0ejeF8dP/RpCrjp157M05uQPEED0bm+T18UGr9/
	TXODEXI5qN7fcmL7up+n8v5B/MyQ=
X-Gm-Gg: ASbGncvX6Tpx7jPyfJtoR4LOKHiW5bg8N49abRPdcPCXnTZadfqK0Ie5ZrEzN+xfzOh
	L1k8J4Q1GalaAXaaBT0kc8aEMF9/WncDu/fTgpPX2bZFkGAE=
X-Google-Smtp-Source: AGHT+IGZfuPFNffxbLr0xy9VP/0yB1MDOKC+PdAQaAXMR4/7SWNPzO+I8xLTJRMP06lQFnCuMgClits/4WkjTZviTb8=
X-Received: by 2002:a2e:be8d:0:b0:2ff:cc65:68aa with SMTP id
 38308e7fff4ca-30009d07fc6mr20356311fa.31.1733241710177; Tue, 03 Dec 2024
 08:01:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-rust-xarray-bindings-v10-0-a25b2b0bf582@gmail.com>
 <20241120-rust-xarray-bindings-v10-2-a25b2b0bf582@gmail.com>
 <CAH5fLgipntMtu7_pdZDZGerGRO499yxDdz2dP=2Bb5FobcykYg@mail.gmail.com>
 <CAJ-ks9kwGi+hhsNUC=Ti3CL8iJ4mEN2vSkoFUnz67Usu+-_P6Q@mail.gmail.com> <CANiq72=8kyfRomVijZO-5tW-Ckuf5KshCTYnHt96CSi6PbDkqA@mail.gmail.com>
In-Reply-To: <CANiq72=8kyfRomVijZO-5tW-Ckuf5KshCTYnHt96CSi6PbDkqA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 3 Dec 2024 11:01:13 -0500
Message-ID: <CAJ-ks9kxkd5bgbDuSwEru7RAmxp5D4HXrJNe-m=2EFm+_Ep9Ag@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] rust: xarray: Add an abstraction for XArray
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 10:22=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Dec 3, 2024 at 4:00=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
> >
> > I prefer to be explicit, unless there's guidance on this somewhere?
>
> I like explicitness in general, but do you think there is an advantage
> for things in the prelude?
>
> I am asking because I am considering adding more things there, e.g. I
> have a series to be sent to add the `ffi::c_*` types -- having things
> like those in the prelude reduces the noise in imports that everyone
> knows about (and that nobody should be tempted to alias anyway), makes
> things more consistent (because then every use is unqualified vs. the
> mix we have now) and generally the code looks easier to read to focus
> on the other things that may be less common.

I agree with these goals, but I personally disprefer the prelude
approach. Probably the most common misuse involves traits in the
prelude, where importing them can change function call resolution.
It's very likely that this isn't a problem with the prelude currently,
but it also doesn't seem to be used consistently everywhere. I don't
feel very strongly, so if there's a mandate to use it then I'll do so.

