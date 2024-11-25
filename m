Return-Path: <linux-kernel+bounces-420770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D88E9D82EE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1571163928
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE66191F83;
	Mon, 25 Nov 2024 09:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/Qw2DBU"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F090518787F;
	Mon, 25 Nov 2024 09:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528598; cv=none; b=k1BhlKY69GKH9MB5r7DAm6mj+QA7H7hhx5UQj91HaecE8lWOSfcSnmZ1NwEsD6viIoDC4GzMFSzga5BoY+8/vZFl5Wu8uEyEBH8w6pEaTsaFf4H0nzEFOLF1LDLLIfEev4XR0SIpj4cpTMRKIjIiF8/OYHJ5ugI8Rqwz8UG/Hw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528598; c=relaxed/simple;
	bh=yYZKNyVxriMi7AV//XVt0PIe+AMXWo5WmgtYsMcdOx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uURI9XgOi3Y/G0yP0dQPJY2KGQqrKNlx9gIkTF0Q/Edk4Q9iaaXCAqU9p1NoqQGyAHQtxAVrZZ9d+TIFiWmqh2HnjmxbDSf0rxa2YCnVuMroEWmbim+mtt9qflno2o4qXUktKHi7UyLjWBvrssLtowMWRPZk8G/wSZg/Ln6Ce/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/Qw2DBU; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e9c1e7268eso655333a91.1;
        Mon, 25 Nov 2024 01:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732528596; x=1733133396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYZKNyVxriMi7AV//XVt0PIe+AMXWo5WmgtYsMcdOx0=;
        b=J/Qw2DBUkZSRM+HcaKQ+Q92st1qqulVexiNRgYCORRAg04ORtUcZkB0ZstP+X2Eh6W
         8mLOG0WVS14gqWS1wxGc3SBmzBay5lhlskUiAzVZAVzKO63cTIc+aRJ/qNJA0G9HSRZ1
         Jhs9lDYv6bo9CQS4thUA2uKurx/eJ4bhuoHJ1Tx3ytki4THkzHWsx5J34BgIA44If2yC
         PKs7oset2eXB8b/vUIAu/IqvlhVUbw4cjg2MdKCcIZXIcTKDbntVRgwvssizWSCtGiyY
         Mp8pTWqE34XsiQ4Je9+Xfey52aYsY+Q3umEPoTRlUMJ5PrnzXVYHO4jhZXW8UCfzaja0
         TiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732528596; x=1733133396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYZKNyVxriMi7AV//XVt0PIe+AMXWo5WmgtYsMcdOx0=;
        b=VywrMb0T1OcxEQnv2lXlzRPCqunD4jLWpD8JomUcDNHmdP+scoQMMp3sWWz9Rx/FT4
         xc/1/xmFXPqzK0ykFHd7QrlDq0alMlH1wO/4+kya9I0fW964tBZDCiEWgZe5BnzAnc/5
         pbFrKqoV6swMmgxx2v8oOhskC71JS91Uhmz1GtV92Mtn4Pojkwtdg2gRBjvoXeuP33jY
         U7coM7ntK1mHdQ+8uPF2wGRkCgE1tpmp50pKy5mcQwuoEHLHwymtKRa8KW0NkhN8Zgue
         dLDOS5iwXQyhBYvn/FjQ8UL1X8OEIljkwMNdIFbkaPtvOMM+QW0alEzDfbCYD8UU8/xc
         WkKw==
X-Forwarded-Encrypted: i=1; AJvYcCUkwV9q0a/JwZZQBSE/mN2QUO2kJL7sP9qPpAIYfcSTLXtXSsJq9/76IPk9r3aiahE/y6Eqi8MQ8NXLbqjeNLY=@vger.kernel.org, AJvYcCW2XIm5/5PLyNAb4joFY1YEaky/yOG9hqTY+ze9+dYqtH6jsaPYXt3Ln/PaCu0RNYAYSNLtqT49v3UyLaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0gFb6XYtdsw3TI1LF9j8bRRvzGdE+yCJXV8GEf+W19oBGuS6A
	4mn4Q1ABtLsid1FshgntRTg4BZgCZqulcUPB89hMinOkUqSq3fT2xZ6z6CnLf1MU4Jzre2XiiJ2
	p1hBkLOVvkGVVVYcWgarzWm857Jw=
X-Gm-Gg: ASbGncu2JpVBt9mUY7EF+e1wuboeWulC5cTCR/IN17ESf+cPi2kecuXypoZPpHlGnap
	DHU23CJllkeDEvxfj8GoyHwjIrC3/gGE=
X-Google-Smtp-Source: AGHT+IGaoGwCojAvQSCX3mdAqYlWAsTQexhHed/lggWkPEGb4m+hlgXa8w0huMdKx9oXQMlgU9jzhU5CZCIRge27C4M=
X-Received: by 2002:a17:90b:3c08:b0:2eb:12ee:cf0b with SMTP id
 98e67ed59e1d1-2eb12eecfb3mr6003337a91.1.1732528596262; Mon, 25 Nov 2024
 01:56:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123180323.255997-1-ojeda@kernel.org> <CAH5fLggg5f0KpaObVtZc7WaxHjUqbhCDsn5CwnA5-3df2HEjnw@mail.gmail.com>
 <CANiq72moPEL5s0T3ELEDvWiE6Lz5oZv2hZnziV5A60EP65bkkQ@mail.gmail.com> <CAH5fLgjEDXHGLf+fAyzZwGtX+sjuCst6P9Eg_eyLjujd2datYw@mail.gmail.com>
In-Reply-To: <CAH5fLgjEDXHGLf+fAyzZwGtX+sjuCst6P9Eg_eyLjujd2datYw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 25 Nov 2024 10:56:24 +0100
Message-ID: <CANiq72migNNeceZ95fJ4fKfOimD9hymdisvpqL0imAnjgVyxHw@mail.gmail.com>
Subject: Re: [PATCH] rust: kbuild: set `bindgen`'s Rust target version
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	Christian Poveda <git@pvdrz.com>, =?UTF-8?Q?Emilio_Cobos_=C3=81lvarez?= <emilio@crisal.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 10:45=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
> Sounds like this might need a backport to 6.12, to prevent issues
> appearing on the LTS in the future?

Yeah (I am not sure how likely it will be that someone hits the issue
in an LTS use case, since it requires using a `bindgen` that does not
exist yet, even in `HEAD`, at the same time as an old enough `rustc`,
but it is definitely possible, and life will keep surprising us).

Thanks!

Cheers,
Miguel

