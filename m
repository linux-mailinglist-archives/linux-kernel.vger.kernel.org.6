Return-Path: <linux-kernel+bounces-568028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5752A68D26
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0196319C79B4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDEC25291E;
	Wed, 19 Mar 2025 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpVFekvM"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834A226AF5;
	Wed, 19 Mar 2025 12:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742388401; cv=none; b=XR/fa2N+6VXq4UPARP05bcVJzObvWMqezCB5t9QCV3LwpxCxlBUeTlR4iDFFcs+A+OUhDzrG9K3J8PRMEofUjM7an7G4oRDFmuhyVUqZEqlbE4miY7c6oFRzLN3LGL7B38aViAYdtcHOjbQa/z+UcA/Nj/tBOTwME/GqRCoC/jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742388401; c=relaxed/simple;
	bh=ob5xQ/2mzoSmS2dMwlIKa4Vvl4pCd9Yb2s2myqiQ9VE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oeDHeK+RciWxZUQndhzKT+1Da37Xoze9vwCmmKIjD2zIeGH5EeUum4/EDUbM4EQ4Rd474krRl3LDBYbvg77d+McwO5/lFBGVnDFkXM+AvHCFWorbGk0L8J3CBy1eqCtVNFtplZs9YgIsrPYb2h6DwXR18JacWSRH22T/CzMpm60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpVFekvM; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2264aefc3b5so1303215ad.0;
        Wed, 19 Mar 2025 05:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742388400; x=1742993200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ob5xQ/2mzoSmS2dMwlIKa4Vvl4pCd9Yb2s2myqiQ9VE=;
        b=hpVFekvMgnKUDBZNBkNSTqCbBwxh88iz8/mXUJdsiSW6byTzTuCzhOI2jkbqE7u2V1
         WDP6mEIgGtRRH+zd5nNmGYmXxOk/dAmLGBZpGvmo++h0xg/SaPbsvKbl9O+jUfjW/1tJ
         aev9Yv00etgg+1DUBX55Zxj4Z1OuXP+TFpUvprABwxt3h5M2UsagHBE3L4BJd/1iBpLi
         L5gBWIlHNyXit6WvOT/iF3z50l4xUla3nYeAp1zLw+8Ydz++D2P50QV/lBrC2hlavXlh
         cgxGnmZnWfD/K6oU7+37dnx2arO7gw/2FTgP/4oFFvlAqGzBbNQa624Q5aFuvBW+zJg6
         cYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742388400; x=1742993200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ob5xQ/2mzoSmS2dMwlIKa4Vvl4pCd9Yb2s2myqiQ9VE=;
        b=dv20cQiYrVkDeBTXsArhLo8b/oR03qhKEUEein3ru3+5H9jVQCyXE0eqF75+yAsVxu
         3RRSUUe+XiX7yAHe5Jc6mAxVHrOJ8pb1mKMPTbES6zO3g8UorFqQuL2wsNyEL/WSzuzu
         RzIze2qqyUFdq6sCR9oUU+lIZG3PxNu4eEKD+/kORLjkCg8NN2PlwSGbzIrd/TmiIkBP
         S0jqniyMZNLSXp6Mp5U8aN1d7jL+YG8ApvrLKzHaOZ34KHkXEfC4hBgWRiQiEhrHOiB0
         R1Wg0yE2pXbUzcNoMhETcavCtb9/0iA4cDTEAlIw5CfKMEOCuNleReMNDemh6imTpApv
         6fJg==
X-Forwarded-Encrypted: i=1; AJvYcCWMB/wjcwMheWOL44Fstasx8lxQFLS9W5J8yZpNUfZndR2mcz+Wl4neY82n8/+Q5B9uUhXQJ+UwCu5p4i0=@vger.kernel.org, AJvYcCXxF2H1P9GMv7uzVFOGCsp8fb8uaJNGWfzFOrogEJLqZStao7cCyggSG/4GGHEvrbBgV/RD2nP5SYoyasi1FyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHwJxE8WiVf4qnlNZC1xEQHpA0C0RFlEU+E5Dk8L6QWJO2i0rn
	t56lcP1L+oeX8ADQqW1RrRztuKWYKT0ePk8+0rtlog48kZNFKdGdJ8QHw+cAX5w4MzX5qeIWNJL
	7r7TyCchwE/WnzzCDhYEXJS2II0o=
X-Gm-Gg: ASbGncssRv3kTrzuRdlAxJf3iox0T+mVhCP76UMnq8eP2WliNQaxgYbigNe0yYn+r6n
	q48RJ8gRqfnMx0cbGyt9khNpJVFY62v5VUriVeYw2wJ5f5kzlSPOYXqCYaG66alTqJenrS1pP6V
	qxeWiNLv2qzg0d0/jofBX5u75MCiioPuSTTWi8
X-Google-Smtp-Source: AGHT+IGaaXD0zeogaEMCgQCUyCkh3ovfsr4pcwMK39nqJF+5e07VWh9fJWqKO/omEHiT8jLDc1N9vDNAn8l490pzR2g=
X-Received: by 2002:a17:902:da81:b0:223:5c33:56ae with SMTP id
 d9443c01a7336-2264c68199emr12401655ad.11.1742388399681; Wed, 19 Mar 2025
 05:46:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319112822.1961241-2-bqe@google.com>
In-Reply-To: <20250319112822.1961241-2-bqe@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 19 Mar 2025 13:46:27 +0100
X-Gm-Features: AQ5f1Jrx4EoGipL1PtbaGi7ZgGvraas0t7rCeLXKB8po8Q0O1dBWOHIEwZXb3Ks
Message-ID: <CANiq72=fBJLhgW64vohSopsR0RQLch+_cKqRKDQT7yR9B6A-mw@mail.gmail.com>
Subject: Re: [PATCH] rust: adds bindings for bitmap.c and bitops.c
To: Burak Emir <bqe@google.com>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 12:31=E2=80=AFPM Burak Emir <bqe@google.com> wrote:
>
> Part of a series that introduces Rust Bitmap API that has received
> a few rounds of review. Thanks for the helpful review comments.
>
> Rebased on next-20250318 and split as requested in
> https://lore.kernel.org/all/Z9nAVIokrWqoRiFR@thinkpad/

I am not sure Yury meant to make it an independent patch, but rather a
different patch in the series.

Doing it this way means we add helpers that are unused, which I don't
think he would like, and we also normally don't do that either.

Cheers,
Miguel

