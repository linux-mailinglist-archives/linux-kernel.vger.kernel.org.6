Return-Path: <linux-kernel+bounces-531013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 762C0A43B19
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4335424CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC57266B6A;
	Tue, 25 Feb 2025 10:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YB7PyxLl"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7757768FD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478234; cv=none; b=CWS2rjV8jzWdNsPFuTxFHmf0bxXCs9C9082lMVw7x9fLmjIdU6lw6LFtvLoUZs+PAlKfklbfM7Seb3HWYamSEw0kknf517CdamRjOQjJhfkvISo2KwL9kqgYc6sR9xxAxgAf7tkOwof/BJlAUGzqM1b5ApndmKgHxmmas80HIHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478234; c=relaxed/simple;
	bh=HEsaUBqbvlmmIMeWKimYYIriYFk+t+jpsGuibbCtBMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=blSXxrUza2xCta9VUnn+aHjrp42f3WwAis6xxxnXRLd9DbQ5g+6aCb67PhhuTHRnc9f95eqVmP3G8uGBQ4zRW9Rvr+HDGMlu7/a51hTiWYjkrUTFND+otwoMfYY798Y5thkEQtf0KZ7vskfm3o+qItQ8jCEDWhsYNv07oB49Zjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YB7PyxLl; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f5fc33602so3050487f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 02:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740478231; x=1741083031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNwJF7WbQ7qHyWG41GyMTL4WrQ1xaWCn+JBYGaDY5JI=;
        b=YB7PyxLlozGRuNxh5oxEwYbvI6QEOP2nI4VKQl8Ppd0J/4MExMa+hhBpe/7wO1piP2
         Hjef3ZbKNwz/cpgLzC+4mpzZF2D3wh6/pj08D3gXODyFmP4ZfXnVf6xvh0eEOXUoq6dq
         3qy0jzO7cxA4d60g/pyb8NO8KQhvuQSya8EXeZA2KkVqNES3XlGw7bGTzsMZqFGVI4qQ
         CaivB66K0KNKSOiqFOlwc4g0xGSeJbiLi93KybSk3yUTzK9NMY4YHPdkiHfgGGEUhO1P
         wPNTBml+WPRc8hSjuZ4dHrpOCIJj1P+6CyZjVC08jW45uiyL4yzO1rLLeOEH9zCTWCS3
         vI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740478231; x=1741083031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNwJF7WbQ7qHyWG41GyMTL4WrQ1xaWCn+JBYGaDY5JI=;
        b=B/Y5gA4CvFU7ZCeM6O88+l7qTfsZavwSHRu1ejMwUaRWKUMs+6GSnEuIgtfOnWtISp
         3H+defDhFVItXf0QHLTp4bLwVcIIYyO66JLB8oTXAKmtSNyxMuK97BS/1B9MjxEE7ISu
         65k/IeP1NdkkK2/uIODVxbPZL8I3w1KQlhh439i0YOoqvXoQu3Qj27m1FEclFMSh5D09
         3xzfOYH1wQqcEsM7+l7VIvOkRe+jNElCGGZvdaZgj3eKW5ltBs7A29NkXUyVI6E9/S5m
         WJ5cN3VcuWLxMt2I1jc84qkp4K8ogONtoIa9amhOydFw8cJy5giMdTJEAGoVItuTcLXh
         KYew==
X-Forwarded-Encrypted: i=1; AJvYcCUDQUXsvy4rPyKQTTqavwPaCBr3bkO8/+VI6A+BrUVXJekiGIPQmkGJIjAG7OWMSR+COki2GGPxslZiywM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1RZowApgHsD1SarB8xICGo8X1J0c64fTTJ2NbL2RidmU2Ubzk
	ig9fDNXlMTxuxN60QhTtCyrBAZwuOFj6eZ9TD2PBk+VaG9yt9SoX3Z7CDIyKXSXWrdBGUXFkY8L
	gGsh5DsY1Jh/3a7Ex5YNmw89XvTihR7ks7Jn/
X-Gm-Gg: ASbGncvrGfoqCqVIdbnMxbafaDWHymm4Nfc3KsLa2LmjwivyL9eEGLoDrSWHB19l9yK
	v6tv0GDyMO/aZJ9oqcjqt6pokJmUtpLVUkEhxJHueAfr0q2o+8xv/TxDpnMb7f7fedvbtvBwmGo
	vyVV56dqB3kG1bLcaPep6L46iN2gWOYP35row8AA==
X-Google-Smtp-Source: AGHT+IGfaWyqkCsllYHWsajFAN0pn2xeUEdUV0MH6OkubIeJVTJI7wG01uTF59yTNz1OwLNz8deLmppVNDVmY7bgr/c=
X-Received: by 2002:a5d:6c6f:0:b0:38d:df15:2770 with SMTP id
 ffacd0b85a97d-38f613fa36emr17275090f8f.0.1740478230765; Tue, 25 Feb 2025
 02:10:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117-miscdevice-fops-change-v1-1-ec04b701c076@google.com> <2025021926-transport-fridge-bc43@gregkh>
In-Reply-To: <2025021926-transport-fridge-bc43@gregkh>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 25 Feb 2025 11:10:17 +0100
X-Gm-Features: AQ5f1JpRZUEexW9GquiI18Q-SWyBfLM83cXvJiOZFncKVQCL9J-DvkDBnBORXeU
Message-ID: <CAH5fLggCjB0ePQvPFeTuy9m0UC_KkHa6-qU8AhQ+P8oHbAhZLA@mail.gmail.com>
Subject: Re: [PATCH] rust: miscdevice: change how f_ops vtable is constructed
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 4:58=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jan 17, 2025 at 02:22:32PM +0000, Alice Ryhl wrote:
> > I was helping someone with writing a new Rust abstraction, and we were
> > using the miscdevice abstraction as an example. While doing this, it
> > became clear to me that the way I implemented the f_ops vtable is
> > confusing to new Rust users, and that the approach used by the block
> > abstractions is less confusing.
> >
> > Thus, update the miscdevice abstractions to use the same approach as
> > rust/kernel/block/mq/operations.rs.
> >
> > Sorry about the large diff. This changes the indentation of a large
> > amount of code.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/kernel/miscdevice.rs | 295 ++++++++++++++++++++++----------------=
--------
> >  1 file changed, 141 insertions(+), 154 deletions(-)
>
> This doesn't apply against a clean 6.14-rc2 tree, what is is made
> against?

I will rebase.

Are there any other miscdevice commits that have landed this cycle
that it might conflict with? If so, I can base it on your branch to
avoid such conflicts.

Alice

