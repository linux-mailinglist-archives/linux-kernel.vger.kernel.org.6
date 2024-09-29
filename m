Return-Path: <linux-kernel+bounces-342799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814CB989316
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 06:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA4EE1C23332
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 04:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246F542AAE;
	Sun, 29 Sep 2024 04:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="Gx+vr5EN"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115F63FB1B
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 04:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727585853; cv=none; b=h8FEwIWNnvP1tGHage8mzkQeYYIN4QSgmKm1twnh7zcnti9HvGyG/AnWYpnDRv4rKUK6sTtVZZqenHUjRuYb2dxb/aYPLBs0PU03xxJkghfaJJbgnVf0zSmhcw8+/WK5l7XNsz2E+7vH5ebt6cfya7IL+asw6CFe+mM/Qe+Aksc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727585853; c=relaxed/simple;
	bh=8JAXnDgwC0E96DmvB7UMxZsYbUOAqQTVFvH/v4Cfgew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9oL3PyEkA+yRzFxs0sX942S6ZdBbXkEPHq2EruMWEDIwEvrCPBRj+CW/WGRe2qIti9Veyh2KxQ78YtbNCuwqQjSZKAJYx1qdan2EdPQShA8vOEzK/8zERLwYKWT2o8Awmtz0CADn0OEQT40QAv0AP6uyEcLo383GdUyf7mrYfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=Gx+vr5EN; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6dbc9a60480so27598057b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 21:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1727585850; x=1728190650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JAXnDgwC0E96DmvB7UMxZsYbUOAqQTVFvH/v4Cfgew=;
        b=Gx+vr5ENXz2emDavv6lAJy7zE3503VhNh0ai5NNt5qehbsYutnQAs8TG5P5x8z732g
         5Z5SVxz7KTK47tblddBtFwevMEc2gkRTwLnrF0KQVCAG5Nf17PmsAzlQrKEWmZmq59LA
         PV7XRwUK5CeYwrLorE8o7MCLDBUdTUmLCOXJUeR17JjvVg+Pl4ggIzb8PDGmRZCYBIz3
         0HqoGo32EsT/iLCaxHcRyQA28U4hpe1NpFdQgIZyYix3I+D7jEk+aegmbjfplceAr87P
         iQSTeQEqUYYKa0rnhEeIKkyzv5hbDsGvK4Gcg73g543fivFsoj0p1sbGmr2aKq28YsCr
         xxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727585850; x=1728190650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8JAXnDgwC0E96DmvB7UMxZsYbUOAqQTVFvH/v4Cfgew=;
        b=JsdoY9LW2QFQV1TTnpaDp+CWtsDCshTMNm7I2Plyu7lf/RkMtysGnb8GZZT/jp+Acu
         MmljMXiyi7wtsQgkfF0Mjhbms+ma+ygKnOcjdNyJtHui7t7/tteQhzZiO6SitxuxELX9
         ClPk3hqbLSPtX7guOvAb7H8wQmDH/USQN+D6Xq4bElccjJT/rBs+gXVZQM7PAy6TKrU0
         mhf0/9UVijPlF97YQqC717A1UA0pELwWwiBCYUApgyG2Tm7NON/B8lJadRt0/7hqzPi1
         GXFXzTmfPZ8klt+CCUbIQaKaxlDsR5IlMi0/6npZG8pJ35gukjJba3a3VPUWC9PeLUms
         uRZg==
X-Forwarded-Encrypted: i=1; AJvYcCV/0JCxLrbIgaGxgIFpxG5pq+FfThlIHzMTjUZ4RoQFX/DAebgwBLOMLOEDYAynFPo3Ptiqy4tHMfRsqgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQpvJcdK8MIwB1UC02XhEk6lv6NKIt1PEk60FWbkFh9lBT1xoB
	a7fdhJg6Z4mUDgjd67p/iJ6a3DjQ9yeyQrurHZ4hK0xiPohcvrcx55gP3iM6iZBgzwSAVPhAcLV
	vsV/h31TpJBhoA34bCewJo43haVqBwWX6ZSyvsA==
X-Google-Smtp-Source: AGHT+IE++v8Td22nI2Q3soyTzNnP0Aq5WWr6h1etnmJLmPLRDEcrld8EaVYYkChWaSBJSUid1U0hDsRreiPYOsW/qIg=
X-Received: by 2002:a05:690c:6788:b0:6d6:7c9a:bf58 with SMTP id
 00721157ae682-6e2475e6741mr63957807b3.28.1727585850530; Sat, 28 Sep 2024
 21:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-16-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-16-ojeda@kernel.org>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 29 Sep 2024 00:57:19 -0400
Message-ID: <CALNs47uSN723+vO9d+sTry7XRDZf1BS_pyA1iu57Yk4M0rtk0w@mail.gmail.com>
Subject: Re: [PATCH 15/19] rust: enable Clippy's `check-private-items`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 4:45=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> In Rust 1.76.0, Clippy added the `check-private-items` lint configuration
> option. When turned on (the default is off), it makes several lints
> check private items as well.
>
> In our case, it affects two lints we have enabled [1]:
> `missing_safety_doc` and `unnecessary_safety_doc`.
>
> It also seems to affect the new `too_long_first_doc_paragraph` lint [2],
> even though the documentation does not mention it.
>
> Thus allow the few instances remaining we currently hit and enable
> the lint.
>
> Link: https://doc.rust-lang.org/nightly/clippy/lint_configuration.html#ch=
eck-private-items [1]
> Link: https://rust-lang.github.io/rust-clippy/master/index.html#/too_long=
_first_doc_paragraph [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

