Return-Path: <linux-kernel+bounces-269782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B529436D3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77805282C27
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81161684A6;
	Wed, 31 Jul 2024 20:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ar86/2s+"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B351662F6;
	Wed, 31 Jul 2024 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722456133; cv=none; b=jcPyFv41ONntUz41qX4L910stSfvq+GYh3MmGvxcakVzU6MWuPSTp2LKFhCTy6/UD+qqOT426KZ/YAcsbza0A1O6jUich57+iC3TGld3dI72T+kMVxfpFPO8AJeZZATZbPftebwU1szEh9Tr3STYrb/PWwd3KugrhG3UfjMzn1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722456133; c=relaxed/simple;
	bh=7SlmGwMnKz91Lmf0m/2cYvqVqZAlXxEkY65N5fUbO+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzTXSojZKEhB9X+XrtH0tKH2pHmmV13MzyrGMThz2GCwrLE8nrpMe5c9UnYF3DOnx0kXkdOUXiTpsJSSYa/w9YrN9aUoXcTucNmSecTfiUo8Y3EcDdIftVmD/sfaGIqY5rxogj/3K/82mfnQZjKd+CQYrFf4fwvzYRiYLd5UCs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ar86/2s+; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70d333d57cdso4419018b3a.3;
        Wed, 31 Jul 2024 13:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722456131; x=1723060931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SlmGwMnKz91Lmf0m/2cYvqVqZAlXxEkY65N5fUbO+g=;
        b=Ar86/2s+4Z/jLbqsjRg+bG1cy/rvFU3P7VvyvH+xOctzfr1gglwLZn8o8TIQXjJcUc
         9S3A8BCqVdr/ubSIGC5KGQuYCCz55Eq73yW/NnqA1avIJaYavSP7apAuE28GO4NOAEXO
         V2t1ZkAzHo0obB4VzDkQzxwJzCw4Scum0s7iOiomi2FltXtxI9nPNwjJ8rUA4rwafipO
         gnsRWSvVFCKvCNG+F2IbqZrf8S6jXAXLqaA9eboWRVyPdX+QB10gat9heycxXN5wMg3b
         9AYKAUJ+N8ZRY7mEnuY/j/CLzuQcuz6RYB5XmnJVnz+NWL0BzF1LtotLod+4BiNRuBt/
         EAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722456131; x=1723060931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SlmGwMnKz91Lmf0m/2cYvqVqZAlXxEkY65N5fUbO+g=;
        b=FStPKaNj0yQKv+j5oe8Q3G/dgTmJjwRomtTewffzmTl2fyaf7DGhCYLv9rFnXfQS13
         YkCXMf5OzwnHcBq/CaAkIliPcqeHdfrgPidmB7h4eImRbWxooqC2UuRNQkUzUTxOCfsU
         FfXXrTnB5P9p2e4rRCVCt8BfJy2q+f0xKDNXHOR2IVmgLa8/u0N9OrKDrY7R6xFD89mJ
         BBeWrQxgTohauVB7OuI16DR6h6GagIFmJAuHNze3gw4O50mImcJqNQ5cdiUT+DXj6v1F
         JGaMOXKQUpMQ4423XxIJwtW2ujpFa6luInhkMTu1qOaKRMiP/H1GJLDeWe7iPGEKRXjf
         ZYXA==
X-Forwarded-Encrypted: i=1; AJvYcCUBd8lgPCPEOcqGefqTqAbrI4G8ddqfB9KLq60kh8O41xqKfBaOJrgOIFd7P8dZvTX+iXqLmidtODTmLGZicqg=@vger.kernel.org, AJvYcCXC4bE+YQ4A89bji6bO3DoE+BqVkWUy5HJVYvQPzW08S5RUXaML8Y8k++6PRVv6bQJ4HZClBofF1PtSB9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YziTNXj8fucrrUiCXpQMQ9uiabK5yphAQ9r8fOhRu3jLDERgOeh
	TxJ9xWtWkS8oGdFXb1mSiQO/7JNJa2bi6br1qFgpkRM/YEthlsYjPuCKdxfb9vG4TwYo/hWceXR
	fiXFo4uEU1TxECSMuMD3h7hwF1sc=
X-Google-Smtp-Source: AGHT+IFy4ToMxRPBs0uzRGSG1x8a3/QTj4Yr0PUJewta67MtrrJ1CFqUH3+m1MKViNdUq9kwTts5pK/LhJmwxHXrtRs=
X-Received: by 2002:a05:6a20:4303:b0:1c4:c305:121d with SMTP id
 adf61e73a8af0-1c68d2607cdmr632415637.39.1722456118755; Wed, 31 Jul 2024
 13:01:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731034112.6060-1-zehuixu@whu.edu.cn> <CANiq72n48BvaSNvghkEMn796u4K3_1owZqD9Gjmyk7h3R9GT+A@mail.gmail.com>
 <CAGSQo01oq+nmPFCB3bRnjcXn9fvtu8tcvjsUh55tZnyJSz6ZDg@mail.gmail.com>
In-Reply-To: <CAGSQo01oq+nmPFCB3bRnjcXn9fvtu8tcvjsUh55tZnyJSz6ZDg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 31 Jul 2024 22:01:46 +0200
Message-ID: <CANiq72k3Nb5qiFhmq9MsuwWnvxjf9mygnXrdtBO1LJsH40L6Dg@mail.gmail.com>
Subject: Re: [PATCH v2] rust: Kbuild: Skip -fmin-function-alignment in bindgen flags
To: Matthew Maurer <mmaurer@google.com>
Cc: Zehui Xu <zehuixu@whu.edu.cn>, ojeda@kernel.org, alex.gaynor@gmail.com, 
	wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	aliceryhl@google.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 9:57=E2=80=AFPM Matthew Maurer <mmaurer@google.com>=
 wrote:
>
> This should not change the calling ABI in a way bindgen would care about;
> Those flags only control how functions are defined, not how they're used.

Thanks Matthew for confirming. Let's go with Zehui's v3 then.

Cheers,
Miguel

