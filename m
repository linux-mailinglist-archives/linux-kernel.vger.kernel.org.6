Return-Path: <linux-kernel+bounces-388306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D86BC9B5D78
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D20D1F240C2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F171946A0;
	Wed, 30 Oct 2024 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q0iC8vGB"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5085A23
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730276118; cv=none; b=k/nXiUEdXgBVd2VXPs6mSmPb4X7RBa696ykcZWBAYraPgL9ckjkzcvFa8v4QbsrgN4cmrgr6imd9nhHtVIs/32PVAUlRTHzz55EQIqYTSGjLswDV3nm2vfkah5xlJFXu+5UpjikDBx6Cs7fur9TGaI2zbMr1RN9YDC0Yjr05Jek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730276118; c=relaxed/simple;
	bh=EtP8O/x0Pp4fo5tjaL8Nz432CQ6nOV4hnuoz2QwMiBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jFGDitz+GKotk/U+l7115ALgBSwvNarK6IjTSP4kWBaaoxqX4SrU/UMOgjPFf5VbI0mT+WsGb1BSel5Oy1uyhL0VHSLv22v2D6z19eRDU56FzzZz1lJ2Kk877S1fk1A4PFauWNKliZgnbAriF4YM8q6ieFiMUZP2DpHiFw6EHX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q0iC8vGB; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d6a2aa748so4064412f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 01:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730276115; x=1730880915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtP8O/x0Pp4fo5tjaL8Nz432CQ6nOV4hnuoz2QwMiBI=;
        b=Q0iC8vGBvX2hZMGXhklquzKfbX1H6TCcDMB07yMc5XQK3Uya0NrI18yRACKCQkxlID
         zdYPJ02CVby+tkSkszCHsBNTjI2VXu2AllcfWYGSHciZo3prQLmNXkVKaQOCWzW6uwmD
         Yh4knvfLiKJr06MrwCFQ3e2vSHLN3nqIxbthX86IMAa/yq/+2DazKiHlK2tHHbVG2hdP
         izJdDWrSYVlxybwCmSNmF+xNW3dBYR69LqBotUntbV3lXQlRhasuHNK+NgTdWFJQfnqp
         DKMA+s+1u+PUR7+goaWsVsEjSNbO2ulqQUiSYZunGf1JEF36SmQNG6nqGiP49G10RwTY
         8cRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730276115; x=1730880915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EtP8O/x0Pp4fo5tjaL8Nz432CQ6nOV4hnuoz2QwMiBI=;
        b=ranknyszuEvA6kNj9a8nGxWkgweX0fCtrdjD8R9GxfVkMSaQ3Ndd3NZYYbp/lVAzf6
         P5yKVHK8tYRk0LiQ01Z0sU9f5zJExvIjweuAC2oMb2X0GViWgftMW8/YFbST7OR4aTWT
         6371VesYS6zgk5+0Oz3PdysIW4obZRHz/Kpk/qjxtKNtFmnBqp9tnZvadTEmlxNocdSq
         a+BHhqxFYFKictZzAA1ocuF6hxubkD4MURZy7IPKMTpxrugo5HsmeXPpXAbQfr3YYABI
         LYNfYKa/XB+oMnngmPdp2o49619pSRQnEB90FrMRUA1a+CVi+Fg3iyFUKKf/00THZorH
         xBUA==
X-Forwarded-Encrypted: i=1; AJvYcCWFoTYlhaO7F0Kg5uWv2sTJBlhgyiW0Zro0iROL+7s2vMcyCVj+iDYfrutWcyQRW9A72Uv/g9qC8vyrJuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyH/cA8dVfxkfqaRFSVGirSKyd6SJKFi9RClh52qekV4UYtHOt
	/DJe2EAYTCmlg8NO/f4DQt0+vW8kQtzXYU7X3zr/x+FFH/lstUVvdmQp5lMhmD8hc43k+VhT36m
	xb3ruqLNwhAfXqZVx4tepsETBXkxvweqnhKPu
X-Google-Smtp-Source: AGHT+IGTc1W3EOESo8v224TbROhEfRVa3icYeOI4MIOE5l9k1YR97UWANEJFet9a8FfcvZVbNtjMuy+NGt95fD/dCpE=
X-Received: by 2002:a5d:6dc5:0:b0:37d:415c:f27c with SMTP id
 ffacd0b85a97d-380611dc1c7mr9637357f8f.38.1730276115165; Wed, 30 Oct 2024
 01:15:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025-rust-platform-dev-v1-0-0df8dcf7c20b@kernel.org>
 <20241025-rust-platform-dev-v1-2-0df8dcf7c20b@kernel.org> <CAH5fLgjhiLUYPgTt_Ks+L-zhWaQG5-Yjm-Y3tfh2b2+PzT=bLg@mail.gmail.com>
 <CAL_JsqJWPR-Q=vsxSvD7V9_v=+om5mRuW9yYNqfavVRUwH9JFw@mail.gmail.com>
 <CAH5fLgiXPZqKpWSSNdx-Ww-E9h2tOLcF3_8Y4C_JQ0eU8EMwFw@mail.gmail.com>
 <CANiq72kaidDJ=81+kibMNr9jNxg467HjOm9C_4G7WRvaiddGvg@mail.gmail.com> <CAL_Jsq+T6T_3p2C62U3v4aSjm_oc-Ycjxi_ckF0ufh=JJDz=rg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+T6T_3p2C62U3v4aSjm_oc-Ycjxi_ckF0ufh=JJDz=rg@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 30 Oct 2024 09:15:02 +0100
Message-ID: <CAH5fLggCDiKUu_dvJZeJr8UD5RvUpqRJbdYKf1F3_MvCdOVK6g@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] rust: Add bindings for device properties
To: Rob Herring <robh@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Saravana Kannan <saravanak@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Dirk Behme <dirk.behme@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 8:35=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Tue, Oct 29, 2024 at 1:57=E2=80=AFPM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > On Tue, Oct 29, 2024 at 7:48=E2=80=AFPM Alice Ryhl <aliceryhl@google.co=
m> wrote:
> > >
> > > One option is to define a trait for integers:
>
> Yeah, but that doesn't feel like something I should do here. I imagine
> other things might need the same thing. Perhaps the bindings for
> readb/readw/readl for example. And essentially the crate:num already
> has the trait I need. Shouldn't the kernel mirror that? I recall
> seeing some topic of including crates in the kernel?

You can design the trait to look similar to traits in external crates.
We did that for FromBytes/AsBytes.

I assume you're referring to the PrimInt trait [1]? That trait doesn't
really let you get rid of the catch-all case, and it's not even
unreachable due to the u128 type.

[1]: https://docs.rs/num-traits/0.2.19/num_traits/int/trait.PrimInt.html

> > +1, one more thing to consider is whether it makes sense to define a
> > DT-only trait that holds all the types that can be a device property
> > (like `bool` too, not just the `Integer`s).
> >
> > Then we can avoid e.g. `property_read_bool` and simply do it in `proper=
ty_read`.
>
> Is there no way to say must have traitA or traitB?

No. What should it do if you pass it something that implements both traits?

If you want a single function name, you'll need one trait.

Alice

