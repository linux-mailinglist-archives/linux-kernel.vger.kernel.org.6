Return-Path: <linux-kernel+bounces-291962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A57956967
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E798E2831A4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526FD166F0C;
	Mon, 19 Aug 2024 11:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E9ODp0ZX"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6A01607A4
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724067379; cv=none; b=ONlym4GNAmDv/yq3icGRxGBfEB92jFmLh/JFmVSuqJMDGnvej0eW61ZINTgKwK+ThxziWNIe9ZTebD1mTu7Tgnq1cDh/rhK8/QG6eB/zztPjE8rYCjF9CKqG0l1ynyVuQszpVk8Af6e4NmIfHKI7l1s3iVtvWHACZPOsL0USfrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724067379; c=relaxed/simple;
	bh=Is3a7YI9bsfHr5amkPmP79YmIyb6qRScMG1uuzNJtJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VU4CmrtT9BnFS3Ko64AZ6gttSeCF2hhIg1YeweqS2N7ibFO+3cFZxmU+Y1n1xxTcM9MQAcL/1ItxvXzSXCQMVeyyspAArRBbOEtKaK9DEp6zDBLmO7/FWe4vuQfOOMv2gvb2O9oxlMpm4xPHJZ8X9HQoNNS9ilbT+RAVfvGvBck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E9ODp0ZX; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428101fa30aso33505125e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 04:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724067376; x=1724672176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Is3a7YI9bsfHr5amkPmP79YmIyb6qRScMG1uuzNJtJw=;
        b=E9ODp0ZXUDrHJYQ9LGJ4xI7NkHJe1hze/2ZW1KcFTSLQG0G00qGEApZgCXOwTMSp8t
         uRyTVYqaaiEd0qvC0/k4dReRDxs36VvHuyJubUVZ8ncr0qF9IQ2Miu+5w6pT+/jA0OAk
         /nyIxiDI08CkhWODuEiYEaybQkFJCj5gQ8A09EM10aDQjQfpYI+Op8DjQt6zZbtWjSli
         vuI6WyWuTF2FBkAEZQ/HnLaxB6yKqeXdYLcV+NtHdByiq0HGRfGj4+kJRTbYHrXGKxad
         j9lIz6idYxzfP2gSt5QFxIQvulYG++bxKyrA4LLGiGmHDyxJn5PbxEAns7LLU8+Y+tC0
         prBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724067376; x=1724672176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Is3a7YI9bsfHr5amkPmP79YmIyb6qRScMG1uuzNJtJw=;
        b=BaEFsHNT9Jkmgkas8xfvvomXA5XQAtHPsAzWtzL/u1kPKdXZnl7icKJP7Ncx1hVS+F
         nbyISOkSAw2aLnpb2uuMHGJbhUghvqiCbDkN778qA0+gg5h6cPZD9aDWip2iOH8Bz2Rg
         +ITY7zOA8ofruzPGM7uTtOR5nSp4HSJGJFFiBJkO2K4srmhv0znW2tOl01Q9r4HB+DwP
         fomO0eBd0lPvhZXK+Qw51vGITx6IrKtAViKy3mENUNjxOIOz6mxhtIkuPfMg5RS/DHVL
         rvEo5IziB5gc6VQYTqBcfLwft3Ewx01ZZVggMGlSsF5Xj2zJKWHVrm2RJ1n8jX2EmZYP
         bSvA==
X-Forwarded-Encrypted: i=1; AJvYcCUymGgsOWw0lEdfYif79kJl3mFfCNYpTagvERMJauD6+ZdFM/zKhSaskBETCD3sW7Y6Sd161a+M+Z1J0y0l/5Bo/WsHDElMkRQ1y5DO
X-Gm-Message-State: AOJu0Yyz/1AiykeprBCij2DyIH0FWNFsqGQa1zlSoReytnubXT/1j94m
	8gPmKuwIhbw4pcV1Jg+CxP58xlntUJhRNDebvPm3Spe56qov+LBJyMGrsQtorrHhn7BXjeS2QF7
	QOW35bUxiY83KeSFW98ffGdq5sg41CkKx8myU
X-Google-Smtp-Source: AGHT+IGkmSaldHSdjt/0H1b2v2/darnvLztt4cnDcC0mQJu7va7pCX24xcuRUUBktO2gxHmYxiPj1fDAsGJNjx282mY=
X-Received: by 2002:adf:8b12:0:b0:371:8a69:18b5 with SMTP id
 ffacd0b85a97d-37194676fe0mr7232822f8f.44.1724067375992; Mon, 19 Aug 2024
 04:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819112415.99810-1-benno.lossin@proton.me> <20240819112415.99810-2-benno.lossin@proton.me>
In-Reply-To: <20240819112415.99810-2-benno.lossin@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 19 Aug 2024 13:36:03 +0200
Message-ID: <CAH5fLggBN=KPdy6aghEmf_QSqZxSnN=_6MWDWrLPsqEg0SLpXg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] rust: init: add `write_[pin_]init` functions
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 1:25=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> Sometimes it is necessary to split allocation and initialization into
> two steps. One such situation is when reusing existing allocations
> obtained via `Box::drop_contents`. See [1] for an example.
> In order to support this use case add `write_[pin_]init` functions to the
> pin-init API. These functions operate on already allocated smart
> pointers that wrap `MaybeUninit<T>`.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://lore.kernel.org/rust-for-linux/f026532f-8594-4f18-9aa5-57ad=
3f5bc592@proton.me/ [1]

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

