Return-Path: <linux-kernel+bounces-344478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3627C98AA32
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F4A81C22C50
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A843195FD1;
	Mon, 30 Sep 2024 16:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4NDUMe0"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4205B824A3;
	Mon, 30 Sep 2024 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714740; cv=none; b=fzpD0UKxkUkqAAl52fY1tX/jaGfYo6lsLVKsomiFCFf2vGvvAorNwm6Ma9BlmSOhxmt4E0fZyuhAv7OGHYa2JORSR/NK7rbmw0Zzi1TzV9XhhtPGxjYjnSvVwjgUpgWIxjnsACSylpcmtlELYU7nqmagN1UUyWfkGozSypAUkbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714740; c=relaxed/simple;
	bh=u1oMF3Vw6h9ZGmyJzapx+6eXhNhylQp8wZjT4qafY5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwNB9fyJMQ+PAOB5kLRboOGA3IR4BuH5gwjYulGONIFV5dXGXFhcjB8rKkjrmzmxJ9ZH7tAfh7MKUXDbTDzsTpb/2KVfzCazVMAhwDQi/wbpZnj39frA9k7ED8D/Jh8t/+u2iEfKkAVfjgXBZdlBgfmFaA8a6pq/yhKL7N87qas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4NDUMe0; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a9ab721058so484896285a.1;
        Mon, 30 Sep 2024 09:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727714738; x=1728319538; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u1oMF3Vw6h9ZGmyJzapx+6eXhNhylQp8wZjT4qafY5Y=;
        b=G4NDUMe0j39jG0VC138DLWnu76J9mTwKjvwJgkc8F9VtatxIJXJ+OKFPLeG4prZFwd
         oqu8BLEwF6h3QAhsHYK8lsirTOXGZqYj5ff1LbfcMDoMV/ro5rCzbXqQf5adMbEm6lQw
         YXegxWUdsZCGpZ8gW06rbDYJqTVDEcLbUFpsmNKZwqxa3oi3OfCL5IlT6p3Aggwo7I9G
         QeczrNVZA+zitiCV0Cv6N3X9TYBl497Hn4P6Hwju63+RPOAueGZJhX9DrVyfd0Nq2BDh
         a2XpGvVXL6NsJSPliliQjcNxdkZ6lRQYiEo6mfHvbmucgdWUl4RKUL9WcqWEKegsY7oL
         L35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727714738; x=1728319538;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u1oMF3Vw6h9ZGmyJzapx+6eXhNhylQp8wZjT4qafY5Y=;
        b=piLqxgB6I2KNsJmkTuyNXNo+JEBsx1OAhYUd4YJBn0WR/WoouylWcnEL/5pQjjNHMe
         3qW1o5uPa5rRX09oorxlzlX+WZEs6cAxgZY8XPbOCnB9/merAC2tRS/xRRNO1girTkMM
         67VrzRrZnDqqVWh18nESDh66JB/HtoXVuMbgicAGaZRiFz+c9mceAaHgei/KhFQRfcrG
         zXI4sWRe+Ud5oTfyrlsqY69NJ01MF9r0r2oMzsYKpcpM8OnWy8eDeIlOR7iF1SGngz5m
         t3zyCiui8bQVV9Terq8Y4HkfABwjGg2JMYzLSJkpw9xCGn//K+A+orggQQkBLbd5lcun
         ZS7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjHYBaPc23/pkiB0piGvauPvgo3IAQttNMfNqbXVN3TBENje/UrdXvQQw/fY3mCSv66Vxa7sRYIQQ3qBl8g6o=@vger.kernel.org, AJvYcCXMV011jOxR1HiSjnxcxZbs+y/jW8jMkm5K4z32cF0WGmLs55UWtRbjf9BIB48FYDeHwctYJNWHbLYrPNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqYDrwyvJ6ukj3XpC3J8gYO2y/dZj3rbx2S97tE+w2duBV/b3R
	BBkU25cyuTOsEcHaDL47swDCtCHk/tn3Cf3YkMIA0udHJUKtVEV6acx9aoWdkH2va+QFVEIQ9Nh
	4BeYxR1EMQ/Z/bn9nPauwRbvGyTw=
X-Google-Smtp-Source: AGHT+IGG1E0coYyjQS8ct4GPgSOxgQwszDKSJcQS80gN110hyaWCLMGkvm5bIhI1U95Fpa30oEDFqB0vKJJsIY4PWsc=
X-Received: by 2002:a05:620a:199d:b0:7ac:e157:e281 with SMTP id
 af79cd13be357-7ae5b85e0fdmr31942285a.32.1727714738073; Mon, 30 Sep 2024
 09:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930144328.51098-1-trintaeoitogc@gmail.com>
 <20240930144328.51098-2-trintaeoitogc@gmail.com> <2024093044-violator-voice-8d97@gregkh>
 <CAM_RzfbJ5qsHKfNxV1EzhYEDdCmXP0THH=g1MX1yHiRP=9tYFA@mail.gmail.com> <CAH5fLgjMGwBNYkOEbiSLzQ5+G0gTz+gbvsRSoRsRizAETLpLeQ@mail.gmail.com>
In-Reply-To: <CAH5fLgjMGwBNYkOEbiSLzQ5+G0gTz+gbvsRSoRsRizAETLpLeQ@mail.gmail.com>
From: =?UTF-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
Date: Mon, 30 Sep 2024 13:45:02 -0300
Message-ID: <CAM_RzfbaAQT5cPhx7aB+uqgKcsHq-fnv_Jt63_p9CJ96rs6J9g@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] rust: device: rename "Device::from_raw()"
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, mcgrof@kernel.org, 
	russ.weight@linux.dev, dakr@redhat.com, a.hindborg@kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Alice Ryhl <aliceryhl@google.com> wrote:
>
> You can use one of my patches as an example. E.g.:
> https://lore.kernel.org/all/20240930-static-mutex-v4-1-c59555413127@google.com/
>
> Here, the commit message itself has:
> 1. Motivation for why we should add global lock support. (To replace a
> hack I had to use in the Binder driver.)
> 2. Explanation for why I implemented it in a certain way. (Why
> separate initialization step?)
>
> Then, below the --- line and not part of the commit message, I have:
> 1. Information about which patches it depends on.
> 2. A changelog and links to previous versions.
>
> Anything below the --- line will not be part of the commit history
> when your change is merged. So you should think about what people
> would want to see when they look at your patch in the commit history.
> They care about why the change was made, and why it was implemented
> that way. What other things need to be merged first are not relevant
> to people who see the final version after it has been merged.
>
> Similarly, the changelog is important for reviewers so they can
> compare with the previous version, but for people who just see the
> final version, they don't care about which bugs you had in previous
> versions of the patch. Of course, if you change the implementation
> approach, then they might care about why you chose that approach over
> some other approach, but that explanation should be in the commit
> message (and the changelog should just say you changed the approach).
>
> Alice

This really make sense. I will resend a v4 version of this patch,
without 0/1.

Tanks for this Mrs. Ryhl.

