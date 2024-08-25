Return-Path: <linux-kernel+bounces-300565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D2D95E526
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 22:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1799D1F2240D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 20:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0DF16F273;
	Sun, 25 Aug 2024 20:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPoDngky"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D902E1803A;
	Sun, 25 Aug 2024 20:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724617791; cv=none; b=RBI5Gj5IRRtjrgQ6rF0x8poYrD/PF5mvH1fwEfLAC54VX1yRFYqRwX2fYO2QSKv/3scVx5odJf372+CUDxPR1gy6q9fLe9iPS82y85IAX7H70GkIKn55Cs1ayd9kCSTkI++ACB4tZPsdE3Zc/fae1ZUE9XMm44e8RNjZuu8ZBwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724617791; c=relaxed/simple;
	bh=Tabtq3pbe9qAyEkgCDeJgXpNUAzPs0xWGHdygU8SfDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WTXk5tD0sKxyb8plr5dEt8QZ1+HKBPD6rv4PZJwC0gisURpdeUp1IJYpZhqvvWTHakJzXacfSrtlQMeQmvgamAScsolZE1B50pyadtCGUbad9GlTZ6KelLbGpmp9OOuCX0yGwzsTfR/lmYRqvsN2cymHQf6PbT2l82Bt98If73Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPoDngky; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d3ba4e6ad9so670621a91.2;
        Sun, 25 Aug 2024 13:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724617789; x=1725222589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tabtq3pbe9qAyEkgCDeJgXpNUAzPs0xWGHdygU8SfDU=;
        b=mPoDngkyKq45m1xrUFUHPuHm00xyyK/+5Fx2/6+nVnKtwLYQHRG+JfNp02Urexp4rF
         Fbk09kGcOb53lJMN47QREr3NProECBjlDbwNsyuOTteaL0+KwDGVQEpr65D+AkYfdpkc
         g+yYg6OiCJ6wuiMTQW9YZBN3dyeQ6SsK+Bhipcxa3JD/5qjpDT77jEyhL6w40M2/kBxf
         a7c+wQbyEc4wGPU4zc0j045g7cP/ZleTc2xvZ85ag9JksmXAZ4CgeWwVB1yq6vTjW4XD
         U1QrrA+WBVKtV1VvRpfz3XrbG++uiWMZksAol/cRf6I90JGYUxCl84jCg7/nPBusbLNJ
         b03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724617789; x=1725222589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tabtq3pbe9qAyEkgCDeJgXpNUAzPs0xWGHdygU8SfDU=;
        b=C4TLBHGglpYvQ6ZUzQCBpc6WiWiKdLgqLndTpIA2QDUuxpk0atjhP275oVlRuipz3n
         z8CldWQ7eKYrzKaETVPQQV+ucLAUidxVdBO+wFg3rp4ZXg1bkK3/LahCj77SHaxI6Ttu
         IPCrcgX6CuArSc2A1o8HXt7Q3Jb9RaYpyAlOJ0VAUZDE8e57UdmP1C9HUCVxjj11GAE5
         NGIAlo2o28ELB+NmiKv54qnZ7+16OXxg0KWwtjTQ3bjT8hMDZroYbucLeQakBVu6+ONd
         r4iS5cTLe5X6VSzvxUopeidXLZpUZPe3DnNSFeubxly/O+VKoSNQyOEH+PtIWDyrXrWn
         eNbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQOVcWFGOw8KmFi7AyTkmu9p4pVT2bsMl6Z43GHLeoVJdQWB5Q70HqPjqALO4uFij3Zwqvzp0tf78=@vger.kernel.org, AJvYcCVgMMSOTPOKD8ZdT67rIyvSaRppAbGyZBOCzzUOTPr2djAdDsx2TrPOvlbIYf3M79rDu7n+oYFMFPT7GYwJr2I=@vger.kernel.org, AJvYcCXBhfgToT+0Z2yJRfcHtZkfCTBuP86Z1W7SVbhqUGxJ31kL1qf29L8+ucp2FI5XhDh3DGQ2q2mMfGyI2PML@vger.kernel.org
X-Gm-Message-State: AOJu0YxBxn6PUk+bjGlWkEr0DZRUFXUI+SjxcoemR/mmtWsUBKl/lPKw
	ZxWm9fBt6rxR7aMc4mtmnmMB73ChI4CUmE3p6NmhXqjQQUQlVAJgNjlTKM52qN26hasMFASxmpb
	12SivrTjq7XBl5Dmc0YVtySleWO4=
X-Google-Smtp-Source: AGHT+IGJ0vPpx4EfP3jAuDeWFpMIZNHlyFSDsmJuLjEou2DJG7XpFM0CJHn7XJgN5N7kJO9sAW70557WPT2I2byI400=
X-Received: by 2002:a05:6a21:6da5:b0:1c4:d312:64d8 with SMTP id
 adf61e73a8af0-1cc89d6442emr5691191637.3.1724617789154; Sun, 25 Aug 2024
 13:29:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240818141249.387166-1-ojeda@kernel.org> <CANiq72=amLCxV3QRVqK0gVKnGZe_YeqB79LkydEjZ_hJ6_K4QA@mail.gmail.com>
 <CAAOQCfSi9sMqgBzh+v42XGOh2fopytBSjxfPp6kd5DUcGtq20w@mail.gmail.com>
In-Reply-To: <CAAOQCfSi9sMqgBzh+v42XGOh2fopytBSjxfPp6kd5DUcGtq20w@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 25 Aug 2024 22:29:37 +0200
Message-ID: <CANiq72nCJNGRSJCyYXn4+Xgq83doxB+oFE87P62pFtqpk6CZFw@mail.gmail.com>
Subject: Re: [RFC PATCH] rust: enable rustdoc's `--generate-link-to-definition`
To: Guillaume Gomez <guillaume1.gomez@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 25, 2024 at 10:25=E2=80=AFPM Guillaume Gomez
<guillaume1.gomez@gmail.com> wrote:
>
> Don't hesitate if you encounter any bug to tell me so I can fix them.
>
> Any feedback is also very appreciated!

Thanks Guillaume, that is very appreciated!

We will hopefully not have to tell you about any bugs :)

Cheers,
Miguel

