Return-Path: <linux-kernel+bounces-554937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D22DA5A39D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09BCD171AAC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BF2235371;
	Mon, 10 Mar 2025 19:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGJeldLl"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4AE18FDAB;
	Mon, 10 Mar 2025 19:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741633654; cv=none; b=V5P5rE2vmYMNVnIY+UMtqK5bAbuiTVLK4r5HBTg3mrGeAmwblxQ2N5rXFw2NCG2Vm0SGo+p7dBr/OfoXPJgreD16JMrDxTWH1YVCcvbGsBRROqwealNUkKWf8bcLLU12JHrQcNKohKUeFuLu4Og6P5Cs4Qgr7+CH7mpUXV7uzIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741633654; c=relaxed/simple;
	bh=4O7RI2phjDRsn8FWXVrl4wv75NJRPYmPPhIXHAxFi60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBmuXTld8DIbP+O7jSTZ/hLJekiePoopbXcIzlRyUh6o8/Qb3VG7VqUlZmr6bN/wkgPnZ/HdNvlX30bhzKHNOR53vPV5JyrF4xs20TFk+qXRX6WdgMbXVCbqkmCP+kXT53KDZoGqEuu2UlY+FF12UtfAYbxKQguHg4sM0oEemLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGJeldLl; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff7255b8c6so1163902a91.0;
        Mon, 10 Mar 2025 12:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741633652; x=1742238452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4O7RI2phjDRsn8FWXVrl4wv75NJRPYmPPhIXHAxFi60=;
        b=nGJeldLlB9oelG7K1m8TQvzpta8la6QLaeb2Ex9c87XyNdStOUPHt7wpgCguc5qwOD
         aQYUSgg+eeK/LGaElM9XSLpu0BbhJruWqM3KG1KEaDvj/+RUk7gyGMoSRmMA3BF9uyQm
         9tsaddduJEd1j4X8M7QiVHrHKEghk4cwuFcmrH742WKMoTzoe7u7Qnd19XHDYuLZbiiv
         r/w9w3dsS9PYysFcFv9s+cC83fRFDwMCGhCLzo5Ugzy6aWE5X5FHh0L9P/TIqV1Kc7cX
         CCowF6+nj9V7XmLm22P86AaBEU87SL5s8esRLgBaYeFgkqDE2xsfY12RP1Sty3Q018eW
         UCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741633652; x=1742238452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4O7RI2phjDRsn8FWXVrl4wv75NJRPYmPPhIXHAxFi60=;
        b=Q+ijAuFnqPPkZAHTcdmaf4Lgtbegsetzamw7jjlYK0quCp3MRURecmToXAO83th9gK
         chCMN7ZB9oyroZ3q7MyXcMv8FT0V9uXmluw/xTNyxyz2AKEeJrlBVxLc+kpT2/5i+PsA
         vWt4vPjFOZ1ZGqveiMO7z/K66xta7FqtGoxjdNnttRjT+6MX5K7hQvAsx8ZPZkQita+d
         xUY+dW7BsKhB0DiXBkrWOcgmt14PyZIIt9g9Lvr5GWGM385LwkG4eL1hwv+7afYOmSoX
         zDP+zpR8qzhc3rUh/xcT0ZxSxD7IuECQicZi2Dk0obbleVeDRFyFLwwHohnmTwEH/Rp7
         nzNA==
X-Forwarded-Encrypted: i=1; AJvYcCUrBjTHaXvUBBbU7kbzXSU5Bj2DQ3WHIaIFpLcKZQ7OHeohCte39soJ/hDp6krNvqeqwzovh3q3i9gMd1Lm75Q=@vger.kernel.org, AJvYcCV5NCKOh1iOKmKGY/jzLvmS4SGsUDTqODW8Thf6RTLxETRht7DFWpOuZnBTA0wCB1FQui+SwWtzK3HLcuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSmKvci/3gPSgzyllSuap6M15a5cT0hiJMIYGiNNdNKOq5pysi
	pKL1yOudN/8DaqtJ9hGniMorrbwYZEPsvH7KvZudW3sGvjfEmdduc6tHPEL+13zGbHl3kyzlnfK
	wCfu94KaWQh+dOJMoZ0C4b8YPd0I=
X-Gm-Gg: ASbGncubE4RUrM1s9W2rqGnXU9uDBHi8F768p5IUOJxPSBUOVPlOd+fGG6OtoUUxapd
	vJjL3pqmuC5k5DKNMqNxCFPdP6t98CFzCT118Qj7OCvgGg/r3i7fei6tWfLA+idZ9wW93KtW/81
	UtXyuK80iWZ4VMFcnQ3i5xWcNDarjPk6VXxMxo
X-Google-Smtp-Source: AGHT+IHJrfv17sQOJJ9P0TqX5ao935JljgSaZ5TbRPET1gTsB6O+mnlwve4jFuQ/AwMkoNmgdytrU2jwZSfg1lEjpEY=
X-Received: by 2002:a17:90b:1a8f:b0:2ff:4b7a:f0a4 with SMTP id
 98e67ed59e1d1-300ff8b9c82mr409862a91.3.1741633652620; Mon, 10 Mar 2025
 12:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309-faux-inline-v1-1-c1b692862433@ethancedwards.com> <2025031053-tribute-crudely-0e1d@gregkh>
In-Reply-To: <2025031053-tribute-crudely-0e1d@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 10 Mar 2025 20:07:20 +0100
X-Gm-Features: AQ5f1Jot2K2MlkoOuWS9Zh97DrILv5SKcwgIrJeUYL677SkLRVqfje9kwFEeVp8
Message-ID: <CANiq72mEVFv+KtGLJKnkYdKtbUgbWDsjQNimd7+DGgYXCQdOmg@mail.gmail.com>
Subject: Re: [PATCH] rust/kernel/faux: mark Registration methods inline
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ethan Carter Edwards <ethan@ethancedwards.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 7:24=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> What release/branch did you make this against?

That hash comes from `rust-next`.

Cheers,
Miguel

