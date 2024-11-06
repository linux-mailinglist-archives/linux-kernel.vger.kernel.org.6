Return-Path: <linux-kernel+bounces-398488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DADC9BF1DB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3477B1F23C4A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD7E2036F7;
	Wed,  6 Nov 2024 15:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBUMbSYp"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1454F16CD29;
	Wed,  6 Nov 2024 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907504; cv=none; b=n7w/y7YqbWrdMHewkX7R+4wEH9RS3fBmw7zNk0yJsQYNUsc8y2k9PogFbcPRYtbZwwsacvWo5H8b0eaXnNCXSaEYsT5hoDv+SeSOMfTZH3uVu5Yidh66GEZZR/d4q1duuiOC8MO7ERDvuQ2MIy15Qw+Vv49JtqttLGy66QjDd7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907504; c=relaxed/simple;
	bh=yRNjlMpC/EJvA712lwSA3Na5j01FqzhcCGSuSoamOVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jAuraWwSCl6gM2yXCDQhj0tPWNADg6roWvo4J8BnuSWNSl8QOySwLozTVWKNL4hbfZ3Vx3zS/ZanuvsCJZPDH4iu977p4/qrX81GinFN5dFSafIIUhsHccZ4sYtF3weiGE9QrVg38MTnvDDKfwpuZVpOaGFQ4hJDLyFc1cek0lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBUMbSYp; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7c3d415f85eso1015982a12.0;
        Wed, 06 Nov 2024 07:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730907502; x=1731512302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRNjlMpC/EJvA712lwSA3Na5j01FqzhcCGSuSoamOVY=;
        b=TBUMbSYprpQOXAjURek7ZykZaJLi9R1Jp/GuATK1TDcwZdM+EE/noENnGiCZQUWCiV
         2dQz6Hzy2KZW1GYsA0GTnuP1fGMqd0YTc9pJgoNGqoFbQmttXd+I9Qxh1yfVmHJpButg
         dd5TNQvk1qPOCVkTBtgEakiG47iiocpxft6FYL2maFoHEWxxxS/5pMeYooJy5hdCs+D8
         mPq22RYuII3UK6BoHMYuGFpe/JsQsG5NGt8sJ15AtxwTLxD2cu5TLY4xDthyYXezABzg
         uUl/XJ8RQYaULbf0gXfIhzw2TYYX4qm7wocPEpZxlc8o0IVNyM+UkBze+UN3osSKGAgi
         nz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730907502; x=1731512302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRNjlMpC/EJvA712lwSA3Na5j01FqzhcCGSuSoamOVY=;
        b=IvKemZUnaFuarHI7lBszxuyRnHoYErDzHD2B5wp4WKb93CaK3sExMvONPIaA+uCAFZ
         GtC6gToaI/0j4iHIl1iCUOuZUlbeOsAcSZ8vPBcFUPgTviX6fachT2Ahfs4YbY1l6QvO
         9rhzHNiI15iC32lfuvjWZdKGxfz8OHeOReIPvxeo7iglsH5uYk35QxlGpDqTz18RR7Hf
         wQGxEPMldfLEWggn5ilbY16kTvSJPLlPnloea/23BOHIGBovbswgNtGyDnHuAGwzYwst
         iKQokde78LZLDkY8GeZktfpM1cwZGWn4NLWdBVHBiHi6WLK8NhMNrEnhsgS02aI0up6f
         mILA==
X-Forwarded-Encrypted: i=1; AJvYcCVJfbMz8lsjiyF7l2hY4y0u8wjIlnX0V/Tio6BvxkTrSyWNiXfQc1HylTgak4SOuENdaJje6qFknzNqS1pp3Us=@vger.kernel.org, AJvYcCWwzgwCjNpx2DA6v8wFGQgLw8zRfQwvBxbVT68yOQ2o9N+roo0mZ+uqk76MrJpWtmEigXKcxJso6w25R3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YztmNuOoIgmvc3wKHmNkQvZL3iUyDXoF/kR9g53yJbX9iBQd19d
	zLIt7oT69QmQwqw51CmD1qA178SbQTKgQnY89p6bV/QKLS7jZKMy4ScHPLe45xKK1MZ2WKoWI7V
	YMzt0DOfsQQrQO0a8/h74yjifPhI=
X-Google-Smtp-Source: AGHT+IGwBXHh3iuF3/7H5apA/OXtm9bx4fcoqLH7W6pMsO/IADpOCrGxyneutyJRlqCn43Qt5p26KVv4ljlFFlFjsE0=
X-Received: by 2002:a17:90b:360a:b0:2e2:c3c7:bce8 with SMTP id
 98e67ed59e1d1-2e8f11d07f8mr19392393a91.7.1730907502215; Wed, 06 Nov 2024
 07:38:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104-simplify-arc-v1-1-a4ffc290f905@gmail.com>
 <ZylNvC8enwPG4IQ4@Boquns-Mac-mini.local> <CANiq72nQ6b1wO6i6zWW6ZWeQFN4SJVB28b216FDU70KmtCbaxA@mail.gmail.com>
 <CAJ-ks9=xW_WWZXB0CbDvU-3otkYs-TY+PSYeiPyidM58QujC3g@mail.gmail.com>
In-Reply-To: <CAJ-ks9=xW_WWZXB0CbDvU-3otkYs-TY+PSYeiPyidM58QujC3g@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 6 Nov 2024 16:38:09 +0100
Message-ID: <CANiq72=9XiYOMQ9ttDrgqTt=mPZnWJuCL0EgQBjFObfqVmr1UA@mail.gmail.com>
Subject: Re: [PATCH] rust: arc: remove unused PhantomData
To: Tamir Duberstein <tamird@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 9:13=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> Doing a bit of archaeology I found the reasoning for the presence of

What I meant by "in the past" is that, before the Rust RFC that
changed it, the `PhantomData` would have been needed as far as I
understand it, since having the `Drop` wouldn't have been enough.

Cheers,
Miguel

